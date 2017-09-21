// Written by EightySix

if(!isServer) exitWith{};

_this spawn {
	private["_count","_task","_mission"];

	_count = (count _this) - 1;
	mps_mission_status = 0;

	for "_i" from 0 to _count do { 
		_mission = _this select _i;
		mps_mission_status = 1;
		sleep 1;
		_task = [] execVM format["tasks\%1.sqf",_mission];
		waitUntil{sleep 30; scriptDone _task};
		mps_mission_status = 0;
	};

	if(true) exitWith {mps_mission_finished = true; publicVariable "mps_mission_finished";};
};