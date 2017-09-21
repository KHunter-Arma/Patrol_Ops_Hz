
private ["_location","_position","_taskid","_allroads","_roads","_allmines","_mine","_troops","_b","_grp","_car_type","_vehgrp","_randompos_on_road","_randompos","_pos","_enemyMinimumSpawnRange","_r","_tempos","_Vehsupport","_vehicletypes","_otherReward","_deathPenalty","_taskRadius","_minSquadCount","_maxSquadCount","_CASchance","_TankChance","_IFVchance","_AAchance","_CarChance","_minMineCount","_maxMineCount","_SniperChance","_rewardmultiplier","_MineCount","_MINE_CHECKER"];
diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Clear Minefield Initialise"];

/*-------------------- TASK PARAMS ---------------------------------*/
_enemyMinimumSpawnRange = 2000;
_taskRadius = 500;
_minSquadCount = 2;
_maxSquadCount = 5;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0.2;
_TankChance = 0;
_IFVchance = 0.2;
_AAchance = 0.2;
_CarChance = 0.5;

//Task specific parameters
_minMineCount = 3;
_maxMineCount = 12;

_SniperChance = 0.1;

//Useful for justifying task-specific difficulties.
_rewardmultiplier = 0.5;
/*--------------------CREATE LOCATION---------------------------------*/

_location = [["towns"]] call mps_getNewLocation;
_position = [(position _location) select 0,(position _location) select 1, 0];
_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];


(vehicle player) setpos _position;

Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

/*--------------------CREATE TARGET-----------------------------------*/

_MineCount = _minMineCount max (round (random _maxMineCount));   

_allroads = _position nearRoads _taskRadius;
_roads = [];
_allmines = [];

{ if(count roadsconnectedto _x > 1) then { _roads = _roads + [_x]; }; } foreach _allroads;

_MINE_CHECKER = {
  _this addEventHandler ["HandleDamage", {
    _damage = _this select 2;
    _projectile = _this select 4;		
    if(_projectile == "PipeBomb" || _projectile == "ACE_PipebombExplosion") then { 1 } else { 0 };
  }];
};

if((count _roads) > 0) then {
  {
    if((random 1) <= 0.4) then {
      _randompos_on_road = [(getpos _x select 0) + 2.5 - random 5, (getpos _x select 1) + 2.5 - random 5,  (getpos _x select 2)];
      //_mine = createMine ["MineMine", _randompos_on_road, [], 0];
      //_mine spawn _MINE_CHECKER;
      _mine = "ACE_MineE_Editor" createvehicle _randompos_on_road;
      
      _allmines = _allmines + [_mine];
    };
    if( (count _allmines) >= _MineCount ) exitWith{};
  } foreach _roads;
} else {
  _pos = [_position,100,1,2] call mps_getFlatArea;
  for "_i" from 1 to _MineCount do {
    _randompos = [(_pos select 0) + 25 - random 50, (_pos select 1) + 25 - random 50, 0];
    //_mine = createMine ["MineMine", _randompos, [], 0];
    //_mine spawn _MINE_CHECKER;
    _mine = "ACE_MineE_Editor" createvehicle _randompos;
    _mine setposatl [(getposatl _mine) select 0, (getposatl _mine) select 1, ((getposatl _mine) select 2)-0.05];
    
    _allmines = _allmines + [_mine];
  };
};


/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = _allmines; publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE GUARDS-------------------------------------------*/

if ((random 1) < _SniperChance) then {

  _snipers = units ([_position] call CREATE_OPFOR_SNIPERS);

  _otherReward = _otherReward + Hz_econ_Sniper_reward*(count _snipers);
  patrol_task_units = patrol_task_units + _snipers;

};

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[ format["TASK%1",_taskid],
"Clear Minefield",
format["Civilians in %1 are reporting injuries caused by enemy mines. Head down there ASAP and remove them either by disabling or destroying them.", text _location],
(SIDE_A select 0),
[format["MARK%1",_taskid],(_position),"hd_objective","ColorRed"," Target"],
"created",
_position
] call mps_tasks_add;

/*--------------------WAIT FOR AMBUSH---------------------------------*/

