_unit = _this select 0;
_firer = _this select 1;
		
_willseearray = [_unit,_firer] call fnc_willseetarget;

_unit setvariable ["alerted",true];
	
if (_willseearray select 0) then {
		
	dostop _unit;
	_unit lookat _firer;
	_unit dofire _firer;

	nul = [_unit] spawn {_unit = _this select 0; sleep 10; _unit setvariable ["alerted",false];};

} else {

	_dist = _unit distance _firer;
	_ctgtdist = _unit getvariable ["tgtdist",51];

	if (_dist < _ctgtdist) then {
		
		_unit setvariable ["tgtdist",_dist];

		_angle = ([_firer,_unit] call fnc_get_angle);
		_willsee = false;
		_target = 0;
		_acnt = 0;
		_mod = 0;

		while {!(_willsee)} do {

			_angle = if (_acnt == 0) then {_angle + _mod} else {_angle - _mod};
			if (_angle <= 0) then {_angle = _angle + 360};
			if (_angle >= 360) then {_angle = _angle - 360};

			_willseearray = [_unit,_angle] call fnc_willseeincombat;
			_willsee = _willseearray select 0;
			_target = _willseearray select 1;
			_acnt = if (_acnt == 0) then {_acnt + 1} else {_acnt - 1}; 
			_mod = _mod + 1;
		};

		dostop _unit;
		_unit lookat _target;
 
		nul = [_unit] spawn {_unit = _this select 0; sleep ((random 5) + 5); _unit setvariable ["tgtdist",51];};
	};	
	
};

