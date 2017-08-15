// =========================================================================================================
// MPS - MultiPlayer Scripting Framework by [OCB]EightySix
// Version Release 2.04
   diag_log format ["###### %1 MPS.INIT ######", missionName];
   diag_log [diag_frameno, diag_ticktime, time, "Executing init_mps.sqf"];
// =========================================================================================================

// DeBuggint MPS
	mps_debug = false;

// Declare a mission name and credits
	mps_mission_name = localize "STR_MISSION_NAME";
	mps_credits = "By [OCB]EightySix";

// =========================================================================================================
//	Modify these configs per your preferences
// =========================================================================================================

// Enable A2, Arrowhead, BAF, PMC Content
	mps_a2	= true; 	// Set false to turn off A2 content
	mps_oa	= true; 	// Set false to turn off OA content
	mps_baf	= true; 	// Set false to turn off BAF content
	mps_pmc	= true; 	// Set false to turn off PMC content
	mps_aaw	= false; 	// Set false to turn off AAW content

	mps_co	= true; 	// Set false to turn off the use of advanced code of ArmA 2 Combined opertions with patch 1.60

// Set the sides
// NOTE: make sure side = faction type, e.g. [east,"BIS_US"] will result in US troops killing each other.
// Faction list can be found in the configuration files to choose from which ones to use.

	SIDE_A = [west,"BIS_US"];		// Player Side
	SIDE_B = [east,"BIS_TK"];	// Enemy Side
	SIDE_C = [east,"BIS_TK_INS"];	// Insurgent Side

// Civillian Types
	ALICE_MODULE =	["AliceManager"];	// Alice = Chernarus, Alice2 = Takistan

// Set total number of expected players
	mps_ref_playercount = 5;	// Max number of players

// Set details for mission intro / outro music
	mps_mission_intro = "Intro";
	mps_mission_outro = "Outro";

// =================================================================================================================================
//	Enemy numbers config only used by the "Spawn OPFOR Army" function. This function is not used in Patrol Ops Hunter'z at all.
// =================================================================================================================================

        mps_params_armour	= [0,1];	// [min,max] number of armour	vs. player number
	mps_params_aa		= [0,2];	// [min,max] number of anti air	vs. player number
	mps_params_apc		= [0,2];	// [min,max] number of apcs	vs. player number
	mps_params_car		= [1,3];	// [min,max] number of light vehicles	vs. player number
	mps_params_inf		= [1,3];	// [min,max] number of infantry	vs. player number

	mps_mission_hour	=    paramsArray select 0;
	mps_mission_type	=    paramsArray select 1;
	mps_mission_counter	=    paramsArray select 2;
	mps_mission_factor	=    paramsArray select 3;
	mps_halo_limitation	=    paramsArray select 4;
	mps_mission_deathlimit	=    paramsArray select 5;
	mps_airdrop_enable	= if(paramsArray select 6  > 0) then {true}else{false};
	mps_liftchopper_enable	= if(paramsArray select 7  > 0) then {true}else{false};
	mps_recruitable_ai	= if(paramsArray select 8  > 0) then {true}else{false};
	mps_ais_factor		=    paramsArray select 9;
	mps_restrict_camera	=    paramsArray select 10;
	mps_restrict_vehicle	= if(paramsArray select 11 > 0) then {true}else{false};
	mps_rank_sys_enabled	= if(paramsArray select 12 > 0) then {true}else{false};
	mps_rank_gear_enabled	= if(paramsArray select 13 > 0) then {true}else{false};
	mps_ied_count		=    paramsArray select 14;
	mps_ambient_civillians	= if(paramsArray select 15 > 0) then {true}else{false};
	mps_ambient_insurgents	= if(paramsArray select 16 > 0) then {true}else{false};
	mps_ambient_airpatrols	= if(paramsArray select 17 > 0) then {true}else{false};
        autoload                = if(paramsArray select 19 > 0) then {true}else{false};

	if(!mps_rank_sys_enabled) then {mps_rank_gear_enabled = false};

	mps_params_muliply	= mps_mission_factor;	// Difficulty Variable from parameters

// =========================================================================================================
//	DO NOT TOUCH CODE BELOW THIS LINE
// =========================================================================================================

