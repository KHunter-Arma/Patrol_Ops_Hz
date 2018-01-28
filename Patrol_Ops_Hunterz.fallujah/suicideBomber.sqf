/* 

Adapted to Hunter'z Ambient War Module and ported to Arma 3 from 

the Suicide Bomber script by Zooloo75/Stealthstick
Link to original:
http://www.armaholic.com/page.php?id=20562

*/

private ["_nearUnits","_exit","_pos","_timeout","_bomber","_targetSides","_explosiveType"];

_bomber = _this select 0;
_targetSides = _this select 1;
_explosiveType = _this select 2;
_bomberSide = _this select 3;
_exit = false;

while {alive _bomber && !_exit} do
{
  _nearUnits = nearestObjects [_bomber,["CAManBase"],100];
  _nearUnits = _nearUnits - [_bomber];
  {
    if(!(side _x in _targetSides)) then {_nearUnits = _nearUnits - [_x];};
  } forEach _nearUnits;
  if(count _nearUnits != 0) then
  {
    _pos = getpos (_nearUnits select 0);
    _bomber forceSpeed -1;
    _bomber setunitpos "UP";
    _bomber doMove _pos;
    
    _timeout = time + 10;
    waitUntil {sleep 0.1; (!alive _bomber) || (_bomber distance _pos < 15) || (time > _timeout)};
    if(((_bomber distance (_nearUnits select 0)) < 15) && (alive _bomber))
    exitWith
    {
      _exit = true;
      
      [_bomber,_explosiveType,_bomberSide] spawn {
        
        private ["_pos","_bomber"];
        
        _bomber = _this select 0; 
        _explosiveType = _this select 1;
        _bomberSide = _this select 2;
        dostop _bomber;
				
				[_bomber,"shout"] remoteExecCall ["say3D",0,false];
				
				_bomber playMoveNow "AmovPercMstpSsurWnonDnon";
				
        _bomber disableAI "MOVE";
        uisleep 0.5;
        [_bomber,"AmovPercMstpSsurWnonDnon"] remoteExecCall ["switchMove",0,false];
        _bomber disableAI "anim";
        [_bomber] joinsilent (creategroup _bomberSide);
        uisleep 1;
        
        if (alive _bomber) then {
        
          _pos = getPos _bomber;
          _bomb = _explosiveType createVehicle _pos;
					_bomb setDamage 1;
          sleep 0.5;
          deletevehicle _bomber;
          
        };
      };      
      
    };
  };
  
  sleep 10;
};