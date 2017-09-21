// Written by Xeno
// Adapted by EightySix

if (!isServer) exitWith {};
WaitUntil{!isNil "mps_init"};

sleep random 3;

_vehicle = _this select 0;
_delay = if (count _this > 1) then {_this select 1} else {120};
_deserted = if (count _this > 2) then {_this select 2} else {1800};
_respawns = if (count _this > 3) then {_this select 3} else {0};
_explode = if (count _this > 4) then {_this select 4} else {false};
_dynamic = if (count _this > 5) then {_this select 5} else {false};
_vehicleinit = if (count _this > 6) then {_this select 6} else {};
_haveinit = if (count _this > 6) then {true} else {false};

_hasname = false;
_vehiclename = vehicleVarName _vehicle;
if (isNil _vehiclename) then {_hasname = false;} else {_hasname = true;};
_noend = true;
_run = true;
_rounds = 0;
_drivercheck = false;
_liftcheck = false;
_liftable = false;
_ranked = [];

if (_delay < 0) then {_delay = 0};
if (_deserted < 0) then {_deserted = 0};
if (_respawns <= 0) then {_respawns= 0; _noend = true;};
if (_respawns > 0) then {_noend = false};

if(!isNil {_vehicle getVariable "check_driver"}) then {_drivercheck = true;};
if(!isNil {_vehicle getVariable "enable_lift"}) then {_liftcheck = true;};
if(!isNil {_vehicle getVariable "liftable"}) then {_liftable = true;};
if(!isNil {_vehicle getVariable "check_rank"}) then {_ranked = _vehicle getVariable "check_rank";};

_vehicle call mps_replace_with_ace;

_dir = getDir _vehicle;
_position = getPosASL _vehicle;
_type = typeOf _vehicle;
_dead = false;
_nodelay = false;

if(_drivercheck) then {_vehicle setVariable ["check_driver",true,true];};
if(_liftcheck) then {_vehicle setVariable ["enable_lift",true,true];};
if(_liftable) then {_vehicle setVariable ["liftable",true,true];};
if(count _ranked > 1) then {_vehicle setVariable ["check_rank",_ranked,true];};


while {_run} do {	
	sleep (2 + (round random 6));

	_vehlock = false;
	if( if(isNil {_vehicle getVariable "mps_veh_locked"}) then {false}else{_vehicle getVariable "mps_veh_locked"} ) then {_vehlock = true;};
	if( !isNil {_vehicle getVariable "mps_veh_reset"} ) then { _dead = true; _nodelay = true; };

	if ((damage _vehicle >= 1) and ({alive _x} count crew _vehicle == 0)) then {_dead = true};

	if (_deserted > 0) then {
		if ((getPosASL _unit distance _position > 10) and ({alive _x} count crew _unit == 0) and (getDammage _unit < 1)) then {
			_timeout = time + _deserted;
			sleep 0.1;
		 	waitUntil {_timeout < time or !alive _vehicle or {alive _x} count crew _vehicle > 0};
			if ({alive _x} count crew _vehicle > 0) then {_dead = false};
			if ({alive _x} count crew _vehicle == 0) then {_dead = true; _nodelay =true};
			if (damage _vehicle >= 1) then {_dead = true; _nodelay = false};
		};
	};

	if (_dead) then {
		if (_nodelay) then {sleep 0.1; _nodelay = false;} else {sleep _delay;};
		if (_dynamic) then {_position = getPosASL _vehicle; _dir = getDir _vehicle;};
		if (_explode) then {_effect = "M_TOW_AT" createVehicle getPosASL _vehicle; _effect setPosASL getPosASL _vehicle;};
		sleep 0.1;
		deleteVehicle _vehicle;
		sleep 2;
		_vehicle = _type createVehicle _position;
		_vehicle setPosASL _position;
		_vehicle setDir _dir;
		if (_haveinit) then {
			_vehicle setVehicleInit format ["%1;", _vehicleinit];
			processInitCommands;
		};
		if (_hasname) then {
			_vehicle setVehicleInit format ["%1 = this; this setVehicleVarName ""%1""",_vehiclename];
			processInitCommands;
		};
		if(_drivercheck) then {_vehicle setVariable ["check_driver",true,true];};
		if(_liftcheck) then {_vehicle setVariable ["enable_lift",true,true];};
		if(_liftable) then {_vehicle setVariable ["liftable",true,true];};
		if(count _ranked > 1) then {_vehicle setVariable ["check_rank",_ranked,true];};
		if(_vehlock) then { _vehicle setVariable ["mps_veh_locked",true,true]; };
		_dead = false;
		if !(_noend) then {_rounds = _rounds + 1};
		if ((_rounds == _respawns) and !(_noend)) then {_run = false;};
	};
};