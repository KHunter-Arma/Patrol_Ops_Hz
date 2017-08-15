
private ["_exit","_Float1","_Float2","_Float3","_xx","_yy","_zz","_plane"];

_plane = _this select 0;
_Float1 = _plane getvariable ["plane_float_object1",objnull];
_Float2 = _plane getvariable ["plane_float_object2",objnull];
_Float3 = _plane getvariable ["plane_float_object3",objnull];


if (!isDedicated) then {


    //in case people switch from the inside to pilot seat
    _exit = false;
    waituntil {if(!alive player || ((vehicle player) == player)) exitwith {_exit = true; true}; local _plane};
    if (_exit) exitwith {};

    //float init
    _plane spawn {

       private ["_xx","_yy","_zz"];
        
      //  sleep 0.2;
        _xx = getpos _this select 0;
        _yy = getpos _this select 1;
        _zz = getpos _this select 2;
        if ((_zz < 7) and (surfaceIsWater [_xx, _yy])) then
        {
                _this setposasl [_xx, _yy, 0.0];
        };

    };

    //create global float objects if they don't exist for this plane
if(isnull _Float1) then {

        _plane addmpeventhandler ["mpkilled", {

        _plane = _this select 0;
        if(!isServer) exitwith {};        
        deletevehicle (_plane getvariable ["plane_float_object1",objnull]);
        deletevehicle (_plane getvariable ["plane_float_object2",objnull]);
        deletevehicle (_plane getvariable ["plane_float_object3",objnull]);

        }];
};

         //must create new float objects every time to make sure there are no locality issues -- leads to BOOM otherwise
         deletevehicle _Float1;
         deletevehicle _Float2;
         deletevehicle _Float3;

        _Float1 = "GNTXFloat1" createvehicle[0,0,0];
        _Float2 = "GNTXFloat2" createvehicle[0,0,0];
        _Float3 = "GNTXFloat2" createvehicle[0,0,0];

        _Float2 attachto [_plane, [1.1,1,-1.7]];
        _Float3 attachto [_plane, [-1.1,1,-1.7]];
        _Float1 setVectorUp [0,0,1];

        _plane setvariable ["plane_float_object1",_Float1,true];
        _plane setvariable ["plane_float_object2",_Float2,true];
        _plane setvariable ["plane_float_object3",_Float3,true];




    //float main
    while {(alive _plane) && local _heli} do {
            _xx = getpos _plane select 0;
            _yy = getpos _plane select 1;
            _zz = getpos _plane select 2;
            if(_zz < 7) then
            {
                    if(surfaceIsWater [_xx, _yy]) then
                    {
                            _plane Animate ["LandContact", 1];
                            _plane Animate ["GearFront", 1];
                            _plane Animate ["GearRear", 1];
                            _Float1 setvelocity velocity _plane;
                            _Float1 setpos [getpos _plane select 0, getpos _plane select 1,0.4];
    //			_Float1 setposasl [getpos _plane select 0, getpos _plane select 1,0.8];
                    }
                    else
                    {
                            _plane Animate ["LandContact", 0];
                            _plane Animate ["GearFront", 0];
                            _plane Animate ["GearRear", 0];
                    };
            };
            if((_zz > 10) and ((_plane animationPhase "GearFront") == 0)) then
            {
                            _plane Animate ["LandContact", 0.1];
                            _plane Animate ["GearFront", 1];
                            _plane Animate ["GearRear", 1];
            };
    };
    
    //switch floating to server
    if(alive _plane) then {[0, {[_this] execvm "logistics\C185_MP_float_correction.sqf";}, _plane] call CBA_fnc_globalExecute;};
    
    //keep floating during transition
    while {(alive _plane) && local _plane} do {
            _xx = getpos _plane select 0;
            _yy = getpos _plane select 1;
            _zz = getpos _plane select 2;
            if(_zz < 7) then
            {
                    if(surfaceIsWater [_xx, _yy]) then
                    {
                            _plane Animate ["LandContact", 1];
                            _plane Animate ["GearFront", 1];
                            _plane Animate ["GearRear", 1];
                            _Float1 setvelocity velocity _plane;
                            _Float1 setpos [getpos _plane select 0, getpos _plane select 1,0.4];
    //			_Float1 setposasl [getpos _plane select 0, getpos _plane select 1,0.8];
                    }
                    else
                    {
                            _plane Animate ["LandContact", 0];
                            _plane Animate ["GearFront", 0];
                            _plane Animate ["GearRear", 0];
                    };
            };
            if((_zz > 10) and ((_plane animationPhase "GearFront") == 0)) then
            {
                            _plane Animate ["LandContact", 0.1];
                            _plane Animate ["GearFront", 1];
                            _plane Animate ["GearRear", 1];
            };
    };

} else {

//float init
    _plane spawn {

        private ["_xx","_yy","_zz"];
        
    //    sleep 0.2;
        _xx = getpos _this select 0;
        _yy = getpos _this select 1;
        _zz = getpos _this select 2;
        if ((_zz < 7) and (surfaceIsWater [_xx, _yy])) then
        {
                _this setposasl [_xx, _yy, 0.0];
        };

    };
    
    _xx = getpos _plane select 0;
    _yy = getpos _plane select 1;
    _zz = getpos _plane select 2;
    
    //no need to run script if parked on land?
 //   if(!(surfaceIsWater [_xx, _yy])) exitwith {};

    //create a global float objects if they don't exist for this plane
    if(isnull _Float1) then {

         //make sure the others are deleted first if they exist already  
         deletevehicle _Float2;
         deletevehicle _Float3;

        _Float1 = "GNTXFloat1" createvehicle[0,0,0];
        _Float2 = "GNTXFloat2" createvehicle[0,0,0];
        _Float3 = "GNTXFloat2" createvehicle[0,0,0];

        _Float2 attachto [_plane, [1.1,1,-1.7]];
        _Float3 attachto [_plane, [-1.1,1,-1.7]];
        _Float1 setVectorUp [0,0,1];

        _plane setvariable ["plane_float_object1",_Float1,true];
        _plane setvariable ["plane_float_object2",_Float2,true];
        _plane setvariable ["plane_float_object3",_Float3,true];

        _plane addmpeventhandler ["mpkilled", {

        _plane = _this select 0;
        if(!isServer) exitwith {};        
        deletevehicle (_plane getvariable ["plane_float_object1",objnull]);
        deletevehicle (_plane getvariable ["plane_float_object2",objnull]);
        deletevehicle (_plane getvariable ["plane_float_object3",objnull]);

        }];

    };
    
    waituntil {local _plane};

    //float main
    while {(alive _plane) && local _plane} do {
            _xx = getpos _plane select 0;
            _yy = getpos _plane select 1;
            _zz = getpos _plane select 2;
            if(_zz < 7) then
            {
                    if(surfaceIsWater [_xx, _yy]) then
                    {
                            _plane Animate ["LandContact", 1];
                            _plane Animate ["GearFront", 1];
                            _plane Animate ["GearRear", 1];
                            _Float1 setvelocity velocity _plane;
                            _Float1 setpos [getpos _plane select 0, getpos _plane select 1,0.4];
    //			_Float1 setposasl [getpos _plane select 0, getpos _plane select 1,0.8];
                    }
                    else
                    {
                            _plane Animate ["LandContact", 0];
                            _plane Animate ["GearFront", 0];
                            _plane Animate ["GearRear", 0];
                    };
            };
            if((_zz > 10) and ((_plane animationPhase "GearFront") == 0)) then
            {
                            _plane Animate ["LandContact", 0.1];
                            _plane Animate ["GearFront", 1];
                            _plane Animate ["GearRear", 1];
            };
    };
    
};