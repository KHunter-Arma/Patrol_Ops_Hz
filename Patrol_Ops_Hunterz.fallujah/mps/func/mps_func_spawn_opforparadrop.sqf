// Many Parts Written by ArmA Community
// Combined together by EightySix

private ["_helogrp","_spawnpos","_dest","_paradrop","_flyin","_droptype","_invisibleTarget","_helo","_drophelo","_drophelogrp","_helopilot","_radarreinforcements","_radargroup","_type","_unit","_count","_string"];

waituntil {!isnil "bis_fnc_init"};

if( count mps_opfor_ncoh == 0 ) exitWith{};

_helogrp = _this select 0;
_spawnpos = _this select 1;

_dest = (_this select 2) call mps_get_position;
_paradrop = false;
_groupType = mps_opfor_inf;
if(count _this > 3) then { _paradrop = _this select 3};
if(count _this > 4) then { _groupType = _this select 4};

_flyin = 200;
_droptype = mps_opfor_ncoh call mps_getRandomElement;

if(_droptype isKindof "Plane") then { _paradrop = true };

_invisibleTarget = objnull;

if (!_paradrop) then {

	_dest = [_dest, 0, 200, 10, 0, .5, 0] call BIS_fnc_findSafePos; 
	_invisibleTarget = "HeliHEmpty" createVehiclelocal _dest;
	_string = format _dest; if (!isNil "_string") then { _invisibleTarget setPos _dest; };

};

_helo = [ [_spawnpos select 0, _spawnpos select 1, _flyin], random 360, _droptype, (SIDE_B select 0)] call BIS_fnc_spawnVehicle;

_drophelo = _helo select 0;
_drophelogrp = _helo select 2;
_drophelogrp setvariable ["Hz_supporting",true];
_drophelogrp setvariable ["Hz_noBehaviour",true];
_drophelogrp setvariable ["Hz_careless",true];

sleep 1;

_drophelogrp setBehaviour "CARELESS";
_drophelogrp setCombatMode "YELLOW";

_drophelo setvehiclelock "locked";

if(count (units _helogrp) == 0) then {

	_helogrp setvariable ["Hz_attacking",true];
  
  //_helogrp = [_spawnpos,"INF",(8 + random 5),10] call CREATE_OPFOR_SQUAD; 

  _count = _drophelo emptyPositions "cargo";

  for "_i" from 1 to _count do {
    
    _type = _groupType call BIS_fnc_selectRandom;
    _unit = _helogrp createUnit [_type, [-1000,-1000,0],[],50,"NONE"];

    _unit assignascargo _drophelo;
    _unit moveincargo _drophelo;

  };
	/*
  (units _helogrp) allowgetin true;
  (units _helogrp) orderGetIn true;
*/
};

_helopilot = driver _drophelo;
_helopilot setSkill 1;
_helopilot disableAI "TARGET";
_helopilot disableAI "AUTOTARGET";

if (!isEngineOn _drophelo && alive _helopilot) then {
  if (!canMove _drophelo) then {
    _drophelo setDammage 0;
    _drophelo setFuel 1;
    sleep 1; 
  }; 
  _helopilot action ["engineOn", vehicle _helopilot];
};

_drophelo flyinheight 200;
_drophelo doMove _dest;

[_drophelo,_dest,_helopilot,_helogrp,_paradrop,_spawnpos,_drophelogrp] spawn {

  _drophelo = _this select 0;
  _dest = _this select 1;
  _helopilot = _this select 2;
  _helogrp = _this select 3;
  _paradrop = _this select 4;
  _spawnpos = _this select 5;
  _drophelogrp = _this select 6;

  waitUntil { _drophelo distance _dest <= 650 || !canMove _drophelo || !alive _helopilot };

  _newgrp = _helogrp;
  _dudes = units _helogrp;

  if(_paradrop || !(toupper (behaviour _helopilot) IN ["CARELESS","SAFE","AWARE"]) ) then {
    
		/*
		 // ARMA 3 PORT
		
    {	if( (assignedVehicleRole _x) select 0 == "Cargo")then {
        unassignVehicle _x;			
        _x action ["EJECT", vehicle _x];
        _x stop false;
        [_x] allowGetIn false;
        [_x] joinsilent _newgrp;
        //increased sleep so dudes don't kill each other with parachutes... #armaphysics
        uisleep 3;
        
      };
      
    } forEach _dudes;		
	*/
			
		[_drophelo,100,_dudes] spawn paraEject;
		
		/*
		_dudes allowGetIn false;
		_dudes joinsilent _newgrp;
		
	*/
	
		{
		
			waituntil {uisleep 1; ((!alive _x) || (captive _x) || ((vehicle _x) != _drophelo))};
			
		} foreach _dudes;
		
  }else{
    waitUntil{unitReady _drophelo || (((getposatl _drophelo) select 2) < 20) || !alive _helopilot};

    _drophelo land "GetOut";
    waituntil {!alive _drophelo || ((abs((velocity _drophelo) select 2)) <= 1 && ((position _drophelo) select 2) < 5)};
    
    {   if( (assignedVehicleRole _x) select 0 == "Cargo")then {
        unassignVehicle _x;
        _x action ["getOut", vehicle _x];
        _x stop false;
        [_x] allowGetIn false;
        uisleep 0.5;
        [_x] joinsilent _newgrp;
      };
      
    } forEach _dudes;
    
    _drophelo land "NONE";
  };

  [_newgrp,_dest]spawn {

    private ["_grp","_dest","_wp"];
    _grp = _this select 0;
    _dest = _this select 1;
    
    //landing
    waituntil {sleep 2; (vehicle (leader _grp)) == (leader _grp)};

    uisleep 40;

    if(!isnil "Hz_AI_moveAndCapture") then {
      
      [_grp, _dest] call Hz_AI_moveAndCapture;       
      
    } else {
      
      _wp = _grp addWaypoint [_dest,20];
      _wp setWaypointType "SAD";
      
    };
    _grp setformation "DIAMOND";
    
  };

  sleep 2;
  _drophelo flyinheight 200;
  _drophelo doMove _spawnpos;

  waitUntil {sleep 30; _helopilot doMove _spawnpos; _drophelo distance _spawnpos < 2000 || !canMove _drophelo || !alive _helopilot};

  _exit = false;
  if (!alive _helopilot) then {

    sleep 60;
    if (!alive _drophelo) then {_exit = true;} else {sleep 600};

  };

  if(_exit) exitwith {};

  { _x action ["EJECT", vehicle _x]; sleep 0.2; deleteVehicle _x; } forEach (crew _drophelo);
  deleteVehicle _drophelo;
  deleteGroup _drophelogrp;

};

units _helogrp