// File path folder
	mps_path = "mps\";

// Set Default Variables in case of not being declared
	if(isNil "mps_hud_active") then { mps_hud_active = false; };
	if(isNil "mps_airdrop_enable") then { mps_airdrop_enable = false;};
	if(isNil "mps_ace_wounds") then { mps_ace_wounds = false; };
	if(isnil "mps_class_limit") then { mps_class_limit = false; };
	if(isNil "mps_liftchopper_enable") then { mps_liftchopper_enable = false; };
	if(isNil "mps_sys_rank") then { mps_sys_rank = false; };
	if(isNil "mps_recruitable_ai") then { mps_recruitable_ai = false; };
	if(isNil "mps_moveable_unload") then { mps_moveable_unload = ""; };
	if(isNil "mps_lock_action") then { mps_lock_action = false; };
	if(isNil "mps_rank_sys_enabled") then { mps_rank_sys_enabled = false; };
	if(isNil "mps_acre_enabled") then { mps_acre_enabled = false; };
	if(isNil "mps_mission_deathcount") then { mps_mission_deathcount = 0; };
	if(isNil "mps_teamkillers") then { mps_teamkillers = []; };
	if(isNil "mps_rank_gear") then { mps_rank_gear = false; };
	if(isNil "RALLY_STATUS") then { RALLY_STATUS = false; };

// Load the Configruation Variables
	[] call compile preprocessFileLineNumbers (mps_path+"config\config_ammobox.sqf");
	[] call compile preprocessFileLineNumbers (mps_path+"config\config_units.sqf");
	[] call compile preprocessFileLineNumbers (mps_path+"config\config_vehicles.sqf");
	[] call compile preprocessFileLineNumbers (mps_path+"config\config_backpacks.sqf");
	[] call compile preprocessFileLineNumbers (mps_path+"config\config_aas.sqf");
	[] call compile preprocessFileLineNumbers (mps_path+"func\mps_func_functions.sqf");

