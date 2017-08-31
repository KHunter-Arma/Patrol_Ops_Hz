
private ["_location","_position","_taskid","_grp","_choptype","_enemyMinimumSpawnRange","_r","_car_type","_vehgrp","_tempos","_Vehsupport","_vehicletypes","_otherReward","_troops","_fired1","_fired2","_count","_fired4","_spawnpos","_fired5","_intelpercent","_deathPenalty","_minSquadCount","_maxSquadCount","_taskRadius","_CASchance","_TankChance","_IFVchance","_AAchance","_CarChance","_ParatrooperChance","_rewardmultiplier","_crashchopper","_fired3","_b","_squadCountperWave","_extra"];
diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Search and Recover Drone Intel Initialise"];

/*-------------------- TASK PARAMS ---------------------------------*/
_enemyMinimumSpawnRange = 1000;
_minSquadCount = 1;
_maxSquadCount = 4;
_taskRadius = 20;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0.2;
_TankChance = 0.1;
_IFVchance = 0.4;
_AAchance = 0.1;
_CarChance = 0.7;

_ParatrooperChance = 0.65;

//Useful for justifying task-specific difficulties.
_rewardmultiplier = 0.75;

/*--------------------CREATE LOCATION---------------------------------*/

_location = [["towns"]] call mps_getNewLocation;
_position = [[(position _location) select 0,(position _location) select 1, 0],900,1,2] call mps_getFlatArea;
_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

/*--------------------CREATE TARGET-----------------------------------*/

_choptype = "MQ9PredatorB";
if(mps_oa) then { _choptype = "MQ9PredatorB_US_EP1"; };
_crashchopper = _choptype createvehicle (_position);
sleep 1;
_crashchopper setFuel 0;
_crashchopper setvehicleammo 0;
_crashchopper allowDamage false;
_crashchopper setvehiclelock "locked";
_crashchopper setVectorUp [0,0,-1];
_crashchopper setDamage 0.75;
sleep 5;
_crashchopper allowDamage true;

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = [_crashchopper]; publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[format["TASK%1",_taskid],
"UAV Down - Recover Data, Destroy Wreckage",
"A reconnaissance UAV has been shot down while doing surveillance over enemy positions. Move to the crash site ASAP, download the data with secure link and, once complete, destroy the wreckage to prevent it falling into enemy hands.",
true,
[format["MARK%1",_taskid],(_position),"hd_objective","ColorBlue"," UAV crash site"],
"created",
_position
] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

_intelpercent = 0;
_fired1 = false;
_fired2 = false;
_fired3 = false;
_fired4 = false;
_fired5 = false;
_troops = [];

_b = (_minSquadCount max (round (random _maxSquadCount)));

_squadCountperWave = floor (_b / 3);
_extra  = _b % 3;

hz_reward = 1;

