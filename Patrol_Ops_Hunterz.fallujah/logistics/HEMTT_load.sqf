
if(isDedicated) exitwith {};

private ["_pos","_nearobjects","_obj","_postruck","_truck","_cargo"];

_truck = _this select 0;
if(_truck getvariable ["Loading",false]) exitwith {};
_truck setvariable ["Loading",true,true];
_cargo = _truck getvariable ["Cargo",objNull];

if(speed _truck > 1) exitwith {"Truck is moving!"};

if (isnull _cargo) then {
  //LOAD FUNCTION
  
  _nearobjects = nearestObjects [_truck, ["Land_Misc_Cargo1E_EP1","Misc_Cargo1B_military","RHIB","pook_SOCR_H_M134b","pook_SOCR_H_M134","pook_SOCR_H_M2","pook_SOCR_H_M2b"], 20];
  _obj = _nearobjects select 0;

  if(isnull _obj) exitwith {hint "No object found nearby to load"};

  if (!(_obj iskindof "Ship")) then {

    _pos = getpos _truck;    
    _obj setpos [_pos select 0,_pos select 1,5];
    _obj attachto [_truck,[0,-1.2,3.2]];

  } else {
    //boats?
    {moveout _x;}foreach crew _obj;

    _obj setvehiclelock "LOCKED";
    [-2, {
      _this setvehiclelock "LOCKED";
    },_obj] call CBA_fnc_globalExecute;

    _pos = getpos _truck;    
    _obj setpos [_pos select 0,_pos select 1,5];
    if(typeof _obj == "RHIB" || typeof _obj == "RHIB2Turret") then {_obj attachto [_truck,[0,-2,5.45]];} else {_obj attachto [_truck,[0,-1.7,3]];};

  };

  _truck setvariable ["Cargo",_obj,true];

} else {
  //UNLOAD FUNCTION

  detach _cargo;
  _postruck = getpos _truck;
  _pos = _truck modeltoworld [0,-10,0];
  _cargo setpos _pos;
  _truck setvariable ["Cargo",objNull,true];

  if(_cargo iskindof "Boat") then {
    
    _cargo setvehiclelock "UNLOCKED";
    [-2, {
      _this setvehiclelock "UNLOCKED";
    }, _cargo] call CBA_fnc_globalExecute; 
    
  };

};

_truck setvariable ["Loading",false,true];