diag_log [time, diag_fps, daytime, "##### POPS HZ TASK ##### Escort Speaker #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

//#define playableUnits switchableUnits

private ["_downPayment", "_speechCompletePayment", "_speechTimeMinutes", "_EnemySpawnMinimumRange", "_taskRadius", "_minSquadCount", "_maxSquadCount", "_CASchance", "_TankChance", "_IFVchance", "_AAchance", "_CarChance", "_rewardMultiplier", "_rand", "_position", "_dir", "_locationDesc", "_newComp", "_taskid", "_otherReward", "_returnPoint", "_crowdPos", "_crowdGrp", "_crowd", "_type", "_civ", "_grp", "_vip", "_guards", "_dude", "_killer", "_condition", "_nearCars", "_suicidebomber", "_preachCounter", "_preachMax", "_speechRewardPerSecond", "_spawnedSquads", "_goTime", "_temp", "_curMuz", "_units", "_target", "_dismountDistance"];

/*-------------------- TASK PARAMS ---------------------------------*/

_downPayment = 50000;
_speechCompletePayment = 150000;
_speechTimeMinutes = 30;

// in case the mission turns into a defend task
_EnemySpawnMinimumRange = 2000;
_dismountDistance = -1; // set individually for each location
_taskRadius = 50;
_minSquadCount = 1;
_maxSquadCount = 3;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0;
_TankChance = 0;
_IFVchance = 0;
_AAchance = 0;
_CarChance = 0.3;

//Useful for justifying task-specific difficulties.
_rewardMultiplier = 1;

/*--------------------CREATE LOCATION---------------------------------*/

_downPayment = _downPayment/_rewardMultiplier;
_speechCompletePayment = _speechCompletePayment/_rewardMultiplier;

Hz_pops_task_auxFailCondition = false;

_rand = random 1;
_position = [0,0,0];
_dir = 0;
_locationDesc = "";

switch (true) do {

case (_rand < 0.33) : {
		
		//HOTEL	
		_position = [8251.68,5492.97,0];
		_dir = 344;
		_dismountDistance = 600;
		_locationDesc = "a hotel just outside the city";
		
	};
	
case (_rand < 0.66) : {
		
		//HOSPITAL
		
		_position = [2408.54,4911.46,0];
		_dir = 255;
		_dismountDistance = 400;
		_locationDesc = "the hospital";
		
	};
	
	default {
		
		//MOSQUE
		
		_position = [4798.86,3852.05,0];
		_dir = 344;		
		_dismountDistance = 400;
		_locationDesc = "the Grand Mosque";
		
	};

};  

_newComp = [_position, _dir,(call compile preprocessfilelinenumbers "Compositions\Other\speaker_platform.sqf")] call Hz_fnc_objectsMapper; 

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

	_type = Hz_ambw_hostileCivTypes call mps_getrandomelement;
	
	_civ = _crowdGrp createUnit [ _type, _crowdPos, [], 10, "CAN_COLLIDE"];
	_civ setVariable ["mps_interaction_disabled", true, true];
	_crowd pushBack _civ;
	_civ setdir (random 360);
	_civ forceSpeed 0;
	
	_civ setSkill 0;
	removeAllWeapons _civ;
	removeAllItems _civ;
	
	if ((random 1) > 0.96) then {
		_civ addBackpack (selectRandom ["B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_oli", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_oli", "B_CivilianBackpack_01_Everyday_Astra_F", "B_CivilianBackpack_01_Everyday_Black_F", "B_CivilianBackpack_01_Sport_Blue_F", "B_CivilianBackpack_01_Sport_Green_F", "B_CivilianBackpack_01_Sport_Red_F", "B_Carryall_green_F", "B_FieldPack_green_F", "B_Messenger_Black_F", "B_Messenger_Coyote_F", "B_Messenger_Gray_F", "B_Messenger_Olive_F"]);
	};

};

_crowdGrp deleteGroupWhenEmpty true;

_crowdGrp setformdir ([_crowdPos,_position] call bis_fnc_dirto);

{

	_x setdir ([_x,_position] call bis_fnc_dirto);

} foreach _crowd;

/*--------------------CREATE TARGET-----------------------------------*/

_grp = createGroup (SIDE_A select 0);

_vip = _grp createUnit ["LOP_ME_Civ_Random",( getMarkerPos format["return_point_%1",(SIDE_A select 0)] ), [], 10, "NONE"];
_vip spawn {
	sleep 5;
	if ((random 1) < 0.5) then {
		_this addUniform (selectRandom ["LOP_U_CHR_Profiteer_04","LOP_U_CHR_Profiteer_01","LOP_U_CHR_Profiteer_03","LOP_U_CHR_Profiteer_02","U_C_FormalSuit_01_tshirt_black_F","U_C_FormalSuit_01_tshirt_gray_F"]);
	};
	sleep 0.1;
	if ((random 1) < 0.33) then {
		_this linkItem (selectRandom ["G_Squares_Tinted_NV","G_Squares_NV","G_Spectacles_NV","G_Spectacles_Tinted_NV","G_Shades_Green_NV","G_Aviator_NV"]);
	};
};
_vip setRank "PRIVATE";
_vip setVariable ["Hz_ambw_disableSideRelations",true,true];
_vip setVariable ["mps_interaction_disabled", true, true];

_grp deleteGroupWhenEmpty true;

dostop _vip;

//body-guards
_guards = [];
for "_i" from 1 to 4 do {

	_dude = _grp createUnit ["LOP_ME_Civ_Random", (getMarkerPos format["return_point_%1",(SIDE_A select 0)]), [], 10, "NONE"];
	_dude setVariable ["mps_interaction_disabled", true, true];
	_dude setRank "PRIVATE";
	_guards pushBack _dude;
	
	_dude setVariable ["Hz_ambw_disableSideRelations",true,true];
	
	dostop _dude;
	
	_dude addweapon "CUP_arifle_AKS";
	_dude addWeaponItem ["CUP_arifle_AKS", "CUP_30Rnd_762x39_AK47_M", true];
	_dude addvest "V_TacChestrig_oli_F";
	_dude addMagazines ["CUP_30Rnd_762x39_AK47_M", 8];
	
	_dude addMPEventHandler ["MPKilled",{
	
		_dude = _this select 0;
		_killer = _this select 1;
		
		if (!local _dude) exitWith {};
		
		_condition = false;
		
		if (isplayer _killer) then {_condition = true;} else {
			
			//hit and run detection
			if (_dude == _killer) then {
				
				//civ might be sent away so keep radius large
				_nearCars = _dude nearEntities [["LandVehicle"],30];
				
				{
					
					if (((speed _x) > 10) && (isplayer (driver _x))) exitwith {_condition = true;};
					
				} foreach _nearCars;
				
			};
			
		};	
		
		if (_condition) then {Hz_pops_task_auxFailCondition = true; publicVariable "Hz_pops_task_auxFailCondition";};
	
	}];
	
};

_vip setVariable ["guards",_guards,true];
_vip setVariable ["location", _position,true];
_vip setVariable ["retreatPos",([_position, 7, _dir + 180] call BIS_fnc_relPos),true];
_vip setVariable ["preaching",false,true];
_vip setVariable ["preachDir",_dir,true];
_vip setvariable ["preachTime",0];
_vip setVariable ["holdingPos", false, true];

// let network variables propagate through before adding actions
sleep 2;

[_vip,["<t color=""#00FF00"">Request to follow</t>",{

	params ["_vip", "_player"];

	if ((group _player) != (group _vip)) then {
	
		_units = [_vip] + (_vip getvariable "guards");
		_units joinsilent (group _player);
		sleep 1;
		
		(group _player) setFormation "DIAMOND";
		
		{
			[_x, _player] remoteExecCall ["doFollow", _x];
		} foreach _units;
		
	};
	
	_vip setVariable ["holdingPos", false, true];
	[_vip, "PATH"] remoteExecCall ["enableAI", _vip];
	
	[_vip, _player] remoteExecCall ["doFollow", _vip];

}, [], 1, true, true, "", "(!(_target call Hz_fnc_isUncon)) && {alive _target} && {((group _target) != (group _this)) || {_target getvariable ""holdingPos""}}"]] remoteexeccall ["addAction",0,true];

[_vip,["<t color=""#FFFF00"">Hold position</t>",{

	_vip = _this select 0;
	
	_vip setVariable ["holdingPos", true, true];
	[_vip, "PATH"] remoteExecCall ["disableAI", _vip];

}, [], 0, true, true, "", "(!(_target call Hz_fnc_isUncon)) && {alive _target} && {(group _target) == (group _this)} && {!(_target getvariable ""preaching"")} && {!(_target getvariable ""holdingPos"")}"]] remoteexeccall ["addAction",0,true];

[_vip,["<t color=""#00FFFF"">Give all clear</t>",{

	_vip = _this select 0;

	_vip setVariable ["preaching",true,true];
	[_vip, [0,0,0]] remoteexeccall ["setVelocity",_vip,false];
	[_vip,"UP"] remoteexeccall ["setUnitPos",_vip,false];
	[_vip,"amovpercmstpsnonwnondnon"] remoteexeccall ["switchMove",0,false];
	[_vip,(_vip getVariable "preachDir")] remoteExecCall ["setDir",_vip,false];
	[_vip,"move"] remoteExecCall ["disableAI",_vip,false];
	_vip setposatl (_vip getVariable "location");

}, [], 1, true, true, "", "(!(_target call Hz_fnc_isUncon)) && {alive _target} && {!captive _target} && {(_target distance (_target getvariable ""location"")) < 10} && {!(_target getvariable ""preaching"")} && {(group _target) == (group _this)}"]] remoteexeccall ["addAction",0,true];

[_vip,["<t color=""#FF0000"">Get off platform</t>",{

	_vip = _this select 0;

	_vip setVariable ["preaching",false,true];
	_vip setposatl (_vip getVariable "retreatPos");
	[_vip,"move"] remoteExecCall ["enableAI",_vip,false];

}, [], 1, true, true, "", "(!(_target call Hz_fnc_isUncon)) && {alive _target} && {_target getvariable ""preaching""} && {(group _target) == (group _this)}"]] remoteexeccall ["addAction",0,true];

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

[ format["TASK%1",_taskid],
"New Mission Received",
format ["We've been hired to provide security detail to a prominent local tribe leader, Mr. %1. He is due to deliver a speech at %2. Your mission is to escort him and his guards to the location and provide security. The VIP also tells us that he might have to make a stopover or two inside the city. For anything outside of the contract he will pay good money, but it's up to you if you want to take the risk. The speech is expected to last about %3 minutes, and this man is known to be stubborn. He will want to finish his speech no matter what, so you must deal with any interruptions swiftly. The intention of the speech is to raise support from locals to form a resistance movement against the invading Takistanis, so you can expect that some people don't want this to happen. If all hell breaks loose, you will have to extract him, but he won't pay a premium if he can't finish his speech.",name _vip,_locationDesc,_speechTimeMinutes],
(SIDE_A select 0),
[format["MARK%1",_taskid],(_position),"mil_objective","ColorGreen"," Escort"],
"created",
_position
] call mps_tasks_add;


/*------------------- INTENSIFY AMBIENT COMBAT------------------------------------*/
Hz_ambw_pat_disablePatrols = false;
publicVariable "Hz_ambw_pat_disablePatrols";

_rand = random 1;
_suicidebomber = false;
if (_rand < 0.1) then {

	_suicidebomber = true;
	Hz_ambw_pat_maxNumOfUnits = Hz_ambw_pat_maxNumOfUnits + Hz_ambient_units_intensify_amount;
	publicVariable "Hz_ambw_pat_maxNumOfUnits";

};

/*--------------------WAIT UNTIL TARGET MEETS PLAYERS---------------------------------*/

waituntil {

	sleep 5;
	
	_vip call Hz_fnc_noCaptiveCheck;
	{_x call Hz_fnc_noCaptiveCheck} foreach _guards;
	(units group _vip) call Hz_fnc_noSideCivilianCheck;

	((isplayer leader group _vip)
	|| (_vip call Hz_fnc_isUncon)
	|| !(alive _vip)
	|| Hz_pops_task_auxFailCondition
	)
	
};

/*--------------------WAIT UNTIL TARGET ARRIVES---------------------------------*/

hz_reward = 1;

_preachCounter = 0;
_preachMax = _speechTimeMinutes * 60;

_otherReward = _otherReward + _downPayment;
_speechRewardPerSecond = _speechCompletePayment / _preachMax;

_spawnedSquads = (_minSquadCount max (round (random _maxSquadCount)));

waituntil {

	_vip call Hz_fnc_noCaptiveCheck;
	{_x call Hz_fnc_noCaptiveCheck} foreach _guards;
	(units group _vip) call Hz_fnc_noSideCivilianCheck;

	sleep 5;
	[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;

	(
//	((_vip distance _position) < 50)
		(({(_x distance _position) < 150} count playableUnits) > 0)
	|| !(alive _vip)
	|| (({(_vip distance _x) < 300} count playableUnits) < 1)
	|| Hz_pops_task_auxFailCondition
	)
	
};

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
_goTime = _preachMax / 4;

switch (true) do {

case (_suicidebomber) : {

		_otherReward = _otherReward + 100000;

		[_vip,_crowd,_goTime] spawn {
					
			_spawnedSquads = 0;
			
			_vip = _this select 0;
			_crowd = _this select 1;
			_goTime = _this select 2;
			
			_abort = false;
			
			waituntil {
				
				sleep 10;
				if (!alive _vip) exitwith {_abort = true;};
				
				((_vip getvariable "preaching") && ((random 1) < 0.1) && ((_vip getvariable "preachTime") > _goTime)) || Hz_pops_task_auxFailCondition
				
			};
			
			if (Hz_pops_task_auxFailCondition) exitWith {};
			
			if (_abort) exitwith {};		
			
			_temp = +_crowd;
			{
				
				if ((!alive _x) || (_x call Hz_fnc_isUncon)) then {
					
					_crowd = _crowd - [_x];
					
				};
				
			} foreach _temp;
			
			_bomber = _crowd call mps_getrandomelement; 
			_bomber setVariable ["Hz_ambw_sideFaction",[SIDE_C select 0, "Enemy Insurgents",0],true];
			_bomber setskill 1;
			_bomber addMagazine "IEDUrbanBig_Remote_Mag";
			_bomber setCaptive false;
			
			_explosiveClass = "IEDUrbanBig_Remote_Ammo";
			
			dostop _bomber;
			
			if ((unitPos _bomber) != "UP") then {
				_bomber setUnitPos "UP";
				uisleep 1;
			};
			
			[_bomber,"Hz_ambw_shout"] remoteExecCall ["say3D",0,false];
			
			[_bomber] joinsilent grpNull;
			_bgroup = createGroup (SIDE_C select 0);
			[_bomber] joinsilent _bgroup;
			
			_bgroup deleteGroupWhenEmpty true;
						
			_bomber playMoveNow "AmovPercMstpSsurWnonDnon";
			
			_bomber disableAI "MOVE";
			uisleep 0.5;
			
			if ((alive _bomber) && {!(_bomber call Hz_ambw_fnc_isUncon)} && {!captive _bomber}) then {
				[_bomber,"AmovPercMstpSsurWnonDnon"] remoteExecCall ["switchMove",0,false];
				_bomber disableAI "anim";
			};
			
			uisleep 1.4;
			
			if ((alive _bomber)  && {!(_bomber call Hz_fnc_isUncon)} && {!captive _bomber}) then {
				_exppos = getPos _bomber;
				_bomb = _explosiveClass createVehicle _exppos;
				_bomb setDamage 1;
				uisleep 0.1;
				deletevehicle _bomber;			
			};
		};   

	};
	
case (_rand < 0.8) : {

		// insurgent attack
		
		[_vip,_goTime,_spawnedSquads,_position,_EnemySpawnMinimumRange,_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] spawn {
			
			_vip = _this select 0;
			_goTime = _this select 1;
			_spawnedSquads = _this select 2;
			_position = _this select 3;
			_EnemySpawnMinimumRange = _this select 4;
			_CASchance = _this select 5;
			_TankChance = _this select 6;
			_IFVchance = _this select 7;
			_AAchance = _this select 8;
			_CarChance = _this select 9;
			
			_abort = false;
			
			/*
			
			// ground attack taking too long -- don't wait
			
			waituntil {
				
				sleep 10;
				if (!alive _vip) exitwith {_abort = true;};
				
				(_vip getvariable "preaching") || Hz_pops_task_auxFailCondition
				
			};		
			
			*/

			if (Hz_pops_task_auxFailCondition) exitWith {};				

			_spawnpos = [_position,_EnemySpawnMinimumRange] call Hz_func_findspawnpos;

			if(_spawnedSquads > 0) then { 
				
				for "_i" from 1 to _spawnedSquads do {
					
					//exit spawn loop and transfer to reinforcements script if too many units present on map
					if((count allunits) > Hz_max_allunits) exitwith {_r = (_spawnedSquads - _i) + 1; [_EnemySpawnMinimumRange,_position,_r,"TRUCK",_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] call Hz_task_reinforcements;};

					_grp = [ _spawnpos,"INS",24 + (random 24),300 ] call CREATE_OPFOR_SQUAD;
					
					_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] call Hz_func_opforVehicleSupport;
					_vehicletypes = _Vehsupport select 0;
					Hz_econ_aux_rewards = Hz_econ_aux_rewards + (_Vehsupport select 1);
					
					if((count _vehicletypes) > 0) then { 
						
						_car_type = _vehicletypes call mps_getRandomElement;
						_vehgrp = [_car_type,SIDE_C,_spawnpos,100] call mps_spawn_vehicle;
						sleep 0.1;
						patrol_task_vehs pushback (vehicle (leader _vehgrp));
						(units _vehgrp) joinSilent _grp;
						sleep 0.1;
						deleteGroup _vehgrp;
						
					};
					
					patrol_task_units = patrol_task_units + (units _grp);
					
					if(!isnil "Hz_AI_moveAndCapture") then {
						
						_spawnedVehs = [_grp, _position,mps_opfor_ins_truck,mps_opfor_ins_ncov, _dismountDistance] call Hz_AI_moveAndCapture;  

						patrol_task_vehs = patrol_task_vehs + _spawnedVehs;					 
						
					} else {
						
						_wp = _grp addWaypoint [_position,50];
						_wp setWaypointType "SAD";
						
					};
					
					//unbunching delay
					sleep 450;
					
				};
			};
			
		};		

	};
	
	default {

		// taki spec ops paradropped
		
		[_vip,_goTime,_spawnedSquads,_position] spawn {
			
			_vip = _this select 0;
			_goTime = _this select 1;
			_spawnedSquads = _this select 2;
			_position = _this select 3;
			
			_abort = false;
			
			waituntil {
				
				sleep 10;
				if (!alive _vip) exitwith {_abort = true;};
				
				((_vip getvariable "preaching") && ((random 1) < 0.1) && ((_vip getvariable "preachTime") > _goTime)) || Hz_pops_task_auxFailCondition
				
			};				
			
			if (Hz_pops_task_auxFailCondition) exitWith {};
						
			//since a chopper carries about half the troops than average squad size normally...
			for "_i" from 1 to (_spawnedSquads*2) do {					
				
				_spawnpos = [((markerpos "patrol_respawn_opfor") select 0) + 500 + random 500,((markerpos "patrol_respawn_opfor") select 1) + 500 + random 500,800];
				uisleep 20;
				
				_paragrp = createGroup (SIDE_B select 0);
				_paratroopers = [_paragrp,_spawnpos,_position,true,["CUP_O_TK_SpecOps_MG","CUP_O_TK_SpecOps","CUP_O_TK_SpecOps_TL","CUP_O_TK_SpecOps","CUP_O_TK_SpecOps_TL"]] call CREATE_OPFOR_PARADROP;
				_paragrp deleteGroupWhenEmpty true;
				patrol_task_units = patrol_task_units + _paratroopers;				
				
			};

		};

	};


};

while { 

	(alive _vip)
	&& (({(_vip distance _x) < 300} count playableUnits) > 0)
	&& (call Hz_fnc_taskSuccessCheckGenericConditions)
	&& ((_preachCounter < _preachMax) || (((_vip distance _returnPoint) < 15) && (!(_vip call Hz_fnc_isUncon))))
	
} do { 

	_vip call Hz_fnc_noCaptiveCheck;
	{_x call Hz_fnc_noCaptiveCheck} foreach _guards;
	(units group _vip) call Hz_fnc_noSideCivilianCheck;
	
	uisleep 1;
	
	if (_vip getVariable "preaching") then {
	
		if (_vip call Hz_fnc_isUncon) exitWith {
			_vip setVariable ["preaching", false, true];
			[_vip,"move"] remoteExecCall ["enableAI",_vip,false];
		};
		
		_preachCounter = _preachCounter + 1;
		_vip setvariable ["preachTime",_preachCounter];
		_otherReward = _otherReward + _speechRewardPerSecond;
		
		if ((random 1) < 0.0007) then {
			
			_temp = +_crowd;
			{
				
				if ((!alive _x) || (_x call Hz_fnc_isUncon)) then {
					
					_crowd = _crowd - [_x];
					
				};
				
			} foreach _temp;
			
			_dude = _crowd call mps_getrandomelement;
			_dude setVariable ["Hz_ambw_sideFaction",[SIDE_C select 0, "Enemy Insurgents",0],true]; 
			_dude setskill 0.4;
			_dude setskill ["spotDistance",1];
			_dude setskill ["spotTime",1];
			_dude setskill ["courage",1];
			_dude setskill ["commanding",1];
			_dude setskill ["aimingSpeed",0.3];		
			_dude setskill ["aimingAccuracy",Hz_AI_param_skillAimingAccuracy/10];	
			_dude setskill ["aimingShake",Hz_AI_param_skillAimingShake/10];	
			
			_dude setdir ([_dude,_vip] call bis_fnc_dirto);
			_dude disableAI "MOVE";
			_dude disableAI "PATH";
			_dude spawn {
				sleep 6;
				_this enableAI "PATH";
			};
			_dude disableAI "AUTOTARGET";
			_dude setunitpos "UP";
			
			if ((random 1) < 0.5) then {
				
				_dude addWeapon "CUP_hgun_Makarov";
				_dude addWeaponItem ["CUP_hgun_Makarov", "CUP_8Rnd_9x18_Makarov_M", true];
				_dude addMagazines ["CUP_8Rnd_9x18_Makarov_M", 2];
				
			} else {
				
				_dude addWeapon "CUP_hgun_TaurusTracker455";
				_dude addWeaponItem ["CUP_hgun_TaurusTracker455", "CUP_6Rnd_45ACP_M", true];
				_dude addMagazines ["CUP_6Rnd_45ACP_M", 2];
				
			};
			
			[_dude] joinSilent grpNull;
			[_dude] joinSilent (createGroup [SIDE_C select 0,true]);
			
			_dude reveal [_vip,4];
			
			_dude forceSpeed 0;
			_dude dotarget _vip;
			
			_dude selectWeapon (handgunWeapon _dude);
			
			sleep 1;
			
			[_dude,"Hz_ambw_shout"] remoteExecCall ["say3D",0,false];
			
			_curMuz = currentmuzzle _dude; 
			_dude enableAI "MOVE";
			
			for "_i" from 1 to 5 do {
				
				_dude dotarget _vip;
				_dude forceWeaponFire [_curMuz, "Single"];
				uisleep 0.33;					
				
			};
			
			_dude enableAI "AUTOTARGET";
			_dude forceSpeed -1;
			
		} else {
		
			{
				// in case crowd is told to get down by players
				if ((random 1) < 0.5) then {
					_x setUnitPos "UP";
				};
			} foreach _crowd;
			
			if ((unitPos _vip) != "UP") then {
				[_vip, "UP"] remoteExecCall ["setUnitPos", _vip, false];
				sleep 0.5;
			};
			
		};
		
	};
	
	[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;
	
};

switch (true) do {

case (_preachCounter >= _preachMax) : {
		
		"The VIP has finished his speech. Return him to base ASAP." remoteExecCall ["hint",0,false];

		waituntil {

			_vip call Hz_fnc_noCaptiveCheck;
			{_x call Hz_fnc_noCaptiveCheck} foreach _guards;
			(units group _vip) call Hz_fnc_noSideCivilianCheck;

			sleep 5;
			[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;

			(
			!(call Hz_fnc_taskSuccessCheckGenericConditions)
			|| (((_vip distance _returnPoint) < 15) && (!(_vip call Hz_fnc_isUncon)))
			|| !(alive _vip)
			|| (({(_vip distance _x) < 300} count playableUnits) < 1)
			|| Hz_pops_task_auxFailCondition
			)
		};
		
		if (!(call Hz_fnc_taskSuccessCheckGenericConditions)) then {
		
			"We've taken too many casualties for this mission. We're aborting. RTB immediately!" remoteExecCall ["hint",0,false];		
		
		};
		
		if (Hz_pops_task_auxFailCondition) then {
		
			"You killed one of the VIP's guards!" remoteExecCall ["hint",0,false];
		
		};

	};
	
case (({(_vip distance _x) < 300} count playableUnits) < 1) : {
		
		"You abandoned the VIP!" remoteExecCall ["hint",0,false];
		
	};
	
case (hz_reward <= 0) : {
		
		"We've taken too many casualties for this mission. We're aborting. RTB immediately!" remoteExecCall ["hint",0,false];
		
	};
	
case (!alive _vip) : {
		
		"The VIP is KIA, abort mission!" remoteExecCall ["hint",0,false];
		
	};
	
case (Hz_pops_task_auxFailCondition) : {

		"You killed one of the VIP's guards!" remoteExecCall ["hint",0,false];

};
	
	default {
		
		"The VIP wasn't able to finish his speech, but at least he's still alive. And he's got you to thank for that!" remoteExecCall ["hint",0,false];
		
		sleep 5;
		
	};

};

if (hz_reward > 0) then {

	hz_reward = ceil hz_reward;

};

/*------------------- INTENSIFY AMBIENT COMBAT---------------------------*/

if (_suicidebomber) then {

	Hz_ambw_pat_maxNumOfUnits = Hz_ambw_pat_maxNumOfUnits - Hz_ambient_units_intensify_amount;
	publicVariable "Hz_ambw_pat_maxNumOfUnits";

};

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/  

if((call Hz_fnc_taskSuccessCheckGenericConditions) && (alive _vip) && (({(_vip distance _x) < 300} count playableUnits) > 0) && !Hz_pops_task_auxFailCondition) then {
	[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;             
	
	call Hz_fnc_taskReward;
	
}else{
	[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
};

/*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       

[patrol_task_units,_position,patrol_task_vehs,_vip,_crowd,_newComp] spawn {
	
	
	private ["_units","_vehs","_markers"];
	_units = _this select 0;
	_pos = _this select 1;
	_vehs = _this select 2;
	_vip = _this select 3;
	_crowd = _this select 4;
	_newComp = _this select 5;
	
	while{ ({(_x distance _pos) < 50} count playableUnits) > 0} do { sleep 60 };
	
	{
		_veh = vehicle _x;
		if (_veh == _x) then {							
			deletevehicle _x;							
		} else {							
			_veh deleteVehicleCrew _x;							
		};	
	} foreach (_vip getVariable "guards");
	{deletevehicle _x} foreach _crowd;
	{deletevehicle _x} foreach _newComp;
	
	_veh = vehicle _vip;
	if (_veh == _vip) then {							
		deletevehicle _vip;							
	} else {							
		_veh deleteVehicleCrew _vip;							
	};
	
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
