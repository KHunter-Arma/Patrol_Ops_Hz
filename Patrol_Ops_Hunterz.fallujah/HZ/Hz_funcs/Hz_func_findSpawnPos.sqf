#define AVOID_PLAYER_MIN_DISTANCE_FROM_RESPAWNPOS 2000
#define MIN_1D_DISTANCE_FROM_PLAYER 1400

private ["_marker1","_maxDistance","_marker2","_taskpos","_minDistance","_blacklistpos","_spawnpos","_pos","_unitarray","_playerpos"];


_taskpos = _this select 0;
_minDistance = _this select 1;

_maxDistance = _minDistance + 500;

if ((count _this) > 2) then {

	_maxDistance = _this select 2;

};

_blacklistpos = [[markerpos "blacklist1",markerpos "blacklist2"]];
_unitarray = [];
_pos = [0,0,10000];

_spawnpos = [0,0,0];
_tries = 0;

while {(format ["%1",_spawnpos]) == "[0,0,0]"} do {

{  
    
   if(((_x distance _pos) > 1000) && ((_x distance (markerpos "respawn_west")) > AVOID_PLAYER_MIN_DISTANCE_FROM_RESPAWNPOS)) then {
     
        
    _unitarray set [count _unitarray, _x];  //add player object to blacklist units array     
    
               }; 
               
   _pos = getpos _x;  
            
}foreach playableunits;

{
  if(((_x distance _taskpos) > 1000) && ((speed (vehicle _x)) < 20)) then {
      
  _playerpos = getpos _x;        
              
  _marker1 = [(_playerpos select 0)-MIN_1D_DISTANCE_FROM_PLAYER,(_playerpos select 1)+MIN_1D_DISTANCE_FROM_PLAYER];
  _marker2 = [(_playerpos select 0)+MIN_1D_DISTANCE_FROM_PLAYER,(_playerpos select 1)-MIN_1D_DISTANCE_FROM_PLAYER];
  _blacklistpos set [count _blacklistpos, [_marker1,_marker2]];
  
    };
        }foreach _unitarray;
        
_spawnpos = [_taskpos, _minDistance, _maxDistance, 3, 0, 1, 0,_blacklistpos,[[0,0,0]]] call BIS_fnc_findSafePos;

_tries = _tries + 1;
_maxDistance = _maxDistance + 500;
if(_tries > 100) exitwith {};

};

//output
[_spawnpos select 0, _spawnpos select 1, 0]