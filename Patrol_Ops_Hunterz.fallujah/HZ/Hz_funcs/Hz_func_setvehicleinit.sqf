
private ["_initstatement","_vehicle"];
_vehicle = _this select 0;
_initstatement = "";

if (_vehicle iskindof "Helicopter") then {
_vehicle setVariable ["ACE_Slingload_Rule",["ACE_Stretcher","M1135_ATGMV_EP1","M1128_MGS_EP1","M1133_MEV_EP1","M1126_ICV_M2_EP1","M1126_ICV_mk19_EP1","M1129_MC_EP1","ACE_Stryker_ICV_M2","ACE_Stryker_TOW","ACE_Stryker_MGS","ACE_Stryker_ICV_M2_SLAT","ACE_Stryker_ICV_M2_D","ACE_Stryker_ICV_MK19","ACE_Stryker_ICV_M2_SLAT_D","ACE_Stryker_ICV_MK19_SLAT","ACE_Stryker_ICV_MK19_D","ACE_Stryker_ICV_MK19_SLAT_D","ACE_Stryker_TOW_Slat","ACE_Stryker_TOW_MG","ACE_Stryker_RV","ACE_Stryker_TOW_MG_Slat","ACE_Stryker_RV_SLAT","ACE_Stryker_RV_D","ACE_Stryker_RV_SLAT_D","ACE_Stryker_MGS_Slat","LAV25","M1A1_US_DES_EP1","M1A2_TUSK_MG","ACE_M1A1HC_DESERT","ACE_M1A1HC_TUSK","M1A2_US_TUSK_MG_EP1","ACE_M1A1_NATO","ACE_M1A1HC_TUSK_DESERT","ACE_M1A1HA_TUSK","ACE_M1A1HC_TUSK_CSAMM","ACE_M1A1HA_TUSK_DESERT","ACE_M1A1HC_TUSK_CSAMM_DESERT","ACE_M1A1HA_TUSK_CSAMM","ACE_M1A1HA_TUSK_CSAMM_DESERT","M2A2_EP1","M6_EP1","M2A3_EP1","ACE_M2A2_W","ACE_M2A2_D","ACE_M2A3_W","ACE_M2A2_G","ACE_M6A1_W","ACE_M6A1_D","ACE_M6A1_G","BAF_FV510_D","BAF_FV510_W","MTVR_DES_EP1","ACE_Truck5tRefuel","MtvrRefuel_DES_EP1","MtvrRefuel","MtvrRepair_DES_EP1","ACE_Truck5tReammo","MtvrReammo","ACE_Truck5t","ACE_Truck5tMG","MtvrReammo_DES_EP1","MtvrRepair","ACE_Truck5tRepair","ACE_Truck5tMGOpen","ACE_Truck5tOpen"], true];
};

if (_vehicle iskindof "pook_HEMTT_US") then {
_initstatement = "this addaction ['<t color=''#E5E500''>'+'Cargo Load/Unload','logistics\HEMTT_load.sqf',[],-1,false,true,'','vehicle player == player && alive _target']; this setvariable ['Cargo',objNull,true];";
};
/*
if (_vehicle iskindof "MIS_Goldhofer1") then {
_initstatement = "this addEventHandler [""getin"",{[_this select 0] execVM ""AttachToTractor\AttachToTractor.sqf"";}];";
};
*/
if (_vehicle iskindof "pook_H13_amphib") then {
_initstatement = "this addEventHandler [""getin"",{[_this select 0] execVM ""logistics\H47_MP_float_correction.sqf"";}];";
[_vehicle] execVM "logistics\H47_MP_float_correction.sqf"; 
};

if (_vehicle iskindof "GNT_C185F") then {
_initstatement = "this addEventHandler [""getin"",{[_this select 0] execVM ""logistics\C185_MP_float_correction.sqf"";}];";
[_vehicle] execVM "logistics\C185_MP_float_correction.sqf"; 
};

if (_vehicle iskindof "MtvrRepair_DES_EP1") then {
_initstatement = "this setrepaircargo 0;";
};

if (_vehicle iskindof "MtvrRefuel_DES_EP1") then {
_initstatement = "this setfuelcargo 0;";
};

if (_vehicle iskindof "MtvrReammo_DES_EP1") then {
_initstatement = "this setammocargo 0;";
};

_initstatement = _initstatement + "this setvariable [""Hz_vehicles_noRadioSound"",true];";

if (_vehicle iskindof "Plane") then {
    
//_initstatement = _initstatement + "this addeventhandler [""HandleDamage"",{_this execvm ""logistics\Hz_plane_damageEH.sqf""}];";        
            
};

if(_initstatement != "") then {
_vehicle setVehicleInit _initstatement;
processInitCommands;
};