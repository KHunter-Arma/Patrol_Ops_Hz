scriptName "Hz_pops_JointOp";

_allTasks = [
	"cap_town",
	"def_camp",
	"def_town"
];

_nextTask = selectRandom _allTasks;

{
	_x setVehicleLock "UNLOCKED";
} foreach Hz_save_jointOps_vehicles;

Hz_patrol_task_in_progress = true;
publicvariable "Hz_patrol_task_in_progress";

call compile preprocessFileLineNumbers format["tasks\jops_types\%1.sqf", _nextTask];

[] execvm "tasks\patrol_ops.sqf";