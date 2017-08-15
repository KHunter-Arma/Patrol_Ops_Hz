if(mp_c130_cabinon) then {

cabinlightemittor1 setLightColor [1, 1, 1];
cabinlightemittor1 setLightAmbient [1,1,1];
cabinlightemittor1 setLightBrightness 0.005;

};

if(mp_c130_cabinoff) then {

cabinlightemittor1 setLightBrightness 0;

};

if(mp_c130_cargoon) then {

cargolightemittor2 setLightColor [1, 1, 1];
cargolightemittor1 setLightAmbient [1,1,1];
cargolightemittor1 setLightColor [1, 1, 1];
cargolightemittor2 setLightAmbient [1,1,1];
cargolightemittor1 setLightBrightness 0.006;
cargolightemittor2 setLightBrightness 0.006;

};

if(mp_c130_cargooff) then {

cargolightemittor1 setLightBrightness 0;
cargolightemittor2 setLightBrightness 0;

};


if(mp_c130_jumpgreen) then {

redlightemittor setLightColor [1, 1, 1];
redlightemittor setLightAmbient [0,1,0];
redlightemittor setLightBrightness 0.01;

};

if(mp_c130_jumpred) then {

redlightemittor setLightColor [1, 0.1, 0.1];
redlightemittor setLightAmbient [1,0,0];
redlightemittor setLightBrightness 0.02;

};

if(mp_c130_jumpoff) then {

redlightemittor setLightBrightness 0;

};

