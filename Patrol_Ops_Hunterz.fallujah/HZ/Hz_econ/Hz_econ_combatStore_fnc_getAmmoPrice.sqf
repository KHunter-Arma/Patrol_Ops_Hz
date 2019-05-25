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

//.303 Lee Enfield
case "CUP_B_303_BALL": {1.06};

//.30-06 M1
case "RHS_AMMO_762X63_M1T_TRACER": {1.5};
case "RHS_AMMO_762X63_M2B_BALL": {0.75};



//545x39
case "RHS_B_545X39_BALL": {0.25};
case "RHS_B_545X39_BALL_TRACER_GREEN": {0.5};
case "RHS_B_545X39_7N6_BALL": {0.25};
case "RHS_B_545X39_7N10_BALL": {0.5};
case "RHS_B_545X39_7N22_BALL": {0.75};
case "RHS_B_545X39_7U1_BALL": {0.5};

case "CUP_B_545X39_BALL_TRACER_GREEN": {0.5};
case "CUP_B_545X39_BALL": {0.25};
case "CUP_B_545X39_BALL_TRACER_RED": {0.5};
case "CUP_B_545X39_BALL_TRACER_WHITE": {0.5};
case "CUP_B_545X39_BALL_TRACER_YELLOW": {0.5};

case "FH_545X39_EP": {0.5};
case "FH_545X39_BALL": {0.25};
case "FH_545X39_TRACER": {0.5};
case "FH_545X39_7U1": {0.5};



//.22 LR
case "RH_B_22LR_SD": {-1};



//556x45
case "B_556X45_BALL_TRACER_YELLOW": {1};
case "B_556X45_BALL_TRACER_GREEN": {1};
case "B_556X45_BALL_TRACER_RED": {1};
case "B_556X45_BALL": {3};

case "RHS_AMMO_556X45_BLANK": {0.33};
case "RHS_AMMO_556X45_M855_BALL": {0.5};
case "RHS_AMMO_556X45_M855A1_BALL_ORANGE": {1};
case "RHS_AMMO_556X45_M855A1_BALL_YELLOW": {1};
case "RHS_AMMO_556X45_M855A1_BALL_GREEN": {1};
case "RHS_AMMO_556X45_M855A1_BALL_RED": {1};
case "RHS_AMMO_556X45_M855A1_BALL": {3};
case "RHS_AMMO_556X45_MK262_BALL": {2.5};
case "RHS_AMMO_556X45_MK318_BALL": {0.85};
case "RHS_AMMO_556X45_M855_BALL": {0.5};
case "RHS_AMMO_556X45_M855_BALL_RED": {1};
case "RHSSAF_AMMO_556X45_BALL_TRACER_DIM": {1};

case "RH_556X45_B_M855A1": {3};
case "RH_556X45_B_MK262": {2.5};
case "RH_556X45_B_MK318": {0.85};

case "HLC_556NATO_EPR": {3};
case "HLC_B_556X45_BALL_TRACER_DIM": {1};
case "HLC_556NATO_EPR_TRACER": {3.5};
case "HLC_556NATO_SPR": {2.5};
case "HLC_556NATO_SOST": {0.85};



//6.8
case "HLC_68X43_OTM": {1.25};
case "HLC_68x43_FMJ": {0.8};
case "HLC_68X43_IRDIM": {1};



//7.5
case "HLC_GP11_APBT": {1.5};
case "HLC_GP11_FMJ": {0.75};
case "HLC_GP11_TRACER": {1};



//762x25
case "RHS_AMMO_762X25_BALL": {0.25};
case "RH_762X25": {0.25};


//.300 blk
case "RH_762X35_B_FMJ": {1};
case "RH_762X35_B_MATCH": {1};
case "RH_762X35_B_MSB": {1};
case "HLC_300BLACKOUT_BALL": {0.9};
case "HLC_300BLACKOUT_RNBT": {1};
case "HLC_300BLACKOUT_SMK": {0.75};




//762x39
case "RHS_B_762X39_BALL": {0.25};
case "RHS_B_762X39_TRACER": {2};
case "RHS_B_762X39_BALL_89": {0.75};
case "RHS_B_762X39_U_BALL": {0.85};

