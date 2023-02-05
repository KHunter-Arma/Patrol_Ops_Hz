////////////////////////////////////////////////
//           Hunter'z Core Settings
////////////////////////////////////////////////

//immersion settings
setGroupIconsVisible [false,false];
onMapSingleClick "_shift";   //disable shift+click magic map marker
if (!isServer && {hasInterface}) then {
	// disable only for player (and any AI units owned by player) so remote AI can have chatter
	enableSentences false;
	
	// try this to disable random radio chatter still coming from player(?)
	enableRadio false;
};

////////////////////////////////////////////////
//        Patrol Ops Hunter'z Settings
////////////////////////////////////////////////

Hz_pops_rallyTentType = "Land_TentDome_F";

// Items added here won't be buyable unless price is defined in the price code
Hz_fort_fortificationList = [
"WarfareBDepot",
"CUP_FlagCarrierIONblack_PMC",

"Land_Cargo_Tower_V3_F",
"Land_Cargo_Tower_V1_F",
"Land_Hlaska",
"Land_HBarrierTower_F",
"Land_Fort_Watchtower_EP1",
"Land_Ind_IlluminantTower",

"Land_BagFence_Corner_F",
"Land_BagFence_End_F",
"Land_BagFence_Long_F",
"Land_BagFence_Round_F",
"Land_BagFence_Short_F",

"US_WarfareBBarrier10xTall_EP1",
"US_WarfareBBarrier10x_EP1",
"US_WarfareBBarrier5x_EP1",
"Land_HBarrier_3_F",
"Land_HBarrier_5_F",
"Land_HBarrier_Big_F",
"Land_HBarrier_1_F",
"Land_HBarrierWall_corridor_F",
"Land_HBarrierWall_corner_F",
"Land_HBarrierWall6_F",
"Land_HBarrierWall4_F",

"Land_CncBarrier_F",
"Land_CncBarrier_stripes_F",
"Land_CncBarrierMedium_F",
"Land_CncBarrierMedium4_F",

"Land_BarGate_F",
"Land_Rampart_F",
"SignAd_SponsorS_ION_F",
"SignAd_Sponsor_ION_F",
"Banner_01_F",
"FlagSmall_F",
"FlagMarker_01_F",
//"Flag_NATO_F",
"Flag_US_F",
//"Flag_UK_F",
"ArrowDesk_L_F",
"ArrowDesk_R_F",
"ArrowMarker_L_F",
"ArrowMarker_R_F",
"RoadBarrier_F",
"RoadBarrier_small_F",
"RoadCone_F",
"Land_RoadCone_01_F",
"RoadCone_L_F",
"Land_RedWhitePole_F",
"TapeSign_F",
"Land_SignM_WarningMilAreaSmall_english_F",
"Land_SignM_WarningMilitaryVehicles_english_F",
"Land_Sign_MinesDanger_English_F",
"Land_Sign_Mines_F",
"Land_Sign_MinesTall_F",
"Land_Sign_MinesTall_English_F",
"Land_Sign_WarningNoWeapon_F",
"Sign_Checkpoint_TK_EP1",
"Sign_Danger",
"Sign_1L_Firstaid_EP1",
"Sign_DangerMines_ACR",
"Sign_1L_Noentry_EP1",
"Land_BagBunker_Small_F",
"Land_BagBunker_Large_F",
"Land_fort_rampart_EP1",
"Land_fort_artillery_nest_EP1",
"ACE_SandbagObject",
"PortableHelipadLight_01_yellow_F",
"PortableHelipadLight_01_white_F",
"PortableHelipadLight_01_red_F",
"PortableHelipadLight_01_green_F",
"PortableHelipadLight_01_blue_F",
"Land_PortableHelipadLight_01_F",
"Land_Campfire_F",
"Land_WoodPile_F",
"Land_FieldToilet_F",
"Land_Camping_Light_F",
"Land_PortableLight_double_F",
"Land_PortableLight_single_F",
"ACE_ConcertinaWireCoil",
//"ACE_TripodObject",
"PlasticBarrier_03_orange_F",
"Land_Cargo10_sand_F",
"Land_Cargo10_grey_F",
"Land_Cargo10_military_green_F",
"Land_Cargo20_military_green_F",
"Land_Cargo20_sand_F",
"Land_Cargo20_grey_F",
"Land_Cargo40_sand_F",
"Land_Cargo40_grey_F",
"Land_Cargo40_military_green_F",
"Land_Water_pipe_EP1",
"Land_ladderEP1",
"Land_ladder_half_EP1",
"CUP_USVehicleBox_EP1",
"Hhedgehog_concreteBig",
"Hhedgehog_concrete",
"MASH",
"Fortress1",
"Fortress2",
"Hedgehog",
"Camp_EP1",
"CampEast",
"WarfareBCamp",
"US_WarfareBFieldhHospital_Base_EP1",
"Land_BagBunker_Tower_F",
"Land_WaterCooler_01_new_F",
"Land_FMradio_F",
"CUP_A1_Road_ces_d6konec",
"CUP_A1_Road_ces_d6",
"CUP_A1_Road_ces_d12",
"CUP_A1_Road_ces_d25"

];

//compositions
Hz_enableStaticEmplacementCompositions = true;
mps_opfor_staticVehicleComps = ["t55_emp_open","t72_emp_open","T64_emp_open","T62_emp_open","t80_emp_open","m113_emp","brdm2_emp","brdm2_atgm_emp","bmp2_emp"];
mps_opfor_staticWeaponComps = ["ags_emp_open","dshkm_emp_open","kord_emp_open","metis_emp_open","spg9_emp_open","zu23_emp_open"];

////////////////////////////////////////////////
//           Hunter'z Restrictions
////////////////////////////////////////////////

Hz_JointOp_UnitBaseType = "rhsusf_infantry_army_base";

if(isServer) then {

	call compile preprocessFileLineNumbers "\Hz_cfg\Hz_pops\Hz_config.sqf";
  
};

////////////////////////////////////////////////
//            Miscellaneous Options
////////////////////////////////////////////////

//building types that have no building positions for AI, but are still accessible -- used by AI garrisson script
Hz_noposbuildings = [];