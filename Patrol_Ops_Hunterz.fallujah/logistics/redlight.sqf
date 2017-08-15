_plane = _this select 0;

redlightemittor setLightColor [1, 0.1, 0.1];
redlightemittor setLightAmbient [1,0,0];
redlightemittor setLightBrightness 0.02;

hint "Red Light on";
_plane setvariable ["Redlight",true,true];
_plane setvariable ["Greenlight",false,true];

mp_c130_main = mp_c130_main + 1;
mp_c130_jumpgreen = false;
mp_c130_jumpred = true;
mp_c130_jumpoff = false;
publicvariable "mp_c130_jumpgreen";
publicvariable "mp_c130_jumpred";
publicvariable "mp_c130_jumpoff";
publicvariable "mp_c130_main";


[_plane] spawn {
    
 if (redlighttracker) exitwith{};
            
redlighttracker = true;
_plane = _this select 0;
_placement = 0;
_speed = 100;

waituntil {sleep 2; (getposatl _plane) select 2 > 10};

while {(getposatl _plane) select 2 > 20} do {
    

_speedx = (velocity _plane) select 0;
_speedy = (velocity _plane) select 1;

_speed = sqrt (((_speedx)^2) + ((_speedy)^2));
_speed = _speed * 3.6;

_placement = _speed * (-0.011);

redlight attachto [c130,[1.4,-3,-1.8]];
redlightemittor attachto [redlight,[0, _placement, 0]];
//redlight attachto [c130,[0, _placement-3, -1.8]];

sleep 1;

};

redlightemittor attachto [redlight,[0,0,0]];
//redlight attachto [c130,[1.4,-3,-1.8]];

redlighttracker = false;

};
