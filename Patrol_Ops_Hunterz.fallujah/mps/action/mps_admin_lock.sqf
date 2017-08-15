// Written by Eightysix

	if(isNil "mps_admin_lockedVehicles") then { mps_admin_lockedVehicles = []; };

	_vehicle = _this select 0;

	if(isNull _vehicle) exitWith{};

	_type = getText (configFile >> "CfgVehicles" >> typeof _vehicle >> "displayName");

	_locked = _vehicle getVariable "mps_veh_locked";

	if(isNil "_locked") then { _vehicle setVariable ["mps_veh_locked",false,true]};

	if(!serverCommandAvailable "#shutdown") exitWith{};

	_locked = _vehicle getVariable "mps_veh_locked";

	if(_locked) exitWith {

		mps_admin_lockedVehicles = mps_admin_lockedVehicles - [_vehicle]; PublicVariable "mps_admin_lockedVehicles";

		mps_admin_vehicle_unlock = _vehicle; PublicVariable "mps_admin_vehicle_unlock"; _vehicle call mps_unlock_vehicle;

		_vehicle setVariable ["mps_veh_locked",false,true];

	};

	if(!_locked) exitWith {

		if ( count (crew _vehicle) > 0 ) then { { _x action ["Eject", vehicle _x] } forEach (crew _vehicle) };

		mps_admin_lockedVehicles = mps_admin_lockedVehicles + [_vehicle]; PublicVariable "mps_admin_lockedVehicles";

		mps_admin_vehicle_lock = _vehicle; PublicVariable "mps_admin_vehicle_lock"; _vehicle call mps_lock_vehicle;

		_vehicle setVariable ["mps_veh_locked",true,true];

	};
        
        