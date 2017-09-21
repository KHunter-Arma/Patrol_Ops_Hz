/* Written by Eightysix

	Inspired by the following:
	 - ACE E.A.S.A
	 - Mandos Missiles
	 - =BTC= Armament System
	 - F2F A.L.S.S.
*/
[] spawn {

waitUntil{ !isNil "mps_ace_enabled" };

mps_aas_weapon_config = [

	[1,"CMFlareLauncher",		"120Rnd_CMFlareMagazine",	"CM Flares"],
	[2,"GAU8",			"1350Rnd_30mmAP_A10",		"GAU8 Cannon"],
	[3,"GAU12",			"300Rnd_25mm_GAU12",		"GAU12 Cannon"],
	[4,"GSh301",			"180Rnd_30mm_GSh301",		"GSH301 Cannon"],
	[5,"GSh302",			"750Rnd_30mm_GSh301",		"GSH302 Cannon"],
	[6,"M197",			"750Rnd_M197_AH1",		"M197 Cannon"],
	[7,"M230",			"1200Rnd_30x113mm_M789_HEDP",	"M230 Cannon"],
	[8,"YakB",			"1470Rnd_127x108_YakB",		"YakB Cannon"],
	[9,"57mmLauncher_64",		"64Rnd_57mm",		"64x 57mm Rockets"],
	[10,"57mmLauncher_128",		"128Rnd_57mm",		"128x 57mm Rockets"],
	[11,"57mmLauncher",		"192Rnd_57mm",		"192x 57mm Rockets"],
	[12,"80mmLauncher",		"40Rnd_80mm",		"40x 80mm Rockets"],
	[13,"S8Launcher",		"80Rnd_S8T",		"80x S8T Rockets"],
	[14,"FFARLauncher_14",		"14Rnd_FFAR",		"14 Hydra Rockets"],
	[15,"FFARLauncher",		"28Rnd_FFAR",		"28 Hydra Rockets"],
	[16,"VikhrLauncher",		"12Rnd_Vikhr_KA50",	"12 Vilkr Rockets"],
	[17,"AirBombLauncher",		"2Rnd_FAB_250",		"2x FAB 250"],
	[18,"AirBombLauncher",		"4Rnd_FAB_250",		"4x FAB 250"],
	[19,"AT2Launcher",		"4Rnd_AT2_Mi24D",	"AT2 Launcher"],
	[20,"AT6Launcher",		"4Rnd_AT6_Mi24V",	"AT6 Launcher"],
	[21,"AT9Launcher",		"4Rnd_AT9_Mi24P",	"AT9 Launcher"],
	[22,"BombLauncherF35",		"2Rnd_GBU12",		"2x Invisible GBU12"],
	[23,"BombLauncherA10",		"4Rnd_GBU12",		"4x GBU12"],
	[24,"BombLauncher",		"6Rnd_GBU12_AV8B",	"6x GBU12"],
	[25,"Ch29Launcher",		"4Rnd_Ch29",		"4x CH29"],
	[26,"Ch29Launcher_Su34",	"6Rnd_Ch29",		"6x CH29"],
	[27,"HeliBombLauncher",		"2Rnd_FAB_250",		"2x FAB 250"],
	[28,"HellfireLauncher",		"8Rnd_Hellfire",	"8x Hellfires"],
	[29,"MaverickLauncher",		"2Rnd_Maverick_A10",	"2x Mavericks"],
	[30,"Mk82BombLauncher",		"3Rnd_Mk82",		"3x Mk82 Bombs"],
	[31,"Mk82BombLauncher_6",	"6Rnd_Mk82",		"6x Mk82 Bombs"],
	[32,"R73Launcher",		"4Rnd_R73",		"4x R73 Missiles"],
	[33,"R73Launcher_2",		"2Rnd_R73",		"2x R73 Missiles"],
	[34,"SidewinderLaucher_AH1Z",	"2Rnd_Sidewinder_AH1Z",	"2x Sidewinders"],
	[35,"SidewinderLaucher",	"4Rnd_Sidewinder_AV8B",	"4x Sidewinders"],
	[36,"SidewinderLaucher_AH64",	"8Rnd_Sidewinder_AH64",	"8x Sidewinders"],
	[37,"SidewinderLaucher_F35",	"2Rnd_Sidewinder_F35",	"2x Sidewinders F35"],
	[38,"GSh23L_L39",		"150Rnd_23mm_GSh23L",	"GSH23L Cannon"],
	[39,"2A42",			"230Rnd_30mmAP_2A42",	"2A42 AP Cannon"],
	[40,"2A42",			"230Rnd_30mmHE_2A42",	"2A42 HE Cannon"],
	[41,"CRV7_FAT",			"6Rnd_CRV7_FAT",	"CRV7 FAT"],
	[42,"CRV7_HEPD",		"6Rnd_CRV7_HEPD",	"CRV7 HEPD"],

	[43,"HellfireLauncher",		"ACE_6Rnd_Hellfire",	"6x Hellfires"],
	[44,"ACE_HellfireLauncher_Apache","ACE_2Rnd_Hellfire_L","2x Hellfires"],
	[45,"ACE_CBU87_Bomblauncher",	"ACE_2Rnd_CBU87",	"2x CBU Cluster"],
	[46,"ACE_CBU87_Bomblauncher",	"ACE_4Rnd_CBU87",	"4x CBU Cluster"],
	[47,"ACE_CBU87_Bomblauncher",	"ACE_6Rnd_CBU87",	"6x CBU Cluster"],
	[48,"ACE_GAU8",			"ACE_1350Rnd_30mmAP_A10","GAU8 Cannon"],
	[49,"ACE_Mk82BombLauncher",	"ACE_2Rnd_Mk82",	"2x Mk82 Bombs"],
	[50,"ACE_Mk82BombLauncher",	"ACE_3Rnd_Mk82",	"3x Mk82 Bombs"],
	[51,"ACE_Mk82BombLauncher",	"ACE_4Rnd_Mk82",	"4x Mk82 Bombs"],
	[52,"ACE_Mk82BombLauncher",	"ACE_6Rnd_Mk82",	"6x Mk82 Bombs"]
];

mps_aas_vehicle_loadout = [

	[ "A10",		1, [2],[29,34],[29,34],[23,31],[14],[1] ],
	[ "A10_US_EP1",		1, [2],[29,34],[29,34],[23,31],[14],[1] ],
	[ "AV8B",		1, [3],[22,29,34],[22,29,34],[22,29,34],[],[1] ],
	[ "AV8B2",		1, [3],[24,31],[29,34],[14],[],[1] ],
	[ "F35B",		1, [3],[22,30],[29,37],[29,37],[],[1] ],
	[ "L39_TK_EP1",		1, [38],[9],[],[],[],[] ],
	[ "Su25_CDF",		1, [4],[33,17],[18,25],[13],[],[1] ],
	[ "Su25_Ins",		1, [4],[33,17],[18,25],[13],[],[1] ],
	[ "Su25_TK_EP1",	1, [4],[33,17],[18,25],[13],[],[1] ],
	[ "Su34",		1, [4],[26,18],[32,25],[12],[],[1] ],
	[ "Su39",		1, [4],[33,17],[18,25],[13],[],[1] ],

	[ "AH1Z",		2, [6],[28,36],[29,34],[15],[],[1] ],
	[ "AH64D",		2, [7],[28,36],[],[],[15],[1] ],
	[ "AH64D_EP1",		2, [7],[28,36],[],[],[15],[1] ],
	[ "BAF_Apache_AH1_D",	2, [7],[28,36],[41,42],[41,42],[],[1] ],
	[ "Ka52",		2, [39,40],[12],[],[],[16],[1] ],
	[ "Ka52Black",		2, [39,40],[12],[],[],[16],[1] ],
	[ "Mi24_D",		2, [8],[19],[],[],[10],[1] ],
	[ "Mi24_D_TK_EP1",	2, [8],[19],[],[],[10],[1] ],
	[ "Mi24_P",		2, [5],[27,33],[],[21],[12],[1] ],
	[ "Mi24_V",		2, [8],[20],[],[],[13],[1] ]

];

if( mps_ace_enabled ) then {
	mps_aas_vehicle_loadout = [
		[ "A10",		1, [48],[29,34],[29,34],[23,51,46],[14],[1] ],
		[ "A10_US_EP1",		1, [48],[29,34],[29,34],[23,51,46],[14],[1] ],
		[ "ACE_A10_CBU87",	1, [48],[29,34],[29,34],[23,51,46],[14],[1] ],
		[ "ACE_A10_Mk82",	1, [48],[29,34],[29,34],[23,51,46],[14],[1] ],
		[ "AV8B",		1, [3],[22,29,34,45],[22,29,34,45],[22,29,34,45],[],[1] ],
		[ "AV8B2",		1, [3],[24,47,52],[29,34,45,49],[14],[],[1] ],
		[ "F35B",		1, [3],[22,45,49],[29,37],[29,37],[],[1] ]
	];
};

mps_aas_supported_vehicles = [];

{ mps_aas_supported_vehicles = mps_aas_supported_vehicles + [ (_x select 0) ]; }forEach mps_aas_vehicle_loadout;

};
