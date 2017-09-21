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
			["Animations >", "", "", "",
				["HZ\Hz_funcs\Hz_anim_menu.sqf", "Animations", 1],
				-1, 1, true]	
		]
	]
];

if(_menuName == "Animations") then {
     
         _menus set [count _menus,
			[
				["Animations", "Hunter'z", "popup", ""],
				[	                              
          [
					"Lie down 1",
						{player playmove "AidlPpneMstpSnonWnonDnon_SleepA_sleep2"},
						"", "", "", -1, 1,
						(true), (true)
					],
					
					[
					"Lie down 2",
						{player playmove "AidlPpneMstpSnonWnonDnon_SleepB_sleep3"},
						"", "", "", -1, 1,
						(true), (true)
					],
					
					[
					"Lie down 3",
						{player playmove "AidlPpneMstpSnonWnonDnon_SleepC_layDown"},
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