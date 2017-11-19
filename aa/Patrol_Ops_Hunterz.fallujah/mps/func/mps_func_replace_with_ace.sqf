// Written by EightySix

private["_pos","_dir","_replacement"];

	if(isNil "mps_ace_enabled") then { waitUntil{!isNil "mps_ace_enabled"}; };

	_object = _vehicle;

	_replacement = switch (typeof _object) do {
		case "M1126_ICV_M2_EP1": 	{"ACE_Stryker_ICV_M2_SLAT};
		case "M1126_ICV_mk19_EP1":	{"ACE_Stryker_ICV_MK19_SLAT};
		case "M1128_MGS_EP1":		{"ACE_Stryker_MGS_Slat"};
		case "M1135_ATGMV_EP1": 	{"ACE_Stryker_TOW_MG_Slat};
		case "M1A1_US_DES_EP1": 	{"ACE_M1A1_NATO"};
		case "M1A2_TUSK_MG": 		{"ACE_M1A1HA_TUSK_CSAMM};
		case "M1A2_US_TUSK_MG_EP1": 	{"ACE_M1A1HA_TUSK_CSAMM_DESERT};
		case "MtvrRepair_DES_EP1": 	{"ACE_Truck5tRepair"};
		case "MtvrReammo_DES_EP1": 	{"ACE_Truck5tReammo"};
		case "MtvrRefuel_DES_EP1": 	{"ACE_Truck5tRefuel"};
		case "MTVR_DES_EP1": 		{"ACE_Truck5tMG"};
		case "MTVR": 			{"ACE_Truck5tMG"};
		case "AH6J_EP1":	 	{"ACE_AH6J_DAGR_FLIR"};
	//	case "": {nil};
		default {nil};
	};

	if(!mps_ace_enabled) then {_replacement = nil};

	if(!isNil "_replacement") then {
		delete _object;

		_vehicle = _replacement createVehicle _pos;
		_vehicle setPosASL _pos;
		_vehicle setDir _dir;
	};

_vehicle;