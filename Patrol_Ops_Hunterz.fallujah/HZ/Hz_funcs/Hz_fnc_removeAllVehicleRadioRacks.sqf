_this spawn {
	sleep 5;
	{
		[_this, _x] call acre_api_fnc_removeRackFromVehicle;
	} foreach ([_this] call acre_api_fnc_getVehicleRacks);
};