case "HLC_762X39_AP": {2};
case "HLC_762X39_BALL": {0.25};
case "HLC_762X39_TRACER": {2};



//762x51
case "B_762X51_BALL": {0.5};

case "RHS_AMMO_762X51_M118_SPECIAL_BALL": {1.5};
case "RHS_AMMO_762X51_M62_TRACER": {1.75};
case "RHS_AMMO_762X51_M993_BALL": {3.3};

case "RHS_AMMO_762X51_M82_BLANK" : {2};
case "RHS_AMMO_762X51_M80A1EPR_BALL": {1.25};
case "RHS_AMMO_762X51_M61_AP": {4.5};
case "RHS_AMMO_762X51_M80_BALL": {1.75};

case "RH_762X51_B_M80A1": {1.25};
case "RH_762x51_B_Mk316LR": {0.8};
case "RH_762x51_B_LFMJSB": {2.50};

case "CUP_B_762X51_TRACER_WHITE_SPLASH": {1.75};
case "CUP_B_762X51_TRACER_RED_SPLASH": {1.75};

case "HLC_762X51_BALL": {1.75};
case "HLC_B_762X51_TRACER_DIM": {2};
case "HLC_762X51_MK316_20IN": {0.8};
case "HLC_762X51_BARRIER": {0.75};
case "HLC_762X51_BTSUB": {1};
case "HLC_762X51_TRACER": {1};



//762x54
case "RHS_B_762X54_BALL": {0.25};
case "RHS_B_762X54_BALL_TRACER_GREEN": {1.5};
case "RHS_B_762X54_7N13_BALL": {1.5};
case "RHS_B_762X54_7N26_BALL": {2};
case "RHS_B_762X54_7BZ3_BALL": {1.5};
case "RHS_B_762X54_7N1_BALL": {0.68};
case "CUP_B_762X54_BALL_WHITE_TRACER": {1.5};
case "CUP_B_762X54_BALL_GREEN_TRACER": {1.5};



//.300WM
case "RHSUSF_B_300WINMAG": {1};
case "HLC_300WM_AP": {2};
case "HLC_300WM_BTHP": {2};
case "HLC_300WM_BTSP": {2};
case "HLC_300WM_S_BT": {1.5};
case "HLC_300WM_TRACER": {1};



//30-06
case "HLC_3006_FMJ": {0.65};



//7.92x33
case "RHS_AMMO_792X33_SME_BALL": {0.5};

//7.92x57
case "RHS_AMMO_792X57_BALL": {1.5};
case "HLC_792X57_AP": {1.5};
case "HLC_792X57_TRACER": {2.5};
case "HLC_792X57_BALL": {0.5};



//.338 lap
case "B_338_BALL": {6};



//9x17
case "RHS_AMMO_9X17": {0.33};



//9x18
case "RH_9X18_BALL": {0.25};
case "RHS_B_9X18_57N181S": {0.25};


//9x19
case "RHS_B_9X19_7N21": {0.3};
case "RHS_B_9X19_7N31": {0.45};
case "RHS_AMMO_9X19_FMJ": {0.25};
case "RHS_AMMO_9X19_JHP": {0.45};

case "RH_B_9X19_BALL": {0.25};
case "CUP_B_9X19_BALL": {0.25};
case "RH_9X19_B_M822": {0.25};
case "RH_9X19_B_HP": {0.45};
case "RH_9X19_B_HPSB": {0.65};
case "B_9X21_BALL": {0.25};

case "HLC_9X19_BALL": {0.25};
case "HLC_9X19_JHP": {0.45};
case "HLC_9X19_SUBSONIC": {0.33};
case "HLC_9x19_JHP_SMG": {0.45};
case "HLC_9X19_M882_SMG": {0.25};


//Starter pistol flares
case "F_40MM_GREEN": {1.75};
case "F_40MM_RED": {1.75};

////9x39
case "RHS_B_9X39_SP5": {3};
case "RHS_B_9X39_SP6": {4};



//93x64
case "CUP_B_93X64_BALL": {0.57};

//.357 SIG 
case "HLC_357SIG_FMJ": {0.38};
case "HLC_357SIG_JHP": {0.46};

