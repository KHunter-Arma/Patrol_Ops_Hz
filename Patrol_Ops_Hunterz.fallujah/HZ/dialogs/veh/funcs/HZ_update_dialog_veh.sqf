
private ["_display","_element"];
_element = _this select 1;
disableSerialization;

//Display money
_display = format ["Available funds: $%1",Hz_funds];
ctrlSetText [3136, _display];
if(Hz_funds >= 1000000) then {
        _display = format ["Available funds: $%1 million",(Hz_funds / 1000000)];
        ctrlSetText [3136, _display];
        };


switch (_element) do {
    
      case 0: {// Toyota Corolla (E90)
        ctrlSetText [3134, "HZ\dialogs\veh\media\toyota_corolla.paa"];
        hz_veh_selected = "car_sedan";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
}; 

case 1: {// Skoda 1203
        ctrlSetText [3134, "HZ\dialogs\veh\media\skoda_1203.paa"];
        hz_veh_selected = "S1203_TK_CIV_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
}; 

case 2: {// Toyota Hilux
        ctrlSetText [3134, "HZ\dialogs\veh\media\toyota_hilux.paa"];
        hz_veh_selected = "hilux1_civil_3_open_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};      
case 3: {// Volkswagen Golf (IV)
        ctrlSetText [3134, "HZ\dialogs\veh\media\vw_golf.paa"];
        hz_veh_selected = "VWGolf";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
}; 

case 4: {// Skoda Octavia
        ctrlSetText [3134, "HZ\dialogs\veh\media\skoda_octavia.paa"];
        hz_veh_selected = "Octavia_ACR";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
}; 

case 5: {// Chevrolet Tahoe
        ctrlSetText [3134, "HZ\dialogs\veh\media\Chevrolet_tahoe.paa"];
        hz_veh_selected = "SUV_PMC";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
}; 

case 6: {// MTVR
        ctrlSetText [3134, "HZ\dialogs\veh\media\MTVR_7t.paa"];
        hz_veh_selected = "MTVR_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
}; 
case 7: {// MTVR Repair
        ctrlSetText [3134, "HZ\dialogs\veh\media\MTVR_7t_Repair.paa"];
        hz_veh_selected = "MtvrRepair_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
}; 
case 8: {// MTVR Refuel
        ctrlSetText [3134, "HZ\dialogs\veh\media\MTVR_7t_refuel.paa"];
        hz_veh_selected = "MtvrRefuel_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
}; 

case 9: {// MTVR Ammo
        ctrlSetText [3134, "HZ\dialogs\veh\media\MTVR_7t_ammo.paa"];
        hz_veh_selected = "MtvrReammo_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};

case 10: {// LR Defender
        ctrlSetText [3134, "HZ\dialogs\veh\media\LR_def.paa"];
        hz_veh_selected = "BAF_Offroad_D";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};

case 11: {// HMMWV Utility
        ctrlSetText [3134, "HZ\dialogs\veh\media\m1123_utility.paa"];
        hz_veh_selected = "HMMWV_M1035_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};

case 12: {// HMMWV Cargo
        ctrlSetText [3134, "HZ\dialogs\veh\media\m1152_cargo.paa"];
        hz_veh_selected = "HMMWV_Terminal_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};

case 13: {// HMMWV MEDEVAC
        ctrlSetText [3134, "HZ\dialogs\veh\media\m1152_medevac.paa"];
        hz_veh_selected = "HMMWV_Ambulance_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};

case 14: {// HMMWV M1025
        ctrlSetText [3134, "HZ\dialogs\veh\media\hmmwv_m1025.paa"];
        hz_veh_selected = "HMMWV_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};

case 15: {// HMMWV M1025 GL
    ctrlSetText [3134, "HZ\dialogs\veh\media\hmmwv_m1025_GL.paa"];
    hz_veh_selected = "HMMWV_MK19_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
    
case 16: {// HMMWV M2
        ctrlSetText [3134, "HZ\dialogs\veh\media\m1151_m2.paa"];
        hz_veh_selected = "HMMWV_M1151_M2_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};    
    
case 17: {// HMMWV Black PMC MG
    ctrlSetText [3134, "HZ\dialogs\veh\media\hmmwv_black.paa"];
    hz_veh_selected = "NZX_M1151_PMC2_M2";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 
    
case 18: {// HMMWV CROWS M2
    ctrlSetText [3134, "HZ\dialogs\veh\media\m1114_m2_crows.paa"];
    hz_veh_selected = "HMMWV_M998_crows_M2_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };     
    
 case 19: {// HMMWV CROWS GL
    ctrlSetText [3134, "HZ\dialogs\veh\media\m1114_mk19_crows.paa"];
    hz_veh_selected = "HMMWV_M998_crows_MK19_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };    
    
  case 20: {// PMC SUV
    ctrlSetText [3134, "HZ\dialogs\veh\media\tahoe_pmc_minigun.paa"];
    hz_veh_selected = "ArmoredSUV_PMC";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };       
    
  case 21: {// HMMWV TOW
    ctrlSetText [3134, "HZ\dialogs\veh\media\m1036_TOW.paa"];
    hz_veh_selected = "HMMWV_TOW_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 
    
      case 22: {// HMMWV Avenger
    ctrlSetText [3134, "HZ\dialogs\veh\media\m1097_avenger.paa"];
    hz_veh_selected = "HMMWV_Avenger_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 
    
    case 23: {// HMMWV SOV
    ctrlSetText [3134, "HZ\dialogs\veh\media\HMMWV_SOV.paa"];
    hz_veh_selected = "HMMWV_M998A2_SOV_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 
    
    case 24: {// Jackal L2A1
    ctrlSetText [3134, "HZ\dialogs\veh\media\Jackal_l2a1.paa"];
    hz_veh_selected = "BAF_Jackal2_L2A1_D";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };   
       case 25: {// Jackal GMG
    ctrlSetText [3134, "HZ\dialogs\veh\media\Jackal_GMG.paa"];
    hz_veh_selected = "BAF_Jackal2_GMG_D";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 
    
          case 26: {// Ikarus Bus
    ctrlSetText [3134, "HZ\dialogs\veh\media\ikarus.paa"];
    hz_veh_selected = "Ikarus";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
    
    case 27: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\tyres.paa"];
    hz_veh_selected = "ACE_Spare_Tyre_HDAPC";
    hz_veh_cost = 450;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
    
          case 28: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\tyres.paa"];
    hz_veh_selected = "ACE_Spare_Tyre_HD";
    hz_veh_cost = 300;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
    
          case 29: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\tyres.paa"];
    hz_veh_selected = "ACE_Spare_Tyre";
    hz_veh_cost = 150;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
    
          case 30: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\jerrycan.paa"];
    hz_veh_selected = "ACE_JerryCan_15";
    hz_veh_cost = 30;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };   

/////////////////////////////////////
        case 31: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\lr_specops.paa"];
    hz_veh_selected = "LandRover_Special_CZ_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 
    
       case 32: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\dingo_mg.paa"];
    hz_veh_selected = "Dingo_DST_ACR";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 
    
      case 33: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\dingo_gl.paa"];
    hz_veh_selected = "Dingo_GL_DST_ACR";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 
    
              case 34: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\m113.paa"];
    hz_veh_selected = "TTK_M113A_US";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 
              case 35: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\vads.paa"];
    hz_veh_selected = "TTK_M163A1_US";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 
              case 36: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\machbet.paa"];
    hz_veh_selected = "TTK_M163_Machbet_US";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 

              case 37: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\lav.paa"];
    hz_veh_selected = "LAV_25_OIF";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 
    
                  case 38: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\warrior.paa"];
    hz_veh_selected = "BAF_FV510_D";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 
    
    
                  case 39: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\hemtt.paa"];
    hz_veh_selected = "pook_HEMTT_US";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 

        case 40: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\hemtt_gun.paa"];
    hz_veh_selected = "pook_HEMTT_gun_US";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 
    
    
    
                  case 41: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\tug.paa"];
    hz_veh_selected = "MIS_Goldhofer1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    }; 


//////////////////////////////////
    
    case 42: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\ural.paa"];
    hz_veh_selected = "Ural_TK_CIV_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Item Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
     case 43: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\stryker_m2.paa"];
    hz_veh_selected = "ACE_Stryker_ICV_M2_D";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
     case 44: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\stryker_m2_slat.paa"];
    hz_veh_selected = "ACE_Stryker_ICV_M2_SLAT_D";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
    case 45: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\stryker_gl.paa"];
    hz_veh_selected = "ACE_Stryker_ICV_MK19_D";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
    case 46: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\stryker_gl_slat.paa"];
    hz_veh_selected = "ACE_Stryker_ICV_MK19_SLAT_D";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
    
    case 47: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\stryker_rv.paa"];
    hz_veh_selected = "ACE_Stryker_RV_D";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
    
    case 48: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\stryker_rv_slat.paa"];
    hz_veh_selected = "ACE_Stryker_RV_SLAT_D";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
    
        case 49: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\stryker_mc.paa"];
    hz_veh_selected = "M1129_MC_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
    
    case 50: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\stryker_atgmv.paa"];
    hz_veh_selected = "M1135_ATGMV_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
    
        case 51: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\m1a1.paa"];
    hz_veh_selected = "M1A1_US_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
        case 52: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\m1a1_tusk.paa"];
    hz_veh_selected = "ACE_M1A1HA_TUSK_DESERT";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
        case 53: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\m1a1_tusk_csamm.paa"];
    hz_veh_selected = "ACE_M1A1HA_TUSK_CSAMM_DESERT";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
        case 54: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\m1a2_tusk.paa"];
    hz_veh_selected = "M1A2_US_TUSK_MG_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
        case 55: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\m2a2.paa"];
    hz_veh_selected = "M2A2_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
        case 56: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\m2a3.paa"];
    hz_veh_selected = "M2A3_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
        case 57: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\linebacker.paa"];
    hz_veh_selected = "M6_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
        case 58: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\mlrs.paa"];
    hz_veh_selected = "MLRS_DES_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
            case 59: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\an2.paa"];
    hz_veh_selected = "AN2_2_TK_CIV_EP1";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
    
                case 60: {
    ctrlSetText [3134, "HZ\dialogs\veh\media\mi17_civ.paa"];
    hz_veh_selected = "Mi17_Civilian";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
    _display = format ["Vehicle Cost: $%1",hz_veh_cost];
    ctrlSetText [3135, _display];
    };
    
    case 61: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\m1123_utility.paa"];
        hz_veh_selected = "ACE_BCS_HMMV";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};


  case 62: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\microlight.paa"];
        hz_veh_selected = "kyo_microlight";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};


case 63: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\ultralight.paa"];
        hz_veh_selected = "kyo_ultralight";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};

    case 64: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\pbx.paa"];
        hz_veh_selected = "PBX";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};

    case 65: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\zodiac.paa"];
        hz_veh_selected = "Zodiac";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};

    case 66: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\rhib.paa"];
        hz_veh_selected = "RHIB";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};

    case 67: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\rhib_gl.paa"];
        hz_veh_selected = "RHIB2Turret";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};
    case 68: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\socr.paa"];
        hz_veh_selected = "pook_SOCR_H_M134b";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};
    case 69: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\socr.paa"];
        hz_veh_selected = "pook_SOCR_H_M134";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};

    case 70: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\socr.paa"];
        hz_veh_selected = "pook_SOCR_H_M2";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};

    case 71: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\socr.paa"];
        hz_veh_selected = "pook_SOCR_H_M2b";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};    

    case 72: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\bell206.paa"];
        hz_veh_selected = ["usec_bell206_1","usec_bell206_3"] call BIS_fnc_selectRandom;
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};   

    case 73: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\bell47.paa"];
        hz_veh_selected = ["pook_H13_amphib_UNO","pook_H13_amphib_PMC","pook_H13_amphib_CIV"] call BIS_fnc_selectRandom;
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};   

    case 74: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\c185.paa"];
        hz_veh_selected = ["GNT_C185U","GNT_C185","GNT_C185R","GNT_C185C"] call BIS_fnc_selectRandom;
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};   

    case 75: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\c185_amphibi.paa"];
        hz_veh_selected = ["GNT_C185E","GNT_C185F"] call BIS_fnc_selectRandom;
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
}; 

    case 76: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\dpv.paa"];
        hz_veh_selected = "DPV_BLACK";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
	};			
				    case 77: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\dpv_desert.paa"];
        hz_veh_selected = "DPV";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};  

    case 78: {// Artillery Computer
        ctrlSetText [3134, "HZ\dialogs\veh\media\fennek.paa"];
        hz_veh_selected = "DAF_Fennek_isaf";
        hz_veh_cost = hz_veh_selected call Hz_veh_getVehCost;
        _display = format ["Vehicle Cost: $%1",hz_veh_cost];
        ctrlSetText [3135, _display];
};  
    
default {hint "Hunter'z Vehicle Store: Unknown error";};

};
        if(hz_veh_cost >= 1000000) then {
        _display = format ["Vehicle Cost: $%1 million",(hz_veh_cost / 1000000)];
        ctrlSetText [3135, _display];
        };