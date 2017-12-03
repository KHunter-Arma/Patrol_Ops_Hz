_unit = _this select 0;
_angle = _this select 1;
	
	_upos = getposATL _unit;

	_hyp = (random 2) + 1;
	_adj = _hyp * (cos _angle);
	_opp = sqrt ((_hyp*_hyp) - (_adj * _adj));


	_infront = if ((_angle) >=  180) then {

		[(_upos select 0) - _opp,(_upos select 1) + _adj,(_upos select 2) + 0.5]

	} else {

		[(_upos select 0) + _opp,(_upos select 1) + _adj,(_upos select 2) + 0.5]

	};

	_obstruction = (lineintersectswith [_upos,_infront,_unit]) select 0;


	_willwalk = if (isnil("_obstruction")) then {true} else {false};


[_willwalk,_infront]

