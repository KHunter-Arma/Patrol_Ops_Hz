/* ace_sys_interaction (.pbo) | (c) 2009 by rocko */
// _this (c) by Xeno
// Initiates the display of a medical report of a person.
// If that patient is not local, then read their medical state via a networked answer variable.
// Exec: local to caller

//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_receiver", "_sender", "_state", "_wakeup", "_damage"];
PARAMS_3(_receiver,_sender,_state);
_wakeup = _this select 6;
_damage = _this select 7;

TRACE_1("Examine answer:",_this);

if (_receiver != player) exitWith {};
if (!alive player) exitWith {};

if(isplayer _sender) exitwith {hintsilent "CMS Enabled";};

if (isNil "_state") then {_state = 0};
if (isNil "_wakeup") then {_wakeup = 0};
if (isNil "_damage") then {_damage = 0};

_hasCAT = _sender getVariable ["ace_w_cat",false]; 	// Is casulty having a CAT
_male = getNumber(configFile >> "CfgVehicles" >> typeOf _sender >> "woman") == 0;

if (_state == 0 && {_wakeup == 0} && {_damage == 0}) exitWith {
	_check = format [localize "STR_DN_ACE_BLUEBLUEEYES", name _sender];
	if (_hasCAT) then { _check = _check + "\n" + format [localize "STR_ACE_WOUNDS_CHECK_T",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }]  };
	hintSilent format ["%1",_check];
};

if (_state == 0 && {_wakeup == 1}) exitWith {
	hintSilent format[localize "STR_DN_ACE_SLEEPINGDOWN", name _sender];
};

_this spawn ace_sys_wounds_fnc_examansw;

false