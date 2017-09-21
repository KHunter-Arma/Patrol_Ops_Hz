
[] spawn {
    
waituntil {sleep 1; !isnil "introseqdone"};
waituntil {sleep 1; introseqdone};

_ACREisOK = [] call Hz_func_acre_OK;

if(!_ACREisOK) then {

hintc "Warning! The server has detected that your ACRE is not functioning correctly! You will be removed from the server if the problem persists.";    
sleep 60;

_ACREisOK = [] call Hz_func_acre_OK;

if(!_ACREisOK) then {

hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! You are being returned to the lobby due to problems with your ACRE. Please make sure your TS3 version is compatible and all addons are installed correctly.</t>"];
sleep 10;
endMission "LOSER";

};

};

};