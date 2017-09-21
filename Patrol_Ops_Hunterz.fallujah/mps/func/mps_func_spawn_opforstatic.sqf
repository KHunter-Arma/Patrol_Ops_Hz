// Written by EightySix
// Derived from BON_IF


private ["_side","_pos","_radius","_mg","_grp","_gunner","_ang","_a","_b","_mgpos"];
if(!isServer) exitWith {};
if(count _this < 1) exitWith{};

_originalPos = _this select 0;
_pos = _originalPos call mps_get_position;
_side = (SIDE_B select 0);

_INS = false;

if((count _this) > 1) then {
  
  if((_this select 1) == "INS") then {_INS = true;};        
  
};

sleep 0.5;
_ang = round random 360;
_radius = 30 + (random 40);
_a = (_pos select 0)+((sin(_ang))*_radius);
_radius = 30 + (random 40);
_b = (_pos select 1)+((cos(_ang))*_radius);
_mgpos = [ [_a,_b,0],10,1,2] call mps_getFlatArea;
_mg = objnull;
_grp = grpNull;

_dir = ([_mgpos,_originalPos] call BIS_fnc_DirTo) + 180;

if(not surfaceIsWater [_mgpos select 0, _mgpos select 1]) then{
  
  if (!Hz_enableStaticEmplacementCompositions) then {
    
    if(!_INS)then {
      
      _mg = (["DSHKM_TK_INS_EP1","DSHKM_TK_INS_EP1","DSHKM_TK_INS_EP1","KORD_high_UN_EP1","KORD_high_UN_EP1","SPG9_TK_INS_EP1","ZU23_TK_INS_EP1","ZU23_TK_INS_EP1","AGS_TK_INS_EP1","DSHKM_TK_INS_EP1","SPG9_TK_INS_EP1","AGS_TK_INS_EP1","KORD_high_UN_EP1","SPG9_TK_INS_EP1","ZU23_TK_INS_EP1","AGS_TK_INS_EP1","KORD_high_UN_EP1","Igla_AA_pod_TK_EP1","Metis_TK_EP1"] call mps_getRandomElement) createVehicle _mgpos;       

    } else {

      _mg = (["DSHKM_TK_INS_EP1","DSHKM_TK_INS_EP1","DSHKM_TK_INS_EP1","SPG9_TK_INS_EP1","ZU23_TK_INS_EP1","ZU23_TK_INS_EP1","DSHKM_TK_INS_EP1","SPG9_TK_INS_EP1","SPG9_TK_INS_EP1","ZU23_TK_INS_EP1","Igla_AA_pod_TK_EP1"] call mps_getRandomElement) createVehicle _mgpos;

    };
    
    _mg setdir _dir;
    
    _grp = createGroup (SIDE_B select 0);
    if(!_INS) then {(mps_opfor_riflemen call bis_fnc_selectrandom) createUnit [_mgpos, _grp ];} else {(mps_opfor_ins_riflemen call bis_fnc_selectrandom) createUnit [_mgpos, _grp ];};
    leader _grp moveInGunner _mg;
    _gunner = gunner _mg;
    
  } else {
    
    _compName = mps_opfor_staticWeaponComps call BIS_fnc_selectRandom;
    
    _comp = [_mgpos, _dir,(call compile preprocessfilelinenumbers (format ["Compositions\Opfor\Statics\%1.sqf",_compName]))] call BIS_fnc_ObjectsMapper;
    
    _units = [_comp, _INS] call Hz_func_initOpforComposition;
    
    _grp = group (_units select 0);
    
  };	
  
  
  
  /*
        
        [_grp] spawn {
    
  _units = units (_this select 0);
  _posgrp = position (leader (_this select 0));
  _hidetime = 100;

  While{ ( {alive _x} count _units ) > 0 } do { sleep 10; };
  while{ { alive _x && side _x == (SIDE_A select 0) } count nearestObjects[_posgrp,["CAManBase","LandVehicle"],800] > 0 } do { sleep 10; };
        sleep 1800;

  {
    hidebody _x;
    sleep 3;
    deleteVehicle _x;
  } foreach _units;

  sleep 5;

  deleteGroup (_this select 0);
        };
        */
  
};

_grp