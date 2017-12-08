//if(isnull heli_radar) exitwith {};
//if(!alive heli_radar) exitwith {};


private ["_targetpos","_group","_jettype","_bombTypes","_jet1"];
_targetpos = [(_this select 0) select 0, (_this select 0) select 1, ((_this select 0) select 2) + 1000];

_group = creategroup (_this select 1);
_jettype = _this select 2;
_bombTypes = _this select 3;

//_jet1 = ([[(position heli_radar select 0)+20000,(position heli_radar select 1)+22000,2000], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;

_jet1 = ([[-20000,22000,2000], 225, _jettype, _group] call BIS_fnc_spawnVehicle) select 0;

_jet1 flyinheight 1000;
{_x disableai "autotarget";_x disableai "fsm"; _x disableai "target";}foreach crew _jet1;

[_jet1, _targetpos,_bombTypes] spawn {

  
private ["_jet","_pos","_bombTypes","_lead","_gunner","_group","_dir","_exitpos"];
_jet = _this select 0;
  _pos = _this select 1;
  _bombTypes = _this select 2;
  _lead = driver _jet;
  _gunner = gunner _jet;
  _group = group _lead;

  _group move _pos;

  sleep 3;
  _jet flyInHeight 1000;

  waituntil {uisleep 0.1; ((_jet distance _pos) < 4000) || (((getposatl _jet) select 2) < 20)};
  if (((getposatl _jet) select 2) < 20) exitwith {};


  //anti-dive...  
  _lead disableai "move";
  _dir = vectordir _jet;
  _jet setvariable ["correction",true];
  [_jet,_dir] spawn {
private ["_jet","_dir"];
_jet = _this select 0; _dir = _this select 1; while {_jet getvariable "correction"} do {_jet setvectordirandup [_dir,[0,0,1]];};
  };

  for "_i" from 1 to 36 do {

    {
      _gunner fireAtTarget [objnull, _x];
      uisleep 0.025;
      _jet setWeaponReloadingTime [_gunner, _x, 0];

    } foreach _bombTypes;


  };

  _lead enableai "move";
  _jet setvariable ["correction",false];

  _exitpos = [30000,30000,7000];

  _group move _exitpos;

  //anti-dive loop
  for "_i" from 1 to 70 do {  
    _jet setVectorUp [0,0,1];
    uisleep 0.05;
  };

  _jet flyInHeight 7000;

  waituntil {sleep 3; if( ((getposatl _jet)select 2) < 6000) then {_jet flyInHeight 7000;}; ((_jet distance _exitpos) < 5000) || (((getposatl _jet) select 2) < 20)};

  {deletevehicle _x;}foreach crew _jet;
  deletevehicle _jet;
  sleep 1;
  deletegroup _group;

};