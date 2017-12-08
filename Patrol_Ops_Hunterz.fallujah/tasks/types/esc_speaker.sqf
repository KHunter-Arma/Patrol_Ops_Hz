diag_log [time, diag_fps, daytime, "##### POPS HZ TASK ##### Escort Speaker #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

//#define playableUnits switchableUnits

/*-------------------- TASK PARAMS ---------------------------------*/

_downPayment = 10000;
_speechCompletePayment = 30000;
_speechTimeMinutes = 20;

// in case the mission turns into a defend task
_EnemySpawnMinimumRange = Hz_max_desired_server_VD + 500;
_taskRadius = 50;
_minSquadCount = 2;
_maxSquadCount = 6;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0;
_TankChance = 0;
_IFVchance = 0;
_AAchance = 0;
_CarChance = 0.3;

//Useful for justifying task-specific difficulties.
_rewardMultiplier = 1;

/*--------------------CREATE LOCATION---------------------------------*/

if (_EnemySpawnMinimumRange < 2000) then {_EnemySpawnMinimumRange = 2000;};

_rand = random 1;
_position = [0,0,0];
_dir = 0;
_locationDesc = "";

switch (true) do {

case (_rand < 0.3) : {
		
		//HOTEL	
		_position = [8251.68,5492.97,0];
		_dir = 344;	
		_locationDesc = "a hotel just outside the city";
		
	};
	
case (_rand < 0.6) : {
		
		//HOSPITAL
		
		_position = [2408.54,4911.46,0];
		_dir = 255;	
		_locationDesc = "the hospital";
		
	};
	
	default {
		
		//MOSQUE
		
		_position = [4798.86,3852.05,0];
		_dir = 344;		
		_locationDesc = "the Grand Mosque";
		
	};

};  

_newComp = [_position, _dir,(call compile preprocessfilelinenumbers "Compositions\Other\speaker_platform.sqf")] call BIS_fnc_objectsMapper; 

_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

_returnPoint = markerPos "return_point_west";

//offsets between where unit is going to be and composition centre
_dir = _dir - 100;
_position = ([_position, 1.5, _dir] call BIS_fnc_relPos);
_position = [_position select 0, _position select 1, 1.5];

_crowdPos = ([_position, 13, _dir] call BIS_fnc_relPos);
_crowdGrp = creategroup civilian;
_crowdGrp setvariable ["Hz_scanHorizonOverride",true];
_crowd = [];

for "_i" from 1 to (40 + (round random 35)) do {

	_type = hoscivtypes call bis_fnc_selectrandom;
	
	_civ = _crowdGrp createUnit [ _type, _crowdPos, [], 10, "CAN_COLLIDE"];
	_crowd pushBack _civ;
	_civ setdir (random 360);
	_civ forceSpeed 0;
	
	_civ setSkill 0;
	removeAllWeapons _civ;
	removeAllItems _civ;
	
	if ((random 1) > 0.96) then {_civ addweapon "B_OutdoorPack_tan";}; 
	
	_EH = _civ addEventHandler ["killed", {
		
		_civ = _this select 0;
		_killer = _this select 1;
		
		_condition = false;
		
		if (isplayer _killer) then {_condition = true;} else {
			
			//hit and run detection
			if (_civ == _killer) then {
				
				//civ might be sent away so keep radius large
				_nearCars = nearestobjects [_civ,["LandVehicle"],100];
				
				{
					
					if (((speed _x) > 10) && (isplayer (driver _x))) exitwith {_condition = true;};
					
				} foreach _nearCars;
				
			};
			
		};
		
		if (_condition) then {
			
			if (_killer getvariable ["JointOps",false]) then {
				
				[-1, {
					
					if (player getvariable ["JointOps",false]) then {
						
						hint "Civilian casualties are unacceptable. Command is sure to cut our budget in this theatre if this continues.";
						
					};
					
				}] call CBA_fnc_globalExecute;
				
			} else {
				
				mps_mission_deathcount = mps_mission_deathcount - 1; 
				Hz_econ_funds = Hz_econ_funds - 100000;
				publicvariable "Hz_econ_funds";
				publicVariable "mps_mission_deathcount";
				[-1, {
					
					if (!(player getvariable ["JointOps",false])) then {
						
						hint "Civilian casualties are unacceptable. We lost $100000 in compensation, but the big loss will come from losing support from our clients.";
						
					};
					
				}] call CBA_fnc_globalExecute;
				civ_killed_count = civ_killed_count + 1;
				
				if (civ_killed_count > CIV_KILLED_COUNT_BEFORE_RAGE) then {
					
					[-1, {hint parsetext format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>Civilian casualties have reached outrageous numbers. Civilians will now start rebelling against you!</t>"];}] call CBA_fnc_globalExecute;    
					
				};
				
			};  
			
		};
		
	}];
	
	_civ setVariable ["EH",_EH];

};

_crowdGrp setformdir ([_crowdPos,_position] call bis_fnc_dirto);

{

	_x setdir ([_x,_position] call bis_fnc_dirto);

} foreach _crowd;

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TARGET-----------------------------------*/

_grp = createGroup (SIDE_A select 0);
_type = ["LOP_CHR_Civ_Functionary_01","LOP_CHR_Civ_Functionary_02","LOP_Tak_Civ_Man_10","LOP_Tak_Civ_Man_02","LOP_Tak_Civ_Man_09","LOP_Tak_Civ_Man_11","LOP_Tak_Civ_Man_12"] call mps_getRandomElement;
_vip = _grp createUnit [ _type, ( getMarkerPos format["return_point_%1",(SIDE_A select 0)] ), [], 10, "NONE"];
_vip setRank "PRIVATE";

//body-guards
_guards = [];
for "_i" from 1 to 4 do {

	_type = ["LOP_Tak_Civ_Man_04",
	"LOP_Tak_Civ_Man_14",
	"LOP_Tak_Civ_Man_13",
	"LOP_Tak_Civ_Man_16",
	"LOP_Tak_Civ_Man_15",
	"LOP_Tak_Civ_Man_08",
	"LOP_Tak_Civ_Man_07",
	"LOP_Tak_Civ_Man_05",
	"LOP_Tak_Civ_Man_01",
	"LOP_Tak_Civ_Man_06"] call mps_getRandomElement;

	_dude = _grp createUnit [ _type, ( getMarkerPos format["return_point_%1",(SIDE_A select 0)] ), [], 10, "NONE"];
	_dude setRank "PRIVATE";		
	_guards pushBack _dude;
	
	_dude addweapon "CUP_arifle_AKS";
	_dude addvest "V_Chestrig_rgr";
	_dude addMagazine "CUP_30Rnd_762x39_AK47_M";
	_dude addMagazine "CUP_30Rnd_762x39_AK47_M";
	_dude addMagazine "CUP_30Rnd_762x39_AK47_M";
	_dude addMagazine "CUP_30Rnd_762x39_AK47_M";
	
};

_vip setVariable ["guards",_guards,true];
_vip setVariable ["location", _position,true];
_vip setVariable ["retreatPos",([_position, 7, _dir + 180] call BIS_fnc_relPos),true];
_vip setVariable ["preaching",false,true];
_vip setVariable ["preachDir",_dir,true];
_vip setvariable ["preachTime",0];

[_vip,["<t color=""#00FF00"">Request to follow</t>",{

	[_this select 0] joinsilent (group (_this select 1));
	((_this select 0) getvariable "guards") joinsilent (group (_this select 1));

}, [], 1, true, true, "", "(!captive _target) && (alive _target) && ((group _target) != (group _this))"]] remoteexeccall ["addAction",0,true];

[_vip,["<t color=""#00FFFF"">Give all clear</t>",{

	_vip = _this select 0;

	_vip setVariable ["preaching",true,true];
	[_vip, [0,0,0]] remoteexeccall ["setVelocity",_vip,false];
	[_vip,"UP"] remoteexeccall ["setUnitPos",_vip,false];
	[_vip,"amovpercmstpsnonwnondnon"] remoteexeccall ["switchMove",0,false];
	[_vip,(_vip getVariable "preachDir")] remoteExecCall ["setDir",_vip,false];
	[_vip,"move"] remoteExecCall ["disableAI",_vip,false];
	_vip setposatl (_vip getVariable "location");

}, [], 1, true, true, "", "(!captive _target) && (alive _target) && ((_target distance (_target getvariable ""location"")) < 10) && !(_target getvariable ""preaching"") && ((group _target) == (group _this))"]] remoteexeccall ["addAction",0,true];

[_vip,["<t color=""#FF0000"">Get off platform</t>",{

	_vip = _this select 0;

	_vip setVariable ["preaching",false,true];
	_vip setposatl (_vip getVariable "retreatPos");
	[_vip,"move"] remoteExecCall ["enableAI",_vip,false];

}, [], 1, true, true, "", "(!captive _target) && (alive _target) && (_target getvariable ""preaching"") && ((group _target) == (group _this))"]] remoteexeccall ["addAction",0,true];

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[ format["TASK%1",_taskid],
"Escort VIP",
format ["We've been hired to provide security detail to a prominent local tribe leader, Mr. %1. He is due to deliver a speech at %2. Your mission is to escort him and his guards to the location and provide security. The VIP also tells us that he might have to make a stopover or two inside the city. For anything outside of the contract he will pay good money, but it's up to you if you want to take the risk. The speech is expected to last about %3 minutes, and this man is known to be stubborn. He will want to finish his speech no matter what, so you must deal with any interruptions swiftly. The intention of the speech is to raise support from locals to form a resistance movement against the invading Takistanis, so you can expect that some people don't want this to happen. If all hell breaks loose, you will have to extract him, but he won't pay a premium if he can't finish his speech.",name _vip,_locationDesc,_speechTimeMinutes],
(SIDE_A select 0),
[format["MARK%1",_taskid],(_position),"mil_objective","ColorGreen"," Escort"],
"created",
_position
] call mps_tasks_add;

/*--------------------WAIT UNTIL TARGET MEETS PLAYERS---------------------------------*/

waituntil { 

	sleep 5;

	(((group _vip) != _grp)
	|| !(alive _vip)
	)
	
};

/*--------------------WAIT UNTIL TARGET ARRIVES---------------------------------*/

hz_reward = 1;

_preachCounter = 0;
_preachMax = _speechTimeMinutes * 60;
_spawnedSquads = 0;

_otherReward = _otherReward + _downPayment;
_speechRewardPerSecond = _speechCompletePayment / _preachMax;

waituntil { 

	sleep 5;
	[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;

	(
	((_vip distance _position) < 50)
	|| !(alive _vip)
	|| (({(_vip distance _x) < 300} count playableUnits) < 1)
	)
	
};

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
_rand = random 1;

_goTime = _preachMax / 4;

switch (true) do {

case (_rand < 0.1) : {

		[_vip,_crowd,_goTime] spawn {
			
			_vip = _this select 0;
			_crowd = _this select 1;
			_goTime = _this select 2;
			
			_abort = false;
			
			waituntil {
				
				sleep 10;
				if (!alive _vip) exitwith {_abort = true;};
				
				((_vip getvariable "preaching") && ((random 1) < 0.1) && ((_vip getvariable "preachTime") > _goTime))
				
			};
			
			if (_abort) exitwith {};		
			
			_temp = +_crowd;
			{
				
				if ((!alive _x) || (captive _x)) then {
					
					_crowd = _crowd - [_x];
					
				};
				
			} foreach _temp;
			
			_bomber = _crowd call bis_fnc_selectrandom; 
			_bomber removeeventhandler ["Killed",_bomber getvariable "EH"];
			_bomber setskill 1;
			_bomber addMagazine "IEDUrbanBig_Remote_Mag";
			_bomber setunitpos "UP";
			
			_explosiveClass = "IEDUrbanBig_Remote_Ammo";
			
			dostop _bomber;
			
			//[objNull,_bomber,rSAY,"shout"] call RE;
			[_bomber,"shout"] remoteExecCall ["say3D",0,false];
			
			[_bomber] joinsilent createGroup (SIDE_B select 0);
			
			//[objNull,_bomber,rPLAYMOVE,"AmovPercMstpSsurWnonDnon"] call RE;
			
			_bomber playMoveNow "AmovPercMstpSsurWnonDnon";
			
			_bomber disableAI "move";
			uisleep 0.5;
			[_bomber,"AmovPercMstpSsurWnonDnon"] remoteExecCall ["switchMove",0,false];
			_bomber disableAI "anim";
			[_bomber] joinsilent (creategroup (SIDE_B select 0));
			uisleep 1;
			//     _uncon = _bomber call ace_sys_wounds_fnc_isUncon;
			//    waituntil {!_uncon; sleep 2;};
			if (alive _bomber) then 
			
			{  _exppos = getPos _bomber;
				_bomb = _explosiveClass createVehicle _exppos;
				_bomb setDamage 1;
				sleep 0.5;
				deletevehicle _bomber;
				
			};
		};   

	};
	
case (_rand < 0.8) : {

		// insurgent attack
		_b = (_minSquadCount max (round (random _maxSquadCount)));
		
		[_vip,_goTime,_b,_position,_EnemySpawnMinimumRange,_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn {
			
			_vip = _this select 0;
			_goTime = _this select 1;
			_b = _this select 2;
			_position = _this select 3;
			_EnemySpawnMinimumRange = _this select 4;
			_CASchance = _this select 5;
			_TankChance = _this select 6;
			_IFVchance = _this select 7;
			_AAchance = _this select 8;
			_CarChance = _this select 9;
			
			_abort = false;
			
			waituntil {
				
				sleep 10;
				if (!alive _vip) exitwith {_abort = true;};
				
				(_vip getvariable "preaching")
				
			};					

			_spawnpos = [_position,_EnemySpawnMinimumRange] call Hz_func_findspawnpos;

			if(_b > 0) then { 
				
				for "_i" from 1 to _b do {
					
					//exit spawn loop and transfer to reinforcements script if too many units present on map
					if((count allunits) > Hz_max_allunits) exitwith {_r = (_b - _i) + 1; [_EnemySpawnMinimumRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] spawn Hz_task_reinforcements;};

					_grp = [ _spawnpos,"INS",random 24,300 ] call CREATE_OPFOR_SQUAD;
					
					_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] call Hz_func_opforVehicleSupport;
					_vehicletypes = _Vehsupport select 0;
					Hz_econ_aux_rewards = Hz_econ_aux_rewards + (_Vehsupport select 1);
					
					if((count _vehicletypes) > 0) then { 
						
						_car_type = _vehicletypes call mps_getRandomElement;
						_vehgrp = [_car_type,(SIDE_C select 0),_spawnpos,300] call mps_spawn_vehicle;
						sleep 0.1;
						patrol_task_vehs pushback (vehicle (leader _vehgrp));
						(units _vehgrp) joinSilent _grp;
						sleep 0.1;
						deleteGroup _vehgrp;
						
					};
					
					patrol_task_units = patrol_task_units + (units _grp);
					
					if(!isnil "Hz_AI_moveAndCapture") then {
						
						_spawnedVehs = [_grp, _position,mps_opfor_ins_truck,mps_opfor_ins_ncov] call Hz_AI_moveAndCapture;  

						patrol_task_vehs = patrol_task_vehs + _spawnedVehs;					 
						
					} else {
						
						_wp = _grp addWaypoint [_position,50];
						_wp setWaypointType "SAD";
						
					};
				};
			};
			
			Hz_econ_aux_rewards = Hz_econ_aux_rewards + (Hz_econ_perSquadReward*_b);
			
		};		

	};
	
	default {

		// taki spec ops paradropped
		
		_b = (_minSquadCount max (round (random _maxSquadCount)));
		
		[_vip,_goTime,_b,_position] spawn {
			
			_vip = _this select 0;
			_goTime = _this select 1;
			_b = _this select 2;
			_position = _this select 3;
			
			_abort = false;
			
			waituntil {
				
				sleep 10;
				if (!alive _vip) exitwith {_abort = true;};
				
				((_vip getvariable "preaching") && ((random 1) < 0.1) && ((_vip getvariable "preachTime") > _goTime))
				
			};				
			
			for "_i" from 1 to _b do {					
				
				_spawnpos = [((markerpos "patrol_respawn_opfor") select 0) + 500 + random 500,((markerpos "patrol_respawn_opfor") select 1) + 500 + random 500,800];
				
				_paratroopers = [createGroup (SIDE_B select 0),_spawnpos,_position,true,["CUP_O_TK_SpecOps_MG","CUP_O_TK_SpecOps","CUP_O_TK_SpecOps_TL","CUP_O_TK_SpecOps","CUP_O_TK_SpecOps_TL"]] call CREATE_OPFOR_PARADROP;
				patrol_task_units = patrol_task_units + _paratroopers;
				
				
			};
			
			Hz_econ_aux_rewards = Hz_econ_aux_rewards + (Hz_econ_perSquadReward*_b);

		};

	};


};

while { 

	(alive _vip)
	&& (({(_vip distance _x) < 300} count playableUnits) > 0)
	&& (call Hz_fnc_taskSuccessCheckGenericConditions)
	&& ((_preachCounter < _preachMax) || (((_vip distance _returnPoint) < 15) && (!captive _vip)))
	
} do { 
	
	uisleep 1;
	
	if ((_vip getVariable "preaching") && (!captive _vip)) then {
		
		_preachCounter = _preachCounter + 1;
		_vip setvariable ["preachTime",_preachCounter];
		_otherReward = _otherReward + _speechRewardPerSecond;
		
		if ((random 1) < 0.0001) then {
			
			_temp = +_crowd;
			{
				
				if ((!alive _x) || (captive _x)) then {
					
					_crowd = _crowd - [_x];
					
				};
				
			} foreach _temp;
			
			_dude = _crowd call bis_fnc_selectrandom;
			_dude removeeventhandler ["Killed",_dude getvariable "EH"];
			_dude setskill 0.4;
			_dude setskill ["spotDistance",1];
			_dude setskill ["spotTime",1];
			_dude setskill ["courage",1];
			_dude setskill ["commanding",1];
			_dude setskill ["aimingSpeed",0.8];		
			
			_dude setdir ([_dude,_vip] call bis_fnc_dirto);
			_dude disableai "move";
			_dude disableai "autotarget";
			_dude setunitpos "UP";
			
			if ((random 1) < 0.5) then {
				
				_dude addMagazine "CUP_8Rnd_9x18_Makarov_M";
				_dude addMagazine "CUP_8Rnd_9x18_Makarov_M";
				_dude addWeapon "CUP_hgun_Makarov";
				
			} else {
				
				_dude addMagazine "CUP_6Rnd_45ACP_M";
				_dude addMagazine "CUP_6Rnd_45ACP_M";
				_dude addWeapon "CUP_hgun_TaurusTracker455";
				
			};
			
			[_dude] joinSilent (createGroup (SIDE_B select 0));
			
			_dude reveal [_vip,4];
			
			_dude forceSpeed 0;
			_dude dotarget _vip;
			
			_dude selectWeapon (handgunWeapon _dude);
			
			sleep 1;
			
			[_dude,"shout"] remoteExecCall ["say3D",0,false];
			
			_curMuz = currentmuzzle _dude; 
			_dude enableai "move";
			
			for "_i" from 1 to 5 do {
				
				_dude dotarget _vip;
				_dude forceWeaponFire [_curMuz, "Single"];
				uisleep 0.33;
					
				
			};
			
			_dude enableai "autotarget";
			_dude forceSpeed -1;
			
		};
		
	};
	
	[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;
	
};

if (hz_reward > 0) then {

	hz_reward = ceil hz_reward;

};

switch (true) do {

case (_preachCounter >= _preachMax) : {
		
		"The VIP has finished his speech. Return him to base ASAP." remoteExecCall ["hint",0,false];

		waituntil { 

			sleep 5;

			(
			(((_vip distance _returnPoint) < 15) && (!captive _vip))
			|| !(alive _vip)
			|| (({(_vip distance _x) < 300} count playableUnits) < 1)
			)
		};

	};
	
case (({(_vip distance _x) < 300} count playableUnits) < 1) : {
		
		"You abandoned the VIP!" remoteExecCall ["hint",0,false];
		
	};
	
case (hz_reward <= 0) : {
		
		"We've taken too many casualties for a mission like this. We're aborting. RTB immediately!" remoteExecCall ["hint",0,false];
		
	};
	
case (!alive _vip) : {
		
		"The VIP is KIA, abort mission!" remoteExecCall ["hint",0,false];
		
	};
	
	default {
		
		"The VIP wasn't able to finish his speech, but at least he's still alive. And he's got you to thank for that!" remoteExecCall ["hint",0,false];
		
		sleep 5;
		
	};

};

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/  

if((call Hz_fnc_taskSuccessCheckGenericConditions) && (alive _vip) && (({(_vip distance _x) < 300} count playableUnits) > 0)) then {
	[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;             
	
	call Hz_fnc_taskReward;
	
}else{
	[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
};

/*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       

[patrol_task_units,_position,patrol_task_vehs,_vip,_crowd] spawn {
	
	
	private ["_units","_vehs","_markers"];
	_units = _this select 0;
	_pos = _this select 1;
	_vehs = _this select 2;
	_vip = _this select 3;
	_crowd = _this select 4;
	
	while{ ({(_x distance _pos) < 50} count playableUnits) > 0} do { sleep 60 };
	
	{deletevehicle _x} foreach (_vip getVariable "guards");
	{deletevehicle _x} foreach _crowd;
	deleteVehicle _vip;	
	
	{deletevehicle _x}forEach _units;
	{deletevehicle _x}forEach _vehs;
	
};      

/*--------------------RESET INTEL---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";