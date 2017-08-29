// Written by K.Hunter
// Derived from BON_IF & EightySix


private ["_side","_pos","_radius","_nocleanup","_mg","_grp","_gunner","_ang","_a","_b","_mgpos"];
if(!isServer) exitWith {};
if(count _this < 1) exitWith{};

_originalPos = _this select 0;
_pos = _originalPos call mps_get_position;
_side = (SIDE_B select 0);

_nocleanup = false;
_INS = false;

if((_this select 1) == "nocleanup") then {_nocleanup = true;} else {
    
	if((_this select 1) == "INS") then {_INS = true;};        
            
};

sleep 0.5;
_ang = round random 360;
_radius = 50 + (random 100);
_a = (_pos select 0)+((sin(_ang))*_radius);
_radius = 50 + (random 100);
_b = (_pos select 1)+((cos(_ang))*_radius);
_mgpos = [ [_a,_b,0],10,1,2] call mps_getFlatArea;
_mg = objnull;
_grp = grpNull;

_dir = ([_mgpos,_originalPos] call BIS_fnc_DirTo) + 180;

if(not surfaceIsWater [_mgpos select 0, _mgpos select 1]) then{
				
		_compName = mps_opfor_staticVehicleComps call BIS_fnc_selectRandom;
	
		_comp = [_mgpos, _dir,(call compile preprocessfilelinenumbers (format ["Compositions\Opfor\Vehicles\%1.sqf",_compName]))] call BIS_fnc_ObjectsMapper;
									
    [_comp] call Hz_func_initOpforComposition; 
        
};

Hz_econ_aux_rewards = Hz_econ_aux_rewards + Hz_econ_StaticVehicle_reward;

if(!_nocleanup) then {
patrol_task_units = patrol_task_units + (units _grp);
{if(!((vehicle _x) in patrol_task_vehs)) then {patrol_task_vehs = patrol_task_vehs + [vehicle _x];};}foreach units _grp;
};