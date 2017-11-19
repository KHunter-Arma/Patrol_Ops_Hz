/* Written by Eightysix

	Inspired by the following:
	 - ACE E.A.S.A
	 - Mandos Missiles
	 - =BTC= Armament System
	 - F2F A.L.S.S.
*/

if (mps_lock_action) then {

	player globalChat "The current operation isn't finished.";

	closeDialog 0;

}else{
	mps_lock_action = true;

	mps_aas_loadout = nil;

	{ if( typeof (vehicle player) == (_x select 0) ) then { mps_aas_loadout = _x; }; }forEach mps_aas_vehicle_loadout;

	if( isNil "mps_aas_loadout" ) exitWith { mps_lock_action = false; hint "No Armaments Found"; closeDialog 0; };

	mps_aas_loadout_vehicle = mps_aas_loadout select 0;
	mps_aas_loadout_positions = mps_aas_loadout select 1;

	for "_i" from 0 to ( (count mps_aas_weapon_config) - 1) do {
		_vwid = (mps_aas_weapon_config select _i);

		{ if( (_vwid select 0) == _x ) then { _loadopt = lbAdd [86810,(_vwid select 3)]; lbSetValue [86810,_loadopt,_x]; }; }forEach (mps_aas_loadout select 2);
		{ if( (_vwid select 0) == _x ) then { _loadopt = lbAdd [86811,(_vwid select 3)]; lbSetValue [86811,_loadopt,_x]; }; }forEach (mps_aas_loadout select 3);
		{ if( (_vwid select 0) == _x ) then { _loadopt = lbAdd [86812,(_vwid select 3)]; lbSetValue [86812,_loadopt,_x]; }; }forEach (mps_aas_loadout select 4);
		{ if( (_vwid select 0) == _x ) then { _loadopt = lbAdd [86813,(_vwid select 3)]; lbSetValue [86813,_loadopt,_x]; }; }forEach (mps_aas_loadout select 5);
		{ if( (_vwid select 0) == _x ) then { _loadopt = lbAdd [86814,(_vwid select 3)]; lbSetValue [86814,_loadopt,_x]; }; }forEach (mps_aas_loadout select 6);
		{ if( (_vwid select 0) == _x ) then { _loadopt = lbAdd [86815,(_vwid select 3)]; lbSetValue [86815,_loadopt,_x]; }; }forEach (mps_aas_loadout select 7);
	};
	
	if( count ( mps_aas_loadout select 2 ) > 0 ) then { lbSetCurSel [86810,0]; ctrlShow [86810, true]; }else{ ctrlShow [86810, false]; };
	if( count ( mps_aas_loadout select 3 ) > 0 ) then { lbSetCurSel [86811,0]; ctrlShow [86811, true]; }else{ ctrlShow [86811, false]; };
	if( count ( mps_aas_loadout select 4 ) > 0 ) then { lbSetCurSel [86812,0]; ctrlShow [86812, true]; }else{ ctrlShow [86812, false]; };
	if( count ( mps_aas_loadout select 5 ) > 0 ) then { lbSetCurSel [86813,0]; ctrlShow [86813, true]; }else{ ctrlShow [86813, false]; };
	if( count ( mps_aas_loadout select 6 ) > 0 ) then { lbSetCurSel [86814,0]; ctrlShow [86814, true]; }else{ ctrlShow [86814, false]; };
	if( count ( mps_aas_loadout select 7 ) > 0 ) then { lbSetCurSel [86815,0]; ctrlShow [86815, true]; }else{ ctrlShow [86815, false]; };

	sliderSetRange [ 86816, 0, 1 ];
	sliderSetPosition [ 86816, fuel (vehicle player) ];

	mps_lock_action = false;
};