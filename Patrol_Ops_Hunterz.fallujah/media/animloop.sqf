if(!isServer) exitwith {};

_unit = _this select 0;
_anim = _this select 1;
_pos = getPosATL _unit;
_dir = getdir _unit;

_unit disableai "TARGET";
_unit disableai "AUTOTARGET";
_unit disableai "MOVE";
_unit disableai "FSM";

_unit setVariable ["Hz_disableFSM",true];



/*

if (!isnil "_anim") then {

_unit setunitPos "UP";
(group _unit) setbehaviour "SAFE";
_unit playMove _anim;
sleep 5;

} else {
		
_unit setunitPos "UP";
if(_unit == repairdude) then {_unit setunitPos "MIDDLE";};
(group _unit) setbehaviour "SAFE";
sleep 2;

};
*/

//Animation loop
if (!isnil "_anim") then {

	_uncon = false;

	while {alive _unit} do {
	
		_unit setPosATL _pos;
		_unit setdir _dir;
		
		for "_x" from 1 to 5 do {
			
			_unit playMoveNow _anim;
			
			waitUntil {
			
				sleep 5;
				
				if (captive _unit) then {				
					_uncon = true;					
					true				
				} else {				
					animationState _unit != _anim				
				}
				
			};
			
			if (_uncon) exitWith {};
			
			_unit setunitPos "UP";
			
		};
		
		if (_uncon) exitWith {};			
			
	};
	
	_unit switchmove "";
	
	_unit enableAI "TARGET";
	_unit enableAI "AUTOTARGET";
	_unit enableAI "MOVE";
	_unit enableAI "FSM";
	
	_unit setVariable ["Hz_disableFSM",false];

} else {

	while {(alive _unit) && {!captive _unit}} do {
		
		_unit setunitPos "UP";
		(group _unit) setbehaviour "SAFE";
		sleep 30;
		
	};
	
	_unit switchmove "";

};