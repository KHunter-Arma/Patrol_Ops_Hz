// Written by Xeno
// Adapted by BON_IF
// Adapted by EightySix

private ["_vehicle","_unit","_type","_position","_damage","_resupply","_repair"];

if(isNil "mps_lock_action") then { mps_lock_action = false; };
if (mps_lock_action) then {
	hint "The current operation isn't finished.";
}else{

	mps_lock_action = true;

	_engineer = [player,"engineer"] call mps_class_check;
	_driver = [player,"driver"] call mps_class_check;
	_crewman = [player,"crew"] call mps_class_check;
	_resupply = false;

	_vehicle = _this select 0;
	if((vehicle player) isKindOf "Man") then {_vehicle = (nearestObjects [position player,["LandVehicle","Air"],10]) select 0};

	if(isNull _vehicle) exitWith{mps_lock_action = false;};

	_type = getText (configFile >> "CfgVehicles" >> typeof _vehicle >> "displayName");
	_position = position _vehicle;
	_damage = damage _vehicle;

	if (count nearestObjects [_position,mps_repair_vehicles + ["Base_WarfareBVehicleServicePoint"],25] > 0) then { _resupply = true };		// Check if Service Point nearby//debug
if(mps_debug) then
{
	player sideChat format["num rep veh: %1",count nearestObjects [_position,mps_repair_vehicles + ["Base_WarfareBVehicleServicePoint"],25]];
};
	if(!mps_class_limit) then {_engineer = true}; // If not limiting player class then all players are engineers

// Exit if parachute or Man or destroyed
	if (_vehicle isKindOf "ParachuteBase" || _vehicle isKindOf "Man" || !alive _vehicle) exitWith {if (!alive _vehicle) then {hint "Vehicle is too damaged to repair";};mps_lock_action = false;};

// Exit if outside the vehicle and not an engineer and not near resupply
	if(!_driver && !_crewman && !_engineer && !_resupply) exitWith {
		mps_lock_action = false;

		_title = "Repair and Resupply";
		_step = "Vehicle Field Repair";
		_content = "Only engineers have the skillset to repair vehicles in the field.";
		[_title,_content,_step,10] spawn playeradvhint;
	};

// Exit if outside the vehicle and not an engineer and near resupply
	if(!_driver && !_crewman && !_engineer && _resupply) exitWith {
		mps_lock_action = false;

		_title = "Repair and Resupply";
		_step = "Vehicle Field Repair";
		_content = "Only engineers and the vehicles driver can repair and resupply vehicles when near a vehicle service point.";
		[_title,_content,_step,10] spawn playeradvhint;
	};

// Exit if inside the vehicle and not driver
	if(_crewman && !_driver) exitWith {
		mps_lock_action = false;

		_title = "Repair and Resupply";
		_step = "Vehicle Resupply";
		_content = "Only a vehicles driver can resupply a vehicle from inside and only when near a Vehicle Service Point.";
		[_title,_content,_step,10] spawn playeradvhint;
	};

// Exit if driver and not near service point
	if(_driver && !_resupply) exitWith {
		mps_lock_action = false;
		_title = "Repair and Resupply";
		_step = "Vehicle Resupply";
		_content = "The vehicle must be near a Vehicle Service Point to repair and resupply with fuel and ammunition.";
		[_title,_content,_step,10] spawn playeradvhint;
	};

// Exit if not driver and not engineer as redundant double check
	if(!_driver && !_engineer) exitWith {
		mps_lock_action = false;
		_title = "Repair and Resupply";
		_step = "Vehicle Resupply";
		_content = "Only a vehicles driver or an Engineer can resupply a vehicle.<br/><br/>Engineers can perform field repairs.<br/>To fully repair and resupply a vehicle, a repair truck or Vehicle Service Point must be nearby.";
		[_title,_content,_step,10] spawn playeradvhint;
	};

// Shuts down vehicles engine
	(_vehicle) engineOn false;

// Exit if vehicle is able to customise its loadout
	if( { _vehicle isKindof _x } count mps_aas_supported_vehicles > 0 && _driver && _resupply) exitWith{
		mps_lock_action = false;
		createDialog "mps_aas_loadout";
	};

// Begin Repair and Resupply function
	if(_damage > 0.4 && !_resupply) then { _repair = 0.4 }else{ _repair = _damage};

	if(_resupply) then {
		_repair = 0;
		_vehicle setFuel 0;
		_vehicle vehicleChat format ["Full Service of %1, Please stand by...", _type];
		hint format ["Full Service of %1, Please stand by...", _type];
	}else{
		_vehicle vehicleChat format ["Field Reparing %1, Please stand by...", _type];
		hint format ["Field Reparing %1, Please stand by...", _type];
	};

player playMove "ActsPercSnonWnonDnon_carFixing2";


if (!alive _vehicle || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";mps_lock_action = false;};
	_vehicle vehicleChat format ["Repairing %1...", _type];
	sleep 10;
	sleep (_damage*20);
	_vehicle setDamage _repair;

if (!alive _vehicle || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";mps_lock_action = false;};
	if(_resupply) then{
		_turretcount = count (configFile >> "CfgVehicles" >> typeof _vehicle >> "turrets");
		if(_turretcount > 0) then {
			_turret = (configFile >> "CfgVehicles" >> typeof _vehicle >> "turrets") select 0;
			_total_magazines = getArray (_turret >> "magazines");
			_magazines_left = magazines _vehicle;
			_magazines_to_fill = [];
			_magazinetypes = [];
			{ if(not(_x in _magazinetypes)) then{_magazinetypes = _magazinetypes + [_x]}; } foreach _total_magazines;
			{	_magtype = _x;
				_diff = ({_x == _magtype} count _total_magazines) - ({_x == _magtype} count _magazines_left) + 1;
				for "_j" from 1 to _diff do {_magazines_to_fill = _magazines_to_fill + [_magtype]};
				_magazines_left = _magazines_left - [_magtype];
				for "_j" from 1 to (({_x == _magtype} count _total_magazines) - _diff) do{_magazines_left = _magazines_left + [_magtype]};
			} foreach _magazinetypes;
			_vehicle setvehicleammo 1;
			{_vehicle removeMagazines _x} foreach magazines _vehicle;
			{_vehicle addMagazine _x} foreach _magazines_left;
			{	_displayname = getText (configFile >> "CfgMagazines" >> _x >> "displayname");
				if(_displayname == "") then {_displayname = _x};
				_vehicle vehicleChat format["Rearming %1...",_displayname]; hint format["Rearming %1...",_displayname];
				sleep 5;
				_vehicle addMagazine _x;
			} foreach _magazines_to_fill;
			_vehicle setVehicleAmmo 1;
		};
		_vehicle setVehicleAmmo 1;
	};

if (!alive _vehicle || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";mps_lock_action = false;};
	_vehicle vehicleChat format ["Refueling %1...", _type];
	hintsilent format ["Refueling %1...", _type];
	while {fuel _vehicle < 0.99 && alive _vehicle} do {
		_vehicle setFuel ( (fuel _vehicle) + 0.1);
		sleep 0.3;
	};

if (!alive _vehicle || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";mps_lock_action = false;};
	_vehicle vehicleChat format ["%1 is ready", _type];
	hint format ["%1 is ready", _type];

if (true) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";mps_lock_action = false;};

};