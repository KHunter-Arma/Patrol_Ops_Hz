
if(!isServer && !(call Hz_fnc_isHC)) then {

    waituntil {!isnull player};    

    if (getplayeruid player == kick) then {
           
    endmission "End2";

    };
    
};