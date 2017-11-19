// Written by EightySix

if(isNil "mps_lock_action") then { mps_lock_action = false; };
if (mps_lock_action) then {
	hint "The current operation isn't finished.";
}else{

	mps_lock_action = true;

	_object = _this select 0;
	_position = position _object;
	_dir = direction _object;

	hint "Deploying Tower";
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 5;
	if (!alive _object || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon"; mps_lock_action = false; };
	sleep 5;
	if (!alive _object || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon"; mps_lock_action = false; };
	sleep 5;
	if (!alive _object || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon"; mps_lock_action = false; };
	sleep 5;
	if (!alive _object || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon"; mps_lock_action = false; };
	detach _object;
	deleteVehicle _object;
	sleep 1;
	_tower = "Land_TTowerBig_1_F" createVehicle [_position select 0, _position select 1, 0];

	//[nil, _tower, "per", rADDACTION, "Pack Tower", (mps_path+"action\mps_tower_pack.sqf"), [], 1, true, true, "", ""] call RE;
	[_tower,["Pack Tower",(mps_path+"action\mps_tower_pack.sqf"),[], 1, true, true, "", ""]] remoteExecCall ["addAction", 0, true];
	
	player addRating 50;

	mps_lock_action = false;

	if (true) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";};
};