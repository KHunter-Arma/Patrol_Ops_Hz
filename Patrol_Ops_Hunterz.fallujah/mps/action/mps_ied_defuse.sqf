// Written by BON_IF
// Adpated by EightySix

if(isNil "mps_lock_action") then { mps_lock_action = false; };
if (mps_lock_action) then {
	hint "The current operation isn't finished.";
}else{
	mps_lock_action = true; 

	_ied = _this select 0;
	_caller = _this select 1;
	_randomtime = 10 + round random 10;
	_delay = _randomtime;

	player playMove "ActsPercSnonWnonDnon_carFixing2";
	sleep _randomtime;
	player playMoveNow "AmovPercMstpSlowWrflDnon";

	if(not alive player) exitwith { player playMoveNow "AmovPercMstpSlowWrflDnon"; mps_lock_action = false; };

	if(getNumber (configFile >> "CfgVehicles" >> typeof _caller >> "canDeactivateMines") < 1) then {
		if(_randomtime > 12) then {
			hint "IED defuse failed. Detonating in 1 second!";
			sleep 1;
			_ied setvariable ["bon_ied_blowit",true,true];
		};
	};
	sleep 2;
	hint "";
	deleteVehicle _ied;

	mps_lock_action = false;

	if(true) exitwith { player playMoveNow "AmovPercMstpSlowWrflDnon"; };
};