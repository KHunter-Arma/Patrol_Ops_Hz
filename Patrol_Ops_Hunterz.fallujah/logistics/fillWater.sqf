#define MAX_DIST 7
#define TANK_TYPE "Land_WaterCooler_01_new_F"
#define COST_PER_LITRE 0.5
#define FILL_TIME_PER_LITER 4

_truck = _this select 0;

_waterTank = (nearestObjects [_truck,[TANK_TYPE],MAX_DIST]) select 0;

if (isnil "_waterTank") exitWith {

	hint "There is no water cooler nearby!";

};

_capacity = getNumber (configFile >> "CfgVehicles" >> TANK_TYPE >> "acex_field_rations_waterSupply");
_waterLevel = [_waterTank] call acex_field_rations_fnc_getRemainingWater;

_waterToFill = _capacity - _waterLevel;

if (_waterToFill < 0.1) exitWith {

	hint "Already full!";

};

_cost = _waterToFill*COST_PER_LITRE;

if (Hz_econ_funds < _cost) exitWith {

	hint "You're too broke to buy water!";

};

_fillTime = _waterToFill*FILL_TIME_PER_LITER;

[_fillTime, [_truck,_waterTank,_capacity,_cost,MAX_DIST], {

	_args = _this select 0;
	_waterTank = _args select 1;
	_capacity = _args select 2;
	_cost = _args select 3;
	
	Hz_econ_funds = Hz_econ_funds - _cost;
	publicVariable "Hz_econ_funds";
	
	hint format ["Total cost: $%1",_cost];
	
	[_waterTank, _capacity] call acex_field_rations_fnc_setRemainingWater;

}, {}, "Filling up...",{_args = _this select 0; (!captive player) && (((_args select 0) distance (_args select 1)) < (_args select 4))}] call ace_common_fnc_progressBar;
