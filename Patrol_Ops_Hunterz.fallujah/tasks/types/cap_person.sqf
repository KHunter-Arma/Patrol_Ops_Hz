
private ["_location","_position","_taskid","_grp","_object","_troops","_b","_car_type","_vehgrp","_reinforcementsMinimumSpawnRange","_r","_tempos","_grppat","_Vehsupport","_vehicletypes","_otherReward","_grpdef","_grpgar","_deathPenalty","_minDefendingSquadCount","_maxDefendingSquadCount","_DefenseRadius","_minGarrisonedSquadCount","_maxGarrisonedSquadCount","_minPatrollingSquadCount","_maxPatrollingSquadCount","_minStaticWeapon","_maxStaticWeapon","_CASchance","_TankChance","_IFVchance","_AAchance","_CarChance","_SniperChance","_TowerChance","_rewardmultiplier","_staticguns","_c","_d"];
diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Capture Target Initialise"];

/*-------------------- TASK PARAMS ---------------------------------*/
_reinforcementsMinimumSpawnRange = 5000;

_minDefendingSquadCount = 2;
_maxDefendingSquadCount = 5;
_DefenseRadius = 200;

_minGarrisonedSquadCount = 0;
_maxGarrisonedSquadCount = 3;

_minPatrollingSquadCount = 0;
_maxPatrollingSquadCount = 2;

_minStaticWeapon = 0;
_maxStaticWeapon = 3;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0.1;
_TankChance = 0.2;
_IFVchance = 0.2;
_AAchance = 0.3;
_CarChance = 0.7;

//Others
_SniperChance = 0;
_TowerChance = 0.5;

//Useful for justifying task-specific difficulties.
_rewardmultiplier = 1.25;
/*--------------------CREATE LOCATION---------------------------------*/

_location = [["towns","StrongpointArea"]] call mps_getNewLocation;
_position = [(position _location) select 0,(position _location) select 1, 0];
_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

/*--------------------CREATE TARGET-----------------------------------*/

_grp = [_position,"TARGET",1,10] call CREATE_OPFOR_SQUAD; sleep 0.1;
_object = (units _grp) select 0;
_object setRank "PRIVATE";
_object setCaptive true;
removeAllWeapons _object;

[_object] spawn {
  private ["_man"];
  _man = _this select 0; _man allowdamage false; _man setvariable ["ace_w_allow_dam",0]; sleep 0.180; _man allowdamage true; _man setvariable ["ace_w_allow_dam",1];};

[nil, _object, "per", rADDACTION, (format ["<t color=""#FF0000"">Arrest %1</t>",name _object]),(mps_path+"action\mps_unit_join.sqf"), [], 1, true, true, "", ""] call RE;

/*--------------------MOVE TARGET TO LOCATION-------------------------*/

[(group _object),_position,"hide"] spawn mps_patrol_init;

/*--------------------CREATE ENEMY AT LOCATION------------------------*/

_troops = [];

_staticguns = _minStaticWeapon max (round (random _maxStaticWeapon));
if(_staticguns > 0) then {

  for "_i" from 1 to _staticguns do {

    _staticgrp = [_position] call CREATE_OPFOR_STATIC; 
    
    patrol_task_units set [count patrol_task_units, leader _staticgrp];
    patrol_task_vehs set [count patrol_task_vehs, vehicle (leader _staticgrp)];
    _otherReward = _otherReward + Hz_econ_Static_reward;

  };

};

if ((random 1) < _TowerChance) then {

  [_position] spawn CREATE_OPFOR_TOWER;

  _otherReward = _otherReward + Hz_econ_Tower_reward;

};

if ((random 1) < _SniperChance) then {

  _snipers = units ([_position] call CREATE_OPFOR_SNIPERS);

  _otherReward = _otherReward + Hz_econ_Sniper_reward*(count _snipers);
  patrol_task_units = patrol_task_units + _snipers;

};

_b = (_minPatrollingSquadCount max (round (random _maxPatrollingSquadCount)));

