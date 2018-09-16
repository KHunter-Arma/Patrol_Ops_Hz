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
	
	if (_vehicle isKindOf "Van_02_vehicle_base_F") then {
	
		_initstatement = _initstatement + "_obj addaction ['<t color=''#CC8400''>'+'Open/Close Rear Doors', {_car = _this select 0; if ((_car doorPhase 'Door_4_source') == 0) then {_car animateDoor ['Door_4_source',1]} else {_car animateDoor ['Door_4_source',0]};},[],-1,false,true,'','_dist = _this distance _target; (((vehicle _this) == _this) && (_dist < 5) && (_dist > 4))'];";
		_initstatement = _initstatement + "_obj addaction ['<t color=''#CC8400''>'+'Open/Close Side Door', {_car = _this select 0;  if ((_car doorPhase 'Door_3_source') == 0) then {_car animateDoor ['Door_3_source',1]} else {_car animateDoor ['Door_3_source',0]};},[],-1,false,true,'','_dist = _this distance _target; (((vehicle _this) == _this) && (_dist < 3.5) && (_dist > 2))'];";
	
	};
	
};

if (((toUpper (typeof _vehicle)) find "CUP") != -1) then {

	_initstatement = _initstatement + "_obj addaction ['<t color=''#dce2ed''>'+'Check fuel', {hint format ['%1%2 full',(floor fuel (_this select 0))*100,'%'];},[],-99,false,true,'','_this == (driver _target)'];";
	
};

if(_initstatement != "") then {
  [_vehicle,_initstatement] remoteexeccall ["Hz_fnc_setVehicleInit",0,true];
};