// FUNCTIONS LISTS which are called when needed.
	mps_weapons_list		= compile preprocessFileLineNumbers (mps_path+"config\config_armoury.sqf");
	mps_cleanup			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_cleanup.sqf");
	mps_get_position		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_get_position.sqf");
	mps_getnearbylocation		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_nearbylocation.sqf");
	mps_getEnterableHouses 		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_getenterablehouses.sqf");
	mps_getRandomElement		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_getrandomarrayelement.sqf");
	mps_getArrayPermutation		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_getarraypermutation.sqf");
	mps_getFlatArea 		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_getflatarea.sqf");
	mps_getnearestroad		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_getnearestroad.sqf");
	mps_new_position		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_new_position.sqf");
	mps_object_c4only		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_c4only.sqf");
	mps_random_position		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_random_location.sqf");
	mps_getNewLocation		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_nearlocation.sqf");
	mps_timeset 			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_time_set.sqf");
	mps_timechange 			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_time_change.sqf");
	mps_adv_hint			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_advhint.sqf");
	mps_tasks_init			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_taskmaster.sqf");
	mps_class_check			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_class_check.sqf");
	mps_intro			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_intro_sequence.sqf");
	mps_intro_camera		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_intro_camera.sqf");
	mps_outro			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_outro_sequence.sqf");
	mps_outro_camera		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_outro_camera.sqf");
	mps_player_killed		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_respawn_killed.sqf");
	mps_player_dead			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_respawn_dead.sqf");
	mps_func_death_pos		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_respawn_deathpos.sqf");
	mps_func_death_cam		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_respawn_deathcam.sqf");
	mps_func_respawn		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_respawn_select.sqf");
	mps_respawn_delay		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_respawn_delay.sqf");
	mps_respawn_dialog_upd 		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_respawn_dialog.sqf");
	mps_respawn_gear 		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_respawn_gear.sqf");
	mps_get_new_type 		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_mhq_gettype.sqf");
	mps_mhq_toggle			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_mhq_toggle.sqf");
	mps_mhq_respawn			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_mhq_respawn.sqf");
	mps_mhq_update			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_mhq_update.sqf");
	mps_rallypoint_init		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_rallypoint_init.sqf");
	mps_rank_update			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_rank_update.sqf");
	mps_rank_proxy			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_rank_proximity.sqf");
	mps_rank_init			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_rank_system.sqf");
	mps_rank_hud			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_rank_hud.sqf");
	mps_func_hud_aimpoint		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_hud_aimpoint.sqf");
	mps_func_hud_3d			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_hud_3d.sqf");
	mps_func_hud_menu_update	= compile preprocessFileLineNumbers (mps_path+"func\mps_func_hud_menu_update.sqf");
	mps_func_hud_teamlist		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_hud_teamlist.sqf");
	mps_func_calculate_alpha	= compile preprocessFileLineNumbers (mps_path+"func\mps_func_calculate_alpha.sqf");
	mps_func_display_getnameNrank	= compile preprocessFileLineNumbers (mps_path+"func\mps_func_getnamerank.sqf");
	mps_func_keyspressed		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_keypressed.sqf");
	mps_func_aas_gui		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_aas_gui.sqf");
	mps_func_aas_loadout		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_aas_loadout.sqf");
	mps_func_aas_loadout_ace	= compile preprocessFileLineNumbers (mps_path+"func\mps_func_aas_loadout_ace.sqf");
	mps_ammobox			= compile preprocessFileLineNumbers (mps_path+"func\mps_func_ammobox_init.sqf");
	mps_fill_ammobox		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_ammobox_fill.sqf");
	mps_ammobox_remove		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_ammobox_remove.sqf");
	mps_patrol_init 		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_patrol_init.sqf");
	mps_spawn_vehicle 		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_spawn_vehicle.sqf");
	mps_object_offset		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_object_offset.sqf");
	mps_moveable_unload		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_moveable_unload.sqf");
	mps_injury_sys_init		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_ais_init.sqf");
	mps_backpack_dialog_upd		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_bkp_dialogupd.sqf");
	mps_lift_chopper_init 		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_liftchopper_init.sqf");
	mps_mission_sequence		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_mission_sequence.sqf");
	mps_replace_with_ace		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_replace_with_ace.sqf");
	mps_recruit_build_list		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_recruit_dialog.sqf");
	mps_recruit_create_new		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_recruit_create_unit.sqf");
	mps_progress_toggle		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_progress_toggle.sqf");
	mps_progress_update		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_progress_update.sqf");
	CREATE_OPFOR_SQUAD		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_spawn_opforsquad.sqf");
	CREATE_OPFOR_ARMY		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_spawn_opforarmy.sqf");
	CREATE_OPFOR_STATIC		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_spawn_opforstatic.sqf");
	CREATE_OPFOR_STATICVEHICLE		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_spawn_opforstaticVehicle.sqf");
	CREATE_OPFOR_SNIPERS		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_spawn_opforsnipers.sqf");
	CREATE_OPFOR_PARADROP		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_spawn_opforparadrop.sqf");
	CREATE_OPFOR_TOWER		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_spawn_opfortower.sqf");
	CREATE_OPFOR_PATROLS		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_spawn_opforpatrols.sqf");
	CREATE_OPFOR_AIRPATROLS		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_spawn_opforradar.sqf");
	CREATE_MOVEABLE_CONTAINER	= compile preprocessFileLineNumbers (mps_path+"func\mps_func_moveable_container.sqf");
	CREATE_MOVEABLE_TOWER		= compile preprocessFileLineNumbers (mps_path+"func\mps_func_moveable_tower.sqf");
        CONFIG_ACM                      = compile preprocessFileLineNumbers (mps_path+"func\mps_func_ambient_combat.sqf");


// Dynamic BIS Object spawner
	BIS_fnc_dyno			= compile preprocessFileLineNumbers "ca\modules\dyno\data\scripts\objectMapper.sqf";

// BON Visualisation Adaption
	if(isnil "visual_settings_maxallowed_viewdist") then {visual_settings_maxallowed_viewdist = 15000;};
	vpos = viewdistance;
	GrassLayer = 1;

// Bon Recruitment Variables;
	mps_group_maxsize = (paramsArray select 18);
	mps_recruit_queue = [];

