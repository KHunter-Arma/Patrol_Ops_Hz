// AI_respawn_UPS_init.sqf
// © JULY 2009 - norrin (norrin@iinet.net.au)


private ["_unit","_lives","_delay","_respawn_point","_marker","_group","_unitsGroup","_side","_AI_unitArray","_AI_magArray","_AI_wepArray"];
if (!isServer) exitWith {};

waitUntil {sleep 1; !isnil "UPS_respawn_initDone"};

_unit 			= _this select 0;
_lives			= _this select 1;
_delay 			= _this select 2;
_respawn_point	= _this select 3;
_marker			= _this select 4;
_group                   = group _unit;
_unitsGroup     	= units _group;
_side 			= side _unit;

_group setvariable ["Hz_Patrolling",true];

waitUntil {sleep 1; !isnil "hz_debug_patrols"};

if (!isMultiplayer && !hz_debug_patrols) exitWith {

	{

		deletevehicle (vehicle _x);
		deletevehicle _x;

	} foreach units _unit;

};

sleep 2;
sleep (random 5);

_AI_unitArray  = [];
_AI_magArray   = [];
_AI_wepArray   = [];

 {
 _AI_unitArray = _AI_unitArray + [typeOf _x];
 _AI_magArray = _AI_magArray + [magazines _x];
 _AI_wepArray = _AI_wepArray + [weapons _x];
 
 }foreach _unitsGroup;

[_unit,_marker] execVM "AI_respawn_UPS\UPS_init.sqf";

[_unit, _lives, _delay, _respawn_point, _marker, _group, _side, _AI_unitArray,_AI_magArray, _AI_wepArray,time] call AI_respawn_UPS;