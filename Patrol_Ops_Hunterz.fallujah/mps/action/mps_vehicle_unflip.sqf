// Written by EightySix

if(isNil "mps_lock_action") then { mps_lock_action = false; };
if (mps_lock_action) then {
	hint "The current operation isn't finished.";
}else{

	mps_lock_action = true;

	_vehicle = _this select 0;

	if(damage _vehicle > 0.9) exitWith { hint "Vehicle is too damaged to flip over"; };

	player playMove "ActsPercSnonWnonDnon_carFixing2";

	sleep 5;

if (!alive _vehicle || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon"; mps_lock_action = false;};

	_vehicle setVectorUp [0,0,1];

if (true) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon"; mps_lock_action = false;};

};