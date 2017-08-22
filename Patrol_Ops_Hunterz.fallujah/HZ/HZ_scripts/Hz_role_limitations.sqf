#include "badpmc_roster.txt"

//Every B.A.D. PMC member is a rifleman. Add all rifles without GL (except ones for MG-type or DM role) that are denied for non-PMC members.
Hz_client_allowed_weps = Hz_client_allowed_weps + [

"ACE_MX2A","ACE_RANGEFINDER_OD","BINOCULAR_VECTOR","ACRE_PRC117F","ACRE_PRC148","ACRE_PRC148_UHF","ACRE_PRC152","ACE_DAGR","ACE_HUNTIR_MONITOR","ACE_KESTREL4500","ACE_SPOTTINGSCOPE",

"M136","ACE_M136_CSRS","ACE_M72A2","ACE_M72","RPG18",
"BWMOD_PZF_HEAT","PZF_HEAT_T","PZF_HEAT_IT"
 
];

if (AT_A) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"MAAWS","SMAW","M47LAUNCHER_EP1","ACE_JAVELIN_CLU","ACE_RPG22","ACE_RPG27",
"RPG7V","ACE_RPG7V_PGO7","ACE_JAVELIN_DIRECT","ACE_M47_DAYSIGHT","METISLAUNCHER","JAVELIN"
];

Hz_restricted_vehs = Hz_restricted_vehs - ["METIS_TK_EP1"];

};

if (AT) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"ACE_RMG","ACE_RPG29","ACE_RPOM","ACE_RSHG1","BAF_NLAW_LAUNCHER"
];

};


