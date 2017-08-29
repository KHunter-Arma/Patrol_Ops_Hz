Hz_initdone = false;
Hz_roles_initdone = false;
#include "Hz_config.sqf"

if(!isDedicated && !isMultiplayer) then {hz_debug = true; hintsilent "DEBUG mode initialised!";} else {hz_debug = false;};

//need to act quick to override this
if(!isDedicated) then {

  [] spawn {

    waituntil {sleep 0.01; !isnil "ace_sys_aitalk_fnc_vehicleradio"};
    sleep 1;
    ace_sys_aitalk_fnc_vehicleradio = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_aitalk\ace_sys_aitalk_fnc_vehicleradio.sqf";
    
  };

};

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
[] spawn {
  waituntil {sleep 1; !isnil "ace_wind_fnc_getWind"};
  waituntil {sleep 1; !isnil "weather_wind"};
  
  sleep 1;
  //make use of alread existing ACE per-frame EH to output custom wind
  ace_wind_fnc_getWind = {[weather_wind select 0,weather_wind select 1, 0]};
  ace_sys_wind_deflection_fnc_wind = ace_wind_fnc_getWind;
  [] execVM "Hz\Hz_sys_weather\Hz_sys_weather_main.sqf";
};

// Initialise Hunter'z
call compile preprocessfilelinenumbers "HZ\dialogs\veh\HZ_veh_init.sqf";
call compile preprocessfilelinenumbers "HZ\dialogs\fort\HZ_fort_init.sqf";
call compile preprocessfilelinenumbers "HZ\dialogs\wep\HZ_wep_init.sqf";
call compile preprocessfilelinenumbers "HZ\dialogs\admin\HZ_admin_init.sqf";

Hz_initdone = true;

//Other initialisations
Hz_remove_gear = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_remove_gear.sqf";
Hz_func_spitoutweps = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_spitoutweps.sqf";
Hz_remove_medical_gear = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_remove_medical_gear.sqf";
Hz_func_isSupervisor = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_isSupervisor.sqf";
Hz_func_rearrangeACRERadios = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_rearrangeACRERadios.sqf";
Hz_func_check_vehicle = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_check_vehicle.sqf";
Hz_func_find_nearest_ammo_crate = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_find_nearest_ammo_crate.sqf";
Hz_func_setvehicleinit = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_setvehicleinit.sqf";
Hz_sleep_mutex = false;

//overwrite funcs
[]spawn {
  
  waituntil {sleep 0.1; !isnil "ace_sys_wounds_fnc_examansw"};
  sleep 0.1;
  ace_sys_wounds_fnc_examansw = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_wounds\ace_sys_wounds_fnc_examansw.sqf";
  waituntil {sleep 0.1; !isnil "ace_sys_wounds_fnc_examansw2"};
  sleep 0.1;
  ace_sys_wounds_fnc_examansw2 = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_wounds\ace_sys_wounds_fnc_examansw2.sqf";
  waituntil {sleep 0.1; !isnil "ace_sys_wounds_fnc_bodybag"};
  sleep 0.1;
  ace_sys_wounds_fnc_bodybag = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_wounds\ace_sys_wounds_fnc_bodybag.sqf";
  waituntil {sleep 0.1; !isnil "ace_sys_wounds_fnc_examine"};
  sleep 0.1;
  ace_sys_wounds_fnc_examine = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_wounds\ace_sys_wounds_fnc_examine.sqf";

  if(Hz_disable_ACE_sniper_dust) then { 

    waituntil {sleep 0.1; !isnil "ace_sys_destruction_fnc_heavysniper"};
    sleep 0.1;
    ace_sys_destruction_fnc_heavysniper = {};

  };

  if(Hz_disable_ACE_rearm_cargo_weapons) then {

    waituntil {sleep 0.1; !isnil "ace_sys_repair_fnc_fill_transportMagazines"};
    sleep 0.1;
    ace_sys_repair_fnc_fill_transportMagazines = {};

  };
  
  //Correct an ACE script issue
  waituntil {sleep 0.1; !isnil "ace_sys_thermobaric_fnc_fired"};
  sleep 0.1;
  ace_sys_thermobaric_fnc_fired = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_thermobaric\ace_sys_thermobaric_fnc_fired.sqf";

};

