// Written by BON_IF
// Adpated by EightySix
// Urban sniper functions by K.Hunter



private ["_buildingheight","_sniper","_building","_highbuildings","_buildingxbound","_buildingybound","_position","_allunits","_snipers","_sniperlist","_buildings","_group","_rewardcount"];
if(!isServer) exitWith{};

_position = _this select 0;

_allunits = call compile format["mps_opfor_inf"];
_snipers = [];
_sniperlist = [];

/*
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


_buildings = nearestObjects [_position, ["Building"], 700];
_highbuildings = [];

{
    _buildingheight = ((boundingbox _x select 1) select 2);
        
        if(_buildingheight > 15) then {_highbuildings set [count _highbuildings, _x];};
           // if (count _highbuildings > 10) exitwith{};
                }foreach _buildings;

_group = createGroup (SIDE_B select 0);
sleep 0.1;
_group setvariable ["Hz_supporting",true];

{
                
		_sniper = _group createUnit ["TK_Soldier_SniperH_EP1",_position,[],0,"NONE"];
                sleep 0.1;
                _sniper setskill 1;
		_sniperlist set [count _sniperlist, _sniper];
                _sniper forcespeed 0;
                _sniper setvariable ["Hz_noMove",true];
                dostop _sniper;
        
} foreach _highbuildings;

_group setBehaviour "AWARE";
_group setCombatMode "YELLOW";


[-2, {
        {_x hideObject true;} foreach units _this;
    
        }, _group] call CBA_fnc_globalExecute;

{
_x setVariable ["ace_w_eh",0];
_building = (_highbuildings call BIS_fnc_selectRandom); // Select a random building from the array
_highbuildings = (_highbuildings - [_building]); // Delete the building from the array, so it wont get used again
_buildingheight = ((boundingbox _building select 1) select 2);
//_x disableai "move";
_buildingxbound = ((boundingbox _building select 1) select 0);
_buildingybound = ((boundingbox _building select 1) select 1);
_x setPosATL [(getPosATL _building select 0) + (_buildingxbound / 2), (getPosATL _building select 1) + (_buildingybound / 2), 50]; // Set the unit pos to 50 Above Terrain level, he will fall down onto the building
_x spawn {_this allowdamage false; sleep 15; _this allowdamage true; _this setVariable ["ace_w_eh",1];_this setUnitPos "MIDDLE"; dostop _this; _this forcespeed 0;}; // Prevent falling damage
} forEach _sniperlist;



[_group, _position] spawn {

private ["_group","_centerpos","_units","_leaderpos"];
_group = _this select 0;
_centerpos = _this select 1;
_group lockwp true;
_group enableAttack false;
_units = units _group;
sleep 16;

{if((getposatl _x select 2) < 10) then {
    
/*_marker = createMarker [format ["%1",random 1], position _x];
_marker setMarkerColor "ColorRed";
_marker setMarkerType "Vehicle";
_marker setMarkerText "Fail";    */    
deletevehicle _x; 
};}foreach _units;

sleep 1;
_units = units _group;
Hz_econ_aux_rewards = Hz_econ_aux_rewards + (Hz_econ_Sniper_reward*(count _units));

[-2, {
        {_x hideObject false;} foreach _this;
    
        }, _units] call CBA_fnc_globalExecute;

{_x forcespeed 0;}foreach _units;

};



/*

//DEBUG
[_group] spawn {

sleep 10;
_units = units (_this select 0);
_index = count _units;
for "_i" from 0 to _index do {
    
        player setposatl (getposatl (_units select _i));
        sleep 12;
            
                }; 


};

*/









/*
[_group] spawn {
    
	_units = units (_this select 0);
	_posgrp = position (leader (_this select 0));
	_hidetime = 100;
        _counter = 0;

	While{ ( {alive _x} count _units ) > 0 } do { 
            sleep 10; 
            _counter = _counter + 1; 
            if(_counter > 17280) exitwith {}; // if unit is glitched inside building make sure he gets deleted after about 48 hours
            };
      
        {
		if (alive _x) then {_x setdamage 1;};
		sleep 3;
		deleteVehicle _x;
	} foreach _units;

	sleep 5;

	deleteGroup (_this select 0);
};

*/

patrol_task_units = patrol_task_units + _sniperlist;


