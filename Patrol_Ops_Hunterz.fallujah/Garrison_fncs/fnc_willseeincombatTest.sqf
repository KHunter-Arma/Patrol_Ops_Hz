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

	_infront set [2,((_infront select 2) - _zdif)];
	
	_intersectPos = [_unit,_infront] call fnc_Intersect_Pos;
	
	if (isnil ("cone")) then
	{
		cone = "RoadCone_F" createVehicle [0,0,0];
	};
	
	cone setPos _intersectPos;
	
	hint (str(_intersectPos));