//[]spawn {waituntil {sleep 0.1; !isnil "ace_sys_dogtag_fnc_menuDef"};sleep 0.10;ace_sys_dogtag_fnc_menuDef = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_dogtag\ace_sys_dogtag_fnc_menuDef.sqf";};


//Client init
if(!isDedicated)  then {
  
  [] spawn {   
    
    waituntil {sleep 0.1; !isnull player};
    
    []spawn {sleep 30; _future = time + 60; waituntil {sleep 0.1; ((!isnil "ace_sys_aitalk_fnc_GetRadioVehicles") || (time > _future))}; sleep 0.10; ace_sys_aitalk_fnc_GetRadioVehicles = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_aitalk\ace_sys_aitalk_fnc_GetRadioVehicles.sqf";};
    
    if(Hz_check_ACRE_working && !hz_debug) then {
      []spawn {
        waituntil {sleep 0.1; !isnil "acre_sys_io_fnc_startServer"};
        sleep 0.10;
        acre_sys_io_fnc_startServer = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACRE\acre_sys_io_fnc_startServer.sqf";
        Hz_func_acre_OK = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACRE\Hz_func_acre_OK.sqf";
        Hz_func_check_ACRE = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACRE\Hz_func_check_acre.sqf";
        [] call Hz_func_check_ACRE;
      };};

    if (Hz_disallow_sthud && isClass(configFile >> "CfgPatches" >> "ST_FTHud")) then {
      [] spawn {
        waituntil {sleep 0.1; !isnil "introseqdone"};     
        waituntil {sleep 0.1; introseqdone}; 
        hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! Disallowed addon detected: @sthud. Remove this addon to play on this server.</t>"];
        sleep 9;
        hintc "You were removed from the game for running a disallowed addon: @st_hud";
        endMission "LOSER"; 
      };
    };

    if (Hz_disallow_blastcore && isClass(configFile >> "CfgPatches" >> "WarFXPE")) then {
      [] spawn { 
        waituntil {sleep 0.1; !isnil "introseqdone"};     
        waituntil {sleep 0.1; introseqdone};        
        hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! Disallowed addon detected: @blastcore_visuals. Remove this addon to play on this server.</t>"];
        sleep 9;
        hintc "You were removed from the game for running a disallowed addon: @blastcore_visuals";
        endMission "LOSER"; 
      };
    };

    if (Hz_disallow_LEA && isClass(configFile >> "CfgPatches" >> "LEA") && !isClass(configFile >> "CfgPatches" >> "LEA_Hz")) then {
      [] spawn { 
        waituntil {sleep 0.1; !isnil "introseqdone"};
        disableuserinput true;
        waituntil {sleep 0.1; introseqdone};        
        hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! Disallowed addon detected: @LEA. Remove this addon to play on this server.</t>"];
        sleep 9;
        disableuserinput false;
        hintc "You were removed from the game for running a disallowed addon: @LEA. This mission requires you to be running a custom version of LEA, which is part of our modpack. You must not load @LEA separately.";
        endMission "LOSER"; 
      };
    };
    
    if (isClass(configFile >> "CfgPatches" >> "mcc_sandbox")) then {
      [] spawn { 
        waituntil {sleep 0.1; !isnil "introseqdone"};
        disableuserinput true;
        waituntil {sleep 0.1; introseqdone};        
        hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! Disallowed addon detected: @mcc_sandbox. Remove this addon to play on this server.</t>"];
        sleep 9;
        disableuserinput false;
        hintc "You were removed from the game for running a disallowed addon: @mcc_sandbox.";
        endMission "LOSER"; 
      };
    };
    
    sleep 8;
    
    if (Hz_enable_weps_restriction) then {
      
      if (!hz_debug) then {
        removeallweapons player;
        removeallitems player;
        [player,0,0,0,true] call ACE_fnc_PackIFAK;
        [player, ""] call ACE_fnc_AddWeaponOnBack;
        [player, "ALL"] call ACE_fnc_RemoveGear;
        sleep 1;
      };     
      
      if(((getplayeruid player) in Hz_wep_restrictions_jointOp) && (player iskindof "USMC_Soldier_Base")) exitwith {
        
        Hz_playertype = "jointOp";
        if(isMultiplayer && Hz_slotrestrictions) then{[] execvm "Hz\Hz_scripts\Hz_restrict_slots.sqf";}; 
        
      };
      
      waituntil {sleep 0.1; !isnil "ace_sys_repair_fnc_repair"};
      sleep 0.1;
      ace_sys_repair_fnc_repair = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_repair\ace_sys_repair_fnc_repair.sqf";
      Hz_econ_func_getAmmoPrice = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_repair\Hz_econ_func_getAmmoPrice.sqf"; 
      Hz_func_getFuelCapacity = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_repair\Hz_func_getFuelCapacity.sqf"; 
      waituntil {sleep 0.1; !isnil "ace_sys_repair_fnc_get_capacity"};
      sleep 0.1;
      ace_sys_repair_fnc_get_capacity = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_repair\ace_sys_repair_fnc_get_capacity.sqf";
      waituntil {sleep 0.1; !isnil "ace_sys_repair_fnc_refuel"};
      sleep 0.1;
      ace_sys_repair_fnc_refuel = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_repair\ace_sys_repair_fnc_refuel.sqf"; 
      waituntil {sleep 0.1; !isnil "ace_sys_repair_fnc_add_magazine"};
      sleep 0.1;
      ace_sys_repair_fnc_add_magazine = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_repair\ace_sys_repair_fnc_add_magazine.sqf"; 
      waituntil {sleep 0.1; !isnil "ace_sys_repair_fnc_restore_loadout"};
      sleep 0.1;
      ace_sys_repair_fnc_restore_loadout = compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_repair\ace_sys_repair_fnc_restore_loadout.sqf"; 
      
      
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
      
      [] execvm "HZ\HZ_scripts\Hz_WeaponCheck.sqf"; 
      
    };
    
    if(isMultiplayer && Hz_slotrestrictions) then{[] execvm "Hz\Hz_scripts\Hz_restrict_slots.sqf";}; 
    
  };
  
  //Flexi menu entries
  ["player", [ace_sys_interaction_key_self], -99999, ["HZ\Hz_funcs\Hz_flexi_menu.sqf", "main"],true] call CBA_ui_fnc_add;
  ["player", [ace_sys_interaction_key_self], -99999, ["HZ\Hz_funcs\Hz_anim_menu.sqf", "main"],true] call CBA_ui_fnc_add;
  
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
  call compile preprocessfilelinenumbers "HZ\Hz_sys_save\Hz_save_init.sqf";
  
  HZ_spawncivs                    = compile preprocessFileLineNumbers "hunterz_civ_main.sqf";
  HZ_updatecivs                   = compile preprocessFileLineNumbers "hunterz_civ_update.sqf";
  HZ_SAMrateoffire                = compile preprocessFileLineNumbers "logistics\SAM_rateoffire.sqf";
  Hz_func_findSpawnPos            = compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_func_findSpawnPos.sqf";
  Hz_task_reinforcements = compile preprocessfilelinenumbers "HZ\Hz_scripts\Hz_task_reinforcements.sqf";
  Hz_func_bombingrun = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_bombingrun.sqf";
  Hz_func_callinBomber = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_callinBomber.sqf";
  Hz_func_opforVehicleSupport = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_opforVehicleSupport.sqf";
  Hz_func_fill_up_vehicle = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_fill_up_vehicle.sqf";
  Hz_func_create_roadside_IED = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_create_roadside_IED.sqf";
  Hz_func_isUrbanArea = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_isUrbanArea.sqf";
  Hz_func_setRealTime = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_setRealTime.sqf";
  Hz_weather_func_dynamicWeather = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_weather_func_dynamicWeather.sqf";
  Hz_func_spawnOpforArtilleryBase = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_spawnOpforArtilleryBase.sqf";    
  Hz_func_initOpforComposition = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_initOpforComposition.sqf";    
  
  if(!isMultiplayer) then {{if(!isplayer _x) then {deletevehicle _x};}foreach switchableunits;};

};

[]spawn compile preprocessfilelinenumbers "HZ\Hz_funcs\ACE\sys_repair\Hz_initLogistics.sqf";  