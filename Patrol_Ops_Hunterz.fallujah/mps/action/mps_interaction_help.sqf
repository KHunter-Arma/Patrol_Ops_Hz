private _person = _this select 0;

if (_person getVariable ["mps_isHelpRequester",false]) exitWith {
	hint """I already told you everything I know! Please help me.""";
};

if ((_person getVariable ["Hz_ambw_civ_isHostile",false]) || {_person getVariable ["mps_askedForHelp",false]}) exitwith {

	if (random 1 < 0.5) then {
		
		hint "This person is acting dismissive against you.";
		
	} else {
	
		hint """No thanks.""";
	
	};
};

_person setVariable ["mps_askedForHelp",true,true];
// either he's going to ask for help or not be too nice so, he shouldn't be questionable if he hasn't been already
_person setVariable ["mps_questioned",true,true];


if ((hz_debug) || {(random 1) < 0.2}) then {

		Hz_pops_heartsandmindsTaskRequested = true;
		publicVariable "Hz_pops_heartsandmindsTaskRequested";
		Hz_pops_heartsandmindsTaskRequester = _person;
		publicvariable "Hz_pops_heartsandmindsTaskRequester";
		
		_person setVariable ["Hz_ambw_civ_doNotDelete", true, true];
		
		hint """There is something you can help me with...""";

} else {

	hint ([
				"This person is confused about what you're asking",
				"This person is becoming frustrated due to the language barrier",
				"This person does not appear to understand what you're asking",
				"This person is acting dismissive against you.",
				"""No thanks."""
				] call mps_getRandomElement);

};