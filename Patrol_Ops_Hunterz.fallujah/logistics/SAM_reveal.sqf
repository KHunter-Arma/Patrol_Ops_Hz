if(!isServer) exitwith {};

_oldgrp = _this select 0;
_pos = markerpos "Base";

sleep 1;

samdude forcespeed 0;
samdude disableai "FSM";

{_x setvariable ["veh",vehicle _x];}foreach units _oldgrp;

//Fallujah airbase is too close to AO. Join SAMs to resistance so they don't learn about targets from BLUFOR radio and shoot down everything
_grp = creategroup resistance;
(units _oldgrp) joinsilent _grp;

sleep 1;

while {(count (units _grp)) > 0} do {

_airvehs = nearestobjects [_pos,["Air"],6000];

_safe = true;
{
    if(((getposatl _x) select 2) > 20) then {
        
    _tar = assignedtarget _x;
        
   if(!isnull _tar) then { 
   
  if (((_pos distance _tar) < 600)  && ((side _x) == east)) then {samdude enableai "move"; samdude assignasgunner SAM; [samdude] allowGetIn true; _grp reveal [_x,4];_grp setcombatmode "YELLOW"; _safe = false;samdude moveingunner SAM;};
   
   } else {
   
   if ((_pos distance _x) < 800 && (((getpos _x) select 2) < 500)) then {samdude enableai "move"; samdude assignasgunner SAM; [samdude] allowGetIn true; _grp reveal [_x,4];_grp setcombatmode "YELLOW"; _safe = false; samdude moveingunner SAM;};      
           
   };
 }; 
 
  } foreach _airvehs;
  
//careful... this implementation makes sure samdude doesn't stick his nose into everything. but if you change the implementation, remember SAM dude also tends to get out of his vehicle sometimes for no reason on his own...  
if(_safe) then {_grp setcombatmode "BLUE"; samdude disableai "move"; unassignvehicle samdude; [samdude] allowGetIn false; moveout samdude; sleep 0.1; samdude setpos [((getpos SAM) select 0),((getpos SAM) select 1) - 3,((getpos SAM) select 2)];};

sleep 2;

};

