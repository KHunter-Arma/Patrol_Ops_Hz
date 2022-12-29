// Written by EightySix
// Inspired by Xeno

private ["_tower", "_position", "_rto", "_newComp", "_newcomp", "_rtoPlaceholder", "_rtoPos", "_rtoGroup", "_type", "_grp"];

_position = [(_this select 0),150,1,2] call mps_getFlatArea;

_tower = objNull;
_rto = objNull;
if(count _this > 1) then {_tower = _this select 1;};

if (isNull _tower) then {

  _newComp = [_position, random 360,(call compile preprocessfilelinenumbers "Compositions\Opfor\Bases\radio_tower.sqf")] call BIS_fnc_ObjectsMapper;

  {if((typeOf _x) == "Land_Vysilac_FM") then {_tower = _x;}; }forEach _newcomp;

  _rtoPlaceholder = objNull;
  {if((typeOf _x) == "Microphone1_ep1") then {_rtoPlaceholder = _x;}; }forEach _newcomp;

  if (!isnull _rtoPlaceholder) then {

    _rtoPos = getposatl _rtoPlaceholder;
    deletevehicle _rtoPlaceholder;

  };

  _rtoGroup = creategroup (SIDE_B select 0);
  _rto = _rtoGroup createunit [(mps_opfor_commander call mps_getrandomelement), _position,[], 25, "NONE"];
  _rto setposatl _rtoPos;
  dostop _rto;

  _rtoGroup setvariable ["Hz_defending",true];
  _rto setvariable ["Hz_noMove",true];
  _rto forcespeed 0;
	
	_rtoGroup deleteGroupWhenEmpty true;

  removeAllWeapons _rto;

  _rto addMagazine "6Rnd_45ACP";
  _rto addMagazine "6Rnd_45ACP";
  _rto addMagazine "6Rnd_45ACP";
  _rto addMagazine "6Rnd_45ACP";
  _rto addMagazine "6Rnd_45ACP";
  _rto addMagazine "6Rnd_45ACP";
  _rto addMagazine "6Rnd_45ACP";
  _rto addMagazine "6Rnd_45ACP";
  _rto addWeapon "revolver_EP1";

  [_tower] spawn mps_object_c4only;

};


/*
_type = ["Land_Vysilac_FM","Land_telek1"] call mps_getRandomElement;
_tower = _type createVehicle _position;
*/

_grp = [_position,"INF",(2 + random 3),50] call CREATE_OPFOR_SQUAD;
(_grp addWaypoint [_position,10]) setWaypointType "HOLD";
_grp setFormation "DIAMOND";

[_position,_tower,_rto] spawn {
  private ["_pos","_tower","_spawnpos","_observer","_paratroopers"];
  _pos = _this select 0;
  _tower = _this select 1;
  _observer = _this select 2;
  _spawnpos = format["respawn_%1",(SIDE_B select 0)];

  while{ alive _tower && alive _observer} do {
    if( !((toupper (behaviour _observer) IN ["CARELESS","SAFE"])))  then {
      
      if(count allunits < Hz_max_allunits) then {
        
				_paragrp = createGroup (SIDE_B select 0);
        _paratroopers = [_paragrp,_spawnpos,_pos,true] call CREATE_OPFOR_PARADROP;
				_paragrp deleteGroupWhenEmpty true;
        patrol_task_units = patrol_task_units + _paratroopers;
        sleep 900;        
        
      };
      //mission_globalchat = "An Enemy Observer has requested reinforcements"; publicVariable "mission_commandchat";
      //player hint mission_globalchat;

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

mission_hint = "We have intel that an enemy high ranking official is overseeing operations in the target area, and he has established an outpost with long range comms equipment. He may use it to call in reinforcements from nearby bases!"; publicVariable "mission_hint";
//player hint mission_commandchat;

sleep (random 30);

While{ damage _tower < 1 && Hz_patrol_task_in_progress} do { sleep 10; };
/*
if(damage _tower >= 1) then {
  mission_hint = "Enemy Tower Destroyed - Now they can't call in further Support"; publicVariable "mission_hint";
  //player hint mission_globalchat;
};
*/
sleep 10;
deleteVehicle _tower;