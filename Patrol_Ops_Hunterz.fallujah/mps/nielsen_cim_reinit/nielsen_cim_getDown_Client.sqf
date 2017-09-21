///////////////////////////////////////////////////////////////////
///////////	(CIM) Civilian Interaction Module	///////////////////
///////////				By: Nielsen				///////////////////
///////////////////////////////////////////////////////////////////	
///////////	nielsen_cim_getDown_client.sqf:		///////////////////
///////////	Executed by action menu on civilian.///////////////////		
///////////	This script collects info about the ///////////////////
///////////	civilians in the area and passes it	///////////////////
///////////	to the server						///////////////////
///////////////////////////////////////////////////////////////////

private ["_soldier","_rangeMax","_propability","_interval","_object","_newTarget","_NewCivilians","_crowd"];
_soldier = (_this select 3) select 0;
_crowd = (_this select 3) select 1; 
_newTarget = cursorTarget; 
if !(local _soldier) exitWith{};

_rangeMax = 50;
_propability = (CIM_Module getVariable "nielsen_cim_authority");

_object = _this select 0;

if (_crowd) then {
	player groupChat "Everybody get down now!";
	if !(CIM_Module getVariable "nielsen_cim_disableAUDIO") then {
	[player, "nielsen_cim_getDown"] call CBA_fnc_globalSay3d;
	};

	//Gather nearby civs and put in list
	private ["_nearMen"];
	_NewCivilians = [];
	_nearMen = (getPos _object) nearEntities ["Man",_rangeMax];
	for "_y" from 0 to (count _nearMen - 1) do {
		if (side (_nearMen select _y) == CIVILIAN && isNil {(_nearMen select _y) getVariable "reezo_ied_triggerman"} && isNil {(_nearMen select _y) getVariable "reezo_ied_trigger"}) then {
			_rnd = random 1;
			if (_rnd < _propability) then {
				_NewCivilians = _NewCivilians + [(_nearMen select _y)];			
			};
		};
	};
} else {
	_soldier groupChat "You! Get down now!";
	if !(CIM_Module getVariable "nielsen_cim_disableAUDIO") then {
	[_soldier, "nielsen_cim_getDown"] call CBA_fnc_globalSay3d;
	};
	_NewCivilians = [_newTarget];
};
//Send list of civs to server
_CBApubVar = ["CIM_NewCivilians", _NewCivilians] call CBA_fnc_publicVariable;
sleep 0.5;
//Tell server to stop civs
_CBApubVar = ["CIM_WarnCiv", true] call CBA_fnc_publicVariable;

if (true) exitWith{};