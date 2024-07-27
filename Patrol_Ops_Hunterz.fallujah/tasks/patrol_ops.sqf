scriptName "Hz_pops_TaskMaster";

/*

if(count mps_loc_hills > 0) then {

  _location = [["hill"]] call mps_getNewLocation;
  

  [_location] spawn CREATE_OPFOR_AIRPATROLS;

};
*/

_allTasks = [
    "def_base",
		"def_castle",
		"esc_speaker",
		"esc_supplies",
    "def_fob",
		"sar_pow",
		"esc_journalist",
		"sad_cache",
		"sar_supplies",
		"def_inscamp"
    ];
		
if(hz_debug) then {
	_allTasks = ["sar_supplies"];
};

// reset vars
taskrequested = false;
publicvariable "taskrequested";
jointops = false;
publicvariable "jointops";
Hz_patrol_task_in_progress = false;
publicvariable "Hz_patrol_task_in_progress";
Hz_pops_heartsandmindsInProgress = false;
publicvariable "Hz_pops_heartsandmindsInProgress";
Hz_pops_heartsandmindsTaskRequested = false;
publicvariable "Hz_pops_heartsandmindsTaskRequested";
Hz_pops_heartsandmindsTaskRequester = objNull;
publicvariable "Hz_pops_heartsandmindsTaskRequester";

reinforcementsqueued = false;
patrol_task_units = [];
patrol_task_vehs = [];

stopreinforcements = true;
publicVariable "stopreinforcements";
Hz_ambw_pat_disablePatrols = false;
publicVariable "Hz_ambw_pat_disablePatrols";
Hz_pops_baseSupportEnabled = true;
publicVariable "Hz_pops_baseSupportEnabled";

//reset flag for garrison script
if (isNil "Hz_resetBuildingVars") then {
	Hz_resetBuildingVars = [];
};
{
	_x setvariable ["occupied",false];
} foreach Hz_resetBuildingVars;
Hz_resetBuildingVars = [];

if (isMultiplayer) then {
	waitUntil {
		sleep 2;
		(!isNil "Hz_pers_serverInitialised") && {Hz_pers_serverInitialised}
	};
	sleep 30;
};
waituntil {
	sleep 10;
	(time > 300) || {hz_debug}
};
waituntil {
	sleep 10;
	(taskrequested) || {jointops} || {Hz_pops_heartsandmindsTaskRequested}
};

Hz_ambw_pat_disablePatrols = true; 
publicVariable "Hz_ambw_pat_disablePatrols";
Hz_pops_baseSupportEnabled = false;
publicVariable "Hz_pops_baseSupportEnabled";
stopreinforcements = false;
publicVariable "stopreinforcements";

if (Hz_pops_heartsandmindsTaskRequested) exitWith {
	[] execvm "tasks\heartsandminds.sqf";
};

if(jointops) exitwith {
	[] execvm "tasks\joint_ops.sqf";
};

if ((count Hz_save_prev_tasks_list) >= (count _allTasks)) then {
	Hz_save_prev_tasks_list = [];
	publicVariable "Hz_save_prev_tasks_list";
};
_availableTasks = _allTasks - Hz_save_prev_tasks_list;

if (!hz_debug) then {
	if (((count playableUnits) + ({isplayer _x} count alldead)) < 8) then {
		_availableTasks = _availableTasks - ["sad_scud"];
	};
};

_nextTask = selectRandom _availableTasks;

waituntil {
	sleep 5;
	(count allunits) < Hz_max_units_before_task
};

//check to see conditions are still true after last wait
if (
		(((count playableunits) >= Hz_pops_minPlayerCountForTask) && 
		(({_x getvariable ["TL",false]} count playableunits) >= Hz_pops_minOfficerCountForTask) &&
		(({_x getvariable ["PMC",false]} count playableunits) >= Hz_pops_minUnitMemberCountForTask)) 
		|| hz_debug
		) then {
		
	Hz_patrol_task_in_progress = true;
	publicvariable "Hz_patrol_task_in_progress";
	
	call compile preprocessFileLineNumbers format["tasks\types\%1.sqf",_nextTask];
		
	Hz_save_prev_tasks_list pushBack _nextTask;
	publicVariable "Hz_save_prev_tasks_list";
	
} else {
	"Conditions required to receive a mission are no longer valid. Mission request has been cancelled!" remoteExecCall ["hint", 0];
};	

[] execvm "tasks\patrol_ops.sqf";