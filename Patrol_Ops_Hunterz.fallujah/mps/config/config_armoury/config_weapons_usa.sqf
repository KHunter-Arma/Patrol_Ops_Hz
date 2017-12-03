if(mps_ace_enabled) then {
	_w = _w +  ["ACE_Glock18","ACE_P226","ACE_P8","ACE_USP","ACE_USPSD","M9","M9SD","glock17_EP1","Colt1911"];

	_list = _list + [
		["PRIVATE", "ALL",	["ACE_HK416_D10","ACE_HK416_D14","M1014","ACE_M1014_Eotech","M14_EP1","M16A2","ACE_M4","ACE_M16A4_Iron","SCAR_L_CQC","ACE_MP5A5","ACE_MP5SD"] ],
		["PRIVATE", "SOLDIER",	["ACE_SPAS12","ACE_M27_IAR","SCAR_L_STD_HOLO","M4A1","M4A1_Aim","M4A1_Aim_camo","ACE_M4A1_C","ACE_M4A1_GL","M4A3_CCO_EP1"] ],
		["PRIVATE", "AT",	["ACE_M72A2","Stinger"] ],
		["PRIVATE", "SNIPER",	["M24_des_EP1","ACE_HK417_Shortdot","ACE_SOC_M4A1_SHORTDOT","ACE_M14_ACOG"] ],
		["PRIVATE", "MG",	["M249_EP1","M240"] ],

		["CORPORAL", "ALL",	["ACE_HK417_micro","ACE_HK416_D10_M320","ACE_HK416_D10_SD","ACE_HK416_D10_AIM","ACE_HK416_D14_SD","M16A2GL","m16a4","SCAR_L_CQC_Holo","ACE_M4_Aim","ACE_M4_GL","ACE_M72A2"] ],
		["CORPORAL", "SOLDIER",	["ACE_M27_IAR_CCO","SCAR_H_CQC_CCO","ACE_SOC_M4A1","ACE_M4A1_Aim_SD","M4A1_AIM_SD_camo","ACE_M4A1_Eotech","ACE_SOC_M4A1_GL"] ],
		["CORPORAL", "AT",	["ACE_M136_CSRS"] ],
		["CORPORAL", "SNIPER",	["ACE_SOC_M4A1_SHORTDOT_SD","DMR"] ],
		["CORPORAL", "MG",	["ACE_M249_AIM","ACE_M240L","M60A4_EP1","ACE_M60"] ],

		["SERGEANT", "ALL",	["ACE_HK416_D10_Holo","ACE_M16A4_EOT","M16A4_GL","ACE_M16A4_CCO_GL","ACE_M4_Eotech","ACE_M4_AIM_GL","SCAR_L_CQC_EGLM_Holo","SCAR_L_CQC_CCO_SD"] ],
		["SERGEANT", "SOLDIER",	["ACE_M4A1_AIM_GL","ACE_M4A1_AIM_GL_SD","ACE_M27_IAR_ACOG","SCAR_L_STD_Mk4CQT","SCAR_H_CQC_CCO_SD","ACE_SOC_M4A1_Eotech"] ],
		["SERGEANT", "AT",	["MAAWS"] ],
		["SERGEANT", "SNIPER",	["ACE_M4SPR_SD","ACE_HK417_leupold"] ],
		["SERGEANT", "MG",	["M249_m145_EP1","ACE_M240B","ACE_M240L_M145"] ],

		["LIEUTENANT", "ALL",	["ACE_HK417_Eotech_4x","ACE_M16A4_EOT_GL","m16a4_acg","ACE_M4_Eotech_GL"] ],
		["LIEUTENANT", "SOLDIER",["ACE_M4A1_EOT_SD","ACE_SOC_M4A1_EOT_SD","ACE_SOC_M4A1_Eotech_4x","ACE_SOC_M4A1_GL_AIMPOINT","ACE_SOC_M4A1_Aim","ACE_SOC_M4A1_AIM_SD","ACE_SOC_M4A1_GL_EOTECH","M4A1_HWS_GL","M4A1_HWS_GL_camo","M4A1_HWS_GL_SD_Camo"] ],
		["LIEUTENANT", "AT",	["M47Launcher_EP1"] ],
		["LIEUTENANT", "SNIPER",["ACE_Mk12mod1","ACE_Mk12mod1_SD","SCAR_H_LNG_Sniper"] ],
		["LIEUTENANT", "MG",	["Mk_48_DES_EP1"] ],

		["CAPTAIN", "ALL",	["ACE_M4_ACOG","ACE_M4_ACOG_PVS14","ACE_HK416_D14_ACOG_PVS14","M16A4_ACG_GL"] ],
		["CAPTAIN", "SOLDIER",	["SCAR_L_STD_EGLM_RCO","M4A3_RCO_GL_EP1","ACE_M4A1_ACOG","ACE_M4A1_ACOG_PVS14","ACE_M4A1_ACOG_SD","ACE_SOC_M4A1_RCO_GL","M4A1_RCO_GL"] ],
		["CAPTAIN", "AT",	["ACE_Javelin_CLU","ACE_Javelin_Direct"] ],
		["CAPTAIN", "SNIPER",	["ACE_M110","ACE_M110_SD","M110_NVG_EP1"] ],
		["CAPTAIN", "MG",	["ACE_M249_PIP_ACOG","m240_scoped_EP1"] ],

		["MAJOR",   "ALL",	["ACE_SCAR_H_STD_Spect","ACE_M4_RCO_GL"] ],
		["MAJOR",   "SOLDIER",	["SCAR_H_STD_EGLM_Spect"] ],
		["MAJOR",   "AT",	[] ],
		["MAJOR",   "SNIPER",	["m107","ACE_AS50","ACE_TAC50","ACE_TAC50_SD","SCAR_H_LNG_Sniper_SD"] ],
		["MAJOR",   "MG",	[] ],

		["COLONEL", "ALL",	[] ],
		["COLONEL", "SOLDIER",	[] ],
		["COLONEL", "AT",	[] ],
		["COLONEL", "SNIPER",	["m107_TWS_EP1","M110_TWS_EP1"] ],
		["COLONEL", "MG",	["M249_TWS_EP1"] ]
	];

	_m = _m + ["ACE_12Rnd_45ACP_USP","ACE_12Rnd_45ACP_USPSD","ACE_33Rnd_9x19_G18","ACE_15Rnd_9x19_P226","17Rnd_9x19_glock17",
		"SmokeShell","SmokeShellYellow","SmokeShellRed","SmokeShellGreen","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange","PipeBomb","HandGrenade_West","Mine",
		"Laserbatteries","ACE_Claymore_M","ACE_BBetty_M","ACE_M4SLAM_M","ACE_TripFlare_M","ACE_Rope_M_50","ACE_Rope_M_90","ACE_Rope_M_120","ACE_Rope_TOW_M_5",
		"ACE_BATTERY_RANGEFINDER","ACE_IRSTROBE","ACE_KNICKLICHT_W","ACE_KNICKLICHT_R","ACE_KNICKLICHT_Y","ACE_KNICKLICHT_G","ACE_KNICKLICHT_B","ACE_KNICKLICHT_IR",

		"10Rnd_127x99_m107","15Rnd_9x19_M9","30Rnd_556x45_Stanag","5Rnd_762x51_M24","7Rnd_45ACP_1911","ACE_1Rnd_CS_M203","ACE_1Rnd_HE_M203","ACE_SSGreen_M203",
		"ACE_SSRed_M203","ACE_SSRed_M203","ACE_SSWhite_M203","ACE_SSWhite_M203","ACE_SSYellow_M203","FlareRed_M203","FlareWhite_M203", "100Rnd_762x51_M240",
		"ACE_100Rnd_556x45_T_M249","ACE_200Rnd_556x45_T_M249","ACE_20Rnd_762x51_S_SCAR","ACE_20Rnd_762x51_T_DMR","ACE_20Rnd_762x51_T_HK417","ACE_20Rnd_762x51_T_SCAR",
		"ACE_30Rnd_556x45_S_Stanag","ACE_30Rnd_556x45_T_Stanag","ACE_30Rnd_9x19_S_MP5", "ACE_5Rnd_127x99_B_TAC50","ACE_5Rnd_127x99_S_TAC50","ACE_5Rnd_127x99_T_TAC50",
		"ACE_8Rnd_12Ga_Buck00","ACE_8Rnd_12Ga_Slug","ACE_30Rnd_6x35_B_PDW","ACE_25Rnd_1143x23_B_UMP45","ACE_25Rnd_1143x23_S_UMP45","ACE_FlareIR_M203","ACE_HuntIR_M203",
		"ACE_M576","ACE_MAAWS_HE","MAAWS_HEAT","MAAWS_HEDP","Stinger","ACE_M252HE_CSWDM"
	];

}else{
	_w = _w +  ["Binocular","NVGoggles","ItemCompass","ItemGPS","ItemMap","ItemRadio","ItemWatch","Binocular_Vector","Laserdesignator","M9","M9SD","glock17_EP1","Colt1911"];

	_list = _list + [
		["PRIVATE", "ALL",	["M1014","M14_EP1","M16A2","SCAR_L_CQC","MP5A5","MP5SD"] ],
		["PRIVATE", "SOLDIER",	["SCAR_L_STD_HOLO","M4A1","M4A1_Aim","M4A3_CCO_EP1"] ],
		["PRIVATE", "AT",	["Stinger","M136"] ],
		["PRIVATE", "SNIPER",	["M24_des_EP1"] ],
		["PRIVATE", "MG",	["M249_EP1","M240"] ],

		["CORPORAL", "ALL",	["M16A2GL","m16a4","SCAR_L_CQC_Holo"] ],
		["CORPORAL", "SOLDIER",	["SCAR_H_CQC_CCO","M4A1_AIM_SD_camo","M136"] ],
		["CORPORAL", "AT",	["MAAWS"] ],
		["CORPORAL", "SNIPER",	["DMR"] ],
		["CORPORAL", "MG",	["M60A4_EP1"] ],

		["SERGEANT", "ALL",	["M16A4_GL","SCAR_L_CQC_EGLM_Holo","SCAR_L_CQC_CCO_SD"] ],
		["SERGEANT", "SOLDIER",	["SCAR_L_STD_Mk4CQT","SCAR_H_CQC_CCO_SD"] ],
		["SERGEANT", "AT",	[] ],
		["SERGEANT", "SNIPER",	["M4SPR"] ],
		["SERGEANT", "MG",	["M249_m145_EP1"] ],

		["LIEUTENANT", "ALL",	["m16a4_acg"] ],
		["LIEUTENANT", "SOLDIER",["M4A1_HWS_GL","M4A1_HWS_GL_camo","M4A1_HWS_GL_SD_Camo"] ],
		["LIEUTENANT", "AT",	["M47Launcher_EP1"] ],
		["LIEUTENANT", "SNIPER",["SCAR_H_LNG_Sniper"] ],
		["LIEUTENANT", "MG",	["Mk_48_DES_EP1"] ],

		["CAPTAIN", "ALL",	["M16A4_ACG_GL"] ],
		["CAPTAIN", "SOLDIER",	["SCAR_L_STD_EGLM_RCO","M4A3_RCO_GL_EP1","M4A1_RCO_GL"] ],
		["CAPTAIN", "AT",	["Javelin"] ],
		["CAPTAIN", "SNIPER",	["M110_NVG_EP1"] ],
		["CAPTAIN", "MG",	["m240_scoped_EP1"] ],

		["MAJOR",   "ALL",	[] ],
		["MAJOR",   "SOLDIER",	["SCAR_H_STD_EGLM_Spect"] ],
		["MAJOR",   "AT",	[] ],
		["MAJOR",   "SNIPER",	["m107","SCAR_H_LNG_Sniper_SD"] ],
		["MAJOR",   "MG",	[] ],

		["COLONEL", "ALL",	[] ],
		["COLONEL", "SOLDIER",	[] ],
		["COLONEL", "AT",	[] ],
		["COLONEL", "SNIPER",	["m107_TWS_EP1","M110_TWS_EP1"] ],
		["COLONEL", "MG",	["M249_TWS_EP1"] ]
	];

	_m = _m + [

		"SmokeShell","SmokeShellYellow","SmokeShellRed","SmokeShellGreen","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange","PipeBomb","HandGrenade_West","Mine",
		"Laserbatteries","17Rnd_9x19_glock17",

		"100Rnd_762x51_M240","10Rnd_127x99_m107","15Rnd_9x19_M9","1Rnd_HE_M203","1Rnd_Smoke_M203","1Rnd_SmokeGreen_M203","1Rnd_SmokeRed_M203","1Rnd_SmokeYellow_M203",
		"20Rnd_556x45_Stanag","20Rnd_762x51_B_SCAR","20Rnd_762x51_DMR","20Rnd_762x51_SB_SCAR","200Rnd_556x45_M249","30Rnd_556x45_Stanag","30Rnd_556x45_StanagSD",
		"30Rnd_9x19_MP5","30rnd_9x19_MP5SD","5Rnd_762x51_M24","8Rnd_B_Beneli_74Slug","Dragon_EP1","FlareGreen_M203","FlareRed_M203","FlareWhite_M203","FlareYellow_M203","Javelin",
		"M136","MAAWS_HEAT","MAAWS_HEDP","Stinger"
	];
};
