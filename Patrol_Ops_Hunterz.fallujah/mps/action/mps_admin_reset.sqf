// Written by Eightysix

	_vehicle = _this select 0;

	if(isNull _vehicle) exitWith{};

	if(!serverCommandAvailable "#shutdown") exitWith{};

	_vehicle setVariable ["mps_veh_reset",true,true];

