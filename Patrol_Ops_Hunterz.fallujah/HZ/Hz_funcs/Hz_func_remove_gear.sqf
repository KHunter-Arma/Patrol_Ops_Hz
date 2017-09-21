private ["_i","_weapontype","_count","_magtype","_unit","_target","_gear","_weparray","_magarray"];

_unit = _this select 1;
_target = _this select 0;

_gear = [_unit] call Hz_func_listallweps;

_weparray = _gear select 0;
_magarray = _gear select 1;

if ("Laserdesignator" in (_weparray select 0)) then {(_magarray select 0) set [count (_magarray select 0),"Laserbatteries"];(_magarray select 1) set [count (_magarray select 1),1];};
if (("Binocular_Vector" in (_weparray select 0)) || ("ACE_YardAge450" in (_weparray select 0)) || ("ACE_Rangefinder_OD" in (_weparray select 0))) then {(_magarray select 0) set [count (_magarray select 0),"ACE_Battery_Rangefinder"];(_magarray select 1) set [count (_magarray select 1),1];};

 if(count (_weparray select 0) > 0) then {

    for [{_i=0},{_i<(count (_weparray select 0))},{_i=_i+1}] do {

    _weapontype = (_weparray select 0) select _i;
    _count = (_weparray select 1) select _i;

      if("ACRE_BaseRadio" in ([(configFile >> "CfgWeapons" >> _weapontype), true] call BIS_fnc_returnparents)) then {
      
      //ACRE classname correction
      if ("ACRE_PRC148_UHF" in ([(configFile >> "CfgWeapons" >> _weapontype), true] call BIS_fnc_returnparents) ) then {_weapontype = "ACRE_PRC148_UHF";} else { 
      if ("ACRE_PRC148" in ([(configFile >> "CfgWeapons" >> _weapontype), true] call BIS_fnc_returnparents) ) then {_weapontype = "ACRE_PRC148";} else {
      if ("ACRE_PRC343" in ([(configFile >> "CfgWeapons" >> _weapontype), true] call BIS_fnc_returnparents) ) then {_weapontype = "ACRE_PRC343";} else {
      if ("ACRE_PRC117F" in ([(configFile >> "CfgWeapons" >> _weapontype), true] call BIS_fnc_returnparents) ) then {_weapontype = "ACRE_PRC117F";};};};};
      };

    _target addweaponcargoglobal [_weapontype,_count];

    };      
};

 if (count (_magarray select 0) > 0) then {
  
    for [{_i=0},{_i<(count (_magarray select 0))},{_i=_i+1}] do {    
         _magtype = (_magarray select 0) select _i;
         _count = (_magarray select 1) select _i;

         _target addmagazinecargoglobal [_magtype,_count];

    };              
                    
};       


        removeallweapons _unit;
        removeallitems _unit;
        [_unit, "ALL"] call ACE_fnc_RemoveGear;
        [_unit,0,0,0,true] call ACE_fnc_PackIFAK;
        [_unit, ""] call ACE_fnc_PutWeaponOnBack;
