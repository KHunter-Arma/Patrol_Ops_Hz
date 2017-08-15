
private ["_location","_position","_taskid","_radius","_nearRoads","_vehicles","_nearlocations","_deathPenalty","_rewardmultiplier","_enemySpawnRange","_otherReward","_car_type","_vehgrp1","_vehgrp2","_vehgrp3","_vehgrp4","_ambience","_vehgrp5","_vehgrp6"];
diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Search and Destroy Convoy Initialise"];

/*-------------------- TASK PARAMS ---------------------------------*/

//Useful for justifying task-specific difficulties.
_rewardmultiplier = 3;
/*--------------------CREATE LOCATION---------------------------------*/

_enemySpawnRange = floor (_enemySpawnRange / (sqrt 2));

	_location = [["towns"]] call mps_getNewLocation;
	_position = [(position _location) select 0,(position _location) select 1, 0];
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
        Hz_task_ID = _taskid;
        Hz_econ_aux_rewards = 0;
        _otherReward = 0;
        
/*--------------------Get nearby Locations-----------------------------------*/

	_nearlocations = [];
	_radius = 2000;
	While{count _nearlocations < 2} do {
		_nearlocations = (nearestLocations [_position,["Name","NameVillage","NameCity","NameCityCapital"],_radius] - [_location]);
		_radius = _radius + 100;
	};
	_nearlocations = _nearlocations call mps_getArrayPermutation;

	_radius = 200;
	_nearRoads = [];
	While{count _nearRoads == 0} do {
		_nearRoads = _position nearRoads _radius;
		_radius = _radius + 100;
	};

/*--------------------CREATE TARGET-----------------------------------*/

	_car_type = (mps_opfor_car+mps_opfor_apc) call mps_getRandomElement;
	_vehgrp1 = [_car_type,(SIDE_B select 0),position (_nearRoads call mps_getRandomElement),0] call mps_spawn_vehicle; sleep 1;
        
        if (_car_type in mps_opfor_car) then {_otherReward = _otherReward + Hz_econ_Car_reward;} else {_otherReward = _otherReward + Hz_econ_IFV_reward;};
        
        _car_type = (mps_opfor_car+mps_opfor_apc) call mps_getRandomElement;
	_vehgrp2 = [_car_type,(SIDE_B select 0),position (_nearRoads call mps_getRandomElement),0] call mps_spawn_vehicle; sleep 1;
        
        if (_car_type in mps_opfor_car) then {_otherReward = _otherReward + Hz_econ_Car_reward;} else {_otherReward = _otherReward + Hz_econ_IFV_reward;};
        
        _car_type = mps_opfor_truck call mps_getRandomElement;
	_vehgrp3 = [_car_type,(SIDE_B select 0),position (_nearRoads call mps_getRandomElement),0] call mps_spawn_vehicle; sleep 1;
     
        _car_type = (mps_opfor_car+mps_opfor_apc+mps_opfor_aa) call mps_getRandomElement;
        _vehgrp4 = [_car_type,(SIDE_B select 0),position (_nearRoads call mps_getRandomElement),0] call mps_spawn_vehicle; sleep 1;
        
        if (_car_type in mps_opfor_car) then {_otherReward = _otherReward + Hz_econ_Car_reward;} else {if (_car_type in mps_opfor_aa) then {_otherReward = _otherReward + Hz_econ_AA_reward;} else {_otherReward = _otherReward + Hz_econ_IFV_reward;};};
        
        _car_type = mps_opfor_truck call mps_getRandomElement;
	_vehgrp5 = [_car_type,(SIDE_B select 0),position (_nearRoads call mps_getRandomElement),0] call mps_spawn_vehicle; sleep 1;
        
        _car_type = (mps_opfor_car+mps_opfor_apc) call mps_getRandomElement;
        _vehgrp6 = [_car_type,(SIDE_B select 0),position (_nearRoads call mps_getRandomElement),0] call mps_spawn_vehicle; sleep 1;
        
        if (_car_type in mps_opfor_car) then {_otherReward = _otherReward + Hz_econ_Car_reward;} else {_otherReward = _otherReward + Hz_econ_IFV_reward;};
        
        //reward for 2 unarmed trucks = 1 armed car? :)
        _otherReward = _otherReward + Hz_econ_Car_reward;
        
        
	_vehicles = [];
	{ _vehicles = _vehicles + [vehicle (leader _x)]; }forEach [_vehgrp1,_vehgrp2,_vehgrp3,_vehgrp4,_vehgrp5,_vehgrp6];

	(units _vehgrp2 + units _vehgrp3+ units _vehgrp4 + units _vehgrp5 + units _vehgrp6) joinSilent _vehgrp1;
	sleep 1;
        if(!isnil "zeu_Groups") then {if(!(_vehgrp1 in zeu_Groups)) then {zeu_Groups set [count zeu_Groups, _vehgrp1];};};
	{ deleteGroup _x; }forEach [_vehgrp2,_vehgrp3,_vehgrp4,_vehgrp5,_vehgrp6];


/*-------------------RANDOM INTENSIFY AMBIENT COMBAT------------------------------------*/

_ambience = false;
if((random 1) < 0.3) then {
_ambience = true;
Hz_max_ambient_units = Hz_max_ambient_units + Hz_ambient_units_intensify_amount;

};

/*--------------------MOVE TARGET TO LOCATIONS------------------------*/

	_vehgrp1 addWaypoint [_position,100];
	_vehgrp1 setBehaviour "SAFE";
	_vehgrp1 setSpeedMode "LIMITED";
	_vehgrp1 setFormation "COLUMN";

	{
		_vehgrp1 addWaypoint [position _x,100];
	} foreach _nearlocations;
	(_vehgrp1 addWaypoint [_position,100]) setWaypointtype "CYCLE";

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = _vehicles; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/
missionload = false;
	[ format["TASK%1",_taskid],
		"Disable Supply Coloumn",
		format["A supply coloumn is distributing weapons to enemy forces around %1. Locate and take out those vehicles.", text _location],
		(SIDE_A select 0),
		[format["MARK%1",_taskid],(_position),"hd_objective","ColorRed"," Column Spotted"],
		"created",
		_position
	] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
hz_reward = 1;
	while { { canMove _x; } count _vehicles > 0 && hz_reward > 0 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)} do { 
            
            sleep 15;
            hz_reward = (_otherReward + Hz_econ_aux_rewards);
            _deathPenalty = (mps_mission_deathlimit - mps_mission_deathcount) * Hz_penalty_multiplier_per_death;
            hz_reward = (hz_reward - _deathPenalty)*_rewardmultiplier;
            
        };

/*-------------------RANDOM INTENSIFY AMBIENT COMBAT---------------------------*/

if(_ambience) then {
    
Hz_max_ambient_units = Hz_max_ambient_units - Hz_ambient_units_intensify_amount;

};

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/
missionload = true;
	if( hz_reward > 0 && { canMove _x; }count _vehicles == 0 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)) then {
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
    
   /*     while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
	{ _x setDamage 1; } forEach _vehicles;
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