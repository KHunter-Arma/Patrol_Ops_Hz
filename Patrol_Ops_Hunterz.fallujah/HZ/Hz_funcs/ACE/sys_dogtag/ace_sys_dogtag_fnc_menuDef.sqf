// #define DEBUG_MODE_FULL
#include "script_component.hpp"
#include "\ca\editor\Data\Scripts\dikCodes.h"

private ["_menuDef", "_target", "_params", "_menuName", "_menuRsc", "_menus"];

// _this==[_target, _menuNameOrParams]
PARAMS_2(_target,_params);
if ((_target distance player) > 2.5) exitWith {}; // TODO: Menu range is way to big, should not be > 2.5 - 3 m ! // Menu title still becomes shown though

_menuName = "";
_menuRsc = "popup";

if (typeName _params == typeName []) then {
	if (count _params < 1) exitWith {diag_log format["Error: Invalid params: %1, %2", _this, __FILE__]};
	_menuName = _params select 0;
	_menuRsc = if (count _params > 1) then {_params select 1} else {_menuRsc};
} else {
	_menuName = _params;
};
//-----------------------------------------------------------------------------

_inVehicle = (player != vehicle player);
//_playerIsBusy = (animationState player == "AinvPknlMstpSlayWrflDnon_medic");

_capable = alive player && {!_inVehicle} && {!(player call ace_sys_wounds_fnc_isUncon)};

//-----------------------------------------------------------------------------

private ["_name_dragee"];
if (_target isKindOf "CAManBase") then {
	_name_dragee = localize "STR_ACE_NO_UNIT"; // "body"
	if (alive _target) then {if (name _target != "Error: No unit") then {_name_dragee = name _target}};
} else {
	_name_dragee = getText (configFile >> "cfgVehicles" >> typeOf _target >> "displayName");
	if (_name_dragee == "") then {_name_dragee = typeOf _target};
};

private["_case"];
_case = if (side (group _target) == side (group player)) then {1} else {0};
if !(alive _target) then {_case = _case + 2};
//_isEnemy = _case in [0,2];
//_isFriend = _case in [1,3];
//_srrs = !(isNil "BIS_SRRS_init");
_isCiv = _target isKindOf "Civilian";

//TRACE_1("_isFriend", _isFriend);
_menus =
[
	[
		["main", if (_case == 0) then {"Person:"} else {_name_dragee}, _menuRsc],
		[
			[localize "STR_ACE_DOG2",
				{ [CBA_UI_TARGET] spawn FUNC(dogtag) },
				"", "", "", DIK_T, 1, _capable && {!alive _target} && {!_isCiv} && {ACE_SELFINTERACTION_RESTRICTED} && {!(_target getvariable ["cms_enable",false])}]
		]
	]
];

//-----------------------------------------------------------------------------
_menuDef = [];
{
	if (_x select 0 select 0 == _menuName) exitWith {_menuDef = _x};
} forEach _menus;

if (count _menuDef == 0) then {
	hintC format ["Error: Menu not found: %1\n%2", str _menuName, if (_menuName == "") then {_params} else {""}];
	diag_log format ["Error: Menu not found: %1, %2, %3", str _menuName, _params, __FILE__];
};

_menuDef // return value
				