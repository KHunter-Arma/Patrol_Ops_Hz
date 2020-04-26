_car = _this select 0;
_player = _this select 1;

_mass = getMass _car; 
_playersNeeded = ceil (_mass/800);
if (_playersNeeded <= 0) then {_playersNeeded = 1};
_PlayersHelping = _car getVariable ["playershelping",0];

if (_PlayersHelping >= _playersNeeded) exitWith {

	hint "There's enough people to flip this already, no need for more!";

};

if (_PlayersHelping < 0) then {_PlayersHelping = 0};
_car setVariable ["playershelping",_PlayersHelping + 1,true];

_car removeAction (_car getVariable "flipAnimHandler");
_cancelHandler = player addAction ["<t color='#FF0000'>Cancel animation</t>",{[player,""] remoteexeccall ["switchMove",0,false];}, nil, 99, false];

[player,"AidlPknlMstpSnonWnonDnon_G01"] remoteExecCall ["switchMove",0,false];
//this locks animation, which is required
player playMoveNow "AidlPknlMstpSnonWnonDnon_G01";
_flipVehicle = false;

if (_PlayersHelping < _playersNeeded) then {

	hint "Too heavy... We need more people to flip this thing!";

};

while{ animationState _player == "AidlPknlMstpSnonWnonDnon_G01"} do {
	_PlayersHelping = _car getVariable "playershelping";

	if (_PlayersHelping >= _playersNeeded) exitWith { 
		hintsilent "";
		_flipVehicle = true;
		sleep 1;
	};
	sleep 1;
};

if (_flipVehicle) then {

	_carpos = (getPosATL _car) vectorAdd [0,0,2];	
  [_player,"InBaseMoves_table1"] remoteexeccall ["switchMove",0,false];
	_player playMoveNow "InBaseMoves_table1";

	[47, [_car,_playersNeeded,_carpos,_cancelHandler], {

		_args = _this select 0;
		_car = _args select 0;
		_carpos = _args select 2;
		_cancelHandler = _args select 3;
	
		//3 lines of network congesting code isn't good... rip
		[_car, [0,0,1]] remoteexeccall ["setVectorUp", _car, false];
		_car setposatl _carpos;
		
		_car setVariable ["playershelping",0,true];
		
		player removeAction _cancelHandler;
		_car setVariable ["flipAnimHandler",_car addAction ["<t color='#FF0000'>Flip vehicle</t>","vehicle_flip.sqf" , nil, 1.5, true, true, "", "((vehicle _this) == _this) && {(((vectorUp _target) select 2) < 0) || {((vectorUp _target) select 0) > 0.8}}", 6, false, ""]];

	}, {
	
		_args = _this select 0;
	
		_car = _args select 0;
		_cancelHandler = _args select 3;
		
		[player,""] remoteexeccall ["switchMove",0,false]; 
		
		_car setVariable ["playershelping",(_car getVariable "playershelping") - 1,true];
		
		player removeAction _cancelHandler;
		_car setVariable ["flipAnimHandler",_car addAction ["<t color='#FF0000'>Flip vehicle</t>","vehicle_flip.sqf" , nil, 1.5, true, true, "", "((vehicle _this) == _this) && {(((vectorUp _target) select 2) < 0) || {((vectorUp _target) select 0) > 0.8}}", 6, false, ""]];
	
	}, "Flipping vehicle...",{_args = _this select 0; _args params ["_car","_playersNeeded"]; (!(player call Hz_fnc_isUncon)) && {alive player} && {alive _car} && {(_car getVariable "playershelping") >= _playersNeeded}}] call ace_common_fnc_progressBar;	
	
} else {

	player removeAction _cancelHandler;
	
	_car setVariable ["playershelping",(_car getVariable "playershelping") - 1,true];	
	_car setVariable ["flipAnimHandler",_car addAction ["<t color='#FF0000'>Flip vehicle</t>","vehicle_flip.sqf" , nil, 1.5, true, true, "", "((vehicle _this) == _this) && {(((vectorUp _target) select 2) < 0) || {((vectorUp _target) select 0) > 0.8}}", 6, false, ""]];
	
};