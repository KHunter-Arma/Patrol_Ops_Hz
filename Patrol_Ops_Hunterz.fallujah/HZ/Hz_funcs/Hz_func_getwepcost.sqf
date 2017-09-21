private ["_attachmentsprice","_baseprice","_price","_EGLM","_KX3","_RMR","_LTWS","_MK4CQT","_SCOPE","_NV","_TWS","_return","_weapon","_IR","_FLASH","_BIPOD","_SD","_SDM9","_GRIP","_M203","_AG36","_M320","_GP25","_GP30","_MK13","_ACOG","_DOCTER","_CCO","_CCOm","_CCOM3","_EOT","_EOT4x","_SHORTDOT","_M145","_LEUPOLD","_G36A1OPTIC","_SG1","_PSO","_KOBRA","_RSAS","_1P78","_NSPU"];


_weapon = _this;
_weapon = toupper _weapon;
_attachmentsprice = 0;

// CONSTANTS

_IR = 1330;
_FLASH = 100;
_BIPOD = 135;
_SD = 650;
_SDM9 = 555;
_GRIP = 70;

_M203 = 1080;
_AG36 = 3500;
_M320 = 3500;
_GP25 = 100;
_GP30 = 390;
_MK13 = 3850;

_ACOG = 1780;
_DOCTER = 555;
_CCO = 780;
_CCOm = 755;
_CCOM3 = 425;
_EOT = 750; 
_EOT4x = 1020;
_SHORTDOT = 2880;
_M145 = 1370;

_LEUPOLD = 2000;
_G36A1OPTIC = 1500;
_SG1 = 1200;

_PSO = 300;
_KOBRA = 400;
_RSAS = 870;
_1P78 = 650;
_NSPU = 500;

//////////////

