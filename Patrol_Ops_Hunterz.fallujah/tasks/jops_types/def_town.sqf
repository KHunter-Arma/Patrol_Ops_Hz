
private ["_location","_position","_taskid","_troops","_b","_tempos","_grp","_car_type","_vehgrp","_EnemySpawnMinimumRange","_r","_Vehsupport","_vehicletypes","_otherReward","_deathPenalty","_taskRadius","_minSquadCount","_maxSquadCount","_CASchance","_TankChance","_IFVchance","_AAchance","_CarChance","_rewardmultiplier","_wait"];
diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Defend Town Initialise"];

/*-------------------- TASK PARAMS ---------------------------------*/
_EnemySpawnMinimumRange = 10000;
_taskRadius = 800;
_minSquadCount = 12;
_maxSquadCount = 20;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0.3;
_TankChance = 0.1;
_IFVchance = 0.4;
_AAchance = 0.4;
_CarChance = 0.8;

//Useful for justifying task-specific difficulties.
_rewardmultiplier = 0.4;

/*--------------------CREATE LOCATION---------------------------------*/

        //_EnemySpawnMinimumRange = floor (_EnemySpawnMinimumRange / (sqrt 2));

	_location = [["towns",3000]] call mps_getNewLocation;
	_position = [[(position _location) select 0,(position _location) select 1, 0],50,1,2] call mps_getFlatArea;
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
        Hz_task_ID = _taskid;
        Hz_econ_aux_rewards = 0;
        _otherReward = 0;
        
/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/



	[ format["TASK%1",_taskid],
		format["Defend %1",name _location],
		format["A large enemy force is moving on %1 and will over run it soon. Secure the location and keep any hostiles away.", name _location],
		(SIDE_A select 0),
		[format["MARK%1",_taskid],(_position),"defend","ColorBlue"," Defend"],
		"created",
		_position
	] call mps_tasks_add;

/*--------------------WAIT UNTIL PLAYERS ARRIVE------------------------*/

	while{ { side _x == (SIDE_A select 0)} count nearestObjects[_position,["CAManBase","LandVehicle"],_taskRadius] == 0 && mps_mission_deathcount > 0 } do { sleep 5 };
        
/*------------------------- TIMER ---------------------------------------------*/  

[-1, {
    hint "Intel reports you have less than 10 minutes before the main force arrives. Get ready!";
}] call CBA_fnc_globalExecute;

_wait = 300;
_wait = _wait + random 300;
sleep _wait;

    /*--------------------CREATE ENEMY NEARBY LOCATION------------------------*/       

	_troops = [];
	//_b = (3 max (round (random (playersNumber (SIDE_A select 0) / 3)))) * mps_mission_factor;
        _b = (_minSquadCount max (round (random _maxSquadCount)));

        if(_b > 0) then {

	for "_i" from 1 to _b do {
            
                //if( (random 1) > 0.5 ) then { _EnemySpawnMinimumRange = -_EnemySpawnMinimumRange; };
		//_tempos = [ (_position select 0) - _EnemySpawnMinimumRange, (_position select 1) + _EnemySpawnMinimumRange, 0 ];
                                
                //exit spawn loop and transfer to reinforcements script if too many units present on map
                if((count allunits) > Hz_max_allunits) exitwith {_r = (_b - _i) + 1; [_EnemySpawnMinimumRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn Hz_task_reinforcements;};
                
                _tempos = [_position,_EnemySpawnMinimumRange] call Hz_func_findspawnpos;
                
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
                    
               _wp = _grp addWaypoint [_position,50];
               _wp setWaypointType "SAD";
                   
                };
		sleep 1;
	};
      };


/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
missionload = false;
hz_reward = 1;
	while{ {alive _x && side _x == (SIDE_A select 0)} count nearestObjects[_position,["CAManBase","LandVehicle","Air"],_taskRadius] != 0 && hz_reward > 0 && { alive _x } count _troops > 10 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)} do { 
            
        sleep 15;
        hz_reward = ((Hz_econ_perSquadReward * _b) + _otherReward + Hz_econ_aux_rewards);
        _deathPenalty = (mps_mission_deathlimit - mps_mission_deathcount) * Hz_penalty_multiplier_per_death;
        hz_reward = (hz_reward - _deathPenalty)*_rewardmultiplier;
                
                
        };     
    

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/
missionload = true;
	if(hz_reward > 0 &&  {alive _x && side _x == (SIDE_A select 0)} count nearestObjects[_position,["CAManBase","LandVehicle","Air"],_taskRadius] != 0 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;              
               
        if(hz_reward >= 1000000) then {hz_display_reward = format ["%1 million",(hz_reward / 1000000)];} else {hz_display_reward = hz_reward;};
        publicvariable "hz_display_reward";
        [-1, {
				
				if (!(player getVariable ["JointOps",false])) then {
				
				hint format["You've earned $%1 for completing the task!", hz_display_reward];
				
				};
        Hz_funds = Hz_funds + hz_reward;
        publicvariable "Hz_funds";
        
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/
/*
	[_troops,_position] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
		{ if ((vehicle _x != _x) && alive _x) then {}else{vehicle _x setDamage 1;};}forEach (_this select 0);
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
                              
                {deletemarkerlocal _x}foreach _markers;
                
	};      
        
/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};