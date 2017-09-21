// Written by EightySix

private["_distance"];

	_distance = _this select 0;

	if(_distance <= 25) exitWith{0};
	if(_distance >= 250) exitWith{1};

	_alpha = log(_distance/25);

_alpha;