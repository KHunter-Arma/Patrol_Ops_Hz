// Written by Dash
  
if (!isServer) exitWith {};

// Define variables
_veh = _this select 0;
_used = if (count _this > 1) then {_this select 1} else {60};

// Redundant variable initialised flag to ensure all variables have been initialised
_ready = true;

if (_delay < 0) then {_delay = 0};
if (_used < 0) then {_used = 0};

// gets the starting Direction, loc and unit type
_dir = getDir _veh;
_position = getPosASL _veh;
_type = typeOf _veh;


while {_ready} do 
{	
	sleep random 5;

	// Check if transport has been used
	if (_used > 0) then
	{
		// Check that the vehicle has moved
		if ((getPosASL _veh distance _position > 10) and ({alive _x} count crew _veh == 0)) then 
		{
			// set the time for when the cehicle will respawn
			_timer = time + _used;
			sleep 0.1;
		 	waitUntil {_timer < time or !alive _veh or {alive _x} count crew _veh > 0};
			
			deleteVehicle _veh;
			sleep 2;
			_veh = _type createVehicle _position;
			_veh setPosASL _position;
			_veh setDir _dir;
			
		};
	};

};

