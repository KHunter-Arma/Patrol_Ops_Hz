// Written by EightySix

private["_location","_position","_xy"];

	_location = _this select 0;

	_position = switch(_location) do{

		case "MHQ": {getmarkerPos "Respawn_MHQ"};

		case "RALLY": {getMarkerPos (getplayeruid player)};

		//default { getmarkerPos format["respawn_%1",playerSide]; };
                default { getpos player; };
	};

// Redundant position check to ensure player is not positioned at [0,0] of the map
	if(_position distance [0,0,0] < 100) then{

		_position = getmarkerPos format["respawn_%1",playerSide];

	};

	_xy = [_position,random 360,(2 + random 2),true,1] call mps_new_position;
	mps_movegrp = [];
	if(player == leader (group player) ) then { { if ( !(isPlayer _x) && _x distance player < 100 ) then { mps_movegrp = mps_movegrp + [_x]; }; }forEach (units (group player)); };

	player setVelocity [0, 0, 0];
	player setpos [_xy select 0,_xy select 1,_position select 2];

	if(player == leader (group player) && count mps_movegrp > 0 ) then {
		{ _x setpos ([_position,random 360,(2 + random 8),true,1] call mps_new_position); }forEach mps_movegrp;
	};


	mps_respawned_player = true;

	closeDialog 0;