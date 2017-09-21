diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Search and Destroy Cache Initialise"];

private["_location","_position","_taskid","_grp","_stance"];



/*


OUT OF ROTATION!


*/


/*-------------------- TASK PARAMS ---------------------------------*/
_enemySpawnRange = 5000;
_minSquadCount = 2;
_maxSquadCount = 5;

//Chance of a squad having the following vehicle support (can't have more than 1 vehicle per squad)
_CASchance = 0.2;
_TankChance = 0.01;
_IFVchance = 0.2;
_AAchance = 0.2;
_CarChance = 0.4;

//Useful for justifying task-specific difficulties.
_rewardmultiplier = 1.2;
/*--------------------CREATE LOCATION---------------------------------*/

_enemySpawnRange = floor (_enemySpawnRange / (sqrt 2));

	_location = [["towns"]] call mps_getNewLocation;
	_position = [[(position _location) select 0,(position _location) select 1, 0],500,1,2] call mps_getFlatArea;
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
        Hz_task_ID = _taskid;
        Hz_econ_aux_rewards = 0;
        _otherReward = 0;
        
/*--------------------CREATE TARGET-----------------------------------*/

	_cachetype = "RUSpecialWeaponsBox";
	if(mps_oa) then {_cachetype = "TKVehicleBox_EP1"};

	TARGET_CACHE = _cachetype createVehicle _position;
        [TARGET_CACHE] spawn mps_object_c4only;
        
/*--------------------MOVE TARGET TO LOCATION-------------------------*/

	_houses = [_position,800] call mps_getEnterableHouses;
	_house = [];
	_hideout = [];

	for "_i" from 1 to 10000 do {
		_house = _houses call mps_getRandomElement;
		_buildingpos = round random (_house select 1);
		_house = (_house select 0);
		_hideout = (_house buildingPos _buildingpos);
		if(count (_hideout - [0]) > 0) exitWith{};
	};

	TARGET_CACHE setPos _hideout;

	if(mps_debug) then {
		_marker = createMarkerLocal [format["Debug%1",_taskid],position TARGET_CACHE];
		_marker setMarkerTypeLocal "mil_dot";
		_marker setMarkerColorLocal "ColorGreen";
	};

/*--------------------Setup Intel Handler-------------------------*/

	objective_intel = 0;
	objective_marker = [];
	objective_location = position TARGET_CACHE;

	objective_intel_KILLED = {
		if(side _this == (SIDE_B select 0) && random 3 < 1) then {
			_this addEventHandler ["Killed",{
				_unit = _this select 0;
				_pos = [(getPos _unit select 0) + 1 - random 2,(getPos _unit select 1) + 1 - random 2,0];
				_ev = (["EvMap","EvMoscow","EvPhoto"] call mps_getRandomElement) createvehicle _pos;
				_ev setPosATL _pos;
				_ev spawn {
					while{alive TARGET_CACHE && {isPlayer _x && side _x == (SIDE_A select 0)} count nearestObjects[position _this,["All"],3] == 0} do {sleep 2};
					if(!alive TARGET_CACHE) exitWith {deleteVehicle _this};
					deleteVehicle _this;
					mission_hint = "We have gained new intel on the cache's possible location. Check your map."; publicVariable "mission_hint"; player hint mission_hint;
					objective_intel = objective_intel + 150;
					_markername = format["objective_int_%1",objective_intel];
					_markeraccuracy = 50 max (1500 - objective_intel);
					_markerpos = [objective_location,random 360,random _markeraccuracy,false,2] call mps_new_position;
					_marker = createMarker [_markername,_markerpos];
					_marker setMarkerType "hd_unknown";
					_marker setMarkerSize [0.75,0.75];
					_marker setMarkerText format["%1m",_markeraccuracy];
					objective_marker = objective_marker + [_markername]; publicVariable "objective_marker";
				};
			}];
		};
	};

/*--------------------CREATE ENEMY NEARBY LOCATION------------------------*/
        _troops = [];
	{
		_loc = position _x;
		_grp = [_loc,"INF",(8 + random 5),50,"patrol"] call CREATE_OPFOR_SQUAD;
		patrol_task_units = patrol_task_units + (units _grp);
		if(random 1 > 0.6) then {
			_car_type = (mps_opfor_car+mps_opfor_apc+mps_opfor_aa+mps_opfor_armor) call mps_getRandomElement;
			_vehgrp = [_car_type,(SIDE_B select 0),_loc,100] call mps_spawn_vehicle;
      patrol_task_vehs set [count patrol_task_vehs, vehicle (leader _vehgrp)];
			[_vehgrp,_loc,"patrol"] spawn mps_patrol_init;
			patrol_task_units = patrol_task_units + (units _vehgrp);
		};
		sleep 0.125;
	} forEach (nearestLocations [_position,["Name","NameLocal","NameVillage","NameCity","NameCityCapital"],250]);

	//if( playersNumber (SIDE_A select 0) > (4 + random 4) ) then { [_position] spawn CREATE_OPFOR_TOWER; };
	//if( playersNumber (SIDE_A select 0) > (6 + random 4) ) then { [_position] spawn CREATE_OPFOR_SNIPERS; };
                
	//{_x spawn objective_intel_KILLED;} foreach _troops;


