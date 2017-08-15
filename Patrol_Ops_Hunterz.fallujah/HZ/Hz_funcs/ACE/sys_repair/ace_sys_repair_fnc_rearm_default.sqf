// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private["_type", "_weapons", "_magazines", "_addMags", "_remMags", "_hash", "_hash2", "_repairTime", "_endTime", "_complete"];
PARAMS_2(_veh,_repairVeh);

_type = typeOf _veh;
_repairTime = 15;
_turretWeapons = [];
_turretmagazines = [];

// TODO: Turret handling.. For now only MainTurret
// TODO: What if unit has custom loadout?
// TODO: Progress display ?
/*
if (isClass(configFile >> "CfgVehicles" >> _type >> "Turrets" >> "MainTurret")) then {
	_weapons = getArray(configFile >> "CfgVehicles" >> _type >> "Turrets" >> "MainTurret" >> "weapons");
	_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "Turrets" >> "MainTurret" >> "magazines");
} else {
	_weapons = getArray(configFile >> "CfgVehicles" >> _type >> "weapons");
	_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");
};
*/

//  Lets Build a magazines and weapons array that includes all Turrets -VM
//  Index 0 = main weapons & magazines, Index 1 = first turret set of weaps & mags, Index 2 = second set of weaps & mags, and so on -VM

_cfg = (configFile>>"cfgVehicles" >> _type);
_turretWeapons = _turretWeapons + [getArray (_cfg >> "weapons")]; // TurretPath [-1] is the pilots turret 
_turretmagazines = _turretmagazines + [getArray (_cfg >> "magazines")];
_numTurrets = count (configFile>>"cfgVehicles" >> _type >> "Turrets");

for "_i" from 0 to (_numTurrets - 1) do {
	_cfg = (configFile>>"cfgVehicles" >> _type >> "Turrets") select _i;
	_turretWeapons = _turretWeapons + [getArray (_cfg >> "weapons")];
	_turretmagazines = _turretmagazines + [getArray (_cfg >> "magazines")];
};

//Add repair time based on Number of Weapon Mounts for now. 
{
	repairTime= _repairTime + ((Count _x) * 15);
} foreach _turretWeapons;
	  
//VM: Debug 
//VM: Need to pick good test vehicles. Armor, Fixed-Wing and Helos 
//VM: Armor: BMP3, BTR60_TK_EP1, BTR90, M2A2 
//VM: Fixed-Wing: A10,SU25
//VM: Helos: Cobra, Apache, Havoc  (Check Flares and Secondary Missiles)
TRACE_2("AllWeaps&Mags",_weapons,_magazines);
TRACE_2("AllTurretWeaps&Mags",_turretWeapons,_turretmagazines);
// vm_GVAR(weapons) = _weapons;
// vm_GVAR(magazines) = _magazines; LOG(vm_GVAR(magazines));


// TODO: are those hashes still valid ? They are not used anywhere
//VM: TODO - Upgrade this HASH to handle muti-dimensional arrays. 
_hash = [[], 0] call CBA_fnc_hashCreate;
{ [_hash, _x, ([_hash, _x] call CBA_fnc_hashGet) + 1] call CBA_fnc_hashSet } forEach _magazines;
_hash2 = [[], 0] call CBA_fnc_hashCreate;
{ [_hash2, _x, ([_hash2, _x] call CBA_fnc_hashGet) + 1] call CBA_fnc_hashSet } forEach (magazines _veh);

//VM: TODO: Review this Hash is not negatively effected by the added Mulitple Turret Support 
//TRACE_2("HasTables",_hash,_hash2);


// ***
// ***  Determine Actually Number of Mags to Reload and Calculate the Reload Time Duration
// ***

/*
_addMags = [];_remMags = [];
[_hash, {
	_value2 = [_hash2, _key] call CBA_fnc_hashGet;
	// Fix for last magazine with few rounds left :)
	if (_value2 == 1) then {
		PUSH(_remMags,_key);
		_value2 = 0;
	};
	if (_value > _value2) then {
		for "_i" from 1 to (_value - _value2) do {
			TRACE_2("addMagazine",_veh,_key);
			PUSH(_addMags,_key);
			ADD(_repairTime,getNumber(configFile >> "CfgMagazines" >> _key >> QGVAR(time)));
		};
	};
}] call CBA_fnc_hashEachPair;
*/

//VM: TODO: Review this Hash is not negatively effected by the added Mulitple Turret Support 
//TRACE_2("HasTables",_hash,_hash2);
//TRACE_2("WhatToAdd",_addMags,_remMags);

_repairTime = ceil _repairTime;

// if (_repairTime == "scalar") then do { _repairTime =10; };
if (_repairTime == 0) exitWith { hint format [localize "STR_ACE_REARM_NO", _veh]; };

//VM: DEBUG RepairTime (actually ReArm Time)
//_repairTime = 3;

// ***
// ***  Check if the Vehicle _veh is already busy being serviced by another Ammo Truck.  If not mark it busy. 
// ***

if (_veh getVariable [QGVAR(rearm_busy), false] && {(_veh getVariable [QGVAR(rearm_busyState), 0]) <= time}) exitWith { hint "Busy already..." };
[QGVAR(setBusyRea), [_veh, _repairTime]] call CBA_fnc_globalEvent;


hint format[localize "STR_ACE_REARM_TIME", _repairTime, _veh];
_complete = false;
_endTime = time + _repairTime;
[_repairTime, [localize "STR_CFG_CUTSCENES_REARM"], false, false] spawn ace_progressbar;

// TODO: Re-arm in steps?
while {alive _repairVeh && {alive _veh} && {_veh distance _repairVeh < 15}} do {
	if (time > _endTime) exitWith { _complete = true };
	sleep 1;
};
// cancel progress bar


// ***
// ***  Handle the Service Station Results. Either Complete or Interrupted. 
// ***

if (_complete) then {

	[_veh] spawn FUNC(reload);

	/* // Rearm Main Weapons
	//[QGVAR(rearm), [_veh, _remMags, _addMags]] call CBA_fnc_globalEvent;
	
	// Rearm Turrets Weapons
	//TODO Move this into the AllInOne Global Rearm Event
	
	//remove all mags from the current turret _x
			_turretIndex=-1; // turret index initialization ,-1 equals the drivers turret. Need a conditional for non-helos
			{
				_setofMags = _x;
				for [{_i = 0},{_i < (count _setofMags)},{_i=_i+1}] do {
				_veh removeMagazinesTurret [(_setofMags select _i),[_turretIndex]];
				TRACE_2("Removing Turret Mags",_turretIndex,_setofMags select _i);
				};
				_turretIndex=_turretIndex+1; // Next Turret 
			} foreach (_turretmagazines);
			
		for [{_i = -1},{_i < _numTurrets+1},{_i=_i+1}] do 
		{
			
			_t=-1; // turret index initialization 
			//add all mags to current turret _x
			{
				
				If (_i == _t) then 
				{
					_setofMags = _x;
					{
						_mag = _x;
						_veh addMagazineTurret [_mag,[_i]];
						TRACE_2("Adding Turret Mag",_i,_mag);
					} foreach _setofMags;
				};
				_t=_t+1; // Next Turret 
			} foreach (_turretmagazines);
			
		};
		 */
	hint (localize "STR_ACE_REARM_SUCCESS");
} else {
	hint (localize "STR_ACE_REARM_NOSUCCESS_TOOFAR");
	// TODO: Still apply % vehicle rearm ?
};


[QGVAR(unsetBusyRea), _veh] call CBA_fnc_globalEvent;