if (GR_A) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"M79_EP1","MK13_EP1",
"ACE_AEK_971_GP_1P63","ACE_AEK_971_GP","ACE_AEK_973S_GP_1P63","ACE_AEK_973S_GP","ACE_AK103_GL","ACE_AK103_GL_1P29","ACE_AK103_GL_Kobra","ACE_AK103_GL_PSO",
"AK_107_GL_KOBRA","AK_107_GL_PSO","AK_74_GL","AK_74_GL_KOBRA","ACE_AK74M_GL","ACE_AK74M_GL_1P78","ACE_AK74M_GL_TWS","ACE_AK74M_GL_KOBRA","ACE_AK74M_GL_NSPU",
"ACE_AK74M_GL_PSO","ACE_AK74M_GL_1P29","ACE_AKM_GL","ACE_AKS74P_GL","ACE_AKS74P_GL_1P29","ACE_AKS74P_GL_KOBRA","ACE_AKS74P_GL_PSO","ACE_G36A1_AG36_UP_F","ACE_G36A1_AG36A1",
"ACE_G36A1_AG36A1_D_F","ACE_G36A1_AG36A1_D_UP_F","ACE_G36A1_AG36A1_D","ACE_G36A1_AG36A1_F","ACE_G36A1_AG36A1_UP","ACE_G36A1_AG36A1_D_UP","ACE_HK416_D10_M320","ACE_HK416_D10_M320_UP",
"ACE_HK416_D14_COMPM3_M320","ACE_HK416_D14_COMPM3_M320_UP","BAF_L85A2_UGL_ACOG","BAF_L85A2_UGL_HOLO","BAF_L85A2_UGL_SUSAT","M16A2GL","ACE_M16A2GL_SCOPE","ACE_M16A2GL_SCOPE_UP","ACE_M16A2GL_UP",
"ACE_M16A4_EOT_GL","ACE_M16A4_EOT_GL_UP","M16A4_GL","ACE_M16A4_CCO_GL","ACE_M16A4_CCO_GL_UP","M16A4_ACG_GL","ACE_M16A4_ACG_GL_UP","ACE_M16A4_GL_UP","ACE_M4_GL","ACE_M4_AIM_GL","ACE_M4_AIM_GL_F",
"ACE_M4_AIM_GL_UP","ACE_M4_AIM_GL_UP_F","ACE_M4_GL_F","ACE_M4_EOTECH_GL","ACE_M4_EOTECH_GL_F","ACE_M4_EOTECH_GL_UP","ACE_M4_EOTECH_GL_UP_F","ACE_M4_RCO_GL","ACE_M4_RCO_GL_F","ACE_M4_RCO_GL_UP",
"ACE_M4_RCO_GL_UP_F","ACE_M4_GL_UP","ACE_M4_GL_UP_F","ACE_M4A1_GL_SD_F","ACE_M4A1_GL_SD_UP","ACE_M4A1_GL_SD_UP_F","ACE_SOC_M4A1_GL_UP","M4A1_HWS_GL","ACE_M4A1_GL","ACE_M4A1_AIM_GL","ACE_M4A1_AIM_GL_F",
"ACE_M4A1_AIM_GL_SD","ACE_M4A1_AIM_GL_SD_F","ACE_M4A1_AIM_GL_SD_UP","ACE_M4A1_AIM_GL_SD_UP_F","ACE_M4A1_GL_F","M4A1_HWS_GL_CAMO","ACE_M4A1_HWS_GL_CAMO_UP","ACE_M4A1_HWS_GL_F","M4A1_HWS_GL_SD_CAMO",
"ACE_M4A1_HWS_GL_SD_CAMO_UP","ACE_SOC_M4A1_GL_EOTECH","ACE_M4A1_HWS_GL_UP","ACE_M4A1_HWS_GL_UP_F","ACE_SOC_M4A1_GL_AIMPOINT","M4A1_RCO_GL","ACE_M4A1_RCO_GL","ACE_SOC_M4A1_RCO_GL_F","ACE_SOC_M4A1_RCO_GL",
"ACE_SOC_M4A1_RCO_GL_UP_F","ACE_SOC_M4A1_RCO_GL_UP","ACE_M4A1_RCO2_GL","ACE_M4A1_RCO2_GL_F","ACE_M4A1_RCO2_GL_UP","ACE_M4A1_RCO2_GL_UP_F","ACE_M4A1_GL_SD","ACE_SOC_M4A1_GL_SD_F","ACE_SOC_M4A1_GL_SD",
"ACE_SOC_M4A1_GL_SD_UP_F","ACE_SOC_M4A1_GL_SD_UP","ACE_SOC_M4A1_GL","ACE_SOC_M4A1_GL_13","ACE_M4A1_GL_UP","ACE_M4A1_GL_UP_F","M4A3_RCO_GL_EP1","M8_CARBINEGL","SCAR_L_CQC_EGLM_HOLO","SCAR_L_STD_EGLM_RCO",
"SCAR_L_STD_EGLM_TWS","SCAR_H_STD_EGLM_SPECT","RH_HK416GL","RH_HK416GLAIM","RH_HK416GLACOG","RH_HK416GLAEOTECH","RH_HK416SDGL","RH_HK416SDGLAIM","RH_HK416SDGLEOTECH","RH_HK416SGL",
"RH_HK416SGLAIM","RH_HK416SGLEOTECH","RH_HK416SGLACOG","RH_HK417SGL","RH_HK417SGLAIM","RH_HK417SGLACOG","RH_HK417SGLEOTECH","RH_ACRGL","RH_ACRGLACOG","RH_ACRGLAIM","RH_ACRGLEOTECH","RH_ACRBGL",
"RH_ACRBGLACOG","RH_ACRBGLAIM","RH_ACRBGLEOTECH","RH_CTAR21GLACOG","RH_CTAR21MGL","CZ805_A1_GL_ACR","CZ805_B_GL_ACR",

"RH_M4GL","RH_M4GLAIM","RH_M4GLACOG","RH_M4GLAEOTECH","RH_M4SDGL","RH_M4SDGLAIM","RH_M4SDGLACOG","RH_M4SDGLEOTECH","RH_M4GLEOTECH_WDL","RH_M4SDGLEOTECH_WDL","RH_M16A1GL","RH_M16A1SGL","RH_M16A2GL",
"RH_M16A2GLAIM","RH_M16A2SGL","HZ_M16A3RAS_CCO_GL","HZ_M16A3RAS_EOT_GL","HZ_M16A3RAS_RCO_GL","RH_M16A4GL","RH_M16A4GLACOG","RH_M16A4GLAIM","RH_M16A4GLEOTECH","RH_M16A3GL","RH_M16A3SGL",

"RH_MP5A5EODAIM","RH_MP5A5EODEOT","RH_MP5A5EODRFX","RH_MP5A5EOD"
];

};

if (GR) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"M32_EP1","GMS_K98_RG"

];

};

if (DM_A) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"ACE_G3SG1","M4SPR","HUNTINGRIFLE","SVD","SVD_NSPU_EP1","SCAR_H_LNG_SNIPER_SD"
];

};

