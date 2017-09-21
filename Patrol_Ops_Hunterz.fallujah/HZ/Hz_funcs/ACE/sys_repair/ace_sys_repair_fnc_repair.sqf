// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private["_simul", "_type", "_threshold", "_damage", "_repairTime", "_endTime", "_complete", "_canMove", "_parts", "_i", "_step","_HzFullRepairCost"];
PARAMS_2(_veh,_repairVeh);

_HzEnterDamage = damage _veh;
_HzMultiplier = 1;
_HzCost =  (typeof _veh) call Hz_veh_getVehCost;

_HzFullRepairCost = _HzEnterDamage * _HzMultiplier * _HzCost;

if(Hz_funds < _HzFullRepairCost) exitwith {hint "Insufficient funds for the repairs!"};

// TODO: Handle repair veh type, can also be building, maybe some repairs should only be allowed at the building. One should be able to tow the vehicle to the building though..
_type = typeOf _veh;
_displayName = getText(configFile >> "CfgVehicles" >> _type >> "displayName");
_threshold = _veh getVariable [QGVAR(threshold),-1];
if (_threshold < 0) then {
	_threshold = getNumber(configFile >> "CfgVehicles" >> _type >> QGVAR(threshold));
};
_damage = damage _veh;
_simul = [_veh] call ace_sys_vehicledamage_fnc_enabled;

if (_simul) then {
	_canMove = _veh getVariable "ace_canmove";
	if !(isNil "_canMove") then { 
		if !(_canMove) then { 
			_damage = 0.5;
		}; 
	}; // 50% repairtime for Tank/Wheeled APC wheels.
	if (GVAR(full)) then { _damage = 0.66 }; // Temporary workaround for simulation enabled vehicles, when full module is used
};
TRACE_4("",_threshold,_damage,_type,_simul);

//Hunter: disable this feature
//if (_damage > _threshold) exitWith { hint format[localize "STR_ACE_TOOMUCHDAMAGE", _threshold, _displayName] };

_complete = false;
_repairTime = getNumber(configFile >> "CfgVehicles" >> _type >> QGVAR(time)) * _damage;
_repairTime = ceil _repairTime;
if (_veh isKindOf "Air" && {_veh call CBA_fnc_locked} && {!isNil {_veh getVariable "ace_sys_eject_seatlock"}}) then {
	_repairTime = _repairTime + 120;
};
if (_repairTime == 0) exitWith { 
	if (_simul) then { 
		[_veh] call ace_sys_vehicledamage_fnc_rep_tracks_n_wheels;
	}; 
	hint format[localize "STR_ACE_REPAIR_NO", _displayName];
};
if (_veh getVariable [QGVAR(repair_busy), false] && {(_veh getVariable [QGVAR(repair_busyState), 0]) >= time}) exitWith { hint "Busy already..." };
[QGVAR(setBusyRep), [_veh, _repairTime]] call CBA_fnc_globalEvent;

hint format[localize "STR_ACE_REPAIR_TIME", _repairTime, _displayName];
[_repairTime, [localize "STR_CFG_CUTSCENES_REPAIR"], false, false, _veh] spawn ace_progressbar;
_endTime = time + _repairTime;

_step = _damage / _repairTime;

_i = 0;
while {_veh distance _repairVeh < 15 && {alive _veh} && {alive _repairVeh}} do {
	if (time > _endTime) exitWith { _complete = true };
	ADD(_i,1);
	sleep 1;
};

if (_complete) then {
	if (_simul) then {
		if (GVAR(full)) then {
			[QGVAR(repair_full), [_veh]] call CBA_fnc_globalEvent;
		} else {
			[QGVAR(repair_part), [_veh]] call CBA_fnc_globalEvent;
		};
	} else {
		if (GVAR(full)) then {
			[QGVAR(sd), [_veh, 0]] call CBA_fnc_globalEvent;
		} else {
			[QGVAR(repair_tracks), [_veh]] call CBA_fnc_globalEvent;
		};
	};
	TRACE_1("Repaired vehicle",_veh);
	if (_veh isKindOf "Air" && {_veh call CBA_fnc_locked} && {!isNil {_veh getVariable "ace_sys_eject_seatlock"}}) then {
		["ace_sys_eject_ooo", _veh] call CBA_fnc_globalEvent;
	};
	hint (localize "STR_ACE_REPAIR_SUCCESS");
} else {
	hint (localize "STR_ACE_REPAIR_NOSUCCESS_TOOFAR");
	_veh setDammage ((_damage - (_step * _i)) min 1);
	_veh setVariable ["ACE_PB_Abort", true];
};

[QGVAR(unsetBusyRep), _veh] call CBA_fnc_globalEvent;

sleep 2;
_HzRepairCost = ceil ((_HzEnterDamage - (damage _veh)) * _HzMultiplier * _HzCost);

Hz_funds = Hz_funds - _HzRepairCost;
publicvariable "Hz_funds";

_display = _HzRepairCost;

if(_HzRepairCost >= 1000000) then {
        _display = format ["%1 million",(_HzRepairCost / 1000000)];
        };

hint format ["Repair cost: $%1",_display];