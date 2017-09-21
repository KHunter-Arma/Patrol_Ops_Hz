// Written by EightySix

if(isServer) then {

private["_year","_month","_day","_hour","_min"];

	if(count _this < 5) exitwith { hint "MPS_SETDATE ERROR- SERVER DATE NOT SET WITH Y,M,D,H,M"; };

	_year = _this select 0;
	_month = _this select 1;
	_day = _this select 2;
	_hour = _this select 3;
	_min = _this select 4;
        
        if (_hour == -1) then {call Hz_func_setRealTime;} else {

            setDate [_year,_month,_day,_hour,_min];
        
        };
} else {

setdate date;

};

if(true) exitWith{};
