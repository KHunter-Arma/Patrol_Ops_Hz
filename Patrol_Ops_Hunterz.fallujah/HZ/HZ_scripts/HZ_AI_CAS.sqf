

//////////////////////////////////////////////////////////////
/*
                    DEPRECATED            
*/
///////////////////////////////////////////////////////////////



















































///////////////////////////////////////
/*
                    PARAMS            
*/
///////////////////////////////////////
            
            
 /*          
            
//useful for simulating how advanced enemy sensors or optics are [unit: seconds]         

private ["_nearunits","_targets","_gunner","_grp","_bombs","_pilot","_TargetDetectionRate","_chopper","_range"];
_TargetDetectionRate = 30;
_enemyside = west;
    
//////////////////////////////////////
              

_chopper = _this select 0;
_range = _this select 1;

if((side _chopper) == west) then {_enemyside = east;};


if(_chopper iskindof "Helicopter") then { 
// CAS is heli

_gunner = gunner _chopper;
_grp = group _chopper;

_chopper spawn {
  
private ["_target","_jet","_pilot","_gunner"];
_jet = _this;
  _pilot = driver _jet;
  _gunner = gunner _jet;
  while {(((getposatl _jet) select 2) > 20)} do {
      waituntil {sleep 1; (assignedtarget _pilot iskindof "LandVehicle") || (((getposatl _jet) select 2) < 20)};
      waituntil {sleep 0.1; (_jet aimedAtTarget [(assignedtarget _pilot)] > 0) || (((getposatl _jet) select 2) < 20)};
      _target = assignedtarget _pilot;
      _pilot fireAtTarget [_target];
      sleep 0.5;
      _pilot fireAtTarget [_target];
      sleep 0.5;
      _pilot fireAtTarget [_target];
      sleep 5;
      };
      };

while {(((getposatl _chopper) select 2) > 20)} do {
        sleep _TargetDetectionRate; 
        _nearunits = nearestObjects [_chopper, ["Car","Tank","CAManBase","Motorcycle","StaticWeapon"], _range];
        _targets = [];
        {if (((side _x) == _enemyside) && ((_x distance (markerpos "respawn_west")) > 1000)) then {_targets set [count _targets, _x];};}foreach _nearunits;


           if (count _targets > 0) then {
                _grp setSpeedMode "LIMITED";
                    {_gunner reveal [_x, 4]; _x setvariable ["known_by_CAS",true]; if(!(_x iskindof "CAManBase")) then {{_x setvariable ["known_by_CAS",true];}foreach crew _x;};}foreach _targets;

            } else {
                _grp setSpeedMode "FULL";
                _chopper setfuel 1; _chopper setVehicleAmmo 1;
                    };


};

} else {
// CAS is jet   

_pilot = driver _chopper;
_grp = group _chopper;


while {(((getposatl _chopper) select 2) > 20)} do {
        sleep _TargetDetectionRate; 
         _nearunits = nearestObjects [_chopper, ["Car","Tank"], _range];
        _targets = [];
        {if (((side _x) == _enemyside) && ((_x distance (markerpos "respawn_west")) > 1000) && (isEngineOn _x)) then {_targets set [count _targets, _x];};}foreach _nearunits;

        if (count _targets > 0) then {

                    { _x setvariable ["known_by_CAS",true]; if(!(_x iskindof "CAManBase")) then {{_x setvariable ["known_by_CAS",true];}foreach crew _x;};}foreach _targets;

        } else {
                    _grp setSpeedMode "FULL";
                    _chopper setfuel 1; _chopper setVehicleAmmo 1;
                    };
                    
};



};

{_x setvariable ["known_by_CAS",false];} foreach allunits;



*/ 