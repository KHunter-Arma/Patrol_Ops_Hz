////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AttachToTractor scripts made by Baco
//
// What does it do? 	Make towingtractors operational to move planes and heli's anywere on a map, as long as they are present.
// How does it work? 	Jump in towingtractor and position in front of a plane or heli and 
// 			head nose to the plane or heli nose within 5 degrees, to get the towing option.
//
// To make these scripts work, place a trigger in the mission and:
// 1) let it trigger repeatable and by anyone
// 2) put in the "bedingung" field:		vehicle player != player and local player;
// 3) put in the "on act." field: 		myvec = vehicle player; temp = [myvec] execVM "AttachToTractor\AttachToTractor.sqf";
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if not (local player) exitWith {};
_Tractor = _this select 0;
_cargo = _this select 3;
Tractorcargo = 0;
exit;