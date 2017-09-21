// Written by EightySix

private["_values","_score","_cr","_nr"];

	_values = [0,500,1500,2500,3500,5000,7500];

	while {true} do {
		_score = rating player;
		_cr = toUpper(rank player);
		_nr = toUpper(rank player);

		waitUntil {(rating player) != _score || (rating player) < 0};
		waitUntil { alive player };

		if((rating player <  (_values select 1)) ) then { _nr = "PRIVATE"	};
		if((rating player >= (_values select 1)) ) then { _nr = "CORPORAL"	};
		if((rating player >= (_values select 2)) ) then { _nr = "SERGEANT"	};
		if((rating player >= (_values select 3)) ) then { _nr = "LIEUTENANT"	};
		if((rating player >= (_values select 4)) ) then { _nr = "CAPTAIN"	};
		if((rating player >= (_values select 5)) ) then { _nr = "MAJOR"		};
		if((rating player >= (_values select 6)) ) then { _nr = "COLONEL"	};


		if( rating player < 0 ) then {

			_score = (-1*_score);

			player addrating _score;

			_score = rating player;

		};

		if( rating player > _score && _nr != _cr && mps_rank_sys_enabled ) then {

			mps_rank_chg = [player,_nr]; publicVariable "mps_rank_chg";

			mps_rank_chg spawn mps_rank_update;

			mission_sidechat = format["%1 was promoted to %2",name player,_nr]; publicVariable "mission_sidechat";
			[side player,"HQ"] sidechat mission_sidechat;
			hint format[localize "STR_Client_RANK_UP",_nr];

			_score = rating player;

			_cr = _nr;

			sleep 1;

		}else{
			if( rating player < _score && _nr != _cr && mps_rank_sys_enabled ) then {

				mps_rank_chg = [player,_nr]; publicVariable "mps_rank_chg";

				mps_rank_chg spawn mps_rank_update;

				mission_sidechat = format["%1 was demoted to %2",name player,_nr]; publicVariable "mission_sidechat";
				[side player,"HQ"] sidechat mission_sidechat;
				hintsilent format[localize "STR_Client_RANK_Down",rank player];

				_score = rating player;

				_cr = _nr;

				sleep 1;
			};
		};

	};