if (DM) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"ACE_HK417_LEUPOLD","ACE_M4SPR_SD","ACE_MK12MOD1","ACE_MK12MOD1_SD","SCAR_H_LNG_SNIPER","SCAR_H_STD_TWS_SD","ACE_M110","M110_NVG_EP1","ACE_M110_SD","ACE_SVD_BIPOD","RH_HK417SDSP","RH_HK417SP",
"TMTR_HK33_LEU","RH_M21","RH_SC2SP","RH_M1SSP","RH_M1STSP","DMR","RH_MK12","RH_MK12SD","RH_MK12MOD1","RH_MK12MOD1SD"
];

};

if (MED_A) then {

 [] spawn {
        
    waituntil {sleep 0.1; !isnull player};    
    
    //player should be able to use medical equipment even if not in medic slot (if CMS is already active), but don't global activate CMS if not in medic slot.
    player setvariable["cms_medicClass",true];
    
    //also make sure medics are able to interact with AI using ACE wounds
    player setvariable ["ace_w_ismedic",true];
   
};

Hz_client_allowed_weps = Hz_client_allowed_weps + ["CMS_FIRSTAIDKIT","ACE_VTAC_RUSH72_FT_MEDIC","ACE_VTAC_RUSH72_TT_MEDIC"];
       
};

if (MED) then {

};

if (MG_A) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"ACE_G36A2_BIPOD","ACE_G36A2_BIPOD_D","BAF_L86A2_ACOG","ACE_M27_IAR","ACE_M27_IAR_CCO","ACE_M27_IAR_ACOG","RPK_74","ACE_RPK","ACE_RPK74M","ACE_RPK74M","ACE_RPK74M_1P29","ACE_SPAREBARREL","M8_SHARPSHOOTER",
"BAF_L110A1_AIM","ACE_M249_AIM","M249_M145_EP1","ACE_M249_PIP_ACOG","M249_EP1","M249","M249_TWS_EP1"
];

};

if (MG) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"BAF_L7A2_GPMG","ACE_BAF_L7A2_GPMG","ACE_M240B","M240","M240_SCOPED_EP1","ACE_M240L","ACE_M240L_M145","ACE_M60","M60A4_EP1","MK_48_DES_EP1","MK_48","PK","PECHENEG",
"M8_SAW","ACE_MG36","ACE_MG36_D","MG36","MG36_CAMO","RH_MK48MOD1","RH_MK48MOD1ACOG","RH_MK48MOD1ELCAN",
"RH_M249P","RH_M249PACOG","RH_M249PELCAN","RH_M249","RH_M249ACOG","RH_M249ELCAN","BWMOD_MG3"
];

};

if (AA_A) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"STRELA"
];

};

if (AA) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"IGLA","STINGER"
];

};


//Other roles

if (FAC) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"ACE_SOFLAMTRIPOD","LASERDESIGNATOR"
];

};

if (PARA) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"ACE_PARACHUTEPACK"
];

};

if (ARTY) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"ACE_ARTY_AIMINGPOST_M1A2_M58","ACE_ARTY_AIMINGPOST_M1A2_M59","ACE_ARTY_M1A1_COLLIMATOR"
];

};

if (SNIPER_A) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"BAF_LRR_SCOPED_W","BAF_LRR_SCOPED","KSVK","M24","M24_DES_EP1","M40A3","SVD_DES_EP1","SVD_CAMO","GMS_K98ZF39"
];

};

if (SNIPER) then {

Hz_client_allowed_weps = Hz_client_allowed_weps + [
"ACE_AS50","BAF_AS50_SCOPED","PMC_AS50_SCOPED","BAF_AS50_TWS","PMC_AS50_TWS","M107","M107_TWS_EP1","ACE_M109","ACE_TAC50","ACE_TAC50_SD","VSS_VINTOREZ"
];

};

if (H_P) then {
Hz_restricted_vehs = Hz_restricted_vehs - 
["USEC_BELL206_1","USEC_BELL206_3","POOK_H13_AMPHIB_UNO","POOK_H13_AMPHIB_PMC","POOK_H13_AMPHIB_CIV"];
};

if (P_P) then {
Hz_restricted_vehs = Hz_restricted_vehs - 
["GNT_C185E","GNT_C185F","GNT_C185U","GNT_C185","GNT_C185R","GNT_C185C","AN2_2_TK_CIV_EP1"];
};

Hz_roles_initdone = true;










