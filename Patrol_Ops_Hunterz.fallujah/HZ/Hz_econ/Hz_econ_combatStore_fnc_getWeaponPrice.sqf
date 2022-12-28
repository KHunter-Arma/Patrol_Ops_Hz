private _relationsMultiplier = Hz_econ_sideRelationsPriceMultipler;

private ["_return","_weapon"];

_weapon = toupper _this;

_return = switch (_weapon) do {

//misc
case "USSR_GUITARA": {150};
case "BV_FLASHLIGHT": {75};

//anti-tank
/*
case "RHS_WEAP_SMAW": {13000};
case "RHS_WEAP_SMAW_GREEN": {13000};
case "RHS_WEAP_MAAWS": {3585};
*/


case "RHS_WEAP_RPG7": {2000};  // actually the RPG-7V2

//disposable anti-tank
case "RHS_WEAP_M136": {1480*_relationsMultiplier};
case "HAFM_LAW": {875*_relationsMultiplier};


/*
case "RHS_WEAP_M136_HEDP": {1500};
case "RHS_WEAP_M136_HP": {1600};
case "RHS_WEAP_M72A7": {875};
case "RHS_WEAP_RSHG2": {450};
case "RHS_WEAP_RPG26": {260};
*/



//anti-air
/*
case "CUP_LAUNCH_9K32STRELA": {12000};
case "RHS_WEAP_IGLA": {5000};
case "RHS_WEAP_FIM92": {3800};
*/


//40mm launchers
/*
case "RHS_WEAP_M32": {19500};
case "RHS_WEAP_M320": {3500};
*/



//RHS
/*
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

case "RHS_WEAP_M14EBRRI": {3500};
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
case "RHS_WEAP_M16A4": {740};
case "RHS_WEAP_M16A4_CARRYHANDLE": {740};
case "RHS_WEAP_M16A4_CARRYHANDLE_M203": {1820};
case "RHS_WEAP_M166A4_CARRYHANDLE_PMAG": {740};
case "RHS_WEAP_M16A4_PMAG": {740};
case "RHS_WEAP_M4_M203S": {1760};
case "RHS_WEAP_M4M320": {4200};
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
case "RHS_WEAP_MK18": {2000};
case "RHS_WEAP_MK18_BK": {2000};
case "RHS_WEAP_MK18_KAC_BK": {2095};
case "RHS_WEAP_MK18_D": {2000};
case "RHS_WEAP_MK18_KAC_D": {2095};
case "RHS_WEAP_MK18_M320": {5500};
case "RHS_WEAP_MK18_KAC": {2095};
case "RHS_WEAP_MK18_WD": {2000};
case "RHS_WEAP_MK18_KAC_WD": {2095};

case "RHS_WEAP_SR25": {7000};
case "RHS_WEAP_SR25_D": {7000};
case "RHS_WEAP_SR25_EC": {2800};
case "RHS_WEAP_SR25_EC_D": {2800};
case "RHS_WEAP_SR25_EC_WD": {2800};
case "RHS_WEAP_SR25_WD": {7700};
case "RHS_WEAP_M40A5": {5000};
case "RHS_WEAP_M40A5_D": {5000};
case "RHS_WEAP_M40A5_WD": {5000};
case "RHS_WEAP_XM2010": {10000};
case "RHS_WEAP_XM2010_WD": {10000};
case "RHS_WEAP_XM2010_D": {10000};
case "RHS_WEAP_XM2010_SA": {10000};
case "RHS_WEAP_M24SWS": {2800};
case "RHS_WEAP_M24SWS_BLK": {2800};
case "RHS_WEAP_M24SWS_GHILLIE": {2800};
case "RHS_WEAP_M107": {12281};
case "RHS_WEAP_M107_D": {12281};
case "RHS_WEAP_M107_W": {12281};

case "RHSUSF_WEAP_MP7A2": {1850};
case "RHSUSF_WEAP_MP7A2_AOR1": {1850};
case "RHSUSF_WEAP_MP7A2_DESERT": {1850};
case "RHSUSF_WEAP_MP7A2_WINTER": {1850};

case "RHS_WEAP_M4": {700};
case "RHS_WEAP_M4_CARRYHANDLE": {700};
case "RHS_WEAP_M4_CARRYHANDLE_PMAG": {700};
case "RHS_WEAP_M4_CARRYHANDLE_MSTOCK": {760};
case "RHS_WEAP_M4_M203": {1780};
case "RHS_WEAP_M4_PMAG": {700};
case "RHS_WEAP_M4_MSTOCK":{760};
case "RHS_WEAP_VHSD2": {2200};
case "RHS_WEAP_VHSD2_CT13X": {2300};
case "RHS_WEAP_VHSD2_BG": {3200};
case "RHS_WEAP_VHSD2_BG_CT15X": {3300};
case "RHS_WEAP_VHSK2": {2100};

*/

case "RHS_WEAP_M590_8RD": {770};
case "RHS_WEAP_M590_5RD": {470};

case "RHSUSF_WEAP_GLOCK17G4": {540};
case "RHSUSF_WEAP_M1911A1": {1700};
case "RHSUSF_WEAP_M9": {675};



/*
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
case "RHS_WEAP_AK74N_GP25_NPZ": {1035};
case "RHS_WEAP_AK74N_NPZ": {935};
case "RHS_WEAP_AK74N_2_NPZ": {1025};
case "RHS_WEAP_AKM_ZENITCO01_B33": {1320};
case "RHS_WEAP_AKMN_GP25_NPZ": {955};
case "RHS_WEAP_AKMN_NPZ": {855};
case "RHS_WEAP_AKS74N_GP25_NPZ": {1015};
case "RHS_WEAP_AKS74N_NPZ": {915};
case "RHS_WEAP_AKS74N_2_NPZ": {-1};
case "RHS_WEAP_AKS74U": {780};
case "RHS_WEAP_AKS74UN": {780};
case "RHS_WEAP_G36KV_AG36": {2600};

case "RHS_WEAP_PKP": {3595};

case "RHS_WEAP_PP2000_FOLDED": {400};
case "RHS_WEAP_PP2000": {400};
case "RHS_WEAP_PB_6P9": {450};
case "RHS_WEAP_PYA": {685};

case "RHS_WEAP_SVDP": {5000};
case "RHS_WEAP_SVDP_WD": {5000};
case "RHS_WEAP_SVDP_WD_NPZ": {5065};
case "RHS_WEAP_SVDP_NPZ": {5065};
case "RHS_WEAP_SVDS": {4400};
case "RHS_WEAP_SVDS_NPZ": {4465};
case "RHS_WEAP_T5000": {6600};
case "RHS_WEAP_VSS": {2470};
case "RHS_WEAP_VSS_GRIP": {2495};
case "RHS_WEAP_VSS_GRIP_NPZ": {2560};
case "RHS_WEAP_VSS_NPZ": {2535};
case "RHS_WEAP_ASVAL": {2465};
case "RHS_WEAP_ASVAL_GRIP": {2490};
case "RHS_WEAP_ASVAL_GRIP_NPZ": {2465};
case "RHS_WEAP_ASVAL_NPZ": {2655};
case "RHS_WEAP_MOSIN_SBR": {425};
case "RHS_WEAP_M82A1": {9119};

case "RHS_WEAP_TR8": {174};
*/



case "RHS_WEAP_AK74": {870};
case "RHS_WEAP_AK74_GP25": {970};
case "RHS_WEAP_AK74_3": {1020};
case "RHS_WEAP_AK74_2": {870};
case "RHS_WEAP_AK74N": {870};
case "RHS_WEAP_AK74N_GP25": {970};
case "RHS_WEAP_AK74N_2": {985};
case "RHS_WEAP_AKM": {770};
case "RHS_WEAP_AKM_GP25": {870};
case "RHS_WEAP_AKMN": {790};
case "RHS_WEAP_AKMN_GP25": {890};
case "RHS_WEAP_AKMS": {725};
case "RHS_WEAP_AKMS_GP25": {825};
case "RHS_WEAP_AKS74": {825};
case "RHS_WEAP_AKS74_GP25": {925};
case "RHS_WEAP_AKS74_2": {940};
case "RHS_WEAP_AKS74N": {850};
case "RHS_WEAP_AKS74N_GP25": {950};
case "RHS_WEAP_AKS74N_2": {940};
case "RHS_WEAP_M21A": {630};
case "RHS_WEAP_M21A_PR": {670};
case "RHS_WEAP_M21S": {615};
case "RHS_WEAP_M21S_PR": {655};
case "RHS_WEAP_M70AB2": {450};
case "RHS_WEAP_M70B1": {570};
case "RHS_WEAP_M92": {600};
case "RHS_WEAP_SAVZ58P": {1200};
case "RHS_WEAP_SAVZ58P_BLACK": {1200};
case "RHS_WEAP_SAVZ58P_RAIL": {1400};
case "RHS_WEAP_SAVZ58P_RAIL_BLACK": {1400};
case "RHS_WEAP_SAVZ58V": {1130};
case "RHS_WEAP_SAVZ58V_BLACK": {1130};
case "RHS_WEAP_SAVZ58V_RAIL": {1330};
case "RHS_WEAP_SAVZ68V_RAIL_BLACK": {1330};
case "RHS_WEAP_M21A_PBG40": {730};
case "RHS_WEAP_M21A_PR_PBG40": {770};
case "RHS_WEAP_M70B1N": {570};
case "RHS_WEAP_M70B3N": {590};
case "RHS_WEAP_M70B3N_PBG40": {690};

case "RHS_WEAP_PKM": {3550};
case "RHS_WEAP_MINIMI_PARA_RAILED": {7500};

case "RHS_WEAP_PM63": {550};
case "RHS_WEAP_SAVZ61": {595};
case "RHS_WEAP_SAVZ61_FOLDED": {595};
case "RHS_WEAP_TT33": {220};
case "RHS_WEAP_SCORPION": {595};
case "RHS_WEAP_MAKAROV_PM": {400};

case "RHS_WEAP_IZH18": {305};

case "RHS_WEAP_KAR98K": {590};
case "RHS_WEAP_M38": {350};
case "RHS_WEAP_M38_RAIL": {360};
case "RHS_WEAP_M76": {1100};

case "RHS_WEAP_RSP30_WHITE": {14};
case "RHS_WEAP_RSP30_GREEN": {14};
case "RHS_WEAP_RSP30_RED": {14};

case "RHS_WEAP_M79" : {3500};

case "RHS_WEAP_M1GARAND_SA43" : {750};
case "RHS_WEAP_MG42" : {1270};
case "RHS_WEAP_MP44" : {600};

case "RHS_WEAP_M84" : {4250};

	
//RH-M4
case "RH_M16A1": {225};
case "RH_M16A1GL": {1805};
case "RH_M16A2": {586};
case "RH_M16A2GL": {1666};

/*
case "RH_M4": {700};                  
case "RH_M4_M203": {1780};             
case "RH_M4_RIS": {750};             
case "RH_M4_RIS_M203": {1830};   
case "RH_M4_TG": {700};        
case "RH_M4_DES": {700};	
case "RH_M4_WDL": {700};     
case "RH_M4_RIS_M203S": {1810}; 
case "RH_M4A1_RIS": {750};           
case "RH_M4A1_RIS_M203": {1830};       
case "RH_M4A1_RIS_M203S": {1810};
case "RH_M4SBR": {1653};
case "RH_M4SBR_G": {1653};
case "RH_M4SBR_B": {1653};
case "RH_M16A3": {700};
case "RH_M16A4": {740};
case "RH_M16A4GL": {1820};
case "RH_M16A4_M": {740};
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
case "RH_AR10": {2072};      
case "RH_M16A6_TG": {-1};
case "RH_M16A6_DES": {-1};	
case "RH_M16A6_WDL": {-1};
case "RH_M4A6_TG": {-1};
case "RH_M4A6_DES": {-1};	
case "RH_M4A6_WDL": {-1};	        

case "RH_MK12MOD1": {3200};
case "RH_SAMR": {2520};
case "RH_MK11": {7000};
case "RH_M110": {2455};
case "RH_SR25EC": {2800};
case "RH_MK12MOD1_TG": {3200};	
case "RH_MK12MOD1_DES": {3200};	
case "RH_MK12MOD1_WDL": {3200};	
case "RH_SAMR_TG": {2520};
case "RH_SAMR_DES": {2520};
case "RH_SAMR_WDL": {2520};	

case "RH_M27IAR": {2070};
case "RH_M27IAR_TG": {2070};
case "RH_M27IAR_DES": {2070};
case "RH_M27IAR_WDL": {2070};

case "RH_SBR9": {1349};
case "RH_SBR9_TG": {1349};
case "RH_SBR9_DES": {1349};
case "RH_SBR9_WDL": {1349};
*/

case "HGUN_ACPC2_F": {1350};
case "HGUN_PISTOL_HEAVY_01_F": {1430};
case "HGUN_P07_F": {630};
case "HGUN_P07_KHK_F": {630};
case "HGUN_PISTOL_SIGNAL_F": {630};
case "HGUN_PISTOL_HEAVY_02_F": {1117};

//RH Pistols
/*
case "RH_G18": {535};
case "RH_MK2": {350};
*/
case "RH_M9": {675};
case "RH_M9C": {685};
case "RH_PYTHON": {2000};
case "RH_CZ75": {612};
case "RH_DEAGLE": {1694};
case "RH_DEAGLEG": {2254};
case "RH_DEAGLEM": {1670};
case "RH_DEAGLES": {2000};
case "RH_FN57": {1399};
case "RH_FN57_T": {1399};
case "RH_FN57_G": {1399};
case "RH_FNP45": {1199};
case "RH_FNPT": {1199};
case "RH_G17": {540};
case "RH_G19": {500};
case "RH_G19T": {500};
case "RH_GSH18": {-1};
case "RH_TEC9": {500};
case "RH_KIMBER": {1464};
case "RH_KIMBER_NW": {1392};
case "RH_M1911": {1700};
case "RH_MAK": {400};
case "RH_MATEBA": {3000};
case "RH_MUZI": {960};
case "RH_MP412": {1500};
case "RH_P226": {1165};
case "RH_P226S": {1413};
case "RH_SW659": {350};
case "RH_BULL": {930};
case "RH_BULLB": {980};
case "RH_TTRACKER": {450};
case "RH_TTRACKER_G": {3500};
case "RH_TT33": {220};
case "RH_USPM": {1050};
case "RH_USP": {850};
case "RH_VP70": {600};
case "RH_VZ61": {595};



//NiArms
case "HLC_RIFLE_AK47": {534};
case "HLC_RIFLE_AK74": {870};
case "HLC_RIFLE_AK74_DIRTY": {550};
case "HLC_RIFLE_AK74_DIRTY2": {825};
case "HLC_RIFLE_AK74_MTK": {910};
case "HLC_RIFLE_AKM": {770};
case "HLC_RIFLE_AKMGL": {870};
case "HLC_RIFLE_AKM_MTK": {810};
case "HLC_RIFLE_RPK": {2775};
case "HLC_RIFLE_RPK74N": {2065};
case "HLC_RIFLE_AKS74": {825};
case "HLC_RIFLE_AKS74_GL": {925};
case "HLC_RIFLE_AKS74_MTK": {950};
case "HLC_RIFLE_AKS74U": {780};
case "HLC_RIFLE_AKS74U_MTK": {905};

case "HLC_RIFLE_G3SG1": {3680};
//case "HLC_RIFLE_G3SG1RIS": {3780}; 
case "HLC_RIFLE_G3A3": {2000};
//case "HLC_RIFLE_G3A3RIS": {2100};
case "HLC_RIFLE_G3A3V": {2000};
//case "HLC_RIFLE_G3A3VRIS": {2100};
//case "HLC_RIFLE_G3KA4": {3900};
//case "HLC_RIFLE_G3KA4_GL": {4980};
case "HLC_RIFLE_HK33A2": {4000};
//case "HLC_RIFLE_HK33A2RIS": {4100};
//case "HLC_RIFLE_HK33A2RIS_GL": {5180};
case "HLC_RIFLE_HK33KA3": {4000};
case "HLC_RIFLE_HK53": {4200};
//case "HLC_RIFLE_HK53RAS": {4500};
//case "HLC_SMG_MP510": {2100};
//case "HLC_SMG_MP5A2": {1700};
//case "HLC_SMG_MP5A3": {1700};
//case "HLC_SMG_MP5A4": {1700};
//case "HLC_SMG_MP5K_PDW": {1600};

case "HLC_WP_M16A1": {325};
case "HLC_RIFLE_A1M203": {1905};
case "HLC_WP_M16A2": {686};
case "HLC_RIFLE_M203": {1766};

case "HLC_PISTOL_P226US": {1165};
case "HLC_PISTOL_P226R": {1165};
case "HLC_PISTOL_P226R_COMBAT": {1265};
case "HLC_PISTOL_P226R_357COMBAT": {1265};
case "HLC_PISTOL_P226R_40COMBAT": {1265};
case "HLC_PISTOL_P226R_ELITE": {1200};
case "HLC_PISTOL_P226R_357ELITE": {1200};
case "HLC_PISTOL_P226_40ELITE": {1200};
case "HLC_PISTO_P226R_40ENOX": {1200};
case "HLC_PISTOL_P226R_STAINLESS": {1200};
case "HLC_PISTOL_PP226R_357": {1200};
case "HLC_PISTOL_P226R_40": {1200};
case "HLC_PISTOL_M11": {1120};
case "HLC_PISTOL_MK25": {1000};
case "HLC_PISTOL_P226WESTGERMAN": {1165};
case "HLC_PISTOL_P228": {1000};
case "HLC_PISTOL_M11A1": {1120};
case "HLC_PISTOL_M11A1D": {1120};
case "HLC_PISTOL_MK25D": {1000};
case "HLC_PISTOL_MK25TR": {1000};
case "HLC_PISTOL_P226R_COMBAT": {880};
case "HLC_PISTOL_P229R_357COMBAT": {880};
case "HLC_PISTOL_P229R_40COMBAT":  {880};
case "HLC_PISTOL_P229R_40ENOX": {880};
case "HLC_PISTOL_P229R_357STAINLESS": {830};
case "HLC_PISTOL_P229R_357": {830};
case "HLC_PISTOL_P229R_40": {830};
case "HLC_PISTOL_P229R_ELITE": {880};
case "HLC_PISTOL_P229R_357ELITE": {880};
case "HLC_PISTOL_P229R_40ELITE": {880};
case "HLC_PISTOL_P239": {900};
case "HLC_PISTOL_P239_357": {900};
case "HLC_PISTOL_P239_40": {900};

/*
case "HLC_RIFLE_HONEYBADGER": {2000};
case "HLC_RIFLE_AWCOVERT_BL": {6750};
case "HLC_RIFLE_AWCOVERT_FDE": {6750};
case "HLC_RIFLE_AWCOVERT": {6750};
case "HLC_RIFLE_AWMAGNUM_BL": {5850};
case "HLC_RIFLE_AWMAGNUM_BL_GHILLIE": {5860};
case "HLC_RIFLE_AWMAGNUM_FDE": {5850};
case "HLC_RIFLE_AWMAGNUM_FDE_GHILLIE": {5860};
case "HLC_RIFLE_AWMAGNUM": {5850};
case "HLC_RIFLE_AWMAGNUM_OD_GHILLIE": {5860};
case "HLC_RIFLE_VENDIMUS": {1190};
case "HLC_RIFLE_RU5562": {1070};
case "HLC_RIFLE_RU556": {930};
case "HLC_RIFLE_SLR107U": {800};
case "HLC_RIFLE_SLR107U_MTK": {825};
case "HLC_RIFLE_BCMBLACKJACK": {2300};
case "HLC_RIFLE_BCMJACK": {2260};
case "HLC_RIFLE_BUSHMASTER300": {930};
case "HLC_RIFLE_C1A1": {400};
case "HLC_RIFLE_COLT727": {1000};
case "HLC_RIFLE_COLT727_GL": {2080};
case "HLC_RIFLE_CQBR": {1100};
case "HLC_RIFLE_M4A1CARRYHANDLE": {1050};
case "HLC_RIFLE_M4": {1400};
case "HLC_RIFLE_M4M203": {2480};
case "HLC_RIFLE_FALOSW": {2175};
case "HLC_RIFLE_OSW_GL": {3255};
case "HLC_RIFLE_L1A1SLR": {680};
case "HLC_RIFLE_FAL5000": {1300};
case "HLC_RIFLE_FAL5000RAIL": {1385};
case "HLC_RIFLE_FAL5000_RH": {1300};
case "HLC_RIFLE_FAL5061": {1595};
case "HLC_RIFLE_FAL5061RAIL": {1680};
case "HLC_RIFLE_LAR": {800};
case "HLC_LMG_MINIMI": {8500};
case "HLC_LMG_MINIMI_RAILED": {8500};
case "HLC_LMG_MINIMIPARA_LONG": {8695};
case "HLC_LMG_MINIMIPARA_LONG_RAILED": {8695};
case "HLC_LMG_MINIMIPARA": {7500};
case "HLC_LMG_MINIMIPARA_RAILED": {7500};
case "HLC_RIFLE_FN3011": {4500};
case "HLC_RIFLE_FN3011LYNX": {4500};
case "HLC_RIFLE_FN3011MODERN": {4500};
case "HLC_RIFLE_FN3011TACTICAL_GREEN": {4650};
case "HLC_RIFLE_FN3011TACTICAL_GREY": {4650};
case "HLC_RIFLE_FN3011TACTICAL": {4650};
case "HLC_RIFLE_FN3011MODERN_CAMO": {4500};
case "HLC_RIFLE_FN3011_WDL": {4500};
case "HLC_RIFLE_HK51": {5200};
case "HLC_RIFLE_G36MLIC": {3000};
case "HLC_RIFLE_G36A1": {2500};
case "HLC_RIFLE_G36A1AG36": {6000};
case "HLC_RIFLE_G36C": {2500};
case "HLC_RIFLE_G36CMLIC": {3000};
case "HLC_RIFLE_G36CV": {2600};
case "HLC_RIFLE_G36CTAC": {2800};
case "HLC_RIFLE_G36E1": {2500};
case "HLC_RIFLE_G36E1AG36_ROMI": {6000};
case "HLC_RIFLE_G36E1AG36": {6000};
case "HLC_RIFLE_G36KMLIC": {6500};
case "HLC_RIFLE_G36KA1KSK": {2800};
case "HLC_RIFLE_G36KSKAG36": {6000};
case "HLC_RIFLE_G36KA1": {2500};
case "HLC_RIFLE_G36KE1": {2500};
case "HLC_RIFLE_G36KV": {2600};
case "HLC_RIFLE_G36KTAC": {2900};
case "HLC_RIFLE_G36MLIAG36": {6500};
case "HLC_RIFLE_G36V": {2600};
case "HLC_RIFLE_G36VAG36": {6100};
case "HLC_RIFLE_G36TAC": {2900};

case "HLC_RIFLE_MG36": {2800};
case "HLC_SMG_9MMAR": {2600};
case "HLC_SMG_MP5SD5": {2200};
case "HLC_SMG_MP5SD6": {2200;
case "HLC_RIFLE_PSG1": {14000};
case "HLC_RIFLE_PSG1A1": {14000};
case "HLC_RIFLE_PSG1A1_RIS": {15000};
case "HLC_RIFLE_AK12": {990};
case "HLC_RIFLE_AK12GL": {1090};
case "HLC_RIFLE_AKU12": {-1};
case "HLC_RIFLE_AK74M": {885};
case "HLC_RIFLE_AK74M_GL": {985};
case "HLC_RIFLE_AK74M_MTK": {910};
case "HLC_RIFLE_AKM": {770};
case "HLC_RIFLE_AKMGL": {870};
case "HLC_RIFLE_AKM_MTK": {795};
case "HLC_RIFLE_RPK": {2775};
case "HLC_RIFLE_RPK12": {-1};
case "HLC_RIFLE_RPK74N": {2065};
case "HLC_RIFLE_SAIGA12K": {-1};
case "HLC_RIFLE_SLR": {680};
case "HLC_RIFLE_SLRCHOPMOD": {680};
case "HLC_WP_M134PAINLESS": {-1};
case "HLC_RIFLE_M14": {2800};
case "HLC_RIFLE_M14_BIPOD": {2900};/improvised
case "HLC_RIFLE_M14_BIPOD_RAIL": {3000};//improvised
case "HLC_RIFLE_M14_RAIL": {2900};//improvised
case "HLC_RIFLE_M14DMR": {3100};//improvised
case "HLC_RIFLE_M14DMR_RAIL": {3200};
case "HLC_RIFLE_M1903A1": {-1};
case "HLC_RIFLE_M1903A1OMR": {-1};
case "HLC_RIFLE_M1903A1_UNERTL": {-1};
case "HLC_RIFLE_M21": {630};
case "HLC_RIFLE_M21_RAIL": {670};
case "HLC_M249_SQUANTOON": {-1};
case "HLC_M249_PIP1": {-1};
case "HLC_M249_PIP4": {-1};
case "HLC_M249_PIP3": {-1};
case "HLC_LMG_M249E1": {-1};
case "HLC_LMG_M249E2": {-1};
case "HLC_M249_PIP2": {-1};
case "HLC_LMG_M249PARA": {-1};
case "HLC_LMG_M60": {-1};
case "HLC_LMG_M60E4": {-1};
case "HLC_LMG_MG42": {-1};
case "HLC_LMG_MG42_BAKELITE": {-1};
case "HLC_LMG_MK46": {-1};
case "HLC_LMG_MK46MOD1": {-1};
case "HLC_LMG_MK48": {-1};
case "HLC_LMG_MK48MOD1": {-1};
case "HLC_RIFLE_MK18MOD0": {-1};
case "HLC_SMG_MP5N": {-1};
case "HLC_RIFLEACR_SBR_CLIFFHANGER": {-1};
case "HLC_RIFLE_ACR_SBR_BLACK": {-1};
case "HLC_RIFLE_ACR_SBR_GREEN": {-1};
case "HLC_RIFLE_ACR_SBR_TAN": {-1};
case "HLC_RIFLE_ACR_FULL_BLACK": {-1};
case "HLC_RIFLE_ACR_FULL_GREEN": {-1};
case "HLC_RIFLE_ACR_FULL_TAN": {-1};
case "HLC_RIFLE_ACR_MID_BLACK": {-1};
case "HLC_RIFLE_ACR_MID_GREEN": {-1};
case "HLC_RIFLE_ACR_MID_TAN": {-1};
case "HLC_RIFLE_ACR_CARB_BLACK": {-1};
case "HLC_RIFLE_ACR_CARB_GREEN": {-1};
case "HLC_RIFLE_ACR_CARB_TAN": {-1};
case "HLC_RIFLE_ACR68_SBR_BLACK": {-1};
case "HLC_RIFLE_ACR68_SBR_GREEN": {-1};
case "HLC_RIFLE_ACR68_SQUANT": {-1};
case "HLC_RIFLE_ACR68_SBR_TAN": {-1};
case "HLC_RIFLE_ACR68_FULL_BLACK": {-1};
case "HLC_RIFLE_ACR68_FULL_GREEN": {-1};
case "HLC_RIFLE_ACR68_FULL_TAN": {-1};
case "HLC_RIFLE_ACR68_MID_BLACK": {-1};
case "HLC_RIFLE_ACR68_MID_GREEN": {-1};
case "HLC_RIFLE_ACR68_MID_TAN": {-1};
case "HLC_RIFLE_ACR68_ARON": {-1};
case "HLC_RIFLE_ACR68_CARB_BLACK": {-1};
case "HLC_RIFLE_ACR68_CARB_GREEN": {-1};
case "HLC_RIFLE_ACR68_CARB_TAN": {-1};
case "HLC_LMG_MG3_OPTIC": {-1};
case "HLC_LMG_MG3": {-1};
case "HLC_LMG_MG3KWS_B": {-1};
case "HLC_LMG_MG3KWS_G": {-1};
case "HLC_LMG_MG3KWS": {-1};
case "HLC_LMG_MG42KWS_B": {-1};
case "HLC_LMG_MG42KWS_G": {-1};
case "HLC_LMG_MG42KWS_T": {-1};
case "HLC_RIFLE_SAMR2": {-1};
case "HLC_RIFLE_SAMR": {-1};
case "HLC_RIFLE_AMT": {-1};
case "HLC_RIFLE_SIG5104": {-1};
case "HLC_RIFLE_SG550": {1950};
case "HLC_RIFLE_SG550SNIPER": {8660};
case "HLC_RIFLE_SG550SNIPER_RIS": {9160};
case "HLC_RIFLE_SG550_GL": {3000};
case "HLC_RIFLE_SG550_RIS": {2050};
case "HLC_RIFLE_SG550_TAC": {2250};
case "HLC_RIFLE_SG550_TAC_GL": {3250};
case "HLC_RIFLE_SG551LB": {2050};
case "HLC_RIFLE_SG551LB_RIS": {2150};
case "HLC_RIFLE_SG551LB_TAC": {2450};
case "HLC_RIFLE_SG551LB_TAC_GL": {2650};
case "HLC_RIFLE_SG553LB": {-1};
case "HLC_RIFLE_SG553LB_RIS": {-1};
case "HLC_RIFLE_SG553LB_TAC": {-1};
case "HLC_RIFLE_SG553SB": {-1};
case "HLC_RIFLE_SG553SB_RIS": {-1};
case "HLC_RIFLE_SG553SB_TAC": {-1};
case "HLC_RIFLE_SG553RLB": {-1};
case "HLC_RIFLE_SG553RLB_TAC": {-1};
case "HLC_RIFLE_SG533RSB": {-1};
case "HLC_RIFLE_SG553RSB_TAC": {-1};
case "HLC_RIFLE_STGW57": {-1};
case "HLC_RIFLE_STGW57_COMMANDO": {-1};
case "HLC_RIFLE_STGW57_RIS": {-1};
case "HLC_RIFLE_AUGSRCARB_B": {-1};
case "HLC_RIFLE_AUGSRCARB": {-1};
case "HLC_RIFLE_AUGSRHBAR_B": {-1};
case "HLC_RIFLE_AUGSRHBAR": {-1};
case "HLC_RIFLE_AUGSRHBAR_T": {-1};
case "HLC_RIFLE_AUGSR_B": {-1};
case "HLC_RIFLE_AUGSR": {-1};
case "HLC_RIFLE_AUGSR_T": {-1};
case "HLC_RIFLE_AUGSR_CARB_T": {-1};
case "HLC_RIFLE_AUGPARA_B": {-1};
case "HLC_RIFLE_AUGPARA": {-1};
case "HLC_RIFLE_AUGPARA_T": {-1};
case "HLC_RIFLE_AUGA1CARB_B": {-1};
case "HLC_RIFLE_AUGA1CARB": {-1};
case "HLC_RIFLE_AUGA1CARB_T": {-1};
case "HLC_RIFLE_AUGHBAR_B": {-1};
case "HLC_RIFLE_AUGHBAR": {-1};
case "HLC_RIFLE_AUGHBAR_T": {-1};
case "HLC_RIFLE_AUGA1_B": {-1};
case "HLC_RIFLE_AUG": {-1};
case "HLC_RIFLE_AUGA1_T": {-1};
case "HLC_RIFLE_AUGA2PARA_B": {-1};
case "HLC_RIFLE_AUGA2PARA": {-1};
case "HLC_RIFLE_AUGA2PARA_T": {-1};
case "HLC_RIFLE_AUGA2CARB_B": {-1};
case "HLC_RIFLE_AUGA2CARB": {-1};
case "HLC_RIFLE_AUGA2CARB_T": {-1};
case "HLC_RIFLE_AUGA2LSW_B": {-1};
case "HLC_RIFLE_AUGA2LSW": {-1};
case "HLC_RIFLE_AUGA2LSW_T": {-1};
case "HLC_RIFLE_AUGA2_B": {-1};
case "HLC_RIFLE_AUGA2": {-1};
case "HLC_RIFLE_AUGA2_T": {-1};
case "HLC_RIFLE_AUGA3_GL_B": {-1};
case "HLC_RIFLE_AUGA3_GL_BL": {-1};
case "HLC_RIFLE_AUGA3_GL": {-1};
case "HLC_RIFLE_AUGA3_B": {-1};
case "HLC_RIFLE_AUGA3_BL": {-1};
case "HLC_RIFLE_AUGA3": {-1};
case "HLC_RIFLE_STG58F": {-1};
case "HLC_RIFLE_M14SOPMOD": {-1};
case "HLC_RIFLE_RK62": {-1};
case "HLC_RIFLE_AEK971": {-1};
case "HLC_RIFLE_AEK971_MTK": {-1};
case "HLC_RIFLE_AEK971WORN": {-1};

case "HLC_SMG_MP5K": {1600};
*/



//CUP
/*
case "CUP_ARIFLE_CZ805_B": {2600}; -dont exist
case "CUP_ARIFLE_CZ805_B_GL": {3600}; -dont exist
*/
/*
case "CUP_ARIFLE_CZ805_A1": {2099};
case "CUP_ARIFLE_CZ805_GL": {3099};
case "CUP_ARIFLE_CZ805_A2": {1999};
*/
case "CUP_SRIFLE_SVD": {1840};
case "CUP_SRIFLE_SVD_DES": {1840};
case "CUP_SRIFLE_CZ550": {890};
case "CUP_SRIFLE_CZ550_RAIL": {990};
case "CUP_LMG_UK59": {3700};
case "CUP_HGUN_DUTY": {517};
case "CUP_HGUN_COMPACT": {562.50};
case "CUP_HGUN_PHANTOM": {636};
case "CUP_SRIFLE_LEEENFIELD": {500};
case "CUP_SRIFLE_LEEENFIELD_RAIL": {600};

//weird ruski mod
case "STR_AK_74_GP": {970};
case "STR_AKM": {870}; //GP-25
case "STR_AKM_CS": {700};
case "STR_RPD": {2300};
case "STR_SKS_OLD": {845};





//BINOCULARS
case "BINOCULAR": {250};
case "RHSUSF_BINO_M24": {250};
case "RHSUSF_BINO_M24_ARD": {300};
case "RHSSAF_ZRAK_RD7J": {250};



/*
case "LERCA_1200_BLACK": {500};
case "LERCA_1200_TAN": {500};
*/



case "RHSUSF_BINO_LEOPOLD_MK4": {2210};
case "RHS_TR8_PERISCOPE": {174};
case "RHS_TR8_PERISCOPE_PIP": {174};


/*
case "ACE_MX2A": {6089};
case "RHS_PDU4": {6000};

case "ACE_VECTORDAY": {30000};
case "ACE_VECTOR": {52923};
case "LASERDESIGNATOR": {12000};
case "LASERDESIGNATOR_03": {12000};
case "LASERDESIGNATOR_01_KHK_F": {12000};
*/

case "ACE_YARDAGE450": {150};


default {-1};
};

_return
