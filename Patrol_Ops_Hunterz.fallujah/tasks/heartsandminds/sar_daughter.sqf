diag_log [time, diag_fps, daytime, "##### POPS HZ HM TASK ##### Search and Rescue Daughter #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

private ["_reinforcementsMinimumSpawnRange", "_ambientCombatIntensifyAmount", "_downPayment", "_minDefendingSquadCount", "_maxDefendingSquadCount", "_DefenseRadius", "_minGarrisonedSquadCount", "_maxGarrisonedSquadCount", "_minPatrollingSquadCount", "_maxPatrollingSquadCount", "_minStaticWeapon", "_maxStaticWeapon", "_CASchance", "_TankChance", "_IFVchance", "_AAchance", "_CarChance", "_SniperChance", "_TowerChance", "_rewardmultiplier", "_rewardMultiplier", "_position", "_closedPositions", "_ins", "_buildings", "_bigBuildings", "_building", "_posB", "_nearbuildings", "_taskid", "_otherReward", "_enemySide", "_powtype", "_powgrp", "_pow1", "_powPos", "_powBuilding", "_guardPositions", "_unit", "_staticguns", "_staticgrp", "_snipers", "_d", "_grpgar", "_b", "_r", "_i", "_tempos", "_grppat", "_Vehsupport", "_vehicletypes", "_car_type", "_vehgrp", "_c", "_grpdef", "_veh", "_target","_randomChoice"];

/*-------------------- TASK PARAMS ---------------------------------*/
_reinforcementsMinimumSpawnRange = 4000;
_ambientCombatIntensifyAmount = 0;

_minDefendingSquadCount = 1;
_maxDefendingSquadCount = 1;
_DefenseRadius = 50;

_minGarrisonedSquadCount = 0;
_maxGarrisonedSquadCount = 1;

_minPatrollingSquadCount = 0;
_maxPatrollingSquadCount = 1;

_minStaticWeapon = 0;
_maxStaticWeapon = 0;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0;
_TankChance = 0;
_IFVchance = 0;
_AAchance = 0;
_CarChance = 0.5;

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

if ((random 1) < 0.25) then {

	_ins = false;
	_downPayment = _downPayment*1.5;
	
	_buildings = (markerpos "ao_centre") nearObjects ["House",3000];
	private _bigBuildings = [];
	private _safeDist = 1200;
	
	while {((count _bigBuildings) < 1) && {_safeDist > 200}} do {
			
			_bigBuildings = _buildings select {
					(alive _x)
					&& {!(isObjectHidden _x)}
					&& {({(side _x) == (SIDE_A select 0)} count (_x nearEntities [["CAManBase", "LandVehicle", "StaticWeapon", "Ship", "Helicopter"], _safeDist])) < 1}
					&& {
						private _thisBuilding = _x;
						private _bpos = [_thisBuilding] call BIS_fnc_buildingPositions;
						((count _bpos) > 12)
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
		
	if ((count _bigBuildings) > 0) then {

		_building = _bigBuildings call mps_getRandomElement;
	
		{
			if (lineIntersects [AGLToASL _x, AGLToASL [_x select 0,_x select 1,150]]) then {
				_closedPositions pushBack _x;		
			};			
		} foreach ([_building] call BIS_fnc_buildingPositions);
		
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
				} foreach ([_x] call BIS_fnc_buildingPositions);
				if (_return) exitwith {};
			} foreach ((nearestObjects [_this select 0,["House"],200]) select {((getDammage _x) < 0.2) && {!(isObjectHidden _x)}});
			
			_return
		}] call Hz_func_findspawnpos;
	
	_nearbuildings = (nearestObjects [_position,["House"],200]) select {((getDammage _x) < 0.2) && {!(isObjectHidden _x)}};

	{
		private _thisHouse = _x;
		{
			if (lineIntersects [AGLToASL _x, AGLToASL [_x select 0,_x select 1,150]]) then {
				_closedPositions pushBack [_thisHouse, _x];
			};
		} foreach ([_thisHouse] call BIS_fnc_buildingPositions);
	} foreach _nearbuildings;
	
	if ((count _closedPositions) > 0) then {
		_randomChoice = _closedPositions call mps_getRandomElement;
	};

};

_position = getpos (_randomChoice select 0);


_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

/*--------------------CREATE TARGET-----------------------------------*/

_otherReward = _otherReward + _downPayment;

_enemySide = [SIDE_B, SIDE_C] select _ins;

_powtype = ["Max_Tak_woman1","Max_Tak_woman2","Max_Tak_woman3","Max_Tak_woman4","Max_Tak_woman5","Max_Tak_woman6","Max_Taky_woman1","Max_Taky_woman2","Max_Taky_woman3","Max_Taky_woman4","Max_Taky_woman5"] call mps_getRandomElement;

_powgrp = createGroup (_enemySide select 0);
_pow1 = _powgrp createUnit [_powtype,_position,[],100,"FORM"];
_pow1 setposatl (_randomChoice select 1);

_pow1 setVariable ["Hz_ambw_disableSideRelations",true,true];
_pow1 setVariable ["mps_askedForHelp",true,true];
_pow1 setVariable ["mps_questioned",true,true];

_pow1 setCaptive true;
_pow1 setRank "private";
_pow1 allowFleeing 0;
_pow1 forceSpeed 0;
dostop _pow1;
_pow1 setUnitPos "MIDDLE";
removeAllWeapons _pow1;
removeAllItems _pow1;
removeAllAssignedItems _pow1;
removeVest _pow1;
removeBackpack _pow1;
removeHeadgear _pow1;	
removeGoggles _pow1;

_powgrp deleteGroupWhenEmpty true;

sleep 1;

_powPos = getposatl _pow1;

_powBuilding = _randomChoice select 0;
_powBuilding setvariable ["occupied",true];


_guardPositions = [_powBuilding] call BIS_fnc_buildingPositions;

{

	if ((_x distance _powPos) < 2) then {
	
		_guardPositions = _guardPositions - [_x];
	
	};

} foreach _guardPositions;


// create enemy commander
_unit = objNull;

if (_ins) then {

	_unit = _powgrp createUnit [mps_opfor_ins_commander call mps_getRandomElement,_position,[],50,"NONE"];

} else {

	_unit = _powgrp createUnit [mps_opfor_commander call mps_getRandomElement,_position,[],50,"NONE"];
	
};

_unit forcespeed 0;
_unit setvariable ["Hz_noMove",true];
_unit setvariable ["Hz_clearingBuilding",true];
dostop _unit;
_guardPos = selectRandom _guardPositions;
_unit setposatl _guardPos;
_unit setUnitPos "UP";

patrol_task_units pushBack _unit;
_guardPositions = _guardPositions - [_guardPos];

// create a guard by random chance
if ((random 1) < 0.5) then {

	_unit = objNull;

	if (_ins) then {

		_unit = _powgrp createUnit [mps_opfor_ins call mps_getRandomElement,_position,[],50,"NONE"];

	} else {

		_unit = _powgrp createUnit [mps_opfor_inf call mps_getRandomElement,_position,[],50,"NONE"];
		
	};

	_unit forcespeed 0;
	_unit setvariable ["Hz_noMove",true];
	_unit setvariable ["Hz_clearingBuilding",true];
	dostop _unit;
	_unit setposatl (selectRandom _guardPositions);
	_unit setUnitPos "UP";

	patrol_task_units pushBack _unit;

};

_pow1 setVariable ["holdingPos", false, true];

[_pow1,["<t color=""#00FF00"">Request to follow</t>",{

		params ["_vip", "_player"];
		
		if (captive _vip) then {
			[_vip, false] remoteExecCall ["setCaptive", _vip];
			[_vip, -1] remoteExecCall ["forcespeed", _vip];
		};
		
		if ((group _player) != (group _vip)) then {
		
			[_vip] joinsilent grpNull;
			sleep 1;
			[_vip] joinsilent (group _player);
			
			(group _player) setFormation "DIAMOND";
			
			[_vip, _player] remoteExecCall ["doFollow", _vip];
			
		};
		
		if (_vip getVariable "holdingPos") then {
			_vip setVariable ["holdingPos", false, true];
			[_vip, "PATH"] remoteExecCall ["enableAI", _vip];
		};

}, [], 1, true, true, "", "(!(_target call Hz_fnc_isUncon)) && {alive _target} && {((group _target) != (group _this)) || {_target getvariable ""holdingPos""}}",5]] remoteexeccall ["addAction",0,true];

[_pow1,["<t color=""#FFFF00"">Hold position</t>",{

	_vip = _this select 0;
	
	_vip setVariable ["holdingPos", true, true];
	[_vip, "PATH"] remoteExecCall ["disableAI", _vip];

}, [], 0, true, true, "", "(!(_target call Hz_fnc_isUncon)) && {alive _target} && {(group _target) == (group _this)} && {!(_target getvariable ""holdingPos"")}",5]] remoteexeccall ["addAction",0,true];

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = [_pow1]; publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[format["TASK%1",_taskid],
"Hearts and Minds: Mission Received",
"Sir, my daughter has been kidnapped by the Takistanis! Please, find her and bring her back to me!",
true,
[],
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
		
			_grpgar = [ _position,"INS",round (random [6, 10, 12]),_DefenseRadius,"hide",200] call CREATE_OPFOR_SQUAD;
				
		} else {		
		
			_grpgar = [ _position,"INF",round (random [6, 10, 12]),_DefenseRadius,"hide",100 ] call CREATE_OPFOR_SQUAD;
		
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
			
				 [_reinforcementsMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] call Hz_task_reinforcements;
			
			} else {
			
				[_reinforcementsMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_task_reinforcements;
			
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
			
				 [_reinforcementsMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] call Hz_task_reinforcements;
			
			} else {
			
				[_reinforcementsMinimumSpawnRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_task_reinforcements;
			
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
While{(((_pow1 distance Hz_pops_heartsandmindsTaskRequester) > 50) || {captive _pow1}) && {alive _pow1} && {call Hz_fnc_taskSuccessCheckGenericConditions}} do {
  
  sleep 5;
	
	if (isplayer leader group _pow1) then {
		_pow1 call Hz_fnc_noCaptiveCheck;
		_pow1 call Hz_fnc_noSideCivilianCheck;
	};
	Hz_pops_heartsandmindsTaskRequester call Hz_fnc_noCaptiveCheck;
	Hz_pops_heartsandmindsTaskRequester call Hz_fnc_noSideCivilianCheck;
  
};

if ((alive _pow1) && {call Hz_fnc_taskSuccessCheckGenericConditions}) then {

	if ((Hz_pops_heartsandmindsTaskRequester distance _returnPos) > 100) then {
	
		[Hz_pops_heartsandmindsTaskRequester,["<t color=""#FF44FF"">Your daughter is here</t>",{

				hint "Oh praise Allah, she is alive! Thank you so much. Please take us to where you found me.";

		}, [], 99, true, true, "", "(alive _target) && {!(_target call Hz_fnc_isUncon)}",5]] remoteexeccall ["addAction",0,true];

	} else {
	
		[Hz_pops_heartsandmindsTaskRequester,["<t color=""#FF44FF"">Your daughter is here</t>",{

				hint "Oh praise Allah, she is alive! Thank you so much.";

		}, [], 99, true, true, "", "(alive _target) && {!(_target call Hz_fnc_isUncon)}",5]] remoteexeccall ["addAction",0,true];
	
	};

};


waitUntil {

	sleep 5;
	
	_pow1 call Hz_fnc_noCaptiveCheck;
	_pow1 call Hz_fnc_noSideCivilianCheck;
	Hz_pops_heartsandmindsTaskRequester call Hz_fnc_noCaptiveCheck;
	Hz_pops_heartsandmindsTaskRequester call Hz_fnc_noSideCivilianCheck;
	
	((!captive _pow1)
	&& {!(_pow1 call Hz_fnc_isUncon)}
	&& {!captive Hz_pops_heartsandmindsTaskRequester}
	&& {!(Hz_pops_heartsandmindsTaskRequester call Hz_fnc_isUncon)}
	&& {(_pow1 distance _returnPos) < 100}
	&& {(Hz_pops_heartsandmindsTaskRequester distance _returnPos) < 100}
	&& {(vehicle _pow1) == _pow1}
	&& {(vehicle Hz_pops_heartsandmindsTaskRequester) == Hz_pops_heartsandmindsTaskRequester})
	|| {!alive _pow1}
	|| {!(call Hz_fnc_taskSuccessCheckGenericConditions)}
	
};

/*------------------- INTENSIFY AMBIENT COMBAT---------------------------*/
  
Hz_ambw_pat_maxNumOfUnits = Hz_ambw_pat_maxNumOfUnits - _ambientCombatIntensifyAmount;
publicVariable "Hz_ambw_pat_maxNumOfUnits";

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

if( alive _pow1 && (call Hz_fnc_taskSuccessCheckGenericConditions)) then {

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
		case (!alive _pow1)	: {
			"The girl was killed!" remoteExecCall ["hint",0];			
		};
	};
	
	sleep 10;
	
	Hz_ambw_srel_relationsCivilian = (Hz_ambw_srel_relationsCivilian - 10) max 1;
	publicVariable "Hz_ambw_srel_relationsCivilian";
	
	"Civilian relations have worsened!" remoteExecCall ["hint",0];
	
};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

_civgrp = createGroup civilian;
if (alive _pow1) then {
	_pow1 remoteExecCall ["removeAllActions",0,true];
	[_pow1] joinsilent grpNull;
	[_pow1] joinsilent _civgrp;
	doStop _pow1;
};
if (alive Hz_pops_heartsandmindsTaskRequester) then {
	Hz_pops_heartsandmindsTaskRequester remoteExecCall ["removeAllActions",0,true];
	[Hz_pops_heartsandmindsTaskRequester] joinsilent grpNull;
	[Hz_pops_heartsandmindsTaskRequester] joinsilent _civgrp;
	doStop Hz_pops_heartsandmindsTaskRequester;
};

_civgrp deleteGroupWhenEmpty true;

[_pow1, Hz_pops_heartsandmindsTaskRequester] spawn {

	params ["_girl", "_dude"];

	waitUntil {
		sleep 5;
		(({(_x distance _girl) < 500} count playableUnits) < 1)
		&& {({(_x distance _dude) < 500} count playableUnits) < 1}
	};
	
	if (alive _girl) then {
		deleteVehicle _girl;
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