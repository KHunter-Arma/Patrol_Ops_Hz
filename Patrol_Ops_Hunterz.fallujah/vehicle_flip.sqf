_car = _this select 0;
_player = _this select 1;
_PlayersHelping = _car getVariable ["Flip_Needed",0];
private "_playersNeeded";

_weight = getMass _car; // HUNTER YOU HAVE TO CHECK HOW THIS IS DONE WITH THE TOWING MOD !!

switch (_weight) do { 
	case (_weight >= 0 && _weight <= 100) : { _playersNeeded = 1; }; 
	case (_weight > 100 && _weight <= 300) : { _playersNeeded = 2; }; 
	case (_weight > 300) : { _playersNeeded = 3; }; 
	default {  _playersNeeded = 3; }; 
};
_playersNeeded = 2; //set for testing only, can be removed later
player switchMove "AidlPknlMstpSnonWnonDnon_G01";
player playMovenow "AidlPknlMstpSnonWnonDnon_G01";
_car setVariable ["Flip_Needed",_PlayersHelping + 1,true];   //setvariable
sleep 0.5; // transition time
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
	
	disableUserInput true; // this command has to be sent to the player ?
	_player switchMove "InBaseMoves_repairVehicleKnl";
	_player playMoveNow "InBaseMoves_repairVehicleKnl";
	disableUserInput false; // this command has to be sent to the player ?
	sleep 6;

	_car setPos [getPos _car select 0,getpos _car select 1, (getPos _car select 2) +2];
	//_car setVectorUp [0,0,1];
	[_car, [0,0,1]] remoteexeccall ["setVectorUp", _car, false];
} 
else 
{
	_PlayersHelping = _car getVariable ["Flip_Needed",1];
	_car setVariable ["Flip_Needed",_PlayersHelping - 1,true];
};