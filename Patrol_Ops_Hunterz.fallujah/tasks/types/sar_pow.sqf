diag_log [time, diag_fps, daytime, "##### POPS HZ TASK ##### Search & Rescue POW #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

/*-------------------- TASK PARAMS ---------------------------------*/
_reinforcementsMinimumSpawnRange = 5000;
_ambientCombatIntensifyAmount = 80;
_downPayment = 75000;

_minDefendingSquadCount = 0;
_maxDefendingSquadCount = 1;
_DefenseRadius = 200;

_minGarrisonedSquadCount = 1;
_maxGarrisonedSquadCount = 3;

_minPatrollingSquadCount = 0;
_maxPatrollingSquadCount = 1;

_minStaticWeapon = 0;
_maxStaticWeapon = 0;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0;
_TankChance = 0;
_IFVchance = 0;
_AAchance = 0;
_CarChance = 0.3;

//Others
_SniperChance = 0.3;
_TowerChance = 0;

//Useful for justifying task-specific difficulties.
_rewardmultiplier = 1;

/*--------------------CREATE LOCATION---------------------------------*/

_position = [-5000,-5000,0];
_closedPositions = [];
_ins = true;

if ((random 1) < 0.25) then {

	_ins = false;
	_downPayment = _downPayment*1.15;

	_buildings = nearestobjects [markerpos "ao_centre",["House"],3000];
	_bigBuildings = [];
	{
	
		if ((count ([_x] call BIS_fnc_buildingPositions)) > 12) then {
		
			_bigBuildings pushback _x;
		
		};
	
	} foreach _buildings;
	
	_building = _bigBuildings call mps_getRandomElement;
	_position = [getpos _building,0,350] call Hz_func_findspawnpos;
	
	if (((str _position) == (str [(markerpos "patrol_respawn_n") select 0, (markerpos "patrol_respawn_n") select 1,0])) || ((str _position) == "[0,0,0]")) then {
	
		_position = getPos _building;
	
	};
	
	{
			
				if (lineIntersects [AGLToASL _x, AGLToASL [_x select 0,_x select 1,150]]) then {
				
					_closedPositions pushBack _x;
				
				};
			
	} foreach ([_building] call BIS_fnc_buildingPositions);		

} else {

	_SniperChance = 0;
	_TowerChance = 0;
	_posFound = false;
	
	while {!_posFound} do {

		while {(count (nearestobjects [_position,["House"],100])) < 4} do {

			_position = [markerpos "ao_centre",3500,7000] call Hz_func_findspawnpos;
		
		};

		_nearbuildings = nearestObjects [_position, ["House"],200];

		{
		
			{
			
				if (lineIntersects [AGLToASL _x, AGLToASL [_x select 0,_x select 1,150]]) then {
				
					_closedPositions pushBack _x;
				
				};
			
			} foreach ([_x] call BIS_fnc_buildingPositions);
		
		} foreach _nearbuildings;
		
		if ((count _closedPositions) > 0) then {
		
			_posFound = true;
		
		} else {
		
			_position = [-5000,-5000,0];
		
		};
	
	};

};

_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

/*--------------------CREATE TARGET-----------------------------------*/

_otherReward = _otherReward + _downPayment;

_powtype = ["PO_IA_Infantry_SF_Operator"] call mps_getRandomElement;
_powgrp = createGroup (SIDE_B select 0);
_pow1 = _powgrp createUnit [_powtype,[0,0,0],[],0,"FORM"];
_powPos = _closedPositions call mps_getRandomElement;
_pow1 setposatl _powPos;

_pow1 setCaptive true;
_pow1 setRank "private";
_pow1 allowFleeing 0;
_pow1 forceSpeed 0;
dostop _pow1;
_pow1 setUnitPos "MIDDLE";
_pow1 setDamage 0.5;
removeAllWeapons _pow1;
removeAllItems _pow1;
removeAllAssignedItems _pow1;
removeVest _pow1;
removeBackpack _pow1;
removeHeadgear _pow1;	
removeGoggles _pow1;

[_pow1, true] call ACE_captives_fnc_setHandcuffed;

sleep 1;

_powPos = getposatl _pow1;

_powBuilding = (nearestObjects [_pow1,["House"],50]) select 0;
_powBuilding setvariable ["occupied",true];

_guardPositions = [_powBuilding] call BIS_fnc_buildingPositions;
_guardPositions = _guardPositions - [_powPos];

{

	_unit = objNull;

	if (_ins) then {
	
		_unit = _powgrp createUnit [mps_opfor_ins call mps_getRandomElement,_position,[],50,"NONE"];
	
	} else {
	
		_unit = _powgrp createUnit [mps_opfor_inf call mps_getRandomElement,_position,[],50,"NONE"];
		
	};
	
	_unit forcespeed 0;
	dostop _unit;
	_unit setposatl _x;	
	_unit setUnitPos "UP";
	
	patrol_task_units pushBack _unit;

} foreach _guardPositions;

[_pow1,["<t color=""#00FF00"">Request to follow</t>",{

		(_this select 0) setCaptive false;
		[_this select 0] joinsilent (group (_this select 1));
		
		(_this select 0) forcespeed -1;

}, [], 1, true, true, "", "(alive _target) && ((group _target) != (group _this))"]] remoteexeccall ["addAction",0,true];

/*--------------------CREATE ENEMY AT LOCATION------------------------*/

_staticguns = _minStaticWeapon max (round (random _maxStaticWeapon));
if(_staticguns > 0) then {

  for "_i" from 1 to _staticguns do {

    _staticgrp = [_position] call CREATE_OPFOR_STATIC; 
    
    patrol_task_units set [count patrol_task_units, leader _staticgrp];
    patrol_task_vehs set [count patrol_task_vehs, vehicle (leader _staticgrp)];
    _otherReward = _otherReward + Hz_econ_Static_reward;

  };

};

if ((random 1) < _TowerChance) then {

  [_position] spawn CREATE_OPFOR_TOWER;

  _otherReward = _otherReward + Hz_econ_Tower_reward;

};

if ((random 1) < _SniperChance) then {

  _snipers = units ([_position] call CREATE_OPFOR_SNIPERS);

  _otherReward = _otherReward + Hz_econ_Sniper_reward*(count _snipers);
  patrol_task_units = patrol_task_units + _snipers;

};

_d = (_minGarrisonedSquadCount max (round (random _maxGarrisonedSquadCount)));

if(_d > 0) then {

  for "_i" from 1 to _d do {
	
		_grpgar = grpNull;
	
		if (_ins) then {
		
			_grpgar = [ _position,"INS",10,_DefenseRadius,"hide" ] call CREATE_OPFOR_SQUAD;
				
		} else {		
		
			_grpgar = [ _position,"INF",10,_DefenseRadius,"hide" ] call CREATE_OPFOR_SQUAD;
		
		};    
    
    patrol_task_units = patrol_task_units + (units _grpgar);
  };
};  

_b = (_minPatrollingSquadCount max (round (random _maxPatrollingSquadCount)));

if(_b > 0) then {
  
  for "_i" from 1 to _b do {
    
    //exit spawn loop and transfer to reinforcements script if too many units present on map
    if((count allunits) > Hz_max_allunits) exitwith {
		
			_r = (_b - _i) + 1;
		
			if (_ins) then {
			
				 [_reinforcementsMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] spawn Hz_task_reinforcements;
			
			} else {
			
				[_reinforcementsMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn Hz_task_reinforcements;
			
			};
			
		};
    
    _tempos = [_position,_reinforcementsMinimumSpawnRange] call Hz_func_findspawnpos;
    
    _grppat = grpNull;
		_Vehsupport = [];
		
		if (_ins) then {
		
			_grppat = [ _position,"INS",random 24,100,"patrol"] call CREATE_OPFOR_SQUAD;
			_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance, "INS"] call Hz_func_opforVehicleSupport;
		
		} else {
		
			_grppat = [ _position,"INF",random 24,100,"patrol" ] call CREATE_OPFOR_SQUAD;
			_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_func_opforVehicleSupport;
		
		};    
        
    _vehicletypes = _Vehsupport select 0;
    _otherReward = _otherReward + (_Vehsupport select 1);
    
    if((count _vehicletypes) > 0) then { 
      
      _car_type = _vehicletypes call mps_getRandomElement;
      _vehgrp = [_car_type,(SIDE_B select 0),_position,300] call mps_spawn_vehicle;
      sleep 1;
      patrol_task_vehs set [count patrol_task_vehs, vehicle (leader _vehgrp)];
      (units _vehgrp) joinSilent _grppat;
      sleep 1;
      deleteGroup _vehgrp;
      
    };
    
    patrol_task_units = patrol_task_units + (units _grppat);
    
  };
};  

_c = (_minDefendingSquadCount max (round (random _maxDefendingSquadCount)));

if(_c > 0) then {

  for "_i" from 1 to _c do {
    
    //exit spawn loop and transfer to reinforcements script if too many units present on map
    if((count allunits) > Hz_max_allunits) exitwith {
		
			_r = (_c - _i) + 1;
		
			if (_ins) then {
			
				 [_reinforcementsMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] spawn Hz_task_reinforcements;
			
			} else {
			
				[_reinforcementsMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn Hz_task_reinforcements;
			
			};
			
		};

    _tempos = [_position,_reinforcementsMinimumSpawnRange] call Hz_func_findspawnpos;
		
		_grpdef = grpNull;
		_Vehsupport = [];
		
		if (_ins) then {
		
			_grpdef = [ _position,"INS",random 24,_DefenseRadius,"standby"] call CREATE_OPFOR_SQUAD;
			_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance, "INS"] call Hz_func_opforVehicleSupport;
		
		} else {
		
			_grpdef = [ _position,"INF",random 24,_DefenseRadius,"standby" ] call CREATE_OPFOR_SQUAD;
			_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_func_opforVehicleSupport;
		
		};    
        
    _vehicletypes = _Vehsupport select 0;
    _otherReward = _otherReward + (_Vehsupport select 1);
    
    if((count _vehicletypes) > 0) then { 
      
      _car_type = _vehicletypes call mps_getRandomElement;
      _vehgrp = [_car_type,(SIDE_B select 0),_position,_DefenseRadius] call mps_spawn_vehicle;
      sleep 1;
      patrol_task_vehs set [count patrol_task_vehs, vehicle (leader _vehgrp)];
      (units _vehgrp) joinSilent _grpdef;
      sleep 1;
      deleteGroup _vehgrp;
      
    };
    
    patrol_task_units = patrol_task_units + (units _grpdef);
    
  };
}; 

/*------------------- INTENSIFY AMBIENT COMBAT------------------------------------*/
missionload = false;
publicVariable "missionload";
Hz_max_ambient_units = Hz_max_ambient_units + _ambientCombatIntensifyAmount;
publicVariable "Hz_max_ambient_units";

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = [_pow1]; publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[format["TASK%1",_taskid],
"Rescue POW",
"An Iraqi Special Forces operator is confirmed to be captured by Takistani forces during the battle in the city a few hours ago. Any intel on the situation is scarce and conflicting, so our expertise is in demand. We're hired to find and rescue the POW using whatever means necessary. Once located, extract him back to Al-Hunter Airbase.",
true,
[],
"created",
_position
] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
hz_reward = 1;
While{ _pow1 distance getMarkerPos format["return_point_%1",(SIDE_A select 0)] > 15 && alive _pow1 && (call Hz_fnc_taskSuccessCheckGenericConditions)} do {
  
  sleep 5;
  [_b+_c,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;
	
	if (((_pow1 distance2D _powPos) > 3) && (captive _pow1)) then {
	
		_pow1 call Hz_fnc_noCaptiveCheck;
	
	};
  
};

if (captive _pow1) then {

	waitUntil {sleep 2; (!captive _pow1) || (!alive _pow1) || !(call Hz_fnc_taskSuccessCheckGenericConditions)};

};

/*------------------- INTENSIFY AMBIENT COMBAT---------------------------*/
  
Hz_max_ambient_units = Hz_max_ambient_units - _ambientCombatIntensifyAmount;

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

if( alive _pow1 && (call Hz_fnc_taskSuccessCheckGenericConditions)) then {
  [format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
  
  call Hz_fnc_taskReward;
  
}else{
  [format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

deleteVehicle _pow1;

/*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       

[patrol_task_units,_position,patrol_task_vehs] spawn {
  
  
  private ["_units","_vehs","_markers"];
  _units = _this select 0;
  _vehs = _this select 2;
  
  while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 60 };
  {deletevehicle _x}forEach _units;
  {deletevehicle _x}forEach _vehs;
};      

/*--------------------RESET INTEL---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";