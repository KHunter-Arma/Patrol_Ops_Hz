//  UPS_init.sqf
// © JULY 2009 - norrin
private ["_unit", "_marker"];

_unit 	= _this select 0;
_marker	= _this select 1;

_unit setSpeedMode "NORMAL";

//this is execvm'd so we just call from this thread
[group _unit,_marker,"CYCLE:",5,"SHOWMARKER"] call Hz_AI_UPS_Hz;