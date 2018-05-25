private ["_initstatement","_vehicle"];
_vehicle = _this select 0;
_initstatement = "";

if (_vehicle iskindof "CUP_FlagCarrierIONblack_PMC") then {
  _initstatement = "_obj setFlagTexture ""media\flag5.jpg"";";
};

if ((_vehicle iskindof "SignAd_SponsorS_ION_F") || (_vehicle iskindof "SignAd_Sponsor_ION_F") || (_vehicle iskindof "Banner_01_F")) then {
  _initstatement = "_obj setObjectTexture [0,""media\flag5.jpg""];";
};

if (_vehicle isKindOf "LandVehicle") then {

	_initstatement = _initstatement + "_obj addAction ['<t color=''#FF0000''>Flip vehicle</t>','vehicle_flip.sqf' , nil, 1.5, true, true, '', '(((vectorUp _target) select 2) < 0 || ((vectorUp _target) select 0) > 0.8) && (vehicle _this == _this)', 6, false, ''];";
	_initstatement = _initstatement + "_obj addaction ['<t color=''#dce2ed''>'+'Check fuel', {hint format ['%1%2 full',(fuel (_this select 0))*100,'%'];},[],-99,false,true,'','_this == (driver _target)'];";
	
};

if (_vehicle isKindOf "Air") then {

	_initstatement = _initstatement + "_obj addaction ['<t color=''#dce2ed''>'+'Check fuel', {hint format ['%1%2 full',(fuel (_this select 0))*100,'%'];},[],-99,false,true,'','_this == (driver _target)'];";
	
};

if(_initstatement != "") then {
  [_vehicle,_initstatement] remoteexeccall ["Hz_fnc_setVehicleInit",0,true];
};