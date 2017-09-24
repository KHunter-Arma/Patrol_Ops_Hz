Hz_initdone = false;
Hz_roles_initdone = false;
#include "Hz_config.sqf"

if(!isDedicated && !isMultiplayer) then {hz_debug = true; hintsilent "DEBUG mode initialised!";} else {hz_debug = false;};

if(isnil "hz_debug_air") then {hz_debug_air = false;};
if(isnil "hz_debug_cas") then {hz_debug_cas = false;};
if(isnil "hz_debug_patrols") then {hz_debug_patrols = false;};
if(isnil "civ_debug") then {civ_debug = false;};

//Ambient patrols respawn controller [only used by the server at the moment]
if(isnil "missionload") then {missionload = true;};
if(isnil "jointops") then {jointops = false;};

//init Weather
if(isnil "nukeweather") then {nukeweather = false;};
if(isnil "Hz_overrideweather") then {Hz_overrideweather = false;};
if(isnil "weather_change") then {weather_change = false;};
Hz_sys_weather_fnc_weatherSync = compile preprocessfilelinenumbers "Hz\Hz_sys_weather\Hz_sys_weather_fnc_weatherSync.sqf";
Hz_weather_fnc_AI_VD_fog_adjuster = compile preprocessfilelinenumbers "Hz\Hz_sys_weather\Hz_weather_fnc_AI_VD_fog_adjuster.sqf";

if (isServer) then {

Hz_weather_func_dynamicWeather = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_weather_func_dynamicWeather.sqf";

weather_fog = Hz_weather_avg_fog;
weather_rain = Hz_weather_avg_rain;
weather = Hz_weather_avg_overcast;
_sign1 = 1;
if ((random 1) < 0.5) then {_sign1 = -1;};       
_sign2 = 1;
if ((random 1) < 0.5) then {_sign2 = -1;}; 
weather_wind = [(14*Hz_weather_avg_wind*_sign1*(1 - (random 0.1))),(14*Hz_weather_avg_wind*_sign2*(1 - (random 0.1))),true]; 


call Hz_weather_func_dynamicWeather;

};

[] spawn {
  waituntil {sleep 1; !isnil "ace_wind_fnc_getWind"};
  waituntil {sleep 1; !isnil "ace_sys_wind_deflection_fnc_wind"};
  waituntil {sleep 1; !isnil "weather_wind"};
  
  sleep 1;
  //make use of alread existing ACE per-frame EH to output custom wind
  ace_wind_fnc_getWind = {[weather_wind select 0,weather_wind select 1, 0]};
  ace_sys_wind_deflection_fnc_wind = ace_wind_fnc_getWind;
  [] execVM "Hz\Hz_sys_weather\Hz_sys_weather_main.sqf";
};

// Init dialogs
call compile preprocessfilelinenumbers "HZ\dialogs\fort\HZ_fort_init.sqf";
call compile preprocessfilelinenumbers "HZ\dialogs\admin\HZ_admin_init.sqf";

Hz_initdone = true;

//Other initialisations
Hz_func_isSupervisor = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_isSupervisor.sqf";
Hz_func_check_vehicle = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_check_vehicle.sqf";
Hz_func_find_nearest_ammo_crate = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_find_nearest_ammo_crate.sqf";
Hz_sleep_mutex = false;

