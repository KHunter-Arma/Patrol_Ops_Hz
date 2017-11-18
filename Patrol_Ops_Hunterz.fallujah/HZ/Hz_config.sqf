////////////////////////////////////////////////
//           Hunter'z Core Settings
////////////////////////////////////////////////

//immersion settings
setGroupIconsVisible [false,false];
onMapSingleClick "_shift";   //disable shift+click magic map marker
enableSentences false;

////////////////////////////////////////////////
//        Patrol Ops Hunter'z Settings
////////////////////////////////////////////////

Hz_pops_rallyTentType = "Land_TentDome_F";

// Items added here won't be buyable unless price is defined in the price code
Hz_fort_fortificationList = ["WarfareBDepot","CUP_FlagCarrierIONblack_PMC"];

//compositions
Hz_enableStaticEmplacementCompositions = true;
mps_opfor_staticVehicleComps = ["t55_emp_open","t72_emp_open","T64_emp_open","T62_emp_open","t80_emp_open","m113_emp","brdm2_emp","brdm2_atgm_emp","bmp2_emp"];
mps_opfor_staticWeaponComps = ["ags_emp_open","dshkm_emp_open","kord_emp_open","metis_emp_open","spg9_emp_open","zu23_emp_open"];

Hz_mapRadius = 10000;

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