if(Hz_sleep_mutex) exitwith {};
Hz_sleep_mutex = true;

private ["_exit","_ready","_hour","_min"];
Hz_sleep_ok = nil;

if((count playableunits) < 4) exitwith {hint "There must be at least 4 players alive on the server to sleep!";};       

if(isServer) then {

_hour = date select 3;    
_min = date select 4;

if (((_hour >= 18) && (_min >= 30)) || (_hour <= 4)) then {Hz_sleep_ok = true;} else {Hz_sleep_ok = false;};    
publicvariable "Hz_sleep_ok";

{_x setvariable ["Hz_ready_for_sleep",false,true];} foreach playableunits;

sleep 20;

_exit = false;
{_ready = _x getvariable ["Hz_ready_for_sleep",false]; if(!_ready) exitwith {_exit = true;};} foreach playableunits;
if(_exit) exitwith {};

[-2, {skiptime 10;}] call CBA_fnc_globalExecute; 

            
} else {    

waituntil {!isnil "Hz_sleep_ok"};    
    
if (!Hz_sleep_ok) exitwith {hint "You can only sleep between  1830h and 0400h!";};
hint "Warning! All players must have their tent deployed and be next to them to sleep.";

waituntil {!isnil {player getvariable "Hz_ready_for_sleep"}};
waituntil {!(player getvariable "Hz_ready_for_sleep")};

//Tent destroyed/doesn't exist?
if(isnil "mps_rallypoint_tent" || (!alive mps_rallypoint_tent)) exitwith {hint "You don't have a tent!";};
if((player distance mps_rallypoint_tent) > 15) exitwith {hint "You are too far away from your tent!";};

player setvariable ["Hz_ready_for_sleep",true,true];

};

Hz_sleep_mutex = false;