//#define DEBUG_MODE_FULL
#include "script_component.hpp"
#include "\ca\editor\Data\Scripts\dikCodes.h"

private ["_menuDef", "_target", "_params", "_menuName", "_menuRsc", "_menus"];

// _this==[_target, _menuNameOrParams]
PARAMS_2(_target,_params);

_menuDef = [];
_menuName = "";
_menuRsc = "popup";

if (typeName _params == typeName []) then {
	if (count _params < 1) exitWith {diag_log format["Error: Invalid params: %1, %2", _this, __FILE__];};
	_menuName = _params select 0;
	_menuRsc = if (count _params > 1) then {_params select 1} else {_menuRsc};
} else {
	_menuName = _params;
};

_menus = [];

if (_menuName == "main") then {

	private ["_type", "_canRearm", "_canRefuel", "_canRepair"];
	
	_type = typeOf _target;
	while {"ace_sys_repair" == getText (configFile >> "CfgVehicles" >> _type >> "vehicleClass")} do {
		_type = configName inheritsFrom (configFile >> "CfgVehicles" >> _type);
	};
	
	_canRearm  = 0 < getNumber (configFile >> "CfgVehicles" >> _type >> "transportAmmo");
	_canRefuel = 0 < getNumber (configFile >> "CfgVehicles" >> _type >> "transportFuel");
	_canRepair = 0 < getNumber (configFile >> "CfgVehicles" >> _type >> "transportRepair");
	
	if !(_canRearm || {_canRefuel} || {_canRepair}) exitWith {_menuDef};
	if !(alive _target) exitWith {_menuDef};
	// not inside vehicle 
	//if (player == vehicle player) exitWith {_menuDef};
	
	_menus = [
		[
			[_menuName, "", _menuRsc],
			[
				[localize "STR_ACE_UA_REARM" + " >",
					"","","",
					[QPATHTO_F(fnc_menuDef_support), "rearm_submenu", 1],
					DIK_A, true, _canRearm],
				[localize "STR_ACE_UA_REFUEL" + " >",
					"","","",
					[QPATHTO_F(fnc_menuDef_support), "refuel_submenu", 1],
					DIK_F, true, _canRefuel],
				[localize "STR_ACE_UA_REPAIR" + " >",
					"","","",
					[QPATHTO_F(fnc_menuDef_support), "repair_submenu", 1],
					DIK_R, true, _canRepair]
			]
		]
	];
};

if (_menuName in ["rearm_submenu","refuel_submenu","repair_submenu"]) then {

	private ["_vehicles_menu_array", "_vehicle_key", "_vehicle_name", "_vehicle_icon", "_vehicle_action", "_self"];

	GVAR(vehicles) =     (position _target) nearEntities [["LandVehicle", "Ship"], 15];
	ADD( GVAR(vehicles), (position _target) nearEntities [ARR_2("Air", 20)]);
	TRACE_1("",GVAR(vehicles));

	_vehicles_menu_array = [];
	_vehicle_key = DIK_1;

	{
		_vehicle_name = getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
		_vehicle_icon = getText(configFile >> "CfgVehicles" >> typeOf _x >> "picture");
		_vehicle_action = switch (_menuName) do {
			case "rearm_submenu" : {format ["[" + QGVAR(vehicles) + " select %1, cba_ui_target] spawn " + QUOTE(FUNC(rearm)),  _forEachIndex]};
			case "refuel_submenu": {format ["[" + QGVAR(vehicles) + " select %1, cba_ui_target] spawn " + QUOTE(FUNC(refuel)), _forEachIndex]};
			case "repair_submenu": {format ["[" + QGVAR(vehicles) + " select %1, cba_ui_target] spawn " + QUOTE(FUNC(repair)), _forEachIndex]};
		};
		TRACE_2("",_vehicle_name,_vehicle_action);
		if (_x != _target) then {
			PUSH(_vehicles_menu_array, [ARR_8(_vehicle_name, _vehicle_action, _vehicle_icon, "", "", _vehicle_key, true, true)]);
			TRACE_1("",_vehicle_key);
			if (-1 != _vehicle_key) then {
				INC(_vehicle_key);
				if (DIK_0 < _vehicle_key) then {_vehicle_key = -1;};
			};
		} else {
			_self = ["self (" + _vehicle_name + ")", _vehicle_action, _vehicle_icon, "", "", _vehicle_key, true, true]
		};
	} foreach GVAR(vehicles);

	if !(isNil "_self") then {
		_self set [5, _vehicle_key];
		PUSH(_vehicles_menu_array, _self);
	};

	_menus set [count _menus,
		[
			[_menuName, "Vehicles", _menuRsc, ""],
			_vehicles_menu_array
		]
	];
};

if (0 == count _menus) exitWith {_menuDef};

//-----------------------------------------------------------------------------

{
	if (_x select 0 select 0 == _menuName) exitWith {_menuDef = _x};
} forEach _menus;

if (count _menuDef == 0) then {
	hintC format ["Error: Menu not found: %1\n%2\n%3", str _menuName, if (_menuName == "") then {_this} else {""}, __FILE__];
	diag_log format ["Error: Menu not found: %1, %2, %3", str _menuName, _this, __FILE__];
};

if(isNil "_menuDef") then {_menuDef = [] };
_menuDef // return value
