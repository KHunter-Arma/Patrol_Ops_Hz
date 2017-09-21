_unit  = _this select 0;
_focus = _this select 1;
_dist = _unit distance _focus;
_array = [];

_upos = getposATL _unit;
_eyes = eyepos _unit;
_angle = [_focus,_unit] call fnc_get_angle;
_zdif = ((_eyes select 2) - (_upos select 2));

if (isnil("fnc_intersects")) then 
{

fnc_intersects = compile "
	_unit = _this select 0;
	_pos = _this select 1;
	_checkdist = _this select 2;

	_hyp = _checkdist;
	_adj = _hyp * (cos _angle);
	_opp = sqrt ((_hyp*_hyp) - (_adj * _adj));

	_infront = if ((_angle) >=  180) then {

		[(_pos select 0) - _opp,(_pos select 1) + _adj,(_pos select 2)]

	} else {

		[(_pos select 0) + _opp,(_pos select 1) + _adj,(_pos select 2)]

	};

	_object = (lineintersectswith [_pos,_infront,_unit]) select 0;

	_obstructed = if (isnil('_object')) then {false} else {true};

	[_obstructed,_infront,_object]";

};

_array = [_unit,_eyes,_dist] call fnc_intersects;
_obstructed = _array select 0;
_obstruction = _array select 2;

if (!(_obstructed)) exitwith {(_array select 1)};

while {_obstructed} do {

	_dist = _dist - 1;
	_array = [_unit,_eyes,_dist] call fnc_intersects;
	_obstructed = _array select 0;
	
};

while {!(_obstructed)} do {

	_dist = _dist + 0.1;
	_array = [_unit,_eyes,_dist] call fnc_intersects;
	_obstructed = _array select 0;
	
};

while {_obstructed} do {

	_dist = _dist - 0.01;
	_array = [_unit,_eyes,_dist] call fnc_intersects;
	_obstructed = _array select 0;
	
};

_infront = _array select 1;
_infront set [2,(_infront select 2) - _zdif];

_infront






