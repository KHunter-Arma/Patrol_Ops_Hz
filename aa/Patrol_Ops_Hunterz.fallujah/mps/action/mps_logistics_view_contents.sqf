// Written by R3F logistics
// Adapted by EightySix

disableSerialization;

if (mps_lock_action) then {
	player globalChat "The current operation isn't finished.";
}else{
	mps_lock_action = true;

	private ["_container","_currentload","_maxload","_contenu","_tabs","_tabobjects","_quantity","_i","_j", "_container_contents"];

	_container = _this select 0;

	_contenu = _container getVariable "mps_logistics_loaded_objects";
	if (isNil "_contenu") then {
		_container setVariable ["mps_logistics_loaded_objects", [], false];
		_contenu = _container getVariable "mps_logistics_loaded_objects";
	};

	uiNamespace setVariable ["mps_logistics_gui_container", _container];
	createDialog "mps_logistics_dialog";

	_tabobjects = [];
	_quantity = [];

	_currentload = 0;
	for [{_i = 0}, {_i < count _contenu}, {_i = _i + 1}] do {
		private ["_object"];
		_object = _contenu select _i;

		if !((typeOf _object) in _tabobjects) then {
			_tabobjects = _tabobjects + [typeOf _object];
			_quantity = _quantity + [1];
		}else{
			private ["_idx_object"];
			_idx_object = _tabobjects find (typeOf _object);
			_quantity set [_idx_object, ((_quantity select _idx_object) + 1)];
		};

		for [{_j = 0}, {_j < count mps_loadable_objects}, {_j = _j + 1}] do{
			if (_object isKindOf (mps_loadable_objects select _j select 0)) exitWith{
				_currentload = _currentload + (mps_loadable_objects select _j select 1);
			};
		};
	};

	_maxload = 0;
	for [{_i = 0}, {_i < count mps_transportable_containers}, {_i = _i + 1}] do {
		if (_container isKindOf (mps_transportable_containers select _i select 0)) exitWith {
			_maxload = (mps_transportable_containers select _i select 1);
		};
	};

	private ["_ctrllist"];
	
	_container_contents = findDisplay 86601;

	(_container_contents displayCtrl 86605) ctrlSetText "Contents of Container";
	(_container_contents displayCtrl 86606) ctrlSetText "";
	(_container_contents displayCtrl 86604) ctrlSetText "Unload";
	(_container_contents displayCtrl 86607) ctrlSetText "Cancel";
	(_container_contents displayCtrl 86602) ctrlSetText (format ["Capacity : %1/%2", _currentload, _maxload]);
	
	_ctrllist = _container_contents displayCtrl 86603;
	
	if (count _tabobjects == 0) then {
		(_container_contents displayCtrl 86604) ctrlEnable false;
	}else{
		for [{_i = 0}, {_i < count _tabobjects}, {_i = _i + 1}] do {
			private ["_index", "_icone"];

			_icone = getText (configFile >> "CfgVehicles" >> (_tabobjects select _i) >> "icon");

			if (toString ([toArray _icone select 0]) == "\") then {
				_index = _ctrllist lbAdd (getText (configFile >> "CfgVehicles" >> (_tabobjects select _i) >> "displayName") + format [" (%1x)", _quantity select _i]);
				_ctrllist lbSetPicture [_index, _icone];
			}else{
				_index = _ctrllist lbAdd ("     " + getText (configFile >> "CfgVehicles" >> (_tabobjects select _i) >> "displayName") + format [" (%1x)", _quantity select _i]);
			};
			_ctrllist lbSetData [_index, _tabobjects select _i];
		};
	};
	
	waitUntil (uiNamespace getVariable "mps_logistics_dialog");
	mps_lock_action = false;
};