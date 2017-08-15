

private ["_veh"];
if(!hz_debug) then {

//Player check
if ([] call Hz_func_isSupervisor) then {

//Check funds
if(Hz_funds >= hz_veh_cost) then {

    if((toupper hz_veh_selected) in Hz_restricted_vehs) exitwith {hint "You are not authorized to order this vehicle!";};
        
    Hz_funds = Hz_funds - hz_veh_cost;
    publicvariable "Hz_funds";
    if(hz_veh_selected == "kyo_microlight") then {hz_veh_selected = ["kyo_microlight","kyo_microlight_blue","kyo_microlight_yellow"] call BIS_fnc_selectrandom;};
    _veh = hz_veh_selected createVehicle (markerpos "hz_buyvehicle");
    _veh setdir 135;
    _veh setpos (getpos _veh);
    
    hz_veh_array = hz_veh_array + [_veh];
    publicvariable "hz_veh_array";
    clearMagazineCargoGlobal _veh;
    clearWeaponCargoGlobal _veh;
    _veh setfuel 0.05;
    _veh setvehicleammo 0;
    [_veh] call Hz_func_setvehicleinit;
    
    hint "Your vehicle has been delivered!";

} else {

hint "Insufficient funds!";

};

} else {

hint "You are not authorised to make purchases on this server!";

};

} else {

hint "DEBUG MODE: Object spawn succesful!";

    if(hz_veh_selected == "kyo_microlight") then {hz_veh_selected = ["kyo_microlight","kyo_microlight_blue","kyo_microlight_yellow"] call BIS_fnc_selectrandom;};
    _veh = hz_veh_selected createVehicle (markerpos "hz_buyvehicle");
    _veh setdir 135;
    _veh setpos (getpos _veh);
    
    hz_veh_array = hz_veh_array + [_veh];
    publicvariable "hz_veh_array";
    
   [_veh] call Hz_func_setvehicleinit;
    
    

};
