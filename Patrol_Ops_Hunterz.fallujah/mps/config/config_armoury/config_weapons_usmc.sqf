if(mps_ace_enabled) then {
	_w = _w +  [
		"NVGoggles","ItemCompass","Laserdesignator","ACE_SOFLAMTripod","ACE_SpottingScope","ACE_Rangefinder_OD","ACE_SpottingScope","ACE_Kestrel4500","ACE_HuntIR_monitor",
		"ItemGPS","ItemWatch","ACE_Earplugs","ACE_Map","ACE_ParachutePack","ACE_GlassesBalaklava","ACE_GlassesLHD_glasses","ACE_GlassesSunglasses",
		"ACE_GlassesTactical","ACE_GlassesGasMask_US","ACE_Backpack_US","ACE_Rucksack_MOLLE_ACU","ACE_Rucksack_MOLLE_ACU_Medic","ACE_CharliePack","ACE_ANPRC77","ACE_KeyCuffs",
		"ACE_M252Proxy","ACE_M252TripodProxy","ACE_DAGR","ACE_Map_Tools","ACE_GlassesBlackSun","ACE_SpareBarrel",

		"ACE_Glock18","ACE_P226","ACE_P8","ACE_USP","ACE_USPSD","M9","M9SD","Colt1911"
	];

	_list = _list + [
		["PRIVATE", "ALL",	["ACE_HK416_D10","ACE_HK416_D14","M1014","ACE_M1014_Eotech","M16A2","ACE_M4","ACE_M16A4_Iron","ACE_MP5A5","ACE_MP5SD","ACE_UMP45","M79_EP1","ACE_WireCutter","ACE_HK416_D10_COMPM3_SD"] ],
		["PRIVATE", "SOLDIER",	["ACE_SPAS12","ACE_M27_IAR","M4A1","M4A1_Aim","M4A1_Aim_camo","ACE_M4A1_C","ACE_M4A1_GL"] ],
		["PRIVATE", "AT",	["ACE_M72A2","Stinger"] ],
		["PRIVATE", "SNIPER",	["M24","ACE_HK417_Shortdot","ACE_SOC_M4A1_SHORTDOT","ACE_M14_ACOG"] ],
		["PRIVATE", "MG",	["M249","M240"] ],

		["CORPORAL", "ALL",	["M4A1_Aim_camo","ACE_HK417_micro","ACE_HK416_D10_M320","ACE_HK416_D10_COMPM3","ACE_HK416_D10_SD","ACE_HK416_D10_AIM","ACE_HK416_D14_SD","M16A2GL","m16a4","ACE_M4_Aim","ACE_M4_GL","ACE_M72A2","ACE_UMP45_SD"] ],
		["CORPORAL", "SOLDIER",	["ACE_M27_IAR_CCO","ACE_SOC_M4A1","ACE_M4A1_Aim_SD","M4A1_AIM_SD_camo","ACE_M4A1_Eotech","ACE_SOC_M4A1_GL"] ],
		["CORPORAL", "AT",	["ACE_M136_CSRS","M136"] ],
		["CORPORAL", "SNIPER",	["M40A3","ACE_SOC_M4A1_SHORTDOT_SD","DMR","M110_NVG_EP1"] ],
		["CORPORAL", "MG",	["ACE_M249_AIM","ACE_M240L","ACE_M60"] ],

		["SERGEANT", "ALL",	["M4A1_HWS_GL_camo","ACE_HK416_D10_Holo","ACE_HK416_D14_COMPM3_M320","ACE_M16A4_EOT","M16A4_GL","ACE_M16A4_CCO_GL","ACE_M4_Eotech","ACE_M4_AIM_GL","ACE_UMP45_AIM","ACE_SOC_M4A1_SD_9"] ],
		["SERGEANT", "SOLDIER",	["ACE_M4A1_AIM_GL","ACE_M4A1_AIM_GL_SD","ACE_M27_IAR_ACOG","ACE_SOC_M4A1_Eotech"] ],
		["SERGEANT", "AT",	["SMAW"] ],
		["SERGEANT", "SNIPER",	["M4SPR","ACE_M4SPR_SD","ACE_HK417_leupold"] ],
		["SERGEANT", "MG",	["ACE_M240B","ACE_M240L_M145"] ],

		["LIEUTENANT", "ALL",	["M4A3_RCO_GL_EP1","ACE_HK417_Eotech_4x","ACE_M16A4_EOT_GL","m16a4_acg","ACE_M4_Eotech_GL","ACE_UMP45_AIM_SD"] ],
		["LIEUTENANT", "SOLDIER",["ACE_M4A1_EOT_SD","ACE_SOC_M4A1_EOT_SD","ACE_SOC_M4A1_Eotech_4x","ACE_SOC_M4A1_GL_AIMPOINT","ACE_SOC_M4A1_Aim","ACE_SOC_M4A1_AIM_SD","ACE_SOC_M4A1_GL_EOTECH","M4A1_HWS_GL","M4A1_HWS_GL_camo","M4A1_HWS_GL_SD_Camo"] ],
		["LIEUTENANT", "AT",	[] ],
		["LIEUTENANT", "SNIPER",["ACE_Mk12mod1","ACE_Mk12mod1_SD"] ],
		["LIEUTENANT", "MG",	["Mk_48"] ],

		["CAPTAIN", "ALL",	["ACE_M4_ACOG","ACE_M4_ACOG_PVS14","ACE_HK416_D14_ACOG_PVS14","M16A4_ACG_GL"] ],
		["CAPTAIN", "SOLDIER",	["ACE_M4A1_ACOG","ACE_M4A1_ACOG_PVS14","ACE_M4A1_ACOG_SD","ACE_SOC_M4A1_RCO_GL","M4A1_RCO_GL"] ],
		["CAPTAIN", "AT",	["ACE_Javelin_CLU","ACE_Javelin_Direct"] ],
		["CAPTAIN", "SNIPER",	["ACE_M110","ACE_M110_SD"] ],
		["CAPTAIN", "MG",	["ACE_M249_PIP_ACOG"] ],

		["MAJOR",   "ALL",	["ACE_M4_RCO_GL","ACE_SOC_M4A1_Eotech_4x_F"] ],
		["MAJOR",   "SOLDIER",	[] ],
		["MAJOR",   "AT",	[] ],
		["MAJOR",   "SNIPER",	["m107","ACE_AS50","ACE_TAC50","ACE_TAC50_SD"] ],
		["MAJOR",   "MG",	[] ],

		["COLONEL", "ALL",	["ACE_SOC_M4A1_RCO_GL_F"] ],
		["COLONEL", "SOLDIER",	["ACE_SOC_M4A1_TWS"] ],
		["COLONEL", "AT",	[] ],
		["COLONEL", "SNIPER",	["ACE_HK416_D14_TWS"] ],
		["COLONEL", "MG",	[] ]
	];

	_m = _m + [
		"SmokeShell","SmokeShellYellow","SmokeShellRed","SmokeShellGreen","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange","PipeBomb","HandGrenade_West","1Rnd_Smoke_M203","1Rnd_Smoke_M203","1Rnd_SmokeGreen_M203","1Rnd_SmokeYellow_M203","IR_Strobe_Target",
		"Mine","ACE_Claymore_M","ACE_BBetty_M","ACE_M4SLAM_M","ACE_TripFlare_M","ACE_Rope_M_50","ACE_Rope_M_90","ACE_Rope_M_120","ACE_Rope_TOW_M_5","ACE_Rope_M5","Laserbatteries",
		"ACE_BATTERY_RANGEFINDER","ACE_KNICKLICHT_W","ACE_KNICKLICHT_R","ACE_KNICKLICHT_Y","ACE_KNICKLICHT_G","ACE_KNICKLICHT_B","ACE_KNICKLICHT_IR",

		"10Rnd_127x99_m107","15Rnd_9x19_M9","30Rnd_556x45_Stanag","5Rnd_762x51_M24","7Rnd_45ACP_1911","ACE_1Rnd_CS_M203","ACE_1Rnd_HE_M203","ACE_SSGreen_M203","ACE_20Rnd_762x51_SB_SCAR",
		"ACE_SSRed_M203","ACE_SSRed_M203","ACE_SSWhite_M203","ACE_SSWhite_M203","ACE_SSYellow_M203","FlareRed_M203","FlareWhite_M203", "100Rnd_762x51_M240","ACE_20Rnd_762x51_S_DMR",
		"ACE_100Rnd_556x45_T_M249","ACE_200Rnd_556x45_T_M249","ACE_20Rnd_762x51_S_SCAR","ACE_20Rnd_762x51_T_DMR","ACE_20Rnd_762x51_T_HK417","ACE_20Rnd_762x51_T_SCAR","ACE_20Rnd_762x51_B_HK417","ACE_20Rnd_762x51_SB_HK417",
		"ACE_30Rnd_556x45_S_Stanag","ACE_30Rnd_556x45_T_Stanag","ACE_30Rnd_9x19_S_MP5", "ACE_5Rnd_127x99_B_TAC50","ACE_5Rnd_127x99_S_TAC50","ACE_5Rnd_127x99_T_TAC50","30Rnd_556x45_StanagSD",
		"ACE_8Rnd_12Ga_Buck00","ACE_8Rnd_12Ga_Slug","ACE_30Rnd_6x35_B_PDW","ACE_25Rnd_1143x23_B_UMP45","ACE_25Rnd_1143x23_S_UMP45","ACE_FlareIR_M203","ACE_HuntIR_M203","ACE_20Rnd_556x45_S_Stanag",
		"ACE_Javelin_Direct","ACE_M136_CSRS","ACE_M576","ACE_M72A2","ACE_SMAW_NE","SMAW_HEAA","SMAW_HEDP","Stinger","ACE_M252HE_CSWDM","ACE_M252WP_CSWDM","ACE_M252IL_CSWDM","ACE_SMAW_Spotting","ACE_12Rnd_45ACP_USP","ACE_15Rnd_9x19_P226","ACE_15Rnd_9x19_P8","ACE_33Rnd_9x19_G18"
	];

}else{
	_w = _w +  ["Binocular","NVGoggles","ItemCompass","ItemGPS","ItemMap","ItemRadio","ItemWatch","Laserdesignator","M9","M9SD","Colt1911"];

	_list = _list + [
		["PRIVATE", "ALL",	["M1014","M16A2","MP5A5","MP5SD"] ],
		["PRIVATE", "SOLDIER",	["M4A1","M4A1_Aim","M4A1_Aim_camo"] ],
		["PRIVATE", "AT",	["M136","Stinger"] ],
		["PRIVATE", "SNIPER",	["M24"] ],
		["PRIVATE", "MG",	["M249","M240"] ],

		["CORPORAL", "ALL",	["M16A2GL","m16a4","M136"] ],
		["CORPORAL", "SOLDIER",	["M4A1_AIM_SD_camo"] ],
		["CORPORAL", "AT",	[] ],
		["CORPORAL", "SNIPER",	["M40A3","DMR"] ],
		["CORPORAL", "MG",	[] ],

		["SERGEANT", "ALL",	["M16A4_GL"] ],
		["SERGEANT", "SOLDIER",	[] ],
		["SERGEANT", "AT",	["SMAW"] ],
		["SERGEANT", "SNIPER",	["M4SPR"] ],
		["SERGEANT", "MG",	[] ],

		["LIEUTENANT", "ALL",	["m16a4_acg"] ],
		["LIEUTENANT", "SOLDIER",["M4A1_HWS_GL","M4A1_HWS_GL_camo","M4A1_HWS_GL_SD_Camo"] ],
		["LIEUTENANT", "AT",	[] ],
		["LIEUTENANT", "SNIPER",[] ],
		["LIEUTENANT", "MG",	["Mk_48"] ],

		["CAPTAIN", "ALL",	["M16A4_ACG_GL"] ],
		["CAPTAIN", "SOLDIER",	["M4A1_RCO_GL"] ],
		["CAPTAIN", "AT",	["Javelin"] ],
		["CAPTAIN", "SNIPER",	[] ],
		["CAPTAIN", "MG",	[] ],

		["MAJOR",   "ALL",	[] ],
		["MAJOR",   "SOLDIER",	[] ],
		["MAJOR",   "AT",	[] ],
		["MAJOR",   "SNIPER",	["m107"] ],
		["MAJOR",   "MG",	[] ],

		["COLONEL", "ALL",	[] ],
		["COLONEL", "SOLDIER",	[] ],
		["COLONEL", "AT",	[] ],
		["COLONEL", "SNIPER",	[] ],
		["COLONEL", "MG",	[] ]
	];

	_m = _m + [
		"SmokeShell","SmokeShellYellow","SmokeShellRed","SmokeShellGreen","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange","PipeBomb","HandGrenade_West","Mine",
		"100Rnd_762x51_M240","10Rnd_127x99_m107","15Rnd_9x19_M9","1Rnd_HE_M203","1Rnd_Smoke_M203","1Rnd_SmokeGreen_M203","1Rnd_SmokeRed_M203","1Rnd_SmokeYellow_M203",
		"20Rnd_556x45_Stanag","20Rnd_762x51_DMR","200Rnd_556x45_M249","30Rnd_556x45_Stanag","30Rnd_556x45_StanagSD","30Rnd_9x19_MP5","30rnd_9x19_MP5SD","5Rnd_762x51_M24","8Rnd_B_Beneli_74Slug",
		"FlareGreen_M203","FlareRed_M203","FlareWhite_M203","FlareYellow_M203","Javelin","Laserbatteries","M136","SMAW_HEAA","SMAW_HEDP","Stinger"
	];
};