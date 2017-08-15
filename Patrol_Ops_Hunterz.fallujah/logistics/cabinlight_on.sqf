_plane = _this select 0;

cabinlightemittor1 setLightColor [1, 1, 1];
cabinlightemittor1 setLightAmbient [1,1,1];
cabinlightemittor1 setLightBrightness 0.005;

mp_c130_main = mp_c130_main + 1;
mp_c130_cabinon = true;
mp_c130_cabinoff = false;
publicvariable "mp_c130_cabinon";
publicvariable "mp_c130_cabinoff";
publicvariable "mp_c130_main";



[_plane] spawn {
    
 if (cabinlighttracker) exitwith{};
            
cabinlighttracker = true;
_plane = _this select 0;
_placement = 0;
_speed = 100;

waituntil {sleep 2; (getposatl _plane) select 2 > 10};

while {(getposatl _plane) select 2 > 2} do {
    

_speedx = (velocity _plane) select 0;
_speedy = (velocity _plane) select 1;

_speed = sqrt (((_speedx)^2) + ((_speedy)^2));
_speed = _speed * 3.6;

_placement = _speed * 0.011;

cabinlight attachto [c130,[0,12,-1.6]];
cabinlightemittor1 attachto [cabinlight,[0, _placement, 0]];
//cabinlight attachto [c130,[0, _placement+12, -1.6]];

//sleep 0.01;

};
cabinlightemittor1 attachto [cabinlight,[0,0,0]];
//cabinlight attachto [c130,[0,12,-1.6]];

cabinlighttracker = false;

};