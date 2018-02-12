
private ["_initstatement","_vehicle"];
_vehicle = _this select 0;
_initstatement = "";

if (_vehicle iskindof "CUP_FlagCarrierIONblack_PMC") then {
  _initstatement = "_obj setFlagTexture ""media\flag5.jpg"";";
};

if ((_vehicle iskindof "SignAd_SponsorS_ION_F") || (_vehicle iskindof "SignAd_Sponsor_ION_F") || (_vehicle iskindof "Banner_01_F")) then {
  _initstatement = "_obj setObjectTexture [0,""media\flag5.jpg""];";
};

if (_vehicle iskindof "pook_HEMTT_US") then {
  _initstatement = "_obj addaction ['<t color=''#E5E500''>'+'Cargo Load/Unload','logistics\HEMTT_load.sqf',[],-1,false,true,'','vehicle player == player && alive _target'];";
    
      _vehicle addMPEventHandler ["MPKilled",{
        ((_this select 0) getvariable ["Cargo",objNull]) setdamage 1;
      }];
      _vehicle addMPeventhandler ["MPHit",{
        _truck = _this select 0;
        _cargo = _truck getvariable ["Cargo",objNull];
        if(!local _cargo || isNull _cargo) exitwith {};
        _damage = _this select 2;
        _newdamage = (getdammage _cargo) + _damage;
        _cargo setdamage _newdamage;
      }];
    ;
};

if (_vehicle iskindof "MtvrRepair_DES_EP1") then {
  _vehicle setrepaircargo 0;
};

if (_vehicle iskindof "MtvrRefuel_DES_EP1") then {
  _vehicle setfuelcargo 0;
};

if (_vehicle iskindof "MtvrReammo_DES_EP1") then {
  _vehicle setammocargo 0;
};

_initstatement = _initstatement + "_obj addaction ['<t color=''#dce2ed''>'+'Check fuel', {hint format ['%1%2 full',(fuel (_this select 0))*100,'%'];},[],-99,false,true,'','_this == (driver _target)'];";

if(_initstatement != "") then {
  [_vehicle,_initstatement] remoteexeccall ["Hz_fnc_setVehicleInit",0,true];
};