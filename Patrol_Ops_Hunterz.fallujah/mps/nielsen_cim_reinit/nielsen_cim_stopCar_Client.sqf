///////////////////////////////////////////////////////////////////
///////////	(CIM) Civilian Interaction Module	///////////////////
///////////				By: Nielsen				///////////////////
///////////////////////////////////////////////////////////////////	
///////////	nielsen_cim_stopCar_client.sqf:		///////////////////
///////////	Executed by action menu on car.		///////////////////		
///////////	This script collects info about the ///////////////////
///////////	targeted civilian car and passes it	///////////////////
///////////	to the server						///////////////////
///////////////////////////////////////////////////////////////////

private ["_soldier","_propability","_object","_rnd","_carCrew"];
_soldier = (_this select 3) select 0;
_civilian = (_this select 3) select 1;
if !(local _soldier) exitWith{};

_carCrew = crew cursorTarget;

_propability = (CIM_Module getVariable "nielsen_cim_authority");

_object = _this select 0;

player groupChat "Turn of your engine and get out of the car!";
if !(CIM_Module getVariable "nielsen_cim_disableAUDIO") then {
[player, "nielsen_cim_stopCar"] call CBA_fnc_globalSay3d;
};

_rnd = random 1;
if (_rnd < _propability) then {
	//Send vehicle crew names to server
	_broadcasted = ["CIM_carCrew", _carCrew] call CBA_fnc_publicVariable;
	sleep 0.5;
	//Tell server to call arrest function
	_broadcasted = ["CIM_stopCar", true] call CBA_fnc_publicVariable;

	//Debug msg
	if (CIM_DebugMode) then {diag_log format ["Client asking server to stop car - CIM_carCrew is: %1",CIM_carCrew];};
} else {
	//Debug msg
	if (CIM_DebugMode) then {diag_log format ["Driver %1 is ignoring commands",CIM_carCrew];};
};

if (true) exitWith{};