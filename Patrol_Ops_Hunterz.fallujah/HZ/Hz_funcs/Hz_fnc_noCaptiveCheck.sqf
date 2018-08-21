if (captive _this) then {
	
	[_this, false] remoteExecCall ["ACE_captives_fnc_setHandcuffed",_this,false];
	[_this, false] remoteExecCall ["setCaptive",_this,false];
	detach _this;
	
};