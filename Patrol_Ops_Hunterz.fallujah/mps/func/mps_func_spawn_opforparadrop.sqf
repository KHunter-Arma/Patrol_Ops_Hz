// Many Parts Written by ArmA Community
// Combined together by EightySix

private ["_helogrp","_spawnpos","_dest","_paradrop","_flyin","_droptype","_invisibleTarget","_helo","_drophelo","_drophelogrp","_helopilot","_radarreinforcements","_radargroup","_type","_unit","_count","_string"];

waituntil {!isnil "bis_fnc_init"};

if( count mps_opfor_ncoh == 0 ) exitWith{};

_helogrp = _this select 0;
//_spawnpos = (_this select 1) call mps_get_position; sleep 1;
_spawnpos = [-5000,10000,0];

_dest = (_this select 2) call mps_get_position;
_paradrop = false;
if(count _this > 3) then { _paradrop = _this select 3};

_flyin = 200;
_droptype = (mps_opfor_ncoh) call mps_getRandomElement;
_invisibleTarget = "HeliHEmpty" createVehiclelocal _dest;


if(_droptype isKindof "Plane") then { _paradrop = true };

_dest = [_dest, 0, 200, 10, 0, .5, 0] call BIS_fnc_findSafePos; 
_string = format _dest; if (!isNil "_string") then { _invisibleTarget setPos _dest; };

_helo = [ [_spawnpos select 0, _spawnpos select 1, _flyin], random 360, _droptype, (SIDE_B select 0)] call BIS_fnc_spawnVehicle;

_drophelo = _helo select 0;
_drophelogrp = _helo select 2;
(group _drophelo) setvariable ["Hz_supporting",true];

sleep 1;

_drophelo setvehiclelock "locked";

if(count (units _helogrp) == 0) then {
    
    //_helogrp = [_spawnpos,"INF",(8 + random 5),10] call CREATE_OPFOR_SQUAD; 

    _count = _drophelo emptyPositions "cargo";

    for "_i" from 1 to _count do {
    
        _type = mps_opfor_inf call BIS_fnc_selectRandom;
        _unit = _helogrp createUnit [_type, [-1000,-1000,0],[],50,"FORM"];

        //set skill
        _unit call Hz_func_AI_SetSkill;

        _unit assignascargo _drophelo;
        _unit moveincargo _drophelo;

    };

    (units _helogrp) allowgetin true;
    (units _helogrp) orderGetIn true;

};



_drophelo setDammage 0;
_drophelo setFuel 1;
_helopilot = driver _drophelo;
_helopilot setSkill 1;
_helopilot disableAI "TARGET";
_helopilot disableAI "AUTOTARGET";

{_x assignAsCargo _drophelo; _x moveInCargo _drophelo} forEach (Units _helogrp);

{ if(vehicle _x == _x) then { _x setDamage 1; }; }forEach (units _helogrp);

if (!isEngineOn _drophelo && alive _helopilot) then {
    if (!canMove _drophelo) then {
        _drophelo setDammage 0;
        _drophelo setFuel 1;
        sleep 1; 
    }; 
    _helopilot action ["engineOn", vehicle _helopilot];
};

_drophelo flyinheight 200;
_helopilot doMove _dest;

waitUntil { _drophelo distance _dest <= 650 || !canMove _drophelo || !alive _helopilot };

_newgrp = creategroup (SIDE_B select 0);
sleep 0.1;
_newgrp setvariable ["Hz_attacking",true];
_dudes = units _helogrp;

if(_paradrop || !(toupper (behaviour _helopilot) IN ["CARELESS","SAFE","AWARE"]) ) then {
            
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
};

    [_newgrp,_dest]spawn {

        private ["_grp","_dest","_wp"];
        _grp = _this select 0;
        _dest = _this select 1;
        
        //landing
        waituntil {sleep 2; (vehicle (leader _grp)) == (leader _grp)};

        uisleep 40;

        if(!isnil "Hz_AI_moveAndCapture") then {
                    
            [_grp, _dest,false] call Hz_AI_moveAndCapture;       
                    
        } else {
                    
            _wp = _grp addWaypoint [_dest,20];
            _wp setWaypointType "SAD";
                   
        };
        _grp setformation "DIAMOND";
    
    };

_drophelo land "NONE";
sleep 2;
_helopilot doMove _spawnpos;

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