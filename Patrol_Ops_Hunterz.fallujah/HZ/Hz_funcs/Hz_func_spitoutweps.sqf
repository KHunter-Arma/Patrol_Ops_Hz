private ["_spitweps","_wepholder","_crate"];

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
     
    if(_x in weapons player) then {

		_wepholder addweaponcargoglobal [_x, 1];
		
		player removeweapon _x;		
		
		};   
     
}foreach _spitweps;