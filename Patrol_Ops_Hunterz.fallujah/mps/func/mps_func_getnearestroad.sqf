// Written by BON_IF

private["_location","_radius","_nearRoads","_j"];

_location  = (_this select 0) call mps_get_position;

_radius = 100;
_nearRoads = [];

While { count _nearRoads == 0 } do {
	_nearRoads = _location nearRoads _radius;
	_radius = _radius + 100;
};

_j = (count _nearRoads - 1) min (round random (count _nearRoads));
_road = _nearRoads select _j;

_road