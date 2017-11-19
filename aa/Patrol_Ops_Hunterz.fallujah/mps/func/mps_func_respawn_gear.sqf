// Written by BON_IF
// Adpated by EightySix

private ['_magazines','_weapons','_backpack','_backpackweap','_backpackmags','_ace_ruck','_ruckweapons','_ruckmags','_weapononback'];

	_unit = _this;

	_weapons = weapons _unit;
	_magazines = magazines _unit;

	if(mps_co) then {
		_backpack = typeOf unitBackpack _unit;
		_backpackmags = getMagazineCargo unitBackpack _unit;
		_backpackweap = getWeaponCargo unitBackpack _unit;
	};

	if(mps_ace_enabled) then {
		_ace_ruck = [_unit] call ACE_fnc_FindRuck;

		if(_ace_ruck != "") then{
			_ruckweapons = [_unit] call ACE_fnc_RuckWeaponsList;
			_ruckmags = [_unit] call ACE_fnc_RuckMagazinesList;
		} else {
			_ruckweapons = [];
			_ruckmags = [];
		};

		_weapononback = _unit getVariable "ACE_weapononback";
		if(isNil "_weapononback") then {_Weapononback = ""};
	};

	WaitUntil{alive player};

	removeAllWeapons player;
	removeAllItems player;
	if(mps_co) then {
		removeBackpack player;
	};
	{player addMagazine _x} foreach _magazines;
	{player addWeapon _x} foreach _weapons;
	if (primaryWeapon player != "") then {
		player selectWeapon (primaryWeapon player);
		_muzzles = getArray(configFile>>"cfgWeapons" >> primaryWeapon player >> "muzzles"); // Fix for weapons with grenade launcher
		player selectWeapon (_muzzles select 0);
	};

	if(mps_co) then {
		if(_backpack != "") then {
			player addBackpack _backpack; clearWeaponCargo (unitBackpack player); clearMagazineCargo (unitBackpack player);
	
			for "_i" from 0 to (count (_backpackmags select 0) - 1) do {
				(unitBackpack player) addMagazineCargo [(_backpackmags select 0) select _i,(_backpackmags select 1) select _i];
			};
			for "_i" from 0 to (count (_backpackweap select 0) - 1) do {
				(unitBackpack player) addWeaponCargo [(_backpackweap select 0) select _i,(_backpackweap select 1) select _i];
			};
		};
	};

	if(mps_ace_enabled) then {
		if(_weapononback != "") then{player setVariable ["ACE_weapononback",_weapononback]};
		if(_ace_ruck != "") then {
			 {[player,_x select 0,_x select 1] call ACE_fnc_PackWeapon} foreach _ruckweapons;
			 {[player,_x select 0,_x select 1] call ACE_fnc_PackMagazine} foreach _ruckmags;
		};
	};