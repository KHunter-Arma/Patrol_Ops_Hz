#define MAX_DIST 26
#define TRUCK_TYPE "C_IDAP_Truck_02_water_F"
#define COST_PER_LITRE 0.5
#define FILL_TIME_PER_LITER 0.06

_this addaction ["<t color=""#42ebf4"">" + "Fill Water Truck",{

_tank = _this select 0;

_truck = (nearestObjects [_tank,[TRUCK_TYPE],MAX_DIST]) select 0;

if (isnil "_truck") exitWith {

	hint "There is no water truck nearby!";

};

if (_truck getVariable ["fillingUp",false]) exitWith {

	hint "Already filling up truck!";

};

_capacity = getNumber (configFile >> "CfgVehicles" >> TRUCK_TYPE >> "acex_field_rations_waterSupply");
_waterLevel = [_truck] call acex_field_rations_fnc_getRemainingWater;

_waterToFill = _capacity - _waterLevel;

if (_waterToFill < 0.1) exitWith {

	hint "Already full!";

};

_cost = _waterToFill*COST_PER_LITRE;

if (Hz_econ_funds < _cost) exitWith {

	hint "You're too broke to buy water!";

};

_fillTime = _waterToFill*FILL_TIME_PER_LITER;

_truck setvariable ["fillingUp",true,true];

[_fillTime,_truck,_tank,_capacity,_cost,MAX_DIST] spawn {

	_fillTime = _this select 0;
	_truck = _this select 1;
	_tank = _this select 2;
	_capacity = _this select 3;
	_cost = _this select 4;
	_dist = _this select 5;
	
	hint format ["Filling up truck...\nTime to complete: ~%1 minutes",round (_fillTime/60)];

	while {(alive _truck) && {alive _tank} && {(_truck distance _tank) < _dist} && {_fillTime > 0}} do {
	
		uiSleep 1;
		_fillTime = _fillTime - 1;
	
	};
	
	if (_fillTime <= 0) then {
	
		Hz_econ_funds = Hz_econ_funds - _cost;
		publicVariable "Hz_econ_funds";
		
		hint format ["Total cost: $%1",_cost];
		
		[_truck, _capacity] call acex_field_rations_fnc_setRemainingWater;
	
	};
	
	_truck setvariable ["fillingUp",false,true];

};

},[],0,true,true,"","((vehicle _this) == _this)"];