/*

R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
	"truck_01_base_f",
	"truck_02_base_f",
	"truck_03_base_f",
	"b_apc_tracked_01_crv_f"
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"car_f"
];

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"bus",
	"car_f"
];

*/

// Consider also the gear cargo space...

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["tank", 10],
	["car", 8],
	["motorcycle", 0],
	["truck_f", 0],
	["bus", 10],
	["wheeled_apc_f", 10],
	
	/*
	
	["kart_01_base_f", 0],
	["mrap_01_base_f", 12],
	["mrap_02_base_f", 12],
	["mrap_03_base_f", 12],	
	["b_truck_01_mover_f", 5],
	["b_truck_01_repair_f", 0],
	["b_truck_01_covered_f", 120],
	["b_truck_01_ammo_f", 0],
	["b_truck_01_box_f", 170],
	["truck_02_base_f", 120],
	["i_truck_02_medical_f", 100],
	["i_truck_02_fuel_f", 0],
	["i_truck_02_transport_f", 100],
	["o_truck_02_fuel_f", 0],
	["o_truck_02_transport_f", 100],
	["o_truck_03_ammo_f", 0],
	["o_truck_03_device_f", 0],
	["o_truck_03_fuel_f", 0],
	["Quadbike_01_base_F",1],
	
	*/
	
	[ "Offroad_01_base_F", 0],
	[ "Offroad_01_repair_base_F", 3],
	[ "Offroad_02_base_F", 0],
	[ "cWrangler_noir_1", 0],
	[ "Quadbike_01_base_F", 0],
	[ "Hatchback_01_base_F", 12],
	[ "Van_01_base_F", 0],
	[ "Van_01_box_base_F", 240],
	[ "Van_02_base_F", 0],
	[ "SUV_01_base_F", 18],
	[ "C_IDAP_Truck_02_water_F", 0],
	[ "CUP_C_Octavia_CIV", 10],
	[ "CUP_C_Golf4_Base", 0], // you can sit in the trunk, so that should barely leave any space for gear even
	[ "CUP_Ikarus_Base", 15], // all the interior is usable passenger space, so that leaves only underside compartments (which should include gear space too)	
	[ "CUP_SUV_Unarmed_Base", 0], // allows sitting in the trunk	
	[ "CUP_LR_Base", 0],
	//[ "CUP_LR_Ambulance_Base", 0],
	//[ "CUP_LR_Special_Base", 0],
	//[ "CUP_LR_RH_MG_Base", 0],
	//[ "CUP_LR_SPG9_Base", 0],
	[ "chdefender_civ_noir", 60],
	[ "chdiscovery_noir", 40],
	[ "suburban", 60],
	[ "tahoe_UNM", 40],
	[ "tahoe_ltz_08", 0],
	[ "CUP_S1203_Base", 8],
	[ "CUP_S1203_Ambulance_Base", 0],
	[ "CUP_Lada_Base", 8],
	[ "CUP_Skoda_Base", 8],	
	[ "CUP_Volha_Base", 10],	
	[ "CUP_Datsun_Base", 0],
	[ "CUP_Datsun_civil_Base", 16],
	[ "CUP_C_Datsun_4seat", 0],		
	[ "CUP_V3S_Open_Base", 0],
	[ "V12_STRALIS23", 600],
	[ "tw_explorer", 0],
	[ "tw_van_base", 150],
	[ "ranger17ch_noir", 60],
	[ "tw_raptor_black", 60],
	[ "prraptor_noir", 60],
	[ "tw_ram", 70],
	[ "V12_VELOCIRAPTOR", 100],
	[ "tw_vic_black", 12],
	[ "chvwt5_civ_noir", 14],
	[ "Mer_Vito_civ_noir", 45],
	[ "chH1_base", 70],
	[ "chH1_ST_base", 70],
	[ "V12_H1_F", 70],
	[ "V12_H1B_F", 70],
	[ "V12_H1TOP_F", 70],
	[ "V12_H1ASSAULT_F", 70],
	[ "chH2_noir", 30],
	[ "chH3_noir", 27],
	[ "chRenegade_noir", 18],
	[ "chGrand_Cherokee_noir", 21],
	[ "galaxych_civ_noir", 12],
	[ "cmax_civ_noir", 10],
	[ "chKa_noir", 0],
	[ "focus3ch_civ_noir",8],
	[ "focussw3_civ_noir",10],
	[ "mondeoswch_civ_noir",13],
	[ "mondeo_civ_noir",10],
	[ "chfiesta_noir",5],
	[ "chfcrsciv_noir",8],
	[ "V12_FOCUSST12_NOIR",8]
	
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
/*
	["kart_01_base_f", 20],
	["quadbike_01_base_f", 40],
	["ugv_01_base_f", 100]
*/
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];