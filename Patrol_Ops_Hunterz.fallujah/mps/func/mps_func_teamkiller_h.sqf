// Inspired by Kev
// Adapted by Eightysix


if(isDedicated || (call Hz_fnc_isHC)) exitWith {};

if( isNil "mps_teamkiller_value" ) then { mps_teamkiller_value = 0; };
if( isNil "mps_teamkiller_busy") then { mps_teamkiller_busy = false; };

mps_func_tk_livestock = {

	private["_unit","_animal"];

	player action ["eject",vehicle player];

	_vehicle = vehicle player;

	_animal = ["Hen","Cock"] call mps_getRandomElement;

	_animal createUnit [position player, createGroup playerSide, "if(local this) then {selectPlayer this;};"];

	deleteVehicle _vehicle;

	if( !( ( getPlayerUID player ) IN mps_teamkillers ) ) then {

		mps_teamkillers = mps_teamkillers + [getPlayerUID player];

		publicVariable "mps_teamkillers";
	};

};

if( ( getPlayerUID player ) IN mps_teamkillers ) then { [] spawn mps_func_tk_livestock; };

"mps_killed_event" addPublicVariableEventHandler {

	_data = _this select 1;

	if( (_data select 2) == playerSide && (_data select 1) == player && (_data select 0) != player && !mps_teamkiller_busy) then {

		mps_teamkiller_busy = true;

		if( mps_teamkiller_value > 2 ) then {

			[] spawn mps_func_tk_livestock;

		} else {

			mps_teamkiller_value = mps_teamkiller_value + 1;

			hintc format["Team Killer be warned. You have %1 chances remaining", (2 - mps_teamkiller_value) ];

			sleep 2;

		};

		mps_teamkiller_busy = false;

	};

};

player addEventHandler ["Fired",{

	if(player distance getMarkerPos format["respawn_%1",SIDE_A select 0] < 200 ) then { deleteVehicle (_this select 6); };

}];

