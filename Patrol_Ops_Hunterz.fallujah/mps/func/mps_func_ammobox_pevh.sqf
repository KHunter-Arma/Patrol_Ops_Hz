// Written by EightySix
/*
"mps_new_ammobox" addPublicVariableEventHandler {

	_data = _this select 1;

	if( (_data select 0) == playerSide) then{

		_box = (_data select 1);

		[_box] spawn mps_fill_ammobox;

	};

};

"mps_create_ammobox" addPublicVariableEventHandler {

	_data = _this select 1;

	if(!isDedicated) then {

		if( (_data select 0) == playerSide) then{

			_position = (_data select 1);

			[_position] call mps_ammobox;

		};

	};

	if(isServer) then {

		mps_ammobox_list = mps_ammobox_list + [_data]; publicVariable "mps_ammobox_list";

	};

};

"mps_remove_ammobox" addPublicVariableEventHandler {

	_data = _this select 1;

	if(!isDedicated) then {

		if( (_data select 0) == playerSide) then{

			_position = (_data select 1);

			[_position] call mps_ammobox_remove;

		};

	};

	if(isServer) then {

		mps_ammobox_list = mps_ammobox_list - [_data]; publicVariable "mps_ammobox_list";

	};

};

*/