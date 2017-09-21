///////////////////////////////////////////////////////////////////
///////////	(CIM) Civilian Interaction Module	///////////////////
///////////				By: Nielsen				///////////////////
///////////////////////////////////////////////////////////////////	
///////////	nielsen_cim_getAway_client.sqf:		///////////////////
///////////	Executed by action menu on civilian.///////////////////		
///////////	This script collects info about the ///////////////////
///////////	civilians in the area and passes it	///////////////////
///////////	to the server						///////////////////
///////////////////////////////////////////////////////////////////

private ["_soldier","_rangeMax","_propability","_interval","_object","_newTarget","_crowd","_AwayCivilians"];
_soldier = (_this select 3) select 0;
if !(local _soldier) exitWith{};

_rangeMax = 50;
_propability = (CIM_Module getVariable "nielsen_cim_authority");
_interval = 3;
_object = _this select 0;

_newTarget = (_this select 3) select 2;
_crowd = (_this select 3) select 1;

if (_crowd) then {

	player groupChat "Everybody get out of the area!";
	if !(CIM_Module getVariable "nielsen_cim_disableAUDIO") then {
	[player, "nielsen_cim_getAway"] call CBA_fnc_globalSay3d;
	};


	//Gather nearby civs and put in list
	private ["_nearMen", "_i"];
	_AwayCivilians = [];
	_nearMen = (getPos _object) nearEntities ["Man",_rangeMax];
	for "_y" from 0 to (count _nearMen - 1) do {
		if (side (_nearMen select _y) == CIVILIAN && isNil {(_nearMen select _y) getVariable "reezo_ied_triggerman"} && isNil {(_nearMen select _y) getVariable "reezo_ied_trigger"}) then {
			_rnd = random 1;
			if (_rnd < _propability) then {
				_AwayCivilians = _AwayCivilians + [(_nearMen select _y)];			
			};
		};
	};

} else {
	player groupChat "You! Get out of the area!";
	if !(CIM_Module getVariable "nielsen_cim_disableAUDIO") then {
		[player, "nielsen_cim_getAway"] call CBA_fnc_globalSay3d;
	};
	_AwayCivilians = [_newTarget];
};

//Send list of CIM_getAway_Caller and civs to server
_CBApubVar = ["CIM_getAway_Caller", player] call CBA_fnc_publicVariable;
_CBApubVar = ["CIM_AwayCivilians", _AwayCivilians] call CBA_fnc_publicVariable;

sleep 0.5;
//Tell server to stop civs
_CBApubVar = ["CIM_GetOutCiv", true] call CBA_fnc_publicVariable;

//Debug msg
if (CIM_DebugMode) then {diag_log format ["cim_action_getAway_Client.sqf running. - CIM_getAway_Caller is: %1, CIM_AwayCivilians is: %2, CIM_GetOutCiv is: %3",CIM_getAway_Caller,CIM_AwayCivilians,CIM_GetOutCiv];};

if (true) exitWith{};