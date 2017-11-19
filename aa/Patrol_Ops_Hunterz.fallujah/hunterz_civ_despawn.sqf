  /*
!!!!Execute upon both activation and deactivation!!!!
*/

//If trigger will stay switched on for an extended period of time, might need an external script to monitor if all civs are still alive and update civtotal.

#define SAFE_DISTANCE_FOR_SPAWN 300
#define CIV_KILLED_COUNT_BEFORE_RAGE 5000 //deprecated for now so keep it too high

//#define playableunits switchableunits

if (civ_debug) exitWith {_this spawn Hz_despawncivs;};

private ["_ForceSpawnAtHouses","_numinput","_mutex","_exit","_civarray","_num","_count","_newcivarray","_roadarr","_client","_civtype","_group","_civ","_road","_spawnpos","_buildings","_wait","_group1","_group2","_group3","_civgroups","_killcivs","_trigger","_pos","_radius","_ownerIDs"];

if (civ_debug) then {hint "inside main script";};

_trigger = _this select 0;
_pos = getpos _trigger;
_radius = (triggerArea _trigger) select 0;
_civarray = _trigger getVariable ["civarray",[]];
_mutex = _trigger getVariable ["mutex",true];
_ForceSpawnAtHouses = false;
_numinput = 0;

//optional, if true then use house positions to spawn civs instead of roads
if((count _this) > 1) then {_ForceSpawnAtHouses = _this select 1;};

//optional, for manual control of number of civs to spawn in area, rather than auto calculation.
if((count _this) > 2) then {_numinput = _this select 2;};


//if (civ_debug) then {sleep 4; [-1, {hint format ["%1",_this];}] call CBA_fnc_globalExecute; sleep 10;};

if (!isServer) exitwith {};
if(!Hz_civ_initdone) exitwith {};
if(!_mutex) exitwith {};

_exit = false;
if(!isnil "Hz_civ_global_safe") then {
  if(!Hz_civ_global_safe) exitwith {_exit = true;};
  Hz_civ_global_safe = false;
};
if(_exit) exitwith{};

_trigger setVariable ["mutex",false];

if (civ_debug) then {hint format ["%1",_pos];sleep 10;};

_ownerIDs = [];
if(Hz_civ_enable_client_processing) then {{_ownerIDs set [count _ownerIDs, owner _x];}foreach playableunits;};

	
	if (civ_debug) then {[-1, {hint "inside despawn script";}] call CBA_fnc_globalExecute; sleep 10;};
  //Subtract civarray from total
  _count = count _civarray;
  civtotal = civtotal - _count;

  //Clean civarray; delete all civilians that are alive. Leave the already dead for added ambiance. 

  _killcivs = [];
  {if(alive _x) then {_killcivs set [count _killcivs,_x];};}foreach _civarray;

  //{_x setdamage 1;}foreach _killcivs;
  {deletevehicle _x; deletegroup (group _x);} foreach _killcivs;

  _civarray = [];	
	
	if (civ_debug) then {sleep 4; [-1, {hint format ["Script done. returned civarray: %1",_civarray];}] call CBA_fnc_globalExecute; sleep 5;};

_trigger setVariable ["civarray",_civarray];
_trigger setVariable ["mutex",true];

publicvariable "civtotal";

if(!isnil "Hz_civ_global_safe") then {Hz_civ_global_safe = true;};