// Written by EightySix

if(isDedicated || !mps_rank_sys_enabled) exitWith {};

private ["_ranksig","_name","_rank","_score","_text","_ctrl"];

disableSerialization;

uiNamespace setVariable ['crewdisplay', objnull];

while {true} do {

	if(isnull (uiNamespace getVariable "crewdisplay")) then { cutrsc ["infomessage", "PLAIN"];};

	if(mps_hud_active && !visibleMap && vehicle player == player) then{

		_color = "#77c753";

		if (damage player >= 0.4 ) then {_color = "#FF4444";};

		If (!alive player) then {_color = "#000000";};

		_ranksig = switch toupper(rank player) do {
			case "PRIVATE"	: {"rank_private.paa"};
			case "CORPORAL"	: {"rank_corporal.paa"};
			case "SERGEANT"	: {"rank_sergeant.paa"};
			case "LIEUTENANT" : {"rank_lieutenant.paa"};
			case "CAPTAIN"	: {"rank_captain.paa"};
			case "MAJOR"	: {"rank_major.paa"};
			case "COLONEL"	: {"rank_colonel.paa"};
			default {"rank_private.paa"};
		};

		_name = name player;

		_rank = rank player;

		_score = rating player;

		_text = format ["<t size='4' shadow='1'><img image='\CA\warfare2\Images\%4'></t><br/><t size='1.35' shadow='1' color='%2'>%1 - %5 - %3</t>",_name,_color,_rank,_ranksig,_score];

	}else{

		_text = localize "STR_MISSION_NAME";

	};

	_ctrl = (uiNamespace getVariable 'crewdisplay') displayCtrl 86041;

	_ctrl ctrlSetStructuredText parseText _text;

	sleep 1;

};

	_text = "";

	_ctrl = (uiNamespace getVariable 'crewdisplay') displayCtrl 86041;

	_ctrl ctrlSetStructuredText parseText _text;
