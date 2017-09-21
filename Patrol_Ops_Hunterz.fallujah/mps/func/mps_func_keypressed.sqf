// Written by BON_IF
// Adapted by EightySix

if(isDedicated) exitWith {};

private["_key"];

	_key = _this select 1;

	_handled = false;

	switch (_key) do{
		case 22 : { if(!dialog) then { createDialog "mps_hud_dialog" }; _handled = true; };
	};

_handled