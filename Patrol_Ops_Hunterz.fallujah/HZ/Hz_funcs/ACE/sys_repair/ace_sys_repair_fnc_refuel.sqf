// #define DEBUG_MODE_FULL
#include "script_component.hpp"

#define FUEL_PRICE_PER_LITER 1.5

private["_type", "_threshold", "_fuel", "_repairTime", "_endTime", "_complete", "_i", "_step"];
PARAMS_2(_veh,_repairVeh);

__REFUEL_TIME_PER_LITER = 0.5;

// TODO: Handle repairs differently based on used damage systems (Hitpoints, vs Armor Damage simulation etc)
// TODO: Handle repair veh type, can also be building, maybe some repairs should only be allowed at the building. One should be able to tow the vehicle to the building though..
_type = typeOf _veh;
_displayName = getText(configFile >> "CfgVehicles" >> _type >> "displayName");
_fuel = fuel _veh;
_fuelCap = _type call Hz_func_getFuelCapacity;
_fuelLitres = _fuel * _fuelCap;

if(_fuelCap > 2000) then {__REFUEL_TIME_PER_LITER = __REFUEL_TIME_PER_LITER * 25;};

if(_fuel == 1) exitwith {hint "Tank already full.";};
_HzRefuelCost = (1 - _fuel) * _fuelCap * FUEL_PRICE_PER_LITER;
if(Hz_funds < _HzRefuelCost) exitWith {hint "Insufficient funds!";};

// TODO: Verify Engine status (Armor damage simulation system)

_complete = false;
//_repairTime = (getNumber(configFile >> "CfgVehicles" >> _type >> QGVAR(time)) * 0.5) * (1 - _fuel); // Fuel: 50% of Repair... for now
//_repairTime = ceil _repairTime;

_repairTime = ceil ((_fuelCap - _fuelLitres) * __REFUEL_TIME_PER_LITER);

if (_repairTime == 0) exitWith { hint format[localize "STR_ACE_REFUEL_NO", _displayName]; };
if (_veh getVariable [QGVAR(refuel_busy), false] && {(_veh getVariable [QGVAR(refuel_busyState), 0]) >= time}) exitWith { hint "Busy already..." };
[QGVAR(setBusyRef), [_veh, _repairTime]] call CBA_fnc_globalEvent;

hint format[localize "STR_ACE_REFUEL_TIME", _repairTime, _displayName];
[_repairTime, [localize "STR_CFG_CUTSCENES_REFUEL"], false, false] spawn ace_progressbar;
_endTime = time + _repairTime;

_step = (1 - _fuel) / _repairTime;

_i = 0;
while {alive _repairVeh && {alive _veh} && {_veh distance _repairVeh < 15}} do {
	if (time > _endTime) exitWith { _complete = true };
	ADD(_i,1);
	sleep 1;
};

if (_complete) then {
	TRACE_1("setFuel 1",_veh);
	[QGVAR(refuel), [_veh, 1]] call CBA_fnc_globalEvent;
	hint (localize "STR_ACE_REFUEL_SUCCESS");
} else {
	[QGVAR(refuel), [_veh, (_fuel + (_step * _i) min 1)]] call CBA_fnc_globalEvent; // Still not entirely doing it in steps realtime, due to possible network implications
	hint (localize "STR_ACE_REFUEL_NOSUCCESS_TOOFAR");
};

[QGVAR(unsetBusyRef), _veh] call CBA_fnc_globalEvent;

sleep 2;
_HzRefuelCost = ceil (((fuel _veh) - _fuel) * _fuelCap * FUEL_PRICE_PER_LITER);
Hz_funds = Hz_funds - _HzRefuelCost;
publicvariable "Hz_funds";

hint format ["Refuel cost: $%1",_HzRefuelCost];
