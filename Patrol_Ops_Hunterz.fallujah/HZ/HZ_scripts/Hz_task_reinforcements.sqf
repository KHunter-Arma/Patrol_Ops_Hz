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
       
_INS = true;
};


for "_i" from 1 to _count do {

waituntil { missionload = true; sleep 20; (((count allunits) < Hz_max_allunits) || stopreinforcements)};

//has task ended?
if (stopreinforcements) exitwith {};

//determine type
_vehgrp = grpNull;
_veh = objNull;
_para = false;

_spawnpos = [_targetpos,_MinimumSpawnRange] call Hz_func_findspawnpos;

//the BIS function doesn't make sure vehicles don't spawn on top of each other...
_randspawnpos = [((_spawnpos select 0)+(random 100)),((_spawnpos select 1)-(random 100))];

switch (_type) do {

    case "TRUCK" : {

        _vehtype = "";
        if(_INS) then {_vehtype = mps_opfor_ins_truck call BIS_fnc_selectRandom;} else {_vehtype = mps_opfor_truck call BIS_fnc_selectRandom;};
        _vehgrp = creategroup east;
        _veh = ([_randspawnpos, random 360, _vehtype, _vehgrp] call BIS_fnc_spawnVehicle) select 0;
        _veh setvehiclelock "LOCKED";
        patrol_task_vehs = patrol_task_vehs + [_veh];
        
        sleep 1;
        
        _vehgrp setvariable ["Hz_supporting",true];
        
        if(!_INS) then {[_veh,mps_opfor_inf] call Hz_func_fill_up_vehicle;} else {[_veh,mps_opfor_ins] call Hz_func_fill_up_vehicle;};
        
        _veh setvariable ["targetpos",_targetpos];
        
        /*_veh addeventhandler ["Hit",{
            
         _this spawn {   
                
             private ["_veh","_driver","_grp","_targetpos"];
             
          _veh = _this select 0;
        _driver = driver _veh;
        _grp = group _driver;
        
         if (_veh == (_this select 1)) exitwith {if(!canmove _veh) then {waituntil {{alive _x} count crew _veh < 1}; _grp move (_veh getvariable "targetpos");};};
         
        _targetpos = _veh getvariable "targetpos";
        
        dostop _veh;
        _driver stop true;
        _driver disableAI "move";
        _grp setBehaviour "COMBAT";
        
        waituntil {(speed _veh) < 15};
        (units _grp) allowgetin false;
        (units _grp) orderGetIn false;
        commandgetout (units _grp);
        {unassignvehicle _x; _x action ["Eject", _veh];}foreach crew _veh;
                
        _driver stop false;
        _driver enableAI "move";
        sleep 1;
        _grp move (_veh getvariable "targetpos");
        
        
        
        };
                           
        }];*/

    };
    case "APC"  : {
    
        _vehtype = mps_opfor_apc call BIS_fnc_selectRandom;
        _vehgrp = creategroup east;
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

//support?
if(_support) then {
    
    _Vehsupport = [];
    if(!_INS) then {_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance] call Hz_func_opforVehicleSupport;} else {_Vehsupport = [_CASchance,_TankChance,_IFVchance,_AAchance,_CarChance,"INS"] call Hz_func_opforVehicleSupport;};
    _vehicletypes = _Vehsupport select 0;
    _otherReward = _Vehsupport select 1;
    
    if((count _vehicletypes) > 0) then { 

    _car_type = _vehicletypes call mps_getRandomElement;
    _tempgrp = grpNull;
    if(!_INS) then {_tempgrp = [_car_type,(SIDE_B select 0),_spawnpos,100] call mps_spawn_vehicle;} else {
    _tempgrp = [_car_type,(SIDE_C select 0),_spawnpos,100] call mps_spawn_vehicle;
    
    };    
    
    _dude = (units _tempgrp) select 0;
    _supportveh = vehicle _dude;
    patrol_task_vehs = patrol_task_vehs + [_supportveh];
    
    (units _tempgrp) joinSilent _vehgrp;
    sleep 1;
    if(!isnil "zeu_Groups") then {if(!(_vehgrp in zeu_Groups)) then {zeu_Groups set [count zeu_Groups, _vehgrp];};};
    deleteGroup _tempgrp;

    };
        
    Hz_econ_aux_rewards = Hz_econ_aux_rewards + _otherReward;
            
};

//set behaviour
if(!_para) then {                

(_vehgrp addWaypoint [_targetpos,30]) setWaypointType "SAD";

_vehgrp setbehaviour "CARELESS"; 

[_veh,_targetpos]spawn {
    
        
private ["_driver","_passengerarr","_veh","_targetpos","_grp"];
_veh = _this select 0;
        _targetpos = _this select 1;
        
        _driver = driver _veh;
        _grp = group _driver;
        
        waituntil {sleep 5; (_driver distance _targetpos) < 150 || !alive _driver};
        
        if (!(_veh iskindof "Tank")) then {
            
            dostop _driver;
            
            (group _driver) setBehaviour "COMBAT";
            (crew _veh) allowgetin false;
            (crew _veh) orderGetIn false;
              commandgetout (crew _veh) ;
              
            {unassignvehicle _x;}foreach crew _veh;
            
                } else {
                                 
         dostop _veh;
        _driver stop true;
        _driver disableAI "move";
        _grp setBehaviour "COMBAT";
        
        _passengerarr = [];
        {if((_x != _driver) && (_x != (commander _veh)) && (_x != (gunner _veh))) then {_passengerarr = _passengerarr + [_x];};}foreach crew _veh;
        
        
            _passengerarr allowgetin false;
            _passengerarr orderGetIn false;
          commandgetout _passengerarr;
        
        {unassignvehicle _x;}foreach _passengerarr;
        
        {waituntil {sleep 2; (vehicle _x) == _x || !alive _x}; }foreach _passengerarr;
        
        _driver stop false;
        _driver enableAI "move";      
        
                                };
                                
          _grp move _targetpos;
          
                };

} else {};

//add reinforcements to cleanup array (vehicles already added)
patrol_task_units = patrol_task_units + (units _vehgrp);

//sleep before sending next
sleep 60;

};