// Calling Public Event Handlers
	//[] call compile preprocessFileLineNumbers (mps_path+"func\mps_func_ammobox_pevh.sqf");
	//[] call compile preprocessFileLineNumbers (mps_path+"func\mps_func_rank_pevh.sqf");

// Calling Team killing :) HAHAHAHA!!!!
	//[] call compile preprocessFileLineNumbers (mps_path+"func\mps_func_teamkiller_h.sqf");

// Admin Tools
	//mps_lock_vehicle = { _this lock true; };
	//mps_unlock_vehicle = { _this lock false; };

// Begin Task sytem by Shuko
	[] call mps_tasks_init;
        
CENTERPOS = markerpos "ao_centre";
AORADIUS = 2000;
eastStationaryGuns = ["KORD_high_TK_EP1","DSHKM_TK_INS_EP1","ZU23_TK_INS_EP1","AGS_TK_INS_EP1",/*"SPG9_TK_INS_EP1","ACE_Konkurs_TK","Metis_TK_EP1","2b14_82mm_TK_INS_EP1",*/"Igla_AA_pod_TK_EP1"];
maxStaticGuns = 0;
if (isnil "gCount") then {gCount = 0;};
startLocation = markerpos "Base";
stationaryGunsHigh = ["KORD_TK_EP1","ZU23_TK_INS_EP1","AGS_TK_INS_EP1","2b14_82mm_TK_INS_EP1","DSHkM_Mini_TriPod","Igla_AA_pod_TK_EP1"];
stationaryGunsMed = ["DSHKM_TK_INS_EP1","AGS_TK_INS_EP1","KORD_high_TK_EP1"];
stationaryGunsLow = ["AGS_TK_INS_EP1","ZU23_TK_INS_EP1","DSHKM_TK_INS_EP1","KORD_high_TK_EP1"];
GUNROOFPOSITIONS = ["Land_dum_istan2b",[[0,0],[1,0.1],[2,0],[3,0.1],[4,0.1],[5,0.2],[6,0.2],[7,0.1],[8,0.2]],"Land_dum_istan3",[[3,0.2]],"Land_dum_istan3_pumpa",[[2,0],[3,0],[4,0],[5,0.2]],"Land_dum_istan2",[[1,0.7],[2,0.2],[3,0.2],[4,0.1],[5,0.1],[6,0.2],[7,0.1],[8,0.2]],"Land_water_tank",[[1,0],[2,0],[3,0],[4,0]],"Land_dum_istan3_hromada2",[[3,0.3],[4,0.3],[5,0.5],[6,0.4],[7,0.5],[8,0.2],[9,0.2],[10,0.2]],"Land_Vysilac_FM",[[1,0],[2,0],[3,0],[4,0]],"Land_A_CraneCon",[[1,0],[2,0]],"Land_Panelak",[[10,-1],[13,0.4],[14,0.3],[15,0.3],[16,0.3],[17,0.3]],"Land_Panelak3",[[4,0],[5,0],[6,0],[7,0]],"Land_watertower1",[[0,0],[1,0],[2,0],[3,0],[4,0],[5,0],[6,0]],"Land_Ind_Mlyn_01",[[1,0],[3,0.2]],"Land_A_TVTower_Base",[[3,0],[4,0],[5,0],[6,0],[7,0],[8,0],[9,0],[10,0],[12,0]],"Land_Ind_Mlyn_03",[[1,0],[2,0],[3,0],[4,0],[6,0],[7,0]],"Land_A_Crane_02b",[[4,0],[5,0],[6,0.8],[7,0]],"Land_A_Crane_02a",[[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0]],"Land_dum_zboreny",[[8,1]],"Land_Tovarna2",[[13,0],[14,0],[15,0],[16,0],[17,0.1],[18,0.2],[34,0.8],[35,0.1]],"Land_A_BuildingWIP",[[19,0.7],[20,0.5],[21,0.8],[22,0.2],[23,0],[24,0.9],[25,0.8],[26,0.9],[27,0.9],[28,0.9],[33,1],[34,1],[35,1],[36,1],[37,1],[38,1],[39,0.9],[40,0.6],[41,0.1],[42,0.4],[43,0.5],[44,1],[45,0.5],[46,0.1],[47,0.5],[48,0],[49,0.2],[51,1],[53,0.3],[54,0.2],[55,0],[56,0],[57,0.3],[58,1],[59,0.3],[60,0.9]],"Land_hotel",[[52,0.9],[53,0.6],[54,0.1],[55,1],[57,-1],[64,0.7],[65,0.6],[66,0.6],[67,1],[70,0.7],[76,0.7],[77,0.6],[78,0.6],[91,0.7],[92,0.6],[93,0.6],[94,1],[97,0.7],[99,0.9],[115,1],[116,0.6],[117,0.6],[118,1],[126,0.7],[127,0.6],[128,0.6],[129,1],[132,0.7],[138,0.7],[139,0.6],[140,0.6],[153,0.7],[154,0.6],[155,0.6],[156,1],[159,0.7],[161,0.8],[165,0.3],[177,1],[178,0.6],[179,0.6],[180,1],[188,0.7],[189,0.6],[190,0.6],[191,1],[194,0.7],[200,0.7],[201,0.6],[202,0.6],[215,0.7],[216,0.6],[217,0.6],[218,1],[221,0.7],[223,0.9],[227,0.3],[237,0.3],[238,0.3],[239,0.6],[240,0.3],[241,0.6],[242,0.3],[243,0.6],[244,0.3],[245,0.6],[246,0.3],[247,0.3],[248,0.3],[249,0.3],[250,0.3],[251,0.8],[252,0.3],[253,0.3],[254,0.3],[255,0.3],[256,0.3],[257,0.3],[258,0.3]],"Land_Panelak2",[[1,0.1],[9,0.3],[10,0],[11,0],[12,0],[13,0]],"Land_Barn_Metal",[[7,0.1],[8,0.3],[9,0],[10,0],[11,0]],"Land_Ind_MalyKomin",[[1,0],[2,0],[3,0],[4,0],[5,0.2]],"Land_Ind_Stack_Big",[[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0]],"Land_Ind_SiloVelke_01",[[0,0],[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0]],"Land_Ind_Quarry",[[9,0],[10,0],[11,0],[12,0.2],[13,0.3]],"Land_Nasypka",[[1,0],[2,0],[3,0],[4,0]],"Land_a_stationhouse",[[12,0.1],[14,0.1],[15,0.1],[16,0.1],[17,0.1],[18,0.1],[19,0.1],[20,0.1],[21,0.1],[22,0.1],[23,0.1],[24,0.1],[25,0]],"Land_Ind_Pec_01",[[2,0],[3,0],[4,0],[5,0],[6,0.1],[7,0],[9,0],[10,0.3],[11,0.3]],"Land_vysilac_FM2",[[1,0],[2,0],[3,0],[4,0]],"Land_Mil_ControlTower",[[2,-1],[4,-1],[9,0],[10,0],[11,0],[12,0],[13,0],[14,0],[15,0],[17,0],[18,0],[19,0],[20,0]],"Land_Shed_Ind02",[[4,0.2],[5,0],[16,0.2]]];
ILLEGALHOUSES = ["Land_Mil_hangar_EP1", "Land_Mil_ControlTower_EP1", "Land_Mil_Guardhouse_EP1", "Land_Mil_Repair_center_EP1","Land_Mil_Barracks_i_EP1","Land_A_Minaret_EP1","Land_Ind_Coltan_Main_EP1"];
// set EP1HOUSES to 'true' in order to have the param ignored and AI will spawn in every building, which got positions
EP1HOUSES = true;
spawnPos = startLocation;
staticClass = "TK_Soldier_EP1";
halocarried = false;
haloarray = [];


// Declare MPS initialised
	mps_init = true;

// Initialise Client and Server to begin calling Functions
	[] execVM (mps_path+"init_mps_server.sqf");
        
        WaitUntil{ Receiving_finish };
        
        //global empty fuel stations
        { _x setFuelCargo 0; } forEach (nearestObjects [markerpos "ao_centre", ["Land_Ind_FuelStation_Feed_EP1","Land_A_FuelStation_Feed"], 15000]);
        
	[] execVM (mps_path+"init_mps_client.sqf");


        
        
        
        

