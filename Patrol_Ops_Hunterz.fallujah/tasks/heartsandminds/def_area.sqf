diag_log [time, diag_fps, daytime, "##### POPS HZ HM TASK ##### Defend Civilian Area #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

private ["_reinforcementsMinimumSpawnRange", "_ambientCombatIntensifyAmount", "_downPayment", "_minDefendingSquadCount", "_maxDefendingSquadCount", "_DefenseRadius", "_minGarrisonedSquadCount", "_maxGarrisonedSquadCount", "_minPatrollingSquadCount", "_maxPatrollingSquadCount", "_minStaticWeapon", "_maxStaticWeapon", "_CASchance", "_TankChance", "_IFVchance", "_AAchance", "_CarChance", "_SniperChance", "_TowerChance", "_rewardmultiplier", "_rewardMultiplier", "_position", "_closedPositions", "_ins", "_buildings", "_houses", "_building", "_posB", "_nearbuildings", "_taskid", "_otherReward", "_enemySide", "_powtype", "_powgrp", "_pow1", "_powPos", "_targetBuilding", "_guardPositions", "_unit", "_staticguns", "_staticgrp", "_snipers", "_d", "_grpgar", "_b", "_r", "_i", "_tempos", "_grppat", "_Vehsupport", "_vehicletypes", "_car_type", "_vehgrp", "_c", "_grpdef", "_veh", "_target","_randomChoice"];

/*-------------------- TASK PARAMS ---------------------------------*/
_EnemySpawnMinimumRange = 4000;
_taskRadius = 500;
_minSquadCount = 1;
_maxSquadCount = 1;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0;
_TankChance = 0;
_IFVchance = 0;
_AAchance = 0;
_CarChance = 1.0;

//Unused
_rewardmultiplier = 1;

/*----------------------------SETUP CIV-------------------------------*/

Hz_pops_heartsandmindsTaskRequester remoteExecCall ["doStop", Hz_pops_heartsandmindsTaskRequester];
[Hz_pops_heartsandmindsTaskRequester, "PRIVATE"] remoteExecCall ["setRank", Hz_pops_heartsandmindsTaskRequester];

private _returnPos = getpos Hz_pops_heartsandmindsTaskRequester;

Hz_pops_heartsandmindsTaskRequester setVariable ["holdingPos", false, true];
[Hz_pops_heartsandmindsTaskRequester,["<t color=""#00FF00"">Request to follow</t>",{

	params ["_vip", "_player"];
	
	if ((group _player) != (group _vip)) then {
		
			[_vip] joinsilent (group _player);
			
			sleep 1;
						
			(group _player) setFormation "DIAMOND";
			
			[_vip, _player] remoteExecCall ["doFollow", _vip];
			
	};
	
	if (_vip getVariable "holdingPos") then {
		_vip setVariable ["holdingPos", false, true];
		[_vip, "PATH"] remoteExecCall ["enableAI", _vip];
	};

}, [], 1, true, true, "", "(!(_target call Hz_fnc_isUncon)) && {alive _target} && {((group _target) != (group _this)) || {_target getvariable ""holdingPos""}}",5]] remoteexeccall ["addAction",0,true];

[Hz_pops_heartsandmindsTaskRequester,["<t color=""#FFFF00"">Hold position</t>",{

	_vip = _this select 0;
	
	_vip setVariable ["holdingPos", true, true];
	[_vip, "PATH"] remoteExecCall ["disableAI", _vip];

}, [], 0, true, true, "", "(!(_target call Hz_fnc_isUncon)) && {alive _target} && {(group _target) == (group _this)} && {!(_target getvariable ""holdingPos"")}",5]] remoteexeccall ["addAction",0,true];

/*--------------------CREATE LOCATION---------------------------------*/

_position = getpos Hz_pops_heartsandmindsTaskRequester;
_maxHouses = 0;
private _newPos = +_position;

{
	_houseCount = count (nearestObjects [_x, ["House"], 200]);
	if (_houseCount > _maxHouses) then {
		_maxHouses = _houseCount;
		_newPos = +_x;
	};
} foreach [_position, (_position vectorAdd [0,150,0]), (_position vectorAdd [0,-150,0]), (_position vectorAdd [150,0,0]), (_position vectorAdd [-150,0,0])];

_position = +_newPos;

_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[format["TASK%1",_taskid],
"Hearts and Minds: Mission Received",
"Praise Allah for sending you here now! Our homes have been getting attacked all week by one of the local tribes. Their leader is very dangerous and he has a few dozen men with guns under his command! And now they say the Takistanis are helping them too! Please, they have pillaged my neighbourhood and raped our girls. Those people are the workers of Satan, I tell you! That bastard was even smug enough to tell us they will be back today, around this time now! I am sure Allah sent you to help us just in time! Please, you must protect our town!",
(SIDE_A select 0),
[format["MARK%1",_taskid],_position,"Contact_pencilTask1","colorCivilian"," Defend"],
"created",
_position
] call mps_tasks_add;

/*------------------------- TIMER ---------------------------------------------*/  

[] spawn {
	sleep 60;

	"HQ has confirmed unusual movement in some nearby camps. They say you have about 10 minutes before they arrive. Get ready!" remoteExecCall ["hint",0,false];
};

/*--------------------CREATE ENEMY NEAR LOCATION---------------------------------*/

_b = (_minSquadCount max (round (random _maxSquadCount)));

_spawnpos = [_position,_EnemySpawnMinimumRange] call Hz_func_findspawnpos;

if(_b > 0) then { 
	
	for "_i" from 1 to _b do {
		
		//exit spawn loop and transfer to reinforcements script if too many units present on map
		if((count allunits) > Hz_max_allunits) exitwith {
			_r = (_b - _i) + 1; [_EnemySpawnMinimumRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] call Hz_task_reinforcements;
		};

		_grp = [ _spawnpos,"INS",24 + (random 24),300 ] call CREATE_OPFOR_SQUAD;
		
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
		_waituntil = time + 450;
		waituntil {
			sleep 3;
			(time > _waituntil) || {!(call Hz_fnc_taskSuccessCheckGenericConditions)}
		};

		if (!(call Hz_fnc_taskSuccessCheckGenericConditions)) exitwith {};
		
	};
};   

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
hz_reward = 1;
_nearObj = _position nearEntities [["CAManBase", "LandVehicle", "StaticWeapon", "Ship", "Air"],_taskRadius];
while{ 

    (({(side _x) == (SIDE_A select 0)} count _nearObj != 0) || ({(side _x) == (SIDE_C select 0)} count _nearObj == 0))
    && (call Hz_fnc_taskSuccessCheckGenericConditions)
    && { reinforcementsqueued || {({(alive _x) && {!(_x call Hz_fnc_isUncon)}} count patrol_task_units) > ((count patrol_task_units) / 10)}}
    } do { 
	
	sleep 10;
	
	Hz_pops_heartsandmindsTaskRequester call Hz_fnc_noCaptiveCheck;
	Hz_pops_heartsandmindsTaskRequester call Hz_fnc_noSideCivilianCheck;

	_nearObj = _position nearEntities [["CAManBase", "LandVehicle", "StaticWeapon", "Ship", "Air"],_taskRadius];
	
};

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

if (call Hz_fnc_taskSuccessCheckGenericConditions) then {

	if ((Hz_pops_heartsandmindsTaskRequester distance _returnPos) > 100) then {
	
		[Hz_pops_heartsandmindsTaskRequester,["<t color=""#FF44FF"">The town is safe now...</t>",{

				hint "Yes, thank you so much! Can you please take me to where you found me?";

		}, [], 99, true, true, "", "(alive _target) && {!(_target call Hz_fnc_isUncon)}",5]] remoteexeccall ["addAction",0,true];

	};

};


waitUntil {

	sleep 5;
	
	Hz_pops_heartsandmindsTaskRequester call Hz_fnc_noCaptiveCheck;
	Hz_pops_heartsandmindsTaskRequester call Hz_fnc_noSideCivilianCheck;
	
	((!captive Hz_pops_heartsandmindsTaskRequester)
	&& {!(Hz_pops_heartsandmindsTaskRequester call Hz_fnc_isUncon)}
	&& {(Hz_pops_heartsandmindsTaskRequester distance _returnPos) < 100}
	&& {(vehicle Hz_pops_heartsandmindsTaskRequester) == Hz_pops_heartsandmindsTaskRequester})
	|| {!(call Hz_fnc_taskSuccessCheckGenericConditions)}
	
};

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

if ((call Hz_fnc_taskSuccessCheckGenericConditions) && (({(side _x) == (SIDE_A select 0)} count (_position nearEntities [["CAManBase","LandVehicle","Air","Ship","StaticWeapon"],_taskRadius])) != 0)) then {

  [format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
  
  Hz_ambw_srel_relationsCivilian = (Hz_ambw_srel_relationsCivilian + 5) min 150;
	publicVariable "Hz_ambw_srel_relationsCivilian";
	
	"Civilian relations have improved" remoteExecCall ["hint",0];
  
} else {
  
	[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	
	switch (true) do {
		case (!alive Hz_pops_heartsandmindsTaskRequester)	: {
			(format ["%1 has died!", name Hz_pops_heartsandmindsTaskRequester]) remoteExecCall ["hint",0];			
		};
		default {};
	};
	
	sleep 10;
	
	Hz_ambw_srel_relationsCivilian = (Hz_ambw_srel_relationsCivilian - 10) max 1;
	publicVariable "Hz_ambw_srel_relationsCivilian";
	
	"Civilian relations have worsened!" remoteExecCall ["hint",0];
	
};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

_civgrp = createGroup civilian;
if (alive Hz_pops_heartsandmindsTaskRequester) then {
	Hz_pops_heartsandmindsTaskRequester remoteExecCall ["removeAllActions",0,true];
	[Hz_pops_heartsandmindsTaskRequester] joinsilent grpNull;
	[Hz_pops_heartsandmindsTaskRequester] joinsilent _civgrp;
	doStop Hz_pops_heartsandmindsTaskRequester;
};
_civgrp deleteGroupWhenEmpty true;

[Hz_pops_heartsandmindsTaskRequester] spawn {

	params ["_dude"];

	waitUntil {
		sleep 5;
		({(_x distance _dude) < 500} count playableUnits) < 1
	};
	
	if (alive _dude) then {
		deleteVehicle _dude;
	};

};

/*--------------------CLEAN UP (NEW VERSION)---------------------------------*/

[patrol_task_units,_position,patrol_task_vehs] spawn {
  
  
  private ["_units","_vehs","_markers"];
  _units = _this select 0;
	_pos = _this select 1;
  _vehs = _this select 2;
  
  while {({(_x distance _pos) < 1500} count playableunits) > 0} do { sleep 60 };
  {
		_veh = vehicle _x;
		if (_veh == _x) then {							
			deletevehicle _x;							
		} else {							
			_veh deleteVehicleCrew _x;							
		};
	}forEach _units;
  {deletevehicle _x}forEach _vehs;
};      

/*--------------------RESET INTEL---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";