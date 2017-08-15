
private ["_grp","_target","_UPSmarker","_wp"];

_grp = _this select 0;
_target = _this select 1;
_UPSmarker = _this select 2;

_grp setvariable ["Hz_Supporting",true];

while {(count (waypoints _grp)) > 0} do
{
 deleteWaypoint ((waypoints _grp) select 0);
};

sleep 0.1;
{dostop _x}foreach units _grp;
sleep 2;

_grp move _target;

waituntil {

sleep 5;

(
(((leader _grp) distance _target) < 100)
|| 
((count (units _grp)) < 1)
||
((behaviour (leader _grp)) == "SAFE") //timeout
)

};

if((count (units _grp)) > 0) then {

waituntil {

sleep 5;

(
((behaviour (leader _grp)) == "SAFE") || ((count (units _grp)) < 1)
)

};

_grp setvariable ["Hz_Supporting",false];
[_grp,_UPSmarker,"CYCLE:",5,"SHOWMARKER"] execvm "ups.sqf";

};