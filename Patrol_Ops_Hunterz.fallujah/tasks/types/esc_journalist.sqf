diag_log [time, diag_fps, daytime, "##### POPS HZ TASK ##### Escort Journalist #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

//#define playableUnits switchableUnits

private ["_rewardPerTarget", "_numberOfTargets", "_minimumVantagePointHeight", "_ambientCombatIntensifyAmount", "_timeRequiredAtEachTarget", "_rewardMultiplier", "_downPayment", "_buildings", "_buildingheight", "_vantagePoints", "_bpos", "_targets", "_taskid", "_otherReward", "_returnPoint", "_grp", "_type", "_vip", "_networkName", "_spawnedSquads", "_timeOnTarget", "_target", "_minNumberOfTargets", "_maxNumberOfTargets", "_thisBuilding"];

/*-------------------- TASK PARAMS ---------------------------------*/

_rewardPerTarget = 75000;
_minNumberOfTargets = 2;
_maxNumberOfTargets = 4;
_minimumVantagePointHeight = 15;
_ambientCombatIntensifyAmount = Hz_ambient_units_intensify_amount;
_timeRequiredAtEachTarget = 5;

//Useful for justifying task-specific difficulties.
_rewardMultiplier = 1;

/*--------------------CREATE LOCATION---------------------------------*/

_numberOfTargets = _minNumberOfTargets max (round (random _maxNumberOfTargets));

_downPayment = (_rewardPerTarget*_numberOfTargets)/_rewardMultiplier;

Hz_pops_task_auxFailCondition = false;
Hz_ambw_pat_disablePatrols = false;
publicVariable "Hz_ambw_pat_disablePatrols";
Hz_ambw_pat_maxNumOfUnits = Hz_ambw_pat_maxNumOfUnits + _ambientCombatIntensifyAmount;
publicVariable "Hz_ambw_pat_maxNumOfUnits";
_timeRequiredAtEachTarget = _timeRequiredAtEachTarget*60;

_buildings = (nearestObjects [markerPos "ao_centre",["House"],7100]) select {
	((getDammage _x) < 0.1)
	&& {!(isObjectHidden _x)}
	&& {(_x distance (markerpos "BASE")) > 2000}
	&& {
		_thisBuilding = _x;
		({(_thisBuilding distance (_x select 0)) < 1200} count Hz_ambw_sc_sectors) > 0	
	}
	&& {
		_buildingheight = (((boundingBoxReal _x) select 1) select 2)*2;
		_buildingheight > (_minimumVantagePointHeight + 5)
	}
};

_vantagePoints = [];
{
  _bpos = [_x] call BIS_fnc_buildingPositions;	
	{
		//get high and open positions
		if ((!lineIntersects [AGLToASL _x, AGLToASL [_x select 0,_x select 1,150]]) && ((_x select 2) > _minimumVantagePointHeight)) then {
			_vantagePoints pushBack _x;	
		};
	} foreach _bpos;
}foreach _buildings;

if ((count _vantagePoints) == 0) exitWith {
	hint "ERROR! Task found no suitable vantage points!";
	diag_log "##### ERROR! Task found no suitable vantage points!";
};

_targets = [];

for "_i" from 1 to _numberOfTargets do {

	_target = _vantagePoints call mps_getRandomElement;
	_targets pushback _target;
	_vantagePoints = _vantagePoints - [_target];

};

_taskid = format["%1%2%3",round (random 15),round (random 15),(round random 999)];
Hz_task_ID = _taskid;
Hz_econ_aux_rewards = 0;
_otherReward = 0;

_returnPoint = markerPos "return_point_west";

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";
mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TARGET-----------------------------------*/

_grp = createGroup (SIDE_A select 0);
_type = ["C_journalist_F","C_Journalist_01_War_F"] call mps_getRandomElement;
_vip = _grp createUnit [ _type, _returnPoint, [], 10, "NONE"];
_vip setRank "PRIVATE";
dostop _vip;
_vip setVariable ["Hz_disableFSM",true];
_vip setVariable ["Hz_ambw_disableSideRelations",true,true];

_grp deleteGroupWhenEmpty true;

_vip setVariable ["holdingPos", false, true];

[_vip,["<t color=""#00FF00"">Request to follow</t>",{

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

[_vip,["<t color=""#FFFF00"">Hold position</t>",{

	_vip = _this select 0;
	
	_vip setVariable ["holdingPos", true, true];
	[_vip, "PATH"] remoteExecCall ["disableAI", _vip];

}, [], 0, true, true, "", "(!(_target call Hz_fnc_isUncon)) && {alive _target} && {(group _target) == (group _this)} && {!(_target getvariable ""holdingPos"")}",5]] remoteexeccall ["addAction",0,true];

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

_networkName = "Battle Broadcast Corporation (BBC)";
if ((random 1) < 0.5) then {

	_networkName = "Conservative News Network (CNN)";

};

[ format["TASK%1",_taskid],
"New Mission Received",
format ["A hotshot %1 war correspondent has just arrived in Fallujah thinking he can grab some close-up combat footage for the evening news. This isn't the kind of shooting we're used to doing, and normally we'd think twice about accepting a job like this, but the news channel offered us a load of money to escort him around town. The reporter has determined %2 areas to visit across Fallujah to get some shots. He will be waiting for you at the airbase to be picked up. Escort him through his itinerary and then return him to base. This guy doesn't know what he's getting into, so watch out for him. Remember, a dead client is not a paying client.",_networkName,_numberOfTargets],
(SIDE_A select 0),
[],
"created",
[0,0,0]
] call mps_tasks_add;



/*--------------------WAIT UNTIL TARGET MEETS PLAYERS---------------------------------*/

waituntil {

	sleep 5;

	((isplayer leader group _vip) && {!(_vip call Hz_fnc_isUncon)})
	|| !(alive _vip)
	
};

if (alive _vip) then {

	[-1, {

		if (((player distance _this) < 25) && (alive player) && (!(player call Hz_fnc_isUncon))) then {

		hint "Alright, let's do this! I think I know where to get the best shots for this one. Here, let me show you on your map where we're going.";

		};
	
	}, _vip] call CBA_fnc_globalExecute;

};



[_vip,["<t color=""#0000FF"">Ask where to go</t>",{

	if ((str (markerpos taskMarker)) != "[0,0,0]") exitwith {
		
		hint "Sigh... just check your map...";
	
	};
	
	hint "If you had listened to me the first time, you wouldn't be asking me again! Here, I'll mark it again...";
	
	deleteMarker taskMarker;
	taskMarker = createMarker [str random 111,taskTarget];
	publicVariable "taskMarker";
	taskMarker setMarkerColor "ColorGreen";
	taskMarker setMarkerText (format ["Target (%1m high)",round (taskTarget select 2)]);
	taskMarker setMarkerType "mil_objective";

}, [], -10, true, true, "", "(alive _target) && {!(_target call Hz_fnc_isUncon)}", 5]] remoteexeccall ["addAction",0,true];

/*--------------------WAIT UNTIL TARGET ARRIVES---------------------------------*/

hz_reward = 1;
_otherReward = _otherReward + _downPayment;
_spawnedSquads = 0;
taskMarker = "";

for "_i" from 1 to _numberOfTargets do {

	if (!alive _vip) exitwith {};

	_target = _targets select 0;	

	deleteMarker taskMarker;
	taskTarget = _target;
	publicVariable "taskTarget";
	taskMarker = createMarker [str random 111,taskTarget];
	publicVariable "taskMarker";
	taskMarker setMarkerColor "ColorGreen";
	taskMarker setMarkerText (format ["Target (%1m high)",round (taskTarget select 2)]);
	taskMarker setMarkerType "mil_objective";

	waituntil {
	
		// allow cuffing because some building pos might not be so AI-friendly...
		if ((captive _vip) && {!(_vip call Hz_fnc_isUncon)}) then {
			[_vip, false] remoteExecCall ["setCaptive",_vip];
		};
		_vip call Hz_fnc_noSideCivilianCheck;

		sleep 5;
		[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;

		(
		(((_vip distance _target) < 100) && ((vehicle _vip) == _vip) && !(_vip call Hz_fnc_isUncon))
		|| !(alive _vip)
		|| (({(_vip distance _x) < 200} count playableUnits) < 1)
		|| Hz_pops_task_auxFailCondition
		)
		
	};
	
	if (!alive _vip) exitwith {};
	
	[_vip] joinsilent (creategroup [SIDE_A select 0,true]);
	sleep 1;
	[_vip,"CARELESS"] remoteExecCall ["setBehaviour",_vip,false];
	[_vip,"UP"] remoteExecCall ["setUnitPos",_vip,false];
	[_vip,15] remoteExecCall ["forcespeed",_vip,false];
	[_vip,_target] remoteExecCall ["domove",_vip,false];
	
	[-1, {

		if (((player distance _this) < 25) && (alive player) && !(player call Hz_fnc_isUncon)) then {

		hint "Ok, I know where to go. Follow me!";

		};
	
	}, _vip] call CBA_fnc_globalExecute;
	
	_timeOnTarget = 0;
	
	waituntil { 
	
		// allow cuffing because some building pos might not be so AI-friendly...
		if ((captive _vip) && {!(_vip call Hz_fnc_isUncon)}) then {
			[_vip, false] remoteExecCall ["setCaptive",_vip];
		};
		_vip call Hz_fnc_noSideCivilianCheck;

		sleep 1;
		[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;
		
		if (((_vip distance _target) <= 3.5) && !(_vip call Hz_fnc_isUncon)) then {
		
			_timeOnTarget = _timeOnTarget + 1;
			
			if (_timeOnTarget == 1) then {
					
					if (local _vip) then {
					
						[_vip, 0] remoteExecCall ["forcespeed",_vip];
						dostop _vip;
						
					};
					
					[-1, {

						if (((player distance _this) < 25) && (alive player) && !(player call Hz_fnc_isUncon)) then {

						hint "I'll set up my equipment here. I need about 5 minutes at this position to get some good shots.";

						};
						
					}, _vip] call CBA_fnc_globalExecute;

			};
		
		};

		(
		(_timeOnTarget > _timeRequiredAtEachTarget)
		|| !(alive _vip)
		|| (({(_vip distance _x) < 200} count playableUnits) < 1)
		|| Hz_pops_task_auxFailCondition
		)
		
	};
	
	if (alive _vip) then {
	
		[-1, {

			if (((player distance _this) < 50) && (alive player) && !(player call Hz_fnc_isUncon)) then {

				hint "Ok I'm done here, we can go now!";

			};
							
		}, _vip] call CBA_fnc_globalExecute;
		
		[_vip, -1] remoteExecCall ["forcespeed",_vip];
		
		_targets = _targets - [_target];
	
	};	

};

deleteMarker taskMarker;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

switch (true) do {

case ((count _targets) == 0) : {

		sleep 5;
		
		"The reporter has finished his work. Our job is done here. Take him back to base ASAP." remoteExecCall ["hint",0,false];

		waituntil {
		
			// allow cuffing because some building pos might not be so AI-friendly...
			if ((captive _vip) && {!(_vip call Hz_fnc_isUncon)}) then {
				[_vip, false] remoteExecCall ["setCaptive",_vip];
			};
			_vip call Hz_fnc_noSideCivilianCheck;

			sleep 5;
			[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;

			(
			!(call Hz_fnc_taskSuccessCheckGenericConditions)
			|| (((_vip distance _returnPoint) < 15) && !(_vip call Hz_fnc_isUncon))
			|| !(alive _vip)
			|| (({(_vip distance _x) < 200} count playableUnits) < 1)
			|| Hz_pops_task_auxFailCondition
			)
		};
		
		if (!(call Hz_fnc_taskSuccessCheckGenericConditions)) then {
		
			"We've taken too many casualties for this mission. We're aborting. RTB immediately!" remoteExecCall ["hint",0,false];		
		
		};
		
		if (Hz_pops_task_auxFailCondition) then {
		
		
		};

};
	
case (({(_vip distance _x) < 200} count playableUnits) < 1) : {
		
		"You abandoned the reporter!" remoteExecCall ["hint",0,false];
		
	};
	
case (hz_reward <= 0) : {
		
		"We've taken too many casualties for this mission. We're aborting. RTB immediately!" remoteExecCall ["hint",0,false];
		
	};
	
case (!alive _vip) : {
		
		"The reporter is KIA, abort mission!" remoteExecCall ["hint",0,false];
		
	};
	
case (Hz_pops_task_auxFailCondition) : {

		

};

};

if (hz_reward > 0) then {

	hz_reward = ceil hz_reward;

};

Hz_ambw_pat_maxNumOfUnits = Hz_ambw_pat_maxNumOfUnits - _ambientCombatIntensifyAmount;
publicVariable "Hz_ambw_pat_maxNumOfUnits";

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/  

if((call Hz_fnc_taskSuccessCheckGenericConditions) && (alive _vip) && (({(_vip distance _x) < 200} count playableUnits) > 0) && !Hz_pops_task_auxFailCondition) then {
	[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;             
	
	call Hz_fnc_taskReward;
	
}else{
	[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
};

/*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       

[patrol_task_units,patrol_task_vehs,_vip] spawn {
	
	
	private ["_units","_vehs","_markers"];
	_units = _this select 0;
	_vehs = _this select 1;
	_vip = _this select 2;
		
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

/*--------------------RESET INTEL---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";