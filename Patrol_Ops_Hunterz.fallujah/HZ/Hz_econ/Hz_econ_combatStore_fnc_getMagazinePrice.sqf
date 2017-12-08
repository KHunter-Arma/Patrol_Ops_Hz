private ["_return","_magazine"];

_magazine = toupper _this;

_return = switch (_magazine) do {
    		
//disposeable anti-tank
//AT-4s
case "RHS_M136_MAG": {0};
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

//RPG7
case "RHS_RPG7_PG7V_MAG": {90};
case "RHS_RPG7_PG7VL_MAG": {140};
case "RHS_RPG7_PG7VR_MAG": {250};
case "RHS_RPG7_OG7V_MAG": {40};
case "RHS_RPG7_TBG7V_MAG": {320}; 
case "RHS_RPG7_TYPE69_AIRBURST_MAG": {92};

//anti-air
//igla
case "RHS_MAG_9K38_ROCKET": {139500};

//stinger
case "RHS_FIM92_MAG": {183300};

//46x30
case "RHSUSF_MAG_40RND_46X30_AP": {87};
case "RHSUSF_MAG_40RND_46X30_JHP": {87};
case "RHSUSF_MAG_40RND_46X30_FMJ": {87};

//545x39
case "RHS_30RND_545X39_AK": {18};
case "RHS_30RND_545X39_AK_NO_TRACERS": {18};
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

//556x45
case "30RND_556X45_STANAG_TRACER_YELLOW": {20};
case "30RND_556X45_STANAG_TRACER_GREEN": {20};
case "30RND_556X45_STANAG_TRACER_RED": {20};
case "30RND_556X45_STANAG": {20};
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
case "RH_20RND_556X45_M855A1": {-1};
case "RH_20RND_556X45_MK262": {-1};
case "RH_20RND_556X45_MK318": {-1};
case "RH_60RND_556X45_M855A1": {-1};
case "RH_60RND_556X45_MK262": {-1};
case "RH_60RND_556X45_MK318": {-1};

//762x39
case "RHS_30RND_762X39MM": {90};
case "RHS_30RND_762X39MM_TRACER": {90};
case "RHS_30RND_762X39MM_89": {90}; 
case "RHS_30RND_762X39MM_U": {90};

//762x51
case "RHSUSF_20RND_762X51_M118_SPECIAL_MAG": {25};
case "RHSUSF_20RND_762X51_M62_MAG": {25};
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
case "RH_20Rnd_762x51_LFMJSB": {-1};

//762x54
case "RHS_100RND_762X54MMR": {40};
case "RHS_100RND_762X54MMR_GREEN": {40};
case "RHS_100RND_762X54MMR_7N13": {40};
case "RHS_100RND_762X54MMR_7N26": {40};
case "RHS_100RND_762X54MMR_7BZ3": {40};

case "RHS_10RND_762X54MMR_7N1": {100};

//.300 blk
case "RH_30RND_762X35_FMJ": {11};
case "RH_30RND_762X35_MATCH": {11};
case "RH_30RND_762X35_MSB": {11};

//.300WM
case "RHSUSF_5RND_300WINMAG_XM2010": {90};

//.338 lap
case "RHS_5RND_338LAPUA_T5000": {150};

//9x19
case "RHS_MAG_9X19MM_7N21_20": {20};
case "RHS_MAG_9X19MM_7N31_20": {20};
case "RHS_MAG_9X19MM_7N21_44": {30};
case "RHS_MAG_9X19MM_7N31_44": {30};

case "RH_32RND_9MM_M822": {-1};
case "RH_32RND_9MM_HP": {-1};
case "RH_32RND_9MM_HPSB": {-1};

//9x39
case "RHS_20RND_9X39MM_SP5": {12};
case "RHS_20RND_9X39MM_SP6": {12};
case "RHS_10RND_9X39MM_SP5": {10};
case "RHS_10RND_9X39MM_SP6": {10};

//.50 BMG
case "RHSUSF_MAG_10RND_STD_50BMG_MK211": {170};
case "RHSUSF_MAG_10RND_STD_50BMG_M33": {170};

//12 ga
case "RHSUSF_5RND_FRAG": {0};
case "RHSUSF_5RND_HE": {0};
case "RHSUSF_5RND_SLUG": {0};
case "RHSUSF_5RND_DOOMSDAY_BUCK": {0};
case "RHSUSF_5RND_00BUCK": {0};

case "RHSUSF_8RND_FRAG": {0};
case "RHSUSF_8RND_HE": {0};
case "RHSUSF_8RND_SLUG": {0};
case "RHSUSF_8RND_DOOMSDAY_BUCK": {0};
case "RHSUSF_8RND_00BUCK": {0};

//40mm
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
case "RHS_MAG_M441_HE": {15};
case "RHS_MAG_M433_HEDP": {20};
case "RHS_MAG_M781_PRACTICE": {10};
case "RHS_MAG_M397_HET": {55};
case "RHS_MAG_M4009": {30};
case "RHS_MAG_M576": {15};
case "RHS_MAG_M585_WHITE": {15};
case "RHS_MAG_M661_GREEN": {15};
case "RHS_MAG_M662_RED": {15};
case "RHS_MAG_M713_RED": {10};
case "RHS_MAG_M714_WHITE": {10};
case "RHS_MAG_M715_GREEN": {10};
case "RHS_MAG_M716_YELLOW": {10};

//Throwables
case  "ACE_M14": {58};
case  "RHS_MAG_AN_M14_TH3": {58};
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
case  "RHS_MAG_FAKEL": {40};
case  "RHS_MAG_FAKELS": {45};
case  "I_IR_GRENADE": {200};
case  "O_IR_GRENADE": {200};
case  "B_IR_GRENADE": {200};
case  "ACE_HANDFLARE_GREEN": {-1};
case  "ACE_HANDFLARE_RED": {-1};
case  "ACE_HANDFLARE_WHITE": {-1};
case  "ACE_HANDFLARE_YELLOW": {-1};
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
case  "RHS_MAG_M69": {-4};
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

//Explosives
case  "APERSMINEDISPENSER_MAG": {250};
case  "IEDLANDBIG_REMOTE_MAG": {-1};
case  "IEDURBANBIG_REMOTE_MAG": {-1};
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
case  "IEDLANDSMALL_REMOTE_MAG": {70};
case  "IEDURBANSMALL_REMOTE_MAG": {40};
case  "RHS_MINE_TM62M_MAG": {120};
case  "TRAININGMINE_MAG": {250};
case  "APERSMINE_RANGE_MAG": {200};  //vs50
case  "ACE_FLARETRIPMINE_MAG": {-1};

case "LASERBATTERIES": {120};

//cigs
case "MURSHUN_CIGS_CIGPACK": {6};
case "IMMERSION_POPS_POPPACK": {1};
case "MURSHUN_CIGS_LIGHTER": {30};
case "MURSHUN_CIGS_MATCHES": {1};



default {-1};

};

_return