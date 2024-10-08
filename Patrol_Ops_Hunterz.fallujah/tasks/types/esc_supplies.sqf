diag_log [time, diag_fps, daytime, "##### POPS HZ TASK ##### Escort Supplies #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

private ["_downPayment", "_supplyTime", "_penaltyPerLostContainer", "_penaltyPerLostWorker", "_EnemySpawnMinimumRange", "_taskRadius", "_minSquadCount", "_maxSquadCount", "_CASchance", "_TankChance", "_IFVchance", "_AAchance", "_CarChance", "_rewardMultiplier", "_supplyTypes", "_escortTypes", "_spawnpos", "_containers", "_workers", "_taskid", "_otherReward", "_cont", "_workergrp", "_worker", "_dudes", "_dude", "_killer", "_condition", "_nearCars", "_rand", "_locationDescription", "_position", "_crowdGrp", "_crowd", "_type", "_civ", "_spawnedSquads", "_lastAliveContainerCount", "_lastAliveWorkerCount", "_waitForArrival", "_count", "_supplyBar", "_stanceWarningDone", "_veh", "_target"];

/*-------------------- TASK PARAMS ---------------------------------*/
_downPayment = 100000;
_supplyTime = 1800;
_penaltyPerLostContainer = 20000;
_penaltyPerLostWorker = 50000;

// in case the mission turns into a defend task
_EnemySpawnMinimumRange = 3000;
_taskRadius = 15;
_minSquadCount = 1;
_maxSquadCount = 3;

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
	_worker setVariable ["mps_interaction_disabled", true, true];
	_worker setVariable ["Hz_ambw_disableSideRelations",true,true];
	_workers pushBack _worker; 

};

_workergrp deleteGroupWhenEmpty true;

