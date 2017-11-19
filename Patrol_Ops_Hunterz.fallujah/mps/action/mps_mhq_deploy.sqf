// Written by EightySix

private["_vehicle","_caller","_side"];

_vehicle = _this select 0;
_caller = _this select 1;
_side = mhq_vehicle getVariable "mhq_side";

if(side _caller != _side) exitWith {hint "Cannot deploy opposition MHQ"};

if(MHQ_STATUS)exitWith{hint "MHQ already deployed";};

if(speed _vehicle > 1 || speed _vehicle < -1) exitWith {hint "Moving to Fast to deploy MHQ";};

_boxloaded = _vehicle getVariable "vehicle_ammobox";

if(if(isNil "_boxloaded") then {true} else {not _boxloaded}) then{}else{ [_vehicle] execVM (mps_path+"action\mps_ammobox_unload.sqf"); };

sleep 0.2;

_vehicle setVariable ["mhq_status",true,true];
