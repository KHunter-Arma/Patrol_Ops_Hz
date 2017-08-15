
// run at start of mission

HZ_fort_update_dialog = compile preprocessfilelinenumbers "HZ\dialogs\fort\funcs\HZ_update_dialog_fort.sqf";
HZ_fort_spawnobject = compile preprocessfilelinenumbers "HZ\dialogs\fort\funcs\HZ_fort_spawnobject.sqf";
if(isnil "hz_debug") then {hz_debug = false;};

if(isServer) then {
    hz_fort_array = []; 
    publicvariable "hz_fort_array";
    hz_fort_array2 = []; 
    publicvariable "hz_fort_array2";
     hz_fort_array3 = []; 
    publicvariable "hz_fort_array3";   
     hz_fort_array4 = []; 
    publicvariable "hz_fort_array4";  
     hz_fort_array5 = []; 
    publicvariable "hz_fort_array5";  
    };