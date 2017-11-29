private ["_return","_weapon"];

_weapon = toupper _this;

_return = switch (_weapon) do {

//disposeable anti-tank
//AT-4s
case "RHS_WEAP_M136": {1480};
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

//RPG7
case "RHS_WEAP_RPG7": {1170};

//anti-air
//igla
case "RHS_WEAP_IGLA": {5000};

//stinger
case "RHS_WEAP_FIM92": {3800};

//RH-M4
case "RH_M4": {700};                  
case "RH_M4_M203": {1780};             
case "RH_M4_RIS": {750};             
case "RH_M4_RIS_M203": {1830};         
case "RH_M4_RIS_M203S": {1810}; 
case "RH_M4A1_RIS": {750};           
case "RH_M4A1_RIS_M203": {1830};       
case "RH_M4A1_RIS_M203S": {1810};
case "RH_M4SBR": {1653};
case "RH_M4SBR_G": {1653};
case "RH_M4SBR_B": {1653};
case "RH_M16A1": {225};
case "RH_M16A1GL": {1805};
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
case "RH_M4A6": {1210};
case "RH_M16A6": {1200};
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
case "RH_M4_TG": {700};        
case "RH_M4_DES": {700};	
case "RH_M4_WDL": {700};	
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
case "RH_M4A6_TG": {1210};
case "RH_M4A6_DES": {1210};	
case "RH_M4A6_WDL": {1210};	
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
case "RH_M16A6_TG": {1200};
case "RH_M16A6_DES": {1200};	
case "RH_M16A6_WDL": {1200};	
case "RH_MK12MOD1_TG": {3200};	
case "RH_MK12MOD1_DES": {3200};	
case "RH_MK12MOD1_WDL": {3200};	
case "RH_SAMR_TG": {2520};
case "RH_SAMR_DES": {2520};
case "RH_SAMR_WDL": {2520};	
case "RH_SBR9_TG": {1349};
case "RH_SBR9_DES": {1349};
case "RH_SBR9_WDL": {1349};

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

case "RHS_WEAP_AK74": {870};
case "RHS_WEAP_AK74_GP25": {970};
case "RHS_WEAP_AK74_3": {1020};
case "RHS_WEAP_AK74_2": {870};
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

case "RHS_WEAP_AKM": {770};
case "RHS_WEAP_AKM_GP25": {870};
case "RHS_WEAP_AKM_ZENITCO01_B33": {1320};
case "RHS_WEAP_AKMN": {790};
case "RHS_WEAP_AKMN_GP25": {890};
case "RHS_WEAP_AKMN_GP25_NPZ": {955};
case "RHS_WEAP_AKMN_NPZ": {855};
case "RHS_WEAP_AKMS": {725};
case "RHS_WEAP_AKMS_GP25": {825};

case "RHS_WEAP_AKS74": {825};
case "RHS_WEAP_AKS74_GP25": {925};
case "RHS_WEAP_AKS74_2": {940};
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

//PKx
case "RHS_WEAP_PKM": {3550};
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
case "RHS_weap_SVDS_NPZ": {4465};

//T5000
case "RHS_WEAP_T5000": {6600};

//Vintorez
case "RHS_WEAP_VSS": {2470};
case "RHS_WEAP_VSS_GRIP": {2495};
case "RHS_WEAP_VSS_GRIP_NPZ": {2560};
case "RHS_WEAP_VSS_NPZ": {2535};

//sidearms
case "RHS_WEAP_PB_6P9": {450};
case "RHS_WEAP_PYA": {685};
case "RHS_WEAP_MAKAROV_PM": {400};
case "RHS_WEAP_PP2000_FOLDED": {400};
case "RHS_WEAP_RSP30_WHITE": {14};
case "RHS_WEAP_RSP30_GREEN": {14};
case "RHS_WEAP_RSP30_RED": {14};
case "RHS_WEAP_TR8": {174};

				
default {-1};

};

_return