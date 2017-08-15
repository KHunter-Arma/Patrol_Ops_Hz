
private ["_location","_position","_taskid","_vehtype","_target1","_r","_car_type","_vehgrp","_tempos","_grppat","_Vehsupport","_vehicletypes","_otherReward","_grpdef","_grpgar","_half","_deathPenalty","_reinforcementsMinimumSpawnRange","_minDefendingSquadCount","_maxDefendingSquadCount","_DefenseRadius","_minGarrisonedSquadCount","_maxGarrisonedSquadCount","_minPatrollingSquadCount","_maxPatrollingSquadCount","_minStaticWeapon","_maxStaticWeapon","_CASchance","_TankChance","_IFVchance","_AAchance","_CarChance","_SniperChance","_TowerChance","_rewardmultiplier","_markerpos","_scudgrp","_target2","_troops","_staticguns","_b","_c","_d"];
diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Search and Destroy Scuds Initialise"];

/*-------------------- TASK PARAMS ---------------------------------*/
_reinforcementsMinimumSpawnRange = 5000;

_minDefendingSquadCount = 3;
_maxDefendingSquadCount = 6;
_DefenseRadius = 200;

_minGarrisonedSquadCount = 0;
_maxGarrisonedSquadCount = 0;

_minPatrollingSquadCount = 0;
_maxPatrollingSquadCount = 3;

_minStaticWeapon = 0;
_maxStaticWeapon = 1;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0.1;
_TankChance = 0.3;
_IFVchance = 0.2;
_AAchance = 0.4;
_CarChance = 0.6;

//Others
_SniperChance = 0.1;
_TowerChance = 0;

//Useful for justifying task-specific difficulties.
_rewardmultiplier = 10;

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["hills"]] call mps_getNewLocation;
	_markerpos = [(position _location) select 0,(position _location) select 1, 0];
	_position = [[(position _location) select 0,(position _location) select 1, 0],800,1,2] call mps_getFlatArea;
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
        Hz_task_ID = _taskid;
        Hz_econ_aux_rewards = 0;
        _otherReward = 0;
        
/*--------------------CREATE TARGETS----------------------------------*/

	_vehtype = "GRAD_RU"; if(mps_oa) then {_vehtype = "MAZ_543_SCUD_TK_EP1"};

	_scudgrp = createGroup east;
	_target1 = ([_position,random 350,_vehtype,_scudgrp] call BIS_fnc_spawnVehicle) select 0;
	_target2 = ([_position,random 350,_vehtype,_scudgrp] call BIS_fnc_spawnVehicle) select 0; 

	_vehtype = getText (configFile >> "CfgVehicles" >> typeof _target1  >> "displayName");

