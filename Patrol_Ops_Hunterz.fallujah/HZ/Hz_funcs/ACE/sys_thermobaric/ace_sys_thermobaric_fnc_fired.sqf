//Hunter: error was in line 55 (52 in original script). "pos" was accidentally made global


#include "script_component.hpp"
#define __cfg configFile >> "CfgAmmo" >> _ammo
#define __vcfg configFile >> "cfgVehicles" >> typeof _cur

private ["_ammo","_bullet"];

PARAMS_2(_unit,_weapon);
_ammo = _this select 4;
_bullet = _this select 6;

if (isNull _bullet) exitwith {};

[_bullet,_weapon,_unit,_ammo,velocity _bullet] spawn {
	private ["_cur","_objV","_obj","_b","_aliveobj","_posASL","_pos","_spd","_posb","_posASLb","_d","_dst"];
	PARAMS_5(_bullet,_weapon,_unit,_ammo,_vel);

	_pos = [0,0,0];
	_posASL = [0,0,0];
	//_spd = 0;

	_d = 1.5*getNumber(__cfg>>"indirecthitrange");
	// *** tracking rocket pos and velocity ***

	while { alive _bullet } do
	{
		_pos = getPos _bullet; //_bullet modeltoWorld [0,_ahead,0];
		_posASL = getPosASL _bullet;
		if ((velocity _bullet) call ACE_fnc_magnitude > 10) then
		{
			_vel = velocity _bullet;
			//_spd = _vel call ACE_fnc_magnitude;
		};
		sleep 0.001;
	};

	// creating a follower bullet to precisely find the impact point
	// (as missiles have long models)

		_b = "ace_at_tracker" createvehiclelocal [_pos select 0,_pos select 1,1000+(_pos select 2)];
		_b setvelocity _vel;
		_b setposASL _posASL;
		_posb = [0,0,0];
		_posASLb = [0,0,0];
		while {alive _b} do
		{
			sleep 0.0001;
			_posb = getpos _b;
			_posASLb = getPosASL _b;
			//hint format ["pos %1 vel %2",_pos,_vel];
			//sleep 0.001;
		};
		if (_pos distance _posb > 3) then {_posb = _pos;_posASLb = _posASL};

	// prevent splosions of replaced ATGM's near shooter
	if (_posb distance _unit < 10) exitwith {};

	_obj = _posb nearEntities ["CaManBase",_d]; 
	_objV = _posb nearEntities [["StaticWeapon","Car","Motorcycle","Tank","Boat"],_d];
	_aliveobj = [];
	{ if (alive _x) then {_aliveobj set [(count _aliveobj),[_x,_x distance _posb]]} } foreach _obj;
	{
		_cur = _x;
		if (getNumber(__vcfg >> "ACE_NBC_Protection") == 0) then
		{
			_dst = _cur distance _posb;
			{ if (alive _x) then {_aliveobj set [(count _aliveobj),[_x,_dst min (_x distance _posb)]]} } foreach (crew _cur);
		};
	} foreach _objV;

	if (count _aliveobj > 0) then
	{
		[QGVAR(handle_injure), [_aliveobj,_d]] call CBA_fnc_globalEvent;
	};

	//diag_log _aliveobj;
};