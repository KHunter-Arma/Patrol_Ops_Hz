// Written by Code34
// Adapted by EightySix

if(!mps_co) exitWith {hint format["%1",_this select 2];};

	private ["_title","_instruction","_duration"];

	_title 		= _this select 0;
	_instruction 	= _this select 1;
	_information	= _this select 2;

	[] call bis_fnc_hints;
	[] call BIS_AdvHints_setDefaults;

	BIS_AdvHints_THeader = _title;

	if(format["%1", _information] != "") then {
		BIS_AdvHints_TInfo = _information;
	} else {
		BIS_AdvHints_TInfo = "";
	};

	BIS_AdvHints_TImp = "";
	BIS_AdvHints_TAction = format["<t color='#e0e0e0'>%1</t>", _instruction];
	BIS_AdvHints_TBinds = "";
	BIS_AdvHints_Text = call BIS_AdvHints_formatText;
	BIS_AdvHints_Duration = 10;
	BIS_AdvHints_HideCode = "hintSilent '';";

	MSGDISPLAY = true;
	call BIS_AdvHints_showHint;
	MSGDISPLAY = false;