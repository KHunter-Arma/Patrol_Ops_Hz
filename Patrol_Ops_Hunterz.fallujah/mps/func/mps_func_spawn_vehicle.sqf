// Written by BON_IF
// Adpated by EightySix

private ["_type", "_pos", "_x", "_sideFaction", "_radius", "_side", "_faction", "_flying", "_Grp", "_y", "_spawnpos", "_count", "_crewTypes", "_sim", "_vec", "_dir", "_unit"];

_type = _this select 0;
_sideFaction = _this select 1;
_pos = _this select 2;
_radius = _this select 3;

_side = _sideFaction select 0;
_faction = _sideFaction select 1;

_flying = false;
if (_type iskindof "Air") then {
	_flying = true;
};

_Grp = grpNull;
if (count _this > 4) then {
	_Grp = _this select 4;
} else {
	_Grp = createGroup _side;
};

_x = _pos select 0;
_y = _pos select 1;

_spawnpos = [0,0];
_count = 0;
While{(surfaceIsWater _spawnpos || count (_spawnpos - [0]) == 0) && _count < 100} do {
	_spawnpos = [_x + _radius - random (_radius*2), _y + _radius - random (_radius*2)];
	_count = _count + 1;
};
if(_count == 100) exitWith{
	_Grp deleteGroupWhenEmpty true;
	_Grp
};
_spawnpos set [2,0];

_crewTypes = [];

if(_faction == (SIDE_B select 1)) then {

	switch (true) do {
		
		case _flying : {
			_crewTypes = mps_opfor_pilot;
		};
		
		case (_type isKindOf "Tank") : {
			_crewTypes = mps_opfor_crewmen;
		};
		
		default {
			_crewTypes = mps_opfor_riflemen;
		};
		
	};
	
} else {
	
	if (_faction == (SIDE_C select 1)) then {	
		_crewTypes = mps_opfor_ins_riflemen;	
	};
	
};

_sim = getText(configFile >> "CfgVehicles" >> _type >> "simulation");

_vec = objNull;
if (_flying) then {
	_spawnpos = [-20000,140000,1200];	
	_vec = createVehicle [_type,_spawnpos,[],0,"FLY"];
	_vec setPos _spawnpos;
	if (_sim == "airplanex") then {
		_dir = getDir _vec;
		_vec setVelocity [100 * (sin _dir), 100 * (cos _dir), 0];
	};
} else {
	_vec = _type createVehicle _spawnpos;
};

_vec setvehiclelock "LOCKED";

if((_vec emptyPositions "commander") > 0) then {
	_unit = _Grp createUnit [selectRandom _crewTypes, _pos, [], _radius, "NONE"];
	_unit assignasCommander _vec;
	[_unit] orderGetIn true;
	_unit moveinCommander _vec;
	_unit setrank "PRIVATE";
};

if((_vec emptyPositions "gunner") > 0) then {
	_unit = _Grp createUnit [selectRandom _crewTypes, _pos, [], _radius, "NONE"];
	_unit assignasGunner _vec;
	[_unit] orderGetIn true;
	_unit moveinGunner _vec;
	_unit setrank "PRIVATE";
};		

if((_vec emptyPositions "driver") > 0) then {
	_unit = _Grp createUnit [selectRandom _crewTypes, _pos, [], _radius, "NONE"];
	_unit assignasDriver _vec;
	[_unit] orderGetIn true;
	_unit moveinDriver _vec;
	_unit setrank "PRIVATE";     
};

{
	if (isNull (_vec turretUnit _x)) then {
		_unit = _Grp createUnit [selectRandom _crewTypes, _pos, [], _radius, "NONE"];
		_unit assignAsTurret [_vec, _x];
		[_unit] orderGetIn true;
		_unit moveInTurret [_vec, _x];
		_unit setrank "PRIVATE"; 
	};
} foreach (allTurrets [_vec, false]);

if (_flying) then {
	if(_vec iskindof "Plane") then {
		if ((_type in mps_opfor_lbomber) || (_type in mps_opfor_hbomber)) then {
			_vec flyinheight 1500;
		} else {
			_vec flyinheight 300;	
		};
	} else {    
		_vec flyinheight 100;
	};
	{
		_x addBackpack "ACE_NonSteerableParachute";
	} foreach crew _vec;
};

_Grp addVehicle _vec;


/*

// Cleanup

[_Grp,_vec] spawn {
    
	_grp = _this select 0;
	_units = units _grp;
	_veh = _this select 1;

	_vehpos = position _veh;

	While{ damage _veh < 1 && ({alive _x} count _units) > 0 } do { sleep 20; };

	while{ { alive _x && side _x == (SIDE_A select 0) } count nearestObjects[_vehpos,["CAManBase","LandVehicle"],800] > 0 } do { sleep 15; };
        
        sleep 600;
        _veh setdamage 0.9;
        sleep 1800;
        if (alive _veh) then {_veh setdamage 0.98; sleep 300;};
        
	deleteVehicle _veh;

	{
		hidebody _x;
		sleep 3;
		deleteVehicle _x;
	} foreach _units;

	sleep 5;

	deleteGroup _grp;
};
*/

_Grp deleteGroupWhenEmpty true;

_Grp
