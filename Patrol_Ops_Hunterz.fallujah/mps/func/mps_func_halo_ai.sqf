private["_para_unit","_chuteopeneningaltitude","_vehicle","_pos"];

_para_unit = _this select 0;

if(_para_unit == player) exitWith{};

_chuteopeningaltitude = 150 + (random 100);

_para_unit switchMove "HaloFreeFall_non";

while { alive _para_unit && vehicle _para_unit == _para_unit && ( (position _para_unit) select 2) > _chuteopeningaltitude } do { sleep 1; };

_vehicle = createVehicle ["BIS_Steerable_Parachute", position _para_unit,[],0,"FLY"];

_pos = [position _para_unit select 0, position _para_unit select 1, (position _para_unit select 2)];
_vehicle setPos _pos;
_para_unit moveInCargo _vehicle;

_vehicle setVelocity _vel;
_para_unit setVelocity _vel;

[_vehicle, _para_unit] execVM "ca\air2\halo\data\Scripts\Parachute_AI.sqf";

waituntil { ((position _vehicle) select 2) < 2};

deleteVehicle _vehicle;

if(true)exitWith{};