// AIvcl_respawn_UPS.sqf
// © JULY 2009 - norrin
#define HZ_DEBUG(X) if(hz_debug_patrols) then {hint X;}

private ["_unit","_lives","_delay","_respawn_point","_group","_marker","_crew","_side","_AI_unitArray","_escort","_type","_unitsGroup","_dir","_vehicle","_vehistank","_isair","_remainingUnits","_wait","_respawnzone","_vcl_new","_dude","_guy","_loop","_leader","_tick"];
if (!isServer) exitWith {};

_unit 			= _this select 0;
_lives			= _this select 1;
_delay 			= _this select 2;
_respawn_point      	= _this select 3;
_marker			= _this select 4;
_crew			= _this select 5;
_side 			= _this select 6;
_AI_unitArray	= _this select 7;
_escort = _this select 8;
_tick = _this select 9;

_type = typeOf vehicle _unit;
_group	= group _unit;
_unitsGroup = units (group _unit);
_dir = getDir _unit;

_vehicle = vehicle _unit;
_crew = crew _vehicle;
_vehicle setvehiclelock "LOCKED";
_vehistank = false;
_isair = false;

_respawnzone = [(((markerPos _respawn_point) select 0) + (random 100)),(((markerPos _respawn_point) select 1) + (random 100)),0];

if(_vehicle iskindof "Air") then {_isair = true;};

if ((count _escort) > 0) then {

    _vehistank = true;
};

while {({alive _x} count _unitsGroup) > 0} do
{
	sleep 10;
        
        //auto-refresh for fail-safe... I've witnessed AI that fall in the river and not drown and stay unconscious... wtf
        if((time - _tick) > 21600) then {
            
         //reset timer if not actually patrolling but doing some other useful thing       
         if (_group getvariable ["Hz_supporting",false]) then {
             
         _tick = time;        
             
        } else {
            
        {_x setdamage 1;}foreach _unitsGroup;    
                
        };  
        
        };
        
};


if((toupper _type) == "AH64D_EP1") then {sleep (random 43200);};

if (alive _vehicle) then {
    
      _vehicle spawn {
        //  _vehicle = _this;
       //   sleep 30;
      //    _vehicle setdamage 0.8;
          
         waituntil {sleep 30; ({ isplayer _x} count nearestObjects[getpos _this,["CAManBase"],100]) == 0}; 
          
      //_vehicle setdamage 1;
      deletevehicle _this;
      
      };

};


deleteGroup _group;
if (_lives == 0) exitWith {};
_lives = _lives - 1;

/*

_wait = (random _delay); // add some randomness
//_wait = Time + _delay
//waitUntil {Time > _wait};
sleep _wait;


*/

_wait = 6;
if(_side == west) then {_wait = 9;};

waituntil {sleep _wait; (((count allunits) < Hz_max_ambient_units) && (!missionload) && (({isplayer _x} count nearestObjects[_respawnzone,["CAManBase"],5000] < 1) || hz_debug)) };

if(_isair) then {sleep (random 120);};

_vcl_new = objNull;

if (_vehistank) then {
_group = createGroup _side;

  {
        _dude = _group createUnit [_x,_respawnzone, [], 100, "FORM"];
        } foreach _escort;
 
_group setvariable ["Hz_Patrolling",true]; 
 
_vcl_new = _type createVehicle _respawnzone;
_vcl_new setDir _dir;
_vcl_new setvehiclelock "LOCKED";

sleep 1;

{
        _guy = _group createUnit [_x,_respawnzone, [], 100, "FORM"];

        switch (true) do {
        
        case ((_vcl_new emptyPositions "Driver") > 0) : { _guy assignasDriver _vcl_new; [_guy] orderGetIn true; _guy moveinDriver _vcl_new;};
        case ((_vcl_new emptyPositions "Gunner") > 0) : {_guy assignasGunner _vcl_new; [_guy] orderGetIn true; _guy moveinGunner _vcl_new;};	
        case ((_vcl_new emptyPositions "Commander") > 0) : {_guy assignasCommander _vcl_new; [_guy] orderGetIn true; _guy moveinCommander _vcl_new;};
        default {_guy moveInTurret [_vcl_new,[0,1]];};
        
        };
        sleep 0.01;
  } forEach _AI_unitArray; 


} else {
    
_group = createGroup _side;


_vcl_new = _type createVehicle _respawnzone;
_vcl_new setDir _dir;
_vcl_new setvehiclelock "LOCKED";

if(_type == "CH_47F_EP1") then {

_vcl_new setvariable ["Turret0",true];
_vcl_new setvariable ["Turret1",true];

};

if(_type == "UH60M_EP1") then {

_vcl_new setvariable ["Turret1",true];

};

sleep 1;

{//_x createUnit [_respawnzone, _group];
_group createUnit [_x,_respawnzone, [], 100, "FORM"];
sleep 0.1;
} forEach _AI_unitArray;

_unitsGroup = units _group;

for [{ _loop = 0 },{ _loop < count  _unitsGroup},{ _loop = _loop + 1}] do
{	
	_guy = _unitsGroup select _loop;
        
        switch (true) do {
        
        case ((_vcl_new emptyPositions "Driver") > 0) : { _guy assignasDriver _vcl_new; [_guy] orderGetIn true; _guy moveinDriver _vcl_new;};
        case ((_vcl_new emptyPositions "Gunner") > 0) : {_guy assignasGunner _vcl_new; [_guy] orderGetIn true; _guy moveinGunner _vcl_new;};	
        case ((_vcl_new emptyPositions "Commander") > 0) : {_guy assignasCommander _vcl_new; [_guy] orderGetIn true; _guy moveinCommander _vcl_new;};
        case (_vcl_new getvariable ["Turret0",false]) : {[_guy] orderGetIn true; _guy moveinturret [_vcl_new,[0]]; _vcl_new setvariable ["Turret0",false];};
        case (_vcl_new getvariable ["Turret1",false]) : {[_guy] orderGetIn true; _guy moveinturret [_vcl_new,[1]]; _vcl_new setvariable ["Turret1",false];};
        case (_vcl_new getvariable ["Turret2",false]) : {[_guy] orderGetIn true; _guy moveinturret [_vcl_new,[2]]; _vcl_new setvariable ["Turret2",false];};
        default {_guy assignascargo _vcl_new; [_guy] orderGetIn true; _guy moveincargo _vcl_new;};
        
        };
        
	sleep 0.1;
};

};


_leader = leader _group;
_group setFormation "STAG COLUMN";
_group setSpeedMode "NORMAL";
_group setCombatMode "SAFE";

[_vcl_new, _lives, _delay, _respawn_point, _marker, _crew, _side, _AI_unitArray,_escort,time] execVM "AIvcl_respawn_UPS\AIvcl_respawn_UPS.sqf";
[_leader, _marker,_isair] execVM "AIvcl_respawn_UPS\UPSvcl_init.sqf";

UPS_vcl_respawn_calls = UPS_vcl_respawn_calls + 1;
publicvariable "UPS_vcl_respawn_calls";

if (true) exitWith {};