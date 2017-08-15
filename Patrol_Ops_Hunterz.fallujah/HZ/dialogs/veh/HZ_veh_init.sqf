
// exec at start of mission
//compile funcs

HZ_veh_update_dialog = compile preprocessfilelinenumbers "HZ\dialogs\veh\funcs\HZ_update_dialog_veh.sqf";
HZ_veh_createveh = compile preprocessfilelinenumbers "HZ\dialogs\veh\funcs\HZ_createveh.sqf";
Hz_veh_getVehCost = compile preprocessfilelinenumbers "HZ\dialogs\veh\funcs\Hz_getVehcost.sqf";

if(isnil "hz_debug") then {hz_debug = false;};


if(isServer) then {Hz_funds = 230000; publicvariable "Hz_funds"; hz_veh_array = []; publicvariable "hz_veh_array";};