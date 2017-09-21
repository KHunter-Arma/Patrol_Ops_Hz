// Written by EightySix

private["_type","_side","_position","_vehicle"];

	_type = _this select 0; 
	_side = _this select 1;

	_position = getMarkerPos format["respawn_mhq_%1",_side];

	_vehicle = _type createvehicle _position; sleep 0.125;

	_vehicle setVariable ["mhq_side",_side,true];
	_vehicle setVariable ["mhq_status",false,true];
	_vehicle setVariable ["liftable",true,true];
	_vehicle setDir 218.738;

	sleep 1;

	[_vehicle] spawn mps_mhq_toggle;