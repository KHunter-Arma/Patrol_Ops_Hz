
hintsilent "Function is not yet implemented in Patrol Ops Hunter'z";

/*

_crate = _this select 0;
_radios = [];

_weparray = getweaponcargo _crate;

{
   if("ACRE_BaseRadio" in ([(configFile >> "CfgWeapons" >> _x), true] call BIS_fnc_returnparents)) then {
      
      //ACRE classname correction
      if ("ACRE_PRC148_UHF" in ([(configFile >> "CfgWeapons" >> _x), true] call BIS_fnc_returnparents) ) then {_wep = "ACRE_PRC148_UHF";} else { 
      if ("ACRE_PRC148" in ([(configFile >> "CfgWeapons" >> _x), true] call BIS_fnc_returnparents) ) then {_wep = "ACRE_PRC148";} else {
      if ("ACRE_PRC343" in ([(configFile >> "CfgWeapons" >> _x), true] call BIS_fnc_returnparents) ) then {_wep = "ACRE_PRC343";} else {
      if ("ACRE_PRC117F" in ([(configFile >> "CfgWeapons" >> _x), true] call BIS_fnc_returnparents) ) then {_wep = "ACRE_PRC117F";};};};};
      }; 
        
            }foreach (_weparray select 0);
            
            
            */