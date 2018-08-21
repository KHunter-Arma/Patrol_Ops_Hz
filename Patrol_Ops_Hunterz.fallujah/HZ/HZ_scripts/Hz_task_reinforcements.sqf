private ["_MinimumSpawnRange","_randspawnpos","_support","_CASchance","_TankChance","_IFVchance","_AAchance","_CarChance","_vehtype","_vehgrp","_veh","_para","_car_type","_tempgrp","_dude","_supportveh","_Vehsupport","_vehicletypes","_otherReward","_spawnpos","_targetpos","_count","_type","_taskid","_INS"];

_MinimumSpawnRange = _this select 0;
_targetpos = _this select 1;
_count = _this select 2;
_type = toupper (_this select 3);

_INS = false;

_support = false;
_CarChance = 0;
_AAchance = 0;
_TankChance = 0;
_IFVchance = 0;
_CASchance = 0;

if((count _this) > 4) then {
  
  _support = true;
  _CASchance = _this select 4;
  _TankChance = _this select 5;
  _IFVchance = _this select 6;
  _AAchance = _this select 7;
  _CarChance = _this select 8;      

};

if((count _this) > 9) then {
  
	if ((_this select 9) == "INS") then {
	
		_INS = true;
	
	};	
  
};


for "_i" from 1 to _count do {

  waituntil {sleep 20; (((count allunits) < Hz_max_allunits) || stopreinforcements)};

  //has task ended?
  if (stopreinforcements) exitwith {};

  _veh = objNull;
  _para = false;
  _otherReward = 0;
  _vehgrp = grpNull;

  _spawnpos = [_targetpos,_MinimumSpawnRange] call Hz_func_findspawnpos;

  //the BIS function doesn't make sure vehicles don't spawn on top of each other...
  _randspawnpos = [((_spawnpos select 0)+(random 100)),((_spawnpos select 1)-(random 100))];
  
  if (!_INS) then {
  
    _vehgrp = [ _randspawnpos,"INF",random 24,300] call CREATE_OPFOR_SQUAD;
  
  } else {
  
    _vehgrp = [ _randspawnpos,"INS",random 24,300] call CREATE_OPFOR_SQUAD;
  
  };

  //support?
  if(_support) then {
    
    _Vehsupport = [];
    if(!_INS) then {_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_func_opforVehicleSupport;} else {_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] call Hz_func_opforVehicleSupport;};
    _vehicletypes = _Vehsupport select 0;
    _otherReward = _otherReward + (_Vehsupport select 1);
    
    if((count _vehicletypes) > 0) then { 

      _car_type = _vehicletypes call mps_getRandomElement;
      _tempgrp = grpNull;
      if(!_INS) then {
      
      _tempgrp = [_car_type,(SIDE_B select 0),_spawnpos,100] call mps_spawn_vehicle;
      
      } else {
      
        _tempgrp = [_car_type,(SIDE_C select 0),_spawnpos,100] call mps_spawn_vehicle;
        
      };    
      
      _dude = (units _tempgrp) select 0;
      _supportveh = vehicle _dude;
      patrol_task_vehs set [count patrol_task_vehs, _supportveh];
      
      (units _tempgrp) joinSilent _vehgrp;
      sleep 1;
      if(!isnil "zeu_Groups") then {if(!(_vehgrp in zeu_Groups)) then {zeu_Groups set [count zeu_Groups, _vehgrp];};};
      deleteGroup _tempgrp;

    };
    
  };
  
  switch (_type) do {

  case "TRUCK" : {

      _truckTypes = mps_opfor_truck;
      _carTypes = mps_opfor_ncov;

      if(_INS) then {
      
      _truckTypes = mps_opfor_ins_truck;
      _carTypes = mps_opfor_ins_ncov;
      
      };     
      
      if(!isnil "Hz_AI_moveAndCapture") then {
			
			_spawnedVehs = [_vehgrp, _targetpos,_truckTypes,_carTypes] call Hz_AI_moveAndCapture;  

			patrol_task_vehs = patrol_task_vehs + _spawnedVehs;					 
			
      } else {
			
			_wp = _vehgrp addWaypoint [_targetpos,50];
			_wp setWaypointType "SAD";
			
      };
                  
      _otherReward = _otherReward + Hz_econ_perSquadReward;

    };
  case "APC"  : {
      
      _vehtype = mps_opfor_apc call mps_getrandomelement;
      _vehgrp = creategroup (SIDE_B select 0);
      _veh = ([_randspawnpos, random 360, _vehtype, _vehgrp] call BIS_fnc_spawnVehicle) select 0;
      _veh setvehiclelock "LOCKED";
      
      _vehgrp setvariable ["Hz_supporting",true];
      
      [_veh,mps_opfor_inf] call Hz_func_fill_up_vehicle; 
      
    };
  case "PARA"  : {
      
      _para = true;        
      
    };
  case "HELI"   : {
      
      
      
    };
    
  case "CAR"   : {
      
      
      
    };
  case "FOOT"   : {
      
      
      
    };
    
    default {};
    
  };

  //add reinforcements to cleanup array (vehicles already added)
  patrol_task_units = patrol_task_units + (units _vehgrp);
  
  Hz_econ_aux_rewards = Hz_econ_aux_rewards + _otherReward;

  //sleep before sending next
  sleep 60;

};