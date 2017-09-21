///////////////////////////////////////////////////////////////////
///////////	(CIM) Civilian Interaction Module	///////////////////
///////////				By: Nielsen				///////////////////
///////////////////////////////////////////////////////////////////	
///////////	nielsen_cim_arrest_client.sqf:		///////////////////
///////////	Executed by action menu on civilian.///////////////////		
///////////	This script opens the gear dialog	///////////////////
///////////	for the targeted civilian.			///////////////////
///////////////////////////////////////////////////////////////////

private ["_object","_thisman"];
_soldier = (_this select 3) select 0;
_civilian = (_this select 3) select 1;
if !(local _soldier) exitWith{};

_thisman = cursorTarget;

//Add civilian to global array of searched civilians
_CBApubVar = ["CIM_Disarm", [true,_thisman]] call CBA_fnc_publicVariable;

//Debug msg
if (CIM_DebugMode) then {diag_log format ["Client disarming civilian: %1",_thisman];};

if (true) exitWith{};