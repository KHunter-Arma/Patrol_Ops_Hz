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
    		
case "RHSUSF_ACC_HARRIS_BIPOD": {135};
case "RHSUSF_ACC_ANPEQ15A": {1330};
case "RHSUSF_ACC_ANPEQ15": {1330};
case "RHSUSF_ACC_ANPEQ15_LIGHT": {1330};
case "RHSUSF_ACC_ANPEQ15SIDE": {1330};
case "RHSUSF_ACC_M2010S": {1333};
case "RHSUSF_ACC_SR25S": {1810};
case "RHSUSF_ACC_ROTEX5_GREY": {1333};
case "RHSUSF_ACC_ROTEX5_TAN": {1333};
case "RHSUSF_ACC_NT4_BLACK": {1333};
case "RHSUSF_ACC_NT4_TAN": {1333};
case "RHSUSF_ACC_MUZZLEFLASH_SF": {1333};
case "RHSUSF_ACC_SF3P556": {1333};
case "RHSUSF_ACC_SFMB556": {1333};
case "RHSUSF_ACC_COMPM4": {780};
case "RHSUSF_ACC_EOTECH_552": {500};
case "RHSUSF_ACC_LEUPOLDMK4": {2375};
case "RHSUSF_ACC_ELCAN": {1370};
case "RHSUSF_ACC_ELCAN_ARD": {1400};
case "RHSUSF_ACC_ELCAN_PIP": {1370};
case "RHSUSF_ACC_ACOG": {1333};
case "RHSUSF_ACC_ACOG_WD": {1333};
case "RHSUSF_ACC_ACOG_D": {1333};
case "RHSUSF_ACC_ACOG_SA": {1333};
case "RHSUSF_ACC_ACOG_PIP": {1333};
case "RHSUSF_ACC_ACOG2": {1333};
case "RHSUSF_ACC_ACOG3": {1333};
case "RHSUSF_ACC_ACOG_USMC": {1333};
case "RHSUSF_ACC_ACOG2_USMC": {1333};
case "RHSUSF_ACC_ACOG3_USMC": {1333};
case "RHSUSF_ACC_LEUPOLDMK4_2": {2375};
case "RHSUSF_ACC_EOTECH": {470};
case "RHSUSF_ACC_M2A1": {1333};
				
default {-1};

};

_return