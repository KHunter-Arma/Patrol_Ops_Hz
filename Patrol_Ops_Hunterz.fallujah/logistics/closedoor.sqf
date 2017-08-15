_plane = _this select 0;
_type = typeof _plane;

if (_type == "C130J_US_EP1") then {
_plane animate ["door_1", 0];

}else {

    _plane animate ["door1_top", 0];
    _plane animate ["door1_bottom", 0];
         
};
hint "Door closed";