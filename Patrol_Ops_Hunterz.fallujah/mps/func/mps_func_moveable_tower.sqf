// Written by EightySix

private["_position"];

if(count _this < 1) exitWith{};

	_position = (_this select 0) call mps_get_position;

	_container = [_position] call CREATE_MOVEABLE_CONTAINER;

	_condition = "!(_target getVariable ""mps_loadable"")";
	[nil, _container, "per", rADDACTION, "Deploy Tower", (mps_path+"action\mps_tower_deploy.sqf"), [], 1, false, true, "", _condition] call RE;

_container