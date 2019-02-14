#define H_SPEED 50
#define V_SPEED 100

private ["_targetpos","_jettype","_group","_jet1","_jet2","_jet3","_bombType"];
//if(isnull heli_radar) exitwith {};
//if(!alive heli_radar) exitwith {};

_targetpos = _this select 0;
_jettype = _this select 2;
_side = _this select 1;
_group = creategroup _side;
_bombType = _this select 3;

_spawnPos = if (_side == east) then {[-20000,22000,2000]} else {[20000,-22000,2000]};

if (isnil "_jettype") exitwith {};
if (isnil "_bombType") exitwith {};

/*_jet1 = ([[(position heli_radar select 0)+20000,(position heli_radar select 1)+22000,800], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;
_jet2 = ([[(position heli_radar select 0)+20100,(position heli_radar select 1)+22100,800], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;
_jet3 = ([[(position heli_radar select 0)+19900,(position heli_radar select 1)+21900,800], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;*/

_jet1 = ([_spawnPos, 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;
_jet2 = ([[(_spawnPos select 0) - 100,(_spawnPos select 1) + 100,2000], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;
_jet3 = ([[(_spawnPos select 0) + 100,(_spawnPos select 1) - 100,2000], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;

_jets = [_jet1,_jet2,_jet3];

{

	(driver _x) disableai "AUTOTARGET";
	(driver _x) disableai "TARGET";
	(driver _x) disableai "FSM";
	(driver _x) disableai "AUTOCOMBAT";
	_x flyinheight 250;
	_x setvariable ["Hz_disableFSM",true];

}foreach _jets;

_group setbehaviour "AWARE";
_group setCombatMode "GREEN";
_group setvariable ["Hz_noBehaviour",true];

{

	_weps = weapons _x;

	if (!(_bombType in _weps)) then {
	
		_x addWeapon _bombType;		
	
	};
	
	_x addMagazines [(getarray (configFile >> "cfgWeapons" >> _bombType >> "magazines")) select 0,4];


} foreach _jets;

[_jets, _targetpos, _bombType] spawn {


private ["_jet","_pos","_lead","_group","_pilots","_bombType","_exitpos"];
_jets = _this select 0;
_pos = _this select 1;
_bombType = _this select 2;

_jet1 = _jets select 0;
_group = group _jet1;
_side = side _jet1;
_lead = leader _group;
_pilots = units _group;

_group move _pos;
_group setformation "LINE";

{(vehicle _x) flyInHeight 250;}foreach _pilots;

{

	[_x,_pos,_bombType] spawn {
	
		_jet = _this select 0;
		_pilot = driver _jet;
		_pos = _this select 1;
		_bombType = _this select 2;
				
		waituntil {uisleep 0.1; ((_jet distance _pos) < 1300) || {((getposatl _jet) select 2) < 20}};
		
		/*
		_vel = velocity _jet;
		_angle = (_vel select 1) atan2 (_vel select 0);
		_jet setVariable ["bombVel",[H_SPEED*(cos _angle),H_SPEED*(sin _angle),-0.05194]];
		*/
		_dir = getdir _jet;
		_jet setVariable ["bombVel",[H_SPEED*(sin _dir),H_SPEED*(cos _dir),-V_SPEED]];
		_EH = _jet addEventHandler ["Fired",{
		
			(_this select 6) setVelocity [0,0,-1];
			(_this select 6) setVelocity ((_this select 0) getVariable "bombVel");
		
		}];
		
		waituntil {((_jet distance _pos) < 1000) || {((getposatl _jet) select 2) < 20}};
		
		_pilot fireAtTarget [objnull, _bombType];
		uisleep 0.3;
		_pilot fireAtTarget [objnull, _bombType];
		uisleep 0.3;
		_pilot fireAtTarget [objnull, _bombType];
		uisleep 0.3;    
		_pilot fireAtTarget [objnull, _bombType];		
		
		sleep 2;
		
		_jet removeEventHandler ["Fired",_EH];
			
	};

} foreach _jets;

{

	waituntil {uisleep 0.1; ((_x distance _pos) < 1000) || {((getposatl _x) select 2) < 20}};
	waituntil {uisleep 0.1; ((_x distance _pos) < 1000) || {((getposatl _x) select 2) < 20}};
	waituntil {uisleep 0.1; ((_x distance _pos) < 1000) || {((getposatl _x) select 2) < 20}};

} foreach _jets;

sleep 3;

{(vehicle _x) flyinheight 2000;}foreach _pilots;

_exitpos = [30000,30000,7000];
_exitpos = if (_side == east) then {[30000,30000,7000]} else {[30000,-30000,7000]};

_timeout = time + 300;

_WP = _group addWaypoint [_exitpos,5000];
_WP setWaypointType "MOVE";

waituntil {sleep 5; ((_lead distance _pos) > 70000) || {((getposatl _jet1) select 2) < 20} || {time > _timeout}};

{

	{
	
		deletevehicle _x;
	
	} foreach crew _x;
	
	deletevehicle _x;

} foreach _jets;

deletegroup _group;

};