// Written By EightySix
// Declare Weapon Class list available in the ammobox.
// For the purpose of Patrol, 2 external files dictate the ace ammobox and vanilla ammobox.

waitUntil{!isNil "mps_ace_enabled" && !isNil "mps_acre_enabled"};

_list = [];
_w = [];
_m = [];

_currank = toUpper (rank player);
_rank1 = ["PRIVATE"];
_rank2 = ["PRIVATE","CORPORAL"];
_rank3 = ["PRIVATE","CORPORAL","SERGEANT"];
_rank4 = ["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT"];
_rank5 = ["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN"];
_rank6 = ["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR"];
_rank7 = ["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"];

_rfilter = [];
{ if( _currank IN _x ) then { _rfilter = _x; }; }forEach [_rank7,_rank6,_rank5,_rank4,_rank3,_rank2,_rank1];

[] call compile preprocessFileLineNumbers (mps_path+"config\config_armoury\config_radios_acre.sqf");

if( mps_a2 ) then {
	[] call compile preprocessFileLineNumbers (mps_path+"config\config_armoury\config_weapons_usmc.sqf");
};

if( mps_oa ) then {
	[] call compile preprocessFileLineNumbers (mps_path+"config\config_armoury\config_weapons_usa.sqf");
};

if( mps_baf ) then {
	[] call compile preprocessFileLineNumbers (mps_path+"config\config_armoury\config_weapons_baf.sqf");
};

if( mps_pmc ) then {
//	[] call compile preprocessFileLineNumbers (mps_path+"config\config_armoury\config_weapons_pmc.sqf");
};

if( mps_aaw ) then {
	[] call compile preprocessFileLineNumbers (mps_path+"config\config_armoury\config_weapons_aaw.sqf");
};

if(mps_ace_wounds) then { _m = _m + ["ACE_Bandage","ACE_Medkit","ACE_Morphine","ACE_Bodybag","ACE_Epinephrine","ACE_LargeBandage","ACE_Tourniquet","ACE_Splint","ACE_IV","ACE_Plasma" ]; };

{
	if( (_x select 0) IN _rfilter || !mps_rank_gear_enabled || mps_debug ) then {
		if( ( _x select 1 ) == toUpper (mps_player_class) || ( _x select 1 ) == "ALL" || mps_debug ) then {
			_w = _w + (_x select 2);
		};
	};
}forEach _list;

mps_armoury_weapons = _w;
mps_armoury_mags = _m;