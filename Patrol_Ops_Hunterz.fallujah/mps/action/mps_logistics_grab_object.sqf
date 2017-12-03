// Written by EightySix
// Inspired by R3F logistics
/*
_object = _this select 0;

if( isNil(" _object getVariable ""mps_drag"" ") ) then { _object setVariable ["mps_drag", false, true]; };

if( _object getVariable "mps_drag" ) exitWith{};

	player playMove "acinpknlmstpsraswrfldnon";

	player setVariable ["mps_drag", _object, true];

	_object setVariable ["mps_drag", true, true];

	_object attachTo [player, [
		0,
		(((boundingBox _object select 1 select 1) max (-(boundingBox _object select 0 select 1))) max ((boundingBox _object select 1 select 0) max (-(boundingBox _object select 0 select 0)))) + 1,
		1]
	];

	_action_menu = player addAction [("<t color=""#ffc600"">Release the object</t>"), (mps_path+"action\mps_logistics_drop_object.sqf"), [], 1, true, true ];

while{alive player && (_object  getVariable "mps_drag") && vehicle player == player} do {sleep 0.125};

	player playAction "released";

	player removeAction _action_menu;

	detach _object;

	_object setPos [getPos _object select 0, getPos _object select 1, 0];

	_object setVelocity [0, 0, 0];

	_object setVariable ["mps_drag", false, true];
        
        */