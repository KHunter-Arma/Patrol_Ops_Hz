if (!isServer) exitwith {};

_carrier = _this select 0;
_objectsloaded = _carrier getVariable "R3F_LOG_objets_charges";

{_x setdamage 1;} foreach _objectsloaded;

_carrier setVariable ["R3F_LOG_objets_charges", [], true];