//Client init
if(!isDedicated)  then {
  
  [] spawn {   
    
    waituntil {sleep 0.1; !isnull player};
    
    if(Hz_check_ACRE_working && !hz_debug) then {
      []spawn {
        waituntil {sleep 0.1; !isnil "acre_sys_io_fnc_startServer"};
        sleep 0.10;
        acre_sys_io_fnc_startServer = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACRE\acre_sys_io_fnc_startServer.sqf";
        Hz_func_acre_OK = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACRE\Hz_func_acre_OK.sqf";
        Hz_func_check_ACRE = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACRE\Hz_func_check_acre.sqf";
        [] call Hz_func_check_ACRE;
      };};

    if (Hz_disallow_sthud && isClass(configFile >> "CfgPatches" >> "ST_STHud")) then {
      [] spawn {
        waituntil {sleep 0.1; !isnil "introseqdone"};     
        waituntil {sleep 0.1; introseqdone}; 
        hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! Disallowed addon detected: @sthud. Remove this addon to play on this server.</t>"];
        sleep 9;
        hintc "You were removed from the game for running a disallowed addon: @st_hud";
        endMission "LOSER"; 
      };
    };  
    
    sleep 8;
    
    if (Hz_enable_weps_restriction) then {
            
      if(((getplayeruid player) in Hz_wep_restrictions_jointOp) && (player iskindof "USMC_Soldier_Base")) exitwith {
        
        Hz_playertype = "jointOp";
        if(isMultiplayer && Hz_slotrestrictions) then{[] execvm "Hz\Hz_scripts\Hz_restrict_slots.sqf";}; 
        
      };
      
      /* sleep 0.1;
    ace_sys_repair_fnc_menuDef_support = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_repair\ace_sys_repair_fnc_menuDef_support.sqf"; */  
      
      _uid = getPlayerUID player;
      
      if(_uid in Hz_wep_restriction_supervisors) then {
        
        Hz_playertype = "supervisor";
        
      } else {
              
        if(_uid in Hz_wep_restriction_whitelist) then {
          
          Hz_playertype = "whitelist";
          
        } else {
          
          Hz_playertype = "public";
          
        };
        
      };
      
      if(hz_debug) then {Hz_playertype = "supervisor";};
      
    };
    
    if(isMultiplayer && Hz_slotrestrictions) then{[] execvm "Hz\Hz_scripts\Hz_restrict_slots.sqf";}; 
    
  };

};

// Server init
if (isServer) then {

  nukeweatherCounter = 0;
  nukeWeatherCountdown_Mutex = false;
  nukeWeatherCountdown = {
  
    //already running but called again -- so extend duration
   if (nukeWeatherCountdown_Mutex) exitWith {nukeweatherCounter = nukeweatherCounter + Hz_falloutDuration};
   nukeWeatherCountdown_Mutex = true;
   if (nukeweatherCounter == 0) then {nukeweatherCounter = Hz_falloutDuration;};
   
   while {true} do {
   
   sleep 60;
   
   nukeweatherCounter = nukeweatherCounter - 60;
   
   if (nukeweatherCounter < 0) exitWith {
   
   nukeweatherCounter = 0;    
   nukeweather = false; 
   nukeWeatherCountdown_Mutex = false;
   waitUntil {sleep 60; ((count playableUnits) + ({isplayer _x} count alldead)) < 1 };
   publicvariable "nukeweather";
   
   };
   
   };   
  
  };
  
  call compile preprocessfilelinenumbers "hunterz_civ_init.sqf";   
  
  HZ_spawncivs                    = compile preprocessFileLineNumbers "hunterz_civ_main.sqf";
  HZ_updatecivs                   = compile preprocessFileLineNumbers "hunterz_civ_update.sqf";
  Hz_func_findSpawnPos            = compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_func_findSpawnPos.sqf";
  Hz_task_reinforcements = compile preprocessfilelinenumbers "HZ\Hz_scripts\Hz_task_reinforcements.sqf";
  Hz_sinisterCiv = compile preprocessfilelinenumbers "HZ\Hz_scripts\Hz_sinisterCiv.sqf";
  Hz_func_bombingrun = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_bombingrun.sqf";
  Hz_func_callinBomber = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_callinBomber.sqf";
  Hz_func_opforVehicleSupport = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_opforVehicleSupport.sqf";
  Hz_func_fill_up_vehicle = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_fill_up_vehicle.sqf";
  Hz_func_create_roadside_IED = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_create_roadside_IED.sqf";
  Hz_func_isUrbanArea = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_isUrbanArea.sqf";
  Hz_func_setRealTime = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_setRealTime.sqf";
  Hz_func_spawnOpforArtilleryBase = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_spawnOpforArtilleryBase.sqf";    
  Hz_func_initOpforComposition = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_initOpforComposition.sqf";    
  
  if(!isMultiplayer) then {{if(!isplayer _x) then {deletevehicle _x};}foreach switchableunits;};

};

[]spawn compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_repair\Hz_initLogistics.sqf";  