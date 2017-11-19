// Code Parts by ArmA Community
// Adapted by EightySix
private["_timer","_height"];

if( isNil "mps_halo_limitation") then { mps_halo_limitation = 0; };

if(mps_halo_limitation > 6) exitWith { hint "Halo Not Available"; };

if(isNil "mps_halo_time") then { mps_halo_time = time - ( mps_halo_limitation * 601 ); };

if( ( ( mps_halo_time - time )* -1) <= ( mps_halo_limitation * 600 ) && mps_halo_limitation > 0 ) exitWith { hint format["Halo Not Available for %1mins", ceil( ( mps_halo_limitation * 600 + ( mps_halo_time - time ) ) / 60) ]; };

	haloed = true;
	_timer = 20;
	mps_jumpgrp = [];

	104 cutText ["Click on the map where you'd like to HALO jump.","PLAIN DOWN",5];

	onMapSingleClick "
		if(player == leader (group player) ) then { { if ( !(isPlayer _x) && _x distance player < 100 ) then { mps_jumpgrp = mps_jumpgrp + [_x]; }; }forEach (units (group player)); };

		player setPos [_pos select 0, _pos select 1, 1500];
		[player, 1500] exec 'ca\air2\halo\data\Scripts\HALO_init.sqs';

		haloed = false;
		104 cutText ['Close the map and don''t forget to open your chute!','PLAIN DOWN',5];
	";

	while { haloed && _timer > 0 } do { sleep 1; _timer = _timer - 1; };

	onMapSingleClick "";

	sleep(1); 104 cutText ["","PLAIN DOWN",0];

	if !(haloed) then {

		if(player == leader (group player) && count mps_jumpgrp > 0 ) then {
			{
				_unk = [position player,random 360,(20 + random 90),true,1] call mps_new_position;
				_x setPos [_unk select 0,_unk select 1, 1500];
				if(mps_ace_enabled) then {
					[_x,1500] execVM (mps_path+"func\mps_func_halo_ai.sqf");
				}else{
					[_x,1500] exec (mps_path+"func\mps_func_halo_ai.sqs");
				};
			}forEach mps_jumpgrp;
		};

		_height = (position player) select 2;

		while {_height > 50} do {
			_height = (position player) select 2;
			hintsilent format["Height: %1m\nPull at minimum 180m",round _height];
			sleep 0.125;
		};

		hintsilent "";

		mps_halo_time = time;

	}else{

		hint "Halo Expired";

	};
