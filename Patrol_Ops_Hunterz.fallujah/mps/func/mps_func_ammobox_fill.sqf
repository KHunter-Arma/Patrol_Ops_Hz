// Written by BON_IF
// Adapted by EightySix

private["_cache","_rank","_timer"];

	_cache = _this select 0;

	player reveal _cache;

	_weaponcapacity    = 0 max ( (getNumber (configFile >> "CfgVehicles" >> typeOf _cache >> "transportMaxWeapons")) min 360);

	_magazinecapacity  = 0 max ( (getNumber (configFile >> "CfgVehicles" >> typeOf _cache >> "transportMaxMagazines")) min 1400);

	while {alive _cache} do {

		[] call mps_weapons_list;

		if(isNil "mps_armoury_mags" || isNil "mps_armoury_weapons") exitWith{};

		_rank = rank player;
		_timer = 30;

		{ mps_armoury_mags = (mps_armoury_mags - [_x]) + [_x]; } foreach mps_armoury_mags;
		{ mps_armoury_weapons = (mps_armoury_weapons - [_x]) + [_x]; } foreach mps_armoury_weapons;

		{deleteVehicle _x} foreach nearestObjects [position _cache,["WeaponHolder"],50];

		clearMagazineCargo _cache;
		clearWeaponCargo _cache;

		{ _cache addWeaponCargo [_x, floor(_weaponcapacity / (count mps_armoury_weapons))]; } foreach mps_armoury_weapons;
		{ _cache addMagazineCargo [_x, floor(_magazinecapacity / (count mps_armoury_mags))]; } foreach mps_armoury_mags;

		while {rank player == _rank && _timer > 0 } do { sleep 10; _timer = _timer - 1; };

	};