#include "func\functions.sqf"

if(!isServer) exitWith {};

//jungle1 = createLocation ["VegetationPalm", markerpos "jungle_1", (markersize "jungle_1") select 0, (markersize "jungle_1") select 1];
//jungle2 = createLocation ["VegetationPalm", markerpos "jungle_2", (markersize "jungle_2") select 0, (markersize "jungle_2") select 1];
//["VegetationPalm",[position player,5000],true] call BIS_fnc_locations;
//jungle2 setname "Jungle_2";
//jungle1 setname "Jungle_1";

//initialise some server-side vars
markerindex = 0;
gunsarr = [];
narray1 = [];
narray2 = [];
narray3 = [];
narray4 = [];
narray5 = [];
Hz_resetBuildingVars = [];
Hz_save_prev_tasks_list = [];
Hz_save_destroyedMapBuildingIDs = [];
staticactive = false;

Hz_patrol_task_in_progress = false;
publicvariable "Hz_patrol_task_in_progress";

//to be used for syncing nuke destruction for JIP
publicvariable "narray2";


//Get rid of nasty trees in Fallujah in the middle of road (only ones that I know of...)
if((tolower worldName) == "fallujah") then {
{
 {_x setdamage 1} foreach _x;

}foreach [
nearestobjects [[3339.92,4055.99,0.00143862],[],15],
nearestobjects [[3359.98,4055.47,0.00143862],[],15],
nearestobjects [[3043.59,2721.69,0.00143862],[],15],
nearestobjects [[3699.2,4940.73,0.00143862],[],15]

]};


//for spawning patrols closer to town. checks for nearby players
AI_respawn_safe_east = true;
AI_respawn_safe_west = false;

// Determine if Server is running ACE & ACRE
	[] execVM (mps_path+"func\mps_func_detect_ace.sqf");

// AMMOBOX
//	mps_ammobox_list = []; publicVariable "mps_ammobox_list";

/*
// Ambient Civillians
	if(AMBCIVILLIAN > 0 && count ALICE_MODULE > 0) then {
		MISSION_GroupLogic = createGroup sideLogic;
		ALICE = MISSION_GroupLogic createUnit [(ALICE_MODULE) select 0,[0,0,0],[],0,"NONE"];
		ALICE setVariable ["spawnDistance",500];
		ALICE setVariable ["ALICE_civilianinit",[{
			_this addEventHandler ["Killed",{
				_killer = _this select 1;
				if(side _killer == (SIDE_A select 0) ) then{ mission_commandchat = format["%1 killed a civilian!",name _killer]; publicVariable "mission_commandchat"; player commandchat mission_commandchat;};
			}];
		}]];
	};
*/

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
//
   //     [] spawn CONFIG_ACM;
   gunspawnindex = 0;
   gunspawntimeroff = true;
   call spawnAIGuns;
    Hz_save_radar_spawn_timer = 0;   
    Hz_save_radar_pos = [0,0,0];
    Hz_save_arty_spawn_timer = 0;
    Hz_save_arty_pos = [0,0,0];
    Hz_save_jointOps_vehicles = [];
   
   AIsoldierFlare_units = [];
   
   //  if (mps_ambient_insurgents) then{  [] spawn RANDOM_PATROLS; };
   
   //Server-side persistency loop
   [] execVM "logistics\cleanup.sqf";


 // Make sure town doesn't "regenerate" for JIP after nuke event. Also sync markers for JIP (thanks for fixing that btw BIS...)
        syncJIPmarkers = [];
        nuke_event = [];
        
        //init security vars
        Hz_SvSec_WaitingForClear = [];
        publicvariable "Hz_SvSec_WaitingForClear";
        Hz_SvSec_ClearUIDs = [];
        Hz_SvSec_InitWaitTime = 120;
        
        
       Onplayerconnected {
             //sync markers (mainly used for syncing player respawn on tent positions which work using invisible player placed markers)
            {_x setMarkerPos (getMarkerPos _x);}foreach syncJIPmarkers;
            
            
            //Experimental: Detect client init failure and kick
                    [_uid] spawn {

                     sleep Hz_SvSec_InitWaitTime;
                     
                     _uid = _this select 0;
                     if (_uid in Hz_SvSec_WaitingForClear) then {
                     
                     Hz_SvSec_ClearUIDs set [count Hz_SvSec_ClearUIDs,_uid];
                     Hz_SvSec_WaitingForClear = Hz_SvSec_WaitingForClear - [_uid];
                     publicvariable "Hz_SvSec_WaitingForClear";
                     
                     } else {
                         
                         if(_uid in Hz_SvSec_ClearUIDs) exitwith {};
                     
                         [-1, {

                             _this spawn {

                                 //isnull player should timeout after so much time anyway. prevent seagull/spectate bug this way
                                 
                                 if (isnull player) then {
                                     
                                 hintc "Warning! Initialization failed! Please rejoin.";
                                 endmission "End2";    
                                     
                                 } else {
                                 
                                 _uid = _this select 0;

                                 if((getplayeruid player) == _uid) then {

                                 hintc "Warning! Initialization failed! Please rejoin.";
                                 endmission "End2";

                                 };
                                 
                               };  
                                 

                             };        


                        },_this] call CBA_fnc_globalExecute;        
                     
                         
                     };

                 };      
            
        };
        
        
                
       Onplayerdisconnected {
         
        Hz_SvSec_ClearUIDs = Hz_SvSec_ClearUIDs - [_uid];     
           
        };       
        
        
        //for remote debugging
        UPS_respawn_calls = 0;
        UPS_vcl_respawn_calls = 0;
        publicvariable "UPS_respawn_calls";
        publicvariable "UPS_vcl_respawn_calls";
        
        
        //Initial VD for server
        setviewdistance 2000;
        
        //For saving
        medbox_array = [medbox1,medbox2,medbox3,medbox4];
        emptybox_array = [emptybox1,emptybox2,emptybox3,emptybox4,emptybox5,emptybox6,emptybox7,emptybox8];
        publicvariable "medbox_array";
        publicvariable "emptybox_array";
        rallytents = [];
        BanList = [];
        publicvariable "BanList";
        publicvariable "rallytents";
        
        //for cleanup
        tempbikes = [];
        publicvariable "tempbikes";
        
        //sync nuke destruction (buildings destroyed don't sync well in Fallujah -- must also be done client side at JIP to assure full sync across all clients)
        publicvariable "narray2";
        
        Hz_save_lock = false;
        
        if(autoload) then {
        deletevehicle hz_trigger_load;
        sleep 30;
        
        gameloaded = false;
        [] execvm "HZ\HZ_loadgame.sqf";
        waituntil {sleep 1; gameloaded};
        
        if(isDedicated && !hz_debug) then {
        
        [-1, {
            
         hintc "Game Loaded. Please reconnect to synchronize.";     
         endmission "loser";
                    
                        }] call CBA_fnc_globalExecute;
        
        };
        
        if(mps_ambient_airpatrols) then {[] spawn CREATE_OPFOR_AIRPATROLS;};
        
        } else {
            
        if(mps_ambient_airpatrols) then {[] spawn CREATE_OPFOR_AIRPATROLS;};    
                    
        };
        
       [] spawn Hz_func_spawnOpforArtilleryBase;  
        
        if((paramsArray select 20) > 0) then {
            
                []spawn {
                
                _delay = paramsArray select 20;
                
                while {true} do {
                
                uisleep _delay;
                call compile preprocessFileLineNumbers "HZ\HZ_savegame.sqf";
                
                };                
                
                };
                
                    
                        
        };