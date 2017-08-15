
_unit = _this select 0;
_type = _this select 1;

_objects = nearestobjects [_unit,[_type],30];
_return = objNull;


if(count _objects > 0) then {_return = _objects select 0;};

_return