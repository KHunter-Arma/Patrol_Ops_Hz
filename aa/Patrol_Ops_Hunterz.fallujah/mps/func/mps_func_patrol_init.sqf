// Written by BON_IF
// Adpated by EightySix

if(!isServer) exitWith{};
private ["_index","_pos","_params"];

_grp = _this select 0;

_pos = (_this select 1) call mps_get_position;

_params = "patrol"; //"standby","hide"

if(count _this > 2) then{ _params = switch (_this select 2) do { case "standby" : {"standby"}; case "hide" : {"hide"}; default {"patrol"}; }; };

[_grp,_pos,_params] execFSM (mps_path+"fsm\mps_patrol.fsm");

if(true) exitWith{};