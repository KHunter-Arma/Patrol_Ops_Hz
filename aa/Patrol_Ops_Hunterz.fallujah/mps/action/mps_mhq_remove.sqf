// Written by EightySix

private["_vehicle","_caller","_side"];

_vehicle = _this select 0;
_caller = _this select 1;

_side = _vehicle getVariable "mhq_side";

if(side _caller != _side) exitWith {hint "Cannot remove opposition MHQ"};

_vehicle setVariable ["mhq_status",false,true];
