if (!isServer) exitwith {};

_carrier = _this select 0;
_carried = _carrier getVariable "cargo";

_carried setdamage 1;

_carrier setVariable ["cargo","", true];


