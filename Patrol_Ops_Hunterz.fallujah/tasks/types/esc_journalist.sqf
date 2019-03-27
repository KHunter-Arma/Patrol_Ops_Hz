diag_log [time, diag_fps, daytime, "##### POPS HZ TASK ##### Escort Journalist #####"];
diag_log diag_activeSQFScripts;
diag_log diag_activeSQSScripts;
diag_log diag_activeMissionFSMs;

//#define playableUnits switchableUnits

/*-------------------- TASK PARAMS ---------------------------------*/

_rewardPerTarget = 50000;
_numberOfTargets = 4;
_minimumVantagePointHeight = 15;
_ambientCombatIntensifyAmount = 80;
_timeRequiredAtEachTarget = 5;

//Useful for justifying task-specific difficulties.
_rewardMultiplier = 1;

/*--------------------CREATE LOCATION---------------------------------*/

_downPayment = (_rewardPerTarget*_numberOfTargets)/_rewardMultiplier;

Hz_pops_task_auxFailCondition = false;
missionload = false;
publicVariable "missionload";
Hz_max_ambient_units = Hz_max_ambient_units + _ambientCombatIntensifyAmount;
publicVariable "Hz_max_ambient_units";
_timeRequiredAtEachTarget = _timeRequiredAtEachTarget*60;

_buildings = nearestobjects [markerpos "ao_centre",["House"],3000];

//coordinate filter
_temp = [];
{
 
 if (((getpos _x) select 1) > 4555) then {
 
	_temp pushBack _x;
 
 };
 
}foreach _buildings;
_buildings = +_temp;

//height filter
_temp = [];
{
  _buildingheight = (((boundingboxreal _x) select 1) select 2)*2;
  
  if(_buildingheight > 15) then {_temp pushBack _x;};

}foreach _buildings;
_buildings = +_temp;

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

[_vip,["<t color=""#00FF00"">Request to follow</t>",{

	[_this select 0] joinsilent grpNull;
	[_this select 0] joinsilent (group (_this select 1));

}, [], 1, true, true, "", "(!captive _target) && (alive _target) && ((group _target) != (group _this))"]] remoteexeccall ["addAction",0,true];

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

_networkName = "Battle Broadcast Corporation (BBC)";
if ((random 1) < 0.5) then {

	_networkName = "Conservative News Network (CNN)";

};

[ format["TASK%1",_taskid],
"Escort Journalist",
format ["A hotshot %1 war correspondent has just arrived in Fallujah thinking he can grab some close-up combat footage for the evening news. This isn't the kind of shooting we're used to doing, and normally we'd think twice about accepting a job like this, but the news channel offered us a load of money to escort him around town. The reporter has determined %2 areas to visit across Fallujah to get some shots. He will be waiting for you at the airbase to be picked up. Escort him through his itinerary and then return him to base. This guy doesn't know what he's getting into, so watch out for him. Remember, a dead client is not a paying client.",_networkName,_numberOfTargets],
(SIDE_A select 0),
[],
"created",
[0,0,0]
] call mps_tasks_add;



/*--------------------WAIT UNTIL TARGET MEETS PLAYERS---------------------------------*/

waituntil { 

	sleep 5;

	(
	((group _vip) != _grp)
	|| !(alive _vip)
	)
	
};

[-1, {

	if (((player distance _this) < 25) && (alive player) && !(captive player)) then {

	hint "Alright, let's do this! I think I know where to get the best shots for this one. Here, let me show you on your map where we're going.";

	};
	
}, _vip] call CBA_fnc_globalExecute;

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

}, [], -10, true, true, "", "(!captive _target) && (alive _target) && ((_target distance _this) <= 2.5)"]] remoteexeccall ["addAction",0,true];

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
	
		(units group _vip) call Hz_fnc_noSideCivilianCheck;

		if (captive _vip) then {
			
			[_vip, false] remoteExecCall ["setCaptive",_vip,false];
			
		};

		sleep 5;
		[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;

		(
		(((_vip distance _target) < 100) && ((vehicle _vip) == _vip) && !(captive _vip))
		|| !(alive _vip)
		|| (({(_vip distance _x) < 200} count playableUnits) < 1)
		|| Hz_pops_task_auxFailCondition
		)
		
	};
	
	[_vip] joinsilent grpNull;
	[_vip] joinsilent (creategroup [SIDE_A select 0,true]);
	sleep 1;
	[_vip,"CARELESS"] remoteExecCall ["setBehaviour",_vip,false];
	[_vip,"UP"] remoteExecCall ["setUnitPos",_vip,false];
	[_vip,15] remoteExecCall ["forcespeed",_vip,false];
	[_vip,_target] remoteExecCall ["domove",_vip,false];
	
	[-1, {

		if (((player distance _this) < 25) && (alive player) && !(captive player)) then {

		hint "Ok, I know where to go. Follow me!";

		};
	
	}, _vip] call CBA_fnc_globalExecute;
	
	_timeOnTarget = 0;
	
	waituntil { 
	
		(units group _vip) call Hz_fnc_noSideCivilianCheck;
	
		if (captive _vip) then {
			
				[_vip, false] remoteExecCall ["setCaptive",_vip,false];
			
		};

		sleep 1;
		[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;
		
		if (((_vip distance _target) <= 3.5) && !(captive _vip)) then {
		
			_timeOnTarget = _timeOnTarget + 1;
			
			if (_timeOnTarget == 1) then {
					
					if (local _vip) then {
					
						_vip forcespeed 0;
						dostop _vip;
						
					};
					
					[-1, {

						if (((player distance _this) < 25) && (alive player) && !(captive player)) then {

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

			if (((player distance _this) < 50) && (alive player) && !(captive player)) then {

				hint "Ok I'm done here, we can go now!";

			};
							
		}, _vip] call CBA_fnc_globalExecute;
		
		if (local _vip) then {
					
			_vip forcespeed -1;
						
		};
		
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
		
			(units group _vip) call Hz_fnc_noSideCivilianCheck;
			
			if (captive _vip) then {
			
				[_vip, false] remoteExecCall ["setCaptive",_vip,false];
			
			};

			sleep 5;
			[_spawnedSquads,_otherReward,_rewardMultiplier] call Hz_fnc_calculateTaskReward;

			(
			!(call Hz_fnc_taskSuccessCheckGenericConditions)
			|| (((_vip distance _returnPoint) < 15) && (!captive _vip))
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

Hz_max_ambient_units = Hz_max_ambient_units - _ambientCombatIntensifyAmount;
publicVariable "Hz_max_ambient_units";

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
	
	deleteVehicle _vip;	
	
	{deletevehicle _x}forEach _units;
	{deletevehicle _x}forEach _vehs;
	
};      

/*--------------------RESET INTEL---------------------------------*/

mps_civilian_intel = []; publicVariable "mps_civilian_intel";