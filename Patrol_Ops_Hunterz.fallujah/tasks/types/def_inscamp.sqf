diag_log [time, diag_fps, daytime, "##### POPS HZ TASK ##### Defend Ins Camp #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

/*-------------------- TASK PARAMS ---------------------------------*/
_EnemySpawnMinimumRange = 3000;
_taskRadius = 200;
_minSquadCount = 2;
_maxSquadCount = 5;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0;
_TankChance = 0.1;
_IFVchance = 0.3;
_AAchance = 0.1;
_CarChance = 0.75;

//Useful for justifying task-specific difficulties.
_rewardMultiplier = 0.5;

/*--------------------CREATE LOCATION---------------------------------*/

_position = [markerpos "ao_centre",3000] call Hz_func_findspawnpos;
_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

_fnc_initDude = {

	_this addMagazine "CUP_30Rnd_762x39_AK47_M";
	if ((random 1) < 0.3) then {

		_this addweapon "CUP_arifle_AKS";
	
	} else {
	
		_this addweapon "CUP_arifle_AKM";
	
	};
	
	_this addvest "V_TacChestrig_oli_F";
	_this addMagazine "CUP_30Rnd_762x39_AK47_M";
	_this addMagazine "CUP_30Rnd_762x39_AK47_M";
	_this addMagazine "CUP_30Rnd_762x39_AK47_M";
	_this addMagazine "CUP_30Rnd_762x39_AK47_M";
	_this addMagazine "CUP_30Rnd_762x39_AK47_M";
	_this addMagazine "CUP_30Rnd_762x39_AK47_M";
	_this addMagazine "CUP_30Rnd_762x39_AK47_M";
	_this addMagazine "CUP_30Rnd_762x39_AK47_M";

};

_newComp = [_position, random 360,(call compile preprocessfilelinenumbers "Compositions\Blufor\Bases\insurgent_camp.sqf")] call BIS_fnc_ObjectsMapper;


//init composition
/*
{

	if(_x iskindof "Land_tent_east") then {
		
		_x allowDamage false;
	
	};

} foreach _newComp;

{

	if(_x iskindof "pook_camonet_land_west_FARP17") then {
		
		_x allowDamage false;
	
	};

	if(_x iskindof "FoldTable") then {
		
		_x enableSimulation false;
	
	};
	
} foreach _newComp;
*/

_ammoCratesFilled = 0;
_statGrp = creategroup (SIDE_A select 0);

{
	if ((_x isKindOf "MetalBarrel_burning_F") || (_x isKindOf "Campfire_burning_F")) then {
	
		_x inflame true;
	
	};
	
	if (_x isKindOf "Land_MedicalTent_01_MTP_closed_F") then {
	
		_x setobjecttextureglobal [0,"a3\structures_f_orange\humanitarian\camps\data\medicaltent_01_tropic_f_co.paa"];
	
	};
	
  if ((_x iskindof "Car") || (_x iskindof "Tank")) then {
  
    _x setvehiclelock "LOCKEDPLAYER";
    
    if ((_x emptyPositions "gunner") > 0) then {
			
      _dude = _statGrp createUnit [Hz_ambw_hostileCivTypes call mps_getrandomelement, getpos _x, [], 200, "NONE"];
			_dude call _fnc_initDude;
      _dude assignasgunner _x;
      _dude moveingunner _x;
    
    };
  
  };
	
	if (_x iskindof "StaticWeapon") then {
	
		_dude = _statGrp createUnit [Hz_ambw_hostileCivTypes call mps_getrandomelement, getpos _x, [], 200, "NONE"];
		_dude call _fnc_initDude;
		_dude assignasgunner _x;
		_dude moveingunner _x;
	
	};
  
  if (_x iskindof "ReammoBox_F") then {
  
    clearWeaponCargoGlobal _x;
    clearItemCargoGlobal _x;
    clearMagazineCargoGlobal _x;
		clearBackpackCargoGlobal _x;
    
    _ammoCratesFilled = _ammoCratesFilled + 1;
    if (_ammoCratesFilled > 2) exitWith {};  
    
    if (_ammoCratesFilled == 1) then {
    
      _x addMagazineCargoGlobal ["rhs_mag_127x108mm_50",15];    
    
    } else {
    
      _x addMagazineCargoGlobal ["rhs_mag_100rnd_127x99_mag_Tracer_Red",5];
    
    };
  
  };
	
	[_x,2] remoteExecCall ["setFeatureType",0,true];

} foreach _newComp;

_statGrp deleteGroupWhenEmpty true;

//create defenders
_defGrp = creategroup (SIDE_A select 0);
for "_i" from 1 to 12 do {

	_dude = _defGrp createUnit [Hz_ambw_hostileCivTypes call mps_getRandomElement, _position, [], 10, "NONE"];
	_dude call _fnc_initDude;
	if (_i == 6) then {
	
		_dude addMagazine "CUP_PG7V_M";
		_dude addWeapon "CUP_launch_RPG7V";
		_dude addMagazine "CUP_PG7V_M";
	
	};
	if (_i == 4) then {
	
		removeAllWeapons _dude;
		_dude addMagazine "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M";
		_dude addWeapon "CUP_lmg_PKM";
		_dude addMagazine "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M";
		_dude addMagazine "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M";
		_dude addMagazine "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M";
	
	};	

};

_defGrp setFormation "DIAMOND";
_defGrp setVariable ["Hz_defending",true];
_defGrp setCombatMode "GREEN";

_defGrp deleteGroupWhenEmpty true;

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[ format["TASK%1",_taskid],
"Support Friendly Insurgent Camp",
"Insurgent factions loyal to the government are trying to amass recruits from the locals as the Takistanis advance, but they are still by no means any match against their Takistani-supported rebel enemies. We have just received word that a nearby camp belonging to a loyalist faction will soon come under attack by rebel militias. And, of course, we're asked to help... We can't expect a great sum of cash on this, but it still is in our interests that friendlies maintain hold of the area.",
(SIDE_A select 0),
[format["MARK%1",_taskid],(_position),"mil_objective","ColorBlue"," Defend"],
"created",
_position
] call mps_tasks_add;

/*--------------------WAIT UNTIL PLAYERS ARRIVE---------------------------------*/
hz_reward = 1;
while{ 

(({ isplayer _x} count (nearestObjects [_position,["CAManBase"],_taskRadius])) == 0)
&&
(call Hz_fnc_taskSuccessCheckGenericConditions)

} do { sleep 5 };

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
			
			_spawnedVehs = [_grp, _position,mps_opfor_ins_truck,mps_opfor_ins_ncov,1500] call Hz_AI_moveAndCapture;  

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
    && (({if (!isnull _x) then {(side _x) == (SIDE_B select 0)} else {false}} count patrol_task_units) > (1*(count patrol_task_units) / 10))
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

[patrol_task_units,_position,patrol_task_vehs] spawn {
	
	
	private ["_units","_vehs","_markers"];
	_units = _this select 0;
	_position = _this select 1;
	_vehs = _this select 2;
	
	while{ ({(_x distance _position) < 1500} count playableUnits) > 0} do { sleep 60 };
	{deletevehicle _x}forEach _units;
	{deletevehicle _x}forEach _vehs;
	
};      

/*--------------------RESET INTEL---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";