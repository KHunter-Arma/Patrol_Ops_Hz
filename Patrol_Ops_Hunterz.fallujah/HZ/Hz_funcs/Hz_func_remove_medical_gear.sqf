private ["_i","_weapontype","_count","_magtype","_unit","_target","_gear","_weparray","_magarray","_medicalweps","_medicalmags"];

_medicalweps = ["cms_firstaidkit","ACE_Stretcher"];
_medicalmags = ["ACE_Bandage","ACE_LargeBandage","ACE_Morphine","ACE_Epinephrine","ACE_Medkit","ACE_Tourniquet",
"cms_bandage_basic",
"cms_packing_bandage",
"cms_tourniquet",
"cms_splint",
"cms_morphine",
"cms_epinephrine",
"cms_plasma_iv",
"cms_blood_iv",
"cms_saline_iv",
"cms_quikclot",
"cms_nasopharyngeal_tube",
"cms_plasma_iv_500",
"cms_blood_iv_500",
"cms_saline_iv_500",
"cms_plasma_iv_250",
"cms_blood_iv_250",
"cms_saline_iv_250",
"cms_opa",
"cms_bandageElastic",
"cms_liquidSkin",
"cms_chestseal",
"cms_atropine"];

_unit = _this select 1;
_target = _this select 0;

_gear = [_unit] call Hz_func_listallweps;

_weparray = _gear select 0;
_magarray = _gear select 1;

 if(count (_weparray select 0) > 0) then {

    for [{_i=0},{_i<(count (_weparray select 0))},{_i=_i+1}] do {

    _weapontype = (_weparray select 0) select _i;
    _count = (_weparray select 1) select _i;

    if(_weapontype in _medicalweps) then {

    _target addweaponcargoglobal [_weapontype,_count];
    _unit removeweapon _weapontype;
    [_unit, "WEP", _weapontype, -1] call ACE_fnc_RemoveGear;
        };
    };      
};

 if (count (_magarray select 0) > 0) then {
  
    for [{_i=0},{_i<(count (_magarray select 0))},{_i=_i+1}] do {    
         _magtype = (_magarray select 0) select _i;
         _count = (_magarray select 1) select _i;

         if(_magtype in _medicalmags) then {
         _target addmagazinecargoglobal [_magtype,_count];
         _unit removeMagazines _magtype;
         [_unit, "MAG",_magtype,-1] call ACE_fnc_RemoveGear;
         };
         
    };              
                    
};       
  
  [_unit,0,0,0,true] call ACE_fnc_PackIFAK;
