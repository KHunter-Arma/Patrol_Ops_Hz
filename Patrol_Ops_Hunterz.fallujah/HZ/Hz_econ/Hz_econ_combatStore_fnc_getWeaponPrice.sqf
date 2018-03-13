private ["_return","_weapon"];

_weapon = toupper _this;

_return = switch (_weapon) do {


//RHSUSF

/*
case "RHS_WEAP_HK416D10": {1800};
case "RHS_WEAP_HK416D10_M320": {5300};
case "RHS_WEAP_HK416D10_LMT": {1895};
case "RHS_WEAP_HK416D10_LMT_D": {1895};
case "RHS_WEAP_HK416D10_LMT_WD": {1895};
case "RHS_WEAP_HK416D145": {3100};
case "RHS_WEAP_HK416D145_D": {3100};
case "RHS_WEAP_HK416D145_D_2": {3100};
case "RHS_WEAP_HK416D145_M320": {6600};
case "RHS_WEAP_HK416D145_WD": {3100};
case "RHS_WEAP_HK416145_WD_2": {3100};
case "RHS_WEAP_M107": {12281};
case "RHS_WEAP_M107_D": {12281};
case "RHS_WEAP_M107_W": {12281};
case "RHS_WEAP_M14EBRRI": {3500};
case "RHS_WEAP_M16A4": {740};
case "RHS_WEAP_M16A4_CARRYHANDLE": {740};
case "RHS_WEAP_M16A4_CARRYHANDLE_M203": {1820};
case "RHS_WEAP_M166A4_CARRYHANDLE_PMAG": {740};
case "RHS_WEAP_M16A4_PMAG": {740};
case "RHS_WEAP_XM2010": {10000};
case "RHS_WEAP_XM2010_WD": {10000};
case "RHS_WEAP_XM2010_D": {10000};
case "RHS_WEAP_XM2010_SA": {10000};
case "RHS_WEAP_M24SWS": {2800};
case "RHS_WEAP_M24SWS_BLK": {2800};
case "RHS_WEAP_M24SWS_GHILLIE": {2800};
case "RHS_WEAP_M240B": {6000};
case "RHS_WEAP_M240B_CAP": {6000};
case "RHS_WEAP_M240G": {6600};
case "RHS_WEAP_M249": {7000};
case "RHS_WEAP_M249_PIP_L": {6500};
case "RHS_WEAP_M249_PIP_L_PARA": {7920};
case "RHS_WEAP_M249_PIP_L_VFG": {6500};
case "RHS_WEAP_M249_PIP_S": {7800};
case "RHS_WEAP_M249_PIP_S_PARA": {7900};
case "RHS_WEAP_M249_PIP_S_VFG": {7800};
case "RHS_WEAP_M249_PIP": {7000};
case "RHS_WEAP_M27IAR": {2000};
case "RHS_WEAP_M27IAR_GRIP": {2070};
*/

case "RHS_WEAP_M4": {700};
case "RHS_WEAP_M4_CARRYHANDLE": {700};
case "RHS_WEAP_M4_CARRYHANDLE_PMAG": {700};
case "RHS_WEAP_M4_CARRYHANDLE_MSTOCK": {760};
case "RHS_WEAP_M4_M203": {1780};

/*
case "RHS_WEAP_M4_M203S": {1760};
case "RHS_WEAP_M4M320": {4200};
*/

case "RHS_WEAP_M4_PMAG": {700};
case "RHS_WEAP_M4_MSTOCK":{760};

/*

case "RHS_WEAP_M40A5": {5000};
case "RHS_WEAP_M40A5_D": {5000};
case "RHS_WEAP_M40A5_WD": {5000};
case "RHS_WEAP_M4A1_CARRYHANDLE": {750};
case "RHS_WEAP_M4A1_CARRYHANDLE_M203": {1830};
case "RHS_WEAP_M4A1_CARRYHANDLE_M203S": {1810};
case "RHS_WEAP_M4A1_CARRYHANDLE_PMAG": {750};
case "RHS_WEAP_M4A1_CARRYHANDLE_MSTOCK": {810};
case "RHS_WEAP_M4A1_BLOCKII": {2200};
case "RHS_WEAP_M4A1_BLOCKII_BK": {2200};
case "RHS_WEAP_M4A1_BLOCKII_M203_BK": {3280};
case "RHS_WEAP_M4A1_BLOCKII_KAC_BK": {2500};
case "RHS_WEAP_M4A1_BLOCKII_M203": {3280};
case "RHS_WEAP_M4A1_BLOCKII_KAC": {2500};
case "RHS_WEAP_M4A1_BLOCKII_WD": {2200};
case "RHS_WEAP_M4A1_BLOCKII_M203_WD": {3280};
case "RHS_WEAP_M4A1_BLOCKII_KAC_WD": {2500};
case "RHS_WEAP_M4A1": {990};
case "RHS_WEAP_M4A1_D": {990};
case "RHS_WEAP_M4A1_M203S_D": {2070};
case "RHS_WEAP_M4A1_D_MSTOCK": {1423};
case "RHS_WEAP_M4A1_M203": {2070};
case "RHS_WEAP_M4A1_M203S": {2050};
case "RHS_WEAP_M4A1_M320": {4490};
case "RHS_WEAP_M4A1_PMAG": {990};
case "RHS_WEAP_M4A1_MSTOCK": {1423};
case "RHS_WEAP_M4A1_WD": {990};
case "RHS_WEAP_M4A1_M203S_WD": {2050};
case "RHS_WEAP_M4A1_WD_MSTOCK": {1423};

*/

case "RHS_WEAP_M590_8RD": {770};
case "RHS_WEAP_M590_5RD": {470};

/*

case "RHS_WEAP_SR25": {7000};
case "RHS_WEAP_SR25_D": {7000};
case "RHS_WEAP_SR25_EC": {2800};
case "RHS_WEAP_SR25_EC_D": {2800};
case "RHS_WEAP_SR25_EC_WD": {2800};
case "RHS_WEAP_SR25_WD": {7700};
case "RHS_WEAP_MK18": {2000};
case "RHS_WEAP_MK18_BK": {2000};
case "RHS_WEAP_MK18_KAC_BK": {2095};
case "RHS_WEAP_MK18_D": {2000};
case "RHS_WEAP_MK18_KAC_D": {2095};
case "RHS_WEAP_MK18_M320": {5500};
case "RHS_WEAP_MK18_KAC": {2095};
case "RHS_WEAP_MK18_WD": {2000};
case "RHS_WEAP_MK18_KAC_WD": {2095};
case "RHSUSF_WEAP_MP7A2": {1850};
case "RHSUSF_WEAP_MP7A2_AOR1": {1850};
case "RHSUSF_WEAP_MP7A2_DESERT": {1850};
case "RHSUSF_WEAP_MP7A2_WINTER": {1850};

*/


//disposeable anti-tank
//AT-4s

case "RHS_WEAP_M136": {1480};

/*
case "RHS_WEAP_M136_HEDP": {1500};
case "RHS_WEAP_M136_HP": {1600};

//M72
case "RHS_WEAP_M72A7": {875};

//RSHG2
case "RHS_WEAP_RSHG2": {450};

//RPG-26
case "RHS_WEAP_RPG26": {260};
	
//anti-tank
// SMAW
case "RHS_WEAP_SMAW": {13000};
case "RHS_WEAP_SMAW_GREEN": {13000};

//MAAWS
case "RHS_WEAP_MAAWS": {3585};

*/

//RPG7
case "RHS_WEAP_RPG7": {1170};

//M72A2
case "HAFM_LAW": {875};

//anti-air
//igla

/*

case "RHS_WEAP_IGLA": {5000};

//stinger
case "RHS_WEAP_FIM92": {3800};

*/

//Strela
case "CUP_LAUNCH_9K32STRELA": {12000};

//40mm launchers

/*

case "RHS_WEAP_M32": {19500};
case "RHS_WEAP_M320": {3500};

*/

//RH-M4
case "RH_M4": {700};                  
case "RH_M4_M203": {1780};             
case "RH_M4_RIS": {750};             
case "RH_M4_RIS_M203": {1830};   

/*
      
case "RH_M4_RIS_M203S": {1810}; 
case "RH_M4A1_RIS": {750};           
case "RH_M4A1_RIS_M203": {1830};       
case "RH_M4A1_RIS_M203S": {1810};
case "RH_M4SBR": {1653};
case "RH_M4SBR_G": {1653};
case "RH_M4SBR_B": {1653};

*/

case "RH_M16A1": {225};
case "RH_M16A1GL": {1805};

/*

case "RH_M16A2": {586};
case "RH_M16A2GL": {1666};
case "RH_M16A3": {700};
case "RH_M16A4": {740};
case "RH_M16A4GL": {1820};
case "RH_M16A4_M": {740};
case "RH_MK12MOD1": {3200};
case "RH_SAMR": {2520};
case "RH_M4M": {1423};
case "RH_M4M_G": {1423};
case "RH_M4M_B": {1423};
case "RH_M4_MOE": {900};
case "RH_M4_MOE_G": {900};
case "RH_M4_MOE_B": {900};
case "RH_M4A6": {-1};
case "RH_M16A6": {-1};
case "RH_HB": {2000};
case "RH_HB_B": {2000};
case "RH_HK416": {3100};
case "RH_HK416C": {1895};
case "RH_HK416S": {2900};
case "RH_M27IAR": {2070};
case "RH_AR10": {2072};              
case "RH_MK11": {7000};
case "RH_M110": {2455};
case "RH_SR25EC": {2800};
case "RH_SBR9": {1349};

*/

case "RH_M4_TG": {700};        
case "RH_M4_DES": {700};	
case "RH_M4_WDL": {700};	


/*


case "RH_M4_M203_TG": {1780};
case "RH_M4_M203_DES": {1780};	
case "RH_M4_M203_WDL": {1780};
case "RH_M4A1_RIS_TG": {750};	
case "RH_M4A1_RIS_WDL": {750};	
case "RH_M4A1_RIS_M203_TG": {1830};	
case "RH_M4A1_RIS_M203_DES": {1830};
case "RH_M4A1_RIS_M203_WDL": {1830};	
case "RH_M4_RIS_M_TG": {1423};
case "RH_M4_RIS_M_DES": {1423};	          
case "RH_M4_RIS_M_WDL": {1423};	
case "RH_M4A6_TG": {-1};
case "RH_M4A6_DES": {-1};	
case "RH_M4A6_WDL": {-1};	
case "RH_M16A4_TG": {740};	
case "RH_M16A4_DES": {740};	
case "RH_M16A4_WDL": {740};
case "RH_M16A4GL_TG": {1820};
case "RH_M16A4GL_DES": {1820};	
case "RH_M16A4GL_WDL": {1820};
case "RH_M16A4_M_TG": {830};
case "RH_M16A4_M_DES": {830};	
case "RH_M16A4_M_WDL": {830};
case "RH_HK416_TG": {3100};
case "RH_HK416_DES": {3100};
case "RH_HK416_WDL": {3100};
case "RH_HK416S_TG": {2900};
case "RH_HK416S_DES": {2900};
case "RH_HK416S_WDL": {2900};
case "RH_HK416C_TG": {1895};
case "RH_HK416C_DES": {1895};
case "RH_HK416C_WDL": {1895};
case "RH_M27IAR_TG": {2070};
case "RH_M27IAR_DES": {2070};
case "RH_M27IAR_WDL": {2070};
case "RH_M16A6_TG": {-1};
case "RH_M16A6_DES": {-1};	
case "RH_M16A6_WDL": {-1};	
case "RH_MK12MOD1_TG": {3200};	
case "RH_MK12MOD1_DES": {3200};	
case "RH_MK12MOD1_WDL": {3200};	
case "RH_SAMR_TG": {2520};
case "RH_SAMR_DES": {2520};
case "RH_SAMR_WDL": {2520};	
case "RH_SBR9_TG": {1349};
case "RH_SBR9_DES": {1349};
case "RH_SBR9_WDL": {1349};
*/

//RH Pistols
case "RH_PYTHON": {-1};
case "RH_CZ75": {-1};
case "RH_DEAGLE": {-1};
case "RH_DEAGLEG": {-1};
case "RH_DEAGLEM": {-1};
case "RH_DEAGLES": {-1};
case "RH_FN57": {-1};
case "RH_FN57_T": {-1};
case "RH_FN57_G": {-1};
case "RH_FNP45": {-1};
case "RH_FNPT": {-1};
case "RH_G17": {540};
case "RH_G18": {535};
case "RH_G19": {-1};
case "RH_G19T": {-1};
case "RH_GSH18": {-1};
case "RH_TEC9": {-1};
case "RH_KIMBER": {-1};
case "RH_KIMBER_NW": {-1};
case "RH_MATEBA": {-1};
case "RH_MUZI": {690};
case "RH_MP412": {-1};
case "RH_MK2": {-1};
case "RH_P226": {1165};
case "RH_P226S": {-1};
case "RH_SW659": {-1};
case "RH_BULL": {-1};
case "RH_BULLB": {-1};
case "RH_TTRACKER": {450};
case "RH_TTRACKER_G": {-1};
case "RH_USPM": {-1};
case "RH_USP": {-1};
case "RH_VP70": {-1};

/*
//AK's
case "RHS_WEAP_AK103": {760};
case "RHS_WEAP_AK103_1": {1200};
case "RHS_WEAP_AK103_1_NPZ": {1265};
case "RHS_WEAP_AK103_2": {1200};
case "RHS_WEAP_AK103_2_NPZ": {1265};
case "RHS_WEAP_AK103_NPZ": {825};
case "RHS_WEAP_AK103_GP25": {860};
case "RHS_WEAP_AK103_GP25_NPZ": {925};
case "RHS_WEAP_AK103_ZENITCO01": {1060};
case "RHS_WEAP_AK103_ZENITCO01_B33": {1810};

case "RHS_WEAP_AK104": {720};
case "RHS_WEAP_AK104_NPZ": {785};
case "RHS_WEAP_AK104_ZENITCO01": {1420};
case "RHS_WEAP_AK104_ZENITCO01_B33": {1770};

case "RHS_WEAP_AK105": {805};
case "RHS_WEAP_AK105_NPZ": {870};
case "RHS_WEAP_AK105_ZENITCO01": {1505};
case "RHS_WEAP_AK105_ZENITCO01_B33": {1855};

*/

case "RHS_WEAP_AK74": {870};

/*

case "RHS_WEAP_AK74_GP25": {970};
case "RHS_WEAP_AK74_3": {1020};

*/

case "RHS_WEAP_AK74_2": {870};

/*

case "RHS_WEAP_AK74M": {885};
case "RHS_WEAP_AK74M_2MAG" :{885};
case "RHS_WEAP_AK74M_2MAG_NPZ": {950};
case "RHS_WEAP_AK74M_2MAG_CAMO": {885};
case "RHS_WEAP_AK74M_NPZ": {950};
case "RHS_WEAP_AK74M_CAMO": {885};
case "RHS_WEAP_AK74M_DESERT": {885};
case "RHS_WEAP_AK74M_DESERT_NPZ": {950};
case "RHS_WEAP_AK74M_GP25": {985};
case "RHS_WEAP_AK74M_GP25_NPZ": {1050};
case "RHS_WEAP_AK74M_FULLPLUM_GP25": {1100};
case "RHS_WEAP_AK74M_FULLPLUM_GP25_NPZ": {1180};
case "RHS_WEAP_AK74M_PLUMMAG": {1000};
case "RHS_WEAP_AK74M_PLUMMAG_NPZ": {1040};
case "RHS_WEAP_AK74M_FULLPLUM": {1000};
case "RHS_WEAP_AK74M_FULLPLUM_NPZ": {1040};
case "RHS_WEAP_AK74M_ZENITCO01": {1585};
case "RHS_WEAP_AK74M_ZENITCO01_B33": {1935};
case "RHS_WEAP_AK74MR": {1060};
case "RHS_WEAP_AK74MR_GP25": {1160};

case "RHS_WEAP_AK74N": {870};
case "RHS_WEAP_AK74N_GP25": {970};
case "RHS_WEAP_AK74N_GP25_NPZ": {1035};
case "RHS_WEAP_AK74N_NPZ": {935};
case "RHS_WEAP_AK74N_2_NPZ": {1025};
case "RHS_WEAP_AK74N_2": {985};

*/

case "RHS_WEAP_AKM": {770};

/*

case "RHS_WEAP_AKM_GP25": {870};
case "RHS_WEAP_AKM_ZENITCO01_B33": {1320};
case "RHS_WEAP_AKMN": {790};
case "RHS_WEAP_AKMN_GP25": {890};
case "RHS_WEAP_AKMN_GP25_NPZ": {955};
case "RHS_WEAP_AKMN_NPZ": {855};

*/

case "RHS_WEAP_AKMS": {725};

/*

case "RHS_WEAP_AKMS_GP25": {825};

*/

case "RHS_WEAP_AKS74": {825};

/*

case "RHS_WEAP_AKS74_GP25": {925};

*/

case "RHS_WEAP_AKS74_2": {940};

/*

case "RHS_WEAP_AKS74N": {850};
case "RHS_WEAP_AKS74N_GP25": {950};
case "RHS_WEAP_AKS74N_GP25_NPZ": {1015};
case "RHS_WEAP_AKS74N_NPZ": {915};
case "RHS_WEAP_AKS74N_2_NPZ": {};
case "RHS_WEAP_AKS74N_2": {940};
case "RHS_WEAP_AKS74U": {780};
case "RHS_WEAP_AKS74UN": {780};

//AS VAL
case "RHS_WEAP_ASVAL": {2465};
case "RHS_WEAP_ASVAL_GRIP": {2490};
case "RHS_WEAP_ASVAL_GRIP_NPZ": {2465};
case "RHS_WEAP_ASVAL_NPZ": {2655};

*/

//PKs
case "RHS_WEAP_PKM": {3550};

//RPKs
case "CUP_ARIFLE_RPK74": {2065};
case "CUP_ARIFLE_RPK74_45": {2925};



/*

case "RHS_WEAP_PKP": {3595};

//PM63
case "RHS_WEAP_PM63": {550};

//PP2000
case "RHS_WEAP_PP2000": {400};

//SVDs
case "RHS_WEAP_SVDP": {5000};
case "RHS_WEAP_SVDP_WD": {5000};
case "RHS_WEAP_SVDP_WD_NPZ": {5065};
case "RHS_WEAP_SVDP_NPZ": {5065};
case "RHS_WEAP_SVDS": {4400};
case "RHS_WEAP_SVDS_NPZ": {4465};

//T5000
case "RHS_WEAP_T5000": {6600};

//Vintorez
case "RHS_WEAP_VSS": {2470};
case "RHS_WEAP_VSS_GRIP": {2495};
case "RHS_WEAP_VSS_GRIP_NPZ": {2560};
case "RHS_WEAP_VSS_NPZ": {2535};

//RHS GREF
case "RHS_WEAP_IZH18": {305};
case "RHS_WEAP_KAR98K": {590};
case "RHS_WEAP_M21A": {630};
case "RHS_WEAP_M21A_PR": {670};
case "RHS_WEAP_M21S": {615};
case "RHS_WEAP_M21S_PR": {655};
case "RHS_WEAP_M70AB2": {450};
case "RHS_WEAP_M70B1": {570};
case "RHS_WEAP_M92": {600};
case "RHS_WEAP_M38": {350};
case "RHS_WEAP_M38_RAIL": {360};

/*

case "RHS_WEAP_MOSIN_SBR": {425};

*/

case "RHS_WEAP_SAVZ58P": {1200};
case "RHS_WEAP_SAVZ58P_BLACK": {1200};
case "RHS_WEAP_SAVZ58P_RAIL": {1400};
case "RHS_WEAP_SAVZ58P_RAIL_BLACK": {1400};
case "RHS_WEAP_SAVZ58V": {1130};
case "RHS_WEAP_SAVZ58V_BLACK": {1130};
case "RHS_WEAP_SAVZ58V_RAIL": {1330};
case "RHS_WEAP_SAVZ68V_RAIL_BLACK": {1330};
case "RHS_WEAP_SAVZ61": {595};
case "RHS_WEAP_M76": {1100};
case "RHS_WEAP_SAVZ61_FOLDED": {595};
case "RHS_WEAP_TT33": {220};

//RHS SAF

/*

case "RHS_WEAP_MINIMI_PARA_RAILED": {7500};
case "RHS_WEAP_G36KV_AG36": {2600};

*/

case "RHS_WEAP_M21A_PBG40": {730};
case "RHS_WEAP_M70B1N": {570};
case "RHS_WEAP_M70B3N": {590};
case "RHS_WEAP_M70B3N_PBG40": {690};

/*

case "RHS_WEAP_M82A1": {9119};

*/

case "RHS_WEAP_SCORPION": {595};

//sidearms
case "RHS_WEAP_PB_6P9": {450};
case "RHS_WEAP_PYA": {685};

*/


case "RHS_WEAP_MAKAROV_PM": {400};

/*
case "RHS_WEAP_PP2000_FOLDED": {400};

*/


case "RHS_WEAP_RSP30_WHITE": {14};
case "RHS_WEAP_RSP30_GREEN": {14};
case "RHS_WEAP_RSP30_RED": {14};

/*

case "RHS_WEAP_TR8": {174};

*/

case "RHSUSF_WEAP_GLOCK17G4": {540};
case "RHSUSF_WEAP_M1911A1": {1700};
case "RHSUSF_WEAP_M9": {675};


//BINOCULARS

case "BINOCULAR": {250};

/*

case "LERCA_1200_BLACK": {500};
case "LERCA_1200_TAN": {500};

*/

case "LEUPOLD_MK4": {2210};

/*

case "ACE_MX2A": {6089};
case "RHS_PDU4": {6000};
case "RHS_TR8_PERISCOPE": {174};
case "RHS_TR8_PERISCOPE_PIP": {174};
case "ACE_VECTORDAY": {30000};
case "ACE_VECTOR": {52923};
case "ACE_YARDAGE450": {150};
case "LASERDESIGNATOR": {12000};
case "LASERDESIGNATOR_03": {12000};
case "LASERDESIGNATOR_01_KHK_F": {12000};

*/

//CUP
case "CUP_SRIFLE_SVD": {1840};
case "CUP_SRIFLE_SVD_DES": {1840};
case "CUP_SRIFLE_CZ550": {890};
case "CUP_SRIFLE_CZ550_RAIL": {890};
case "CUP_LMG_UK59": {-1};
case "CUP_HGUN_DUTY": {517};
case "CUP_HGUN_COMPACT": {562.50};
case "CUP_HGUN_PHANTOM": {636};

//Project Opfor
case "LOP_WEAP_LEEENFIELD": {500};
case "LOP_WEAP_LEEENFIELD_RAILED": {600};

//NiArms
case "HLC_RIFLE_AK47": {534};
case "HLC_RIFLE_AK74": {870};
case "HLC_RIFLE_AK74_DIRTY": {770};
case "HLC_RIFLE_AK74_MTK": {910};
case "HLC_RIFLE_AKM": {770};
case "HLC_RIFLE_AKMGL": {870};
case "HLC_RIFLE_AKM_MTK": {810};
case "HLC_RIFLE_AKS74U": {780};
case "HLC_RIFLE_RPK": {2775};
case "HLC_RIFLE_RPK74N": {2065};

//weird ruski mod
case "STR_AK_74_GP": {970};
case "STR_AKM": {870}; //GP-25
case "STR_AKM_CS": {700};
case "STR_RPD": {2300};
case "STR_SKS_OLD": {845};


default {-1};

};

_return