While{ _intelpercent < 3 && alive _crashchopper && hz_reward > 0 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)} do {

  sleep 10;

  if( _intelpercent > 0 && !_fired1 ) then {    
    
    if(_squadCountperWave > 0) then {

      for "_i" from 1 to _squadCountperWave do {

        //exit spawn loop and transfer to reinforcements script if too many units present on map
        if((count allunits) > Hz_max_allunits) exitwith {_r = (_squadCountperWave - _i) + 1; [_enemyMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn Hz_task_reinforcements;};

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
          
          _spawnedVehs = [_grp, _position,true,100] call Hz_AI_moveAndCapture;  

          patrol_task_vehs = patrol_task_vehs + _spawnedVehs;					 
          
        } else {
          
          _wp = _grp addWaypoint [_position,10];
          _wp setWaypointType "SAD";
          
        };
        
        sleep 1;
      };
    };
    
    _fired1 = true;
  };

  if( _intelpercent > 0.5 && !_fired2 ) then {
    
    if(_squadCountperWave > 0) then {

      for "_i" from 1 to _squadCountperWave do {

        //exit spawn loop and transfer to reinforcements script if too many units present on map
        if((count allunits) > Hz_max_allunits) exitwith {_r = (_squadCountperWave - _i) + 1; [_enemyMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn Hz_task_reinforcements;};

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
          
          _spawnedVehs = [_grp, _position,true,100] call Hz_AI_moveAndCapture;  

          patrol_task_vehs = patrol_task_vehs + _spawnedVehs;					 
          
        } else {
          
          _wp = _grp addWaypoint [_position,10];
          _wp setWaypointType "SAD";
          
        };
        sleep 1;
      };
    };
    
    
    _fired2 = true;
  };

  if( _intelpercent > 0.75 && !_fired4 ) then {
    
    _count = _squadCountperWave + _extra;
    
    if(_count > 0) then {

      for "_i" from 1 to _count do {

        //exit spawn loop and transfer to reinforcements script if too many units present on map
        if((count allunits) > Hz_max_allunits) exitwith {_r = (_count - _i) + 1; [_enemyMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn Hz_task_reinforcements;};

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
          
          _spawnedVehs = [_grp, _position,true,100] call Hz_AI_moveAndCapture;  

          patrol_task_vehs = patrol_task_vehs + _spawnedVehs;					 
          
        } else {
          
          _wp = _grp addWaypoint [_position,10];
          _wp setWaypointType "SAD";
          
        };
        sleep 1;
      };
    };
    
    _fired4 = true;
  };
  
  if( _intelpercent > 1.5 && !_fired5 ) then {
    
    if ((random 1) < _ParatrooperChance) then {
      
      _rewardmultiplier = _rewardmultiplier*1.25;
      
      for "_i" from 1 to 2 do {
        
        _tempos = [_position,_enemyMinimumSpawnRange*2] call Hz_func_findspawnpos;
        _spawnpos = [_tempos select 0,_tempos select 1];
        
        _grp = [_spawnpos,"INF",(8 + random 4),50] call CREATE_OPFOR_SQUAD;
        [_grp,_spawnpos,_position,true] spawn CREATE_OPFOR_PARADROP;
        
        sleep 30;
        
      };      
    };
    
    _fired5 = true;
    missionload = false;
    
  };

  if( ({isPlayer _x} count (nearestObjects[(position _crashchopper),["CAManBase"],_taskRadius])) > 0 ) then {

    _intelpercent = _intelpercent + 0.0125;
    mps_progress_bar_update = [ _intelpercent, 3, west, "Downloading Intel..."]; publicVariable "mps_progress_bar_update"; mps_progress_bar_update call mps_progress_update;

  };
  
  hz_reward = ((Hz_econ_perSquadReward * _b) + _otherReward + Hz_econ_aux_rewards);
  _deathPenalty = (mps_mission_deathlimit - mps_mission_deathcount) * Hz_penalty_multiplier_per_death;
  hz_reward = (hz_reward - _deathPenalty)*_rewardmultiplier;

};


waituntil {
  
  sleep 5; 
  hz_reward = ((Hz_econ_perSquadReward * _b) + _otherReward + Hz_econ_aux_rewards);
  _deathPenalty = (mps_mission_deathlimit - mps_mission_deathcount) * Hz_penalty_multiplier_per_death;
  hz_reward = (hz_reward - _deathPenalty)*_rewardmultiplier;

  ((!alive  _crashchopper) || (hz_reward <= 0) || (((count playableunits) + ({isplayer _x} count alldead)) < 2))

};


/*--------------------CHECK IF SUCCESSFUL---------------------------------*/
missionload = true;
if(  _intelpercent >= 3 && hz_reward > 0 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)) then {
  
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

/*[_troops,_position,_crashchopper] spawn {
    while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
    { _x setDamage 1}forEach (_this select 0);
    deleteVehicle (_this select 2);
  };*/

/*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       

[patrol_task_units,_position,patrol_task_vehs,_crashchopper] spawn {
  
  
  private ["_units","_vehs","_markers"];
  _units = _this select 0;
  _vehs = _this select 2;
  _markers = patrol_task_markers;
  
  while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
  {deletevehicle _x}forEach _units;
  {deletevehicle _x}forEach _vehs;
  {deletemarkerlocal _x}foreach _markers;
  deleteVehicle (_this select 3);
};      


/*--------------------RESET INTEL---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};