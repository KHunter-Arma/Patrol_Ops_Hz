// Written by BON_IF
// Adpated by EightySix
// Re-written by K.Hunter for urban sniper functionality

private ["_buildings", "_position", "_radius", "_highbuildings", "_buildingheight", "_maxHeight", "_sniper", "_sniperlist", "_building", "_bpos", "_noHPosFound", "_hPos", "_maxH", "_buildingxbound", "_buildingybound", "_signx", "_signy", "_debug", "_marker", "_group", "_units"];

if(!(call Hz_fnc_isTaskMaster)) exitWith{};

_position = _this select 0;
_radius = 350;
_maxHeight = 15;
_debug = false;

if ((count _this) > 1) then {_radius = _this select 1;};
if ((count _this) > 2) then {_maxHeight = _this select 2;};


_sniperlist = [];

/*
_allunits = call compile format["mps_opfor_inf"];
_snipers = [];

{
  _camouflage = getnumber (configfile >> "CfgVehicles" >> _x >> "camouflage");
  if(_camouflage < 1) then{_snipers = _snipers + [_x]};
} foreach _allunits;
if(count _snipers == 0) exitWith{};
*/



/*
_heights = nearestLocations [_position,["Mount"],500];

_helih = "HeliHEmpty" createVehicleLocal _position;
_locationheight = (getposASL _helih) select 2;
{
  _helih setpos position _x;
  _heightasl = (getposASL _helih) select 2;

  if(_heightasl - _locationheight > 20) then {
    _group = createGroup (SIDE_B select 0);
    _sniper = _group createUnit [_snipers call mps_getRandomElement,_position,[],0,"NONE"];
                _sniper setskill 0.8;
                _sniper disableai "move";
    _group setBehaviour "COMBAT";
    (_group addWaypoint [position _helih,0]) setWaypointType "HOLD";

    _group spawn {
      while{count units _this > 0} do {sleep 60};
      deletegroup _this;
    };
    _sniperlist = _sniperlist + [_sniper];
  };
} foreach _heights;


deleteVehicle _helih;*/


_buildings = nearestObjects [_position, ["Building"], _radius];
_highbuildings = [];

{
  _buildingheight = (((boundingboxreal _x) select 1) select 2)*2;
  
  if(_buildingheight > _maxHeight) then {_highbuildings set [count _highbuildings, _x];};
  // if (count _highbuildings > 10) exitwith{};
}foreach _buildings;

_group = createGroup (SIDE_B select 0);
sleep 0.1;
_group setvariable ["Hz_supporting",true];
_group setvariable ["Hz_noBehaviour",true];

{
  
  _sniper = _group createUnit [(mps_opfor_sniper call mps_getrandomelement),_position,[],0,"NONE"];
  sleep 0.1;
  _sniper setskill 1;
  _sniperlist set [count _sniperlist, _sniper];
  _sniper forcespeed 0;
  _sniper setvariable ["Hz_noMove",true];
  dostop _sniper;
  
} foreach _highbuildings;

_group setBehaviour "COMBAT";
_group setCombatMode "YELLOW";
_group deleteGroupWhenEmpty true;


[-2, {
  {_x hideObject true;} foreach units _this;
  
}, _group] call CBA_fnc_globalExecute;

{
  _building = (_highbuildings call mps_getrandomelement); // Select a random building from the array
  _highbuildings = (_highbuildings - [_building]); // Delete the building from the array, so it wont get used again
	
	_bpos = [_building] call BIS_fnc_buildingPositions;
	_noHPosFound = false;
	
	if ((count _bpos) > 0) then {
		
		_hPos = [0,0,0];
		_maxH = 0;
	
		{
		
			if ((_x select 2) >= _maxH) then {
			
				_hPos = _x;
				_maxH = _x select 2;
			
			};
		
		} foreach _bpos;	
		
		if (_maxH >= _maxHeight) then {
		
			_x setposatl _hPos;
		
		} else {
		
			_noHPosFound = true; 
		
		};
	
	}; 	
	
	if (_noHPosFound) then {
	
		_buildingheight = ((boundingboxreal _building select 1) select 2)*2;
		_buildingxbound = ((boundingboxreal _building select 1) select 0);
		_buildingybound = ((boundingboxreal _building select 1) select 1);
		
		_signx = if ((random 1) < 0.5) then {1} else {-1};
		_signy = if ((random 1) < 0.5) then {1} else {-1};
		
		_x setPosATL [(getPosATL _building select 0) + ((_buildingxbound / 2)*_signx), (getPosATL _building select 1) + ((_buildingybound / 2)*_signy), _buildingheight + 50];
		_x spawn {_this setVariable ["ace_medical_allowDamage",false]; _this allowdamage false; sleep 15; _this allowdamage true; _this setVariable ["ace_medical_allowDamage",true];_this setUnitPos "MIDDLE";}; // Prevent falling damage
		
	};	
	
} forEach _sniperlist;


//_group lockwp true;
//_group enableAttack false;
_units = units _group;
sleep 16;

{

if((getposatl _x select 2) < 10) then {

if (_debug) then {

_marker = createMarker [format ["%1",random 1], position _x];
_marker setMarkerColor "ColorRed";
_marker setMarkerType "hd_dot";
_marker setMarkerText "Fail";     

};
   
    deletevehicle _x; 
		
};
	
}foreach _units;

sleep 1;
_units = units _group;

[-2, {
  {_x hideObject false;} foreach _this;
  
}, _units] call CBA_fnc_globalExecute;





//DEBUG
if (_debug) then {
[_group] spawn {

sleep 10;
_units = units (_this select 0);
_index = count _units;
for "_i" from 0 to _index do {
    
        player setposatl (getposatl (_units select _i));
        sleep 12;
            
                }; 


};

};

_group