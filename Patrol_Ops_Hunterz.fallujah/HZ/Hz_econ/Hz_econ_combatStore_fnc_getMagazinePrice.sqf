private ["_return","_magazine"];

_magazine = toupper _this;

_return = switch (_magazine) do {
    		
//disposeable anti-tank

//M72A2
case "HAFM_M72_ROCKET": {0};

//AT-4s
case "RHS_M136_MAG": {0};

/*

case "RHS_M136_HEDP_MAG": {0};
case "RHS_M136_HP_MAG": {0};

//M72
case "RHS_M72A7_MAG": {0};

//RSHG2
case "RHS_RSHG2_MAG": {0};

//RPG26
case "RHS_RPG26_MAG": {0};

//anti-tank 
//SMAW
case "RHS_MAG_SMAW_HEAA": {235};
case "RHS_MAG_SMAW_HEDP": {185};
case "RHS_MAG_SMAW_SR": {38};

//MAAWS
case "RHS_MAG_MAAWS_HE": {145};
case "RHS_MAG_MAAWS_HEDP": {190};
case "RHS_MAG_MAAWS_HEAT": {410};

*/

//RPG7
case "RHS_RPG7_PG7V_MAG": {90};
case "RHS_RPG7_PG7VL_MAG": {140};

/*

case "RHS_RPG7_PG7VR_MAG": {250};
case "RHS_RPG7_OG7V_MAG": {40};
case "RHS_RPG7_TBG7V_MAG": {320}; 
case "RHS_RPG7_TYPE69_AIRBURST_MAG": {92};



//anti-air
//igla
case "RHS_MAG_9K38_ROCKET": {139500};

//stinger
case "RHS_FIM92_MAG": {183300};

//strela
case "ACE_PRELOADEDMISSILEDUMMY_STRELA_2_CUP": {45000};

//46x30
case "RHSUSF_MAG_40RND_46X30_AP": {87};
case "RHSUSF_MAG_40RND_46X30_JHP": {87};
case "RHSUSF_MAG_40RND_46X30_FMJ": {87};



//545x39
case "RHS_30RND_545X39_AK": {18};

*/

case "RHS_30RND_545X39_AK_NO_TRACERS": {18};

case "HLC_30RND_545X39_EP_AK": {18};
case "HLC_30RND_545X39_B_AK": {18};
case "HLC_45RND_545X39_M_RPK": {60};
case "HLC_60RND_545X39_T_RPK": {60};
case "HLC_30RND_545X39_S_AK": {18};
case "HLC_30RND_545X39_T_AK": {18};
case "HLC_45RND_545X39_T_RPK": {60};

case "CUP_45RND_TE4_LRT4_GREEN_TRACER_545X39_RPK_M": {60};
case "CUP_30RND_TE1_GREEN_TRACER_545X39_AK_M": {18};
case "CUP_30RND_545X39_AK_M": {18};
case "CUP_30RND_TE1_RED_TRACER_545X39_AK_M": {18};
case "CUP_30RND_TE1_WHITE_TRACER_545X39_AK_M": {18};
case "CUP_30RND_TE1_YELLOW_TRACER_545X39_AK_M": {18};
case "CUP_75RND_TE4_LRT4_GREEN_TRACER_545X39_RPK_M": {60};

/*

case "RHS_30RND_545X39_7N6_AK": {18};
case "RHS_30RND_545X39_7N10_AK": {18};
case "RHS_30RND_545X39_7N22_AK": {18};
case "RHS_30RND_545X39_AK_GREEN": {18};
case "RHS_30RND_545X39_7U1_AK": {18};
case "RHS_45RND_545X39_AK": {60};
case "RHS_45RND_545X39_7N6_AK": {60};
case "RHS_45RND_545X39_7N10_AK": {60};
case "RHS_45RND_545X39_7N22_AK": {60};
case "RHS_45RND_545X39_AK_GREEN": {60};
case "RHS_45RND_545X39_7U1_AK": {60};

*/

//.22 LR
case "CUP_5X_22_LR_17_HMR_M": {0};
case "RH_10RND_22LR_MK2": {-1};

//556x45

/*

// BIS STANAGs...

case "30RND_556X45_STANAG_TRACER_YELLOW": {20};
case "30RND_556X45_STANAG_TRACER_GREEN": {20};
case "30RND_556X45_STANAG_TRACER_RED": {20};
case "30RND_556X45_STANAG": {20};

*/

case "RHS_MAG_30RND_556X45_M855_STANAG": {20};

/*

case "RHS_MAG_30RND_556X45_M200_STANAG": {20};
case "RHS_MAG_30RND_556X45_M855A1_STANAG_TRACER_ORANGE": {20};
case "RHS_MAG_30RND_556X45_M855A1_STANAG_TRACER_YELLOW": {20};
case "RHS_MAG_30RND_556X45_M855A1_STANAG_TRACER_GREEN": {20};
case "RHS_MAG_30RND_556X45_M855A1_STANAG_TRACER_RED": {20};
case "RHS_MAG_30RND_556X45_M855A1_STANAG_NO_TRACER": {20};
case "RHS_MAG_30RND_556X45_M855A1_STANAG":{20};
case "RHS_MAG_30RND_556X45_MK262_STANAG": {20};
case "RHS_MAG_30RND_556X45_MK318_STANAG": {20};

case "RHSUSF_100RND_556X45_M200_SOFT_POUCH": {25};
case "RHSUSF_200RND_556X45_SOFT_POUCH": {25};
case "RHSUSF_100RND_556X45_SOFT_POUCH": {25};
case "RHS_200RND_556X45_T_SAW": {150};
case "RHS_200RND_556X45_B_SAW": {150};
case "RHS_200RND_556X45_M_SAW": {150};

case "RH_30RND_556X45_M855A1": {20};
case "RH_30RND_556X45_MK262": {20};
case "RH_30RND_556X45_MK318": {20};
case "RH_20RND_556X45_M855A1": {12};
case "RH_20RND_556X45_MK262": {12};
case "RH_20RND_556X45_MK318": {12};
case "RH_60RND_556X45_M855A1": {149};
case "RH_60RND_556X45_MK262": {149};
case "RH_60RND_556X45_MK318": {149};

case "RHSSAF_100RND_556X45_EPR_G36": {-1};
case "150RND_556X45_DRUM_MAG_TRACER_F": {-1};
case "150RND_556X45_DRUM_MAG_F": {-1};
case "RHSSAF_30RND_556X45_TDIM_G36": {50};
case "RHSSAF_30RND_556X45_EPR_G36": {50};
case "RHSSAF_30RND_556X45_MDIM_G36": {50};
case "RHSSAF_30RND_556X45_TRACERS_G36": {50};
case "RHSSAF_30RND_556X45_SPR_G36": {50};
case "RHSSAF_30RND_556X45_SOST_G36": {50};
*/
case "RHSGREF_30RND_556X45_M21": {11};
case "RHSGREF_30RND_556X45_M21_T": {11};

//762x25
case "RHS_MAG_762X25_8": {15};

//.300 blk

/*

case "RH_30RND_762X35_FMJ": {11};
case "RH_30RND_762X35_MATCH": {11};
case "RH_30RND_762X35_MSB": {11};
*/


//762x39
case "RHS_30RND_762X39MM": {90};

case "HLC_30RND_762X39_AP_AK": {16};
case "HLC_45RND_762X39_AP_RPK": {60};
case "HLC_75RND_762X39_AP_RPK": {60};
case "HLC_30RND_762X39_B_AK": {16};
case "HLC_45RND_762X39_M_RPK": {60};
case "HLC_75RND_762X39_M_RPK": {60};
case "HLC_30RND_762X39_S_AK": {16};
case "HLC_30RND_762X39_T_AK": {16};
case "HLC_45RND_762X39_T_RPK": {60};

case "RHS_30RND_762X39MM_SAVZ58": {25};
case "RHS_30RND_762X39MM_SAVZ58_TRACER": {25};

case "10RND_SKS_MAG": {6};
case "100RND_KOROB_RPD": {60};

/*

case "RHS_30RND_762X39MM_TRACER": {90};
case "RHS_30RND_762X39MM_89": {90}; 
case "RHS_30RND_762X39MM_U": {90};

*/

/*

//762x51
case "RHSUSF_20RND_762X51_M118_SPECIAL_MAG": {25};

*/

case "RHSUSF_20RND_762X51_M62_MAG": {25};

/*

case "RHSUSF_20RND_762X51_M993_MAG": {25};

case "RHSUSF_5RND_762X51_M62_MAG": {0};
case "RHSUSF_5RND_762X51_M993_MAG": {0};
case "RHSUSF_5RND_762X51_M118_SPECIAL_MAG": {0};

case "RHSUSF_10RND_762X51_M62_MAG": {25};
case "RHSUSF_10RND_762X51_M993_MAG": {25};
case "RHSUSF_10RND_762X51_M118_SPECIAL_MAG": {25};

case "RHSUSF_100RND_762X51_M993": {125};
case "RHSUSF_100RND_762X51_M82_BLANK": {125};
case "RHSUSF_100RND_762X51_M80A1EPR": {125};
case "RHSUSF_100RND_762X51_M62_TRACER": {125};
case "RHSUSF_100RND_762X51_M61_AP": {125};
case "RHSUSF_100RND_762X51": {125};
case "RHSUSF_50RND_762X51_M993": {75};
case "RHSUSF_50RND_762X51_M82_BLANK": {75};
case "RHSUSF_50RND_762X51_M80A1EPR": {75};
case "RHSUSF_50RND_762X51_M62_TRACER": {75};
case "RHSUSF_50RND_762X51_M61_AP": {75};
case "RHSUSF_50RND_762X51":{75};


case "RH_20RND_762X51_AR10": {22};

case "RH_20Rnd_762x51_M80A1": {79};
case "RH_20Rnd_762x51_Mk316LR": {79};
case "RH_20Rnd_762x51_LFMJSB": {79};

*/

//762x54
case "RHS_100RND_762X54MMR": {40};

/*

case "RHS_100RND_762X54MMR_GREEN": {40};
case "RHS_100RND_762X54MMR_7N13": {40};
case "RHS_100RND_762X54MMR_7N26": {40};
case "RHS_100RND_762X54MMR_7BZ3": {40};

case "RHS_10RND_762X54MMR_7N1": {100};

*/
case "CUP_50RND_UK59_762X54R_TRACER": {-1};
case "CUP_10RND_762X54_SVD_M": {50};


//7.7mm
case "LOP_10RND_77MM_MAG": {10};

//7.92x57
case "RHSGREF_5RND_792X57_KAR98K": {5};
case "RHSGREF_10RND_792X57_M76": {4};
case "RHSSAF_10RND_792X57_M76_TRACER": {4};

//.300WM
/*
case "RHSUSF_5RND_300WINMAG_XM2010": {90};
*/

/*
//.338 lap
case "RHS_5RND_338LAPUA_T5000": {150};

//9x19
case "RHS_MAG_9X19MM_7N21_20": {20};
case "RHS_MAG_9X19MM_7N31_20": {20};
case "RHS_MAG_9X19MM_7N21_44": {30};
case "RHS_MAG_9X19MM_7N31_44": {30};

*/

case "RHSUSF_MAG_17RND_9X19_FMJ": {30};
case "RHSUSF_MAG_17RND_9X19_JHP": {30};
case "RHSUSF_MAG_7X45ACP_MHP": {40};
case "RHSUSF_MAG_15RND_9X19_FMJ": {40};
case "RHSUSF_MAG_15RND_9X19_JHP": {40};

case "CUP_10RND_9X19_COMPACT": {38};
case "CUP_18RND_9X19_PHANTOM": {56};

case "RH_15RND_9X19_M9": {40};
case "RH_16RND_9X19_CZ": {-1};
case "RH_17RND_9X19_G17": {34};
case "RH_33RND_9X19_G18": {58};
case "RH_19RND_9X19_G18": {30};
case "RH_18RND_9X19_GSH": {-1};
case "RH_32RND_9X19_TEC": {-1};
case "RH_30RND_9X19_UZI": {22};
case "RH_15RND_9X19_SIG": {46};
case "RH_14RND_9X19_SW": {-1};
case "RH_18RND_9X19_VP": {-1};
case "RH_32RND_9MM_M822": {19};

/*

case "RH_32RND_9MM_HP": {19};
case "RH_32RND_9MM_HPSB": {19};

*/
//9x21
case "16RND_9X21_GREEN_MAG": {53};
case "16RND_9X21_RED_MAG": {53};
case "16RND_9X21_YELLOW_MAG": {53};
case "16RND_9X21_MAG": {53};


//9x39
/*

case "RHS_20RND_9X39MM_SP5": {12};
case "RHS_20RND_9X39MM_SP6": {12};
case "RHS_10RND_9X39MM_SP5": {10};
case "RHS_10RND_9X39MM_SP6": {10};

//.45 acp
*/
case "RH_7RND_45CAL_M1911": {40};
case "RH_12RND_45CAL_USP": {-1};
case "RH_15RND_45CAL_FNP": {-1};
case "RH_6RND_45ACP_MAG": {6};
/*

//.50 ae
case "RH_7RND_50_AE": {-1};


//.50 BMG
case "RHSUSF_MAG_10RND_STD_50BMG_MK211": {170};
case "RHSUSF_MAG_10RND_STD_50BMG_M33": {170};

//12 ga


case "RHSUSF_5RND_FRAG": {0};
case "RHSUSF_5RND_HE": {0};

*/

case "RHSUSF_5RND_SLUG": {0};
case "RHSUSF_5RND_DOOMSDAY_BUCK": {-1};
case "RHSUSF_5RND_00BUCK": {0};
case "RHSGREF_1RND_00BUCK": {0};
case "RHSGREF_1RND_SLUG": {0};

/*

case "RHSUSF_8RND_FRAG": {0};
case "RHSUSF_8RND_HE": {0};

*/


case "RHSUSF_8RND_SLUG": {0};
case "RHSUSF_8RND_DOOMSDAY_BUCK": {-1};
case "RHSUSF_8RND_00BUCK": {0};

//40mm

/*

case "RHSUSF_MAG_6RND_M716_YELLOW": {0};
case "RHSUSF_MAG_6RND_M715_GREEN": {0};
case "RHSUSF_MAG_6RND_M714_WHITE": {0};
case "RHSUSF_MAG_6RND_M713_RED": {0};
case "RHSUSF_MAG_6RND_M662_RED": {0};
case "RHSUSF_MAG_6RND_M661_GREEN": {0};
case "RHSUSF_MAG_6RND_M585_WHITE": {0};
case "RHSUSF_MAG_6RND_M4009": {0};
case "RHSUSF_MAG_6RND_M781_PRACTICE": {0};
case "RHSUSF_MAG_6RND_M576_BUCKSHOT": {0};
case "RHSUSF_MAG_6RND_M397_HET": {0};
case "RHSUSF_MAG_6RND_M433_HEDP": {0};
case "RHSUSF_MAG_6RND_M441_HE": {0};

case "ACE_HUNTIR_M203": {400};

*/

case "RHS_MAG_M441_HE": {15};

/*

case "RHS_MAG_M433_HEDP": {20};

*/

case "RHS_MAG_M781_PRACTICE": {10};

/*

case "RHS_MAG_M397_HET": {55};
case "RHS_MAG_M4009": {30};
case "RHS_MAG_M576": {15};

*/

case "RHS_MAG_M585_WHITE": {15};
case "RHS_MAG_M661_GREEN": {15};
case "RHS_MAG_M662_RED": {15};
case "RHS_MAG_M713_RED": {10};
case "RHS_MAG_M714_WHITE": {10};
case "RHS_MAG_M715_GREEN": {10};
case "RHS_MAG_M716_YELLOW": {10};

//various non standardized mags
case "RH_20Rnd_57x28_FN": {-1};
case "RH_20RND_32CAL_VZ61": {25};
case "RH_6RND_357_MAG": {6};
case "RH_16RND_40CAL_USP": {-1};
case "RH_6RND_44_MAG": {6};
case "RH_6RND_454_MAG": {6};
case "RHSGREF_20RND_765X17_VZ61": {25};
case "RHSGREF_10RND_765X17_VZ61": {10};

//Throwables
/*

case  "ACE_M14": {58};
case  "RHS_MAG_AN_M14_TH3": {58};

*/

case  "RHS_MAG_AN_M8HC": {52};
case  "CHEMLIGHT_BLUE": {1};
case  "CHEMLIGHT_GREEN": {1};
case  "ACE_CHEMLIGHT_HIORANGE": {1};
case  "ACE_CHEMLIGHT_HIRED": {1};
case  "ACE_CHEMLIGHT_HIWHITE": {1};
case  "ACE_CHEMLIGHT_HIYELLOW": {1};
case  "ACE_CHEMLIGHT_IR": {2};
case  "ACE_CHEMLIGHT_ORANGE": {1};
case  "CHEMLIGHT_RED": {1};
case  "ACE_CHEMLIGHT_WHITE": {1};
case  "CHEMLIGHT_YELLOW": {1};

/*

case  "RHS_MAG_FAKEL": {40};
case  "RHS_MAG_FAKELS": {45};
case  "I_IR_GRENADE": {200};
case  "O_IR_GRENADE": {200};
case  "B_IR_GRENADE": {200};

*/

case  "ACE_HANDFLARE_GREEN": {60};
case  "ACE_HANDFLARE_RED": {60};
case  "ACE_HANDFLARE_WHITE": {60};
case  "ACE_HANDFLARE_YELLOW": {60};
case  "RHS_MAG_M18_GREEN": {52};
case  "RHS_MAG_M18_PURPLE": {52};
case  "RHS_MAG_M18_RED": {52};
case  "SMOKESHELLBLUE": {52};
case  "SMOKESHELLGREEN": {52};
case  "SMOKESHELLORANGE": {52};
case  "SMOKESHELLPURPLE": {52};
case  "SMOKESHELLRED": {52};
case  "SMOKESHELLYELLOW": {52};
case  "HANDGRENADE": {34};
case  "RHS_MAG_M18_YELLOW": {52};
case  "RHS_MAG_M67": {34};

/*

case  "RHS_MAG_M69": {-1};
case  "RHS_MAG_M7A3_CS": {213};
case  "SMOKESHELL": {52};
case  "RHS_MAG_MK84": {175};
case  "ACE_M84": {175};
case  "RHS_MAG_MK3A2": {50};
case  "RHS_MAG_NSPD": {20};
case  "RHS_MAG_NSPN_GREEN": {21};
case  "RHS_MAG_NSPN_RED": {21};
case  "RHS_MAG_NSPN_YELLOW": {21};
case  "RHS_MAG_PLAMYAM": {21};
case  "RHS_MAG_RDG2_BLACK": {20};
case  "RHS_MAG_RDG2_WHITE": {20};
case  "RHS_MAG_RGD5": {38};
case  "RHS_MAG_RGN": {30};
case  "MINIGRENADE": {34};
case  "RHS_MAG_RGO": {32};
case  "RHS_MAG_ZARYA2": {22};

*/

//Explosives
/*

case  "APERSMINEDISPENSER_MAG": {250};

*/

case  "IEDLANDBIG_REMOTE_MAG": {100};
case  "IEDURBANBIG_REMOTE_MAG": {70};

/*

case  "RHSUSF_M112_MAG": {110};
case  "DEMOCHARGE_REMOTE_MAG": {220};
case  "RHSUSF_M112X4_MAG": {440};
case  "RHSUSF_MINE_M14_MAG": {58};
case  "ATMINE_RANGE_MAG": {60};
case  "SATCHELCHARGE_REMOTE_MAG": {200}; //m183
case  "CLAYMOREDIRECTIONALMINE_REMOTE_MAG": {119};
case  "RHS_MINE_M19_MAG": {170}; 
case  "APERSBOUNDINGMINE_RANGE_MAG": {115}; //m26 bounding
case  "SLAMDIRECTIONALMINE_WIRE_MAG": {200};//m4a1 slam
case  "RHS_MAG_MINE_PFM1": {115}; 
case  "RHS_MINE_PMN2_MAG": {225};
case  "APERSTRIPMINE_WIRE_MAG": {220}; //pmr3
case  "RHS_MAG_MINE_PTM1": {120};

*/

case  "IEDLANDSMALL_REMOTE_MAG": {70};
case  "IEDURBANSMALL_REMOTE_MAG": {40};

/*

case  "RHS_MINE_TM62M_MAG": {120};
case  "TRAININGMINE_MAG": {250};
case  "APERSMINE_RANGE_MAG": {200};  //vs50

*/

case  "ACE_FLARETRIPMINE_MAG": {20};

/*

case "LASERBATTERIES": {120};

*/

//cigs
case "MURSHUN_CIGS_CIGPACK": {6};
case "IMMERSION_POPS_POPPACK": {1};
case "MURSHUN_CIGS_LIGHTER": {30};
case "MURSHUN_CIGS_MATCHES": {1};







default {-1};

};

_return