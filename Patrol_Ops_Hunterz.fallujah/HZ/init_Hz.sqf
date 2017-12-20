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
call compile preprocessFileLineNumbers "HZ\Hz_sys_weather\Hz_weather_init.sqf";

// Init dialogs
call compile preprocessfilelinenumbers "HZ\dialogs\fort\HZ_fort_init.sqf";
call compile preprocessfilelinenumbers "HZ\dialogs\admin\HZ_admin_init.sqf";

Hz_initdone = true;

//Other initialisations
Hz_fnc_vehicleInit = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_fnc_vehicleInit.sqf";
Hz_pops_fnc_storeBoughtVehicleInit = compile preprocessfilelinenumbers "Hz_pops_fnc_storeBoughtVehicleInit.sqf";
Hz_func_isSupervisor = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_isSupervisor.sqf";
Hz_func_find_nearest_ammo_crate = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_find_nearest_ammo_crate.sqf";
Hz_sleep_mutex = false;

//Client init
if(!isDedicated)  then {

	Hz_fnc_arrestPlayer = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_fnc_arrestPlayer.sqf";
  
  [] spawn {   
    
    waituntil {sleep 0.1; !isnull player};
    sleep 1;
    
    if (Hz_pops_enableRestrictions) then {
      
      _uid = getPlayerUID player;
      
      if ((_uid in Hz_pops_jointOpList) && (player iskindof Hz_JointOp_UnitBaseType)) exitwith {
        
        Hz_playertype = "jointOp";
				Hz_econ_combatStore_storeClosed = true;
				Hz_econ_vehicleStore_storeClosed = true;
        if(isMultiplayer && Hz_pops_enableSlotRestrictions) then{[] execvm "Hz\Hz_scripts\Hz_restrict_slots.sqf";}; 
        
      };      
      
      if(_uid in Hz_pops_restrictions_supervisorList) then {
        
        Hz_playertype = "supervisor";
        
      } else {
        
        if(_uid in Hz_pops_restrictions_publicNoRatioLimit) then {
          
          Hz_playertype = "publicNoLimit";
					Hz_econ_vehicleStore_storeClosed = true;
          
        } else {
          
          Hz_playertype = "public";
					Hz_econ_vehicleStore_storeClosed = true;
          
        };
        
      };
      
      if(hz_debug) then {Hz_playertype = "supervisor"; Hz_econ_vehicleStore_storeClosed = false;};
      
    };
    
    if(isMultiplayer && Hz_pops_enableSlotRestrictions) then{[] execvm "Hz\Hz_scripts\Hz_restrict_slots.sqf";}; 
		
		call compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_fnc_setupAceInteractionMenuEntries.sqf";
    
  };

};

// Server init
if (isServer) then {

	if (Hz_pops_enableDetainUnrecognisedUIDs) then {
	
		Hz_pops_releasedUIDs = [];
		publicvariable "Hz_pops_releasedUIDs";
	
	};

  nukeweatherCounter = 0;
  nukeWeatherCountdown_Mutex = false;
  nukeWeatherCountdown = {
    
    //in case already running but called again by another nuke -- so extend duration
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
  
	Hz_civ_initdone = false;
  call compile preprocessfilelinenumbers "hunterz_civ_init.sqf";   
  
	Hz_fnc_calculateTaskReward = compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_fnc_calculateTaskReward.sqf";
	Hz_fnc_taskReward = compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_fnc_taskReward.sqf";
	Hz_fnc_taskSuccessCheckGenericConditions = compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_fnc_taskSuccessCheckGenericConditions.sqf";
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
  //Hz_func_spawnOpforArtilleryBase = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_spawnOpforArtilleryBase.sqf";    
  Hz_func_initOpforComposition = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_initOpforComposition.sqf";    
  
  if(!isMultiplayer) then {{if(!isplayer _x) then {deletevehicle _x};}foreach switchableunits;};

};