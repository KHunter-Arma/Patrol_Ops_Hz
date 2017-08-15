//  UPS_init.sqf
// © JULY 2009 - norrin

private ["_unit","_marker","_isair","_vehicle","_group","_passengerarr","_moveto","_driver","_leader","_rndx","_rndy","_flightgrp"];

_unit 	= _this select 0;
_marker	= _this select 1;
_isair = _this select 2;
_group = group _unit;
_vehicle = vehicle (leader _group);


if(!_isair) then {[_group,_marker,"SHOWMARKER"] spawn Hz_AI_UPS_Hz;} else {

    
_group setvariable ["Hz_patrolling",true];        
            
_passengerarr = [];   

{
   // if (_vehicle iskindof "AH64_base_EP1") exitwith {};
        
            if((_x != (driver _vehicle)) && (_x != (gunner _vehicle)) && (_x != (commander _vehicle))) then {
            _passengerarr = _passengerarr + [_x];
        };}foreach crew _vehicle;
        
       // if (_vehicle iskindof "CH_47F_EP1") then {_passengerarr = _passengerarr - [_passengerarr select 0];};
       
_rndx = 0;
_rndy = 0;
if(random 1 < 0.5) then {_rndx = -1;} else {_rndx = 1;};
if(random 1 < 0.5) then {_rndy = -1;} else {_rndy = 1;};

_moveto = [(markerpos "LZ" select 0) + (_rndx * (random 60)),(markerpos "LZ" select 1) + (_rndy * (random 30))];
_unit domove _moveto;
_unit setspeedmode "FULL";
_unit setCombatMode "RED";
_unit setBehaviour "CARELESS";

if (count _passengerarr > 0) then {
 
//remove crew chief     
_passengerarr = _passengerarr - [_passengerarr select 0];
//remove tail gunner
if(_vehicle iskindof "CH_47F_EP1" || _vehicle iskindof "CH_47F_BAF") then {_passengerarr = _passengerarr - [_passengerarr select 0];};

_driver = (driver _vehicle);
_driver setrank "colonel";
_driver disableai "autotarget";
_driver disableai "target";
//_driver disableai "fsm";


while { ( (alive _vehicle) && !(unitReady _vehicle) ) } do
{
       sleep 1;
};

if (alive _vehicle) then
{
       _vehicle land "GET OUT";
};


/*
waituntil {sleep 1; ((!alive _driver ) || (!alive _vehicle )|| (_moveto distance _vehicle < 100))};
_unit setspeedmode "LIMITED";
_unit setCombatMode "YELLOW";
_unit setBehaviour "COMBAT";

_vehicle forcespeed 30;

if((!alive _driver ) || (!alive _vehicle )) exitwith {_driver enableai "autotarget";_driver enableai "target";_driver enableai "fsm";};
_unit domove _moveto;
sleep 10;
//waituntil {_vehicle land "GET OUT"; _height1 = (getposatl _vehicle) select 2; if (_height1 < 5) exitwith {true}; sleep 3; if ((getposatl _vehicle) select 2 < 5) exitwith {true}; sleep 3; if ((getposatl _vehicle) select 2 < 5) exitwith {true}; sleep 3;  _height2 = (getposatl _vehicle) select 2; if (_height2 < 5) exitwith {true}; if( abs(_height1 - _height2) < 1) then {_unit domove (markerpos "ao_centre"); sleep 15;_unit domove _moveto; sleep 10;}; ((getposatl _vehicle) select 2 < 5)};
if(_moveto distance _vehicle < 70) then {_vehicle land "GET OUT";};
while {((getposatl _vehicle) select 2) > 13} do {
if((speed _vehicle < 2) || (_moveto distance _vehicle > 70)) then {_unit domove (markerpos "ao_centre"); sleep 13;_unit domove _moveto;} else {sleep 2; _vehicle land "GET OUT";};
sleep 5;
};*/

_vehicle forcespeed 0;

_leader = leader _group;
_leader setCombatMode "RED";
_leader setBehaviour "COMBAT";

{ unassignVehicle _x; _x setunitpos "MIDDLE"; } forEach _passengerarr;
 dogetout _passengerarr;
 _passengerarr allowGetIn false; 
{_timeout = time + 5; waituntil {sleep 1; (((vehicle _x) == _x) || (!alive _x) || (!alive _driver) || (time > _timeout))};} foreach _passengerarr;

_vehicle forcespeed -1;
sleep 2;

if(((vehicle _driver) != _driver) && alive _driver) then {

    
    _vehicle domove (getpos _vehicle);
    //_driver enableai "autotarget";_driver enableai "target";_driver enableai "fsm";
    //_vehicle forcespeed -1;
    _flightgrp = creategroup west;
    (crew _vehicle) joinsilent _flightgrp;
    sleep 0.1;
    _flightgrp setvariable ["Hz_supporting",true];
    _driver setspeedmode "FULL";
    _driver setBehaviour "CARELESS";
    _flightgrp setcombatmode "YELLOW";
		sleep 1;
    _flightgrp move (markerpos "patrol_respawn_b_air");
    _vehicle domove (markerpos "patrol_respawn_b_air");

    [_group,_marker,"SHOWMARKER"] spawn Hz_AI_UPS_Hz;
		
		{_x setunitpos "AUTO"; } forEach _passengerarr;

    waituntil {sleep 2; !alive _driver || (_driver distance (markerpos "patrol_respawn_b_air") < 1000)};
    {deletevehicle _x;} foreach units _flightgrp;
    deletevehicle _vehicle;

    //shot down
    } else {
        
    _driver enableai "autotarget";
    _driver enableai "target";
    _driver setrank "private";
		
		{_x setunitpos "AUTO"; } forEach _passengerarr;
    
    [_group,_marker,"SHOWMARKER"] spawn Hz_AI_UPS_Hz;
    
 };

} else {

    
// CAS        
_vehicle flyinheight 500;
waituntil {sleep 1; (_moveto distance _vehicle) < 3000};
sleep 1;
_leader = leader _group;
_leader setSpeedMode "NORMAL";


               [_vehicle] spawn {
                
               private ["_wp","_helo1","_groupgrp1"];

                _helo1 = _this select 0;
                _groupgrp1 = group _helo1;
                sleep 5;
                
               _wp = _groupgrp1 addWaypoint [(markerpos "air_patrol_blufor"),700];
                _wp setWaypointType "SAD";
                sleep 300;
               
               while {(((getposatl _helo1) select 2) > 20)} do {
               
                deleteWaypoint _wp;
                _wp = _groupgrp1 addWaypoint [(markerpos "air_patrol_blufor2"),500];
                _wp setWaypointType "SAD";
                sleep 300;
                
                deleteWaypoint _wp;
                _wp = _groupgrp1 addWaypoint [(markerpos "air_patrol_blufor"),500];
                _wp setWaypointType "SAD";
                
                
                    };
                
                
                };

[_vehicle,5000] execvm "Hz\Hz_scripts\HZ_AI_CAS.sqf";

};

};


if (true) exitWith {};