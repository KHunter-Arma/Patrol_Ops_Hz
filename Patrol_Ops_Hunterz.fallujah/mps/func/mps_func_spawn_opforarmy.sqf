// Written by BON_IF
// Adpated by EightySix

if(!(call Hz_fnc_isTaskMaster)) exitWith{};

EnemiesSpawned = false;
_Enemies = [];
_pos = (_this select 0) call mps_get_position;
_pos set [2,0];

_forcetype = "DEFAULT";
if(count _this > 1) then {
	if(typeName (_this select 1) == "STRING") then{_forcetype = _this select 1};
};

_spawnpos = _pos;
While{_forcetype == "REINFORCEMENTS" && ({isPlayer _x} count nearestObjects [_spawnpos,["CAManBase"],1200] > 0 || _spawnpos distance _pos < 800)} do{
	_radius = 800;
	_angle = random 360;
	_a = (_pos select 0) + (sin(_angle) * (_radius + random 200));
	_b = (_pos select 1) + (cos(_angle) * (_radius + random 200));
	_spawnpos = [_a,_b,0];
};

_linear_equation = {
	_min = _this select 0;
	_max = _this select 1;
	_players = 1 max (playersNumber (SIDE_A select 0));
	_a = (_max-_min)/(mps_ref_playercount-1);
	_b = _min - _a;
	_result = round(_players * _a + _b);
	_result
};

_reinf_prob = {
	if(_forcetype == "REINFORCEMENTS") then{
		round random 1
	} else {1}
};

_reinf_movement = {
	_grp = _this select 0;
	_pos = _this select 1;
	(_grp addWaypoint [_pos,200]) setWaypointBehaviour "CARELESS";
	_grp setSpeedMode "FULL";
	{_x allowFleeing 0} foreach units _grp;
	While{{_x distance _pos < 200} count units _grp == 0 && {alive _x} count units _grp > 0} do {sleep 5};
	if({alive _x} count units _grp > 0) then {_this spawn mps_patrol_init};
};

_tankweight	= (mps_params_armour call _linear_equation) * mps_params_muliply * (call _reinf_prob);
_apcweight	= (mps_params_apc call _linear_equation) * mps_params_muliply * (call _reinf_prob);
_carweight 	= (mps_params_car call _linear_equation) * mps_params_muliply * (call _reinf_prob);
_infweight	= (mps_params_inf call _linear_equation) * mps_params_muliply * (call _reinf_prob);
_aaweight	= (mps_params_aa call _linear_equation) * mps_params_muliply * (call _reinf_prob);

private ["_armortypes","_apctypes","_cartypes","_aatypes"];
call compile format["
	_armortypes = mps_opfor_armor;
	_apctypes = mps_opfor_apc;
	_cartypes = mps_opfor_car;
	_aatypes = mps_opfor_aa;
"];

//hint format["%1, %2, %3, %4, %5",_tankweight,_apcweight,_carweight,_aaweight,_infweight];
/********************************* SPAWN ENEMIES **********************************************/
for "_i" from 1 to (_tankweight max (_apcweight max (_carweight max (_aaweight max _infweight)))) do {
	if(_i <= _tankweight) then{
		_j = (count _armortypes - 1) min (round random (count _armortypes));
		_tank = _armortypes select _j;
		_Grp = [_tank,(SIDE_B select 0),_spawnpos,200] call mps_spawn_vehicle;
		_Enemies = _Enemies + units _Grp;

		if(_forcetype == "REINFORCEMENTS") then {[_Grp,_pos] spawn _reinf_movement}
		else {[_Grp,_pos,"standby"] spawn mps_patrol_init};
	};

	if(_i <= _apcweight) then{
		_j = (count _apctypes - 1) min (round random (count _apctypes));
		_apc = _apctypes select _j;
		_Grp = [_apc,(SIDE_B select 0),_spawnpos,200] call mps_spawn_vehicle;
		_Enemies = _Enemies + units _Grp;

		if(_forcetype == "REINFORCEMENTS") then {[_Grp,_pos] spawn _reinf_movement}
		else {[_Grp,_pos,"standby"] spawn mps_patrol_init};
	};

	if(_i <= _aaweight) then{
		_j = (count _aatypes - 1) min (round random (count _aatypes));
		_aa = _aatypes select _j;
		_Grp = [_aa,(SIDE_B select 0),_spawnpos,200] call mps_spawn_vehicle;
		_Enemies = _Enemies + units _Grp;

		if(_forcetype == "REINFORCEMENTS") then {[_Grp,_pos] spawn _reinf_movement}
		else {[_Grp,_pos,"standby"] spawn mps_patrol_init};
	};

	if(_i <= _carweight) then{
		_j = (count _cartypes - 1) min (round random (count _cartypes));
		_car = _cartypes select _j;
		_Grp = [_car,(SIDE_B select 0),_spawnpos,200] call mps_spawn_vehicle;
		_Enemies = _Enemies + units _Grp;

		if(_forcetype == "REINFORCEMENTS") then {[_Grp,_pos] spawn _reinf_movement}
		else {[_Grp,_pos,"patrol"] spawn mps_patrol_init};
	};

	if(_i <= _infweight) then{
		_Grp = [_spawnpos,"INF",(6 + round random (playersNumber (SIDE_A select 0))),200,false] call CREATE_OPFOR_SQUAD;
		_Enemies = _Enemies + units _Grp;

		if(_forcetype == "REINFORCEMENTS") then {[_Grp,_pos] spawn _reinf_movement}
		else {
			if(random 2 < 1.25) then {[_Grp,_pos,"hide"] spawn mps_patrol_init}
			else {[_Grp,_pos,"patrol"] spawn mps_patrol_init};
		};
	};
};

/*********************************************************************************************/
_Enemies spawn mps_cleanup;
EnemiesSpawned=true;
sleep 5;
ReinfSpawn=false;
if(enemy_reinforcements == 1 && not (_forcetype == "MAIN FORCE")) then {
	_total = (count _Enemies) / ([2,9] call _linear_equation);
	While {MISSIONSTAT == "IN PROGRESS" && {alive _x} count _Enemies >= _total*1.5} do{sleep 2.5};
	if(MISSIONSTAT != "IN PROGRESS") exitWith{};

	ReinfSpawn=true;
	[_location,"REINFORCEMENTS"] spawn CREATE_OPFOR_ARMY;
};