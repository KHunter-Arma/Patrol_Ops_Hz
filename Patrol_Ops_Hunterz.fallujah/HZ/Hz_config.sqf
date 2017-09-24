////////////////////////////////////////////////
//           Hunter'z Core Settings
////////////////////////////////////////////////

Hz_devs = ["76561198002110130"];

Hz_GMTOffset = -3;

//immersion settings
setGroupIconsVisible [false,false];
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
//           Hunter'z Restrictions
////////////////////////////////////////////////

Hz_pops_enableRestrictions = true;

Hz_pops_enableSlotRestrictions = true;

Hz_JointOp_UnitBaseType = "USMC_Soldier_Base";

//min 3 supervisors per public player -- 0 to disable limit
Hz_publicPlayerRatioLimit = 3;

if(isServer) then {
  
  Hz_pops_restrictions_publicNoRatioLimit = [];
  
  Hz_pops_restrictions_supervisorList = ["76561198002110130","76561198017258138","76561197992821044",
  "76561197991833712","76561197988793826","76561198142692277","76561198012587329","76561198002906820",
  "76561198027293421","76561198117073327","76561198048254349","76561198056800694"];
  
  Hz_pops_jointOpList = [];
  
  Hz_Officers = ["76561198002110130","76561198017258138","76561198142692277"];
  
  publicvariable "Hz_pops_restrictions_supervisorList";
  publicvariable "Hz_pops_restrictions_publicNoRatioLimit";
  publicvariable "Hz_Officers";
  publicvariable "Hz_pops_jointOpList";
  
};


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
//            Miscellaneous Options
////////////////////////////////////////////////

//building types that have no building positions for AI, but are still accessible -- used by AI garrisson script
Hz_noposbuildings = [];