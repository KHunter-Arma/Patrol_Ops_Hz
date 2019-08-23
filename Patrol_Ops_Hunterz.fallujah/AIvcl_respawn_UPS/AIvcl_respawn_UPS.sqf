// AIvcl_respawn_UPS.sqf
// © JULY 2009 - norrin
#define HZ_DEBUG(X) if(hz_debug_patrols) then {hint X;}

if (!(call Hz_fnc_isAiMaster)) exitWith {};

private ["_group", "_type", "_lives", "_respawn_point", "_marker", "_side", "_unitTypeArray", "_escort", "_isair", "_signx", "_signy", "_respawnzone", "_vehIsTank", "_vehicle", "_dude", "_unitsGroup", "_turrets", "_turCount", "_loop", "_guy", "_leader", "_vehType", "_unitTypeArray"];

_type 			= _this select 0;
_lives			= _this select 1;
_respawn_point      	= _this select 2;
_marker			= _this select 3;
_side 			= _this select 4;
_unitTypeArray	= _this select 5;
_escort = _this select 6;
_isair = _this select 7;

if (_lives == 0) exitWith {};
_lives = _lives - 1;

_signx = if ((random 1) < 0.5) then {-1} else {1};
_signy = if ((random 1) < 0.5) then {-1} else {1};
_respawnzone = [(((markerPos _respawn_point) select 0) + (random 715)*_signx),(((markerPos _respawn_point) select 1) + (random 715)*_signy),0];

_vehIsTank = false;
_isman = _type isKindOf "CAManBase";

if (((count _escort) > 0) && !_isman) then {

	_vehIsTank = true;
};

_vehicle = objNull;
_group = createGroup _side;
_group setvariable ["Hz_Patrolling",true]; 

if (_isman) then {

	{
			_dude = _group createUnit [_x,_respawnzone, [], 100, "NONE"];
			
	} foreach _escort;
	
	_escort allowGetIn false;
	_escort orderGetIn false;

} else {

	//needed before going into UPS or bis function will override name...
	scriptName format ["HZUPSID: %1",_group];

	if (_vehIsTank) then {
	
		_vehicle = ([_respawnzone,90,_type,_group] call BIS_fnc_spawnVehicle) select 0;
		_vehicle setvehiclelock "LOCKED";
		
		(units _group) allowGetIn true;
		(units _group) orderGetIn true;
		
		{
			_dude = _group createUnit [_x,_respawnzone, [], 100, "NONE"];
			
		} foreach _escort;

		_escort allowGetIn false;
		_escort orderGetIn false;

	} else {
		
		_vehicle = ([_respawnzone,90,_type,_group] call BIS_fnc_spawnVehicle) select 0;
		_vehicle setvehiclelock "LOCKED";
		
		_passengerUnits = +_unitTypeArray;
		_crewType = typeof driver _vehicle;
		
		_passengerUnits = _passengerUnits - [_crewType];		
		
		_diff = (count _unitTypeArray) - ((count _passengerUnits) + (count crew _vehicle));
		if (_diff > 0) then {
		
			for "_i" from 1 to _diff do {
			
				_passengerUnits pushBack _crewType;
			
			};
		
		};
		
		_cargoCount = _vehicle emptyPositions "Cargo";
		_fcFreeTurrets = [];
		{
		
			_fcFreeTurrets pushback (_x select 3);
		
		} foreach (fullCrew [_vehicle, "Turret",true] - fullCrew [_vehicle, "Turret",false]);
		
		{
			_dude = _group createUnit [_x,_respawnzone, [], 100, "NONE"];
			
			if (_cargoCount > 0) then {
						
				_dude assignascargo _vehicle;
				_dude moveinCargo _vehicle;
				_cargoCount = _cargoCount - 1;
			
			} else {
			
				if ((count _fcFreeTurrets) > 0) then {
				
					_turret = selectRandom _fcFreeTurrets;
					_dude assignasTurret [_vehicle, _turret];
					_dude moveinTurret [_vehicle, _turret];
					_fcFreeTurrets = _fcFreeTurrets - [_turret];
				
				};
			
			};	
			
			_dude assignasCargo _vehicle;
			_dude moveInCargo _vehicle;		
		} forEach _passengerUnits;
		
		(units _group) allowGetIn true;
		(units _group) orderGetIn true;
		
	};

};

_group setFormation "STAG COLUMN";
_group setSpeedMode "NORMAL";
_group setCombatMode "SAFE";

[_vehicle,_marker,_isair,_group] call Hz_pops_patrols_startUPS;

_group deleteGroupWhenEmpty true;

if (alive _vehicle) then {

	Hz_pops_deleteVehicleArray pushBack _vehicle;

};

Hz_pops_UPSRespawnArray pushBack [_type, _lives, _respawn_point, _marker, _side, _unitTypeArray,_escort,_isair];