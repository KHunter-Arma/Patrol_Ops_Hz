// Written by EightySix
// Declares the Ammobox Type (suitable for TvT)

// Arma 2
_ammoboxes = ["USSpecialWeaponsBox","RUSpecialWeaponsBox","GuerillaCacheBox"];

// Arma 2 OA
if(mps_oa) then { _ammoboxes = ["USBasicWeapons_EP1","TKBasicWeapons_EP1","LocalBasicAmmunitionBox"]; };


// =========================================================================================================
//	DO NOT TOUCH CODE BELOW THIS LINE
// =========================================================================================================

mission_base_ammobox = switch (side player) do {
	case WEST: {_ammoboxes select 0};
	case EAST: {_ammoboxes select 1};
	case resistance: {_ammoboxes select 2};
	default {_ammoboxes select 0};
};

mission_mobile_ammo = switch (side player) do {
	case WEST: {_ammoboxes select 0};
	case EAST: {_ammoboxes select 1};
	case resistance: {_ammoboxes select 2};
	default {_ammoboxes select 0};
};