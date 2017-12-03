


_target = _this select 0;

_marker = createMarkerLocal ["radiationmarker", position _target];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerSizeLocal [1000, 1000];
_marker setMarkerColorLocal "ColorRed";

_marker2 = createMarkerLocal ["radiationmarker2", position _target];
_marker2 setMarkerShapeLocal "Icon";
_marker2 setMarkerTypeLocal "Dot";
_marker2 setMarkerColorLocal "ColorYellow";
_marker2 setMarkerTextLocal "  Nuclear Radiation";


[_target] Spawn {
	Private ["_dammageable","_target"];
	_target = _this select 0;
	_dammageable = ["Man","Car","Motorcycle","Tank","Ship","Air","StaticWeapon"];
	for [{_x = 0},{_x < 300},{_x = _x + 1}] do {
		if (player distance _target < 1000) then {hintsilent parseText "<t color='#ff3300' size='2.0' shadow='1' shadowColor='#000000' align='center'>RADIATION ZONE</t>"; player say "radzoneb"};
		_array = _target nearEntities [_dammageable, 1000];
		{
			_x setDammage (getDammage _x +  0.03);
			{_x setDammage  (getDammage _x + 0.05)} forEach crew _x;
		} forEach _array;
		_range = _range + 300;
		sleep 3;
	};
	deleteVehicle _target;
	deletemarkerlocal "radiationmarker";
	deletemarkerlocal "radiationmarker2";
	"dynamicBlur" ppEffectEnable false;
	"colorCorrections" ppEffectEnable false;
	deletevehicle nukepos;
	hint "Nuclear Bomb Is available again";
	nukev=true;
};

