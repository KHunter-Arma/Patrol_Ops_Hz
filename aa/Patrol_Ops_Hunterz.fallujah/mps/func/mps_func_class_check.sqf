// Written by EightySix

if(count _this < 2) exitWith{false};
private["_unit","_type"];

_unit = _this select 0;
_type = _this select 1;


//hintc format["%1", mps_class_at ];

_result = switch (_type) do {
	case "engineer" : { if( typeOf _unit IN mps_class_eng || getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "canDeactivateMines") > 0) then {true}else{false}; };
	case "crewman" : { if( typeOf _unit IN mps_class_crew ) then {true} else {false}; };
	case "sniper" : { if ( getNumber (configfile >> "CfgVehicles" >> typeOf _unit >> "camouflage") < 1 ) then {true} else {false};};
	case "driver" : { if ( vehicle _unit != _unit && driver (vehicle _unit) == _unit ) then {true} else {false}; };
	case "leader" : { if( typeOf _unit IN mps_class_tl ) then {true} else {false}; };
	case "pilot" : { if( (typeOf _unit) IN mps_class_pilot ) then {true} else {false}; };
	case "crew" : { if ( vehicle _unit != _unit && driver (vehicle _unit) != _unit ) then {true} else {false}; };
	case "mg" : { if( typeOf _unit IN mps_class_mg ) then {true} else {false}; };
	case "at" : { if( typeOf _unit IN mps_class_at ) then {true} else {false}; };
//	case "aa" : { if( typeOf _unit IN mps_class_aa ) then {true} else {false}; };
//	case "" : { false };
	default { false };
};

_result;