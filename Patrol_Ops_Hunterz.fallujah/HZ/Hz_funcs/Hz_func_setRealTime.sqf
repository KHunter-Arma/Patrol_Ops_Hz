
if(isServer) then {

    [] spawn {

        _setDate = date;    
        _date = call compile ("real_date" callextension "GMT");
        _minute = _date select 4;

        waituntil {_date = call compile ("real_date" callextension "GMT"); (_date select 4) != _minute};
        
        //GMT-5
        _hour = (_date select 3) - 5;
        if(_hour < 0) then {_hour = 24 + _hour;};
        setdate [_setDate select 0, _setDate select 1, _setDate select 2, _hour, _date select 4];
        
        _resetSecs = time % 60;
        skiptime (-(_resetSecs/3600));

    };

};