// Written by Xeno
// Adpated by EightySix

private ["_vehicle","_caller","_id"];

_vehicle = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_nearest = _this select 3;

_loaded = (_nearest select 0) getVariable "mps_loadable";


if( {alive _x} count (crew (_nearest select 0)) > 0) exitWith {Hint format["The vehicle is not empty: %1 in Crew", count crew (_nearest select 0) ]};

if( if(isNil "_loaded") then { false } else { _loaded } ) exitWith { hint "The vehicle is too heavy to lift."; };

if (_caller == driver _vehicle) then {

	_vehicle removeAction _id;

	Vehicle_Attached = true;

};

if (true) exitWith {};