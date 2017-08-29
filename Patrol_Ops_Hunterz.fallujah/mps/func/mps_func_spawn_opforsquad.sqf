// Written by BON_IF
// Adpated by EightySix
// Modified by K.Hunter
//	requires Position
//	[_position,"INF",5,50] spawn CREATE_OPFOR_SQUAD;
//

private ["_side","_strength","_unit","_allunits","_pos","_radius","_count","_spawnpos","_nocleanup","_type","_patrol","_movetype","_x","_y","_Grp","_max","_skill","_upsmarker","_markerrange"];

if(count _this < 1) exitWith{};

_nocleanup = false;
if(count _this > 5) then{
  if((_this select 5) == "nocleanup") then {_nocleanup = true;};   
};

_side = (SIDE_B select 0);
_pos = (_this select 0) call mps_get_position;

_type = "INF";
if(count _this > 1) then{
  _type = _this select 1;        
};

_strength = 2 + (round random 3);
if(count _this > 2) then{ _strength = _this select 2; };

_radius = 20;
if(count _this > 3) then{ _radius = _this select 3; };

_patrol = false;
_movetype = "patrol";
if(count _this > 4) then{ _patrol = true; _movetype = switch (_this select 4) do { case "standby" : {"standby"}; case "hide" : {"hide"}; default {"patrol"}; }; };

_x = _pos select 0;
_y = _pos select 1;

_Grp = createGroup _side;

//temporary -- to make sure mod doesn't take over prematurely
_Grp setvariable ["Hz_attacking",true];

_spawnpos = [0,0];
_count=0;
While{(surfaceIsWater _spawnpos || count (_spawnpos - [0]) == 0) && _count < 100} do {
  _spawnpos = [_x + _radius - random (_radius*2), _y + _radius - random (_radius*2)];
  _count = _count + 1;
};
if(_count == 100) exitWith{_Grp};
_spawnpos set [2,0];

switch _type do{
case "INF": {_allunits = mps_opfor_inf};
case "INS": {_allunits = mps_opfor_ins};
case "TARGET" : {_allunits = mps_opfor_leader};
  default {_allunits = mps_opfor_inf};
};

_max = (count _allunits) - 1;
_skill = 1 + log(mps_mission_factor/4);

for "_j" from 1 to _strength do {
  
  _unit = _Grp createUnit [_allunits select (round random _max),_spawnpos,[],20,"NONE"];
  
};

_upsmarker = Format ["upstaskmarker_%1", markerindex];
markerindex = markerindex + 1;

createMarkerLocal [_upsmarker, _spawnpos];
_upsmarker setMarkerShapeLocal "RECTANGLE";
_markerrange = 150 max (random 700);
_upsmarker setMarkerSizeLocal [_markerrange, _markerrange];


if(!_nocleanup) then {patrol_task_units = patrol_task_units + (units _Grp); patrol_task_markers = patrol_task_markers + [_upsmarker];};


if(_patrol) then {

  if(_movetype == "standby") then {
    
    
    // [_Grp,_spawnpos,_movetype] spawn mps_patrol_init;

    /*

DEFENSIVE BEHAVIOUR HANDLED BY MOD


*/

    _Grp setvariable ["Hz_attacking",false];

  } else {
    
    if(_movetype == "patrol") then {
      
      _Grp setvariable ["Hz_attacking",false];
      _Grp setvariable ["Hz_patrolling",true];

      [_Grp,_upsmarker,"SHOWMARKER"] spawn Hz_AI_UPS_Hz;
      
    }else {
      
      _Grp setvariable ["Hz_attacking",false];
      _Grp setvariable ["Hz_defending",true];
      
      //_movetype == "hide"
      
      //[unit,radius,stationary?,([occupy percentage,maximum],warping?,minimum height)] execVM "Garrison_script.sqf"
      if((_this select 0) call Hz_func_isurbanarea) then {
        
        [leader _Grp,400,true,[100,2],true,2] execVM "Garrison_script.sqf";
        
      } else {
        
        {deletevehicle _x;}foreach units _Grp;
        
      };
      
    };
  };
  
} else {
  
  _Grp setvariable ["Hz_attacking",false];
  
};

_Grp