_plane = _this select 0;

redlightemittor setLightColor [1, 1, 1];
redlightemittor setLightAmbient [0,1,0];
redlightemittor setLightBrightness 0.01;

hint "Green Light given. It will automatically switch off when you close the ramps.";


mp_c130_main = mp_c130_main + 1;
mp_c130_jumpgreen = true;
mp_c130_jumpred = false;
mp_c130_jumpoff = false;
publicvariable "mp_c130_jumpgreen";
publicvariable "mp_c130_jumpred";
publicvariable "mp_c130_jumpoff";
publicvariable "mp_c130_main";