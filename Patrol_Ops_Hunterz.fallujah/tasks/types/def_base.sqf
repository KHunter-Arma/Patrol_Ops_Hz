diag_log [time, diag_fps, daytime, "##### POPS HZ TASK ##### Defend Base #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

/*-------------------- TASK PARAMS ---------------------------------*/
_EnemySpawnMinimumRange = 3000;
_taskRadius = 1500;
_minSquadCount = 4;
_maxSquadCount = 10;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0;
_TankChance = 0;
_IFVchance = 0;
_AAchance = 0;
_CarChance = 0.6;

//Useful for justifying task-specific difficulties.
_rewardMultiplier = 0.5;

/*--------------------CREATE LOCATION---------------------------------*/

//These are markers placed in editor
_position = markerpos "BASE";
_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[ format["TASK%1",_taskid],
"Defend Base",
"We've just got intel that local insurgents provoked by Takistan are planning an attack on the US Airbase. We're here to keep our client's interests secure, so keep any hostiles away!",
(SIDE_A select 0),
[format["MARK%1",_taskid],(_position),"mil_objective","ColorBlue"," Defend"],
"created",
_position
] call mps_tasks_add;

/*--------------------CREATE DEFENDERS ---------------------------------*/

_group = createGroup (SIDE_A select 0);

for "_i" from 1 to 12 do {

_group createUnit ["USAF_SecurityForces_rifleman_Hz", [8172.02,2200.39,0], [], 70, "NONE"];

};

_group = createGroup (SIDE_A select 0);

for "_i" from 1 to 12 do {

_group createUnit ["USAF_SecurityForces_rifleman_Hz", [7800.5,1834.66,0], [], 50, "NONE"];

};

/*--------------------WAIT UNTIL PLAYERS ARRIVE---------------------------------*/

while{ (({ (side _x) == (SIDE_A select 0)} count (nearestObjects [_position,["CAManBase"],_taskRadius])) == 0)} do { sleep 5 };

Hz_econ_combatStore_storeClosed = true;
publicVariable "Hz_econ_combatStore_storeClosed";
Hz_pops_disableStore = true;
publicVariable "Hz_pops_disableStore";

[John,["<t color='#e01414'>Hunter'z Combat Store</t>",{hint "You actually expect me to handle weapons in this mess?!"}]] remoteExecCall ["addAction",0,true];

[0, {

	John addMagazines ["CUP_15Rnd_9x19_M9",15];	
	John addWeapon "CUP_hgun_M9";	
	John setUnitPos "MIDDLE";
	
	_grp = group John;	
	_grp setBehaviour "AWARE";
	_grp setCombatMode "GREEN";
	
	{
	
		_x enableAI "MOVE";
		_x forceSpeed -1;
	
	} foreach (units _grp);
	
}] call CBA_fnc_globalExecute;

/*------------------------- TIMER ---------------------------------------------*/  

"Intel reports you have less than 30 minutes before the main force arrives. Get ready!" remoteExecCall ["hint",0,false];

/*
_wait = 120;
_wait = _wait + random 300;
sleep _wait;
*/

/*--------------------CREATE ENEMY NEAR LOCATION---------------------------------*/

_b = (_minSquadCount max (round (random _maxSquadCount)));

_spawnpos = [_position,_EnemySpawnMinimumRange] call Hz_func_findspawnpos;

if(_b > 0) then { 
	
	for "_i" from 1 to _b do {
		
		//exit spawn loop and transfer to reinforcements script if too many units present on map
		if((count allunits) > Hz_max_allunits) exitwith {_r = (_b - _i) + 1; [_EnemySpawnMinimumRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] spawn Hz_task_reinforcements;};

		_grp = [ _spawnpos,"INS",24 + (random 24),300 ] call CREATE_OPFOR_SQUAD;
		
		_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] call Hz_func_opforVehicleSupport;
		_vehicletypes = _Vehsupport select 0;
		_otherReward = _otherReward + (_Vehsupport select 1);
		
		_grpLeader = objNull;
		
		if((count _vehicletypes) > 0) then { 
			
			_car_type = _vehicletypes call mps_getRandomElement;
			_vehgrp = [_car_type,(SIDE_C select 0),_spawnpos,100] call mps_spawn_vehicle;
			_grpLeader = leader _vehgrp;
			sleep 0.1;
      patrol_task_vehs pushback (vehicle (leader _vehgrp));
			(units _vehgrp) joinSilent _grp;
			sleep 0.1;
			deleteGroup _vehgrp;
			_grp selectleader _grpLeader;
			
		};
		
		patrol_task_units = patrol_task_units + (units _grp);
		
		if(!isnil "Hz_AI_moveAndCapture") then {
			
			_spawnedVehs = [_grp, _position,mps_opfor_ins_truck,mps_opfor_ins_ncov,2000] call Hz_AI_moveAndCapture;  

			patrol_task_vehs = patrol_task_vehs + _spawnedVehs;					 
			
		} else {
			
			_wp = _grp addWaypoint [_position,50];
			_wp setWaypointType "SAD";
			
		};
				
		//unbunching delay
		//increase this to make path finding easier? (more units with waypoints, less FPS...)
		sleep 900;
		
	};
};   

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
hz_reward = 1;
_nearObj = nearestObjects [_position,["CAManBase"],_taskRadius];
while{ 

    (({(side _x) == (SIDE_A select 0)} count _nearObj != 0) || ({(side _x) == (SIDE_C select 0)} count _nearObj == 0))
    && (call Hz_fnc_taskSuccessCheckGenericConditions)
    && (({if (!isnull _x) then {(side _x) == (SIDE_C select 0)} else {false}} count patrol_task_units) > (1*(count patrol_task_units) / 10))
		&& !reinforcementsqueued
    
    } do { 
	
	sleep 15;
	
	[_b,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;
	_nearObj = nearestObjects [_position,["CAManBase"],_taskRadius];
	
};       

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/  

if((call Hz_fnc_taskSuccessCheckGenericConditions) && ({(side _x) == (SIDE_A select 0)} count nearestObjects[_position,["CAManBase","LandVehicle","Air"],_taskRadius] != 0)) then {
	[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;             
	
	call Hz_fnc_taskReward;
	
}else{
	[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
};

/*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       

// No cleanup for this task needed... get your damn base back in action...

/*

[patrol_task_units,_position,patrol_task_vehs] spawn {
	
	
	private ["_units","_vehs","_markers"];
	_units = _this select 0;
	_vehs = _this select 2;
	
	while{ ({(_x distance _pos) < 1500} count playableUnits) > 0} do { sleep 60 };
	{deletevehicle _x}forEach _units;
	{deletevehicle _x}forEach _vehs;
	
};      

*/

/*--------------------RESET INTEL---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";