if(!isServer) exitwith {};

_grp = _this select 0;
_pos = markerpos "respawn_west";

sleep 10;

_grp setcombatmode "BLUE";

while {(count units _grp) > 0} do {
    
        _targets = nearestobjects [_pos,["LandVehicle","CAManBase"],4000];
        {_grp reveal [_x,4];} foreach _targets;
        
        //need to make sure ground defences don't fire at enemy air and attract their attention unnecessarily
        _safe = true;
        {
        if((((side _x) == east) && (((assignedtarget _x) distance _pos) < 1200)) || ((_x distance _pos) < 1200)) exitwith {_safe = false;};
        } foreach _targets;
        
        if (!_safe) then {_grp setcombatmode "YELLOW";} else {_grp setcombatmode "BLUE";};
        
       sleep 10;  
        
        };