
private ["_taskRadius","_enemyMinimumSpawnRange","_r","_car_type","_vehgrp","_tempos","_grp","_Vehsupport","_vehicletypes","_otherReward","_troops","_deathPenalty","_minSquadCount","_maxSquadCount","_CASchance","_TankChance","_IFVchance","_AAchance","_CarChance","_rewardmultiplier","_location","_position","_taskid","_container","_b"];
diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Build Tower Initialise"];

/*-------------------- TASK PARAMS ---------------------------------*/
_enemyMinimumSpawnRange = 5000;
_minSquadCount = 3;
_maxSquadCount = 6;

_taskRadius = 2000;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0.2;
_TankChance = 0.1;
_IFVchance = 0.2;
_AAchance = 0.2;
_CarChance = 0.5;

//Useful for justifying task-specific difficulties.
_rewardmultiplier = 2;
/*--------------------CREATE LOCATION---------------------------------*/

_location = [["hills"],6000] call mps_getNewLocation;
_position = [ [(position _location) select 0,(position _location) select 1, 0] ,50,1,2] call mps_getFlatArea;
_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

/*--------------------CREATE TARGET-----------------------------------*/

_container = [format["return_point_%1",(SIDE_A select 0)]] call CREATE_MOVEABLE_TOWER;

/*--------------------CREATE ENEMY AT LOCATION------------------------*/

_grp = [_position,"INF",(5 + random 5),50,"patrol" ] call CREATE_OPFOR_SQUAD;

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = [_container]; publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/
missionload = false;
[format["TASK%1",_taskid],
"Deploy Communications Tower",
format["The enemy has destroyed one of our communication towers. A hill near %1 is ideal to deploy a new Comms Tower to restore communication in the area. Take the mobile comms station packed inside a shipping container in base and deploy it at the site.", text _location],
true,
[format["MARK%1",_taskid],(_position),"hd_objective","ColorBlue"," Deploy Tower"],
"created",
_position
] call mps_tasks_add;

/*--------------------WAIT TILL PLAYERS ARRIVE---------------------------------*/

while{ { side _x == (SIDE_A select 0)} count nearestObjects[_position,["CAManBase","LandVehicle"],_taskRadius] == 0 && mps_mission_deathcount > 0 } do { sleep 5 };

/*--------------------CREATE ENEMY NEAR LOCATION---------------------------------*/



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
      (units _vehgrp) joinSilent _grp;
      sleep 1;
      if(!isnil "zeu_Groups") then {if(!(_grp in zeu_Groups)) then {zeu_Groups set [count zeu_Groups, _grp];};};
      deleteGroup _vehgrp;
      
    };
    
    _troops = _troops + (units _grp);
    sleep 1;
    if(!isnil "Hz_AI_moveAndCapture") then {
          
          _spawnedVehs = [_grp, _position] call Hz_AI_moveAndCapture;  

          patrol_task_vehs = patrol_task_vehs + _spawnedVehs;					 
          
        } else {
          
          _wp = _grp addWaypoint [_position,20];
          _wp setWaypointType "SAD";
          
        };
    sleep 1;
  };
};

/*-------------------RANDOM INTENSIFY AMBIENT COMBAT------------------------------------*/

_ambience = false;
if((random 1) < 0.3) then {
  _ambience = true;
  Hz_max_ambient_units = Hz_max_ambient_units + Hz_ambient_units_intensify_amount;

};

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
hz_reward = 1;
while { count nearestObjects[ _position, ["Land_Vysilac_FM"], 80] == 0 && damage _container < 1 && hz_reward > 0 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)} do {
  
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
if( count nearestObjects[ _position, ["Land_Vysilac_FM"], 80] > 0 && hz_reward > 0 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)) then {
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

sleep 2;

/*[_troops,_position] spawn {
    while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
    { _x setDamage 1}forEach (_this select 0);
    { deleteVehicle _x }forEach (nearestObjects[(_this select 1), ["Land_Vysilac_FM"], 80] select 0);
  };
*/
/*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       

[patrol_task_units,_position,patrol_task_vehs] spawn {
  
  
  private ["_units","_vehs","_markers"];
  _units = _this select 0;
  _vehs = _this select 2;
  _markers = patrol_task_markers;
  
  while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
  {deletevehicle _x}forEach _units;
  {deletevehicle _x}forEach _vehs;
  { deleteVehicle _x }forEach (nearestObjects[(_this select 1), ["Land_Vysilac_FM"], 80] select 0);
  
  {deletemarkerlocal _x}foreach _markers;
};      

/*--------------------RESET INTEL---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};

