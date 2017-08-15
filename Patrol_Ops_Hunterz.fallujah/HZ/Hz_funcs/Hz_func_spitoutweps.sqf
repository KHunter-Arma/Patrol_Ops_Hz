private ["_spitweps","_wepholder"];

_spitweps = _this;

_wepholder = objNull;

if((vehicle player) != player) then {

    _wepholder = vehicle player;
    
    hint "You are not allowed to carry this weapon!\nWeapon is now stored in vehicle";
    
    
} else {
    
    _crate = [player,"ACE_USVehicleBox_EP1"] call Hz_func_find_nearest_ammo_crate;
        
     if(!isnull _crate) then {
         
      _wepholder = _crate;
      hint "You are not allowed to carry this weapon!\nWeapon is now stored in nearest ammo crate";
     
     } else {   
            
    _wepholder = "WeaponHolder" createvehicle (position player);
    hint "You are not allowed to carry this weapon!\nWeapon dropped on ground";
    
    };

};

{
     _wepholder addweaponcargoglobal [_x, 1];
     
    if(_x in weapons player) then { player removeweapon _x;} else { [player, "WEP", _x, 1] call ACE_fnc_RemoveGear;};   
     
            }foreach _spitweps;