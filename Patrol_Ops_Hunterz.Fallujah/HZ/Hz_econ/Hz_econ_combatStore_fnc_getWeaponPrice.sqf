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

private ["_return","_weapon"];

_M203 = 1080;
_M320 = 3500;

_weapon = toupper _this;

_return = switch (_weapon) do {
    		
//Rifles
case "RHS_WEAP_M4_BASE": {700};
case "RHS_WEAP_M4": {700};
case "RHS_WEAP_M4_CARRYHANDLE": {700};
case "RHS_WEAP_M4_CARRYHANDLE_PMAG": {700};
case "RHS_WEAP_M4A1": {750};
case "RHS_WEAP_M4A1_CARRYHANDLE": {750};
case "RHS_WEAP_M4A1_CARRYHANDLE_PMAG": {750};
case "RHS_WEAP_M4A1_BLOCKII": {2200};
case "RHS_WEAP_M4A1_BLOCKII_KAC": {2200};
case "RHS_WEAP_MK18": {2000};
case "RHS_WEAP_MK18_KAC": {2000};
case "RHS_WEAP_M16A4": {740};
case "RHS_WEAP_M16A4_CARRYHANDLE": {740};
case "RHS_WEAP_M16A4_CARRYHANDLE_PMAG": {740};
case "RHS_WEAP_M16A4_CARRYHANDLE_M203": {740 + _M203};
case "RHS_WEAP_M4_M320": {700 + _M320};
case "RHS_WEAP_M4A1_M320": {750 + _M320};
case "RHS_WEAP_MK18_M320": {2000 + _M320};
case "RHS_WEAP_M4_M203": {700 + _M203};
case "RHS_WEAP_M4_M203S": {700 + _M203};
case "RHS_WEAP_M4A1_M203": {750 + _M203};
case "RHS_WEAP_M4A1_M203S": {750 + _M203};
case "RHS_WEAP_M4A1_M203S_WD": {750 + _M203};
case "RHS_WEAP_M4A1_M203S_D": {750 + _M203};
case "RHS_WEAP_M4A1_M203S_SA": {750 + _M203};
case "RHS_WEAP_M4A1_CARRYHANDLE_M203": {750 + _M203};
case "RHS_WEAP_M4A1_CARRYHANDLE_M203S": {750 + _M203};
case "RHS_WEAP_M4A1_BLOCKII_M203": {2200 + _M203};

//MG
case "RHS_WEAP_LMG_MINIMIPARA": {4090};
case "RHS_WEAP_LMG_MINIMI_RAILED": {4090};
case "RHS_WEAP_M249_PIP_S": {4090};
case "RHS_WEAP_M249_PIP_S_PARA": {7000};
case "RHS_WEAP_M249_PIP_S_VFG": {7000};
case "RHS_WEAP_M249_PIP": {4090};
case "RHS_WEAP_M249_PIP_L": {4090};
case "RHS_WEAP_M249_PIP_L_PARA": {7000};
case "RHS_WEAP_M249_PIP_L_VFG": {7000};
case "RHS_WEAP_M240B": {6000};
case "RHS_WEAP_M240G": {6600};
case "RHS_WEAP_M240B_CAP": {6000};

//Sniper
case "RHS_WEAP_M14EBRRI": {3500};
case "RHS_WEAP_SR25": {2455};
case "RHS_WEAP_SR25_EC": {2455};
case "RHS_WEAP_M110": {2455};
case "RHS_WEAP_M107": {6000};

//Launcher
case "RHS_WEAP_M32": {19500};

//Binocs
case "LERCA_1200_BLACK": {1333};
case "LERCA_1200_TAN": {1333};
				
default {-1};

};

_return