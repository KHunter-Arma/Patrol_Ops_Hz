/*******************************************************************************
* Copyright (C) Hunter'z Economy Module
*
* This file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/

private ["_return","_attachment"];

_attachment = toupper _this;

_return = switch (_attachment) do {
    		
/*				
				
case "RHS_ACC_RAKURSPM": {600};
case "RHS_ACC_1P87": {800};
case "RHS_ACC_DH520X56": {1650};
case "RHS_ACC_EKP8_18": {280};
case "RHS_ACC_1P29": {550};
case "RHS_ACC_1P63": {540};
case "RHS_ACC_1P78": {650};
case "RHS_ACC_1PN93_1": {1780};
case "RHS_ACC_1PN93_2": {2100};
case "RHS_ACC_EKP1": {440};
case "RHS_ACC_EPK8_02": {280};
case "RHS_ACC_NITA": {580};
case "RHS_ACC_PGO7V": {450};
case "RHS_ACC_PGO7V2": {480};
case "RHS_ACC_PGOV3": {500};
case "RHS_ACC_PKAS": {460};
case "RHS_ACC_PSO1M2": {300};
case "RHS_ACC_PSO1M21": {335};

case "RHSUSF_ACC_ANPAS13GV1": {7630};
case "RHSUSF_ACC_ACOG2_USMC": {1772};
case "RHSUSF_ACC_ACOG3_USMC": {1790};
case "RHSUSF_ACC_ACOG_USMC": {1724};
case "RHSUSF_ACC_ANPVS27": {10795};
case "RHSUSF_ACC_EOTECH": {580};
case "RHSUSF_ACC_ELCAN": {1370};
case "RHSUSF_ACC_ELCAN_ARD": {1440};
case "RHSUSF_ACC_ACOG":  {1780};
case "RHSUSF_ACC_ACOG2": {1828};
case "RHSUSF_ACC_ACOG3": {1846};
case "RHSUSF_ACC_ACOG_ANPVS27": {12575};
case "RHSUSF_ACC_M2A1": {800};
case "RHSUSF_ACC_EOTECH_552": {570};
case "RHSUSF_ACC_EOTECH_552_D": {570};

*/

case "RHSUSF_ACC_COMPM4": {780};

/*

case "RHSUSF_ACC_M8541": {3900};
case "RHSUSF_ACC_M8541_LOW": {3900};
case "RHSUSF_ACC_M8541_LOW_D": {3900};
case "RHSUSF_ACC_M8541_LOW_WD": {3900};
case "RHSUSF_ACC_PREMIER_LOW": {3200};
case "RHSUSF_ACC_PREMIER_ANPVS27": {13995};
case "RHSUSF_ACC_PREMIER": {3200};
case "RHSUSF_ACC_LEUPOLDMK4": {1100};
case "RHSUSF_ACC_LEUPOLDMK4_2": {1700};
case "RHSUSF_ACC_LEUPOLDMK4_2_D": {1700};
case "RHSUSF_ACC_SPECTERDR": {2360};
case "RHSUSF_ACC_SPECTERDR_OD": {2360};
case "RHSUSF_ACC_SPECTERDR_D": {2360};
case "RHSUSF_ACC_SPECTERDR_A": {2360};
case "RHSUSF_ACC_ACOG_MDO": {3861};
case "RHSUSF_ACC_ACOG_RMR": {2560};
case "RHSUSF_ACC_ACOG_D": {1780};
case "RHSUSF_ACC_ACOG_WD": {1780};
case "RHSUSF_ACC_EOTECH_XPS3": {580};
case "RHSUSF_ACC_ANPEQ15SIDE": {1280};
case "RHSUSF_ACC_ANPEQ15_TOP": {1280};
case "RHSUSF_ACC_ANPEQ15_WMX": {1930};
case "RHSUSF_ACC_ANPEQ15_WMX_LIGHT": {1930};
case "RHSUSF_ACC_ANPEQ15SIDE_BK": {1280};
case "RHSUSF_ACC_ANPEQ15_BK_TOP": {1280};
case "RHSUSF_ACC_ANPEQ15": {1945};
case "RHSUSF_ACC_ANPEQ15_LIGHT": {1945};
case "RHSUSF_ACC_ANPEQ15_BK": {1945};
case "RHSUSF_ACC_ANPEQ15_BK_LIGHT": {1945};
case "RHSUSF_ACC_ANPEQ15A": {1506};

*/

