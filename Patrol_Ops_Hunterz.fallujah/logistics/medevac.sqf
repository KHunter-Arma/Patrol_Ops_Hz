//_chopper = _this select 0;

/*
_array = [];

{
if (_x iskindof "LandVehicle") then {_array = _array + [typeof _x];};

}foreach allMissionObjects "";

_array = _array - ["ACE_Stretcher"];

_chopper setVariable ["ACE_Slingload_Rule",_array];

*/

_chopper = _this select 0;
_pos = getpos _chopper;
_speedx = ((velocity _chopper)select 0);
_speedy = ((velocity _chopper)select 1);
_speedz = ((velocity _chopper)select 2);

_height = ((getposATL _chopper) select 2);

if(_height > 5 && _height < 35) then { if(_speedx < 1 && _speedy < 1 && _speedz < 1) then {

_droppos = [(_pos select 0),(_pos select 1),0];
_rope = "WeaponHolder" createVehicle _droppos;
_rope addMagazineCargo ["ACE_Rope_M5",1];
hint "Slingrope dropped!";


//cleanup
[_rope]spawn {
    
        _rope = _this select 0;
        
        sleep 300;
        deletevehicle _rope;
        deletegroup group _rope;


};

}else {hint "You must be stationary to drop a slingrope!";};
} else {hint "Your altitude is not suitable to drop a slingrope!"};

