/* ace_sys_wounds(.pbo) */
// _this (c) by Xeno
// Displays a hint with person's medical condition and required treatment.
// Exec: local to caller
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

#define __SPACE " "

private ["_check", "_uncon", "_ok", "_idcs", "_mor_dosage","_hasCAT"];
PARAMS_6(_receiver,_sender,_state,_epi,_bleed,_pain);

_bleed_add = _this select 10;
_mor_dosage = _this select 13;
_hasCAT = _this select 14;

TRACE_1("Examine wounds answer:",_this);

if (!alive _receiver) exitWith {};

if(isplayer _sender) exitwith {hintsilent "CMS Enabled";};

//_state : Used to determine wether unit is unconscious or not
//_epi: Used to tell the units pulse
//_bleed: Used to tell how many wounds
//_bleedAdd: NEW! Used to tell how severe the wounds are // This should also be available in the Examine action
//_pain: Used to tell how much a unit is suffering from pain

_male = getNumber(configFile >> "CfgVehicles" >> typeOf _sender >> "woman") == 0;

_check = format ["%1", name _sender]; // Just the name

_uncon = _sender call FUNC(isUncon); 					// Is casulty unconscious
_isMedic = _receiver call FUNC(isMedic); 					// Is examiner a medic ?

// Non medics will get the "WYSIWYG" message of the examine report, e.g see the result of symptoms
// Medics will get the "correct" examine report as is now, e.g "X is unconscious"

if (!_uncon) then {
	if (_isMedic) then {
		_check = _check + __SPACE + (localize "STR_ACE_WOUNDS_CHECK_NOT_UNC"); 								// "is conscious" / "ist bei Bewußtsein"
	} else {
		_check = _check + __SPACE + (localize "STR_ACE_WOUNDS_CHECK_NOTMEDIC_NOT_UNC");						// "is responsive" / "ist ansprechbar"
	};
	if (_epi > 0) then {
		if (_isMedic) then {
			if (50 > random 100) then {
				_check = _check + (localize "STR_ACE_WOUNDS_CHECK_BUT_EPI"); 						// "but needs epinephrine.\n" / "benötigt aber Epi.\n"
			} else {
				_check = _check + (localize "STR_ACE_WOUNDS_CHECK_BUT_WEAKPULSE"); 				// "but has a weak pulse.\n"  / "aber hat einen schwachen Puls.\n"
			};
		} else {
			_check = _check + ".\n"; // Non medics probably cannot examine a conscious person that has low pulse
		};
	} else {
		_check = _check + ".\n";
	};
} else {
	if (_isMedic) then {
		_check = _check + __SPACE + (localize "STR_ACE_WOUNDS_CHECK_UNC"); 						// "is unconscious" / "ist bewustlos"
	} else {
		if (50 > random 100) then {
			_check = _check + __SPACE + (localize "STR_ACE_WOUNDS_CHECK_NOTMEDIC_UNC1");		// "is not responsive" / "ist nicht ansprechbar"
		} else {
			_check = _check + __SPACE + (localize "STR_ACE_WOUNDS_CHECK_NOTMEDIC_UNC2");		// "does not react" / "reagiert nicht"
		};
	};
	if (_epi > 0) then {
		if (_isMedic) then {
			_check = _check + __SPACE + (localize "STR_ACE_WOUNDS_CHECK_AND_EPI"); 			// "and needs epinephrine.\n"
		} else {
			_check = _check + ".\n";
		};
	} else {
		_check = _check + ".\n";
	};
};

if (_bleed == 0) then {
	// "He is not bleeding.\n"
	_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_NOT_BLEED",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
} else {
	if (_isMedic) then {
		if (_bleed <= 0.2) then {
			_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_BLEED",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
		};
		if (_bleed > 0.2 && {_bleed <= 0.4}) then {
			//"He is bleeding from several wounds.\n";
			_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_BLEED2",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
		};
		if (_bleed > 0.4 && {_bleed <= 0.6}) then {
			// "He is bleeding heavily and needs to get bandaged.\n"
			_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_BLEED_HEAVY",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
		};
		if (_bleed > 0.6) then {
			//"He is suffering extreme bloodloss.\n";
			_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_BLEED3",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];	
		};
	} else {
		if (_bleed > 0.3 && {_bleed < 0.7}) then {
			_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_BLEED",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
		};
		if (_bleed >= 0.7) then {
			//"He is suffering extreme bloodloss.\n";
			_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_BLEED3",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
		};		
	};
};

// Pain diagnosis only for a conscious patient...
if (_pain == 0) then {
	if (_isMedic && {!_uncon}) then {
		// "He has no pain.\n"
		_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_NOT_PAIN",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
	};
} else {
	if (_isMedic && {!_uncon}) then {	// You cannot tell wether someone who is uncon has pain :D
		switch (true) do {
			case (_pain <= 0.3): {
				_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_PAIN",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
			};
			case (_pain > 0.6): {
				// "He seems to have heavy pain.\n"
				_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_PAIN3",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
			};
			default {
				_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_PAIN2",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
			};
		};
	} else {
		if (_pain >= 0.5 && {!_uncon}) then {
			// "He seems to have pain.\n"
			_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_NOTMEDIC_PAIN",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
		};
	};
};
// Overdosage recog for medics only
if (_isMedic) then {
	if (_mor_dosage >= 1) then { // Light overdose
		_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_MORINTOX1",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
	};
	if (_mor_dosage >= 2) then { // Severe
		_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_MORINTOX2",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
	};
	if (_mor_dosage >= 3) then { // He will die...
		_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_MORINTOX3",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
	};
};

if (_hasCAT) then {
	_check = _check + format [localize "STR_ACE_WOUNDS_CHECK_T",if (_male) then { localize "STR_ACE_WOUNDS_HEMAN" } else { localize "STR_ACE_WOUNDS_SHEMAN" }];
};

hintSilent _check;

ace_sys_wounds_receiver = _sender;
ace_sys_wounds_recstate = _state;
ace_sys_wounds_recAnswer = _this;

if (!local _sender) then {
	[
		ace_sys_wounds_receiver,
		[[QPATHTO_F(fnc_menuDef_Self), "treat person"]]
	] call cba_ui_fnc_menu;
};

false
