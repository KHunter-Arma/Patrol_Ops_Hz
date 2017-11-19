// Written by EightySix
// Replaces a units gear and weapons with defaults on Join

waitUntil {!isNil "mps_ace_enabled" && !isNil "mps_acre_enabled"};

private["_weapons","_magazine"];

_wep = weapons player;
_mag = magazines player;

removeAllWeapons player;
removeAllItems player;
if(mps_co) then {
	removeBackpack player;
};

_weapons = [];
_magazine = [];

if( mps_aaw ) then 
{
	_weapons = _weapons + ["AAW_f88_A1"];
}else{
	if( mps_oa ) then 
	{
		_weapons = _weapons + ["SCAR_L_CQC"];
	}else{
		_weapons = _weapons + ["M16A2"];
	};
};



if( mps_ace_enabled ) then{
	if( mps_aaw ) then 
	{
		_weapons = ["AAW_f88_A1","Binocular","NVGoggles","ACE_Map","ItemRadio","ItemCompass","ItemGPS","ItemWatch","ACE_Earplugs"];
		_magazine = ["aaw_f88_mag","aaw_f88_mag","aaw_f88_mag","aaw_f88_mag","aaw_f1_grenade","SmokeShellBlue"];
	}else{
		_weapons = ["ACE_M4","Binocular","NVGoggles","ACE_Map","ItemRadio","ItemCompass","ItemGPS","ItemWatch","ACE_Earplugs"];
		_magazine = ["ACE_30Rnd_556x45_S_Stanag","ACE_30Rnd_556x45_S_Stanag","ACE_30Rnd_556x45_S_Stanag","ACE_30Rnd_556x45_S_Stanag","HandGrenade_West","SmokeShellBlue"];
	};
}else{
	_weapons = _weapons + ["Binocular","NVGoggles","ItemMap","ItemCompass","ItemGPS","ItemWatch","ItemRadio"];
	if( mps_aaw ) then 
	{
		_magazine = ["aaw_f88_mag","aaw_f88_mag","aaw_f88_mag","aaw_f88_mag","aaw_f1_grenade","SmokeShellBlue"];
	}else{
		_magazine = ["30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","HandGrenade_West","HandGrenade_West","SmokeShellBlue"];
	};
};

{ player addWeapon _x; } forEach _weapons;
{ player addMagazine _x; } forEach _magazine;

if ( typeOf player == "USMC_Soldier_Medic" || 
	typeOf player == "FR_Corpsman" || 
	typeOf player == "US_Soldier_Medic_EP1" ||
	typeOf player == "US_Delta_Force_Medic_EP1") then
{
hint "filling backpack";
	player addweapon "ACE_Rucksack_MOLLE_Brown_Medic";
	[player, "ACE_epinephrine", 15] call ACE_fnc_PackMagazine;
	[player, "ACE_Morphine", 15] call ACE_fnc_PackMagazine;
	[player, "ACE_LargeBandage", 10] call ACE_fnc_PackMagazine;	
	[player, "ACE_Bandage", 10] call ACE_fnc_PackMagazine;
	[player, "ACE_Medkit", 5] call ACE_fnc_PackMagazine;
	[player, "ACE_Tourniquet", 2] call ACE_fnc_PackMagazine; 
};