_plane = _this select 0;
_type = typeof _plane;

if (_type == "C130J_US_EP1" || _type == "MV22") then {
_plane animate ["ramp_top", 0];
_plane animate ["ramp_bottom", 0];
redlightemittor setLightBrightness 0;

mp_c130_main = mp_c130_main + 1;
mp_c130_jumpgreen = false;
mp_c130_jumpred = false;
mp_c130_jumpoff = true;
publicvariable "mp_c130_jumpgreen";
publicvariable "mp_c130_jumpred";
publicvariable "mp_c130_jumpoff";
publicvariable "mp_c130_main";



}else {

    _plane animate ["ramp", 0];
         
};


hint "Ramp closed";