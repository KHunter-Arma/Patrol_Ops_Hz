diag_log [time, diag_fps, daytime, "##### POPS HZ HM TASK ##### Recover Files #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

private ["_reinforcementsMinimumSpawnRange", "_ambientCombatIntensifyAmount", "_downPayment", "_minDefendingSquadCount", "_maxDefendingSquadCount", "_DefenseRadius", "_minGarrisonedSquadCount", "_maxGarrisonedSquadCount", "_minPatrollingSquadCount", "_maxPatrollingSquadCount", "_minStaticWeapon", "_maxStaticWeapon", "_CASchance", "_TankChance", "_IFVchance", "_AAchance", "_CarChance", "_SniperChance", "_TowerChance", "_rewardmultiplier", "_rewardMultiplier", "_position", "_closedPositions", "_ins", "_buildings", "_houses", "_building", "_posB", "_nearbuildings", "_taskid", "_otherReward", "_enemySide", "_powtype", "_powgrp", "_pow1", "_powPos", "_targetBuilding", "_guardPositions", "_unit", "_staticguns", "_staticgrp", "_snipers", "_d", "_grpgar", "_b", "_r", "_i", "_tempos", "_grppat", "_Vehsupport", "_vehicletypes", "_car_type", "_vehgrp", "_c", "_grpdef", "_veh", "_target","_randomChoice"];

/*-------------------- TASK PARAMS ---------------------------------*/
_reinforcementsMinimumSpawnRange = 4000;
_ambientCombatIntensifyAmount = 0;

_minDefendingSquadCount = 1;
_maxDefendingSquadCount = 2;
_DefenseRadius = 50;

_minGarrisonedSquadCount = 1;
_maxGarrisonedSquadCount = 1;

_minPatrollingSquadCount = 0;
_maxPatrollingSquadCount = 0;

_minStaticWeapon = 0;
_maxStaticWeapon = 0;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0;
_TankChance = 0;
_IFVchance = 0;
_AAchance = 0;
_CarChance = 0.333;

//Others
_SniperChance = 0;
_TowerChance = 0;

//Unused
_downPayment = 1;
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

_downPayment = _downPayment/_rewardMultiplier;

_position = [-5000,-5000,0];
_closedPositions = [];
_randomChoice = [objNull, [0,0,0]];
_ins = true;

if ((random 1) < 0.5) then {

	_ins = false;
	_downPayment = _downPayment*1.5;
	
	_buildings = (markerpos "ao_centre") nearObjects ["House",3000];
	private _houses = [];
	private _safeDist = 1200;
	
	while {((count _houses) < 1) && {_safeDist > 200}} do {
		
		_houses = _buildings select {
			(alive _x)
			&& {!(isObjectHidden _x)}
			&& {({(side _x) == (SIDE_A select 0)} count (_x nearEntities [["CAManBase", "LandVehicle", "StaticWeapon", "Ship", "Helicopter"], _safeDist])) < 1}
			&& {
				private _bpos = _x buildingPos -1;
				((count _bpos) > 5)
				&& {
					private _result = false;
					{
						if (lineIntersects [AGLToASL _x, AGLToASL [_x select 0,_x select 1,150]]) exitWith {
							_result = true;
						};
					} foreach _bpos;
					_result
				}
			}
		};
	
		_safeDist = (_safeDist - 100) max 200;
	
	};
	
	if ((count _houses) > 0) then {

		_building = _houses call mps_getRandomElement;
	
		{
			if (lineIntersects [AGLToASL _x, AGLToASL [_x select 0,_x select 1,150]]) then {
				_closedPositions pushBack _x;
			};
		} foreach (_building buildingPos -1);
		
		_randomChoice = [_building, _closedPositions call mps_getRandomElement];

	};	

} else {

	_SniperChance = 0;
	_TowerChance = 0;

		_position = [markerpos "ao_centre",3500,7100, SIDE_A select 0,0,false,{
			private _return = false;
			{
				{
					if (lineIntersects [AGLToASL _x, AGLToASL [_x select 0,_x select 1,150]]) exitWith {
						_return = true;
					};
				} foreach (_x buildingPos -1);
				if (_return) exitwith {};
			} foreach ((nearestObjects [_this select 0,["House"],200]) select {(alive _x) && {!(isObjectHidden _x)}});			
			_return
		}] call Hz_func_findspawnpos;

	_nearbuildings = (nearestObjects [_position,["House"],200]) select {(alive _x) && {!(isObjectHidden _x)}};

	{
		private _thisHouse = _x;
		{
			if (lineIntersects [AGLToASL _x, AGLToASL [_x select 0,_x select 1,150]]) then {
				_closedPositions pushBack [_thisHouse, _x];				
			};			
		} foreach (_thisHouse buildingPos -1);		
	} foreach _nearbuildings;
	
	if ((count _closedPositions) > 0) then {
		_randomChoice = _closedPositions call mps_getRandomElement;
	};

};

_position = getpos (_randomChoice select 0);

private _prop = createSimpleObject ["Land_TableSmall_01_F", [0,0,50000]];
_prop setposatl ((_randomChoice select 1) vectoradd [0,0,-0.3]);
private _file = "Item_Files" createVehicle [0,0,50000];
_file attachto [_prop, [0,0,0.48]];
sleep 2;
detach _file;

// aux failure condition in case files are "destroyed"
Hz_pops_failFileTask = false;
publicVariable "Hz_pops_failFileTask";

Hz_pops_taskObjectHandedOver = false;

[Hz_pops_heartsandmindsTaskRequester,["<t color=""#AA5500"">Hand over files</t>",{

	player removeItem "Files";
	
	Hz_pops_taskObjectHandedOver = true;
	publicVariable "Hz_pops_taskObjectHandedOver";
	
	hint "Oh praise Allah, you found it! We are saved! Thank you so much!";
	
}, [], 99, true, true, "", "(!(_target call Hz_fnc_isUncon)) && {alive _target} && {'Files' in (magazines player)}",5]] remoteexeccall ["addAction",0,true];

_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

/*--------------------CREATE TARGET-----------------------------------*/

_otherReward = _otherReward + _downPayment;

_enemySide = [SIDE_B, SIDE_C] select _ins;

_targetBuilding = _randomChoice select 0;

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = [_targetBuilding]; publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[format["TASK%1",_taskid],
"Hearts and Minds: Mission Received",
"The Takistanis attacked my neighbourhood and we barely managed to flee in time. They control that area now. I had to leave everything behind, including some important documents... Documents that were given to me by my brother who was part of the defence militia, before he got killed in the attack... If the Takistanis find those documents, they will link my entire family with the militia and come for us! Please, my whole family is in danger, you must help us! Please bring me those documents, before they find them!",
(SIDE_A select 0),
[format["MARK%1",_taskid],_position vectorAdd [([1, -1] select ((random 1) < 0.5))*(random 70), ([1, -1] select ((random 1) < 0.5))*(random 70), 0],"Contact_pencilTask1","colorCivilian"," Recover"],
"created",
_position
] call mps_tasks_add;

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
		
			_grpgar = [ _position,"INS",round (random [6, 10, 12]),_DefenseRadius,"hide",500] call CREATE_OPFOR_SQUAD;
				
		} else {		
		
			_grpgar = [ _position,"INF",round (random [6, 10, 12]),_DefenseRadius,"hide",150 ] call CREATE_OPFOR_SQUAD;
		
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
		
			_grppat = [ _position,"INS",round (random [10, 12, 20]),100,"patrol"] call CREATE_OPFOR_SQUAD;
			_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance, "INS"] call Hz_func_opforVehicleSupport;
		
		} else {
		
			_grppat = [ _position,"INF",round (random [10, 12, 20]),100,"patrol" ] call CREATE_OPFOR_SQUAD;
			_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_func_opforVehicleSupport;
		
		};    
        
    _vehicletypes = _Vehsupport select 0;
    _otherReward = _otherReward + (_Vehsupport select 1);
    
    if((count _vehicletypes) > 0) then { 
      
      _car_type = _vehicletypes call mps_getRandomElement;
      _vehgrp = [_car_type,_enemySide,_position,300] call mps_spawn_vehicle;
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
		
			_grpdef = [ _position,"INS",round (random [10, 12, 20]),_DefenseRadius,"standby"] call CREATE_OPFOR_SQUAD;
			_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance, "INS"] call Hz_func_opforVehicleSupport;
		
		} else {
		
			_grpdef = [ _position,"INF",round (random [10, 12, 20]),_DefenseRadius,"standby" ] call CREATE_OPFOR_SQUAD;
			_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_func_opforVehicleSupport;
		
		};    
        
    _vehicletypes = _Vehsupport select 0;
    _otherReward = _otherReward + (_Vehsupport select 1);
    
    if((count _vehicletypes) > 0) then { 
      
      _car_type = _vehicletypes call mps_getRandomElement;
      _vehgrp = [_car_type,_enemySide,_position,_DefenseRadius] call mps_spawn_vehicle;
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
Hz_ambw_pat_disablePatrols = false;
publicVariable "Hz_ambw_pat_disablePatrols";
Hz_ambw_pat_maxNumOfUnits = Hz_ambw_pat_maxNumOfUnits + _ambientCombatIntensifyAmount;
publicVariable "Hz_ambw_pat_maxNumOfUnits";

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
hz_reward = 1;
While{(!Hz_pops_taskObjectHandedOver) && {call Hz_fnc_taskSuccessCheckGenericConditions} && {!Hz_pops_failFileTask}} do {
  
  sleep 5;
	
	Hz_pops_heartsandmindsTaskRequester call Hz_fnc_noCaptiveCheck;
	Hz_pops_heartsandmindsTaskRequester call Hz_fnc_noSideCivilianCheck;
  
};

if (Hz_pops_taskObjectHandedOver && {call Hz_fnc_taskSuccessCheckGenericConditions}) then {

	if ((Hz_pops_heartsandmindsTaskRequester distance _returnPos) > 100) then {
	
		[Hz_pops_heartsandmindsTaskRequester,["<t color=""#FF44FF"">You got your files...</t>",{

				hint "Yes, thank you so much! Can you please take me to where you found me?";

		}, [], 99, true, true, "", "(alive _target) && {!(_target call Hz_fnc_isUncon)}",5]] remoteexeccall ["addAction",0,true];

	};

};

// in case of failure, don't let any files remain on any player
{
	_x removeItem "Files";
} foreach playableUnits;

{
	if ("Files" in (magazineCargo _x)) then {
		[_x, "Files"] call CBA_fnc_removeMagazineCargo;
	};	
} foreach (Hz_pers_network_vehicles + Hz_pers_network_objects);


waitUntil {

	sleep 5;
	
	Hz_pops_heartsandmindsTaskRequester call Hz_fnc_noCaptiveCheck;
	Hz_pops_heartsandmindsTaskRequester call Hz_fnc_noSideCivilianCheck;
	
	((!captive Hz_pops_heartsandmindsTaskRequester)
	&& {!(Hz_pops_heartsandmindsTaskRequester call Hz_fnc_isUncon)}
	&& {(Hz_pops_heartsandmindsTaskRequester distance _returnPos) < 100}
	&& {(vehicle Hz_pops_heartsandmindsTaskRequester) == Hz_pops_heartsandmindsTaskRequester})
	|| {!(call Hz_fnc_taskSuccessCheckGenericConditions)}
	|| {Hz_pops_failFileTask}
	
};

/*------------------- INTENSIFY AMBIENT COMBAT---------------------------*/
  
Hz_ambw_pat_maxNumOfUnits = Hz_ambw_pat_maxNumOfUnits - _ambientCombatIntensifyAmount;
publicVariable "Hz_ambw_pat_maxNumOfUnits";

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

if((call Hz_fnc_taskSuccessCheckGenericConditions) && {!Hz_pops_failFileTask}) then {

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
		case (Hz_pops_failFileTask) : {
			"The files were destroyed!" remoteExecCall ["hint",0];			
		};
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