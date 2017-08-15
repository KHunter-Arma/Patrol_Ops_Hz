// by Xeno
// #include "x_setup.sqf"
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_config","_count","_i","_magazines","_object","_type","_type_name", "_prev_fuel"];

PARAMS_1(_object);
if (typeOf _object == "HeliH") then {
	_object = _this select 1;
};

_type = typeof _object;

if (_object isKindOf "ParachuteBase") exitWith {};

// _lrl = GVD(_object,GVAR(last_reload),-1);
_lrl = _object getVariable[QGVAR(last_reload),-1];
TRACE_2("last_reload",_object,GVAR(last_reload));
if (_lrl != -1 && {(time - _lrl) < 60}) exitWith {
	if (!isDedicated) then {
		[_object, format ["You have to wait %1 seconds before you can service the vehicle again...", round (60 - (time - _lrl))]] call FUNC(VehicleChat)
	};
};
_object setVariable [QGVAR(last_reload), time];

if (isNil {GVAR(reload_time_factor)}) then {GVAR(reload_time_factor) = 1};

if (GVAR(reload_engineoff)) then {_object action ["engineOff", _object]};
if (!alive _object) exitWith {};
_prev_fuel = fuel _object;
_object setFuel 0;
_object setVehicleAmmo 1;

_type_name = [_type,0] call FUNC(GetDisplayName);
if (_type_name == "") then {_type_name = _type};
if (!isDedicated) then {[_object,format ["Servicing %1... Please stand by...", _type_name]] call FUNC(VehicleChat)};

_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");

if (count _magazines > 0) then {
	_removed = [];
	{
		if (!(_x in _removed)) then {
			_object removeMagazines _x;
			_removed set [count _removed, _x];
		};
	} forEach _magazines;
	{
		if (!isDedicated) then {[_object, format ["Reloading %1", _x]] call FUNC(VehicleChat)};
		sleep GVAR(reload_time_factor);
		if (!alive _object) exitWith {};
		_object addMagazine _x;
	} forEach _magazines;
};

_cfgturrets = configFile >> "CfgVehicles" >> _type >> "Turrets";
_turrets = [_cfgturrets] call FUNC(returnVehicleTurrets);

_reloadTurrets = {
	private ["_turrets", "_path", "_cfgturrets"];
	PARAMS_3(_turrets,_path,_cfgturrets);

	private "_i";
	_i = 0;
	while {_i < (count _turrets)} do {
		private ["_turretIndex", "_thisTurret"];
		_turretIndex = _turrets select _i;
		_thisTurret = _path + [_turretIndex];

		_cfgturrets = _cfgturrets select _turretIndex;
		_fullmags = getArray(_cfgturrets >> "magazines");
		_magazines = _object magazinesTurret _thisTurret;

		if (!alive _object) exitWith {};
		_removed = [];
		{
			if !(_x in _removed) then {
				_object removeMagazinesTurret [_x, _thisTurret];
				_removed set [count _removed, _x];
			};
		} forEach _magazines;
		if (!alive _object) exitWith {};
		{
			_mag_disp_name = [_x,2] call FUNC(GetDisplayName);
			if (_mag_disp_name == "") then {_mag_disp_name = _x};
			if (!isDedicated) then {[_object,format ["Reloading %1", _mag_disp_name]] call FUNC(VehicleChat)};
			sleep GVAR(reload_time_factor);
			if (!alive _object) exitWith {};
			_object addMagazineTurret [_x, _thisTurret];
			sleep GVAR(reload_time_factor);
			if (!alive _object) exitWith {};
		} forEach _fullmags;

		if (!alive _object) exitWith {};

		_cfgturrets = _cfgturrets select 0;
		[_turrets select (_i + 1), _thisTurret, _cfgturrets] call _reloadTurrets;
		_i = _i + 2;
		if (!alive _object) exitWith {};
	};
};

if (count _turrets > 0) then {
	[_turrets, [], _cfgturrets] call _reloadTurrets;
};

if (!alive _object) exitWith {};

_object setVehicleAmmo 1;

#ifdef __MANDO__
if (local _object) then {
	_samsleft = _object getVariable "mando_flaresleft";
	_maxsams  = _object getVariable "mando_maxflares";
	if (!isNil "_samsleft" && {!isNil "_maxsams"}) then {
		_object setVariable ["mando_flaresleft", _maxsams, true];
		if (!isDedicated) then {[_object, "Reloading countermeasures..."] call FUNC(VehicleChat)};
	};
};
#endif

if (!alive _object) exitWith {};
if (!isDedicated) then {[_object, format ["%1 is ready...", _type_name]] call FUNC(VehicleChat)};
_object setFuel _prev_fuel;
reload _object;
