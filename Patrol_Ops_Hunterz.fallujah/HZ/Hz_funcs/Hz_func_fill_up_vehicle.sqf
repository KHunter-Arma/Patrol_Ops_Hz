
private ["_type","_unit","_veh","_passengertypes","_driver","_group","_count"];
_veh = _this select 0;
_passengertypes = _this select 1;

_driver = driver _veh;
_group = group _driver;

_count = _veh emptyPositions "cargo";

if(_count < 1) exitwith {};

for "_i" from 1 to _count do {
    
_type = _passengertypes call mps_getrandomelement;
_unit = _group createUnit [_type, [-1000,-1000,0],[],50,"FORM"];

_unit assignascargo _veh;
_unit moveincargo _veh;

//add unit to cleanup array
patrol_task_units set [count patrol_task_units, _unit];

};

(units _group) allowgetin true;
(units _group) orderGetIn true;