//.40 SW
case "HLC_40SW_FMJ": {0.28};
case "HLC_40SW_JHP": {0.65};
case "HLC_40SW_SD": {0.5};

//.45 ACP
case "RHS_AMMO_45ACP_MHP": {0.33};
case "B_45ACP_BALL_GREEN": {0.33};
case "B_45ACP_BALL": {0.33};
case "RH_45ACP": {0.33};

//10 mm 
case "HLC_10MM_FMJ": {0.57};
case "HLC_10MM_JHP": {1};


//.50 AE
case "RH_50_AE_BALL": {1.71};



//12.7x99 BMG
case "B_127X99_BALL": {3};
case "B_127X99_BALL_TRACER_RED": {5};
case "B_127X99_BALL_TRACER_GREEN": {5};
case "B_127X99_BALL_TRACER_YELLOW": {5};

case "RHSUSF_AMMO_127X99_MK211": {30};
case "RHSUSF_AMMO_127X99_M33_BALL": {7};
case "RHS_AMMO_127X99_BALL": {3};
case "RHS_AMMO_127X99_BALL_TRACER_RED": {5};
case "RHS_AMMO_127X99_BALL_TRACER_GREEN": {5};
case "RHS_AMMO_127X99_BALL_TRACER_YELLOW": {5};



//12 ga
case "RHS_AMMO_12G_FRAG": {25};
case "RHS_AMMO_12G_HE": {20};
case "RHS_AMMO_12G_SLUG": {0.66};
case "RHS_AMMO_DOOMSDAY_BUCKSHOT": {100};
case "RHS_AMMO_12G_00BUCKSHOT": {0.5};



//40mm
case "F_HUNTIR": {400};

case "G_40MM_SMOKEBLUE": {15};
case "G_40MM_SMOKEGREEN": {15};
case "G_40MM_SMOKEORANGE": {15};
case "G_40MM_SMOKEPURPLE": {15};
case "G_40MM_SMOKERED": {15};
case "G_40MM_SMOKE": {15};
case "G_40MM_SMOKEYELLOW": {15};
case "G_40MM_HE": {10};

case "RHSUSF_40MM_HE": {15};
case "RHSUSF_40MM_HEDP": {20}; 
case "RHS_AMMO_M397": {55};
case "RHS_AMMO_M576_BUCKSHOT": {15};
case "RHSUSF_40MM_PRACTICE": {10};
case "RHSUSF_40MM_WHITE": {15};
case "RHSUSF_40MM_GREEN": {15};
case "RHSUSF_40MM_RED": {15};
case "RHS_40MM_SMOKE_RED": {10};
case "RHS_40MM_SMOKE_WHITE": {10};
case "RHS_40MM_SMOKE_GREEN": {10};
case "RHS_40MM_SMOKE_YELLOW": {10};
case "RHS_AMMO_MK19M3_M384": {28};
case "RHS_AMMO_MK19M3_M430I": {28};
case "RHS_AMMO_MK19M3_M1001": {32};

case "RHS_G_GDM40": {15};
case "RHS_G_VG40MD_GREEN": {10};
case "RHS_G_VG40MD_RED": {10};
case "RHS_G_VG40MD_WHITE": {10};
case "RHS_40MM_GREEN": {10};
case "RHS_40MM_RED": {10};
case "RHS_40MM_WHITE": {10};
case "RHS_G_VG40SZ": {25};
case "RHS_G_VG40TB": {30};
case "RHS_G_VOG25": {10};
case "RHS_G_VOG25P": {15};





//SPG-9 ammo
case "RHS_AMMO_PG9V": {409};
case "RHS_AMMO_PG9N": {409};
case "RHS_AMMO_PG9VNT": {409};
case "RHS_AMMO_OG9VM": {409};
case "RHS_AMMO_OG9V": {409};

case "CUP_SH_PG9_AT": {409};
case "CUP_SH_OG9_HE": {409};



//various non standardized ammunition
case "RH_57X28MM": {0.48};
case "RH_357MAG_BALL": {0.32};
case "RH_32ACP": {0.37};
case "RH_B_40SW": {0.28};
case "RH_44MAG_BALL": {0.79};
case "RH_454_CASULL": {1.34};

default {-1};

};

_return
