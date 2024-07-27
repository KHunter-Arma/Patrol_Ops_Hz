scriptName "Hz_pops_HMTask";

waitUntil {
	!isNull Hz_pops_heartsandmindsTaskRequester
};

_allTasks = [
    "sar_daughter",
		"rec_files",
		"def_area"
    ];
		
if(hz_debug) then {
	_allTasks = ["def_area"];
};

if ((count Hz_pops_HM_prevTaskList) >= (count _allTasks)) then {
	Hz_pops_HM_prevTaskList = [];
	publicVariable "Hz_pops_HM_prevTaskList";
};
_availableTasks = _allTasks - Hz_pops_HM_prevTaskList;
_nextTask = selectRandom _availableTasks;

Hz_pops_heartsandmindsInProgress = true;
publicvariable "Hz_pops_heartsandmindsInProgress";

call compile preprocessFileLineNumbers format["tasks\heartsandminds\%1.sqf",_nextTask];

Hz_pops_HM_prevTaskList pushBack _nextTask;
publicVariable "Hz_pops_HM_prevTaskList";

[] execvm "tasks\patrol_ops.sqf";