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

//stop animation if any
if ( !(_thisman in CIM_List_Keycuff) AND (group _thisMan != group CIM_getAway_Caller) AND isNil {_thisMan getVariable "reezo_ied_triggerman"} && isNil {_thisMan getVariable "reezo_ied_trigger"}) then {
	if ((animationState _thisMan) != "") then { _thisMan enableAI "ANIM"; _thisMan enableAI "MOVE"; _broadcastedInfo = ["cim_animation", [true,_thisman,""]] call CBA_fnc_publicVariable;};
};

//Open gear screen
CreateGearDialog [_thisman,"RscDisplayGear"];

//Add civilian to global array of searched civilians
_CBApubVar = ["CIM_List_Searched", CIM_List_Searched + [_thisman]] call CBA_fnc_publicVariable;

_object = _this select 0;

player groupChat "Stand still while I search you!";
//if !(CIM_Module getVariable "nielsen_cim_disableAUDIO") then {
//[_soldier, "nielsen_cim_Arrest"] call CBA_fnc_globalSay3d;
//};

//If CRM riot is active, pubvar as possible cause
if !(isNil "CRM_Module") then {
	if ("riot" in (CRM_Module getVariable "nielsen_crm_events")) then {
		private ["_rnd"]; _rnd = random 100;
		if (_rnd < 5) then {
			_broadcastEvent = ["crm_newEvent",[true,"riot",_soldier]] call CBA_fnc_publicVariable;
		};
	};
};

//Debug msg
if (CIM_DebugMode) then {diag_log format ["Client searching civilian: %1",_thisman];};

if (true) exitWith{};