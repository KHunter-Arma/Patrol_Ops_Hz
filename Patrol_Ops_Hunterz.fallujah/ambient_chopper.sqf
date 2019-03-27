_type = _this select 0;
_target = _this select 1;

_grp = createGroup west;

_chopper = ([[15000,-25000,150], 0, _type, _grp] call BIS_fnc_spawnVehicle) select 0;

ambient_chopper = _chopper;

sleep 1;

_grp setCombatMode "WHITE";
_grp setBehaviour "CARELESS";
_grp deleteGroupWhenEmpty true;

_chopper disableAI "FSM";
_chopper disableAI "AUTOCOMBAT";
_chopper disableAI "TARGET";
_chopper disableAI "AUTOTARGET";

clearItemCargoGlobal _chopper;
clearWeaponCargoGlobal _chopper;
clearMagazineCargoGlobal _chopper;
clearBackpackCargoGlobal _chopper;
_chopper lockDriver true;
{

	_chopper lockTurret [_x,true];

} foreach allTurrets [_chopper, false];

_chopper flyInHeight 150;
_chopper doMove _target;

sleep 15;

waitUntil {sleep 0.5; unitReady _chopper};

_chopper land "LAND";

sleep (300 + (random 3600));

_chopper doMove [15000, 25000,10000];

sleep 300;
			
{

	deletevehicle _x;

} foreach crew _chopper;

deleteVehicle _chopper;