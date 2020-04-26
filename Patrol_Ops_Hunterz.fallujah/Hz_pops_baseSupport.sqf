#define ALT 200

_targetpos = _this select 0;

_targetpos = _targetpos vectorAdd [0,0,ALT];

_type = selectRandom ["RHS_AH64DGrey"];

_air1 = ([ [5000, -5000, ALT], 0, _type, (SIDE_A select 0)] call BIS_fnc_spawnVehicle) select 0;
_group = group _air1;
_air2 = ([ [5000, -5500, ALT], 0, _type, _group] call BIS_fnc_spawnVehicle) select 0;

_group setVariable ["Hz_Attacking",true];

sleep 3;

_air1 flyInHeight ALT;
_air2 flyInHeight ALT;

sleep 5;

_group setBehaviour "COMBAT";
_group setCombatMode "RED";
_group setFormation "WEDGE";

{
	_x setSkill 1;
} foreach units _group;

_WP = _group addWaypoint [ATLToASL _targetpos,-1];
_WP setWaypointType "SAD";
_WP setWaypointCompletionRadius 1500;
_group setSpeedMode "FULL";

waitUntil {

	Hz_pops_baseSupportOffline || {({(alive _x) && {(lifeState _x) != "INCAPACITATED"}} count ((crew _air1) + (crew _air2))) < 1}

};

Hz_pops_baseSupportOffline = true;

if (({(alive _x) && {(lifeState _x) != "INCAPACITATED"}} count ((crew _air1) + (crew _air2))) > 0) then {

	_group setCombatMode "BLUE";
	
	{	
		_x forgetTarget (assignedTarget _x);
		_x doWatch objNull;
	} foreach units _group;
	
	_air1 doMove _targetpos;
	_air2 doMove _targetpos;

	sleep 15;
	
	_group setBehaviour "SAFE";
	_group setCombatMode "BLUE";
	
	deleteWaypoint _WP;
	sleep 2;
	_WP = _group addWaypoint [ATLToASL [5000, -5500, ALT],-1];
	_WP setWaypointType "MOVE";
	_WP setWaypointCompletionRadius 500;
	_group setSpeedMode "FULL";
	
	sleep 120;
	
	{
		if (alive _x) then {
			if ((vehicle _x) != _x) then {
				(vehicle _x) deleteVehicleCrew _x;
			} else {
				deleteVehicle _x;
			};			
		};
	} foreach units _group; 
	
	if (alive _air1) then {
		deleteVehicle _air1;
	};
	if (alive _air2) then {
		deleteVehicle _air2;
	};

};
