// Written by EightySix

private["_position","_type"];

	if(mps_a2) then {_type = "Misc_Cargo1B_military"};
	if(mps_oa) then {_type = "Land_Misc_Cargo1E_EP1"};
	
	_type = "Misc_Cargo1B_military";

	if(count _this < 1 || isNil "_type") exitWith {hint "Container Create Error";};

	_position = (_this select 0) call mps_get_position;

	_container = _type createVehicle [_position select 0, _position select 1, 0];
	_container setVariable ["mps_loadable",false,true];
	_container setVariable ["mps_liftable",true,true];

_container;