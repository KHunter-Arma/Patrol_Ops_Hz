_plane = _this select 0;
_type = typeof _plane;

if (_type == "C130J_US_EP1" || _type == "MV22") then {
_plane animate ["ramp_top", 1];
_plane animate ["ramp_bottom", 1];

}else {

    _plane animate ["ramp", 1];
         
};


hint "Ramp open";

