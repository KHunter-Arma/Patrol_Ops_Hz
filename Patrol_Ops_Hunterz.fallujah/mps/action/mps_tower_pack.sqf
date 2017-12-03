// Written by EightySix

	_object = _this select 0;
	_position = position _object;
	hint "Packing Tower";
	player playMove "ActsPercSnonWnonDnon_carFixing2";
	sleep 5;
	if (!alive _object || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";};
	sleep 5;
	if (!alive _object || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";};
	sleep 5;
	if (!alive _object || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";};
	sleep 5;
	if (!alive _object || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";};
	detach _object;
	deleteVehicle _object;
	sleep 1;

	_container = [_position] call CREATE_MOVEABLE_TOWER;

	player addRating 25;

if (true) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";};