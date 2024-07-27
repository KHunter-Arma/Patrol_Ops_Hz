{

	[_x] call Hz_pops_fnc_storeBoughtVehicleInit;

} foreach Hz_pers_network_vehicles;

{

	[_x] call Hz_fnc_vehicleInit;

} foreach Hz_pers_network_objects;

// remove radio racks -- this function has some weird working requirements...
if (isDedicated) then {
	[] spawn {
		waitUntil {
			sleep 10;
			playableUnits > 0	
		};
		{
			_x call Hz_fnc_removeAllVehicleRadioRacks;
		} foreach Hz_pers_network_vehicles;
	};
};