/*--------------------CREATE ENEMY AT LOCATION------------------------*/


        _troops = [];
        
        _staticguns = _minStaticWeapon max (round (random _maxStaticWeapon));
	if(_staticguns > 0) then {for "_i" from 1 to _staticguns do { [_position] call CREATE_OPFOR_STATIC; };};
        if ((random 1) < _TowerChance) then {[_position] spawn CREATE_OPFOR_TOWER;};
        if ((random 1) < _SniperChance) then {[_position] spawn CREATE_OPFOR_SNIPERS;};
        
        _b = (_minPatrollingSquadCount max (round (random _maxPatrollingSquadCount)));

	if(_b > 0) then {
            
                for "_i" from 1 to _b do {
                        
                //exit spawn loop and transfer to reinforcements script if too many units present on map
                if((count allunits) > Hz_max_allunits) exitwith {_r = (_b - _i) + 1; [_reinforcementsMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn Hz_task_reinforcements;};
                
                _tempos = [_position,_reinforcementsMinimumSpawnRange] call Hz_func_findspawnpos;
                
		_grppat = [ _position,"INF",(5 + random 10),300,"patrol" ] call CREATE_OPFOR_SQUAD;
                    
                    _Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_func_AI_veh_support;
                    _vehicletypes = _Vehsupport select 0;
                    _otherReward = _otherReward + (_Vehsupport select 1);
                        
                        if((count _vehicletypes) > 0) then { 
                        
                        _car_type = _vehicletypes call mps_getRandomElement;
			_vehgrp = [_car_type,(SIDE_B select 0),_position,300] call mps_spawn_vehicle;
			sleep 1;
			(units _vehgrp) joinSilent _grppat;
                        sleep 1;
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
                    
                    _Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_func_AI_veh_support;
                    _vehicletypes = _Vehsupport select 0;
                    _otherReward = _otherReward + (_Vehsupport select 1);
                        
                        if((count _vehicletypes) > 0) then { 
                        
                        _car_type = _vehicletypes call mps_getRandomElement;
			_vehgrp = [_car_type,(SIDE_B select 0),_position,_DefenseRadius] call mps_spawn_vehicle;
			sleep 1;
			(units _vehgrp) joinSilent _grpdef;
                        sleep 1;
                        if(!isnil "zeu_Groups") then {if(!(_grpdef in zeu_Groups)) then {zeu_Groups set [count zeu_Groups, _grpdef];};};
			deleteGroup _vehgrp;
                        
                        };
		
		patrol_task_units = patrol_task_units + (units _grpdef);
                
	};
       }; 
        _d = (_minGarrisonedSquadCount max (round (random _maxGarrisonedSquadCount)));

        if(_d > 0) then {

	for "_i" from 1 to _d do {
            
               // _tempos = [_position,_reinforcementsMinimumSpawnRange] call Hz_func_findspawnpos;
            
                //exit spawn loop and transfer to reinforcements script if too many units present on map
             //   if((count allunits) > Hz_max_allunits) exitwith {_r = (_d - _i) + 1; [_tempos,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn Hz_task_reinforcements;};
                
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

	mps_civilian_intel = [_target1,_target2]; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/
missionload = false;
waituntil {(count playableunits) > 0};

	[format["TASK%1",_taskid],
		format["Urgent! Destroy: %2 spotted near %1", text _location,_vehtype],
		format["We have just learned that a rogue enemy general has ordered a couple of %2 near %1 to hit %3! You must find them and take them out before they wipe out the whole town!",text _location,_vehtype,worldname],  
		true,
		[format["MARK%1",_taskid],(_markerpos),"hd_objective","ColorRed"," Last Known"],
		"created",
		_markerpos
	] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	scudcount = 0;
	fired = false;
        hz_reward = 1;

	While { { canmove _x } count [_target1,_target2] > 0 && scudcount < 90 && hz_reward > 0 } do {
		sleep 30;
		scudcount = scudcount + 1;
		if( canmove _target1 ) then {
			switch (scudcount) do {
				case 30 : { fire = _target1 action ["scudLaunch",_target1]; };
				case 90 : { fire = _target1 action ["scudStart",_target1]; };
			};
		};
		if( canmove _target2 ) then {
			switch (scudcount) do {
				case 40 : { fire = _target2 action ["scudLaunch",_target2]; };
				case 90 : { fire = _target2 action ["scudStart",_target2]; };
			};
		};
		mps_progress_bar_update = [ (90 - scudcount), 90, east, "Scud Launch"]; publicVariable "mps_progress_bar_update";
	
                hz_reward = ((Hz_econ_perSquadReward * (_b+_c)) + _otherReward + Hz_econ_aux_rewards);
                _deathPenalty = (mps_mission_deathlimit - mps_mission_deathcount) * Hz_penalty_multiplier_per_death;
                hz_reward = (hz_reward - _deathPenalty)*_rewardmultiplier;
        
        };
      
    //SCUDs stopped, clean out enemies  
    if( (!(canmove _target1)) && (!(canmove _target2)) && scudcount < 90 ) then {
        
    [-1, {hint "Great! The SCUDS are out of commission! Now move in and clear out the remaining enemies.";}] call CBA_fnc_globalExecute; 
    sleep 240; 
     
     
    if ((random 1) < 0.5) then {
     
    While {hz_reward > 0  && (({alive _x} count patrol_task_units) > 10)} do {
        
        sleep 15;
        hz_reward = ((Hz_econ_perSquadReward * (_b+_c)) + _otherReward + Hz_econ_aux_rewards);
        _deathPenalty = (mps_mission_deathlimit - mps_mission_deathcount) * Hz_penalty_multiplier_per_death;
        hz_reward = (hz_reward - _deathPenalty)*_rewardmultiplier;
        
    };   
        
    } else {
    
    _half = floor ((count patrol_task_units) / 2);    
            
    While {hz_reward > 0 && ({alive _x} count patrol_task_units) > _half} do { 
        
        sleep 15;
        hz_reward = ((Hz_econ_perSquadReward * (_b+_c)) + _otherReward + Hz_econ_aux_rewards);
        _deathPenalty = (mps_mission_deathlimit - mps_mission_deathcount) * Hz_penalty_multiplier_per_death;
        hz_reward = (hz_reward - _deathPenalty)*_rewardmultiplier;
        
    }; 
    
    if (mps_mission_deathcount > 0) then {
    
    
    if((random 1) < 0.5) then {[_position] call Hz_func_bombingrun;} else {[_position] call Hz_func_callinBomber;};

    sleep 85;
    
    [-1, {hint "We just received intel that the enemy HQ has learned about the general and they have just called in an airstrike on the area! Get out of there now!";}] call CBA_fnc_globalExecute;
    
    sleep 60; 
    
    };
    
    };    
    
    };
    
/*-------------------RANDOM INTENSIFY AMBIENT COMBAT---------------------------*/

if(_ambience) then {
    
Hz_max_ambient_units = Hz_max_ambient_units - Hz_ambient_units_intensify_amount;

};    
    
/*--------------------CHECK IF SUCCESSFUL---------------------------------*/
missionload = true;
	if ((!(canmove _target1)) && (!(canmove _target2)) && scudcount < 90 && hz_reward > 0) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
                       
        if(hz_reward >= 1000000) then {hz_display_reward = format ["%1 million",(hz_reward / 1000000)];} else {hz_display_reward = hz_reward;};
        publicvariable "hz_display_reward";
        [-1, {hint format["You've earned $%1 for completing the task!", hz_display_reward];}] call CBA_fnc_globalExecute;
        Hz_funds = Hz_funds + hz_reward;
        publicvariable "Hz_funds";
                
	}else{
            
                [format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
            
                if ((!(canmove _target1)) && (!(canmove _target2)) && scudcount < 90) then {
                    
                [-1, {hint "Good job on stopping the launch, but we gave too many casualties and you need to retreat. NATO Command will take over from here.";}] call CBA_fnc_globalExecute;   
                sleep 10;   
                   
                } else {
                    
		
                
           //     if(mps_mission_deathcount < 1) then {mission_hint = "We are too late, radar is tracking a missile in the air right now. You only have about a minute to clear the town!"; publicVariable "mission_hint";} else {
                    if( canmove _target1 ) then {
			if (scudcount < 30) then {
				fire = _target1 action ["scudLaunch",_target1];
                                sleep 8;
				fire = _target1 action ["scudStart",_target1]; 
			} else { if (scudcount < 90) then {fire = _target1 action ["scudStart",_target1]; };};
		};
		 if( canmove _target2 ) then {
			if (scudcount < 40) then {
				fire = _target2 action ["scudLaunch",_target2];
                                sleep 8;
				fire = _target2 action ["scudStart",_target2]; 
			} else { if (scudcount < 90) then {fire = _target2 action ["scudStart",_target2]; };};
		};
                
               if (mps_mission_deathcount > 0) then {
                   
               mission_hint = "We are too late. Command has ordered to evacuate the city and radar is already tracking a missile in the air right now. You only have about a minute to clear the town!"; 
              } else {
              mission_hint = "We tried but we have given too many casualties. Command has ordered to evacuate the city and radar is already tracking a missile in the air right now. You only have about a minute to clear the town!";                  
              }; 
               publicVariable "mission_hint";            
                           
                sleep 60;
                baboom = true;
                publicvariable "baboom";
                []execvm "lk\nuke\nuke.sqf";
	};
        
};
/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

/*	[_troops,_position,[_target1,_target2]] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
		{ _x setDamage 1}forEach (_this select 0);
		{ deleteVehicle _x; }forEach (_this select 2);
	};
*/
 /*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       
        
	[patrol_task_units,_position,patrol_task_vehs,[_target1,_target2]] spawn {
            
                
private ["_units","_vehs","_markers"];
_units = _this select 0;
                _vehs = _this select 2;
                _markers = patrol_task_markers;
                
                while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
		{deletevehicle _x}forEach _units;
                {deletevehicle _x}forEach _vehs;
                {deletemarkerlocal _x}foreach _markers;
                { deleteVehicle _x }forEach (_this select 3);
	};      
       
/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};