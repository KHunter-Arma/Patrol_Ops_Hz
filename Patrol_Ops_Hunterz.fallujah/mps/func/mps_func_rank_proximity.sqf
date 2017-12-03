// Written by EightySix

if(!mps_rank_sys_enabled) exitWith{};

private["_score"];

	while {true} do {

		sleep 10;

		_grp = group player;

		_tl = leader _grp;

		_score = 0;



		{	if(side _x == playerSide && _x in (units _grp) && alive _x && _x != player) then {

				_score = _score + 0.3;

			};

		}forEach (nearestObjects [position player,["Man"],50]);


		if(_score > 0) then { player addrating (ceil _score) };

	};
