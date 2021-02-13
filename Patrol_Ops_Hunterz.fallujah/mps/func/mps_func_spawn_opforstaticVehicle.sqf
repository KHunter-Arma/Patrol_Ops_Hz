// Written by K.Hunter
// Derived from BON_IF & EightySix


private ["_originalPos", "_side", "_INS", "_ang", "_radius", "_a", "_b", "_mgpos", "_mg", "_grp", "_dir", "_compName", "_comp", "_pos", "_units"];

if(!(call Hz_fnc_isTaskMaster)) exitWith {};
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
_radius = 50 + (random 100);
_a = (_pos select 0)+((sin(_ang))*_radius);
_radius = 50 + (random 100);
_b = (_pos select 1)+((cos(_ang))*_radius);
_mgpos = [ [_a,_b,0],10,1,2] call mps_getFlatArea;
_mg = objnull;
_grp = grpNull;

_dir = ([_mgpos,_originalPos] call BIS_fnc_DirTo) + 180;

if(not surfaceIsWater [_mgpos select 0, _mgpos select 1]) then{
				
		_compName = mps_opfor_staticVehicleComps call mps_getrandomelement;
	
		_comp = [_mgpos, _dir,(call compile preprocessfilelinenumbers (format ["Compositions\Opfor\Vehicles\%1.sqf",_compName]))] call BIS_fnc_ObjectsMapper;
									
    _units = [_comp] call Hz_func_initOpforComposition; 
    
    _grp = group (_units select 0);
        
};

_grp