/*--------------------CREATE ENEMY AT LOCATION------------------------*/

	for "_i" from 1 to 3 do {
		_stance = "standby";
		_grp = [_position,"INF",4,50,_stance ] call CREATE_OPFOR_SQUAD;
		patrol_task_units = patrol_task_units + (units _grp);
	};
        
        for "_i" from 1 to 5 do {
		_stance = "hide";
		_grp = [_position,"INF",4,70,_stance ] call CREATE_OPFOR_SQUAD;
		patrol_task_units = patrol_task_units + (units _grp);
	};

        if (random 1 > 0.3) then {[_position] spawn CREATE_OPFOR_TOWER;};
        if (random 1 > 0.8) then {[_position] spawn CREATE_OPFOR_SNIPERS;};
        
        for "_i" from 1 to (round(random 8)) do { [_position] call CREATE_OPFOR_STATIC; };


/*--------------------CREATE INTEL MARKERS------------------------*/

	[] spawn {
		While{alive TARGET_CACHE} do {n
			{
				_xmarkerposition = getMarkerPos _x;
				_xmarkercolor = getMarkerColor _x;
				_xmarkerType = getMarkerType _x;
				_xmarkertext = markerText _x;
				objective_marker = objective_marker - [_x];
				deleteMarker _x;
				_xmarker = createMarker [format["INTEL_%1",round (random 99999)],_xmarkerposition];
				_xmarker setMarkerType _xmarkerType;
				_xmarker setMarkerSize [0.75,0.75];
				_xmarker setMarkerColor _xmarkercolor;
				_xmarker setMarkerText _xmarkertext;
				objective_marker = objective_marker + [_xmarker];
			} forEach objective_marker;
			sleep 30;
		};
	};

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = [TARGET_CACHE]; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/
missionload = false;
	[format["TASK%1",_taskid],
		"Search and Destroy Weapons Cache",
		format["Enemy have taken delivery of a large weapons cache and stored it in a town somewhere in %1. Locate and Destroy the weapons cache using C4.<br/><br/>Search for heavily defended positions to locate the target.<br/>Hostile troops patrolling nearby might have intel about the cache, so keep an eye out.",worldname],
		true,
		[],
		"created"
	] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/
hz_reward = 1;
	while { damage TARGET_CACHE < 1 && hz_reward > 0 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)} do {
            
            sleep 15;
            hz_reward = ((Hz_econ_perSquadReward * _b) + _otherReward + Hz_econ_aux_rewards);
            _deathPenalty = (mps_mission_deathlimit - mps_mission_deathcount) * Hz_penalty_multiplier_per_death;
            hz_reward = (hz_reward - _deathPenalty)*_rewardmultiplier;
        };

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/
missionload = true;
	if( damage TARGET_CACHE >= 1 && hz_reward > 0 && (((count playableunits) + ({isplayer _x} count alldead)) > 1)) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;                
        
        if(hz_reward >= 1000000) then {hz_display_reward = format ["%1 million",(hz_reward / 1000000)];} else {hz_display_reward = hz_reward;};
        publicvariable "hz_display_reward";
        [-1, {hint format["You've earned $%1 for completing the task!", hz_display_reward];}] call CBA_fnc_globalExecute;
        Hz_funds = Hz_funds + hz_reward;
        publicvariable "Hz_funds";
                
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

	{deleteMarker _x} forEach objective_marker;

/*	[_troops,_position] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
		{ _x setDamage 1}forEach (_this select 0);
		deleteVehicle TARGET_CACHE;
	};*/

 /*--------------------CLEAN UP (NEW VERSION)---------------------------------*/       
        
	[patrol_task_units,_position,patrol_task_vehs] spawn {
            
                _units = _this select 0;
                _vehs = _this select 2;
                _target = TARGET_CACHE;
                
                while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 3600 };
		{deletevehicle _x}forEach _units;
                {deletevehicle _x}forEach _vehs;
                deleteVehicle _target;
	};      
        

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};


