// Written by EightySix

if(!(call Hz_fnc_isTaskMaster)) exitWith{};

_this spawn {
	private["_count","_task","_mission"];

	_count = (count _this) - 1;
	mps_mission_status = 0;

	for "_i" from 0 to _count do { 
		_mission = _this select _i;
		mps_mission_status = 1;
		call compile preprocessFileLineNumbers format["tasks\%1.sqf",_mission];
		mps_mission_status = 0;
	};

	if(true) exitWith {mps_mission_finished = true; publicVariable "mps_mission_finished";};
};