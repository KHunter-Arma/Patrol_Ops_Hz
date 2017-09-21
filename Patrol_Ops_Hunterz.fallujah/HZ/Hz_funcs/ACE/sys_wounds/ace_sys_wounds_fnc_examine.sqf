/* ace_sys_interaction (.pbo) | (c) 2009 by rocko */
// Initiates a medical examination of a person (patient).
// If that patient is not local, then read their medical state via a networked answer variable.
// Exec: local to caller
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private "_receiver";
PARAMS_1(_receiver);

TRACE_1("Examine", _receiver);

if (!alive player) exitWith {};

if(isplayer _receiver) exitwith {hintsilent "CMS Enabled";};

if (!alive _receiver) exitWith {
	hintSilent localize "STR_DN_ACE_HEISDEAD"; // "He is dead"
};

if (isNil "ace_sys_wounds_enabled") exitWith {
	// provide some level of response
	if (alive _receiver) then {
		if (damage _receiver == 0) then {
			hintSilent "He appears fine";
		} else {
			if (damage _receiver < 30) then {
				hintSilent "He has some injuries";
			} else {
				hintSilent "He has major injuries";
			};
		};
	};
	false
};

ace_sys_wounds_recAnswer = [];

[QGVAR(examunit), [_receiver, player]] call ACE_fnc_receiverOnlyEvent;

false
