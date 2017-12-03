// Written by R3F logistics
// Adpated by EightySix

if (mps_lock_action) then {
	Hint "The current operation isn't finished.";
}else{
	mps_lock_action = true;
	private ["_container", "_stored_items", "_type_stored_object", "_object", "_i"];

	_container = uiNamespace getVariable "mps_logistics_gui_container";
	_stored_items = _container getVariable "mps_logistics_loaded_objects";

	_type_object = lbData [86603, lbCurSel 86603];

	closeDialog 0;

	_object = objNull;
	for [{_i = 0}, {_i < count _stored_items}, {_i = _i + 1}] do {
		if (typeOf (_stored_items select _i) == _type_object) exitWith {
			_object = _stored_items select _i;
		};
	};

	if !(isNull _object) then {
		_stored_items = _stored_items - [_object];
		_container setVariable ["mps_logistics_loaded_objects", _stored_items, true];

		detach _object;

		private ["_dimension_max"];
		_dimension_max = (((boundingBox _object select 1 select 1) max (-(boundingBox _object select 0 select 1))) max ((boundingBox _object select 1 select 0) max (-(boundingBox _object select 0 select 0))));

		HintSilent "Unloading...";

		_object setPos [
			(getPos _container select 0) - ((_dimension_max+4-(boundingBox _container select 0 select 1))*sin (getDir _container - 90+random 180)),
			(getPos _container select 1) - ((_dimension_max+4-(boundingBox _container select 0 select 1))*cos (getDir _container - 90+random 180)),
			0
		];
		_object setVelocity [0, 0, 0];

		Hint "The object has been unloaded from the vehicle.";
	}else{
		Hint "The object has already been unloaded.";
	};
	mps_lock_action = false;
};