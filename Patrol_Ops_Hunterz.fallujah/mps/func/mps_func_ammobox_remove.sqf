// Written by EightySix

private["_position","_nearestboxes"];

	if(count _this == 0) exitWith{};

	_position = (_this select 0) call mps_get_position;

	_nearestboxes = nearestObjects [_position,[mission_mobile_ammo],5];

	if(count _nearestboxes > 0) then {

		_box = (_nearestboxes select 0);

		_marker = _box getVariable "box_marker";

		if(!isNil "_marker") then {deleteMarker _marker};

		deleteVehicle _box;

	};
