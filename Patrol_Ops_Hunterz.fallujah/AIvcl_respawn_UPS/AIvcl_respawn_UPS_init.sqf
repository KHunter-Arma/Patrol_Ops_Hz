// AI_respawn_UPS_init.sqf
// © JULY 2009 - norrin (norrin@iinet.net.au)
#define HZ_DEBUG(X) if(hz_debug_patrols) then {hint X;}

if (!isServer) exitWith {};
private ["_unit", "_lives", "_delay", "_respawn_point", "_marker", "_group", "_crew", "_side", "_isair","_AI_unitArray", "_escort", "_leader"];


sleep 10;

_unit 			= _this select 0;
_lives			= _this select 1;
_delay 			= _this select 2;
_respawn_point          = _this select 3;
_marker			= _this select 4;
_crew 			= crew _unit;
_group 			= group _unit;
_side 			= side _unit; 
_isair = false;

_group setvariable ["Hz_Patrolling",true];

if(_this select 5) then {_isair = true;};

sleep 2;
sleep (random 5);

// AI unit array is guys that are in the vehicle at the beginning of the mission (10 second delay on top is to wait for moveincargo commands to work)
//for APCs this will be all the group members if all are in the vehicle.
//for tanks it will only be the actualy crew and not the rest of the squad.
//same goes for AI skill array. this is why the setskill command in the persistent script is overriden to set all group members' skill to a constant.

_AI_unitArray  = [];
_escort = [];

{_AI_unitArray set [count _AI_unitArray, typeOf _x];
}forEach _crew;

{if((vehicle _x) == _x) then {_escort set [count _escort,typeof _x];};}foreach units _group;

[_unit, _lives, _delay, _respawn_point, _marker, _crew, _side, _AI_unitArray,_escort,time] execVM "AIvcl_respawn_UPS\AIvcl_respawn_UPS.sqf";
_leader = leader _group;

sleep (random 30);
[_leader,_marker,_isair] execVM "AIvcl_respawn_UPS\UPSvcl_init.sqf";

if (true)exitWith {};

