// Written by EightySix
// Inspired by Xeno

private ["_position","_tower","_type","_grp"];

_position = [(_this select 0),150,1,2] call mps_getFlatArea;

_type = ["Land_Vysilac_FM","Land_telek1"] call mps_getRandomElement;
_tower = _type createVehicle _position;

_grp = [_position,"INF",(2 + random 3),50] call CREATE_OPFOR_SQUAD;
(_grp addWaypoint [_position,20]) setWaypointType "HOLD";
_grp setFormation "DIAMOND";

[_position,_tower,_grp] spawn {
	private ["_pos","_tower","_spawnpos","_regrp","_timer","_observer"];
	_pos = _this select 0;
	_tower = _this select 1;
	_observer = leader (_this select 2);
	_spawnpos = format["respawn_%1",(SIDE_B select 0)];

	while{ alive _tower && alive _observer} do {
		if( !(toupper (behaviour _observer) IN ["CARELESS","SAFE"]) ) then {
		
			if(count allunits < Hz_max_allunits) then {
				_regrp = [_spawnpos,"INF",(8 + random 4),50] call CREATE_OPFOR_SQUAD;
				[_regrp,_spawnpos,_pos,true] spawn CREATE_OPFOR_PARADROP;
			};
			//mission_globalchat = "An Enemy Observer has requested reinforcements"; publicVariable "mission_commandchat";
			//player hint mission_globalchat;

			_timer = 45;
			while{ alive _tower && alive _observer && _timer > 0 } do { uisleep 10; _timer = _timer - 1;};
		};
		sleep 10;
	};

	if(!alive _observer) then {
		//mission_hint = "Enemy Radio Operator Killed - Now they can't call in further Support"; publicVariable "mission_hint";
		//player hint mission_globalchat;
	};
};

//allow task loading to complete before hint
sleep 60;

mission_hint = format["We have intel on an enemy high ranking official in the target area. He has his RTO positioned on a watch tower as an observer. If the enemy is alerted, he may call in reinforcements!",mapGridPosition _position]; publicVariable "mission_hint";
//player hint mission_commandchat;

sleep (random 30);
if(isnil "Hz_econ_aux_rewards") then {Hz_econ_aux_rewards = 0;};
Hz_econ_aux_rewards = Hz_econ_aux_rewards + Hz_econ_Tower_reward;

While{ damage _tower < 1 && mps_mission_status == 1} do { sleep 10; };
/*
if(damage _tower >= 1) then {
	mission_hint = "Enemy Tower Destroyed - Now they can't call in further Support"; publicVariable "mission_hint";
	//player hint mission_globalchat;
};
*/
sleep 10;
deleteVehicle _tower;