diag_log [time, diag_fps, daytime, "##### POPS HZ TASK ##### Defend FOB #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

private ["_EnemySpawnMinimumRange", "_taskRadius", "_minSquadCount", "_maxSquadCount", "_CASchance", "_TankChance", "_IFVchance", "_AAchance", "_CarChance", "_rewardMultiplier", "_position", "_taskid", "_otherReward", "_newComp", "_ammoCratesFilled", "_statGrp", "_guardPos", "_dude", "_defGrp", "_b", "_spawnpos", "_r", "_i", "_grp", "_Vehsupport", "_vehicletypes", "_grpLeader", "_car_type", "_vehgrp", "_spawnedVehs", "_wp", "_nearObj"];

/*-------------------- TASK PARAMS ---------------------------------*/
_EnemySpawnMinimumRange = 4000;
_taskRadius = 200;
_minSquadCount = 2;
_maxSquadCount = 3;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0;
_TankChance = 0;
_IFVchance = 0;
_AAchance = 0.1;
_CarChance = 0.6;

//Useful for justifying task-specific difficulties.
_rewardMultiplier = 1.5;

/*--------------------CREATE LOCATION---------------------------------*/

_position = [markerpos "ao_centre",2000,8000,SIDE_B select 0] call Hz_func_findspawnpos;
_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

_newComp = [_position, random 360,(call compile preprocessfilelinenumbers "Compositions\Blufor\Bases\IA_fob.sqf")] call Hz_fnc_objectsMapper; 

//init composition
_ammoCratesFilled = 0;
_statGrp = creategroup (SIDE_A select 0);
_guardPos = _position;

{
	//lock and man vehicles but not statics
  if ((_x iskindof "Car") || (_x iskindof "Tank")) then {
  
    _x setvehiclelock "LOCKEDPLAYER";
    
    if ((_x emptyPositions "gunner") > 0) then {
    
      _dude = _statGrp createUnit [mps_blufor_riflemen call mps_getRandomElement, getpos _x, [], 200, "NONE"];
      _dude assignasgunner _x;
      _dude moveingunner _x;
    
    };
  
  };
	
	if (_x isKindOf "StaticWeapon") then {
		_x enableWeaponDisassembly false;
		_x spawn {
			sleep 5;
			{deletevehicle _x} foreach (nearestObjects [_this, ["WeaponHolder"], 10]);
		};
	};
  
  if (_x iskindof "ReammoBox_F") then {
  
    clearWeaponCargoGlobal _x;
    clearItemCargoGlobal _x;
    clearMagazineCargoGlobal _x;
		clearBackpackCargoGlobal _x;
    
    _ammoCratesFilled = _ammoCratesFilled + 1;
    if (_ammoCratesFilled > 2) exitWith {};  
    
    if (_ammoCratesFilled == 1) then {
    
      _x addMagazineCargoGlobal ["ace_csw_50Rnd_127x108_mag",15];    
    
    } else {
    
      _x addMagazineCargoGlobal ["ace_csw_100Rnd_127x99_mag_red",5];
    
    };
  
  };
  
  if (_x iskindof "Land_GuardShed") then {
  
		_guardPos = ([_x] call bis_fnc_buildingpositions) select 0;
  
  };

	[_x,2] remoteExecCall ["setFeatureType",0,true];

} foreach _newComp;

_statGrp setFormation "DIAMOND";
_statGrp setVariable ["Hz_defending",true];
_statGrp setCombatMode "GREEN";

_statGrp deleteGroupWhenEmpty true;

//create defenders
_defGrp = [_position,"INF",12,10] call CREATE_BLUFOR_SQUAD;
_dude = _defGrp createUnit [mps_blufor_leader call mps_getRandomElement, _position, [], 10, "NONE"];
_dude = _defGrp createUnit [mps_blufor_riflemen call mps_getRandomElement, _position, [], 10, "NONE"];
_dude setposatl _guardPos;
_dude forcespeed 0;
_dude setUnitPos "UP";

_defGrp setFormation "DIAMOND";
_defGrp setVariable ["Hz_defending",true];
_defGrp setCombatMode "GREEN";

_defGrp deleteGroupWhenEmpty true;

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[ format["TASK%1",_taskid],
"Assist FOB",
"We've been entrusted with a delicate task. NATO Joint Operations Command contacted us early this morning about an Iraqi FOB that recently found itself to be in a strategic position. Apparently their defences are in need of a serious reorganisation. We're hired as advisors, and you are to head in there to get the place battle-ready ASAP, or the first raid that comes will probably end very badly not just for them, but all units in the region. Give them your support in fortifying the base, and watch out for any enemy movement in the meantime. If you ask the Iraqis, they say an attack may be imminent...",
(SIDE_A select 0),
[format["MARK%1",_taskid],(_position),"mil_objective","ColorBlue"," Defend"],
"created",
_position
] call mps_tasks_add;

/*--------------------WAIT UNTIL PLAYERS ARRIVE---------------------------------*/
hz_reward = 1;
while{ 

(({(_x distance _position) < _taskRadius} count playableUnits) == 0)
&&
(call Hz_fnc_taskSuccessCheckGenericConditions)

} do { sleep 5 };

_defGrp setCombatMode "YELLOW";
_statGrp setCombatMode "YELLOW";
{
	_x setunitPosWeak "MIDDLE";
} foreach units _defGrp;
{
	_x setunitPosWeak "MIDDLE";
} foreach units _statGrp;

/*------------------------- TIMER ---------------------------------------------*/  

_wait = 300;
_wait = _wait + random 300;
sleep _wait;

/*--------------------CREATE ENEMY NEAR LOCATION---------------------------------*/

_b = (_minSquadCount max (round (random _maxSquadCount)));

_spawnpos = [_position,_EnemySpawnMinimumRange] call Hz_func_findspawnpos;

if(_b > 0) then { 
	
	for "_i" from 1 to _b do {
		
		//exit spawn loop and transfer to reinforcements script if too many units present on map
		if((count allunits) > Hz_max_allunits) exitwith {_r = (_b - _i) + 1; [_EnemySpawnMinimumRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn Hz_task_reinforcements;};

		_grp = [ _spawnpos,"INF",24 + (random 24),300 ] call CREATE_OPFOR_SQUAD;
		
		_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_func_opforVehicleSupport;
		_vehicletypes = _Vehsupport select 0;
		_otherReward = _otherReward + (_Vehsupport select 1);
		
		_grpLeader = objNull;
		
		if((count _vehicletypes) > 0) then { 
			
			_car_type = _vehicletypes call mps_getRandomElement;
			_vehgrp = [_car_type,SIDE_B,_spawnpos,100] call mps_spawn_vehicle;
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
			
			_spawnedVehs = [_grp, _position,mps_opfor_truck,mps_opfor_ncov,1500] call Hz_AI_moveAndCapture;  

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

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
hz_reward = 1;
_nearObj = _position nearEntities [["CAManBase"],_taskRadius];
while{ 

    (({(side _x) == (SIDE_A select 0)} count _nearObj != 0) || ({(side _x) == (SIDE_B select 0)} count _nearObj == 0))
    && (call Hz_fnc_taskSuccessCheckGenericConditions)
    && { reinforcementsqueued || {({if (!isnull _x) then {(side _x) == (SIDE_B select 0)} else {false}} count patrol_task_units) > ((count patrol_task_units) / 10)} }
		
    } do { 
	
	sleep 15;
	
	[_b,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;
	_nearObj = _position nearEntities [["CAManBase"],_taskRadius];
	
};       

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/  

if((call Hz_fnc_taskSuccessCheckGenericConditions) && (({(side _x) == (SIDE_A select 0)} count (_position nearEntities [["CAManBase","LandVehicle","Air"],_taskRadius])) != 0)) then {
	[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;             
	
	call Hz_fnc_taskReward;
	
}else{
	[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
};

/*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       

[patrol_task_units,_position,patrol_task_vehs] spawn {
	
	
	private ["_units","_vehs","_markers"];
	_units = _this select 0;
	_position = _this select 1;
	_vehs = _this select 2;
	
	while{ ({(_x distance _position) < 1500} count playableUnits) > 0} do { sleep 60 };
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