
// run at start of mission

HZ_fort_update_dialog = compile preprocessfilelinenumbers "HZ\dialogs\fort\funcs\HZ_update_dialog_fort.sqf";
Hz_fort_getObjectCost = compile preprocessfilelinenumbers "HZ\dialogs\fort\funcs\Hz_fort_getObjectCost.sqf";
HZ_fort_spawnobject = compile preprocessfilelinenumbers "HZ\dialogs\fort\funcs\HZ_fort_spawnobject.sqf";
if(isnil "hz_debug") then {hz_debug = false;};

if(isServer) then {

    hz_fort_array = []; 
    publicvariable "hz_fort_array"; 
		
};