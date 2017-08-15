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

private ["_soldier","_rangeMax","_propability","_object","_newTarget","_crowd","_InsideCivilians"];
_soldier = (_this select 3) select 0;
if !(local _soldier) exitWith{};

_rangeMax = 50;
_propability = (CIM_Module getVariable "nielsen_cim_authority");

_object = _this select 0;
_id = _this select 2;
_newTarget = (_this select 3) select 2;
_crowd = (_this select 3) select 1;


if (_crowd) then {
	player groupChat "Everybody get inside!";
	if !(CIM_Module getVariable "nielsen_cim_disableAUDIO") then {
	[player, "nielsen_cim_getInside"] call CBA_fnc_globalSay3d;
	};


	//Gather nearby civs and put in list
	private ["_nearMen", "_i"];
	_InsideCivilians = [];
	_nearMen = (getPos _object) nearEntities ["Man",_rangeMax];
	for "_y" from 0 to (count _nearMen - 1) do {
		if (side (_nearMen select _y) == CIVILIAN && isNil {(_nearMen select _y) getVariable "reezo_ied_triggerman"} && isNil {(_nearMen select _y) getVariable "reezo_ied_trigger"}) then {
			_rnd = random 1;
			if (_rnd < _propability) then {
				_InsideCivilians = _InsideCivilians + [(_nearMen select _y)];			
			};
		};
	};
} else {
	_soldier groupChat "You! Get inside!";
	if !(CIM_Module getVariable "nielsen_cim_disableAUDIO") then {
	[_soldier, "nielsen_cim_getInside"] call CBA_fnc_globalSay3d;
	};
	_InsideCivilians = [_newTarget];
};
//Send list of CIM_getInside_Caller and civs to server
_CBApubVar = ["CIM_getInside_Caller", _soldier] call CBA_fnc_publicVariable;

_CBApubVar = ["CIM_InsideCivilians", _InsideCivilians] call CBA_fnc_publicVariable;

sleep 0.5;
//Tell server to stop civs
_CBApubVar = ["CIM_getInside", true] call CBA_fnc_publicVariable;

//Debug msg
if (CIM_DebugMode) then {diag_log format ["cim_action_getInside_Client.sqf running. - CIM_getInside_Caller is: %1, CIM_InsideCivilians is: %2, CIM_getInside is: %3",CIM_getInside_Caller,CIM_InsideCivilians,CIM_getInside];};

if (true) exitWith{};