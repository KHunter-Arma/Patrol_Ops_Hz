Hz_initdone = false;
Hz_roles_initdone = false;
hz_debug = false;
mps_debug = false;
if(isnil "hz_debug_air") then {hz_debug_air = false;};
if(isnil "hz_debug_cas") then {hz_debug_cas = false;};
if(isnil "civ_debug") then {civ_debug = false;};

if (is3DEN) then {

	waitUntil {sleep 1; !is3DEN};

};

#include "Hz_config.sqf"

if(!isMultiplayer) then {
  hz_debug = true;
  mps_debug = true;
	Hz_enableHC = false;
  hintsilent "DEBUG mode initialised!";
};

Hz_fnc_isHC = compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_fnc_isHC.sqf";
Hz_fnc_isTaskMaster = compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_fnc_isTaskMaster.sqf";
Hz_fnc_isUncon = compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_fnc_isUncon.sqf";
Hz_func_findGarrisonedRespawnPos = compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_func_findGarrisonedRespawnPos.sqf";

if(isnil "jointops") then {jointops = false;};

call compile preprocessfilelinenumbers "lk\nuke\nenvi.sqf";

//init Weather
[] execVM "HZ\Hz_sys_weather\Hz_weather_init.sqf";

// Init dialogs
call compile preprocessfilelinenumbers "HZ\dialogs\fort\HZ_fort_init.sqf";
call compile preprocessfilelinenumbers "HZ\dialogs\admin\HZ_admin_init.sqf";

Hz_initdone = true;

//Other initialisations
Hz_fnc_vehicleInit = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_fnc_vehicleInit.sqf";
Hz_pops_fnc_storeBoughtVehicleInit = compile preprocessfilelinenumbers "Hz_pops_fnc_storeBoughtVehicleInit.sqf";
Hz_func_isSupervisor = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_isSupervisor.sqf";
Hz_func_find_nearest_ammo_crate = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_find_nearest_ammo_crate.sqf";
Hz_func_locateFOB = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_locateFOB.sqf";

//Client init
if(!isDedicated && !(call Hz_fnc_isHC)) then {

	Hz_fnc_arrestPlayer = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_fnc_arrestPlayer.sqf";
  Hz_fnc_arrestedHandleEscape = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_fnc_arrestedHandleEscape.sqf";
	Hz_fnc_transferGearToNearestAmmoCrate = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_fnc_transferGearToNearestAmmoCrate.sqf";
  
  [] spawn {   
    
    waituntil {sleep 0.1; !isnull player};
    sleep 1;
    
    if (Hz_pops_enableRestrictions) then {
      
      _uid = getPlayerUID player;
      
      if ((_uid in Hz_pops_jointOpList) && (player iskindof Hz_JointOp_UnitBaseType)) exitwith {
        
        Hz_playertype = "jointOp";				
        if(isMultiplayer && Hz_pops_enableSlotRestrictions) then{[] execvm "Hz\Hz_scripts\Hz_restrict_slots.sqf";}; 
        
      };      
			
			Hz_econ_combatStore_storeClosed = false;
      
      if(_uid in Hz_pops_restrictions_supervisorList) then {
        
        Hz_playertype = "supervisor";
				Hz_econ_vehicleStore_storeClosed = false;
        
      } else {
        
        if(_uid in Hz_pops_restrictions_publicNoRatioLimit) then {
          
          Hz_playertype = "publicNoLimit";
					
					if (Hz_econ_funds < 100000) then {
					
						Hz_econ_combatStore_storeClosed = true;
						
						"Hz_econ_funds" addPublicVariableEventHandler {
						
							if (Hz_econ_funds < 100000) then {
					
								Hz_econ_combatStore_storeClosed = true;
								
							} else {
							
								Hz_econ_combatStore_storeClosed = false;
							
							};
						
						};
					
					};
          
        } else {
          
          Hz_playertype = "public";
					
					if (Hz_econ_funds < 100000) then {
					
						Hz_econ_combatStore_storeClosed = true;
						
						"Hz_econ_funds" addPublicVariableEventHandler {
						
							if (Hz_econ_funds < 100000) then {
					
								Hz_econ_combatStore_storeClosed = true;
								
							} else {
							
								Hz_econ_combatStore_storeClosed = false;
							
							};
						
						};
					
					};
          
        };
        
      };
      
      if(hz_debug) then {
			
				Hz_playertype = "supervisor";
				Hz_econ_vehicleStore_storeClosed = false;
			
			};
			
			if ((!isnil "Hz_pops_disableStore") && {Hz_pops_disableStore}) then {
			
				Hz_econ_combatStore_storeClosed = true;
			
			};
      
    };
    
    if(isMultiplayer && Hz_pops_enableSlotRestrictions) then{[] execvm "Hz\Hz_scripts\Hz_restrict_slots.sqf";}; 
		
		call compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_fnc_setupAceInteractionMenuEntries.sqf";
    
  };

};

