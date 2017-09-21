// Written by EightySix
/*
if(isNil "mps_lock_action") then { mps_lock_action = false; };
if (mps_lock_action) then {
	hint "The current operation isn't finished.";
}else{
	mps_lock_action = true;

	Hint parsetext format["Applying First Aid to Self<br/>Damage: %1 Percent",round((damage player)*100)];

	_healer = _this select 1;

	_healer playAction "medicStart";
	_healer disableAI "MOVE";
	_healer disableAI "TARGET";
	_healer disableAI "AUTOTARGET";

	sleep 5;

	_time = time;
	_damage = (damage _healer * 30);

	WaitUntil{
		time - _time > _damage
		|| (animationState _healer != "AinvPknlMstpSnonWrflDnon_medic0s" &&
		   animationState _healer != "AinvPknlMstpSnonWrflDnon_medic"	&&
		   animationState _healer != "AinvPknlMstpSnonWrflDnon_medic0"	&&
		   animationState _healer != "AinvPknlMstpSnonWrflDnon_medic1"	&&
		   animationState _healer != "AinvPknlMstpSnonWrflDnon_medic2"	&&
		   animationState _healer != "AinvPknlMstpSnonWrflDnon_medic3"	&&
		   animationState _healer != "AinvPknlMstpSnonWrflDnon_medic4"	&&
		   animationState _healer != "AinvPknlMstpSnonWrflDnon_medic5"	&&
		   animationState _healer != "AinvPknlMstpSnonWrflDnon_medicend")
		|| not alive _healer
	};

	_healer enableAI "MOVE";
	_healer enableAI "TARGET";
	_healer enableAI "AUTOTARGET";
	_healer playAction "medicStop";

	if(time - _time > _damage && alive _healer) then {
		_healer setDamage (damage player - 0.1);
		Hintsilent parsetext format["Finished Applying First Aid<br/>Damage: %1 Percent",round((damage player)*100)];
	};
	mps_lock_action = false;
};

*/