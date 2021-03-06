// Written by EightySix

if(!(call Hz_fnc_isTaskMaster)) exitWith{};
private["_position","_locations","_location","_radius","_sidea","_sideb"];

	if(isNil "mps_used_locations") then {mps_used_locations = [];};

	_types = _this select 0;
	if(count _types == 0) then {_types = ["Name","NameLocal","NameVillage","NameCity","NameCityCapital","Hill"]};
	_locations = [];
	_nlocations = [];

	_sidea = SIDE_A select 0;
	_sideb = SIDE_B select 0;

	while{ count _locations == 0} do {
		while{ count _nlocations == 0 } do {
			_nlocations = nearestLocations [[0,0],_types,30000];
		};
		{
			if(	!(_x in mps_used_locations) &&
				position _x distance _position > 5000 &&
				position _x distance getMarkerPos "respawn_west" > 3000 &&
				position _x distance getMarkerPos "respawn_east" > 3000
			) then {
				_locations = _locations + [_x];
			};
		} foreach _nlocations;
	};

	_location = _locations select (random ( (count _locations) - 1) );

	mps_used_locations = mps_used_locations + [_location];

_location