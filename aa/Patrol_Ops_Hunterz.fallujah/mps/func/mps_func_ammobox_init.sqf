// Written by EightySix
/*
if(isDedicated) exitWith{};

private["_position","_ammobox"];

	if(count _this == 0) exitWith{};

	_position = (_this select 0) call mps_get_position;

	_boxid = format["AMMOBOX%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

	_boxmarker = createMarkerlocal [format["%1",_boxid],_position];

	_boxmarker setmarkerTypelocal "mil_marker";

	switch (playerside) do{

		case west: {_boxmarker setMarkerColorlocal "ColorBlue";};

		case east: {_boxmarker setMarkerColorlocal "ColorRed"; };

		default {_boxmarker setMarkerColorlocal "ColorGreen"; };

	};

	_boxmarker setMarkerTextlocal " ammo";

	_boxmarker setMarkerSizelocal [0.5,0.5];

	_ammobox = mission_base_ammobox createVehiclelocal _position;

	_ammobox setPos _position;

	_ammobox setVariable ["box_marker",_boxmarker,false];

	[_ammobox] spawn mps_fill_ammobox;

_ammobox

*/