#define MINIMUM_KNOW 1

private ["_civ","_side","_targetSide","_grp"];

_civ = _this select 0;
_side = _this select 1;
_targetSide = _this select 2;

_grp = createGroup _side;
[_civ] joinSilent _grp;
_civ setunitpos "UP";

sleep 1;

while {alive _civ} do {

  _civ setCaptive true;
	
	//apparently we need something like this in Arma 3 to force him to holster weapon...
	_civ action ['SwitchWeapon', _civ, _civ, -1];

  waitUntil {
    
    sleep 5;
    
    (({((side _x) == _targetSide) && ((vehicle _x) == _x) && ((_civ knowsAbout _x) >= MINIMUM_KNOW)} count (nearestobjects [_civ, ["CAManBase"], 50])) > 0)
    || !alive _civ

  };

	//add some random intensity
  sleep (random 10);
	
	_civ setCaptive false;
  _grp setvariable ["Hz_AI_lastTrueDangerTime",time];
  _grp setvariable ["Hz_AI_lastDangerTime",time];
  _grp setCombatMode "COMBAT";
	_civ action ['SwitchWeapon', _civ, _civ, 0];
  
  waitUntil {
  
  sleep 10;
  
  (!alive _civ) || ((behaviour _civ) == "SAFE")
  
  };

};