if(!isServer) exitwith {};

_unit = _this select 0;
_anim = _this select 1;
_pos = getPos _unit;
_dir = getdir _unit;

_unit disableai "TARGET";
_unit disableai "AUTOTARGET";
_unit disableai "MOVE";
_unit disableai "FSM";



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

_pos = getPos _unit;
_dir = getdir _unit;

if (!isnil "_anim") then {

while{alive _unit}do{
    
        for "_x" from 1 to 5 do {
            
	_unit playMove _anim;
	waitUntil{animationState _unit != _anim};
        _unit setunitPos "UP";
        sleep 7;
        };
        _unit setPos _pos;
        _unit setdir _dir;
};

} else {

while{alive _unit}do{
    
        _unit setunitPos "UP";
        (group _unit) setbehaviour "SAFE";
        sleep 30;
       
};

};