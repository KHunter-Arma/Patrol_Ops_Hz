_plane = _this select 0;

cargolightemittor1 setLightBrightness 0;
cargolightemittor2 setLightBrightness 0;

hintsilent "Cargo lights off";

mp_c130_main = mp_c130_main + 1;
mp_c130_cargoon = false;
mp_c130_cargooff = true;
publicvariable "mp_c130_cargoon";
publicvariable "mp_c130_cargooff";
publicvariable "mp_c130_main";

