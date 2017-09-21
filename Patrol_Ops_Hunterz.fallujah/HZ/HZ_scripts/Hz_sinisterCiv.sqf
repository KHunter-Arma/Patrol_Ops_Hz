#define MINIMUM_KNOW 1

private ["_civ","_side","_targetSide","_grp"];

_civ = _this select 0;
_side = _this select 1;
_targetSide = _this select 2;

_grp = createGroup _side;
[_civ] joinSilent _grp;
_civ setunitpos "UP";

while {alive _civ} do {

  _civ setCaptive true;

  waitUntil {
    
    sleep 30;
    
    (({((side _x) == _targetSide) && ((vehicle _x) == _x) && ((_civ knowsAbout _x) >= MINIMUM_KNOW)} count (nearestobjects [_civ, ["CAManBase"], 50])) > 1)
    || !alive _civ

  };

  _civ setCaptive false;
  _grp setvariable ["Hz_AI_lastTrueDangerTime",time];
  _grp setvariable ["Hz_AI_lastDangerTime",time];
  _grp setCombatMode "COMBAT";
  
  sleep 1;
  
  waitUntil {
  
  sleep 10;
  
  (!alive _civ) || ((behaviour _civ) == "SAFE")
  
  };

};