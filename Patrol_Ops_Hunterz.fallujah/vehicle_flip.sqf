_car = _this select 0;
_player = _this select 1;
_PlayersHelping = _car getVariable ["Flip_Needed",0];
private "_playersNeeded";

_weight = getMass _car; 

switch (_weight) do { 
	case (_weight >= 0 && _weight <= 1600) : { _playersNeeded = 1; }; 
	case (_weight > 1600 && _weight <= 2140) : { _playersNeeded = 2; }; 
	case (_weight > 2140) : { _playersNeeded = 3; }; 
	default {  _playersNeeded = 3; }; 
};
//copyToClipboard str _weight;
//_playersNeeded = 1; //set for testing only, can be removed later
player switchMove "AidlPknlMstpSnonWnonDnon_G01";
//[player,"AidlPknlMstpSnonWnonDnon_G01"] remoteExecCall ["switchMove",0,false];
player playMoveNow "AidlPknlMstpSnonWnonDnon_G01";
_car setVariable ["Flip_Needed",_PlayersHelping + 1,true];   //setvariable
sleep 0.2; // transition time
_anim = animationState _player;
_break = false;

while{ animationState _player == _anim }do{
	_PlayersHelping = _car getVariable ["Flip_Needed",0];

	if (_PlayersHelping == _playersNeeded) exitWith { 
		_break = true;
	};
	sleep 1;
};
if (_break) then {
	
	disableUserInput true; 
	_player switchMove "InBaseMoves_repairVehicleKnl";
	//[player,"InBaseMoves_repairVehicleKnl"] remoteExecCall ["switchMove",0,false];
	_player playMoveNow "InBaseMoves_repairVehicleKnl";
	disableUserInput false; 
	sleep 18;

	//_car setPos [getPos _car select 0,getpos _car select 1, (getPos _car select 2) +2];
	_carpos = [getPos _car select 0,getpos _car select 1, (getPos _car select 2) +2];
	//_car setVectorUp [0,0,1];
	[_car, [0,0,1]] remoteexeccall ["setVectorUp", _car, false];
	[_car, _carpos] remoteexeccall ["setPos", _car, false];
} 
else 
{
	_PlayersHelping = _car getVariable ["Flip_Needed",1];
	_car setVariable ["Flip_Needed",_PlayersHelping - 1,true];
};