
private ["_bike"];
/*
this addAction ["Create Bike", "logistics\createbike.sqf", nil, -1, true, true, "", "true"];
*/
if(isnil "bikesafe") then {bikesafe = true;};
if(!bikesafe) exitwith {hint "You must wait for 1 minute before being able to create another bike!";};

bikesafe = false;
_bike = "MMT_Civ" createVehicle (getpos (_this select 0));

tempbikes = tempbikes + [_bike];
publicvariable "tempbikes";

sleep 60;
bikesafe = true;

