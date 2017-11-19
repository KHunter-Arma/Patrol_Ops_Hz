// Written by BON_IF
// Adpated by EightySix

if(not local player) exitWith{};

_vehicle = _this select 0;
_boxloaded = _vehicle getVariable "vehicle_ammobox";

if(if(isNil "_boxloaded") then {true} else {not _boxloaded}) then{
	hint format["%1",localize "STR_Client_ammobox_load"];
	_time = time;
	WaitUntil{ time > _time + 5 ||  (getPos _vehicle select 2) > 2 || isNull driver _vehicle || speed _vehicle > 1 || speed _vehicle < -1};
	if( time <= _time + 5) exitWith {
		hint format["%1",localize "STR_Client_ammobox_cancel"];
	};

	_vehicle setVariable ["vehicle_ammobox",true,true];
	_nearestboxes = nearestObjects [position _vehicle,[mission_mobile_ammo],5];
	if(count _nearestboxes > 0) then {
		mps_remove_ammobox = [playerSide,position (_nearestboxes select 0)]; publicVariable "mps_remove_ammobox"; [position (_nearestboxes select 0)] spawn mps_ammobox_remove;
	};
	hint format["%1",localize "STR_Client_ammobox_done"];
}else{
	hint format["%1",localize "STR_Client_ammobox_void"];
};

if(true) exitWith {};