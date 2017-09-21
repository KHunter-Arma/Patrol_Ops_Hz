///////////////////////////////////////////////////////////////////
///////////	(CIM) Civilian Interaction Module	///////////////////
///////////				By: Nielsen				///////////////////
///////////////////////////////////////////////////////////////////	
///////////	nielsen_cim_arrest_client.sqf:		///////////////////
///////////	Executed by action menu on civilian.///////////////////		
///////////	This script collects info about the ///////////////////
///////////	targeted civilian and passes it		///////////////////
///////////	to the server						///////////////////
///////////////////////////////////////////////////////////////////

private ["_soldier","_rangeMax","_probability","_object"];
_soldier = (_this select 3) select 0;
_civilian = (_this select 3) select 1;
if !(local _soldier) exitWith{};

//Assign civilian global value to pass to server
_broadcasted = ["CIM_NewRelease", cursorTarget] call CBA_fnc_publicVariable;

_object = _this select 0;

player groupChat "You can go!";

//if !(CIM_Module getVariable "nielsen_cim_disableAUDIO") then {
//[_soldier, "nielsen_CIM_Release"] call CBA_fnc_globalSay3d;
//};

sleep 0.5;
//Tell server to call release function
_broadcasted = ["CIM_Release", true] call CBA_fnc_publicVariable;

//Debug msg
if (CIM_DebugMode) then {diag_log format ["Client asking server to release civilian: %1",CIM_NewRelease];};

if (true) exitWith{};