// AI_respawn_UPS_init.sqf
// © JULY 2009 - norrin (norrin@iinet.net.au)
#define HZ_DEBUG(X) if(hz_debug_patrols) then {hint X;}

if (!isServer) exitWith {};

private ["_vehicle", "_group", "_crew", "_escort", "_lives", "_delay", "_respawn_point", "_marker", "_isair", "_side", "_vehicleTypeArray", "_vehType", "_leader"];

_vehicle = _this select 0;
_crew = crew _vehicle;
_group = group _vehicle;
_escort = [];
{if((vehicle _x) == _x) then {_escort pushback (typeof _x);};}foreach units _group;

_lives			= _this select 1;
_delay 			= _this select 2;
_respawn_point          = _this select 3;
_marker			= _this select 4;
_isair = if ((count _this) > 5) then {_this select 5} else {false};
_side 			= side _vehicle; 

_group setvariable ["Hz_Patrolling",true];

waitUntil {!isnil "hz_debug_patrols"};

if (!isMultiplayer && !hz_debug_patrols) exitWith {

	{
		_veh = vehicle _x;
		if (_veh == _x) then {							
			deletevehicle _x;							
		} else {							
			_veh deleteVehicleCrew _x;							
		};
	} foreach units _vehicle;
	
	deletevehicle _vehicle;
	
	deleteGroup _group;

};

// Unit type array is for guys that are in the vehicle at the beginning of the mission
//for APCs this will be all the group members if all are in the vehicle.
//for tanks it will only be the actualy crew and not the rest of the squad.

_vehType = typeof _vehicle;
_isman = _vehType isKindOf "CAManBase";

_vehicleTypeArray  = [];

if (!_isman) then {

	{
	
		_vehicleTypeArray set [count _vehicleTypeArray, typeOf _x];
	
	}forEach _crew;
	
	_vehicle setvehiclelock "LOCKED";

};

waitUntil {!isnil "Hz_fnc_isAiMaster"};

if (call Hz_fnc_isAiMaster) then {

	waitUntil {!isnil "UPS_respawn_initDone"};
	
	switch (_side) do {
		case blufor : {
			{Hz_pops_UpsBluforUnits pushBack _x} foreach (units _group);
		};
		case opfor : {	
			{Hz_pops_UpsOpforUnits pushBack _x} foreach (units _group);	
		};
		case resistance : {
			{Hz_pops_UpsGrnforUnits pushBack _x} foreach (units _group);		
		};
	};		

	[_vehicle,_marker,_isair,_group] call Hz_pops_patrols_startUPS;

	if (alive _vehicle) then {

		Hz_pops_deleteVehicleArray pushBack _vehicle;

	};

	Hz_pops_UPSRespawnArray pushBack [_vehType, _lives, _respawn_point, _marker, _side, _vehicleTypeArray,_escort,_isair];

} else {

	{
		_veh = vehicle _x;
		if (_veh == _x) then {							
			deletevehicle _x;							
		} else {							
			_veh deleteVehicleCrew _x;							
		};
	} foreach units _vehicle;
	
	deleteVehicle _vehicle;
	
	deleteGroup _group;
	
	waitUntil {!isnil "Hz_pops_UPSPassToHCArray"};
	
	Hz_pops_UPSPassToHCArray pushBack [_vehType, _lives, _respawn_point, _marker, _side, _vehicleTypeArray,_escort,_isair];

};