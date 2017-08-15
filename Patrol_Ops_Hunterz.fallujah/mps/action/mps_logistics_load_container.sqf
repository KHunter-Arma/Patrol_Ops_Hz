// Written by EightySix
/*
private["_offset"];

if(isNil "mps_lock_action") then { mps_lock_action = false; };
if (mps_lock_action) then {
	hint "The current operation isn't finished.";
}else{

	mps_lock_action = true;

	_container = _this select 0;
	_position = position _container;
	_vehicle = (nearestObjects [_position,mps_transports,8]) select 0;
	_type = getText (configFile >> "CfgVehicles" >> typeof _vehicle >> "displayName");

	_loaded = _vehicle getVariable "mps_loadable";

	if(if(isNil "_loaded") then {false} else {_loaded}) exitWith { hint format["The %1 is already loaded with a container",_type] };
	if(!canMove _vehicle) exitWith { hint format["The %1 is crippled and cannot be loaded",_type] };

	player playMove "ActsPercSnonWnonDnon_carFixing2";

//	if( {side _x == side player} count nearestObjects [_position,["MAN"],6] <= 1) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon"; hint "Good for you, thinking you alone can lift a whole container. But you might need some more help.";};
//	if( {side _x == side player} count nearestObjects [_position,["MAN"],6] < 4) exitWith {player playMoveNow "AmovPercMstpSlowWrflDnon"; hint "You will need some more help to lift this onto the truck. 4 Men should do it.";};

	sleep 8;

	if(!alive player) exitWith{player playMoveNow "AmovPercMstpSlowWrflDnon"; mps_lock_action = false;};

	_offset = [_container,_vehicle] call mps_object_offset;

	_container attachto [_vehicle,_offset];
	_container setvariable ["mps_loadable",true,true];
	_vehicle setvariable ["mps_loadable",true,true];

	player playMoveNow "AmovPercMstpSlowWrflDnon";

	mps_lock_action = false;

	while{canMove _vehicle && _container getVariable "mps_loadable"} do {sleep 1};

	detach _container;

	_vehiclerightside = (_vehicle modelToWorld [3.5,-2,0]); _vehiclerightside set [2,0];

	_container setPos _vehiclerightside;
	_container setvariable ["mps_loadable",false,true];
	_vehicle setvariable ["mps_loadable",false,true];
};

*/