// Server init
if (isServer) then {

	civilian setfriend [west, 1];
	civilian setfriend [east, 1];
	civilian setfriend [resistance, 1];

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
	
	srvrst = {
		if (!isnil "srvrst_mtx") exitWith {};
		srvrst_mtx = true; publicVariable "srvrst_mtx";
		Hz_pers_enableAutoSave = false;
		waitUntil {
			sleep 1;
			(count (call BIS_fnc_listPlayers)) == 0
		};
		call Hz_pers_fnc_saveGame;
		sleep 10;
		(preprocessFile "Hz_cfg\Hz_svc\cmd_pwd") serverCommand "#shutdown";
	};
  
  if(!isMultiplayer) then {{if(!isplayer _x) then {deletevehicle _x};}foreach switchableunits;};

};

if (isServer || (call Hz_fnc_isHC)) then {

	Hz_pops_baseSupport = compile preprocessFileLineNumbers "Hz_pops_baseSupport.sqf";
	Hz_pops_baseSupportOffline = true;
	Hz_pops_baseSupportEnabled = true;
	
	Hz_fnc_objectsMapper = compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_fnc_objectsMapper.sqf";
	Hz_fnc_calculateTaskReward = compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_fnc_calculateTaskReward.sqf";
	Hz_fnc_taskReward = compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_fnc_taskReward.sqf";
	Hz_fnc_taskSuccessCheckGenericConditions = compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_fnc_taskSuccessCheckGenericConditions.sqf";
  Hz_func_findSpawnPos            = compile preprocessFileLineNumbers "HZ\Hz_funcs\Hz_func_findSpawnPos.sqf";
  Hz_task_reinforcements = compile preprocessfilelinenumbers "HZ\Hz_scripts\Hz_task_reinforcements.sqf";
  Hz_func_bombingrun = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_bombingrun.sqf";
  Hz_func_callinBomber = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_callinBomber.sqf";
  Hz_func_opforVehicleSupport = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_opforVehicleSupport.sqf";
  Hz_func_fill_up_vehicle = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_fill_up_vehicle.sqf";
  Hz_func_create_roadside_IED = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_create_roadside_IED.sqf";
  Hz_func_isUrbanArea = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_isUrbanArea.sqf";
  Hz_func_setRealTime = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_setRealTime.sqf";
  //Hz_func_spawnOpforArtilleryBase = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_spawnOpforArtilleryBase.sqf";    
  Hz_func_initOpforComposition = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_initOpforComposition.sqf";    
	Hz_fnc_noCaptiveCheck = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_fnc_noCaptiveCheck.sqf";  
	Hz_fnc_noSideCivilianCheck = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_fnc_noSideCivilianCheck.sqf";  

};

if (call Hz_fnc_isHC) then {

	waitUntil {(name player) != "Error: No vehicle"};

	[] execvm "HZ\init_HC.sqf";
	
};