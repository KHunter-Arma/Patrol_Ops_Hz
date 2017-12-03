_unit = _this select 0;
_dir = getdir _unit;
_group = group _unit;
_staying = _group getvariable ["defending",true];


_pos = getposATL _unit;

_build = (nearestobjects [getposATL _unit,["house"],20] select 0);

_bpos = _unit getvariable ["homepos",0];

_dest = [];

while {alive _unit} do 
{
	
	sleep ((random 15) + 5);

	_action = 2;
	_waittime = 0.1;
	_rand = random 10;
	if (_rand <= 1) then {_action = 1;_waittime = 5};
	if ((_rand > 1) && (_rand <= 6)) then {_action = 0;_waittime = 2};

	if (_staying) then {
	
		if (_action == 0) then {
	
			if (_unit getvariable ["indoors",false]) then {

				_indoors = [_unit] call fnc_indoors;
				if (!(_indoors)) then {_action = 1;_waittime = 5};

			};
	
		};

	};
	
	switch (_action) do 
	{
		case 0 : {
				
				_willwalk = false;
		
				while {!(_willwalk)} do {
				
					_rdir = random 360;

					_angle = (([_unit,_pos] call fnc_get_angle) + 180);

					_homedir = if (_angle > 360) then {_angle - 360} else {_angle};

					_ofdir = if ((_rdir - _homedir) < 0) then {(_rdir - _homedir) + 360} else {_rdir - _homedir};
					_dir = if (_ofdir > 180) then {_rdir + ((360 - _ofdir) / 2)} else {_homedir + (_ofdir / 2)};

					_walkfncarray = [_unit,_dir] call fnc_willwalk;
					_willwalk = _walkfncarray select 0;
					_dest = _walkfncarray select 1;


				};

			};

		case 1 : {
					
				_dest = _build buildingpos _bpos;
		
			}; 

		default {

				_dest = (getposATL _unit);		

			};
		

	};
	
	dostop _unit;
		
	if ((combatmode (group _unit)) == "RED") then {(group _unit) setcombatmode "YELLOW"};

	_unit forcespeed 2;

	sleep 0.1;

	_unit MoveTo _dest;

	waituntil {sleep _waittime;true};

	_unit forcespeed (_unit getvariable ["forcedspeed",-1]);

	


	waituntil {!(_unit getvariable ["alerted",false])};

	_willsee = false;
	_infront = [];
	
	while {!(_willsee)} do {

		_dir = random 360;
		_fncarray = [_unit,_dir] call fnc_willsee;
		_willsee = _fncarray select 0;
		_infront = _fncarray select 1;
		_upos = getposATL _unit;
		_infront set [2,(_upos select 2) + 0.5];

	};
	
	_unit lookat _infront;

};
