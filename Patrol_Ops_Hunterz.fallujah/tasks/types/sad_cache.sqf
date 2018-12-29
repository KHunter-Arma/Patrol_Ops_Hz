diag_log [time, diag_fps, daytime, "##### POPS HZ TASK ##### Search & Destroy Cache #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

/*-------------------- TASK PARAMS ---------------------------------*/
_reinforcementsMinimumSpawnRange = 5000;

_minCacheCount = 1;
_maxCacheCount = 3;
_rewardPerCache = 20000;
_minDistanceBetweenCaches = 300;

_minDefendingSquadCountPerCache = 1;
_maxDefendingSquadCountPerCache = 3;
_DefenseRadius = 200;

_minGarrisonedSquadCountPerCache = 2;
_maxGarrisonedSquadCountPerCache = 3;

_minPatrollingSquadCountPerCache = 0;
_maxPatrollingSquadCountPerCache = 1;

_minStaticWeaponPerCache = 0;
_maxStaticWeaponPerCache = 0;

_intelAtCacheChance = 0.7;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0;
_TankChance = 0;
_IFVchance = 0;
_AAchance = 0;
_CarChance = 0.5;

//Useful for justifying task-specific difficulties.
_rewardmultiplier = 1;

/*--------------------CREATE LOCATION---------------------------------*/

_rewardPerCache = _rewardPerCache/_rewardmultiplier;

_caches = [];
_cacheCount = _minCacheCount max (round (random _maxCacheCount));

for "_i" from 1 to _cacheCount do {

	_position = [-5000,-5000,0];
	_closedPositions = [];

	if ((random 1) < 0.1) then {

		_buildings = nearestobjects [markerpos "ao_centre",["House"],3000];
		_bigBuildings = [];
		{
		
			_build = _x;
		
			if (((count ([_x] call BIS_fnc_buildingPositions)) > 12) && (({(_build distance _x) < _minDistanceBetweenCaches} count _caches) < 1)) then {
			
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
				
				_build = _x;
			
					if (({(_build distance _x) < _minDistanceBetweenCaches} count _caches) < 1) then {
				
					{
					
						if (lineIntersects [AGLToASL _x, AGLToASL [_x select 0,_x select 1,150]]) then {
						
							_closedPositions pushBack _x;
						
						};
					
					} foreach ([_x] call BIS_fnc_buildingPositions);
				
				};
			
			} foreach _nearbuildings;
			
			if ((count _closedPositions) > 0) then {
			
				_posFound = true;
			
			} else {
			
				_position = [-5000,-5000,0];
			
			};
		
		};

	};

	_cachePos = _closedPositions call mps_getRandomElement;
	_cache = "rhs_weapon_crate" createVehicle [-5000,500,0];
	_cache setposatl _cachePos;
	sleep 0.1;
	_caches pushBack _cache;
	
	clearItemCargoGlobal _cache;
	clearWeaponCargoGlobal _cache;
	clearMagazineCargoGlobal _cache;
	clearBackpackCargoGlobal _cache;
	
	_cache addWeaponCargoGlobal ["hlc_rifle_ak74_dirty",2];
	_cache addMagazineCargoGlobal ["hlc_30Rnd_545x39_B_AK",30];
	_cache addMagazineCargoGlobal ["rhs_rpg7_PG7V_mag",3];
	_cache addMagazineCargoGlobal ["rhs_100Rnd_762x54mmR",4];
	_cache addMagazineCargoGlobal ["hlc_30Rnd_762x39_b_ak",60];
	_cache addMagazineCargoGlobal ["5rnd_762_mos",20];
	
	_cache setVariable ["R3F_LOG_disabled",true,true];
	
	_cache addEventHandler ["Killed",{
	
		_splosion = "IEDUrbanBig_Remote_Ammo" createVehicle (getposatl (_this select 0));
		_splosion setDamage 1;
		
		mps_civilian_intel = mps_civilian_intel - [_this select 0];
		publicVariable "mps_civilian_intel";
	
	}];
	
	_cacheBuilding = (nearestObjects [_cache,["House"],50]) select 0;
	_cacheBuilding setvariable ["occupied",true];

	_guardPositions = [_cacheBuilding] call BIS_fnc_buildingPositions;
	_guardPositions = _guardPositions - [_cachePos];
	
	_cacheGrp = createGroup (SIDE_B select 0);

	{

		_unit = _cacheGrp createUnit [mps_opfor_ins call mps_getRandomElement,_cachePos,[],50,"NONE"];
		_unit forcespeed 0;
		_unit setvariable ["Hz_noMove",true];
		_unit setvariable ["Hz_clearingBuilding",true];
		dostop _unit;
		_unit setposatl _x;	
		_unit setUnitPos "UP";
		
		patrol_task_units pushBack _unit;

	} foreach _guardPositions;
			
};

if ((count _caches) > 1) then {

	{
	
		if ((random 1) < _intelAtCacheChance) then {
	
			_cache = _x;		
			while {_cache == _x} do {
			
				_cache = _caches call mps_getRandomElement;
			
			};

			_pos = getposatl _x;
			_intelPos = [_pos select 0, _pos select 1, (_pos select 2) + 0.83];
			_intel = "EvMap" createVehicle [-500,5000,0];
			_intel setVariable ["R3F_LOG_disabled",true,true];
			_intel setposatl _intelPos;
			_intel setVariable ["cachePos",getpos _cache,true];
			
			[_intel,["<t color=""#00FF00"">Check out</t>",{

				_marker = createMarkerLocal [str random 55500, (_this select 0) getVariable "cachePos"];
				_marker setmarkershapelocal "ELLIPSE";
				_marker setMarkerSizeLocal [200,150];
			  _marker setMarkerDirLocal (random 360);
				_marker setMarkerBrushLocal "Border";
				_marker setMarkerColorLocal "ColorRed";				
				openMap true;
				hint "This map has this area circled.";			
				mapAnimAdd [1, 0.5, markerPos _marker];
				mapAnimCommit;
				removeAllActions (_this select 0);

			}, [], 1, true, true, "", "(_this distance _target) < 2"]] remoteexeccall ["addAction",0,true];
		
		};

	} foreach _caches;

};

_taskid = format["%1%2%3",round random 20, round random 1222,round random 51212];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = _cacheCount*_rewardPerCache;

/*--------------------CREATE ENEMY AT LOCATION------------------------*/
	
	_totalSquads = 0;
	
{
	
	_position = getpos (_caches select _foreachIndex);

	_staticguns = _minStaticWeaponPerCache max (round (random _maxStaticWeaponPerCache));
	if(_staticguns > 0) then {

		for "_i" from 1 to _staticguns do {

			_staticgrp = [_position] call CREATE_OPFOR_STATIC; 
			
			patrol_task_units set [count patrol_task_units, leader _staticgrp];
			patrol_task_vehs set [count patrol_task_vehs, vehicle (leader _staticgrp)];
			_otherReward = _otherReward + Hz_econ_Static_reward;

		};

	};

	_d = (_minGarrisonedSquadCountPerCache max (round (random _maxGarrisonedSquadCountPerCache)));

	if(_d > 0) then {

		for "_i" from 1 to _d do {
		
			_grpgar = [ _position,"INS",6 + (random 6),_DefenseRadius,"hide" ] call CREATE_OPFOR_SQUAD;				
			
			patrol_task_units = patrol_task_units + (units _grpgar);
		};
	};  

	_b = (_minPatrollingSquadCountPerCache max (round (random _maxPatrollingSquadCountPerCache)));
	
	_totalSquads = _totalSquads + _b;

	if(_b > 0) then {
		
		for "_i" from 1 to _b do {
			
			//exit spawn loop and transfer to reinforcements script if too many units present on map
			if((count allunits) > Hz_max_allunits) exitwith {
			
				_r = (_b - _i) + 1;
			
				[_reinforcementsMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] spawn Hz_task_reinforcements;
							
			};
			
			_tempos = [_position,_reinforcementsMinimumSpawnRange] call Hz_func_findspawnpos;
				
			_grppat = [ _position,"INS",12 + (random 12),100,"patrol"] call CREATE_OPFOR_SQUAD;
			_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance, "INS"] call Hz_func_opforVehicleSupport;
					
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

	_c = (_minDefendingSquadCountPerCache max (round (random _maxDefendingSquadCountPerCache)));
	
	_totalSquads = _totalSquads + _c;

	if(_c > 0) then {

		for "_i" from 1 to _c do {
			
			//exit spawn loop and transfer to reinforcements script if too many units present on map
			if((count allunits) > Hz_max_allunits) exitwith {
			
				_r = (_c - _i) + 1;
			
				[_reinforcementsMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] spawn Hz_task_reinforcements;
							
			};

			_tempos = [_position,_reinforcementsMinimumSpawnRange] call Hz_func_findspawnpos;
			
			_grpdef = [ _position,"INS",12 + (random 12),_DefenseRadius,"standby"] call CREATE_OPFOR_SQUAD;
			_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance, "INS"] call Hz_func_opforVehicleSupport;
							
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

} foreach _caches;

missionload = false;
publicVariable "missionload";

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = +_caches; publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[format["TASK%1",_taskid],
"Destroy Insurgent Caches",
"It’s bad enough that the Takistani Army is gaining ground near Fallujah, but its proxies are making their move too. Iraqi intelligence has just discovered that one of the larger insurgent factions has begun building arms caches around the AO, which they are planning on using for sabotage missions. They might even target US establishments in the region. Question the locals to find information about any caches. Once you find a cache, look for evidence of existence of any others, and destroy any that are found.",
true,
[],
"created",
[0,0,0]
] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
hz_reward = 1;
While{ (({alive _x} count _caches) > 0) && (call Hz_fnc_taskSuccessCheckGenericConditions)} do {
  
  sleep 5;
  [_totalSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;
  
};

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

if(call Hz_fnc_taskSuccessCheckGenericConditions) then {
  [format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
  
  call Hz_fnc_taskReward;
  
}else{
  [format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
};

/*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       

[patrol_task_units,markerpos "BASE",patrol_task_vehs] spawn {
  
  
  private ["_units","_vehs","_markers"];
  _units = _this select 0;
  _vehs = _this select 2;
	_pos = _this select 1;
  
  waitUntil {
	
		sleep 10;
		({(_x distance _pos) < 1000} count playableUnits) == (count playableUnits)	
	
	};
	
  {deletevehicle _x}forEach _units;
  {deletevehicle _x}forEach _vehs;
};      

/*--------------------RESET INTEL---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";