// Written by EightySix

if(isNil "mps_progress_show") then { mps_progress_show = false; };
if(isNil "mps_progress_timer") then { mps_progress_timer = 0; };

if(!mps_progress_show) exitWith {
	8601 cutRsc ["XProgressBar","PLAIN"];
	mps_progress_show = true;
	if( mps_progress_timer == 0) then {
		mps_progress_timer = 15;
		[] spawn {
			while{ mps_progress_timer > 0 } do { mps_progress_timer = mps_progress_timer - 1; sleep 1; };
			8601 cuttext ["","PLAIN"];
			mps_progress_show = false;
			mps_progress_timer = 0;
		}
	};

};
