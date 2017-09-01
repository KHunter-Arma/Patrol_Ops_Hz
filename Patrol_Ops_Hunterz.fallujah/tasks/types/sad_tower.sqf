
private ["_location","_position","_taskid","_b","_marker","_reinforcementsMinimumSpawnRange","_r","_car_type","_vehgrp","_tempos","_grppat","_Vehsupport","_vehicletypes","_otherReward","_troops","_grpdef","_grpgar","_deathPenalty","_minDefendingSquadCount","_maxDefendingSquadCount","_DefenseRadius","_minGarrisonedSquadCount","_maxGarrisonedSquadCount","_minPatrollingSquadCount","_maxPatrollingSquadCount","_minStaticWeapon","_maxStaticWeapon","_CASchance","_TankChance","_IFVchance","_AAchance","_CarChance","_SniperChance","_TowerChance","_rewardmultiplier","_tower","_staticguns","_c","_d"];
diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Search and Destroy Comms Tower Initialise"];

/*-------------------- TASK PARAMS ---------------------------------*/
_reinforcementsMinimumSpawnRange = 5000;

_minDefendingSquadCount = 1;
_maxDefendingSquadCount = 3;
_DefenseRadius = 200;

_minGarrisonedSquadCount = 0;
_maxGarrisonedSquadCount = 1;

_minPatrollingSquadCount = 1;
_maxPatrollingSquadCount = 3;

_minStaticWeapon = 0;
_maxStaticWeapon = 3;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0;
_TankChance = 0;
_IFVchance = 0.2;
_AAchance = 0.3;
_CarChance = 0.4;

//Others
_SniperChance = 0;
_TowerChance = 0.2;

//Useful for justifying task-specific difficulties.
_rewardmultiplier = 1.25;

/*--------------------CREATE LOCATION---------------------------------*/
        
        _location = [["hills"]] call mps_getNewLocation;
	_position = [[(position _location) select 0,(position _location) select 1, 0],800,1,2] call mps_getFlatArea;
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
        Hz_task_ID = _taskid;
        Hz_econ_aux_rewards = 0;
        _otherReward = 0;
        
/*--------------------CREATE TARGET-----------------------------------*/

	_tower = "Land_Vysilac_FM" createVehicle _position;
	[_tower] spawn mps_object_c4only;

	TARGET_CAMP = _tower;

	if(mps_debug) then {
		_marker = createMarkerLocal [format["Debug%1",_taskid],position TARGET_CAMP];
		_marker setMarkerTypeLocal "mil_dot";
		_marker setMarkerColorLocal "ColorGreen";
	};

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
                    
                    _Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_func_opforVehicleSupport;
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
		
		_troops = _troops + (units _grppat);
                
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
			sleep 1;
			(units _vehgrp) joinSilent _grpdef;
                        sleep 1;
                         if(!isnil "zeu_Groups") then {if(!(_grpdef in zeu_Groups)) then {zeu_Groups set [count zeu_Groups, _grpdef];};};
			deleteGroup _vehgrp;
                        
                        };
		
		_troops = _troops + (units _grpdef);
                
	};
       }; 
        _d = (_minGarrisonedSquadCount max (round (random _maxGarrisonedSquadCount)));

        if(_d > 0) then {

	for "_i" from 1 to _d do {
            
               // _tempos = [_position,_reinforcementsMinimumSpawnRange] call Hz_func_findspawnpos;
            
                //exit spawn loop and transfer to reinforcements script if too many units present on map
             //   if((count allunits) > Hz_max_allunits) exitwith {_r = (_d - _i) + 1; [_tempos,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn Hz_task_reinforcements;};
                
		_grpgar = [ _position,"INF",5,_DefenseRadius,"hide" ] call CREATE_OPFOR_SQUAD;
                    
		_troops = _troops + (units _grpgar);
	};
      };  

/*-------------------RANDOM INTENSIFY AMBIENT COMBAT------------------------------------*/

_ambience = false;
if((random 1) < 0.3) then {
_ambience = true;
Hz_max_ambient_units = Hz_max_ambient_units + Hz_ambient_units_intensify_amount;

};

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = [TARGET_CAMP]; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/
missionload = false;
	[format["TASK%1",_taskid],
		"Search and Destroy Comms Relay",
		format["The enemy has setup a new comms relay somewhere in %1. With this new technology antenna, they will be able to coordinate much more effectively. You need to find it and take it out of commission.",worldname],
		true,
		[],
		"created"
	] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
hz_reward = 1;
	while { damage TARGET_CAMP < 1 && hz_reward > 0 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)} do { 
            
            sleep 15;
            hz_reward = ((Hz_econ_perSquadReward * (_b+_c)) + _otherReward + Hz_econ_aux_rewards);
            _deathPenalty = (mps_mission_deathlimit - mps_mission_deathcount) * Hz_penalty_multiplier_per_death;
            hz_reward = (hz_reward - _deathPenalty)*_rewardmultiplier;                
            
        };

/*-------------------RANDOM INTENSIFY AMBIENT COMBAT---------------------------*/

if(_ambience) then {
    
Hz_max_ambient_units = Hz_max_ambient_units - Hz_ambient_units_intensify_amount;

};

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/
missionload = true;
	if( damage TARGET_CAMP >= 1 && hz_reward > 0 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)) then {
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
/*
	{deleteMarker _x} forEach objective_marker;

	[_troops,_position] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
		{ _x setDamage 1}forEach (_this select 0);
		deleteVehicle TARGET_CAMP;
	};
        */
 /*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       
        
	[patrol_task_units,_position,patrol_task_vehs] spawn {
            
                
private ["_units","_vehs","_target","_markers"];
_units = _this select 0;
                _vehs = _this select 2;
                _target = TARGET_CAMP;
                 _markers = patrol_task_markers;
                 
                while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
		{deletevehicle _x}forEach _units;
                {deletevehicle _x}forEach _vehs;
                {deletemarkerlocal _x}foreach _markers;
		deleteVehicle _target;
	};      
        
/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};

