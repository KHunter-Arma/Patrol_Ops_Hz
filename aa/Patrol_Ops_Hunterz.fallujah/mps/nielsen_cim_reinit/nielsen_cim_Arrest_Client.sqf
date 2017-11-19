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

private ["_soldier","_newCiv","_CBApubVar","_interval","_object"];
_soldier = (_this select 3) select 0;
_civilian = (_this select 3) select 1;
if !(local _soldier) exitWith{};

private ["_soldier","_rangeMax"];
//Assign civilian value to pass to server
_newCiv = cursorTarget;

_object = _this select 0;

// no audio only text
player groupChat "You are comming with us!";
//if !(CIM_Module getVariable "nielsen_cim_disableAUDIO") then {
//[_soldier, "nielsen_cim_Arrest",30] call CBA_fnc_globalSay3d;
//};

//Send civ and caller names to server
_CBApubVar = ["CIM_Arrest_Caller", player] call CBA_fnc_publicVariable;
_CBApubVar = ["CIM_NewArrest", _newCiv] call CBA_fnc_publicVariable;
sleep 0.5;

//Tell server to call arrest function
_CBApubVar = ["CIM_Arrest", true] call CBA_fnc_publicVariable;

//If CRM riot is active, pubvar as possible cause
if !(isNil "CRM_Module") then {
	if ("riot" in (CRM_Module getVariable "nielsen_crm_events")) then {
		private ["_rnd"]; _rnd = random 100;
		if (_rnd < 20) then {
			_broadcastEvent = ["crm_newEvent",[true,"riot",_soldier]] call CBA_fnc_publicVariable;
		};
	};
};

//Debug msg
if (CIM_DebugMode) then {diag_log format ["Client asking server to arrest - CIM_NewArrest is: %1",CIM_NewArrest];};


if (true) exitWith{};