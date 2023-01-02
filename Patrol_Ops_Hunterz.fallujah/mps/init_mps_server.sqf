if(!isServer) exitWith {};

//jungle1 = createLocation ["VegetationPalm", markerpos "jungle_1", (markersize "jungle_1") select 0, (markersize "jungle_1") select 1];
//jungle2 = createLocation ["VegetationPalm", markerpos "jungle_2", (markersize "jungle_2") select 0, (markersize "jungle_2") select 1];
//["VegetationPalm",[position player,5000],true] call BIS_fnc_locations;
//jungle2 setname "Jungle_2";
//jungle1 setname "Jungle_1";

//initialise some server-side vars
narray1 = [];
Hz_resetBuildingVars = [];
Hz_save_lock = false;

//initialise persistent variables
narray2 = [];
Hz_save_prev_tasks_list = [];
Hz_save_destroyedMapBuildingIDs = [];
Hz_save_radar_spawn_timer = 0;   
Hz_save_radar_pos = [0,0,0];
Hz_save_arty_spawn_timer = 0;
Hz_save_arty_pos = [0,0,0];
Hz_save_arty_rocketArty = false;
rallytents = [];
BanList = [];
publicvariable "BanList";
publicvariable "rallytents";
publicvariable "Hz_save_prev_tasks_list";

//to be used for syncing nuke destruction for JIP
publicvariable "narray2";

// Determine if Server is running ACE & ACRE
//[] execVM (mps_path+"func\mps_func_detect_ace.sqf");

// AMMOBOX
//	mps_ammobox_list = []; publicVariable "mps_ammobox_list";

//	[] spawn compile preprocessFileLineNumbers (mps_path+"func\mps_func_ieds.sqf");

// Unit Recruiting
// Written By BON_IF
// Adapted by EightySix

/*	"mps_recruit_newunit" addPublicVariableEventHandler {
		_newunit = _this select 1;
		[_newunit] execFSM (mps_path+"recruit\recruit_lifecycle.fsm");
	};*/

// Storeable Objects Reference point
// Written By R3F
// Adapted by EightySix

mps_logistics_referencepoint = "HeliHEmpty" createVehicle [0, 0, 0];
publicVariable "mps_logistics_referencepoint";

// Initilise MHQ
// Written By EightySix

/*
				[] spawn {
		{
			_mhq = !isNil {_x getVariable "mhq_side"};
			if(_mhq) then {
				_x setVariable ["mhq_status",false,true];
				_x setVariable ["liftable",true,true];
				_x setVariable ["vehicle_ammobox",true,true];
				[_x] spawn mps_mhq_toggle;
			};
		} forEach (nearestObjects [ [0,0], ["LandVehicle"], 80000 ] );
	};

*/

//  if (mps_ambient_insurgents) then{  [] spawn RANDOM_PATROLS; };

//Server-side persistency loop
[] execVM "HZ\server.sqf";

nuke_event = [];

//Initial VD for server
setviewdistance 2000;

//for cleanup of bicycles
tempbikes = [];
publicvariable "tempbikes";

/*
ambientPatrolBoosterRunning = false;
addMissionEventHandler ["PlayerConnected",{

	if (time < 7200) exitWith {};
	if (ambientPatrolBoosterRunning) exitWith {};
	ambientPatrolBoosterRunning = true;
	if ((count (allPlayers - entities "HeadlessClient_F")) == 1) then {
	
		[] spawn {
		
			Hz_max_ambient_units_old = Hz_max_ambient_units;
			Hz_max_ambient_units = Hz_max_ambient_units + 100;
			
			if (Hz_max_ambient_units > 250) then {
			
				Hz_max_ambient_units = 250;
			
			};
			
			publicVariable "Hz_max_ambient_units";
			
			sleep 900;
			
			Hz_max_ambient_units = Hz_max_ambient_units_old;
			publicVariable "Hz_max_ambient_units";
			
			ambientPatrolBoosterRunning = false;
				
		};
	
	} else {
	
		ambientPatrolBoosterRunning = false;
	
	};

}];
*/

// disabled in favour of ACE towing now
//[] execvm "SA_AdvancedTowing\advancedTowingInit.sqf";

//if(mps_ambient_airpatrols) then {[] spawn CREATE_OPFOR_AIRPATROLS;};    
	
//[] spawn Hz_func_spawnOpforArtilleryBase;  
