#define MAX_DIST 7
#define TANK_TYPE "Land_WaterCooler_01_new_F"
#define FILL_TIME_PER_LITER 4

_truck = _this select 0;

_waterTank = (nearestObjects [_truck,[TANK_TYPE],MAX_DIST]) select 0;

if (isnil "_waterTank") exitWith {

	hint "There is no water cooler nearby!";

};

_capacity = getNumber (configFile >> "CfgVehicles" >> TANK_TYPE >> "acex_field_rations_waterSupply");
_waterLevel = [_waterTank] call acex_field_rations_fnc_getRemainingWater;

_waterToFill = _capacity - _waterLevel;

_truckWater = [_truck] call acex_field_rations_fnc_getRemainingWater;

if (_waterToFill > _truckWater) exitWith {

	hint "Truck hasn't got enough water!";

};

if (_waterToFill < 0.1) exitWith {

	hint "Already full!";

};

_fillTime = _waterToFill*FILL_TIME_PER_LITER;

[_fillTime, [_truck,_waterTank,_capacity,_waterToFill,_truckWater, MAX_DIST], {

	_args = _this select 0;
	_truck = _args select 0;
	_waterTank = _args select 1;
	_capacity = _args select 2;
	_waterToFill = _args select 3;
	_truckWater = _args select 4;
	
	[_waterTank, _capacity] call acex_field_rations_fnc_setRemainingWater;
	[_truck, _truckWater - _waterToFill] call acex_field_rations_fnc_setRemainingWater;

}, {}, "Filling up...",{_args = _this select 0; (!captive player) && {alive (_args select 0)} && {alive (_args select 1)} && {((_args select 0) distance (_args select 1)) < (_args select 5)}}] call ace_common_fnc_progressBar;
