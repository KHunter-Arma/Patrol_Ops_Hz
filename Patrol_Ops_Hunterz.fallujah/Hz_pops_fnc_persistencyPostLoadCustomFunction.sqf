{

	[_x] call Hz_pops_fnc_storeBoughtVehicleInit;

} foreach Hz_pers_network_vehicles;

{

	[_x] call Hz_fnc_vehicleInit;

} foreach Hz_pers_network_objects;
