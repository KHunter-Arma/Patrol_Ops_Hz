// Written by R3F
// Adapted by EightySix

if(!isMultiplayer) exitwith{};

if (_this select 0 != player) exitWith {};

terminate mps_respawn_process;
terminate mps_death_effect;

mps_respawn_process = [] spawn {
	private ["_position_bc", "_height_ATL_bc", "_direction_bc", "_mags_bc", "_weap_bc"];

	_position_bc = getPos mps_body;
	_height_ATL_bc = getPosATL mps_body select 2;
	_direction_bc = getDir mps_body;
	_mags_bc = magazines mps_body;
	_weap_bc = weapons mps_body;
	mps_respawned_player = false;

	closeDialog 0;

        //delay increased because black screen wasn't working when CMS active
	sleep 2;

	if (!isnil "AIS_effect_video_blur") then {ppEffectDestroy AIS_effect_video_blur};
	AIS_effect_video_blur = ppEffectCreate ["DynamicBlur", 472];
	AIS_effect_video_blur ppEffectEnable true;
	AIS_effect_video_blur ppEffectAdjust [0.3+random 0.3];
	AIS_effect_video_blur ppEffectCommit 2;

	if (!isnil "AIS_effect_video_colour") then {ppEffectDestroy AIS_effect_video_colour};
	AIS_effect_video_colour = ppEffectCreate ["ColorCorrections", 1587];
	AIS_effect_video_colour ppEffectEnable true;
	AIS_effect_video_colour ppEffectAdjust [0.25, 1, 0, [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
	AIS_effect_video_colour ppEffectCommit 2;

	[_position_bc] spawn mps_func_death_cam;

	waitUntil {alive player};

	sleep 0.2;
	mps_current_pos = getPosATL player;

	//player setPosATL (getMarkerPos format["respawn_%1",side player]);
	"respawn_west" call Hz_func_findGarrisonedRespawnPos;
	
	sleep 1;
	player setVelocity [0, 0, 0];

	mps_death_effect = [] spawn {
		while {true} do {
			AIS_effect_video_blur ppEffectAdjust [0.3+random 0.3];
			AIS_effect_video_blur ppEffectCommit 0;
			sleep (1+random 2);
			AIS_effect_video_colour ppEffectAdjust [0.1+random 0.1, 0.4+random 0.2, 0, [1, 0, 0, 0], [1, 0, 0, 0], [1, 0, 0, 0]];
			AIS_effect_video_colour ppEffectCommit (2.2+random 0.4);
			sleep (1+random 2);
			AIS_effect_video_colour ppEffectAdjust [0.25, 1, 0, [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
			AIS_effect_video_colour ppEffectCommit (1.7+random 0.2);
			sleep (1+random 2);
		};
	};

	closeDialog 0;

	121 cuttext [localize "STR_AIS_dead_message", "PLAIN"];

	[] call mps_respawn_delay;

	121 cuttext ["", "PLAIN"];
	createDialog "mps_respawn_dialog";

	while {!mps_respawned_player} do {sleep 1;};

	//deleteVehicle mps_body;
	mps_body = player;

	terminate mps_death_effect;

	closeDialog 0;

	ppEffectDestroy AIS_effect_video_blur;
	ppEffectDestroy AIS_effect_video_colour;
/*
	if(AIS_lives == 0) then { [] spawn mps_player_dead; };
	if(AIS_lives > 0) then { AIS_lives = AIS_lives - 1; };
*/
	sleep 0.2;

	121 cuttext [localize "STR_AIS_new_message", "PLAIN"]; sleep 3;
	121 cuttext ["","PLAIN"];
			
	if (Hz_pops_enableDetainUnrecognisedUIDs) then {
	
		if (!((getPlayerUID player) in Hz_pops_releasedUIDs)) then {
		
			[] spawn {
			
				sleep 1;			
				player setposatl Hz_pops_detainPosition;
				sleep 1;		
				
				waituntil {sleep 1; ((!alive player) || ((player distance Hz_pops_detainPosition) > 50))};

				if ((player distance Hz_pops_detainPosition) > 50) then {
				
					Hz_pops_releasedUIDs pushBack (getPlayeruid player);
					publicVariable "Hz_pops_releasedUIDs";
					call Hz_pers_API_enablePlayerSaveStateOnDisconnect;
					player removeEventHandler ["AnimChanged",Hz_pops_abortClimbEH];
					Hz_pers_clientReadyForLoad = true;
				
				};			
			
			};
		
		};
			
	};
};