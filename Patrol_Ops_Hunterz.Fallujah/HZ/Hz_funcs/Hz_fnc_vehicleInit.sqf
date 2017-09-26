
private ["_initstatement","_vehicle"];
_vehicle = _this select 0;
_initstatement = "";

if (_vehicle iskindof "pook_HEMTT_US") then {
  _initstatement = "
    _obj addaction ['<t color=''#E5E500''>'+'Cargo Load/Unload','logistics\HEMTT_load.sqf',[],-1,false,true,'','vehicle player == player && alive _target'];
    if (isServer) then {
      _obj addMPEventHandler [""MPKilled"",{
        ((_this select 0) getvariable [""Cargo"",objNull]) setdamage 1;
      }];
      _obj addMPeventhandler [""MPHit"",{
        _truck = _this select 0;
        _cargo = _truck getvariable [""Cargo"",objNull];
        if(!local _cargo || isNull _cargo) exitwith {};
        _damage = _this select 2;
        _newdamage = (getdammage _cargo) + _damage;
        _cargo setdamage _newdamage;
      }];
    };
    ";
};

if (_vehicle iskindof "pook_H13_amphib") then {
  _initstatement = "_obj addEventHandler [""getin"",{[_this select 0] execVM ""logistics\H47_MP_float_correction.sqf"";}];";
  [_vehicle] execVM "logistics\H47_MP_float_correction.sqf"; 
};

if (_vehicle iskindof "GNT_C185F") then {
  _initstatement = "_obj addEventHandler [""getin"",{[_this select 0] execVM ""logistics\C185_MP_float_correction.sqf"";}];";
  [_vehicle] execVM "logistics\C185_MP_float_correction.sqf"; 
};

if (_vehicle iskindof "MtvrRepair_DES_EP1") then {
  _initstatement = "_obj setrepaircargo 0;";
};

if (_vehicle iskindof "MtvrRefuel_DES_EP1") then {
  _initstatement = "_obj setfuelcargo 0;";
};

if (_vehicle iskindof "MtvrReammo_DES_EP1") then {
  _initstatement = "_obj setammocargo 0;";
};

if(_initstatement != "") then {
  [_vehicle,_initstatement] remoteexeccall ["Hz_fnc_setVehicleInit",0,true];
};