while{ {isPlayer _x} count nearestObjects[ _position, ["CAManBase","LandVehicle"], 1000] == 0 } do { sleep 10 };

/*--------------------CREATE AMBUSH-----------------------------------*/

_troops = [];
//_b = (3 max (round (random (playersNumber (SIDE_A select 0) / 3)))) * mps_mission_factor;
_b = (_minSquadCount max (round (random _maxSquadCount)));

if(_b > 0) then {

  for "_i" from 1 to _b do {
    
    //exit spawn loop and transfer to reinforcements script if too many units present on map
    if((count allunits) > Hz_max_allunits) exitwith {_r = (_b - _i) + 1; [_enemyMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn Hz_task_reinforcements;};
    
    _tempos = [_position,_enemyMinimumSpawnRange] call Hz_func_findspawnpos;
    
    _grp = [ _tempos,"INF",(5 + random 10),50 ] call CREATE_OPFOR_SQUAD;
    
    _Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_func_opforVehicleSupport;
    _vehicletypes = _Vehsupport select 0;
    _otherReward = _otherReward + (_Vehsupport select 1);
    
    if((count _vehicletypes) > 0) then { 
      
      _car_type = _vehicletypes call mps_getRandomElement;
      _vehgrp = [_car_type,(SIDE_B select 0),_tempos,100] call mps_spawn_vehicle;
      sleep 1;
      patrol_task_vehs set [count patrol_task_vehs, vehicle (leader _vehgrp)];
      (units _vehgrp) joinSilent _grp;
      sleep 1;
      if(!isnil "zeu_Groups") then {if(!(_grp in zeu_Groups)) then {zeu_Groups set [count zeu_Groups, _grp];};};
      deleteGroup _vehgrp;
      
    };
    
    patrol_task_units = patrol_task_units + (units _grp);
    sleep 1;
    if(!isnil "Hz_AI_moveAndCapture") then {
      
      _spawnedVehs = [_grp, _position,mps_opfor_truck,mps_opfor_ncov,_taskRadius] call Hz_AI_moveAndCapture;  

      patrol_task_vehs = patrol_task_vehs + _spawnedVehs;
      
    } else {
      
      _wp = _grp addWaypoint [_position,50];
      _wp setWaypointType "SAD";
      
    };
  };
};

/*-------------------RANDOM INTENSIFY AMBIENT COMBAT------------------------------------*/

_ambience = false;
if((random 1) < 0.3) then {
  _ambience = true;
  Hz_max_ambient_units = Hz_max_ambient_units + Hz_ambient_units_intensify_amount;

};

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
missionload = false;
hz_reward = 1;
//while { { isNull _x || (vectorUp _x select 2) < 1} count _allmines < count _allmines && mps_mission_deathcount > 0 } do { sleep 15 };
while { { !isNull _x } count _allmines > 0 && hz_reward > 0 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)} do { 
  
  sleep 15;
  hz_reward = ((Hz_econ_perSquadReward * _b) + _otherReward + Hz_econ_aux_rewards);
  _deathPenalty = (mps_mission_deathlimit - mps_mission_deathcount) * Hz_penalty_multiplier_per_death;
  hz_reward = (hz_reward - _deathPenalty)*_rewardmultiplier;
  
};


/*-------------------RANDOM INTENSIFY AMBIENT COMBAT---------------------------*/

if(_ambience) then {
  
  Hz_max_ambient_units = Hz_max_ambient_units - Hz_ambient_units_intensify_amount;

};


/*--------------------CHECK IF SUCCESSFUL---------------------------------*/
missionload = true;
if( hz_reward > 0 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)) then {
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

{ deleteVehicle _x; }forEach _allmines;

/*[_troops,_position] spawn {
    while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
    { _x setDamage 1}forEach (_this select 0);
  };*/

/*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       

[patrol_task_units,_position,patrol_task_vehs] spawn {
  
  
  private ["_units","_vehs","_markers"];
  _units = _this select 0;
  _vehs = _this select 2;                
  
  while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
  {deletevehicle _x}forEach _units;
  {deletevehicle _x}forEach _vehs;
};      


/*--------------------RESET INTEL---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};