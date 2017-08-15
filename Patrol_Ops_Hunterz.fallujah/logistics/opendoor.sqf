_plane = _this select 0;
_type = typeof _plane;

if (_type == "C130J_US_EP1") then {
_plane animate ["door_1", 1];

}else {

    _plane animate ["door1_top", 1];
    _plane animate ["door1_bottom", 1];
         
};

hint "Door open";

