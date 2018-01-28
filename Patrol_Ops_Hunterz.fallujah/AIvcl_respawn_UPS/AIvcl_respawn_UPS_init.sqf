// AI_respawn_UPS_init.sqf
// © JULY 2009 - norrin (norrin@iinet.net.au)
#define HZ_DEBUG(X) if(hz_debug_patrols) then {hint X;}

if (!isServer) exitWith {};

private ["_group", "_unit", "_crew", "_escort", "_lives", "_delay", "_respawn_point", "_marker", "_isair", "_side", "_unitTypeArray", "_vehType", "_leader"];

_unit = _this select 0;
_crew = crew _unit;
_group 			= group _unit;
_escort = [];
{if((vehicle _x) == _x) then {_escort pushback (typeof _x);};}foreach units _group;

_lives			= _this select 1;
_delay 			= _this select 2;
_respawn_point          = _this select 3;
_marker			= _this select 4;
_isair = if ((count _this) > 5) then {_this select 5} else {false};
_side 			= side _unit; 

_group setvariable ["Hz_Patrolling",true];

waitUntil {!isnil "hz_debug_patrols"};

if (!isMultiplayer && !hz_debug_patrols) exitWith {

	{

		deletevehicle (vehicle _x);
		deletevehicle _x;

	} foreach units _unit;

};

// Unit type array is for guys that are in the vehicle at the beginning of the mission
//for APCs this will be all the group members if all are in the vehicle.
//for tanks it will only be the actualy crew and not the rest of the squad.

_unitTypeArray  = [];
{_unitTypeArray set [count _unitTypeArray, typeOf _x];
}forEach _crew;

_vehType = typeof _unit;
_unit setvehiclelock "LOCKED";

_leader = leader _group;

waitUntil {!isnil "UPS_respawn_initDone"};

[_leader,_marker,_isair] call Hz_pops_patrols_startUPS;

if (alive _unit) then {

	Hz_pops_deleteVehicleArray pushBack _unit;

};

Hz_pops_UPSRespawnArray pushBack [_vehType, _lives, _respawn_point, _marker, _side, _unitTypeArray,_escort,_isair];