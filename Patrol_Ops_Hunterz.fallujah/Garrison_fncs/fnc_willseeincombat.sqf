_unit = _this select 0;
_angle = _this select 1;

	_upos = getposATL _unit;
	_eyes = eyepos _unit;
	_zdif = ((_eyes select 2) - (_upos select 2));

	_hyp = 5;
	_adj = _hyp * (cos _angle);
	_opp = sqrt ((_hyp*_hyp) - (_adj * _adj));


	_infront = if ((_angle) >=  180) then 
	{

		[(_eyes select 0) - _opp,(_eyes select 1) + _adj,(_eyes select 2)]

	} 
	else 
	{

		[(_eyes select 0) + _opp,(_eyes select 1) + _adj,(_eyes select 2)]

	};

	

	
	
	_obstruction = (lineintersectswith [_eyes,_infront,_unit]) select 0;
	
	_willsee = if (isnil("_obstruction")) then {true} else {false};
	
	_infront set [2,((_infront select 2) - _zdif)];
	
	if (!(_willsee)) then
	{
	
		_uACfg = (configFile >> "cfgVehicles" >> (typeOf _obstruction) >> "UserActions");
		if ((count _uACfg) <= 0) exitwith {};
		
		_doorPositions = [];
		
		for "_i" from 0 to ((count _uACfg) - 1) step 3 do
		{
			if (_i >= (count _uACfg)) exitwith {};
			_sel = _uACfg select _i;
			_position = getText (_sel >> "position");
			_doorPositions set [(count _doorPositions),(_obstruction selectionPosition _position)];
		};
		
		_intersectPos = (_obstruction worldToModel ([_unit,_infront] call fnc_Intersect_Pos));
		
		_dist = 100;
		_closest = 100;
		
		{
			if ((abs((_intersectPos select 2) - (_x select 2))) <= 2) then
			{
				_intersectPos set [2,_x select 2];
			};
			_dist = _x distance _intersectPos;
			if (_dist < _closest) then
			{
				_closest = _dist;
			};
		
			if (_dist <= 0.5) exitwith
			{
				_willsee = true;
			};
			
		} forEach _doorPositions;

	};
	
[_willsee,_infront]
	
	



