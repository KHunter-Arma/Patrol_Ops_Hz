_vestType = vest _this;
_uniformType = uniform _this;
_backpackType = backpack _this;
_headgear = headgear _this;
_goggles = goggles _this;
_assignedItems = assignedItems _this;

_backpackMags = [];

if(!isnull (backpackContainer _this)) then {
	_backpackMags = magazinesAmmoCargo backpackContainer _this;
};

_vestMags = [];

if(!isnull (vestContainer _this)) then {
	_vestMags = magazinesAmmoCargo vestContainer _this;
};

_uniformMags = [];

if(!isnull (uniformContainer _this)) then {
	_uniformMags = magazinesAmmoCargo uniformContainer _this;
};

_temp = [];
{

	if (!("CA_Magazine" in ([(configfile >> "cfgmagazines" >> _x), true] call bis_fnc_returnParents))) then {

		_temp pushback _x;

	};

} foreach uniformItems _this;

_uniformItems = _temp call Hz_pers_fnc_convert1DArrayTo2D;

_temp = [];
{

	if (!("CA_Magazine" in ([(configfile >> "cfgmagazines" >> _x), true] call bis_fnc_returnParents))) then {

		_temp pushback _x;

	};

} foreach vestItems _this;

_vestItems = _temp call Hz_pers_fnc_convert1DArrayTo2D;

_temp = [];
{

	if (!("CA_Magazine" in ([(configfile >> "cfgmagazines" >> _x), true] call bis_fnc_returnParents))) then {

		_temp pushback _x;

	};

} foreach backpackItems _this;

_backpackItems = _temp call Hz_pers_fnc_convert1DArrayTo2D;

_weaponsItems = weaponsitems _this;

removeallweapons _this;
removeallitems _this;
removeAllAssignedItems _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;	
removeGoggles _this;

//find nearest ammo crate
_crate = objNull;
_dist = 300000;
{

	_newDist = _this distance _x;

	if (_newDist < _dist) then {
	
		_crate = _x;
		_dist = _newDist;
	
	};

} foreach Hz_pers_network_crates;

if (isnull _crate) then {

	_crate = "WeaponHolder" createVehicle (markerpos "respawn_west");

};

_crate additemcargoglobal [_vestType,1];
_crate additemcargoglobal [_uniformType,1];
_crate addBackpackCargoGlobal [_backpackType,1];
_crate additemcargoglobal [_headGear,1];
_crate additemcargoglobal [_goggles,1];

{
		
	if !((_x select 0) in _assignedItems) then {

		_crate addWeaponCargoGlobal [_x select 0, 1];	
		
		//add magazine
		_magArray = _x select 4;
		if ((count _magArray) > 0) then {
			_crate addMagazineAmmoCargo [(_magArray select 0), 1, (_magArray select 1)];
		};
		
		//attachments
		_wep = _x select 0;
		_wepComponents = _wep call BIS_fnc_weaponComponents;
		
		{
		
			if (!((tolower _x) in _wepComponents)) then {
			
				_crate additemcargoglobal [_x,1];
			
			};
		
		} foreach [_x select 1, _x select 2, _x select 3];
		
		//Grenade launcher?
		if ((typename (_x select 5)) == "ARRAY") then {
			
			_magArray = _x select 5;
			if ((count _magArray) > 0) then {
				_crate addMagazineAmmoCargo [(_magArray select 0), 1, (_magArray select 1)];
			};
			
			if (!((tolower (_x select 6)) in _wepComponents)) then {
			
				_crate additemcargoglobal [(_x select 6),1];
			
			};	

		} else {
		
			if (!((tolower (_x select 5)) in _wepComponents)) then {
			
				_crate additemcargoglobal [(_x select 5), 1];
			
			};	
		
		};
		
	};

} foreach _weaponsItems;

{
	_crate addMagazineAmmoCargo [_x select 0, 1, _x select 1];
}foreach _vestMags;

{
	_crate addItemCargoGlobal [_x,(_vestItems select 1) select _foreachIndex];
} foreach (_vestItems select 0);

{
	_crate addMagazineAmmoCargo [_x select 0, 1, _x select 1];
}foreach _backpackMags;

{
	_crate addItemCargoGlobal [_x,(_backpackItems select 1) select _foreachIndex];
} foreach (_backpackItems select 0);

{
	_crate addMagazineAmmoCargo [_x select 0, 1, _x select 1];
}foreach _uniformMags;

{
	_crate addItemCargoGlobal [_x,(_uniformItems select 1) select _foreachIndex];
} foreach (_uniformItems select 0);

{
	_crate addItemCargoGlobal [_x,1];
}foreach _assignedItems;