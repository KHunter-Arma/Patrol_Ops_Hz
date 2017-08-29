// AI_respawn_UPS.sqf
// © JULY 2009 - norrin


private ["_unit","_group","_lives","_delay","_respawn_point","_marker","_side","_AI_unitArray","_AI_magArray","_AI_wepArray","_unitsGroup","_remainingUnits","_wait","_loop","_guy","_leader","_tick"];
if (!isServer) exitWith {};

_unit 			= _this select 0;
_lives			= _this select 1;
_delay 			= _this select 2;
_respawn_point	= _this select 3;
_marker	= _this select 4;
_group			= _this select 5;
_side 			= _this select 6;
_AI_unitArray	= _this select 7;
_AI_magArray	= _this select 8;
_AI_wepArray	= _this select 9;
_tick = _this select 10;
//_grouphasveh = _this select 11;


_unitsGroup = units (group _unit);

while {(count _unitsGroup) > 0} do
{	
        _remainingUnits = [];
	{if(!isnull _x) then {if (alive _x) then {_remainingUnits set [count _remainingUnits, _x];};};} forEach _unitsGroup;
	_unitsGroup = _remainingUnits;
	sleep 10;
        
        //auto-refresh for fail-safe... I've witnessed AI that fall in the river and not drown and stay unconscious... wtf
        if((time - _tick) > 43200) then {
            
         //reset timer if not actually patrolling but doing some other useful thing       
         if (_group getvariable ["Hz_supporting",false]) then {
             
         _tick = time;        
             
        } else {
            
        {_x setdamage 1;}foreach _unitsGroup;    
                
        };  
        
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
if(_side == west) then {_wait = 6;};

waituntil {sleep _wait; (((count allunits) < Hz_max_ambient_units) && (!missionload) && (({isplayer _x} count nearestObjects[(getMarkerPos _respawn_point),["CAManBase"],1000] < 1) || hz_debug))};

_group = createGroup _side; 

{
_guy = _group createUnit [_x,(getMarkerPos _respawn_point), [], 100, "FORM"];

} forEach _AI_unitArray;

_group setvariable ["Hz_Patrolling",true];

//hint "AI respawned";
_unitsGroup = units _group;
for [{ _loop = 0 },{ _loop < count  _unitsGroup},{ _loop = _loop + 1}] do
{
        
	_guy = _unitsGroup select _loop;
	removeAllWeapons _guy;
	{_guy removeMagazine _x} forEach magazines _guy;
	removeAllItems _guy;
	{_guy addMagazine _x} forEach (_AI_magArray select _loop);
	{_guy addWeapon _x}   forEach (_AI_wepArray select _loop);
	_guy selectWeapon (primaryWeapon _guy);
	sleep 0.01;
};

_leader = leader _group;
[_leader, _lives, _delay, _respawn_point, _marker, _group, _side, _AI_unitArray,_AI_magArray, _AI_wepArray,time] execVM "AI_respawn_UPS\AI_respawn_UPS.sqf"; 	
[_leader, _marker] execVM "AI_respawn_UPS\UPS_init.sqf";

UPS_respawn_calls = UPS_respawn_calls + 1;
publicvariable "UPS_respawn_calls";

if (true) exitWith {};

 

