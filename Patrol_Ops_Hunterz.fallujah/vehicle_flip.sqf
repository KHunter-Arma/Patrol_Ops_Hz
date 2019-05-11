if (isNil "fliprunning") then {fliprunning = false};
if (fliprunning) exitWith {};
fliprunning = true;

_car = _this select 0;
_player = _this select 1;
_PlayersHelping = _car getVariable ["Flip_Needed",0];
private "_playersNeeded";

_mass = getMass _car; 
/*
switch (_mass) do { 
	case (_mass >= 0 && _mass <= 1600) : { _playersNeeded = 1; }; 
	case (_mass > 1600 && _mass <= 2140) : { _playersNeeded = 2; }; 
	case (_mass > 2140) : { _playersNeeded = 3; }; 
	default {  _playersNeeded = 3; }; 
};
*/

_playersNeeded = ceil (_mass/800);
if (_playersNeeded <= 0) then {_playersNeeded = 1};

//copyToClipboard str _mass;
//_playersNeeded = 1; //set for testing only, can be removed later
_car setVariable ["Flip_Needed",_PlayersHelping + 1,true];   //setvariable
[player,"AidlPknlMstpSnonWnonDnon_G01"] remoteExecCall ["switchMove",0,false];
sleep 1;
player playMoveNow "AidlPknlMstpSnonWnonDnon_G01";
sleep 0.2; // transition time
_anim = animationState _player;
_break = false;

if (_PlayersHelping < _playersNeeded) then {

	hint "Waiting for more people to help flip this thing!...";

};

while{ animationState _player == _anim }do{
	_PlayersHelping = _car getVariable ["Flip_Needed",0];

	if (_PlayersHelping >= _playersNeeded) exitWith { 
		_break = true;
		hint "Flipping vehicle...";
	};
	sleep 1;
};

if (_break) then {
	
	disableUserInput true; 
  [_player,"InBaseMoves_repairVehicleKnl"] remoteexeccall ["switchMove",0,false];
  sleep 1;
	_player playMoveNow "InBaseMoves_repairVehicleKnl";
	disableUserInput false; 
	sleep 18;

	_carpos = [getPos _car select 0,getpos _car select 1, (getPos _car select 2) +2];
	[_car, [0,0,1]] remoteexeccall ["setVectorUp", _car, false];
	[_car, _carpos] remoteexeccall ["setPos", _car, false];
} 
else 
{
	_PlayersHelping = _car getVariable ["Flip_Needed",1];
	_car setVariable ["Flip_Needed",_PlayersHelping - 1,true];
};

fliprunning = false;