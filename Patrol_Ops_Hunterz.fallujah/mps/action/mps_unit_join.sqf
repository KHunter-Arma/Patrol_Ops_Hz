// Written by BON_IF
_capturee = _this select 0;
_capturer = _this select 1;
_callid = _this select 2;

_capturee enableAI "MOVE";
_capturee enableAI "ANIM";

[_capturee] joinSilent _capturer;

_capturee setCaptive false;

if(true) exitWith{};