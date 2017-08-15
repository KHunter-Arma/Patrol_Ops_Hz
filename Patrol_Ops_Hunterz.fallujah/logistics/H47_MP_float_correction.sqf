
private ["_exit","_landfloat","_xx","_yy","_zz","_heli"];

_heli = _this select 0;
_landfloat = _heli getvariable ["heli_float_object",objnull];

if (!isDedicated) then {

    //in case people switch from the inside to pilot seat
    _exit = false;
    waituntil {if(!alive player || ((vehicle player) == player)) exitwith {_exit = true; true}; local _heli};
    if (_exit) exitwith {};

    //float init
    _heli spawn {

        private ["_xx","_yy","_zz"];
        
        //sleep 0.2;
        _xx = getpos _this select 0;
        _yy = getpos _this select 1;
        _zz = getpos _this select 2;
        if ((_zz < 7) and (surfaceIsWater [_xx, _yy])) then
        {
               for "_i" from 0 to 30 do {
                
                _this setposasl [_xx, _yy, 0.0];
                sleep 0.1;
                };
        };

    };

    //Add the EH if creating object for the first time
    if(isnull _landfloat) then {

        _heli addmpeventhandler ["mpkilled", {

        _heli = _this select 0;
        if(!isServer) exitwith {};        
        deletevehicle (_heli getvariable ["heli_float_object",objnull]);

        }];

    };
    
    //must create new float object every time to make sure there are no locality issues -- leads to BOOM otherwise
    deletevehicle _landfloat;
    _landfloat = "pook_H13_landfloat" createvehicle[0,0,0];
    _landfloat setVectorUp [0,0,1];        
    _heli setvariable ["heli_float_object",_landfloat,true];
    

    //float main
    while {(alive _heli) && local _heli} do {
            _xx = getpos _heli select 0;
            _yy = getpos _heli select 1;
            _zz = getpos _heli select 2;
            if(_zz < 10) then {
                    if(surfaceIsWater [_xx, _yy]) then {
                            _landfloat setvelocity velocity _heli;
                            _landfloat setpos [getpos _heli select 0, getpos _heli select 1,0.3]; //0.4
                            _landfloat setdir getdir _heli;
                    }
                    else {};
            };
    };
    
    //switch floating to server
    if(alive _heli) then {[0, {[_this] execvm "logistics\H47_MP_float_correction.sqf";}, _heli] call CBA_fnc_globalExecute;};
    
    //keep floating during transition
    while {local _heli && alive _heli} do {
            _xx = getpos _heli select 0;
            _yy = getpos _heli select 1;
            _zz = getpos _heli select 2;
            if(_zz < 10) then {
                    if(surfaceIsWater [_xx, _yy]) then {
                            _landfloat setvelocity velocity _heli;
                            _landfloat setpos [getpos _heli select 0, getpos _heli select 1,0.3]; //0.4
                            _landfloat setdir getdir _heli;
                    }
                    else {};
            };
    };

} else {

    //float init
    _heli spawn {

        private ["_xx","_yy","_zz"];
        
        //sleep 0.2;
        _xx = getpos _this select 0;
        _yy = getpos _this select 1;
        _zz = getpos _this select 2;
        if (surfaceIsWater [_xx, _yy]) then
        {
               for "_i" from 0 to 30 do {
                
                _this setposasl [_xx, _yy, 0.5];
                sleep 0.1;
                };
        };

    };
    
    
    _xx = getpos _heli select 0;
    _yy = getpos _heli select 1;
    _zz = getpos _heli select 2;
    
    //no need to run script if parked on land?
 //   if(!(surfaceIsWater [_xx, _yy])) exitwith {};

    //create a global float object if it doesn't exist for this heli
    if(isnull _landfloat) then {

        _landfloat = "pook_H13_landfloat" createvehicle[0,0,0];
        _landfloat setVectorUp [0,0,1];        
        _heli setvariable ["heli_float_object",_landfloat,true];
        _heli addmpeventhandler ["mpkilled", {

        _heli = _this select 0;
        if(!isServer) exitwith {};        
        deletevehicle (_heli getvariable ["heli_float_object",objnull]);

        }];

    };

    waituntil {local _heli};

    //float main
    while {(alive _heli) && local _heli} do {
            _xx = getpos _heli select 0;
            _yy = getpos _heli select 1;
            _zz = getpos _heli select 2;
            if(_zz < 10) then {
                    if(surfaceIsWater [_xx, _yy]) then {
                            _landfloat setvelocity velocity _heli;
                            _landfloat setpos [getpos _heli select 0, getpos _heli select 1,0.3]; //0.4
                            _landfloat setdir getdir _heli;
                    }
                    else {};
            };
    };

};