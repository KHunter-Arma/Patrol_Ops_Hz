////////////////////////////////////////////////
//           Hunter'z Core Settings
////////////////////////////////////////////////

Hz_devs = ["76561198002110130"];

Hz_GMTOffset = -3;

//min 3 supervisors per public player -- 0 to disable limit
Hz_publicPlayerRatioLimit = 3;

//immersion settings
ACE_NO_RECOGNIZE = true;
setGroupIconsVisible [false,false];
Hz_disable_ACE_sniper_dust = true;  //recommended for urban maps
onMapSingleClick "_shift";   //disable shift+click magic map marker
enableSentences false;

//side relations
resistance setfriend [east, 0];
east setfriend [resistance, 0];

//performance settings
Hz_max_allunits = 260;
Hz_max_deadunits = 60;
Hz_max_ambient_units = 200;
Hz_ambient_units_intensify_amount = 20;   //the amount to increase ambient unit count by during some tasks (this has a random chance of happening)
Hz_max_units_before_task = 215;
Hz_max_desired_server_FPS = 23;
Hz_min_desired_server_FPS = 17;
Hz_max_desired_server_VD =  7185;   //NOTE: Max object render distance (0 fog, max Video settings, Arma 2) for players found to be 7185m
Hz_min_desired_server_VD =  3500;

////////////////////////////////////////////////
//        Patrol Ops Hunter'z Settings
////////////////////////////////////////////////

//task rewards
Hz_penalty_multiplier_per_death = 50000;
Hz_econ_perSquadReward = 15000;
Hz_econ_CAS_reward = 200000;
Hz_econ_Tank_reward = 750000;
Hz_econ_IFV_reward = 400000;
Hz_econ_AA_reward = 100000;
Hz_econ_Car_reward = 40000;
Hz_econ_Tower_reward = 250000;
Hz_econ_Sniper_reward = 5000;
Hz_econ_Static_reward = 50000;
Hz_econ_StaticVehicle_reward = 400000;

//compositions
Hz_enableStaticEmplacementCompositions = true;
mps_opfor_staticVehicleComps = ["t55_emp_open","t72_emp_open","T64_emp_open","T62_emp_open","t80_emp_open","m113_emp","brdm2_emp","brdm2_atgm_emp","bmp2_emp"];
mps_opfor_staticWeaponComps = ["ags_emp_open","dshkm_emp_open","kord_emp_open","metis_emp_open","spg9_emp_open","zu23_emp_open"];

Hz_mapRadius = 10000;

////////////////////////////////////////////////
//           Hunter'z Economy Module Settings
////////////////////////////////////////////////

Hz_enable_weps_restriction = true;

if(isServer) then {
  
  Hz_wep_restriction_whitelist = ["76561198056074177","76561198012587329","76561198006958791","76561198002906820","76561198056800694","76561198048254349","76561198117073327","76561198027293421","76561198059583284",
  "76561198035571753","76561198086631026","76561198080472574","76561197998271838","76561198129876850",    
  
  // Non-members
  "76561197983958892", //Diamond
  "76561198086630094" //Drunken
  
  ];
  
  Hz_wep_restriction_supervisors = ["76561198002110130","76561198017258138","76561197992821044",
  "76561197991833712","76561197988793826","76561198142692277","76561198012587329","76561198002906820",
  "76561198027293421","76561198117073327","76561198048254349","76561198056800694"];
  
  Hz_wep_restrictions_jointOp = [];
  
  //temporary. to restrict special skins
  Hz_specialpermissions = [];
  
  Hz_Officers = ["76561198002110130","76561198017258138","76561198142692277"];
  
  //for recruits that have completed weapons training
  Hz_temp_non_supervisor_PMC_permissions = [];
  
  publicvariable "Hz_wep_restriction_supervisors";
  publicvariable "Hz_wep_restriction_whitelist";
  publicvariable "Hz_specialpermissions";
  publicvariable "Hz_Officers";
  publicvariable "Hz_temp_non_supervisor_PMC_permissions";
  publicvariable "Hz_wep_restrictions_jointOp";
  
};

//Override weapon and/or magazine prices if needed. 
//Note: Items not listed in these scripts will not be buyable! 
//[]spawn {waituntil {!isnil "Hz_get_wep_cost"}; Hz_get_wep_cost = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_func_getwepcost.sqf";};
//[]spawn {waituntil {!isnil "Hz_get_mag_cost"};Hz_get_mag_cost = compile preprocessfilelinenumbers "HZ\Hz_funcs\Hz_get_mag_cost.sqf";};

Hz_restricted_vehs = ["TTK_M113A_US","TTK_M163A1_US","TTK_M163_MACHBET_US","LAV_25_OIF","BAF_FV510_D","ACE_STRYKER_ICV_M2_D","ACE_STRYKER_ICV_M2_SLAT_D","ACE_STRYKER_ICV_MK19_D","ACE_STRYKER_ICV_MK19_SLAT_D","ACE_STRYKER_RV_D",
"ACE_STRYKER_RV_SLAT_D","M1129_MC_EP1","M1135_ATGMV_EP1","M1A1_US_DES_EP1","ACE_M1A1HA_TUSK_DESERT","ACE_M1A1HA_TUSK_CSAMM_DESERT","M1A2_US_TUSK_MG_EP1","M2A2_EP1","M2A3_EP1","M6_EP1","MLRS_DES_EP1","AN2_2_TK_CIV_EP1",
"MI17_CIVILIAN","USEC_BELL206_1","USEC_BELL206_3","GNT_C185E","GNT_C185F","GNT_C185U","GNT_C185","GNT_C185R","GNT_C185C","POOK_H13_AMPHIB_UNO","POOK_H13_AMPHIB_PMC","POOK_H13_AMPHIB_CIV","METIS_TK_EP1","ACE_120TAMPELLA",
"ACE_ARTY_M119","ACE_2B14_82MM","ACE_M47_STATIC","ACE_M224_1","ACE_M252"
];

////////////////////////////////////////////////
//            ACE Wounds Settings (for AI)
////////////////////////////////////////////////

ace_sys_wounds_enabled = true;
//ace_sys_wounds_noai = true;	
//ace_wounds_prevtime = 300;
ace_sys_wounds_leftdam = 0.35;				
ace_sys_wounds_all_medics = false;						
ace_sys_wounds_no_rpunish = true;					
ace_sys_wounds_auto_assist_any = true;		
ace_sys_wounds_ai_movement_bloodloss = true;	
ace_sys_wounds_player_movement_bloodloss = true;	
ace_sys_wounds_auto_assist = true;				
//ace_sys_wounds_no_medical_vehicles = true;     

////////////////////////////////////////////////
//            Hunter'z Weather Settings
////////////////////////////////////////////////

Hz_falloutDuration = 1209600;
Hz_weather_Snow = false; //overrides all settings below if enabled
Hz_weather_avg_overcast = 0;
Hz_weather_avg_fog = 0;
Hz_weather_avg_wind = 0.1;
Hz_weather_avg_rain = 0;
Hz_weather_change_chance = 0.2;

////////////////////////////////////////////////
//            Addon Restrictions
////////////////////////////////////////////////

Hz_disallow_sthud = true;
Hz_disallow_blastcore = true;
Hz_disallow_LEA = true;
Hz_check_ACRE_working = true;


////////////////////////////////////////////////
//            Miscellaneous Options
////////////////////////////////////////////////

Hz_disable_ACE_rearm_cargo_weapons = true;
Hz_slotrestrictions = true;
Hz_noposbuildings = [];