//  UPS_init.sqf
// © JULY 2009 - norrin
private ["_unit", "_marker"];

_unit 	= _this select 0;
_marker	= _this select 1;

_unit setSpeedMode "NORMAL";
[group _unit,_marker,"CYCLE:",5,"SHOWMARKER"] spawn Hz_AI_UPS_Hz;

//hint "UPS initialised!";

if (true) exitWith {};