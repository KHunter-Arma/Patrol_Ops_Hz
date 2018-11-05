
private ["_targetpos","_jettype","_group","_jet1","_jet2","_jet3","_bombType"];
//if(isnull heli_radar) exitwith {};
//if(!alive heli_radar) exitwith {};

_targetpos = _this select 0;
_jettype = _this select 2;
_group = creategroup (_this select 1);
_bombType = _this select 3;

/*_jet1 = ([[(position heli_radar select 0)+20000,(position heli_radar select 1)+22000,800], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;
_jet2 = ([[(position heli_radar select 0)+20100,(position heli_radar select 1)+22100,800], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;
_jet3 = ([[(position heli_radar select 0)+19900,(position heli_radar select 1)+21900,800], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;*/

_jet1 = ([[-20000,22000,2000], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;
_jet2 = ([[-20100,22100,2000], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;
_jet3 = ([[-19900,21900,2000], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;

{(driver _x) disableai "autotarget"; (driver _x) disableai "target"; _x flyinheight 250;}foreach [_jet1,_jet2,_jet3];

{

	_weps = weapons _x;
	_x setVehicleAmmo 0;

	if (!(_bombType in _weps)) then {
	
		_x addWeapon _bombType;		
	
	};
	
	_x addMagazines [(getarray (configFile >> "cfgWeapons" >> _bombType >> "magazines")) select 0,4];


} foreach [_jet1,_jet2,_jet3];

[_jet1, _targetpos, _bombType] spawn {


private ["_jet","_pos","_lead","_group","_pilots","_bombType","_exitpos"];
_jet = _this select 0;
_pos = _this select 1;
_bombType = _this select 2;
_lead = driver _jet;
_group = group _lead;
_pilots = units _group;


_group move _pos;
_group setformation "LINE";

{(vehicle _x) flyInHeight 250;}foreach _pilots;

//waituntil {uisleep 0.1; ((_jet distance _pos) < 1450) || (((getposatl _jet) select 2) < 20)};
waituntil {uisleep 0.1; ((_jet distance _pos) < 3150) || (((getposatl _jet) select 2) < 20)};

{_x fireAtTarget [objnull, _bombType];} foreach _pilots;  //lulz Xfire....
uisleep 0.3;
{_x fireAtTarget [objnull, _bombType];} foreach _pilots; 
uisleep 0.3;
{_x fireAtTarget [objnull, _bombType];} foreach _pilots; 
uisleep 0.3;    
{_x fireAtTarget [objnull, _bombType];} foreach _pilots; 




{(vehicle _x) flyinheight 2000;}foreach _pilots;

_exitpos = [30000,30000,7000];

_group move _exitpos;

waituntil {sleep 5; ((_lead distance _pos) > 70000) || (((getposatl _lead) select 2) < 20)};

{
_jet = vehicle _x;
if ((_jet != _x) && (alive _jet)) then {deletevehicle _x; deletevehicle _jet;};
} foreach _pilots;

deletegroup _group;

};