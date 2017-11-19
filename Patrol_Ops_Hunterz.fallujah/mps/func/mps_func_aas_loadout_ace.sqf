/* Written by Eightysix

	Inspired by the following:
	 - ACE E.A.S.A
	 - Mandos Missiles
	 - =BTC= Armament System
	 - F2F A.L.S.S.
*/
private["_w_mg","_w_p1","_w_p2","_w_p3","_w_p4","_w_fl","_m_mg","_m_p1","_m_p2","_m_p3","_m_p4","_m_fl","_type","_vehicle","_position","_damage","_setfuel","_vwid","_rearm_1","_rearm_2","_rearm_2_ace"];

for "_i" from 0 to ( (count mps_aas_weapon_config) - 1) do {
	_vwid = (mps_aas_weapon_config select _i);

	if( (_vwid select 0) == ( lbValue [ 86810 , lbCurSel 86810 ] ) ) then { _w_mg = (_vwid select 1); _m_mg = (_vwid select 2); };
	if( (_vwid select 0) == ( lbValue [ 86811 , lbCurSel 86811 ] ) ) then { _w_p1 = (_vwid select 1); _m_p1 = (_vwid select 2); };
	if( (_vwid select 0) == ( lbValue [ 86812 , lbCurSel 86812 ] ) ) then { _w_p2 = (_vwid select 1); _m_p2 = (_vwid select 2); };
	if( (_vwid select 0) == ( lbValue [ 86813 , lbCurSel 86813 ] ) ) then { _w_p3 = (_vwid select 1); _m_p3 = (_vwid select 2); };
	if( (_vwid select 0) == ( lbValue [ 86814 , lbCurSel 86814 ] ) ) then { _w_p4 = (_vwid select 1); _m_p4 = (_vwid select 2); };
	if( (_vwid select 0) == ( lbValue [ 86815 , lbCurSel 86815 ] ) ) then { _w_fl = (_vwid select 1); _m_fl = (_vwid select 2); };
};

	_setfuel = sliderPosition 86816;

	_sleeptimer = 5;

	closeDialog 0;

	_vehicle = vehicle player;
	_type = getText (configFile >> "CfgVehicles" >> typeof _vehicle >> "displayName");
	_position = position _vehicle;
	_damage = damage _vehicle;

if (!alive _vehicle || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";};

	_vehicle setFuel 0;
	if( damage _vehicle != 0 ) then {
		_vehicle vehicleChat format["Repairing %1...", _type]; hint format["Repairing %1...", _type];
		sleep (_damage*20);
		_vehicle setDamage _repair;
	};

if (!alive _vehicle || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";};

	_title = "Repair and Resupply";
	_step = "Vehicle Resupply";
	_content = "The vehicle is now rearming. For SAFETY, please stay away until it is complete!";
	[_title,_content,_step,10] spawn mps_adv_hint;
	_vehicle vehicleChat _content;

	_vehicle_pos = position _vehicle;
	_vehicle_dir = direction _vehicle;
	_vehicle_typ = typeOf _vehicle;

	{_x action ["getOut",_vehicle]} foreach (crew _vehicle);

	deleteVehicle _vehicle;

	_vehicle = _vehicle_typ createVehicle _vehicle_pos;
	_vehicle setPos _vehicle_pos;
	_vehicle setDir _vehicle_dir;
	_vehicle setFuel 0;
	_vehicle lock true;
		
	_vehicle_w =	weapons _vehicle;
	_vehicle_m =	magazines _vehicle;
	_vehicle_mtd =	_vehicle magazinesTurret [-1];
	_vehicle_mt0 =	_vehicle magazinesTurret [0];
	_vehicle_mt1 =	_vehicle magazinesTurret [1];
	_vehicle_mt2 =	_vehicle magazinesTurret [2];

	{ _vehicle removeWeapon _x; } forEach _vehicle_w;
	{ _vehicle removeMagazine _x} forEach _vehicle_m;
	{ _vehicle removeMagazinesTurret [_x,[-1]]} forEach _vehicle_mtd;
	{ _vehicle removeMagazinesTurret [_x,[0]] } forEach _vehicle_mt0;
	{ _vehicle removeMagazinesTurret [_x,[1]] } forEach _vehicle_mt1;
	{ _vehicle removeMagazinesTurret [_x,[2]] } forEach _vehicle_mt2;

	{ if ( !(_vehicle hasWeapon _x) && _x != "") then { _vehicle addweapon _x; } } foreach [_w_fl,_w_mg,_w_p1,_w_p2,_w_p3,_w_p4];

	_rearm_1 = {
		{ if (_x != "") then { sleep _sleeptimer; _vehicle addMagazine _x; }; } foreach [_m_mg,_m_p1,_m_p2,_m_p3,_m_p4,_m_fl];
	};

	_rearm_2 = {
		{ if (_x != "") then { sleep _sleeptimer; _vehicle addMagazine (_x); }; } foreach [_m_fl,_m_mg];
		{ if (_x != "") then { sleep _sleeptimer; _vehicle addMagazineTurret [ _x, [0] ]; }; } foreach [_m_p1,_m_p2,_m_p3,_m_p4];
		_vehicle addMagazineTurret ["120Rnd_CMFlareMagazine",[-1]];
	};

	_rearm_2_ace = { // weapon pod 4 for helicopters is typically Hydra pods. Controlled by the pilot in ACE.
		{ if (_x != "") then { sleep _sleeptimer; _vehicle addMagazine (_x); }; } foreach [_m_fl,_m_mg];
		{ if (_x != "") then { sleep _sleeptimer; _vehicle addMagazineTurret [ _x, [0] ]; }; } foreach [_m_p1,_m_p2,_m_p3];
		{ if (_x != "") then { sleep _sleeptimer; _vehicle addMagazineTurret [ _x, [-1]]; }; } foreach [_m_p4];
		_vehicle addMagazineTurret ["120Rnd_CMFlareMagazine",[-1]];
	};

	switch mps_aas_loadout_positions do {
		case 1: { call _rearm_1; };
		case 2: { if( mps_ace_enabled ) then { call _rearm_2_ace; } else { call _rearm_2; }; };
		default { call _rearm_1; };
	};

if (!alive _vehicle || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";};

	_vehicle vehicleChat format ["Refueling %1...", _type]; hintsilent format ["Refueling %1...", _type];

	while {fuel _vehicle < _setfuel && alive _vehicle && alive player} do {
		_vehicle setFuel ( (fuel _vehicle) + 0.1);
		sleep 0.3;
	};

	_vehicle lock false;

if (!alive _vehicle || !alive player) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";};

	_vehicle vehicleChat format ["%1 is ready", _type]; hint format ["%1 is ready", _type];

	_title = "Repair and Resupply";
	_step = "Vehicle Resupply";
	_content = "The vehicle is rearmed. You are now able to enter the combat zone.";
	[_title,_content,_step,10] spawn playeradvhint;

if (true) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon";};