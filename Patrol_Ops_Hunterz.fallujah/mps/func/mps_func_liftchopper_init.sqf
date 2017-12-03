// Written by Xeno
// Adapted by BON_IF
// Adapted by EightySix

if(!mps_liftchopper_enable) exitWith {};
if(not local player) exitWith {};

private ["_vehicle","_menu_lift_shown","_nearest","_id","_pos","_npos"];

_vehicles_lift_list = ["Car"];
_vehicles_nolift_list = ["Wheeled_APC"];

_vehicle = _this select 0;
_vehicleType = typeof _vehicle;

Vehicle_Attached = false;
Vehicle_Released = false;
_menu_lift_shown = false;
vehicle_attached_list = [];
_nearest = objNull;
_id = -1;

_title = "Advanced Vehicles";
_step = "Lift Chopper";
_content = format["This %1 is a Lift Chopper, capable of lifting up cars and trucks. Hover over between 3-9m above to be able to lift the object.", getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName")];
[_title,_content,_step] spawn mps_adv_hint;

sleep 5;

WaitUntil{(alive _vehicle) && (alive player) && (driver _vehicle == player)};

while {(alive _vehicle) && (alive player) && (driver _vehicle == player)} do {
	if ((driver _vehicle) == player) then {
		_pos = getPos _vehicle;
		
		if (!Vehicle_Attached && (_pos select 2 > 2.5) && (_pos select 2 < 10)) then {
			_nearest = nearestObjects [_vehicle,["LandVehicle","Boat"],30];
			_nearest = if(count _nearest > 0) then {_nearest select 0} else {ObjNull};
			sleep 0.1;

			if ( !(isNull _nearest) && ({_nearest isKindOf _x} count mps_liftable > 0 && {_nearest isKindOf _x} count _vehicles_nolift_list == 0 || !isNil {_nearest getVariable "liftable"} ) ) then {
				_nearest_pos = getPos _nearest;
				_nx = _nearest_pos select 0;_ny = _nearest_pos select 1;_px = _pos select 0;_py = _pos select 1;
				if ((_px <= _nx + 3 && _px >= _nx - 3) && (_py <= _ny + 3 && _py >= _ny - 3)) then {
					if (!_menu_lift_shown) then {
						_id = _vehicle addAction ["<t color='#FFc600'>Lift vehicle</t>", (mps_path+"action\mps_heli_lift.sqf"),[_nearest],99];
						_menu_lift_shown = true;
					};
				} else {
					_nearest = objNull;
					if (_menu_lift_shown) then {
						_vehicle removeAction _id;
						_menu_lift_shown = false;
					};
				};
			};
		} else {
			if (_menu_lift_shown) then {
				_vehicle removeAction _id;
				_menu_lift_shown = false;
			};
			
			sleep 0.1;
			
			if (isNull _nearest) then {
				Vehicle_Attached = false;
				Vehicle_Released = false;
			} else {
				if (Vehicle_Attached) then {
					_release_id = _vehicle addAction ["<t color='#FF0000'>Release vehicle</t>", (mps_path+"action\mps_heli_release.sqf"),[],99];
					(driver _vehicle) vehicleChat "Vehicle attached to chopper";
					vehicle_attached_list = vehicle_attached_list + [_nearest];

					_nearest attachTo [_vehicle,[0,0,-8]];
					_nearest engineOn false;
					while {!Vehicle_Released && alive _vehicle && alive _nearest && alive player && (driver _vehicle == player)} do {sleep 1};
					detach _nearest;
					
					if((position _nearest) select 2 > 160 && mps_airdrop_enable) then {[_nearest,typeof _nearest,true] execVM (mps_path+"func\mps_func_vehicle_airdrop.sqf");};

					Vehicle_Attached = false;
					Vehicle_Released = false;
					
					vehicle_attached_list = vehicle_attached_list - [_nearest];
					
					if (!alive _vehicle) then {
						_vehicle removeAction _release_id;
					} else {
						(driver _vehicle) vehicleChat "Vehicle released";
					};
					
					waitUntil {(getPos _nearest) select 2 < 10};
					
					_npos = getPos _nearest;
					_nearest setPos [_npos select 0, _npos select 1, 0];
					
					sleep 1.012;
				};
			};
		};
	};
	sleep 0.51;
};

if (!(alive _vehicle) || !(alive player)) then {
	_vehicle removeAction vec_id;
};

if (true) exitWith {};