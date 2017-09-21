
hint "Disabled in Hunter'z";

/*

//#define DEBUG_MODE_FULL
#include "script_component.hpp"

[] spawn {
	{ __HIDE(_x); } foreach [66371,66372,66373];
	_veh = GET_SELECTED_VEHICLE;
	_veh_type = GET_SELECTED_DATA(66363);
	_repairTime = 60; // TODO
	[QGVAR(setBusyRea), [_veh, _repairTime]] call CBA_fnc_globalEvent;
	
	_veh setVariable ["ACE_PB_Result", 0];
	[60,[localize "STR_CFG_CUTSCENES_REARM"],true,false,_veh] spawn ace_progressbar;
	waitUntil { (_veh getVariable "ACE_PB_Result" != 0) };
	if (_veh getVariable "ACE_PB_Result" == 1) then {
		//hull
		_current_magazines = [];
		_default_magazines_hull = getArray(configFile >> "CfgVehicles" >> _veh_type >> "magazines");
		TRACE_1("",_default_magazines_hull);
		if (_veh isKindOf "Car") then {
		//if (_veh isKindOf "Plane" || {_veh isKindOf "Helicopter"} || {_veh isKindOf "Car"}) then 
			_current_magazines = magazines _veh;
			TRACE_1("",_current_magazines);
			{_veh removeMagazine _x; TRACE_1("Removing magazine",_x); } forEach _current_magazines;
			{_veh addMagazine _x; TRACE_1("Adding magazine",_x); } forEach _default_magazines_hull;
		}else{
			_veh setVehicleAmmo 1; // Empty magazines are not catched by the stupid engine
			_current_magazines = _veh magazinesTurret [-1];
			{_veh removeMagazine _x;} forEach _current_magazines;
			{_veh removeMagazineTurret [_x,[-1]];} forEach _current_magazines;
			{
				// Fucking SMDICK fix for CMFlare Launchers, hopefully BIS get their shitty rearm simulation done in A3
				_isFlare = (getText(configFile >> "CfgMagazines" >> _x >> "ammo") in ["CMflareAmmo","CMflare_Chaff_Ammo"]);
				if (_isFlare) then {
					if ("CMFlareLauncher" in (_veh weaponsTurret [-1])) then {
						_veh removeWeapon "CMFlareLauncher";
						_veh addMagazineTurret [_x,[-1]];
						_veh addWeapon "CMFlareLauncher";
						reload _veh;
					};
				} else {
					_veh addMagazineTurret [_x,[-1]];
				};
			} forEach _default_magazines_hull;
		};

		//turrets
		_turrets= configFile >> "CfgVehicles" >> _veh_type >> "Turrets"; TRACE_1("",_turrets);
		for "_i" from 0 to (count _turrets)-1 do {
			_turret = _turrets select _i;
			_weapons = _veh weaponsTurret [_i];


			if !(isNil {_weapons select 0}) then {
				_current_magazines = _veh magazinesTurret [_i];
				_default_magazines = getArray(_turret >> "magazines");
				{_veh removeMagazineTurret [_x,[_i]];} forEach _current_magazines;
				{_veh addMagazineTurret [_x,[_i]];} forEach _default_magazines;
			};
			_subturrets = _turret >> "Turrets";
			for "_j" from 0 to (count _subturrets)-1 do {
				_turret = _subturrets select _j;
				_weapons = _veh weaponsTurret [_i,_j];
				if !(isNil {_weapons select 0}) then {
					_current_magazines = _veh magazinesTurret [_i,_j];
					_default_magazines = getArray(_turret >> "magazines");
					{_veh removeMagazineTurret [_x,[_i,_j]];} forEach _current_magazines;
					{_veh addMagazineTurret [_x,[_i,_j]];} forEach _default_magazines;
				};
			};
		};
	};
	[QGVAR(unsetBusyRea), _veh] call CBA_fnc_globalEvent;
	{ __SHOW(_x); } foreach [66371,66372,66373];
	
	[] call FUNC(fill_current_magazines_list);
	[_veh] call FUNC(fill_transportMagazines);
};

*/
