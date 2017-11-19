_obj1 = _this select 0;
_obj2 = _this select 1;

_pos1 = if ((typename _obj1) == "Array") then {_obj1} else {getposATL _obj1};
_pos2 = if ((typename _obj2) == "Array") then {_obj2} else {getposATL _obj2};


_hyp = _pos1 distance _pos2;
if (_hyp == 0) then {_hyp = 0.1};
_adj = (_pos1 select 1) - (_pos2 select 1);



_angle = if ((_pos1 select 0) > (_pos2 select 0)) then {
	
	acos (_adj/_hyp);

} else {

	360 - (acos (_adj/_hyp));

};

_angle