case "RHSUSF_ACC_M952V": {665};
case "RHSUSF_ACC_WMX": {650};
case "RHSUSF_ACC_WMX_BK": {650};
case "ACE_ACC_POINTER_GREEN": {1506};
case "ACE_MUZZEL_MZLS_L": {125};

/*

case "RHSUSF_ACC_NT4_BLACK": {1500};
case "RHSUSF_ACC_NT4_TAN": {1500};
case "RHSUSF_ACC_ROTEX5_GREY": {1090};
case "RHSUSF_ACC_ROTEX5_TAN": {1090};

*/

case "RHSUSF_ACC_SF3P556": {135};
case "RHSUSF_ACC_SFMB556": {149};

/*

case "MUZZLE_SNDS_M_KHK_F": {1099};
case "MUZZLE_SNDS_M_SND_F": {1099};

*/

case "RHSUSF_ACC_GRIP2": {35};
case "RHSUSF_ACC_GRIP2_TAN": {35};
case "RHSUSF_ACC_GRIP2_WD": {35};
case "RHSUSF_ACC_GRIP1": {150};
case "RHSUSF_ACC_HARRIS_BIPOD": {135};
case "RHSUSF_ACC_GRIP3": {70};
case "RHSUSF_ACC_GRIP3_TAN": {70};
case "BIPOD_03_F_BLK": {135};
case "BIPOD_02_F_BLK": {135};
case "BIPOD_01_F_BLK": {135};
case "BIPOD_02_F_HEX": {135};
case "BIPOD_01_F_KHK": {135};
case "BIPOD_01_F_MTP": {135};
case "BIPOD_03_F_OLI": {135};
case "BIPOD_01_F_SND": {135};
case "BIPOD_02_F_TAN": {135};

/*

case "RHSUSF_ACC_ARDEC_M240": {30};

case "MUZZLE_SNDS_H_MG_BLK_F": {664};
case "MUZZLE_SNDS_H_MG": {664};
case "MUZZLE_SNDS_H_MG_KHK_F": {664};
case "RHSUSF_ACC_M2010S": {1440};
case "RHSUSF_ACC_M2010S_D": {1440};
case "RHSUSF_ACC_M2010S_SA": {1440};
case "RHSUSF_ACC_M2010S_WD": {1440};
case "RHSUSF_ACC_SR25S": {1800};

case "RHSUSF_ACC_ROTX_MP7_AOR1": {-1};
case "RHSUSF_ACC_ROTEX_MP7": {-1};
case "RHSUSF_ACC_ROTEX_MP7_DESERT": {-1};
case "RHSUSF_ACC_ROTEX_MP7_WINTER": {-1};
case "RH_HBSD": {1200};
case "RH_DELFT": {219};
case "RHS_OPTIC_MAAWS": {850};

case "OPTIC_ACO_GRN": {240};
case "OPTIC_ACO": {240};
case "OPTIC_ACO_GRN_SMG": {240};
case "OPTIC_ACO_SMG": {240};
case "OPTIC_ARCO": {1577};
case "OPTIC_DMS": {1550};
case "OPTIC_LRPS": {2100};
case "OPTIC_HOLOSIGHT": {630};
case "OPTIC_HOLOSIGHT_SMG": {630};
case "OPTIC_SOS": {1170};
case "OPTIC_MRCO": {1495};
case "OPTIC_HAMR": {1370};
case "OPTIC_YORRIS": {250};
case "OPTIC_AMS": {2230};
case "OPTIC_AMS_KHK": {2230};
case "OPTIC_AMS_SND": {2230};
case "OPTIC_KHS_BLK": {1250};
case "OPTIC_KHS_OLD": {950};
case "OPTIC_KHS_TAN": {1250};
case "OPTIC_ARCO_BLK_F": {1577};
case "OPTIC_ARCO_GHEX_F": {1577};
case "OPTIC_ERCO_BLK_F": {2000};
case "OPTIC_ERCO_SND_F": {2000};
case "OPTIC_LRPS_GHEX_F": {2100};
case "OPTIC_LRPS_TNA_F": {2100};
case "OPTIC_HOLOSIGHT_BLK_F": {630};
case "OPTIC_HOLOSIGHT_KHK_F": {630};
case "OPTIC_HOLOSIGHT_SMG_BLK_F": {630};
case "OPTIC_HOLOSIGHT_SMG_KHK_F": {630};
case "OPTIC_SOS_KHK_F": {1170};
case "OPTIC_HAMR_KHK_F": {1370};

*/


default {-1};

};

_return