// Written by BON_IF
// Adpated by EightySix
/*
_healer = _this select 1;
_injuredperson = _this select 3;
_behaviour = behaviour _healer;
_timenow = time;

if(not (isPlayer _healer) && _healer distance _injuredperson > 4) then {
	_healer setBehaviour "AWARE";
	_healer doMove position _injuredperson;
	WaitUntil{	_healer distance _injuredperson <= 4		 ||
			not alive _injuredperson			 ||
			not (_injuredperson getVariable "ais_agony") ||
			not alive _healer				 ||
			_healer getVariable "ais_agony"		 ||
			time - _timenow > 120
	};
};

if(_healer distance _injuredperson > 4) exitWith{_healer setBehaviour _behaviour};

_injuredperson setVariable ["healer",_healer,true];
_healer playAction "medicStart";
_offset = [0,0,0]; _dir = 0;
_relpos = _injuredperson worldToModel position _healer;

if((_relpos select 0) < 0) then{_offset=[-0.8,0.2,0]; _dir=90} else{_offset=[0.8,0.2,0]; _dir=270};

_healer attachTo [_injuredperson,_offset];
_healer setDir _dir;
_healer disableAI "MOVE";
_healer disableAI "TARGET";
_healer disableAI "AUTOTARGET";

sleep 5;

_time = time;
_damage = (damage _injuredperson * 30);

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
	|| (_healer distance _injuredperson) > 2
	|| not alive _injuredperson
};

detach _healer;
_healer enableAI "MOVE";
_healer enableAI "TARGET";
_healer enableAI "AUTOTARGET";
_injuredperson setVariable ["healer",ObjNull,true];
_healer playAction "medicStop";
_healer setBehaviour _behaviour;

if(time - _time > _damage) then {
	_injuredperson setVariable ["ais_agony",false,true];
	_healer addRating 200;
};

*/