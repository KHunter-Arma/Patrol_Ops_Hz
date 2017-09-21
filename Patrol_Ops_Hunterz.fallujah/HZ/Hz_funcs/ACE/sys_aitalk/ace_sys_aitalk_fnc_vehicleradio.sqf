#include "script_component.hpp"

private ["_vecs", "_vecindex", "_vehicle", "_side", "_array"];

sleep 121 + random 100;

while {true} do {
	if (alive player) then {
		if (vehicle player == player) then {
			_vecs = call FUNC(GetRadioVehicles);
			if (count _vecs > 0) then {
				_vecindex = floor random (count _vecs);
				_vehicle = _vecs select _vecindex;
				_side = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "side");
				if (_side in [0,1,2]) then {
					if (({alive _x} count (crew _vehicle)) > 0) then {
						{
							if (alive _x) exitWith {
								_side = _x call FUNC(getvecfaction);
							};
						} forEach crew _vehicle;
					};
					switch (_side) do {
						case 0: {
							_array = GVAR(rus_vec_radio) select 0;
							_vehicle say3D (_array select (floor random (count _array)));
						};
						case 1: {
							_array = if (_vehicle isKindOf "Air") then {
								GVAR(us_vec_radio) select 1
							} else {
								GVAR(us_vec_radio) select 0
							};
							_vehicle say3D (_array select (floor random (count _array)));
						};
					};
				};
			};
		} else {
			_vehicle = vehicle player;
			if (!(_vehicle isKindOf "ParachuteBase" || {_vehicle isKindOf "StaticWeapon"} || {_vehicle isKindOf "Motorcycle"} || {_vehicle isKindOf "BIS_Steerable_Parachute"} || {_vehicle isKindOf "ATV_Base_EP1"}) && !(_vehicle getvariable ["Hz_vehicles_noRadioSound",false])) then {
				_side = getNumber (configFile>>"CfgVehicles" >> typeOf _vehicle >> "side");
				if (_side in [0,1,2]) then {
					if (_side == 0) then {
						_array = GVAR(rus_vec_radio) select 0;
						_vehicle say3D (_array select (floor random (count _array)));
					} else {
						_array = if (_vehicle isKindOf "Air") then {
							GVAR(us_vec_radio) select 1
						} else {
							GVAR(us_vec_radio) select 0
						};
						_vehicle say3D (_array select (floor random (count _array)));
					};
				};
			};
		};
	};
	sleep 80 + (random 220);
};
