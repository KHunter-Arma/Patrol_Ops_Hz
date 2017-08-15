 if (isServer) then {
     
_narray1 = (nearestObjects [nukepos,[], 300]);
_narray2 = (nearestObjects [nukepos,[], 500]);
//narray5 = (nearestObjects [nukepos,["Thing","Static"], 1000]) - (nearestObjects [nukepos,["Thing","Static"], 500]);

narray3 = ((nearestObjects [nukepos,["Air","Car","CAManBase","Tank"], 1000]) - (nearestObjects [nukepos,["Air","Car","CAManBase","Tank"], 500]));
narray4 = ((nearestObjects [nukepos,["Air","Car","CAManBase","Tank"], 2000]) - (nearestObjects [nukepos,["Air","Car","CAManBase","Tank"], 1000]));

_narray1 = _narray1 - [nukepos,wreck1,wreck2,wreck3,wreck4,wreck5,wreck6,wreck7];
_narray2 = _narray2 - [nukepos,wreck1,wreck2,wreck3,wreck4,wreck5,wreck6,wreck7];

//if(nukepos in narray5) then {narray5 = narray5 - [nukepos];};
//if(wreck1 in narray5) then {narray5 = narray5 - [wreck1];};
//if(wreck2 in narray5) then {narray5 = narray5 - [wreck2];};

//try to sync with client visual effects
sleep 7;


{_x setdammage 1; } forEach _narray2;

//sleep 4;

{if (_x iskindof "CAManBase") then {_x setvelocity [10,-10,5]; _x setvectorup [0,-1,0.5]; _x setdir random 360;} else {(vehicle _x) setvelocity [10,-10,1]; (vehicle _x)setvectorup [0,-1,0.5]; (vehicle _x) setdammage ((getdammage (vehicle _x)) + 0.6);}; (vehicle _x) setdir random 360; {if(!isplayer _x)then {[_x, 0.5] call ace_sys_wounds_fnc_addDamage;};}foreach crew _x;} forEach narray3;

//sleep 8;

{if (_x iskindof "CAManBase") then {_x setvelocity [8.5,-8.5,3]; _x setvectorup [0,-1,0.5]; _x setdir random 360;} else {(vehicle _x) setvelocity [5,-5,0]; (vehicle _x) setvectorup [0,-1,0.5]; (vehicle _x) setdammage ((getdammage (vehicle _x)) + 0.3);}; (vehicle _x) setdir random 360; {if(!isplayer _x)then {[_x, 0.25] call ace_sys_wounds_fnc_addDamage;};}foreach crew _x;} forEach narray4;

//sleep 5;

{deletevehicle _x; 
//_x hideobject true;
} forEach _narray1;

/*publicvariable "narray1";
sleep 1;
[-1, {
        {_x hideobject true;}foreach narray1;
         }] call CBA_fnc_globalExecute;
*/

//damage script uses local vars, then updates global vars to ensure JIP sync of multiple nuke events during a persistent campaign
narray1 = narray1 + _narray1;
narray2 = narray2 + _narray2;
publicvariable "narray2";

}else {

    //compensate for modifying the damage script start time in the original script
sleep 10;

//[] exec "snuke\radzone.sqf";

//if (player distance nukepos < 1000) then 



};