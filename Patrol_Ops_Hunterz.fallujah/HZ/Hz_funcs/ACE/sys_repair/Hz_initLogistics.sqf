
waituntil {!isnil "CBA_fnc_AddlocalEventhandler"};
sleep 0.1;

//Turret locality is an extremely weird case in Arma. Best is to execute globally and hope that everything goes fine...
["Hz_econ_addMagazineTurret", {
    
    private ["_veh","_magazine","_turret"];

    _veh = _this select 0;
    _magazine = _this select 1;
    _turret = _this select 2;

    _veh addmagazineturret [_magazine, _turret];    
                        
}] call CBA_fnc_addEventHandler;

["Hz_econ_addVehMagazine", {
    
    private ["_veh","_magazine"];

    _veh = _this select 0;
    _magazine = _this select 1;

    _veh addmagazine _magazine;    
                        
}] call CBA_fnc_addEventHandler;

["Hz_econ_removeVehMagazine", {
    
    private ["_veh","_magazine"];

    _veh = _this select 0;
    _magazine = _this select 1;

    _veh removemagazine _magazine;    
                        
}] call CBA_fnc_addEventHandler;

["Hz_econ_addVehicleWeapon", {
    
    private ["_veh","_weapon"];

    _veh = _this select 0;
    _weapon = _this select 1;

    _veh addweapon _weapon;    
                        
}] call CBA_fnc_addEventHandler;
