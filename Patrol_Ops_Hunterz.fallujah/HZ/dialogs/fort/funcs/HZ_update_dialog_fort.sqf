
private ["_display","_element","_pic"];
_element = _this select 1;
disableSerialization;


_display = format ["Available funds: $%1",Hz_funds];
ctrlSetText [4136, _display];
if(Hz_funds >= 1000000) then {
        _display = format ["Available funds: $%1 million",(Hz_funds / 1000000)];
        ctrlSetText [4136, _display];
        };


switch (_element) do {
    
      case 0: {// Toyota Corolla (E90)
//        ctrlSetText [4134, "HZ\dialogs\veh\media\toyota_corolla.paa"];
        hz_fort_selected = "MASH_EP1";
        hz_fort_cost = 800;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
}; 

case 1: {// Skoda 1203
 //       ctrlSetText [4134, "HZ\dialogs\veh\media\skoda_1203.paa"];
        hz_fort_selected = "US_WarfareBFieldhHospital_EP1";
        hz_fort_cost = 8000;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
}; 

case 2: {// Toyota Hilux
 //       ctrlSetText [4134, "HZ\dialogs\veh\media\toyota_hilux.paa"];
        hz_fort_selected = "WarfareBDepot";
        hz_fort_cost = 50000;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
};      
case 3: {// Volkswagen Golf (IV)
 //       ctrlSetText [4134, "HZ\dialogs\veh\media\vw_golf.paa"];
        hz_fort_selected = "Stinger_Pod_US_EP1";
        hz_fort_cost = 100000;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
}; 

case 4: {// Skoda Octavia
  //      ctrlSetText [4134, "HZ\dialogs\veh\media\skoda_octavia.paa"];
        hz_fort_selected = "US_WarfareBBarracks_EP1";
        hz_fort_cost = 15000;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
}; 

case 5: {// Chevrolet Tahoe
//        ctrlSetText [4134, "HZ\dialogs\veh\media\Chevrolet_tahoe.paa"];
        hz_fort_selected = "WarfareBMGNest_M240_US_EP1";
        hz_fort_cost = 7000;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
}; 

case 6: {// MTVR
//        ctrlSetText [4134, "HZ\dialogs\veh\media\MTVR_7t.paa"];
        hz_fort_selected = "ACE_ConcertinaWireCoil";
        hz_fort_cost = 800;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
}; 

case 7: {// MTVR Refuel
//        ctrlSetText [4134, "HZ\dialogs\veh\media\MTVR_7t_refuel.paa"];
        hz_fort_selected = "Hhedgehog_concrete";
        hz_fort_cost = 2500;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
}; 

case 8: {// MTVR Ammo
  //      ctrlSetText [4134, "HZ\dialogs\veh\media\MTVR_7t_ammo.paa"];
        hz_fort_selected = "Land_fort_bagfence_long";
        hz_fort_cost = 150;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
};

case 9: {// LR Defender
 //       ctrlSetText [4134, "HZ\dialogs\veh\media\LR_def.paa"];
        hz_fort_selected = "Land_fort_bagfence_corner";
        hz_fort_cost = 100;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
};

case 10: {// HMMWV Utility
 //       ctrlSetText [4134, "HZ\dialogs\veh\media\m1123_utility.paa"];
        hz_fort_selected = "Hhedgehog_concreteBig";
        hz_fort_cost = 5000;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
};

case 11: {// HMMWV Cargo
//        ctrlSetText [4134, "HZ\dialogs\veh\media\m1152_cargo.paa"];
        hz_fort_selected = "Land_fort_bagfence_round";
        hz_fort_cost = 100;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
};

case 12: {// HMMWV MEDEVAC
  //      ctrlSetText [4134, "HZ\dialogs\veh\media\m1152_medevac.paa"];
        hz_fort_selected = "Land_fort_artillery_nest_EP1";
        hz_fort_cost = 400;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
};

case 13: {// HMMWV M1025
 //       ctrlSetText [4134, "HZ\dialogs\veh\media\hmmwv_m1025.paa"];
        hz_fort_selected = "Land_fortified_nest_small_EP1";
        hz_fort_cost = 600;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
};

case 14: {// HMMWV M1025 GL
 //   ctrlSetText [4134, "HZ\dialogs\veh\media\hmmwv_m1025_GL.paa"];
    hz_fort_selected = "Land_Fort_Watchtower_EP1";
    hz_fort_cost = 2000;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
case 15: {// HMMWV M2
  //      ctrlSetText [4134, "HZ\dialogs\veh\media\m1151_m2.paa"];
        hz_fort_selected = "Hedgehog";
        hz_fort_cost = 1000;
        _display = format ["Item Cost: $%1",hz_fort_cost];
        ctrlSetText [4135, _display];
};    
    
case 16: {// HMMWV Black PMC MG
 //   ctrlSetText [4134, "HZ\dialogs\veh\media\hmmwv_black.paa"];
    hz_fort_selected = "Land_fort_rampart_EP1";
    hz_fort_cost = 150;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    }; 
    
case 17: {// HMMWV CROWS M2
 //   ctrlSetText [4134, "HZ\dialogs\veh\media\m1114_m2_crows.paa"];
    hz_fort_selected = "Land_HBarrier_large";
    hz_fort_cost = 1000;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };     
    
 case 18: {// HMMWV CROWS GL
 //   ctrlSetText [4134, "HZ\dialogs\veh\media\m1114_mk19_crows.paa"];
    hz_fort_selected = "Land_HBarrier5";
    hz_fort_cost = 800;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };    
    
  case 19: {// PMC SUV
 //   ctrlSetText [4134, "HZ\dialogs\veh\media\tahoe_pmc_minigun.paa"];
    hz_fort_selected = "Land_fortified_nest_big_EP1";
    hz_fort_cost = 1200;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };       
    
  case 20: {// HMMWV TOW
 //   ctrlSetText [4134, "HZ\dialogs\veh\media\m1036_TOW.paa"];
    hz_fort_selected = "Base_WarfareBBarrier10xTall";
    hz_fort_cost = 1500;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    }; 
    
      case 21: {// HMMWV Avenger
 //   ctrlSetText [4134, "HZ\dialogs\veh\media\m1097_avenger.paa"];
    hz_fort_selected = "SearchLight_US_EP1";
    hz_fort_cost = 500;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    }; 
    
    case 22: {// HMMWV SOV
  // ctrlSetText [4134, "HZ\dialogs\veh\media\HMMWV_SOV.paa"];
    hz_fort_selected = "Land_Campfire";
    hz_fort_cost = 5;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    }; 
    
    case 23: {// Jackal L2A1
  //  ctrlSetText [4134, "HZ\dialogs\veh\media\Jackal_l2a1.paa"];
    hz_fort_selected = "RoadCone";
    hz_fort_cost = 20;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };   
       case 24: {// Jackal GMG
 //   ctrlSetText [4134, "HZ\dialogs\veh\media\Jackal_GMG.paa"];
    hz_fort_selected = "Sign_1L_Noentry_EP1";
    hz_fort_cost = 100;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };   
      case 25: {// Ikarus Bus
 //   ctrlSetText [4134, "HZ\dialogs\veh\media\ikarus.paa"];
    hz_fort_selected = "Sign_DangerMines_ACR";
    hz_fort_cost = 100;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
     case 26: {// Stryker M2
 ctrlSetText [4134, ""];
    hz_fort_selected = "Land_coneLight";
    hz_fort_cost = 40;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
         case 27: {// Stryker M2
 ctrlSetText [4134, ""];
    hz_fort_selected = "Sign_Checkpoint_US_EP1";
    hz_fort_cost = 20;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
         case 28: {// Stryker M2
 ctrlSetText [4134, ""];
    hz_fort_selected = "RoadBarrier_light";
    hz_fort_cost = 50;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
         case 29: {// Stryker M2
 ctrlSetText [4134, ""];
    hz_fort_selected = "Sign_1L_Firstaid_EP1";
    hz_fort_cost = 100;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
         case 30: {// Stryker M2
 ctrlSetText [4134, ""];
    hz_fort_selected = "Land_arrows_desk_R";
    hz_fort_cost = 200;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
         case 31: {// Stryker M2
 ctrlSetText [4134, ""];
    hz_fort_selected = "Land_arrows_desk_L";
    hz_fort_cost = 200;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
             case 32: {// Stryker M2
 ctrlSetText [4134, ""];
    hz_fort_selected = "Land_arrows_yellow_R";
    hz_fort_cost = 50;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
             case 33: {// Stryker M2
 ctrlSetText [4134, ""];
    hz_fort_selected = "Land_arrows_yellow_L";
    hz_fort_cost = 50;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
             case 34: {// Stryker M2
 ctrlSetText [4134, ""];
    hz_fort_selected = "FlagCarrierBAF";
    hz_fort_cost = 200;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
             case 35: {// Stryker M2
 ctrlSetText [4134, ""];
    hz_fort_selected = "FlagCarrierNATO_EP1";
    hz_fort_cost = 200;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
             case 36: {
 ctrlSetText [4134, ""];
    hz_fort_selected = "FlagCarrierUSA_EP1";
    hz_fort_cost = 200;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
             case 37: {
 ctrlSetText [4134, ""];
    hz_fort_selected = "FlagCarrierIONwhite_PMC";
    hz_fort_cost = 200;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
             case 38: {
 ctrlSetText [4134, ""];
    hz_fort_selected = "ACRE_OE_303";
    hz_fort_cost = 7000;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
      case 39: {
 ctrlSetText [4134, ""];
    hz_fort_selected = "Base_WarfareBBarrier10x";
    hz_fort_cost = 750;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
     case 40: {
 ctrlSetText [4134, ""];
    hz_fort_selected = "Land_Misc_Cargo1E_EP1";
    hz_fort_cost = 3000;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
         case 41: {
 ctrlSetText [4134, ""];
    hz_fort_selected = "Land_Ind_IlluminantTower";
    hz_fort_cost = 15000;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
             case 42: {
 ctrlSetText [4134, ""];
    hz_fort_selected = "ACE_ArtyEquip_Box";
    hz_fort_cost = 35000;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
 /////////////////////////////////////////////////////////////////////////////////////////////////   
    case 43: {
    ctrlSetText [4134, "HZ\dialogs\veh\media\mortar.paa"];
    hz_fort_selected = "ACE_120Tampella";
    hz_fort_cost = 30000;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
    case 44: {//Smoke
    ctrlSetText [4134, "HZ\dialogs\veh\media\mortarbox.paa"];
    hz_fort_selected = "ace_arty_120mm_ammo_dm35";
    hz_fort_cost = 250;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
    case 45: {//Illum
    ctrlSetText [4134, "HZ\dialogs\veh\media\mortarbox.paa"];
    hz_fort_selected = "ace_arty_120mm_ammo_dm26";
    hz_fort_cost = 200;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
      case 46: {//HE
    ctrlSetText [4134, "HZ\dialogs\veh\media\mortarbox.paa"];
    hz_fort_selected = "ace_arty_120mm_ammo_dm11";
    hz_fort_cost = 200;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
       case 47: {//HE
    ctrlSetText [4134, "HZ\dialogs\veh\media\mortarbox.paa"];
    hz_fort_selected = "ace_arty_120mm_ammo_dm61";
    hz_fort_cost = 200;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
    case 48: {
    ctrlSetText [4134, "HZ\dialogs\veh\media\m119arty.paa"];
    hz_fort_selected = "ACE_ARTY_M119";
    hz_fort_cost = 1500000;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    }; 
    
       case 49: {//HE
    ctrlSetText [4134, "HZ\dialogs\veh\media\artybox.paa"];
    hz_fort_selected = "ace_arty_105mm_ammo_m1";
    hz_fort_cost = 255;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
    case 50: {//Illum
    ctrlSetText [4134, "HZ\dialogs\veh\media\artybox.paa"];
    hz_fort_selected = "ace_arty_105mm_ammo_m314a3";
    hz_fort_cost = 295;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
     case 51: {//WP
    ctrlSetText [4134, "HZ\dialogs\veh\media\artybox.paa"];
    hz_fort_selected = "ace_arty_105mm_ammo_m60a2";
    hz_fort_cost = 610;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
    case 52: {//Smoke
    ctrlSetText [4134, "HZ\dialogs\veh\media\artybox.paa"];
    hz_fort_selected = "ace_arty_105mm_ammo_m84a1";
    hz_fort_cost = 270;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
     case 53: {//DPICM
    ctrlSetText [4134, "HZ\dialogs\veh\media\artybox.paa"];
    hz_fort_selected = "ace_arty_105mm_ammo_m916";
    hz_fort_cost = 1830;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    /////////////////////////////////////////////////////////////////////////////////////////////
         case 54: {//DPICM
 ctrlSetText [4134, ""];
    hz_fort_selected = "M2StaticMG_US_EP1";
    hz_fort_cost = 10000;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
         case 55: {//DPICM
 ctrlSetText [4134, ""];
    hz_fort_selected = "ACE_M240_Tripod";
    hz_fort_cost = 5000;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
         case 56: {//DPICM
 ctrlSetText [4134, ""];
    hz_fort_selected = "ACE_M240M145_Tripod";
    hz_fort_cost = 6200;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
         case 57: {//DPICM
 ctrlSetText [4134, ""];
    hz_fort_selected = "ACE_BAF_GPMG_Minitripod_D";
    hz_fort_cost = 4300;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
    
         case 58: {//DPICM
 ctrlSetText [4134, ""];
    hz_fort_selected = "BAF_GPMG_Minitripod_D";
    hz_fort_cost = 5500;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
         case 59: {//DPICM
 ctrlSetText [4134, ""];
    hz_fort_selected = "BAF_L2A1_Tripod_D";
    hz_fort_cost = 13000;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
             case 60: {
 ctrlSetText [4134, ""];
    hz_fort_selected = "WarfareBCamp";
    hz_fort_cost = 5000;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
                 case 61: {
 ctrlSetText [4134, ""];
    hz_fort_selected = "Land_tent_east";
    hz_fort_cost = 5000;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
    case 62: {
    ctrlSetText [4134, ""];
    hz_fort_selected = "ACE_USVehicleBox_EP1";
    hz_fort_cost = 150;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    
     case 63: {
    ctrlSetText [4134, ""];
    hz_fort_selected = "ACE_BandageBoxWest";
    hz_fort_cost = 20;
    _display = format ["Item Cost: $%1",hz_fort_cost];
    ctrlSetText [4135, _display];
    };
    

/*

 ACE_CSW_Box_M224
 ACE_Tbox_Mortar_60mmHE //M720A1 HE
 ACE_Tbox_Mortar_60mmIL //M721 Illum
 ACE_Tbox_Mortar_60mmWP //M722A1 Bursting WP
 ACE_CSW_Box_M252
 ACE_Tbox_Mortar_81mmHE //M821A2 HE
 ACE_Tbox_Mortar_81mmWP //M375A3 Bursting WP
 ACE_Tbox_Mortar_81mmIL //M853A1 Illum
 
*/

 
default {hint "Hunter'z Fortification Store: Unknown error";};
};

_pic = gettext (configfile >> "cfgVehicles" >> hz_fort_selected >> "picture");
if(_pic == "pictureStaticObject") then {_pic = gettext (configfile >> "cfgVehicles" >> hz_fort_selected >> "icon");};
ctrlSetText [4134,_pic];