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
_Tractor removeAction actioncargo;
if( (isNull _cargo) || ((_cargo distance _Tractor) > 35) ) exitwith {
	Tractorcargo = 0;
};

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 7;
Tractorcargo = 1;
actiondrop = _Tractor addAction [format ["Detach %1", typeOf _cargo], "AttachToTractor\AttachToTractor_stop.sqf", _cargo, -10, false,true,"","((vehicle _this) != _this) && ((_this distance _target) < 7)"];
_CargoDis = (_cargo distance _Tractor) + 2.5; //safety factor for when detaching...
_CargoDamage = GetDammage _cargo;
while{ (Tractorcargo == 1) && (alive _Tractor)/* && (vehicle player == _Tractor)*/} do
{
	_TractorPos = getPosASL _Tractor;
	_TractorDir = getDir _Tractor;
	_cargo setPosASL [(_TractorPos select 0) + (_CargoDis * sin _TractorDir), (_TractorPos select 1) + (_CargoDis * cos _TractorDir), (_TractorPos select 2)];
	_cargo setDir (_TractorDir + 180);
	_cargo SetDammage _CargoDamage;
	//sleep 0.01;
};

/*
_Tractor removeAction actiondrop;
_TractorPos = getPosASL _Tractor;
_TractorDir = getDir _Tractor;
_cargo setPosASL [(_TractorPos select 0) + (_CargoDis * sin _TractorDir), (_TractorPos select 1) + (_CargoDis * cos _TractorDir), (_TractorPos select 2)];
_cargodir = _TractorDir + 180;
*/