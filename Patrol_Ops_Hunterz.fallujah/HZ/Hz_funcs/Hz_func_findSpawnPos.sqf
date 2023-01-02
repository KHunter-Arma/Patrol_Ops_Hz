#define AVOID_PLAYER_MIN_DISTANCE_FROM_RESPAWNPOS 2000
#define MIN_1D_DISTANCE_FROM_PLAYER 1400

private ["_taskpos", "_minDistance", "_maxDistance", "_sideToAvoid", "_maxDistanceStart", "_blacklistpos", "_unitarray", "_playerPositions", "_player", "_playerpos", "_marker1", "_marker2", "_results", "_spawnpos", "_tries", "_safetyFactors", "_nearEntities", "_minEnemies", "_minTotal", "_returnIndex", "_customCondition"];


_taskpos = _this select 0;
_minDistance = _this select 1;

_maxDistance = _minDistance + 500;

_sideToAvoid = SIDE_A select 0;

if ((count _this) > 2) then {
	_maxDistance = _this select 2;
};

if ((count _this) > 3) then {
	_sideToAvoid = _this select 3;
};

_objectsAvoidDistance = 10;
if ((count _this) > 4) then {
	_objectsAvoidDistance = _this select 4;
};

_customCondition = {true};
if ((count _this) > 6) then {
	_customCondition = _this select 6;
};

_stayInsideTheMap = false;
if ((count _this) > 5) then {
	_stayInsideTheMap = _this select 5;
};

_customConditionCopy = _customCondition;
if (_stayInsideTheMap) then {
	_customCondition = {((count 
(nearestTerrainObjects [_this select 0, [], 200, false, true])) > 0) && {_this call _customConditionCopy}};
};

private _customConditionArgs = [];
if ((count _this) > 7) then {
	_customConditionArgs = _this select 7;
};

_maxDistanceStart = _maxDistance;

_blacklistpos = [[markerpos "blacklist1",markerpos "blacklist2"]];
_unitarray = [];
_playerPositions = [];

//needs refactoring and optimisation on condition check order
{  	
	_player = _x;

		//add player object to blacklist only if he's more than 2km away from respawn position and make sure players close to each other are considered only as one position
	 if((({(_player distance _x) < 1000} count _playerPositions) == 0) && {(_x distance (markerpos "respawn_west")) > AVOID_PLAYER_MIN_DISTANCE_FROM_RESPAWNPOS}) then {
		 _unitarray set [count _unitarray, _x];     
	 }; 
							 
	 _playerPositions pushBack (getpos _x);  
						
}foreach playableunits;

{
	if(((_x distance _taskpos) > 1000) && {(speed (vehicle _x)) < 20}) then {
			
		_playerpos = getpos _x;        
								
		_marker1 = [(_playerpos select 0)-MIN_1D_DISTANCE_FROM_PLAYER,(_playerpos select 1)+MIN_1D_DISTANCE_FROM_PLAYER];
		_marker2 = [(_playerpos select 0)+MIN_1D_DISTANCE_FROM_PLAYER,(_playerpos select 1)-MIN_1D_DISTANCE_FROM_PLAYER];
		_blacklistpos set [count _blacklistpos, [_marker1,_marker2]];
		
	};
}foreach _unitarray;


//try collecting different options
_results = [];

for "_i" from 1 to 50 do {

	_spawnpos = [0,0,0];
	_tries = 0;
	_maxDistance = _maxDistanceStart;

	while {(_spawnpos isEqualTo [0,0,0]) || {!([_spawnpos, _customConditionArgs] call _customCondition)}} do {
						
		_spawnpos = [_taskpos, _minDistance, _maxDistance, _objectsAvoidDistance, 0, 1, 0,_blacklistpos,[[0,0,0]]] call BIS_fnc_findSafePos;

		_tries = _tries + 1;
		//_maxDistance = _maxDistance + 500;
		if(_tries > 100) exitwith {};

	};

	_results pushBack [_spawnpos select 0, _spawnpos select 1, 0];

};

_results = _results - [[0,0,0]];
if ((count _results) == 0) then {
	_results = [[0,0,0]];
};

//choose safest position that is also the most empty
_safetyFactors = [];
{
	_nearEntities = _x nearEntities [["CAManBase","Ship","LandVehicle","Helicopter","StaticWeapon"], _maxDistanceStart];
	_safetyFactors pushBack [{(side _x) == _sideToAvoid} count _nearEntities, {(side _x) != civilian} count _nearEntities]; 
} foreach _results;

_minEnemies = 999;
_minTotal = 999;
_returnIndex = 0;
{
	if (((_x select 0) < _minEnemies) && {(_x select 1) < _minTotal}) then {
		_minEnemies = _x select 0;
		_minTotal = _x select 1;
		_returnIndex = _foreachIndex;
	};
} foreach _safetyFactors;

//output
_results select _returnIndex
