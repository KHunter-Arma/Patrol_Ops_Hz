diag_log [time, diag_fps, daytime, "##### POPS HZ TASK ##### Defend Base #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

private ["_EnemySpawnMinimumRange", "_taskRadius", "_minSquadCount", "_maxSquadCount", "_basePos", "_baseDefenderLocations", "_baseDefenderType", "_baseDefenderSquadSize", "_mapObjIDsToDisableRender", "_editorObjsToDisableRender", "_editorObjsToDelete", "_CASchance", "_TankChance", "_IFVchance", "_AAchance", "_CarChance", "_rewardMultiplier", "_position", "_taskid", "_otherReward", "_dude", "_grp", "_wait", "_b", "_spawnpos", "_r", "_i", "_Vehsupport", "_vehicletypes", "_grpLeader", "_car_type", "_vehgrp", "_spawnedVehs", "_wp", "_nearObj", "_group", "_target"];

/*-------------------- TASK PARAMS ---------------------------------*/
_EnemySpawnMinimumRange = 3000;
_taskRadius = 1500;
_minSquadCount = 3;
_maxSquadCount = 6;

_basePos = [8113.73,2261.58,0];

_baseDefenderLocations = [[8172.02,2200.39,0],[7800.5,1834.66,0],[8124.44,2461.57,0]];
_baseDefenderType = "USAF_SecurityForces_rifleman_Hz";
_baseDefenderSquadSize = 12;

//Allows to locally (where taskmaster is running) hide objects so AI can pass through them (e.g. fences etc.)
_mapObjIDsToDisableRender = [313447,313449,399225,162792,163293,96500,165857,168348,168798,169419,169993,170882,171166,171057,171856,174669,176475,177174,190861,192285,192542,192562,192565,192592,192615,192662,192697,192755,192784,192817,192846,192921,192932,192694,193035,193088,193215,193230,193229,193271,195420,195717,195875,196064,196912,196913,197256,197608,197998,198129,198280,198479,198448,198259,198571,198844,199099,199309,199435,199577,199735,199748,200070,200105,200134,200368,205422,210380,210536];
_editorObjsToDisableRender = [Gate_E,Gate_W,Gate_N];
//Allows to get rid of ambient units or vehicles that aren't there to fight
_editorObjsToDelete = [amb1,amb2,amb3,amb4,amb5,amb6,amb7,amb8,amb9];

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0;
_TankChance = 0.3;
_IFVchance = 0.3;
_AAchance = 0.3;
_CarChance = 0.75;

//Useful for justifying task-specific difficulties.
_rewardMultiplier = 1.2;

/*--------------------CREATE LOCATION---------------------------------*/

_position = _basePos;
_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

{

	if (!isnil {_x}) then {
		_x hideObject true;
	};

} foreach _editorObjsToDisableRender;

{

	(_position nearestObject _x) hideObject true;

} foreach _mapObjIDsToDisableRender;

{
	if (!isnil {_x}) then {
		_x remoteExecCall ["deleteVehicle",_x,false];
	};
} foreach _editorObjsToDelete;

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[ format["TASK%1",_taskid],
"New Mission Received",
"We've just got intel that local insurgents provoked by Takistan are planning an attack on the US Airbase. We're here to keep our client's interests secure, so keep any hostiles away!",
(SIDE_A select 0),
[],
"created",
_position
] call mps_tasks_add;

/*--------------------CREATE DEFENDERS ---------------------------------*/

{
	_group = createGroup (SIDE_A select 0);

	for "_i" from 1 to _baseDefenderSquadSize do {

		_dude = _group createUnit [_baseDefenderType, _x, [], 50, "NONE"];
		_dude setskill 0.1;
		_dude setskill ["spotDistance",1];
		_dude setskill ["spotTime",1];
		_dude setskill ["courage",1];
		_dude setskill ["commanding",1];
		_dude setskill ["aimingSpeed",0.8];
		_dude setskill ["aimingAccuracy",0.15];	
		_dude setskill ["aimingShake",0.15];
		_dude setunitPosWeak "MIDDLE";

	};
	
	_group setformation "LINE";
	_group setCombatMode "YELLOW";
	_group setVariable ["Hz_defending",true];

	_group deleteGroupWhenEmpty true;

} foreach _baseDefenderLocations;

/*--------------------WAIT UNTIL PLAYERS ARRIVE---------------------------------*/

while{ (({ (side _x) == (SIDE_A select 0)} count (_position nearEntities [["CAManBase", "LandVehicle", "StaticWeapon", "Ship", "Air"],_taskRadius])) == 0)} do { sleep 5 };

Hz_econ_combatStore_storeClosed = true;
publicVariable "Hz_econ_combatStore_storeClosed";
Hz_econ_vehicleStore_storeClosed = true;
publicVariable "Hz_econ_vehicleStore_storeClosed";
Hz_pops_disableStore = true;
publicVariable "Hz_pops_disableStore";

[John,["<t color='#e01414'>Hunter'z Combat Store</t>",{hint "You actually expect me to handle weapons in this mess?!"},[],1.5,false,true,"","(alive _target) && {!(_target call Hz_fnc_isUncon)}"]] remoteExecCall ["addAction",0,true];

[0, {

	John addMagazines ["CUP_15Rnd_9x19_M9",15];	
	John addWeapon "CUP_hgun_M9";	
	//John setUnitPos "MIDDLE";
	
	_grp = group John;	
	_grp setBehaviour "SAFE";
	_grp setCombatMode "YELLOW";
	
	{
	
		_x enableAI "MOVE";
		_x enableAI "PATH";
		_x enableAI "TARGET";
		_x enableAI "AUTOTARGET";
		_x enableAI "FSM";
		_x setUnitPos "MIDDLE";
		_x setSkill 0.2;
		_x setVariable ["Hz_noMove", false]; 
		_x setVariable ["Hz_disableFSM", false];
		
		/*
		_x addEventHandler ["Hit",{
		
			{
			
				_x enableAI "PATH";
				_x forceSpeed -1;
			
			} foreach (units group (_this select 0));
		
		}];
		*/
	} foreach (units _grp);
	
}] call CBA_fnc_globalExecute;

/*------------------------- TIMER ---------------------------------------------*/  

"Intel reports you have less than 30 minutes before the main force arrives. Get ready!" remoteExecCall ["hint",0,false];


_wait = 300;
_wait = _wait + random 300;
sleep _wait;


/*--------------------CREATE ENEMY NEAR LOCATION---------------------------------*/

_b = (_minSquadCount max (round (random _maxSquadCount)));

_spawnpos = [_position,_EnemySpawnMinimumRange] call Hz_func_findspawnpos;

if(_b > 0) then { 
	
	for "_i" from 1 to _b do {
		
		//exit spawn loop and transfer to reinforcements script if too many units present on map
		if((count allunits) > Hz_max_allunits) exitwith {_r = (_b - _i) + 1; [_EnemySpawnMinimumRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] call Hz_task_reinforcements;};

		_grp = [ _spawnpos,"INS",48 + (random 48),300 ] call CREATE_OPFOR_SQUAD;
		
		_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] call Hz_func_opforVehicleSupport;
		_vehicletypes = _Vehsupport select 0;
		_otherReward = _otherReward + (_Vehsupport select 1);
		
		_grpLeader = objNull;
		
		if((count _vehicletypes) > 0) then { 
			
			_car_type = _vehicletypes call mps_getRandomElement;
			_vehgrp = [_car_type,SIDE_C,_spawnpos,100] call mps_spawn_vehicle;
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
		sleep 450;
		
	};
};   

sleep 30;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
hz_reward = 1;
_nearObj = _position nearEntities [["CAManBase", "LandVehicle", "StaticWeapon", "Ship", "Air"],_taskRadius];
while{ 

    /*(({(side _x) == (SIDE_A select 0)} count _nearObj != 0) || ({(side _x) == (SIDE_C select 0)} count _nearObj == 0))
    &&*/ (call Hz_fnc_taskSuccessCheckGenericConditions)
    && { reinforcementsqueued || {({(alive _x) && {!(_x call Hz_fnc_isUncon)}} count patrol_task_units) > ((count patrol_task_units) / 10)}}
    } do { 
	
	sleep 15;
	
	[_b,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;
	_nearObj = _position nearEntities [["CAManBase", "LandVehicle", "StaticWeapon", "Ship", "Air"],_taskRadius];
	
};  

//sleep for a bit to allow friendlies to make sure they're clear
sleep 180;

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/  

if((call Hz_fnc_taskSuccessCheckGenericConditions) /*&& (({(side _x) == (SIDE_A select 0)} count (_position nearEntities [["CAManBase", "LandVehicle", "StaticWeapon", "Ship", "Air"],_taskRadius])) != 0)*/) then {
	[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;             
	
	call Hz_fnc_taskReward;
	
}else{
	[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
};

/*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       

// No cleanup for this task needed... get your damn base back in action...
