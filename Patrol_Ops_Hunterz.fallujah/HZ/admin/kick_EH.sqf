
if(!isServer) then {

    waituntil {!isnull player};    

    if (getplayeruid player == kick) then {
        
    hintc "You were kicked by an admin.";        
    endmission "End2";

    };
    
};