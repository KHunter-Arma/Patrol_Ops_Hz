// Written by R3F logistics
// Adapted by EightySix
/*
if (mps_lock_action) then {
	hint "The current operation isn't finished.";
}else{
	mps_lock_action = true;
	
	private ["_object","_container","_i"];
	
	_object = mps_selected_object;
	_container = _this select 0;

	_loadedobjects = _container getVariable "mps_logistics_loaded_objects";
	if (isNil "_loadedobjects") then {
		_container setVariable ["mps_logistics_loaded_objects", [], false];
	};

	if (!isNull _object) then {
		if ( isNull (_object getVariable "mps_container_stored") ) then {

			private ["_loadedobjects", "_currentload", "_objectsize", "_maxload"];

			_loadedobjects = _container getVariable "mps_logistics_loaded_objects";

			_currentload = 0;
			{
				for [{_i = 0}, {_i < count mps_loadable_objects}, {_i = _i + 1}] do {
					if (_x isKindOf (mps_loadable_objects select _i select 0)) exitWith {
						_currentload = _currentload + (mps_loadable_objects select _i select 1);
					};
				};
			} forEach _loadedobjects;

			_objectsize = 99999;
			for [{_i = 0}, {_i < count mps_loadable_objects}, {_i = _i + 1}] do {
				if (_object isKindOf (mps_loadable_objects select _i select 0)) exitWith {
					_objectsize = (mps_loadable_objects select _i select 1);
				};
			};

			_maxload = 0;
			for [{_i = 0}, {_i < count mps_transportable_containers}, {_i = _i + 1}] do {
				if (_container isKindOf (mps_transportable_containers select _i select 0)) exitWith {
					_maxload = (mps_transportable_containers select _i select 1);
				};
			};

			if (_currentload + _objectsize <= _maxload) then {
				if (_object distance _container <= 30) then {
					_loadedobjects = _loadedobjects + [_object];
					_container setVariable ["mps_logistics_loaded_objects", _loadedobjects, true];

					HintSilent "Loading...";

					sleep 2;

					private ["_offsetpos", "_attachpos"];
					_attachpos = [random 3000, random 3000, (10000 + (random 3000))];
					_offsetpos = 1;
					while {(!isNull (nearestObject _attachpos)) && (_offsetpos < 25)} do {
						_attachpos = [random 3000, random 3000, (10000 + (random 3000))];
						_offsetpos = _offsetpos + 1;
					};
					_object attachTo [mps_logistics_referencepoint, _attachpos];
					mps_selected_object = objNull;

					hint format ["The %1 has been loaded in the container.", getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "displayName")];
				}else{
					hint format ["The %1 is too far from the container.", getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "displayName")];
				};
			}else{
				hint "There is no enough space in this container.";
			};
		};
	};
	mps_lock_action = false;
	mps_loading_in_progress = false;
};
*/