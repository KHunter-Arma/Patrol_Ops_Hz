
if(isServer) then {

    if(!(ban in BanList)) then {
    
     BanList set [count BanList, ban]; 
     publicvariable "BanList";
            
    };
    
} else {
    
    waituntil {!isnull player};    

    if (getplayeruid player == ban) then {

    hintc "You were banned by an admin.";
    endmission "End3";

    };

};