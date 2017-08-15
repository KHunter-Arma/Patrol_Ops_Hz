_plane = _this select 0;

cargolightemittor2 setLightColor [1, 1, 1];
cargolightemittor1 setLightAmbient [1,1,1];
cargolightemittor1 setLightColor [1, 1, 1];
cargolightemittor2 setLightAmbient [1,1,1];
cargolightemittor1 setLightBrightness 0.006;
cargolightemittor2 setLightBrightness 0.006;

hintsilent "Cargo lights on";

mp_c130_main = mp_c130_main + 1;
mp_c130_cargoon = true;
mp_c130_cargooff = false;
publicvariable "mp_c130_cargoon";
publicvariable "mp_c130_cargooff";
publicvariable "mp_c130_main";


waituntil {sleep 2; (velocity _plane) select 1 > 30};

[_plane] spawn {
    
 if (cargolighttracker) exitwith{};
            
cargolighttracker = true;
_plane = _this select 0;
_placement = 0;
_speed = 100;


waituntil {sleep 2; (getposatl _plane) select 2 > 10};

while {(getposatl _plane) select 2 > 2} do {
    

_speedx = (velocity _plane) select 0;
_speedy = (velocity _plane) select 1;

_speed = sqrt (((_speedx)^2) + ((_speedy)^2));
_speed = _speed * 3.6;

_placement = _speed * 0.013;

cargolight attachto [c130,[0,7,-1.6]];
cargolightemittor1 attachto [cargolight,[0, _placement, 0]];
cargolightemittor2 attachto [cargolight,[0, _placement - 6, 0]];
//cargolight attachto [c130,[0, _placement + 7, -1.6]];

//sleep 0.01;

};
cargolightemittor1 attachto [cargolight,[0,0,0]];
cargolightemittor2 attachto [cargolight,[0,-6,0]];
//cargolight attachto [c130,[0,7,-1.6]];

cargolighttracker = false;

};

