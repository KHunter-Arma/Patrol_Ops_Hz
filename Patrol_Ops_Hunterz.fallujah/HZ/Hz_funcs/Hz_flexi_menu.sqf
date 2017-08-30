private ["_menuDef","_target","_params","_menuName","_menuRsc","_menus","_visible"];

// _this==[_target, _menuNameOrParams]
_target = _this select 0;
_params = _this select 1;

_menuName = "";
_menuRsc = "popup";

if (typeName _params == typeName []) then {
	if (count _params < 1) exitWith {diag_log format["Error: Invalid params: %1, %2", _this, __FILE__];};
	_menuName = _params select 0;
	_menuRsc = if (count _params > 1) then {_params select 1} else {_menuRsc};
} else {
	_menuName = _params;
};

//-----------------------------------------------------------------------------

_visible = true;
if (!alive player) then {
_visible = false;
};

_menus = [
	[
		["main", "Main Menu", _menuRsc],
		[
			["Hunter'z >", "", "", "",
				["HZ\Hz_funcs\Hz_flexi_menu.sqf", "HzFlexiMenuOptions", 1],
				-1, 1, true]	
		]
	]
];

if(_menuName == "HzFlexiMenuOptions") then {
     
         _menus set [count _menus,
			[
				["HzFlexiMenuOptions", "Hunter'z", "popup", ""],
				[
					[
					"Request New Task",
						{ if(!taskrequested) then {taskrequested = true; publicVariable "taskrequested"; hint "Task requested. You will receive a new task once the task conditions are satisfied.";} else {hint "A new task has already been requested. You will receive a new task only if all task conditions are satisfied.";};},
						"", "", "", -1, 1,
						((player getvariable ["TL",false]) || hz_debug), (true)
					],
                                        
                                        [
					"Initialise Joint Operation",
						{ if(!taskrequested && !jointops) then {jointops = true; publicVariable "jointops"; hint "Initialising joint ops... You will receive a new task once the task conditions are satisfied.";} else {hint "A new task has already been requested. You will receive a new task only if all task conditions are satisfied.";};},
						"", "", "", -1, 1,
						((player getvariable ["TL",false]) || hz_debug), (true)
					],
                                        
                                        [
					"Sleep for 10 hours",
						{ [-2, {[] execvm "HZ\HZ_scripts\Hz_MP_all_sleep.sqf";}] call CBA_fnc_globalExecute;},
						"", "", "", -1, 1,
						((player getvariable ["TL",false]) || hz_debug), (true)
					],
                                        
                                        [
					"Save Game",
						{ [-2, {call compile preprocessFileLineNumbers "HZ\HZ_savegame.sqf";}] call CBA_fnc_globalExecute;},
						"", "", "", -1, 1,
						(([] call Hz_func_isSupervisor) || hz_debug), (true)
					],
                                        
                                        [
					"Admin System",
						{[] execvm "HZ\dialogs\admin\HZ_admin_open.sqf";},
						"", "", "", -1, 1,
						(([] call Hz_func_isSupervisor) || hz_debug), (true)
					],
                                        
                                        [
					"View Available Weapons",
						{hint "Not yet implemented";},
						"", "", "", -1, 1,
						(true), (true)
					]
				]
			]
		];
               
};

//-----------------------------------------------------------------------------

_menuDef = [];
{
	if (_x select 0 select 0 == _menuName) exitWith {_menuDef = _x};
} forEach _menus;

if (count _menuDef == 0) then {
	hintC format ["Error: Menu not found: %1\n%2\n%3", str _menuName, if (_menuName == "") then {_this}else{""}, __FILE__];
	diag_log format ["Error: Menu not found: %1, %2, %3", str _menuName, _this, __FILE__];
};

_menuDef // return value