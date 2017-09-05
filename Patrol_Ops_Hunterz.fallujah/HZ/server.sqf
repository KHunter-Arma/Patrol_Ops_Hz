//Server DVD
[] spawn {
  
  if(!isDedicated) exitwith {};        
  
  while {true} do {
    
    uisleep 5;

    if(diag_fps < Hz_min_desired_server_FPS) then {if(viewdistance > (Hz_min_desired_server_VD + 200)) then {setviewdistance (viewdistance - 200);}else {setviewdistance Hz_min_desired_server_VD;};} else {
      if(diag_fps > Hz_max_desired_server_FPS) then {if(viewdistance < (Hz_max_desired_server_VD - 200)) then {setviewdistance (viewdistance + 200);}else {setviewdistance Hz_max_desired_server_VD;};};};

  };
  
}; 


_timescaler1 = 0;
_timescaler2 = 0;
_timescaler3 = 0;
if(isnil "Hz_func_AI_isUncon") then {Hz_func_AI_isUncon = {false};};

while {true} do
{
  
  //3.8 minute loop    
  uisleep 233;
  _timescaler1 = _timescaler1 + 1;
  _timescaler2 = _timescaler2 + 1;
  _timescaler3 = _timescaler3 + 1;
  
  //track unconscious units and kill them if they're lying at the same place for more than 10 minutes
  {
    if((local _x) && (_x call Hz_func_AI_isUncon) && (alive _x)) then {
      
      if((count (_x getvariable ["Hz_AI_unconTracker",[]])) < 1) then {_x setvariable ["Hz_AI_unconTracker",[time,getpos _x]];};
      
      _last = _x getvariable "Hz_AI_unconTracker";
      
      _samepos = (format (_last select 1)) == (format (getpos _x));
      
      if(_samepos) then {
        
        if(((time - (_last select 0)) > 600)) then {
          
          _x setdamage 1;
          
        };
        
      } else {
        
        _x setvariable ["Hz_AI_unconTracker",[time,getpos _x]];   
        
      };                           
      
    };
    
  }foreach allunits;
  
  if((count alldead) > Hz_max_deadunits) then {

    //dead body cleanup    
    {
      if(_x iskindof "CAManBase") then {if(!(_x getvariable ["NoDelete",false]) && ((_x distance (markerpos "respawn_west")) > 300)) then {deleteVehicle _x;};};

    }foreach AllDead;

  };
  
  //reset position of dudes with no weapons at base (they tend to drift over time for some reason)
  {_x setposatl (_x getvariable "pos");}foreach position_correction;  
  
  // SAM setVehicleAmmo 1;
  
  
  //50 minute loop
  if(_timescaler1 > 12) then {
    _timescaler1 = 0;
    
    _temp = +tempbikes;
    {if(!isnull _x) then {if((count (crew _x)) < 1) then {_temp = _temp - [_x]; deletevehicle _x; };};}foreach tempbikes;
    tempbikes = +_temp;
    publicvariable "tempbikes";
    {deletegroup _x;}foreach allgroups;
    
  };
  
  
  //3 hour loop
  if(_timescaler3 > 45) then {
    
    //dead vehicle cleanup
    {
      if ((_x iskindof "LandVehicle") || (_x iskindof "Air") || (_x iskindof "Boat")) then {if(!(_x getvariable ["NoDelete",false])) then {
          
          // does not work reliably										
          _flameEffects = _x getvariable ["ace_burnObj",[]];
          {deletevehicle _x} foreach _flameEffects;
          //alternative -- does not get rid of sound!!!!!!!!!!
          {
            deletevehicle _x;
          }foreach nearestobjects [_x,["ace_flameout_1"],30];
          //*sigh* delete sound source....
          {
            deletevehicle _x;
          }foreach nearestobjects [_x,[],2];
          deleteVehicle _x;	
        };};
      
    }foreach AllDead;      
    
    _timescaler3 = 0;

    call Hz_weather_func_dynamicWeather;
    call Hz_func_setrealtime;
    
  };
  
  //6 hour loop
  if(_timescaler2 > 90) then {
    
    _timescaler2 = 0; 
    
  };

}; 