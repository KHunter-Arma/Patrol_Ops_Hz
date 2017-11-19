// Written by Kev
// Adapted by EightySix

//Redundant with ACE
if(mps_ace_enabled) exitWith {};

private["_target","_text"];

	while{isNil "mps_mission_finished"} do{

		_target = cursorTarget;

		_text = "";

		if(side _target == playerSide || {side _x == playerSide} count (crew _target) > 0 ) then {

			if(count (crew _target) > 0) then {

				{ if(alive _x && isPlayer _x) then {_text = format["%1 %2 ",_text,name _x];}; }forEach (crew _target);

			}else{

				if(alive _target && isPlayer _target) then {_text = format["%1",name _target]; };

			};

			106 cutText [_text,"PLAIN DOWN"];

			sleep 2;

			106 cutText ["","PLAIN DOWN"];

		};

		sleep 1;

	};
