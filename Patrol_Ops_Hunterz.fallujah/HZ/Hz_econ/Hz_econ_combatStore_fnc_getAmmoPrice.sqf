private ["_return","_ammo"];

_ammo = toupper _this;

_return = switch (_ammo) do {
 
//AT 
//SMAW
case "RHS_AMMO_SMAW_SR": {7};

//46x30 
case "RHS_AMMO_46X30_FMJ": {0.5};
case "RHS_AMMO_46X30_JHP": {0.75};
case "RHS_AMMO_46X30_AP": {1};

//545x39
case "RHS_B_545X39_BALL": {0.25};
case "RHS_B_545X39_BALL_TRACER_GREEN": {0.5};
case "RHS_B_545X39_7N6_BALL": {0.25};
case "RHS_B_545X39_7N10_BALL": {0.5};
case "RHS_B_545X39_7N22_BALL": {0.75};
case "RHS_B_545X39_7U1_BALL": {0.5};

//556x45
case "B_556X45_BALL_TRACER_YELLOW": {1};
case "B_556X45_BALL_TRACER_GREEN": {1};
case "B_556X45_BALL_TRACER_RED": {1};
case "B_556X45_BALL": {0.33};
case "RHS_AMMO_556X45_BLANK": {0.37};
case "RHS_AMMO_556X45_M855A1_BALL_ORANGE": {0.56};
case "RHS_AMMO_556X45_M855A1_BALL_YELLOW": {0.56};
case "RHS_AMMO_556X45_M855A1_BALL_GREEN": {0.56};
case "RHS_AMMO_556X45_M855A1_BALL_RED": {0.56};
case "RHS_AMMO_556X45_M855A1_BALL": {0.48};
case "RHS_AMMO_556X45_MK262_BALL": {2.5};
case "RHS_AMMO_556X45_MK318_BALL": {1};

case "RH_556X45_B_M855A1": {3};
case "RH_556X45_B_MK262": {2.5};
case "RH_556X45_B_MK318": {0.85};

//762x39
case "RHS_B_762X39_BALL": {0.5};
case "RHS_B_762X39_TRACER": {0.75};
case "RHS_B_762X39_BALL_89": {0.75};
case "RHS_B_762X39_U_BALL": {0.85};

//762x51
case "RHS_AMMO_762X51_M118_SPECIAL_BALL": {1.5};
case "RHS_AMMO_762X51_M62_TRACER": {1.75};
case "RHS_AMMO_762X51_M993_BALL": {3.3};

case "RHS_AMMO_762X51_M82_BLANK" : {2};
case "RHS_AMMO_762X51_M80A1EPR_BALL": {1.25};
case "RHS_AMMO_762X51_M61_AP": {4.5};
case "RHS_AMMO_762X51_M80_BALL": {1.75};

case "RH_762X51_B_M80A1": {1.25};
case "RH_762x51_B_Mk316LR": {0.8};
case "RH_762x51_B_LFMJSB": {-1};

//762x54
case "RHS_B_762X54_BALL": {1.25};
case "RHS_B_762X54_BALL_TRACER_GREEN": {1.25};
case "RHS_B_762X54_7N13_BALL": {1.5};
case "RHS_B_762X54_7N26_BALL": {2};
case "RHS_B_762X54_7BZ3_BALL": {1.5};
case "RHS_B_762X54_7N1_BALL": {0.68};

//.300 blk
case "RH_762X35_B_FMJ": {1};
case "RH_762X35_B_MATCH": {1};
case "RH_762X35_B_MSB": {1};

//.300WM
case "RHSUSF_B_300WINMAG": {1};

//.338 lap
case "B_338_BALL": {6};

//9x19
case "RHS_B_9X19_7N21": {0.25};
case "RHS_B_9X19_7N31": {0.25};

case "RH_9X19_B_M822": {-1};
case "RH_9X19_B_HP": {0.45};
case "RH_9X19_B_HPSB": {-1};

////9x39
case "RHS_B_9X39_SP5": {3};
case "RHS_B_9X39_SP6": {4};

//12.7x99 BMG
case "RHSUSF_AMMO_127X99_MK211": {30};
case "RHSUSF_AMMO_127X99_M33_BALL": {3};

//12 ga
case "RHS_AMMO_12G_FRAG": {25};
case "RHS_AMMO_12G_HE": {20};
case "RHS_AMMO_12G_SLUG": {0.66};
case "RHS_AMMO_DOOMSDAY_BUCKSHOT": {100};
case "RHS_AMMO_12G_00BUCKSHOT": {0.5};

//40mm
case "RHSUSF_40MM_HE": {15};
case "RHSUSF_40MM_HEDP": {20}; 
case "RHS_AMMO_M397": {55};
case "RHS_AMMO_M576_BUCKSHOT": {15};
case "RHSUSF_40MM_PRACTICE": {10};
case "RHS_G_VG40SZ": {30};
case "RHSUSF_40MM_WHITE": {15};
case "RHSUSF_40MM_GREEN": {15};
case "RHSUSF_40MM_RED": {15};
case "RHS_40MM_SMOKE_RED": {10};
case "RHS_40MM_SMOKE_WHITE": {10};
case "RHS_40MM_SMOKE_GREEN": {10};
case "RHS_40MM_SMOKE_YELLOW": {10};
case "F_HUNTIR": {400};
				
default {-1};

};

_return