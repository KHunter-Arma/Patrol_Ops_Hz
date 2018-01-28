// AIvcl_respawn_UPS.sqf
// © JULY 2009 - norrin
#define HZ_DEBUG(X) if(hz_debug_patrols) then {hint X;}

if (!isServer) exitWith {};

private ["_group", "_type", "_lives", "_respawn_point", "_marker", "_side", "_unitArray", "_escort", "_isair", "_signx", "_signy", "_respawnzone", "_vehIsTank", "_vehicle", "_dude", "_unitsGroup", "_turrets", "_turCount", "_loop", "_guy", "_leader", "_vehType", "_unitTypeArray"];

_type 			= _this select 0;
_lives			= _this select 1;
_respawn_point      	= _this select 2;
_marker			= _this select 3;
_side 			= _this select 4;
_unitArray	= _this select 5;
_escort = _this select 6;
_isair = _this select 7;

if (_lives == 0) exitWith {};
_lives = _lives - 1;

_signx = if ((random 1) < 0.5) then {-1} else {1};
_signy = if ((random 1) < 0.5) then {-1} else {1};
_respawnzone = [(((markerPos _respawn_point) select 0) + (random 715)*_signx),(((markerPos _respawn_point) select 1) + (random 715)*_signy),0];

_vehIsTank = false;
if ((count _escort) > 0) then {

	_vehIsTank = true;
};

_vehicle = objNull;

if (_vehIsTank) then {
	_group = createGroup _side;

	{
		_dude = _group createUnit [_x,_respawnzone, [], 100, "FORM"];
		[_dude] allowGetIn false;
		
	} foreach _escort;

	_group setvariable ["Hz_Patrolling",true]; 

	_vehicle = _type createVehicle _respawnzone;
	_vehicle setvehiclelock "LOCKED";

	createVehicleCrew _vehicle;
	(crew _vehicle) joinSilent _group;
	_group addVehicle _vehicle;
	(crew _vehicle) allowGetIn true;

} else {
	
	_group = createGroup _side;

	_vehicle = _type createVehicle _respawnzone;
	_vehicle setvehiclelock "LOCKEDPLAYER";

	if (_type == "LOP_IA_M113_W") then {[_vehicle, ["Desert",1],[]] call BIS_fnc_initVehicle;};

	{
		_group createUnit [_x,_respawnzone, [], 100, "FORM"];
	} forEach _unitArray;

	_unitsGroup = units _group;
	_turrets = allTurrets [_vehicle, false];
	_turCount = count _turrets;

	_unitsGroup allowgetin true;

	for [{ _loop = 0 },{ _loop < count  _unitsGroup},{ _loop = _loop + 1}] do
	{	
		_guy = _unitsGroup select _loop;
		
		switch (true) do {
			
		case ((_vehicle emptyPositions "Driver") > 0) : { _guy assignasDriver _vehicle; [_guy] orderGetIn true; _guy moveinDriver _vehicle;};
		case (_turCount > 0) : {
				
				_guy assignasTurret [_vehicle,_turrets select 0];
				[_guy] orderGetIn true;
				_guy moveinTurret [_vehicle,_turrets select 0];
				_turrets = _turrets - [_turrets select 0];
				_turCount = _turCount - 1;
				
			};	
			
			default {
				
				_guy assignascargo _vehicle;
				[_guy] orderGetIn true;
				_guy moveincargo _vehicle;
				
			};
			
		};
		
	};

};

_leader = leader _group;
_group setFormation "STAG COLUMN";
_group setSpeedMode "NORMAL";
_group setCombatMode "SAFE";

[_leader, _marker,_isair] call Hz_pops_patrols_startUPS;

UPS_vcl_respawn_calls = UPS_vcl_respawn_calls + 1;
publicvariable "UPS_vcl_respawn_calls";

if (alive _vehicle) then {

	Hz_pops_deleteVehicleArray pushBack _vehicle;

};

Hz_pops_UPSRespawnArray pushBack [_vehType, _lives, _respawn_point, _marker, _side, _unitTypeArray,_escort,_isair];