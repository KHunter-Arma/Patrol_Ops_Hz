if ((captive _this) && {!(_this call Hz_fnc_isUncon)}) then {
	
	[_this, false] remoteExecCall ["ACE_captives_fnc_setHandcuffed",_this,false];
	[_this, false] remoteExecCall ["setCaptive",_this,false];
	detach _this;
	
};