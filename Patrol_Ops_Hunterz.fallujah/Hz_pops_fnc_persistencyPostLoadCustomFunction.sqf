{

	[_x] call Hz_pops_fnc_storeBoughtVehicleInit;

} foreach Hz_pers_network_vehicles;

call Hz_weather_func_dynamicWeather;