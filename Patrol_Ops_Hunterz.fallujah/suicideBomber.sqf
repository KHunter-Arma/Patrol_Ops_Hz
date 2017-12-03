
private ["_nearUnits","_runCode","_pos","_timeout","_bomber","_targetSide","_explosiveClass"];

_bomber = _this select 0;
_targetSide = _this select 1;
_explosiveClass = _this select 2;
_runCode = 1;

while {alive _bomber && _runCode == 1} do
{
  _nearUnits = nearestObjects [_bomber,["CAManBase"],100];
  _nearUnits = _nearUnits - [_bomber];
  {
    if(!(side _x in _targetSide)) then {_nearUnits = _nearUnits - [_x];};
  } forEach _nearUnits;
  if(count _nearUnits != 0) then
  {
    _pos = getpos (_nearUnits select 0);
    _bomber forceSpeed -1;
    _bomber setunitpos "UP";
    _bomber doMove _pos;
    
    /*_explosive = _explosiveClass createVehicle (position _bomber);
                _explosive setDir (getDir _bomber);
                _explosive attachTo [_bomber,[0.2,0.2,0.9],"torso"];
                _explosive2 = _explosiveClass createVehicle (position _bomber);
                _explosive2 setDir (getDir _bomber);
                _explosive2 attachTo [_bomber,[-0.2,0.2,0.9],"torso"];
                */
    _timeout = time + 10;
    waitUntil {sleep 0.1; (!alive _bomber) || (_bomber distance _pos < 15) || (time > _timeout)};
    if(((_bomber distance (_nearUnits select 0)) < 15) && (alive _bomber))
    exitWith
    {
      _runCode = 0;
      /*
    [_bomber] spawn {
                    _bomber = _this select 0; _bomber say3D "shout"; _bomber switchmove "AmovPercMstpSsurWnonDnon"; sleep 0.5;
                    _bomber enablesimulation false; sleep 1; _exppos = getPos _bomber;
                    "Warfare82mmMortar" createVehicle _exppos;"Warfare82mmMortar" createVehicle _exppos;"Warfare82mmMortar" createVehicle _exppos; sleep 0.5; deletevehicle _bomber;
                    };
                    
      
      */
      
      //to make it work on MP...   
      
      [_bomber,_explosiveClass] spawn {
        
        private ["_exppos","_bomber"];
        
        _bomber = _this select 0; 
        _explosiveClass = _this select 1;
        dostop _bomber;
				
        //[objNull,_bomber,rSAY,"shout"] call RE;
				[_bomber,"shout"] remoteExecCall ["say3D",0,false];
				
        //[objNull,_bomber,rPLAYMOVE,"AmovPercMstpSsurWnonDnon"] call RE;
				
				_bomber playMoveNow "AmovPercMstpSsurWnonDnon";
				
        _bomber disableAI "move";
        uisleep 0.5;
        [_bomber,"AmovPercMstpSsurWnonDnon"] remoteExecCall ["switchMove",0,false];
        _bomber disableAI "anim";
        [_bomber] joinsilent (creategroup (SIDE_B select 0));
        uisleep 1;
        //     _uncon = _bomber call ace_sys_wounds_fnc_isUncon;
        //    waituntil {!_uncon; sleep 2;};
        if (alive _bomber) then 
        
        {  _exppos = getPos _bomber;
          _bomb = _explosiveClass createVehicle _exppos;
					_bomb setDamage 1;
          sleep 0.5;
          deletevehicle _bomber;
          
        };
      };      
      
    };
  };
  
  sleep 10;
};

//deletevehicle _explosive; deletevehicle _explosive2;