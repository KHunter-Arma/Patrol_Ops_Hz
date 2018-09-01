// Written by BON_IF
// Adpated by EightySix

if(!(call Hz_fnc_isTaskMaster)) exitWith{};

_locations = nearestLocations [ [0,0] ,["Name","NameLocal","NameVillage","NameCity","NameCityCapital","ViewPoint"],20000];
_patrollocations = [];

{	if(position _x distance getMarkerPos format["respawn_%1",(SIDE_A select 0)] > 2000) then {
		_patrollocations = _patrollocations + [_x];
	};
} foreach _locations;

for "_i" from 1 to (10/* + random 20*/) do {
	_position = position (mps_loc_towns call mps_getRandomElement);
	_Grp = [_position,"INF",(5 + random 5),50] call CREATE_OPFOR_SQUAD;

	_Grp setBehaviour "AWARE";
	_Grp setSpeedMode "LIMITED";
	_Grp setFormation "COLUMN";

	_patrollocations = _patrollocations call mps_getArrayPermutation;
	{	if(position _x distance getMarkerPos format["respawn_%1",(SIDE_A select 0)] > 2000) then {
			(_Grp addWaypoint [position _x,100]) setWaypointType "MOVE";
		};
	} foreach _patrollocations;
	(_Grp addWaypoint [_position,50]) setWaypointType "CYCLE";

	if(mps_debug) then {
		_marker = createMarker [format["marker%1%2",round (_position select 0),round (_position select 1)],_position];
		_marker setMarkerType "o_inf";
		_marker setMarkerColor "ColorRedAlpha";
	};
	sleep 1.234;
};