_return = switch (true) do {
    
case (_weapon in [ "M8_CARBINE", "M8_HOLO_SD" ] ) : {

_baseprice = 3700;
if(_weapon == "M8_CARBINE") then {_attachmentsprice = 0;};
if(_weapon == "M8_HOLO_SD") then {_attachmentsprice = _GRIP + _SD + _EOT + _FLASH;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon in [ "SCAR_L_CQC_CCO_SD", "SCAR_L_CQC", "SCAR_L_CQC_HOLO", "SCAR_L_CQC_EGLM_HOLO", "SCAR_L_STD_EGLM_RCO", "SCAR_L_STD_EGLM_TWS", "SCAR_L_STD_HOLO", "SCAR_L_STD_MK4CQT" ] ) : {

_baseprice = 2700;
if(_weapon == "SCAR_L_CQC_CCO_SD") then {_attachmentsprice = _CCO + _IR + _SD;};
if(_weapon == "SCAR_L_CQC") then {_attachmentsprice = 0;};
if(_weapon == "SCAR_L_CQC_HOLO") then {_attachmentsprice = _EOT + _GRIP;};
if(_weapon == "SCAR_L_CQC_EGLM_HOLO") then {_attachmentsprice =  _EOT + _EGLM + _IR + _KX3;};
if(_weapon == "SCAR_L_STD_EGLM_RCO") then {_attachmentsprice = _ACOG + _EGLM + _IR + _RMR;};
if(_weapon == "SCAR_L_STD_EGLM_TWS") then {_attachmentsprice = _EGLM + _IR + _KX3 + _LTWS;};
if(_weapon == "SCAR_L_STD_HOLO") then {_attachmentsprice = _EOT + _GRIP + _IR;};
if(_weapon == "SCAR_L_STD_MK4CQT") then {_attachmentsprice = _GRIP + _IR + _MK4CQT;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon in [ "M4SPR", "ACE_M4SPR_SD" ] ) : {

_baseprice = 2050;
if(_weapon == "M4SPR") then {_attachmentsprice = _SCOPE;};
if(_weapon == "ACE_M4SPR_SD") then {_attachmentsprice = _SCOPE + _SD;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon in [ "ACE_SOC_M4A1_EOTECH_4x", "ACE_SOC_M4A1_EOTECH", "ACE_SOC_M4A1_GL_UP", "ACE_SOC_M4A1_GL_EOTECH", "ACE_SOC_M4A1_GL_AIMPOINT", "ACE_SOC_M4A1_RCO_GL", "ACE_SOC_M4A1_RCO_GL_UP", "ACE_SOC_M4A1_GL_SD", "ACE_SOC_M4A1_GL_SD_UP", "ACE_SOC_M4A1_GL", "ACE_SOC_M4A1_GL_13", "ACE_SOC_M4A1_AIM", "ACE_SOC_M4A1_AIM_SD", "ACE_SOC_M4A1_SD_9", "ACE_SOC_M4A1_SHORTDOT_SD", "ACE_SOC_M4A1_SHORTDOT", "ACE_SOC_M4A1_EOT_SD", "ACE_SOC_M4A1", "ACE_SOC_M4A1_TWS" ] ) : {

_baseprice = 1050;
if(_weapon == "ACE_SOC_M4A1_EOTECH_4x") then {_attachmentsprice = _EOT4X + _FLASH + _GRIP + _IR;};
if(_weapon == "ACE_SOC_M4A1_EOTECH") then {_attachmentsprice = _EOT + _FLASH + _GRIP + _IR;};
if(_weapon == "ACE_SOC_M4A1_GL_UP") then {_attachmentsprice = _FLASH + _M203;};
if(_weapon == "ACE_SOC_M4A1_GL_EOTECH") then {_attachmentsprice = _EOT + _IR + _M203;};
if(_weapon == "ACE_SOC_M4A1_GL_AIMPOINT") then {_attachmentsprice = _CCOM + _IR + _M203;};
if(_weapon == "ACE_SOC_M4A1_RCO_GL") then {_attachmentsprice = _ACOG + _FLASH + _IR + _M203;};
if(_weapon == "ACE_SOC_M4A1_RCO_GL_UP") then {_attachmentsprice = _ACOG + _FLASH + _IR + _M203;};
if(_weapon == "ACE_SOC_M4A1_GL_SD") then {_attachmentsprice = _FLASH + _IR + _M203 + _SD;};
if(_weapon == "ACE_SOC_M4A1_GL_SD_UP") then {_attachmentsprice = _FLASH + _IR + _M203 + _SD;};
if(_weapon == "ACE_SOC_M4A1_GL") then {_attachmentsprice = _FLASH + _M203;};
if(_weapon == "ACE_SOC_M4A1_GL_13") then {_attachmentsprice = _IR + _M203;};
if(_weapon == "ACE_SOC_M4A1_AIM") then {_attachmentsprice = _CCOM + _GRIP + _IR;};
if(_weapon == "ACE_SOC_M4A1_AIM_SD") then {_attachmentsprice = _CCOM + _GRIP + _IR + _SD;};
if(_weapon == "ACE_SOC_M4A1_SD_9") then {_attachmentsprice = _GRIP + _IR + _SD;};
if(_weapon == "ACE_SOC_M4A1_SHORTDOT_SD") then {_attachmentsprice = _FLASH + _GRIP + _IR + _SHORTDOT + _SD;};
if(_weapon == "ACE_SOC_M4A1_SHORTDOT") then {_attachmentsprice = _FLASH + _GRIP + _IR + _SHORTDOT;};
if(_weapon == "ACE_SOC_M4A1_EOT_SD") then {_attachmentsprice = _EOT + _FLASH + _GRIP + _IR + _SD;};
if(_weapon == "ACE_SOC_M4A1") then {_attachmentsprice = _GRIP + _IR;};
if(_weapon == "ACE_SOC_M4A1_TWS") then {_attachmentsprice = _FLASH + _GRIP + _IR + _LTWS;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon in [ "ACE_Mk12MOD1", "ACE_Mk12MOD1_SD" ] ) : {

_baseprice = 3200;
if(_weapon == "ACE_Mk12MOD1") then {_attachmentsprice = _SCOPE;};
if(_weapon == "ACE_Mk12MOD1_SD") then {_attachmentsprice = _SCOPE + _SD;};
_price = _attachmentsprice + _baseprice;
_price;

};
                
case (_weapon in [ "ACE_M16A4_IRON", "M16A4", "ACE_M16A4_EOT", "ACE_M16A4_EOT_GL", "M16A4_GL", "ACE_M16A4_CCO_GL", "M16A4_ACG_GL", "M16A4_ACG" ] ) : {

_baseprice = 740;    
if(_weapon == "ACE_M16A4_IRON") then {_attachmentsprice = _IR + _FLASH;};
if(_weapon == "M16A4") then {_attachmentsprice = _IR + _FLASH + _CCO;};
if(_weapon == "ACE_M16A4_EOT") then {_attachmentsprice = _IR + _FLASH + _EOT;};
if(_weapon == "ACE_M16A4_EOT_GL") then {_attachmentsprice = _IR + _FLASH + _EOT + _M203;};
if(_weapon == "M16A4_GL") then {_attachmentsprice = _IR + _FLASH + _M203;};
if(_weapon == "ACE_M16A4_CCO_GL") then {_attachmentsprice = _IR + _FLASH + _CCO + _M203;};
if(_weapon == "M16A4_ACG_GL") then {_attachmentsprice = _IR + _FLASH + _ACOG + _M203;};
if(_weapon == "M16A4_ACG") then {_attachmentsprice = _IR + _FLASH + _ACOG;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon in [ "ACE_AK74M", "ACE_AK74M_FL", "ACE_AK74M_1P78", "ACE_AK74M_1P78_FL", "ACE_AK74M_PSO", "ACE_AK74M_PSO_FL", "ACE_AK74M_KOBRA", "ACE_AK74M_KOBRA_FL", "ACE_AK74M_SD", "ACE_AK74M_SD_KOBRA", "ACE_AK74M_GL", "ACE_AK74M_GL_1P78", "ACE_AK74M_SD_NSPU" ] ) : {

_baseprice = 1200;
if(_weapon == "ACE_AK74M") then {_attachmentsprice = 0;};
if(_weapon == "ACE_AK74M_FL") then {_attachmentsprice = _IR + _FLASH;};
if(_weapon == "ACE_AK74M_1P78") then {_attachmentsprice = _1P78;};
if(_weapon == "ACE_AK74M_1P78_FL") then {_attachmentsprice = _IR + _FLASH + _1P78;};
if(_weapon == "ACE_AK74M_PSO") then {_attachmentsprice = _PSO;};
if(_weapon == "ACE_AK74M_PSO_FL") then {_attachmentsprice = _IR + _FLASH + _PSO;};
if(_weapon == "ACE_AK74M_KOBRA") then {_attachmentsprice = _KOBRA;};
if(_weapon == "ACE_AK74M_KOBRA_FL") then {_attachmentsprice = _IR + _FLASH + _KOBRA;};
if(_weapon == "ACE_AK74M_SD") then {_attachmentsprice = _SD + _IR + _FLASH;};
if(_weapon == "ACE_AK74M_SD_KOBRA") then {_attachmentsprice = _SD + _IR + _FLASH + _KOBRA;};
if(_weapon == "ACE_AK74M_GL") then {_attachmentsprice = _GP25;};
if(_weapon == "ACE_AK74M_GL_1P78") then {_attachmentsprice = _IR + _GP25 + _1P78;};
if(_weapon == "ACE_AK74M_GL_PSO") then {_attachmentsprice = _GP25 + _PSO;};
if(_weapon == "ACE_AK74M_GL_KOBRA") then {_attachmentsprice = _FLASH + _GP25 + _KOBRA;};
if(_weapon == "ACE_AK74M_SD_NSPU") then {_attachmentsprice = _SD + _FLASH + _IR + _NSPU;};
_price = _attachmentsprice + _baseprice;
_price;

};


case (_weapon in ["ACE_HK417_CCOM","ACE_HK417_EOTECH_4X","ACE_HK417_SHORTDOT","ACE_HK417_LEUPOLD"] ) : {

_baseprice = 4200;
if(_weapon == "ACE_HK417_CCOM") then {_attachmentsprice = _CCOm;};
if(_weapon == "ACE_HK417_EOTECH_4X") then {_attachmentsprice = _EOT4x;};
if(_weapon == "ACE_HK417_SHORTDOT") then {_attachmentsprice = _SHORTDOT;};
if(_weapon == "ACE_HK417_LEUPOLD") then {_attachmentsprice = _LEUPOLD + _BIPOD;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon in ["ACE_MP7","ACE_MP7_RSAS"] ) : {

_baseprice = 1800;
if(_weapon == "ACE_MP7") then {_attachmentsprice = 0;};
if(_weapon == "ACE_MP7_RSAS") then {_attachmentsprice = _RSAS;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon == "ACE_KAC_PDW" ) : {3000};

case (_weapon == "ACE_SKS" ) : {845};

case (_weapon in [ "AKS_74_U", "AKS_74_UN_KOBRA" ] ) : {

_baseprice = 620;
if(_weapon == "AKS_74_U") then {_attachmentsprice = 0;};
if(_weapon == "AKS_74_UN_KOBRA") then {_attachmentsprice = _SD + _KOBRA;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon in [ "ACE_G36A1_AG36A1","ACE_G36A1_AG36A1_D" ] ) : {

_baseprice = 2500;
if(_weapon == "ACE_G36A1_AG36A1") then {_attachmentsprice = _G36A1OPTIC + _AG36 + _IR + _FLASH;};
if(_weapon == "ACE_G36A1_AG36A1_D") then {_attachmentsprice = _G36A1OPTIC + _AG36 + _IR + _FLASH;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon in [ "ACE_G3A3","ACE_G3A3_RSAS","ACE_G3SG1" ] ) : {

_baseprice = 2000;    
if(_weapon == "ACE_G3A3") then {_attachmentsprice = 0;};
if(_weapon == "ACE_G3A3_RSAS") then {_attachmentsprice = _RSAS + _GRIP + _IR + _FLASH;};
if(_weapon == "ACE_G3SG1") then {_attachmentsprice = _SG1;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon in [ "ACE_M110", "M110_NVG_EP1", "ACE_M110_SD", "M110_TWS_EP1" ] ) : {

_baseprice = 2455;
if(_weapon == "ACE_M110") then {_attachmentsprice = _BIPOD + _SCOPE;};
if(_weapon == "M110_NVG_EP1") then {_attachmentsprice = _BIPOD + _NV;};
if(_weapon == "ACE_M110_SD") then {_attachmentsprice = _BIPOD + _SCOPE + _SD;};
if(_weapon == "M110_TWS_EP1") then {_attachmentsprice = _BIPOD + _TWS;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon in [ "ACE_M249_AIM", "M249_M145_EP1", "ACE_M249_PIP_ACOG", "M249", "M249_EP1", "M249_TWS_EP1" ] ) : {

_baseprice = 5545;
if(_weapon == "ACE_M249_AIM") then {_attachmentsprice = _BIPOD + _CCOM3 + _GRIP + _IR;};
if(_weapon == "M249_M145_EP1") then {_attachmentsprice = _BIPOD + _GRIP + _IR + _M145;};
if(_weapon == "ACE_M249_PIP_ACOG") then {_attachmentsprice = _ACOG + _BIPOD + _GRIP + _IR;};
if(_weapon == "M249") then {_attachmentsprice = _BIPOD;};
if(_weapon == "M249_EP1") then {_attachmentsprice = _BIPOD + _GRIP + _IR;};
if(_weapon == "M249_TWS_EP1") then {_attachmentsprice = _BIPOD + _GRIP + _IR + _LTWS;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon in [ "STINGER","IGLA" ] ) : {

if(_weapon == "IGLA") then {5000};
if(_weapon == "STINGER") then {44000};

};

case (_weapon in [ "ITEMCOMPASS", "ACE_EARPLUGS", "ITEMGPS", "ACE_MAP", "ITEMWATCH", "NVGOGGLES" ] ) : {

if(_weapon == "ITEMCOMPASS") then {70};
if(_weapon == "ACE_EARPLUGS") then {15};
if(_weapon == "ITEMGPS") then {1500};
if(_weapon == "ACE_MAP") then {50};
if(_weapon == "ITEMWATCH") then {100};
if(_weapon == "NVGOGGLES") then {2230};

};

case (_weapon in [ "ACE_VTAC_RUSH72_OD", "ACE_VTAC_RUSH72", "ACE_VTAC_RUSH72_ACU", "ACE_VTAC_RUSH72_FT_MEDIC", "ACE_VTAC_RUSH72_TT_MEDIC" ] ) : {200};

case ("ACRE_PRC148_UHF" in ([(configFile >> "CfgWeapons" >> _weapon), true] call BIS_fnc_returnparents) ) : {7500};
case ("ACRE_PRC148" in ([(configFile >> "CfgWeapons" >> _weapon), true] call BIS_fnc_returnparents) ) : {7500};
case ("ACRE_PRC343" in ([(configFile >> "CfgWeapons" >> _weapon), true] call BIS_fnc_returnparents) ) : {150};

case (_weapon == "GLOCK17_EP1" ) : {

_baseprice = 540;
if(_weapon == "GLOCK17_EP1") then {_attachmentsprice = _FLASH;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon == "COLT1911" ) : {1700};

case (_weapon in [ "ACE_USP", "ACE_USPSD" ] ) : {

_baseprice = 1140;
if(_weapon == "ACE_USP") then {_attachmentsprice = _FLASH;};
if(_weapon == "ACE_USPSD") then {_attachmentsprice = _FLASH + _SD;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon in [ "M9", "M9SD" ] ) : {

_baseprice = 675;
if(_weapon == "M9") then {_attachmentsprice = 0;};
if(_weapon == "M9SD") then {_attachmentsprice = _SDM9;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon in [ "M1014", "ACE_M1014_EOTECH" ] ) : {

_baseprice = 1800;
if(_weapon == "M1014") then {_attachmentsprice = 0;};
if(_weapon == "ACE_M1014_EOTECH") then {_attachmentsprice = _EOT;};
_price = _attachmentsprice + _baseprice;
_price;

};

case (_weapon == "ACE_SPAS12" ) : {1500};

default {
    
  _return = -1;
  _return;
        
};

};

_return;