scriptName "Hz_pops_unitPosHoldHandler";

_initPos = getPosATL _this;
_posx = _initPos select 0;
_posy = _initPos select 1;

sleep 10;

while {(alive _this) && {!(_this call Hz_fnc_isUncon)}} do {

	_pos = getPosATL _this;
	if (((abs ((_pos select 0) - _posx)) > 0.1) || {(abs ((_pos select 1) - _posy)) > 0.1}) then {_this setposatl _initPos;};
	
	sleep 10;

};