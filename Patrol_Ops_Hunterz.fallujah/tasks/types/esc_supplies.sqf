diag_log [time, diag_fps, daytime, "##### POPS HZ TASK ##### Escort Supplies #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

/*-------------------- TASK PARAMS ---------------------------------*/
_downPayment = 100000;
_supplyTime = 1800;
_penaltyPerLostContainer = 20000;
_penaltyPerLostWorker = 50000;

// in case the mission turns into a defend task
_EnemySpawnMinimumRange = 2000;
_taskRadius = 15;
_minSquadCount = 2;
_maxSquadCount = 5;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0;
_TankChance = 0;
_IFVchance = 0;
_AAchance = 0;
_CarChance = 0.55;

//Useful for justifying task-specific difficulties.
_rewardMultiplier = 1;

/*--------------------CREATE TARGET-----------------------------------*/

Hz_pops_task_auxFailCondition = false;
_supplyTypes = ["Land_PaperBox_01_open_water_F","Land_PaperBox_01_open_boxes_F","Land_FoodSacks_01_large_white_idap_F","Land_PlasticCase_01_large_idap_F"];
_escortTypes = ["C_IDAP_Man_AidWorker_03_F","C_IDAP_Man_AidWorker_04_F","C_IDAP_Man_AidWorker_06_F","C_IDAP_Man_AidWorker_05_F","C_IDAP_Man_AidWorker_02_F","C_IDAP_Man_AidWorker_09_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_AidWorker_07_F","C_IDAP_Man_AidWorker_01_F"];

_spawnpos = markerpos "return_point_west";
_containers = [];
_workers = [];

_taskid = format["%1%2%3",round (_spawnpos select 0),round (_spawnpos select 1),(round random 999)];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

for "_i" from 1 to 6 do {

	_cont = (_supplyTypes call mps_getRandomElement) createVehicle _spawnpos;
	[_cont, 300] call ace_cargo_fnc_setSize;
	_containers pushBack _cont;
	
};

_workergrp = creategroup civilian;

for "_i" from 1 to 4 do {

	_worker = _workergrp createUnit [(_escortTypes call mps_getRandomElement), _spawnpos, [], 10, "NONE"];
	_worker setVariable ["Hz_ambw_disableSideRelations",true,true];
	_workers pushBack _worker; 

};

_workergrp deleteGroupWhenEmpty true;

{

	_x setvariable ["workers",_workers,true];
	
	_x forcespeed 0;

	[_x,["<t color=""#00FF00"">Request to follow</t>",{

		_dudes = (_this select 0) getvariable "workers";
	
		_dudes joinsilent grpNull;
		_dudes joinsilent (group (_this select 1));
		
		{_x forcespeed -1} foreach _dudes;

	}, [], 1, true, true, "", "(!captive _target) && (alive _target) && ((group _target) != (group _this))"]] remoteexeccall ["addAction",0,true];
	
	_x addMPEventHandler ["MPKilled",{
	
		_dude = _this select 0;
		_killer = _this select 1;
		
		if (!local _dude) exitWith {};
		
		_condition = false;
		
		if (isplayer _killer) then {_condition = true;} else {
			
			//hit and run detection
			if (_dude == _killer) then {
				
				//civ might be sent away so keep radius large
				_nearCars = _dude nearEntities [["LandVehicle"],30];
				
				{
					
					if (((speed _x) > 10) && (isplayer (driver _x))) exitwith {_condition = true;};
					
				} foreach _nearCars;
				
			};
			
		};	
		
		if (_condition) then {Hz_pops_task_auxFailCondition = true; publicVariable "Hz_pops_task_auxFailCondition";};
	
	}];

} foreach _workers;

_rand = random 1;

_locationDescription = "";
_position = [0,0,0];

switch (true) do {

	case (_rand < 0.33) : {

		_position = [4637.1,2359.13,0];
		_locationDescription = "the old army base";

	};

	case (_rand < 0.66) : {

		_position = [3526.63,6819.39,0];
		_locationDescription = "the train station";

	};
	
	default {

		_position = [8984.87,9105.5,0];
		_locationDescription = "Mukhtar village";

	};

};

_crowdGrp = creategroup civilian;
_crowd = [];

for "_i" from 1 to (6 + (round random 15)) do {

	_type = Hz_ambw_hostileCivTypes call mps_getrandomelement;
	
	_civ = _crowdGrp createUnit [ _type, _position, [], 10, "CAN_COLLIDE"];
	_crowd pushBack _civ;
	_civ setdir (random 360);
	_civ forceSpeed 0;
	
	_civ setSkill 0;
	removeAllWeapons _civ;
	removeAllItems _civ;
	
	if ((random 1) > 0.96) then {_civ addweapon "B_OutdoorPack_tan";}; 

};

_crowdGrp deleteGroupWhenEmpty true;

/*------------------- INTENSIFY AMBIENT COMBAT------------------------------------*/

missionload = false;
publicVariable "missionload";
/*
Hz_max_ambient_units = Hz_max_ambient_units + Hz_ambient_units_intensify_amount;
publicVariable "Hz_max_ambient_units";
Hz_max_allunits = Hz_max_allunits + Hz_ambient_units_intensify_amount;
publicVariable "Hz_max_allunits";
*/
/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = (_containers + _workers); publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[format["TASK%1",_taskid],
"Escort Supplies",
format["The population in parts of Iraq have been seriously affected by the sudden conflict. A lot of them remain trapped in battle zones around Fallujah, with no option to escape. IDAP want to do something about it, and they need our help. Aid workers are standing by at the airbase with supplies. The supplies need to be transported to %1, where the aid workers will distribute them. Insurgent factions in the region frequently raid supply convoys to take them for themselves, and that's where you come in. Keep the delivery and workers safe and we'll get paid.", _locationDescription],
true,
[format["MARK%1",_taskid],(_position),"mil_objective","ColorGreen"," Deliver Supplies"],
"created",
_position
] call mps_tasks_add;

/*----------------------------------------WAIT---------------------------------*/

waitUntil {

	sleep 5;
	(
		 (({captive _x} count _workers) > 0)
	|| ((count (units _workergrp)) < 1)
	|| (({alive _x} count _containers) < 1)
	|| (({alive _x} count _workers) < 1)
	|| Hz_pops_task_auxFailCondition
	)

};

if (
		!Hz_pops_task_auxFailCondition
		&& (({alive _x} count _containers) > 0)
		&& (({alive _x} count _workers) > 0)
		) then {

			(format ["The workers will need about %1 minutes to distribute the supplies to the population. Make sure they're undisturbed and can work safely with the supplies at the drop zone.",round (_supplyTime/60)]) remoteExecCall ["hint",0,false];
	
};

_spawnedSquads = (_minSquadCount max (round (random _maxSquadCount)));
hz_reward = 1;
_otherReward = _otherReward + (_downPayment/_rewardMultiplier);

_lastAliveContainerCount = 6;
_lastAliveWorkerCount = 4;

_waitForArrival = false;
if ((random 1) < 0.5) then {
	_waitForArrival = true;
};

waituntil {

	{
		if (alive _x) exitWith {(units group _x) call Hz_fnc_noSideCivilianCheck};
	} foreach _workers;
	
	{_x call Hz_fnc_noCaptiveCheck} foreach _workers;

	sleep 5;
	
	_count = {alive _x} count _workers;
	if (_count < _lastAliveWorkerCount) then {
	
		_lastAliveWorkerCount = _count; 
		_otherReward = _otherReward - (_penaltyPerLostWorker/_rewardMultiplier);
		
	};
	
	_count = {alive _x} count _containers;
	if (_count < _lastAliveContainerCount) then {
	
		_lastAliveContainerCount = _count; 
		_otherReward = _otherReward - (_penaltyPerLostContainer/_rewardMultiplier);
		
	};
	
	[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;

	(
	(if (!_waitForArrival) then {({(_x distance _spawnpos) > 1000} count _workers) > 0} else {({(_x distance _position) < 200} count _workers) > 0})
	|| (({alive _x} count _containers) < 1)
	|| (({alive _x} count _workers) < 1)
	|| Hz_pops_task_auxFailCondition
	)
	
};


/*--------------------CREATE ENEMY NEAR LOCATION---------------------------------*/

_troops = [];

if(_spawnedSquads > 0) then {

	for "_i" from 1 to _spawnedSquads do {
		
		//exit spawn loop and transfer to reinforcements script if too many units present on map
		if((count allunits) > Hz_max_allunits) exitwith {_r = (_spawnedSquads - _i) + 1; [_EnemySpawnMinimumRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] spawn Hz_task_reinforcements;};
		
		_tempos = [_position,_EnemySpawnMinimumRange] call Hz_func_findspawnpos;
		
		_grp = [ _tempos,"INS",24 + random 24,300 ] call CREATE_OPFOR_SQUAD;
		
		_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] call Hz_func_opforVehicleSupport;
		_vehicletypes = _Vehsupport select 0;
		_otherReward = _otherReward + (_Vehsupport select 1);
		
		if((count _vehicletypes) > 0) then { 
			
			_car_type = _vehicletypes call mps_getRandomElement;
			_vehgrp = [_car_type,(SIDE_C select 0),_tempos,100] call mps_spawn_vehicle;
			sleep 1;
			patrol_task_vehs set [count patrol_task_vehs, vehicle (leader _vehgrp)];
			(units _vehgrp) joinSilent _grp;
			sleep 1;
			deleteGroup _vehgrp;
			
		};
		
		patrol_task_units = patrol_task_units + (units _grp);
		sleep 1;
		if(!isnil "Hz_AI_moveAndCapture") then {
			
			_spawnedVehs = [_grp, _position,mps_opfor_ins_truck,mps_opfor_ins_ncov,1000] call Hz_AI_moveAndCapture;  

			patrol_task_vehs = patrol_task_vehs + _spawnedVehs;					 
			
		} else {
			
			_wp = _grp addWaypoint [_position,20];
			_wp setWaypointType "SAD";
			
		};
		
		//unbunching delay
		sleep 450;
	};
};

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

_supplyBar = 0;
_stanceWarningDone = false;

while { 

    (call Hz_fnc_taskSuccessCheckGenericConditions)
		&& (({alive _x} count _containers) > 0)
	  && (({alive _x} count _workers) > 0)
		&& !Hz_pops_task_auxFailCondition
		&& (_supplyBar < _supplyTime)
    
    } do {

	{
		if (alive _x) exitWith {(units group _x) call Hz_fnc_noSideCivilianCheck};
	} foreach _workers;
	
	{_x call Hz_fnc_noCaptiveCheck} foreach _workers;
	
	uisleep 1;
	
	if (
	
		(({if (alive _x) then {(_x distance _position) < _taskRadius} else {true}} count _containers) == 6)
		&& (({if (alive _x) then {((_x distance _position) < _taskRadius) && ((vehicle _x) == _x) && (!captive _x)} else {true}} count _workers) == 4)
	
	) then {
	
		_exit = false;
		if (!_stanceWarningDone) then {

			if (({if (alive _x) then {(stance _x) == "STAND"} else {true}} count _workers) != 4) then {
			
				"The workers won't be able to work if they are not standing up." remoteExecCall ["hint",0,false];
				_exit = true;
				_stanceWarningDone = true;
			
			};
		
		};		
		if (_exit) exitWith {};
		
		_supplyBar = _supplyBar + 1;
	
	};
	
	if (_supplyBar == 1) then { "The workers are now distributing the supplies. Provide security until they finish." remoteExecCall ["hint",0,false]; };
	
	_count = {alive _x} count _workers;
	if (_count < _lastAliveWorkerCount) then {
	
		_lastAliveWorkerCount = _count; 
		_otherReward = _otherReward - (_penaltyPerLostWorker/_rewardMultiplier);
		
	};
	
	_count = {alive _x} count _containers;
	if (_count < _lastAliveContainerCount) then {
	
		_lastAliveContainerCount = _count; 
		_otherReward = _otherReward - (_penaltyPerLostContainer/_rewardMultiplier);
		
	};
	
	[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;
	
};       

switch (true) do {

case (_supplyBar >= _supplyTime) : {
		
		"The supplies have reached the population. Return the workers to base ASAP." remoteExecCall ["hint",0,false];

		waituntil {

			{
				if (alive _x) exitWith {(units group _x) call Hz_fnc_noSideCivilianCheck};
			} foreach _workers;
	
			{_x call Hz_fnc_noCaptiveCheck} foreach _workers;

			sleep 5;
			
			_count = {alive _x} count _workers;
			if (_count < _lastAliveWorkerCount) then {
			
				_lastAliveWorkerCount = _count; 
				_otherReward = _otherReward - (_penaltyPerLostWorker/_rewardMultiplier);
				
			};
	
			[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;

			(
			!(call Hz_fnc_taskSuccessCheckGenericConditions)
			|| (({if (alive _x) then {((_x distance _spawnpos) < 15) && (!captive _x)} else {true}} count _workers) == 4)
			|| Hz_pops_task_auxFailCondition
			)
		};
		
		if (!(call Hz_fnc_taskSuccessCheckGenericConditions)) then {
		
			"We've taken too many casualties for this mission. We're aborting. RTB immediately!" remoteExecCall ["hint",0,false];		
		
		};
		
		if (Hz_pops_task_auxFailCondition) then {
		
			"You killed one of the workers!" remoteExecCall ["hint",0,false];
		
		};

	};
	
	case (Hz_pops_task_auxFailCondition) : {

		"You killed one of the workers!" remoteExecCall ["hint",0,false];

	};
	
	case (hz_reward <= 0) : {
			
		"We've taken too many casualties for this mission. We're aborting. RTB immediately!" remoteExecCall ["hint",0,false];
			
	};
		
	case (({alive _x} count _workers) < 1) : {
			
		"We lost all the workers, abort mission!" remoteExecCall ["hint",0,false];
			
	};
	
	case ((({alive _x} count _containers) < 1) && (_supplyBar < _supplyTime)) : {
			
		"We lost all the supplies, abort mission!" remoteExecCall ["hint",0,false];
			
	};

};

if (hz_reward > 0) then {

	hz_reward = ceil hz_reward;

};

/*------------------- INTENSIFY AMBIENT COMBAT---------------------------*/
/*
Hz_max_ambient_units = Hz_max_ambient_units - Hz_ambient_units_intensify_amount;
publicVariable "Hz_max_ambient_units";
Hz_max_allunits = Hz_max_allunits - Hz_ambient_units_intensify_amount; 
publicVariable "Hz_max_allunits";
*/
/*--------------------CHECK IF SUCCESSFUL---------------------------------*/
if( (_supplyBar >= _supplyTime) && (({ alive _x } count _workers) > 0) && (call Hz_fnc_taskSuccessCheckGenericConditions) && !Hz_pops_task_auxFailCondition) then {

	[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;             
	
	call Hz_fnc_taskReward;
	
}else{
	[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

{
	if(alive _x) then {
		_veh = vehicle _x;
		if (_veh == _x) then {							
			deletevehicle _x;							
		} else {							
			_veh deleteVehicleCrew _x;							
		};
	};
} foreach _workers;
{deletevehicle _x} foreach _containers;

/*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       

[patrol_task_units,_position,patrol_task_vehs,_crowd] spawn {
	
	private ["_units","_vehs","_markers"];
	_units = _this select 0;
	_pos = _this select 1;
	_vehs = _this select 2;
	
	while{({(_x distance _pos) < 1500} count playableunits) > 0} do { sleep 60 };
	{	
		_veh = vehicle _x;
		if (_veh == _x) then {							
			deletevehicle _x;							
		} else {							
			_veh deleteVehicleCrew _x;							
		};
	}forEach _units;
	{deletevehicle _x}forEach (_this select 3);
	{deletevehicle _x}forEach _vehs;
	
};      

/*--------------------RESET INTEL---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";