{

	_x setvariable ["workers",_workers,true];
	_x setVariable ["holdingPos", false, true];

	[_x,["<t color=""#00FF00"">Request to follow</t>",{
	
		params ["_vip", "_player"];
		
		_dudes = _vip getvariable "workers";
		
		_ungrpdDudes = _dudes select {((group _player) != (group _x)) && {alive _x}};
		if ((count _ungrpdDudes) > 0) then {
			_ungrpdDudes joinsilent (group _player);
			sleep 1;
			(group _player) setFormation "DIAMOND";
			{
				[_x, _player] remoteExecCall ["doFollow", _x];
			} foreach _ungrpdDudes;
		};
		
		if (_vip getVariable "holdingPos") then {
			_vip setVariable ["holdingPos", false, true];
			[_vip, "PATH"] remoteExecCall ["enableAI", _vip];
		};
		
	}, [], 1, true, true, "", "(!(_target call Hz_fnc_isUncon)) && {alive _target} && {((group _target) != (group _this)) || {_target getvariable ""holdingPos""}}",5]] remoteexeccall ["addAction",0,true];
	
	[_x,["<t color=""#FFFF00"">Hold position</t>",{

		_vip = _this select 0;
		
		_vip setVariable ["holdingPos", true, true];
		[_vip, "PATH"] remoteExecCall ["disableAI", _vip];

	}, [], 0, true, true, "", "(!(_target call Hz_fnc_isUncon)) && {alive _target} && {(group _target) == (group _this)} && {!(_target getvariable ""holdingPos"")}",5]] remoteexeccall ["addAction",0,true];
	
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

	_type = Hz_ambw_allCivTypes call mps_getrandomelement;
	
	_civ = _crowdGrp createUnit [ _type, _position, [], 10, "CAN_COLLIDE"];
	_crowd pushBack _civ;
	_civ setdir (random 360);
	_civ forceSpeed 0;
	
	_civ setSkill 0;
	removeAllWeapons _civ;
	removeAllItems _civ;
	
	if ((random 1) > 0.96) then {
		_civ addBackpack (selectRandom ["B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_oli", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_oli", "B_CivilianBackpack_01_Everyday_Astra_F", "B_CivilianBackpack_01_Everyday_Black_F", "B_CivilianBackpack_01_Sport_Blue_F", "B_CivilianBackpack_01_Sport_Green_F", "B_CivilianBackpack_01_Sport_Red_F", "B_Carryall_green_F", "B_FieldPack_green_F", "B_Messenger_Black_F", "B_Messenger_Coyote_F", "B_Messenger_Gray_F", "B_Messenger_Olive_F"]);
	}; 

};

_crowdGrp deleteGroupWhenEmpty true;

/*------------------- INTENSIFY AMBIENT COMBAT------------------------------------*/

Hz_ambw_pat_disablePatrols = false;
publicVariable "Hz_ambw_pat_disablePatrols";
/*
Hz_ambw_pat_maxNumOfUnits = Hz_ambw_pat_maxNumOfUnits + Hz_ambient_units_intensify_amount;
publicVariable "Hz_ambw_pat_maxNumOfUnits";
Hz_max_allunits = Hz_max_allunits + Hz_ambient_units_intensify_amount;
publicVariable "Hz_max_allunits";
*/

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[format["TASK%1",_taskid],
"New Mission Received",
format["The population in parts of Iraq have been seriously affected by the sudden conflict. A lot of them remain trapped in battle zones around Fallujah, with no option to escape. IDAP want to do something about it, and they need our help. Aid workers are standing by at the airbase with supplies. The supplies need to be transported to %1, where the aid workers will distribute them. Insurgent factions in the region frequently raid supply convoys to take them for themselves, and that's where you come in. Keep the delivery and workers safe and we'll get paid.", _locationDescription],
true,
[format["MARK%1",_taskid],(_position),"mil_objective","ColorGreen"," Deliver Supplies"],
"created",
_position
] call mps_tasks_add;

/*----------------------------------------WAIT---------------------------------*/

waitUntil {

	sleep 5;
	
	{
		_x call Hz_fnc_noCaptiveCheck;
	} foreach _workers;
	
	_workers call Hz_fnc_noSideCivilianCheck;
	
	(
		 (({_x call Hz_fnc_isUncon} count _workers) > 0)
	|| ((count (units _workergrp)) < 1)
	|| (({!alive _x} count _containers) > 0)
	|| (({!alive _x} count _workers) > 0)
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
	
	{_x call Hz_fnc_noCaptiveCheck} foreach _workers;
	_workers call Hz_fnc_noSideCivilianCheck;

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

if(_spawnedSquads > 0) then {

	//handle spawning with reinforcements script so task doesn't wait for spawn loop to finish
	[_EnemySpawnMinimumRange,_position,_spawnedSquads,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] call Hz_task_reinforcements;
	
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
	
	{_x call Hz_fnc_noCaptiveCheck} foreach _workers;
	_workers call Hz_fnc_noSideCivilianCheck;
	
	uisleep 1;
	
	if (	
		(({if (alive _x) then {(_x distance _position) < _taskRadius} else {true}} count _containers) == 6)
		&& {({if (alive _x) then {((_x distance _position) < _taskRadius) && ((vehicle _x) == _x) && (!(_x call Hz_fnc_isUncon))} else {true}} count _workers) == 4}
		&& {		
				if (({if (alive _x) then {(stance _x) == "STAND"} else {true}} count _workers) != 4) then {
					
					if (!_stanceWarningDone) then {
						_stanceWarningDone = true;
						"The workers won't be able to work if they are not standing up." remoteExecCall ["hint",0,false];				
					};					
					false	
				} else {
					true
				}
			}	
	) then {		
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
	
			{_x call Hz_fnc_noCaptiveCheck} foreach _workers;
			_workers call Hz_fnc_noSideCivilianCheck;

			sleep 5;
			
			_count = {alive _x} count _workers;
			if (_count < _lastAliveWorkerCount) then {
			
				_lastAliveWorkerCount = _count; 
				_otherReward = _otherReward - (_penaltyPerLostWorker/_rewardMultiplier);
				
			};
	
			[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;

			(
			!(call Hz_fnc_taskSuccessCheckGenericConditions)
			|| (({if (alive _x) then {((_x distance _spawnpos) < 15) && (!(_x call Hz_fnc_isUncon))} else {true}} count _workers) == 4)
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
Hz_ambw_pat_maxNumOfUnits = Hz_ambw_pat_maxNumOfUnits - Hz_ambient_units_intensify_amount;
publicVariable "Hz_ambw_pat_maxNumOfUnits";
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