if(_b > 0) then {
  
  for "_i" from 1 to _b do {
    
    //exit spawn loop and transfer to reinforcements script if too many units present on map
    if((count allunits) > Hz_max_allunits) exitwith {_r = (_b - _i) + 1; [_reinforcementsMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn Hz_task_reinforcements;};
    
    _tempos = [_position,_reinforcementsMinimumSpawnRange] call Hz_func_findspawnpos;

    _grppat = [ _position,"INF",(5 + random 10),300,"patrol" ] call CREATE_OPFOR_SQUAD;
    
    _Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_func_opforVehicleSupport;
    _vehicletypes = _Vehsupport select 0;
    _otherReward = _otherReward + (_Vehsupport select 1);
    
    if((count _vehicletypes) > 0) then { 
      
      _car_type = _vehicletypes call mps_getRandomElement;
      _vehgrp = [_car_type,(SIDE_B select 0),_position,300] call mps_spawn_vehicle;
      sleep 0.1;
      patrol_task_vehs set [count patrol_task_vehs, vehicle (leader _vehgrp)];
      (units _vehgrp) joinSilent _grppat;
      sleep 0.1;
      if(!isnil "zeu_Groups") then {if(!(_grppat in zeu_Groups)) then {zeu_Groups set [count zeu_Groups, _grppat];};};
      deleteGroup _vehgrp;
      
    };
    
    patrol_task_units = patrol_task_units + (units _grppat);
    
  };
};  


_c = (_minDefendingSquadCount max (round (random _maxDefendingSquadCount)));

if(_c > 0) then {

  for "_i" from 1 to _c do {
    
    //exit spawn loop and transfer to reinforcements script if too many units present on map
    if((count allunits) > Hz_max_allunits) exitwith {_r = (_c - _i) + 1; [_reinforcementsMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn Hz_task_reinforcements;};
    
    _tempos = [_position,_reinforcementsMinimumSpawnRange] call Hz_func_findspawnpos;
    
    _grpdef = [ _position,"INF",(5 + random 10),_DefenseRadius,"standby" ] call CREATE_OPFOR_SQUAD;
    
    _Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_func_opforVehicleSupport;
    _vehicletypes = _Vehsupport select 0;
    _otherReward = _otherReward + (_Vehsupport select 1);
    
    if((count _vehicletypes) > 0) then { 
      
      _car_type = _vehicletypes call mps_getRandomElement;
      _vehgrp = [_car_type,(SIDE_B select 0),_position,_DefenseRadius] call mps_spawn_vehicle;
      sleep 0.1;
      patrol_task_vehs set [count patrol_task_vehs, vehicle (leader _vehgrp)];
      (units _vehgrp) joinSilent _grpdef;
      sleep 0.1;
      if(!isnil "zeu_Groups") then {if(!(_grpdef in zeu_Groups)) then {zeu_Groups set [count zeu_Groups, _grpdef];};};
      deleteGroup _vehgrp;
      
    };
    
    patrol_task_units = patrol_task_units + (units _grpdef);
    
  };
}; 
_d = (_minGarrisonedSquadCount max (round (random _maxGarrisonedSquadCount)));

if(_d > 0) then {

  for "_i" from 1 to _d do {
    
    //  _tempos = [_position,_reinforcementsMinimumSpawnRange] call Hz_func_findspawnpos;
    
    //exit spawn loop and transfer to reinforcements script if too many units present on map
    // if((count allunits) > Hz_max_allunits) exitwith {_r = (_d - _i) + 1; [_tempos,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn Hz_task_reinforcements;};
    
    _grpgar = [ _position,"INF",5,_DefenseRadius,"hide" ] call CREATE_OPFOR_SQUAD;
    
    patrol_task_units = patrol_task_units + (units _grpgar);
  };
};  


/*-------------------RANDOM INTENSIFY AMBIENT COMBAT------------------------------------*/

_ambience = false;
if((random 1) < 0.3) then {
  _ambience = true;
  Hz_max_ambient_units = Hz_max_ambient_units + Hz_ambient_units_intensify_amount;

};


/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = [ _object ]; publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

missionload = false;

[ format["TASK%1",_taskid],
format["Priority Target: Capture %1", name _object],
format["A high profile target has been spotted in %1. Capture %2 alive and transport him back to base. He may be well defended.", text _location, name _object],
(SIDE_A select 0),
[format["MARK%1",_taskid],(_position),"hd_objective","ColorRed"," Target"],
"created",
_position
] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
hz_reward = 1;
while { (alive _object && _object distance (getMarkerPos format["return_point_%1",(SIDE_A select 0)]) > 10 && hz_reward > 0) && (((count playableunits) + ({isplayer _x} count alldead)) > 1)} do {
  
  sleep 0.15;
  hz_reward = ((Hz_econ_perSquadReward * (_b + _c)) + _otherReward + Hz_econ_aux_rewards);
  _deathPenalty = (mps_mission_deathlimit - mps_mission_deathcount) * Hz_penalty_multiplier_per_death;
  hz_reward = (hz_reward - _deathPenalty)*_rewardmultiplier;
};


/*-------------------RANDOM INTENSIFY AMBIENT COMBAT---------------------------*/

if(_ambience) then {
  
  Hz_max_ambient_units = Hz_max_ambient_units - Hz_ambient_units_intensify_amount;

};

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

missionload = true;

if( alive _object && hz_reward > 0 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)) then {
  [format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
  
  if(hz_reward >= 1000000) then {hz_display_reward = format ["%1 million",(hz_reward / 1000000)];} else {hz_display_reward = hz_reward;};
  publicvariable "hz_display_reward";
  [-1, {hint format["You've earned $%1 for completing the task!", hz_display_reward];}] call CBA_fnc_globalExecute;
  Hz_funds = Hz_funds + hz_reward;
  publicvariable "Hz_funds";
  
}else{
  [format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

_object action ["eject",vehicle _object];
sleep 5;
deleteVehicle _object;
deleteGroup _grp;
/*
  [_troops,_position] spawn {
    while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
    { _x setDamage 1}forEach (_this select 0);
  };
*/
/*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       

[patrol_task_units,_position,patrol_task_vehs] spawn {
  
  
  private ["_units","_vehs","_markers"];
  _units = _this select 0;
  _vehs = _this select 2;
  
  while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Air"],1500] > 0} do { sleep 3600 };
  {deletevehicle _x}forEach _units;
  {deletevehicle _x}forEach _vehs;
};      

/*--------------------RESET INTEL---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};