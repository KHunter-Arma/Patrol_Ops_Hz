private ["_initstatement","_vehicle"];
_vehicle = _this select 0;
_initstatement = "";

if (_vehicle iskindof "CUP_FlagCarrierIONblack_PMC") then {
  _initstatement = "_obj setFlagTexture ""Hz_media\pops\flag_pmc.jpg"";";
};

if ((_vehicle iskindof "SignAd_SponsorS_ION_F") || (_vehicle iskindof "SignAd_Sponsor_ION_F") || (_vehicle iskindof "Banner_01_F")) then {
  _initstatement = "_obj setObjectTexture [0,""Hz_media\pops\flag_pmc.jpg""];";
};

if (_vehicle isKindOf "LandVehicle") then {

	_initstatement = _initstatement + "_obj setVariable ['flipAnimHandler',_obj addAction ['<t color=''#FF0000''>Flip vehicle</t>','logistics\vehicle_flip.sqf' , nil, 1.5, true, true, '', '((vehicle _this) == _this) && {_vectorUp = vectorUp _target; (((_vectorUp select 2) < 0) || {(_vectorUp select 0) > 0.7})}', 6, false, '']];";
	
	if (_vehicle isKindOf "Van_02_base_F") then {
	
		_initstatement = _initstatement + "_obj addaction ['<t color=''#CC8400''>'+'Open/Close Rear Doors', {_car = _this select 0; if ((_car doorPhase 'Door_4_source') == 0) then {_car animateDoor ['Door_4_source',1]} else {_car animateDoor ['Door_4_source',0]};},[],-1,false,true,'','_dist = _this distance _target; (((vehicle _this) == _this) && (_dist < 5) && (_dist > 4))'];";
		_initstatement = _initstatement + "_obj addaction ['<t color=''#CC8400''>'+'Open/Close Side Door', {_car = _this select 0;  if ((_car doorPhase 'Door_3_source') == 0) then {_car animateDoor ['Door_3_source',1]} else {_car animateDoor ['Door_3_source',0]};},[],-1,false,true,'','_dist = _this distance _target; (((vehicle _this) == _this) && (_dist < 3.5) && (_dist > 2))'];";
	
	};
	
	if (_vehicle isKindOf "C_IDAP_Truck_02_water_F") then {
	
		_initstatement = _initstatement + "_obj addaction ['<t color=''#00ffff''>'+'Fill water cooler','logistics\fillWater.sqf',[],-1,false,true,'','_dist = _this distance _target; (((vehicle _this) == _this) && (_dist < 6) && (_dist > 4))']; if ((!isDedicated) && (local _obj)) then {[_obj, 0] call acex_field_rations_fnc_setRemainingWater;};";
	
	};
	
	// ignore back seats since it's supposed to be a cargo van...
	if ((typeof _vehicle) in ["tw_van_white", "tw_van_black"]) then {
		_initstatement = _initstatement + "_obj lockCargo [1, true]; _obj lockCargo [2, true]; _obj lockCargo [3, true]; _obj lockCargo [4, true]; _obj lockCargo [5, true]; _obj lockCargo [6, true];";	
	};
	
};

if (_vehicle isKindOf "Land_FMradio_F") then {
	
		_initstatement = _initstatement + "[_obj, false] call klpq_musicRadio_fnc_addRadio; [_obj, -1] call ace_field_rations_fnc_setRemainingWater;";
	
};

if (((((toUpper (typeof _vehicle)) find "CUP") != -1) && {!(_vehicle isKindOf "CUP_LR_Base")}) || {(typeof _vehicle) in ["tw_explorer","V12_STRALIS23","tw_raptor_black","prraptor_noir","tw_van_black","tw_van_white","tw_ram","V12_RAM6X6_NOIR","V12_RAM_NOIR","V12_VELOCIRAPTOR","tw_vic_black","V12_H1TOPB","V12_H1TOP_NOIRB","V12_H1BB","V12_H1_NOIRB","V12_H1ASSAULT","V12_H1_NOIR","V12_H1B","suburban","tahoe_UNM","Mer_Vito_civ_noir","V12_FOCUSST12_NOIR","ranger17ch_noir","chdefender_civ_noir"]}) then {

	_initstatement = _initstatement + "_obj addaction ['<t color=''#dce2ed''>'+'Check fuel', {hint format ['%1%2 full',floor (( fuel (_this select 0))*100),'%'];},[],-99,false,true,'','_this == (driver _target)'];";
	
};

_initstatement = _initstatement + "_obj addEventHandler ['Killed',{{if ((_x isKindOf 'StaticWeapon') || {_x isKindOf 'Cargo_base_F'}) then {{_x setDamage 1;} foreach (attachedObjects _x);}; _x setDamage 1;} foreach (attachedObjects (_this select 0));}];";

if(_initstatement != "") then {
  [_vehicle,_initstatement] remoteexeccall ["Hz_fnc_setVehicleInit",0,true];
};

_vehicle addMPEventHandler ["MPKilled", {
	params ["_vehicle", "_killer", "_instigator", "_useEffects"];	
	if (!local _vehicle) exitWith {};	
	if ("Files" in (magazineCargo _vehicle)) then {
		Hz_pops_failFileTask = true;
		publicVariable "Hz_pops_failFileTask";
	};	
}];
