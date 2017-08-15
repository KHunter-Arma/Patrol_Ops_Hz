// Written by BON_IF
// Adpated by EightySix

private ["_Grp","_type","_side","_vec","_unit","_pos","_radius","_count","_spawnpos"]; 

_type = _this select 0;
_side = _this select 1;
_pos = _this select 2;
_radius = _this select 3;

_nocleanup = false;
if(_this select 4 == "nocleanup") then {_nocleanup = true;};

_flying = false;

if (_type iskindof "Air") then {_flying = true;};

_Grp = grpNull;
if (count _this > 4) then {_Grp = _this select 4;}else{_Grp = createGroup (SIDE_B select 0);};

_x = _pos select 0;
_y = _pos select 1;



_spawnpos = [0,0];
_count = 0;
While{(surfaceIsWater _spawnpos || count (_spawnpos - [0]) == 0) && _count < 100} do {
	_spawnpos = [_x + _radius - random (_radius*2), _y + _radius - random (_radius*2)];
	_count = _count + 1;
};
if(_count == 100) exitWith{_Grp};
_spawnpos set [2,0];

if(!_flying) then {_vec = _type createVehicle _spawnpos;
_vec setvehiclelock "LOCKED";

_crewtype = getArray (configFile >> "CfgVehicles" >> _type >> "typicalCargo");
_max = (count _crewtype)-1;

if(count(_crewtype - ["Soldier"] - ["SoldiereCrew"])==0) then{
	if(_side==EAST) then{_crewtype = ["TK_Soldier_EP1"]}
	else {_crewtype = ["US_Soldier_EP1"]};
};

if((_vec emptyPositions "commander") > 0) then {
	_unit = _Grp createUnit [_crewtype select (round random _max), _pos, [], _radius, "NONE"];
        _unit setSkill 0.4;
        _unit setskill ["aimingSpeed",0.8];
        _unit setskill ["spotDistance",1];
        _unit setskill ["spotTime",1];
        _unit setskill ["commanding",1];
	_unit assignasCommander _vec;
        [_unit] orderGetIn true;
        _unit moveinCommander _vec;
				_unit setrank "PRIVATE";
};

if((_vec emptyPositions "gunner") > 0) then {
	_unit = _Grp createUnit [_crewtype select (round random _max), _pos, [], _radius, "NONE"];
        _unit setSkill 0.4;
        _unit setskill ["aimingSpeed",0.8];
        _unit setskill ["spotDistance",1];
        _unit setskill ["spotTime",1];
        _unit setskill ["commanding",1];
	_unit assignasGunner _vec;
        [_unit] orderGetIn true;
        _unit moveinGunner _vec;
				_unit setrank "PRIVATE";
};		

if((_vec emptyPositions "driver") > 0) then {
	_unit = _Grp createUnit [_crewtype select (round random _max), _pos, [], _radius, "NONE"];
        _unit setSkill 0.4;
        _unit setskill ["aimingSpeed",0.8];
        _unit setskill ["spotDistance",1];
        _unit setskill ["spotTime",1];
        _unit setskill ["commanding",1];
	_unit assignasDriver _vec;
        [_unit] orderGetIn true;
        _unit moveinDriver _vec;
				_unit setrank "PRIVATE";
        
};

if(((_vec emptyPositions "cargo") == 1) && _vec iskindof "Tank") then {
	_unit = _Grp createUnit [_crewtype select (round random _max), _pos, [], _radius, "NONE"];
        _unit setSkill 0.4;
        _unit setskill ["aimingSpeed",0.8];
        _unit setskill ["spotDistance",1];
        _unit setskill ["spotTime",1];
        _unit setskill ["commanding",1];
	_unit assignasCargo _vec;
        [_unit] orderGetIn true;
        _unit moveinCargo _vec;
				_unit setrank "PRIVATE";
        
};


} else {
    
_airspawnpos = [-20000,140000,800];        
             
_vec = ([_airspawnpos, random 360, _type, _Grp] call BIS_fnc_spawnVehicle) select 0;
_vec setvehiclelock "locked";
sleep 1;

{_x setrank "PRIVATE";} foreach (crew _vec);

if(_vec iskindof "Plane") then {

if(_vec iskindof "GLT_Su24Fencer_TK") then {_vec flyinheight 1500;} else {_vec flyinheight 300;};

} else {
    
_vec flyinheight 100;

};



{       
        _x setSkill 0.4;
        _x setskill ["aimingSpeed",0.8];
        _x setskill ["spotDistance",1];
        _x setskill ["spotTime",1];
        _x setskill ["commanding",1];}foreach (crew _vec);
   
   
   //Reveal targets for CAS
[_vec,3500] execVM "HZ\HZ_scripts\HZ_AI_CAS.sqf";
   
};





/*

// Cleanup

[_Grp,_vec] spawn {
    
	_grp = _this select 0;
	_units = units _grp;
	_veh = _this select 1;

	_vehpos = position _veh;

	While{ damage _veh < 1 && ({alive _x} count _units) > 0 } do { sleep 20; };

	while{ { alive _x && side _x == (SIDE_A select 0) } count nearestObjects[_vehpos,["CAManBase","LandVehicle"],800] > 0 } do { sleep 15; };
        
        sleep 600;
        _veh setdamage 0.9;
        sleep 1800;
        if (alive _veh) then {_veh setdamage 0.98; sleep 300;};
        
	deleteVehicle _veh;

	{
		hidebody _x;
		sleep 3;
		deleteVehicle _x;
	} foreach _units;

	sleep 5;

	deleteGroup _grp;
};
*/


if(!_nocleanup) then {
patrol_task_units = patrol_task_units + (units _Grp);
{if(!((vehicle _x) in patrol_task_vehs)) then {patrol_task_vehs = patrol_task_vehs + [vehicle _x];};}foreach units _Grp;
};
_Grp