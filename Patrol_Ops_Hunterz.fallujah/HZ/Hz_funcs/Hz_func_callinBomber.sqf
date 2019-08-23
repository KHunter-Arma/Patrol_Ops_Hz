#define H_SPEED 70
#define V_SPEED 260

//if(isnull heli_radar) exitwith {};
//if(!alive heli_radar) exitwith {};

private ["_targetpos","_group","_jettype","_bombTypes","_jet1"];
_targetpos = [(_this select 0) select 0, (_this select 0) select 1, ((_this select 0) select 2) + 1000];

_jettype = _this select 2;
_bombTypes = _this select 3;

if (isnil "_jettype") exitwith {};
if (isnil "_bombTypes") exitwith {};
if ((count _bombTypes) < 1) exitwith {};

_group = grpNull;
_jet1 = objNull;

if ((typeName _jettype) == "OBJECT") then {

	_jet1 = _jettype;
	_vel = velocity _jet1;
	_vel = [_vel select 0,_vel select 1,0];
	_jet1 setposatl [-20000,22000,2000];
	_jet1 setdir 225;
	_jet1 setVelocity _vel;
	_group = group _jet1;

} else {

	_group = creategroup (_this select 1);
	_jet1 = ([[-20000,22000,2000], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;
	//_jet1 = ([[(position heli_radar select 0)+20000,(position heli_radar select 1)+22000,2000], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;

};

_jet1 flyinheight 1000;
_jet1 forcespeed 2000;

{

	_x disableai "AUTOTARGET";
	_x disableai "FSM";
	_x disableai "TARGET";
	_x disableai "AUTOCOMBAT";	

}foreach crew _jet1;

_jet1 setvariable ["Hz_disableFSM",true];
_group setbehaviour "AWARE";
_group setCombatMode "GREEN";
_group setvariable ["Hz_noBehaviour",true];

_group deleteGroupWhenEmpty true;

_weps = weapons _jet1;
{

	if (!(_x in _weps)) then {
	
		_jet1 addWeapon _x;		
	
	};
	
	_jet1 addMagazines [(getarray (configFile >> "cfgWeapons" >> _x >> "magazines")) select 0,24];

} foreach _bombTypes;

[_jet1, _targetpos,_bombTypes] spawn {

  
private ["_jet","_pos","_bombTypes","_lead","_gunner","_group","_dir","_exitpos"];
_jet = _this select 0;
  _pos = _this select 1;
  _bombTypes = _this select 2;
  _lead = driver _jet;
  _gunner = gunner _jet;
  _group = group _lead;

  _WP = _group addWaypoint [_pos,500];
	_WP setWaypointType "MOVE";

  sleep 3;
	{_x setSkill 1}foreach crew _jet;
  _jet flyInHeight 1000;
	
	waituntil {uisleep 0.1; ((_jet distance _pos) < 10000) || (((getposatl _jet) select 2) < 20)};
	
	//allow this heavy fucker to turn...
	_jet forceSpeed -1;

	//height correction...
	_jetpos = getposatl _jet;
	if ((abs (1000 - (_jetpos select 2))) > 100) then {
	
		_vel = velocity _jet;
		
		_jet setposatl [_jetpos select 0, _jetpos select 1,1000];
		_jet setVelocity _vel;
		sleep 0.1;
		_jet flyinheight 1000;
	
	};

  waituntil {uisleep 0.1; ((_jet distance _pos) < 4000) || (((getposatl _jet) select 2) < 20)};
  if (((getposatl _jet) select 2) < 20) exitwith {};
	
	//heading correction...
	_speed = velocity _jet;
	_speed = sqrt ((_speed select 0)^2 + (_speed select 1)^2);
	_truedir = [_jet,_pos] call BIS_fnc_dirTo;
	_jet setdir _truedir;
	uisleep 0.1;
	_jet setVelocity [_speed*(sin _truedir),_speed*(cos _truedir),0];
	_jet setVariable ["bombVel",[H_SPEED*(sin _truedir),H_SPEED*(cos _truedir),-V_SPEED]];

  //anti-dive...  
  _lead disableai "move";
  _jet setvariable ["correction",true];
  _jet spawn {
	
			private "_jet";
			_jet = _this;
			_dir = getdir _jet;			
			_vel = velocity _jet;
			_vel = [_vel select 0, _vel select 1,0];
			
			while {_jet getvariable "correction"} do {
			
			_jet setvectorup [0,0,1];	
			_jet setdir _dir;
			_jet setVelocity _vel;
			
			};  
	};
	
	_EH = _jet addEventHandler ["Fired",{
	
		(_this select 6) setVelocity [0,0,-1];
		(_this select 6) setVelocity ((_this select 0) getVariable "bombVel");		
	
	}];

  for "_i" from 1 to 24 do {

    {
      _gunner fireAtTarget [objnull, _x];
      //uisleep 0.025;
				uisleep 0.15;
      _jet setWeaponReloadingTime [_gunner, _x, 0];

    } foreach _bombTypes;


  };

  _lead enableai "move";
  _jet setvariable ["correction",false];

  _exitpos = [30000,30000,7000];

  _WP = _group addWaypoint [_exitpos,5000];
	_WP setwaypointtype "MOVE";
	_jet forcespeed 2000;

  //anti-dive loop
	_vel = velocity _jet;
	_vel = [_vel select 0,_vel select 1,0];
  for "_i" from 1 to 70 do {  
    _jet setVectorUp [0,0,1];
		_jet setVelocity _vel;
    uisleep 0.05;
  };
	
	_jet removeEventHandler ["Fired",_EH];

  _jet flyInHeight 7000;
	
	_timeout = time + 300;

  waituntil {sleep 3; ((_jet distance _pos) > 70000) || {((getposatl _jet) select 2) < 20} || {time > _timeout}};

  {
		_jet deletevehicleCrew _x;	
	}foreach crew _jet;
	
  deletevehicle _jet;
  sleep 1;
  deletegroup _group;

};