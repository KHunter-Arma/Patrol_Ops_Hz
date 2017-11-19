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

private ["_soldier","_rangeMax","_probability","_object","_newCiv"];
_soldier = (_this select 3) select 0;
_civilian = (_this select 3) select 1;
if !(local _soldier) exitWith{};

//Assign civilian global value to pass to server
_newCiv = cursorTarget;

_object = _this select 0;

player groupChat "Get down and stay there!";

//Send civ and caller names to server
_CBApubVar = ["CIM_NewPacify", _newCiv] call CBA_fnc_publicVariable;

sleep 0.5;
//Tell server to call arrest function
_CBApubVar = ["CIM_Pacify", true] call CBA_fnc_publicVariable;

//If CRM riot is active, pubvar as possible cause
if !(isNil "CRM_Module") then {
	if ("riot" in (CRM_Module getVariable "nielsen_crm_events")) then {
		private ["_rnd"]; _rnd = random 100;
		if (_rnd < 10) then {
			_broadcastEvent = ["crm_newEvent",[true,"riot",_soldier]] call CBA_fnc_publicVariable;
		};
	};
};

//Debug msg
if (CIM_DebugMode) then {diag_log format ["Client asking server to pacify - CIM_NewPacify is: %1",CIM_NewPacify];};

if (true) exitWith{};