// Written by Eightysix

private["_types","_locations","_limit"];

if( isNil "mps_prev_location" || count _this > 1 ) then { mps_prev_location = getMarkerPos format["respawn_%1",(SIDE_A select 0)]; };

mps_prev_position = ( mps_prev_location call mps_get_position );
mps_next_location = [];
_locations = [];

_dist = 10000;
if( count _this > 1 ) then { _dist = _this select 1; };

_types = [];

{
	switch (_x) do {
		case "villages": { _types = _types + ["Name","NameLocal"]; };
		case "towns": { _types = _types + ["Name","NameLocal","NameVillage","NameCity","NameCityCapital"]; };
		case "hills": { _types = _types + ["Hill","ViewPoint"]; };
		case "airports": { _types = _types + ["Airport"]; };
                case "forest" : { _types = _types + ["VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]; };
		default { _types = _types + ["Name","NameLocal","NameVillage","NameCity","NameCityCapital"]; }
	};

} foreach (_this select 0);

_limit = 10;
while{ count _locations == 0 && _limit > 0 } do {
	_locations = nearestLocations [ mps_prev_position , _types , _dist ];
	_dist = _dist + 5000;
	_limit = _limit - 1;
};

if( _limit == 0 ) then {
	_locations = nearestLocations [ getMarkerPos format["respawn_%1",(SIDE_A select 0)] , ["Name","NameLocal","NameVillage","NameCity","NameCityCapital"] , 20000 ];	
};

{

	if(	position _x distance getMarkerPos format["respawn_%1",(SIDE_A select 0)] > 2200 &&
		position _x distance getMarkerPos "exclude1" > 1000 &&
		position _x distance getMarkerPos "exclude2" > 1000 &&
		position _x distance getMarkerPos "exclude3" > 1000 &&
		position _x distance getMarkerPos "exclude4" > 1000 &&
		position _x distance getMarkerPos "exclude5" > 1000 &&
		position _x distance mps_prev_position > 500
	) then {
		mps_next_location = mps_next_location + [_x];
	};
} foreach _locations;

mps_next_location = mps_next_location call mps_getRandomElement;
mps_prev_location = mps_next_location;


mps_next_location
