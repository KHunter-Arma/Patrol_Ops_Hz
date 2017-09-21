// Written by BON_IF
// Adapted by EightySix
// ADD BACKPACKS TO THE LIST TO HAVE THEM APPEAR IN THE BACKPACK MENU

if(mps_co) then {

[] spawn {
	WaitUntil{ !(isNull player) };

	_bkpk = [];

// Default BIS Backpacks
	if(side player == west) then {
		if(mps_aaw) then { _bkpk = _bkpk + ["aaw_AlicePack_dpcu"]; };	// AAW Backpack

		_bkpk = _bkpk + [
			"USBasicBag",
			"US_Assault_Pack_EP1",
			"US_Patrol_Pack_EP1",
			"US_Backpack_EP1",
			"TOW_TriPod_US_Bag_EP1",
			"M252_US_Bag_EP1",
			"MK19_TriPod_US_Bag_EP1",
			"M2HD_mini_TriPod_US_Bag_EP1",
			"M2StaticMG_US_Bag_EP1",
			"Tripod_Bag"
		];
	};

	if(side player == east) then {
		_bkpk = _bkpk + [
			"TK_RPG_Backpack_EP1",
			"TK_ALICE_Pack_EP1",
			"TKA_ALICE_Pack_Ammo_EP1",
			"TK_Assault_Pack_EP1",
			"TKA_Assault_Pack_Ammo_EP1",
			"SPG9_TK_INS_Bag_EP1",
			"Metis_TK_Bag_EP1",
			"2b14_82mm_TK_Bag_EP1",
			"AGS_TK_Bag_EP1",
			"KORD_TK_Bag_EP1",
			"KORD_high_TK_Bag_EP1",
			"DSHkM_Mini_TriPod_TK_INS_Bag_EP1",
			"DSHKM_TK_INS_Bag_EP1",
			"Tripod_Bag"
		];
	};

	if(mps_aaw && side player == west) then {
		_bkpk = _bkpk + ["aaw_AlicePack_dpcu"];
	};

	{ _bkpk = (_bkpk - [_x]) + [_x]; } foreach _bkpk;

	bon_getbackpack_backpacks = _bkpk;
};

};
/*
"USBasicBag",
"US_UAV_Pack_EP1",
"US_Assault_Pack_EP1",
"US_Assault_Pack_Ammo_EP1",
"US_Assault_Pack_AmmoSAW_EP1",
"US_Assault_Pack_AT_EP1",
"US_Assault_Pack_Explosives_EP1",
"US_Patrol_Pack_EP1",
"US_Patrol_Pack_Ammo_EP1",
"US_Patrol_Pack_Specops_EP1",
"US_Backpack_EP1",
"US_Backpack_AmmoMG_EP1",
"US_Backpack_AT_EP1",
"US_Backpack_Specops_EP1",

"DE_Backpack_Specops_EP1",
"CZ_Backpack_EP1",
"CZ_Backpack_Ammo_EP1",
"CZ_Backpack_Specops_EP1",
"CZ_Backpack_AmmoMG_EP1",
"CZ_VestPouch_EP1",
"CZ_VestPouch_Sa58_EP1",
"CZ_VestPouch_M4_EP1",

"TK_RPG_Backpack_EP1",
"TK_ALICE_Pack_EP1",
"TK_ALICE_Pack_Explosives_EP1",
"TK_ALICE_Pack_AmmoMG_EP1",
"TKA_ALICE_Pack_Ammo_EP1",
"TKG_ALICE_Pack_AmmoAK47_EP1",
"TKG_ALICE_Pack_AmmoAK74_EP1",
"TK_Assault_Pack_EP1",
"TK_Assault_Pack_RPK_EP1",
"TKA_Assault_Pack_Ammo_EP1",

"Tripod_Bag",
"SPG9_TK_INS_Bag_EP1",
"SPG9_TK_GUE_Bag_EP1",
"TOW_TriPod_US_Bag_EP1",
"Metis_TK_Bag_EP1",
"2b14_82mm_TK_INS_Bag_EP1",
"2b14_82mm_TK_GUE_Bag_EP1",
"2b14_82mm_TK_Bag_EP1",
"M252_US_Bag_EP1",
"AGS_UN_Bag_EP1",
"AGS_TK_INS_Bag_EP1",
"AGS_TK_GUE_Bag_EP1",
"AGS_TK_Bag_EP1",
"MK19_TriPod_US_Bag_EP1",
"KORD_UN_Bag_EP1",
"KORD_TK_Bag_EP1",
"KORD_high_UN_Bag_EP1",
"KORD_high_TK_Bag_EP1",
"DSHkM_Mini_TriPod_TK_INS_Bag_EP1",
"DSHkM_Mini_TriPod_TK_GUE_Bag_EP1",
"DSHKM_TK_INS_Bag_EP1",
"DSHKM_TK_GUE_Bag_EP1",
"M2HD_mini_TriPod_US_Bag_EP1",
"M2StaticMG_US_Bag_EP1",

*/