

private ["_return"];
_return = false;

if(!isNil "Hz_playertype") then {
    
if((toupper Hz_playertype) == "SUPERVISOR") then {_return = true;};

};

_return