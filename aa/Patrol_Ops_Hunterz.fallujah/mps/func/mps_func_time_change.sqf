// Written by EightySix

private["_addhours","_hour","_location","_hourslater","_position","_radius"];

	_addhours = _this select 0;

if(isServer && isMultiplayer) exitWith {
	setDate [date select 0,date select 1,date select 2,(date select 3)+_addhours,date select 4];
};

if(!isDedicated) then {

	_position = if(count _this > 1) then { (_this select 1) call mps_get_position; }else{ nil };

	_radius = if(count _this > 2) then { _this select 2 }else{ 5 };

	_location = if(count _this > 3) then { _this select 3 }else{ nil };
	if(isNil "_location") then { _location = text ((nearestLocations[position player,["NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal"],2000]) select 0); };

	_hourslater = if(count _this > 4) then { _this select 4 }else{ "" };




	121 cuttext [format["%1",_hourslater], "BLACK OUT",5];

	sleep 6;

	setDate [date select 0,date select 1,date select 2,(date select 3)+_addhours,date select 4];

	if(!isNil "_position") then {
		_xy = [_position,random 360,(2 + random _radius),true,1] call mps_new_position;
		player setVelocity [0, 0, 0];
		player setpos [_xy select 0,_xy select 1,0];
	};

	if(date select 3 < 10) then { _hour = format["0%1",date select 3]; }else{_hour = str(date select 3);} ;

	[	format["%1",name player],
		_hour + str(date select 4) + " HOURS",
		str( format["%1", _location])
	] call BIS_fnc_infoText;

	sleep 5;

	121 cuttext [ _hour + str(date select 4) + " HOURS", "BLACK IN",5];

};

if(true) exitWith{};


