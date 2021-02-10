private ["_objectsarr","_uid","_tentpos","_tentposx","_tentposy","_tentposz"];

// Client Initialise

if(isDedicated || (call Hz_fnc_isHC)) exitWith {

	if (call Hz_fnc_isHC) then {
	
		waituntil {!isnil "narray2"};
		if (count narray2 > 0) then {{_x setdamage 1;} foreach narray2;};
		
		[] execvm "SA_AdvancedTowing\advancedTowingInit.sqf";

	};

};

if (!hz_debug && isMultiplayer) then {

  //delete UPS markers on client...
  deleteMarkerlocal "UPS";
	deleteMarkerlocal "UPS_b";
	deleteMarkerlocal "UPS_ins";

};

/*

// work out what class the player has joined as
  _class = "soldier";
  _sniper = [player,"sniper"] call mps_class_check;	if(_sniper) then {_class = "sniper";};
  _mg = [player,"mg"] call mps_class_check;		if(_mg) then {_class = "mg";};
  _at = [player,"at"] call mps_class_check;		if(_at) then {_class = "at";};
  _engineer = [player,"engineer"] call mps_class_check;	if(_engineer) then {_class = "engineer";};
  _crewman = [player,"crewman"] call mps_class_check;	if(_crewman) then {_class = "crewman";};
  _pilot = [player,"pilot"] call mps_class_check;		if(_pilot) then {_class = "pilot";};

  mps_player_class = _class;

*/



/*


// Error messages when a player tries to enter something the should not
  mps_driver_error_pilot = {
    _vehicleType = typeof (_this select 0);
    _title = "Advanced Vehicles";
    _content = format[localize "STR_Client_Limit_Pilots", getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName") ];
    _step = "Pilot Required";
    [_title,_content,_step] spawn mps_adv_hint;
  };
  mps_driver_error_crewman = {
    _vehicleType = typeof (_this select 0);
    _title = "Advanced Vehicles";
    _content = format[localize "STR_Client_Limit_Crew", getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName") ];
    _step = "Crewman Required";
    [_title,_content,_step] spawn mps_adv_hint;
  };
  mps_driver_error_rank = {
    _vehicleType = typeof (_this select 0);
    _rank = _this select 1;
    _title = "Advanced Vehicles";
    _content = format[localize "STR_Client_Limit_rank", getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName"),_rank];
    _step = "Rank Required";
    [_title,_content,_step] spawn mps_adv_hint;
  };
  mps_error_locked = {
    _vehicleType = typeof (_this select 0);
    _rank = _this select 1;
    _title = "Admin Restrictions";
    _content = format["The Administrator has locked this %1.<br/>If you wish to use this %1, the admin may unlock it for you.", getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName")];
    _step = "Admin Locked";
    [_title,_content,_step] spawn mps_adv_hint;
    (_this select 0) call mps_lock_vehicle;
  };

*/

// Detect ACRE
//[] call compile preprocessFileLineNumbers (mps_path+"func\mps_func_detect_acre.sqf");

// ACE additions

/*
  if(mps_ace_enabled) then {
    [player, _pilot] call ace_fnc_setCrewProtection;
  };
*/
// Begin actions for vehicle Drivers
// Written by BON_IF
// Adapted by EightySix
//	[] execFSM (mps_path+"fsm\mps_client_driver.fsm");

// Enable Restriction of 3rd Person
// Written by Xeno
// Adapted by EightySix
//	[] execFSM (mps_path+"fsm\mps_client_3rdperson.fsm");

waitUntil {!(isNull player)};

if (!hz_debug) then {

	"respawn_west" call Hz_func_findGarrisonedRespawnPos;
	sleep 1;

};

// Setup Client Event Handlers
call compile preprocessFileLineNumbers (mps_path+"func\mps_func_client_eventhandlers.sqf");

// Begin Client Cursor Monitoring for actions on objects
[] execVM (mps_path+"func\mps_func_client_cursortarget.sqf");
GrassLayerchanged = false;

// Remove all gear from a joining player and equip defaults
//	[] execVM (mps_path+"config\config_defaultgear.sqf");

// Publicvariabled from server init. Used to sync destroyed objects/buildings from nuke for JIP
waituntil {!isnil "narray2"};
if (count narray2 > 0) then {{_x setdamage 1;} foreach narray2;};

// Setup Respawn Variables
mps_body = player;
mps_death_effect = [] spawn {};

// Call the Injury System. This is disabled in the event ACE_Wounds is enabled
// Written by BON_IF
// Adapted by EightySix

//	player spawn mps_injury_sys_init;

// Setup JIP MHQ and enable mhq status updates

/*
  [] spawn {
    {	_mhq = !isNil {_x getVariable "mhq_side"};
      if(_mhq) then {
        if(_x getVariable "mhq_status") then { [_x,true] call mps_mhq_update };
      };
    } forEach (nearestObjects [ [0,0], ["All"], 40000 ] );	

    "mhq_update" addPublicVariableEventHandler { (_this select 1) call mps_mhq_update; };
  };
*/

// Initialise the Ranking System for players
//player spawn mps_rank_init;
//	player spawn mps_rank_proxy;
//player spawn mps_rank_hud;

// Initialise the Player HUDs

/*  
        [] spawn mps_func_hud_aimpoint;
  [] spawn mps_func_hud_teamlist;
  [] spawn {
    mps_player_list = []; sleep 10;
    while {true} do {
      {
        if( ((side _x) == (playerSide)) && (_x IN (playableUnits+switchableunits)) && !(_x in mps_player_list) && _x != player ) then {
          mps_player_list = mps_player_list + [_x];
          // _x spawn mps_func_hud_3d;
        };
      } foreach allUnits;
      { if !(_x IN (playableUnits+switchableunits)) then { mps_player_list = mps_player_list - [_x]; }; } forEach mps_player_list;
      sleep 20;
    };
  };

  [] spawn { waitUntil {time > 2}; (findDisplay 46) displayAddEventHandler ["KeyDown","_this call mps_func_keyspressed"]; };
        
        */

// Setup JIP deployed ammoboxes
/*
        
        player spawn {

    private["_data","_position","_nearestboxes"];

    waitUntil {!isNil "mps_ammobox_list"};

    {
      _data = _x;
      if( (_data select 0) == side player) then{
        _position = (_data select 1);
        _nearestboxes = nearestObjects [_position,[mission_mobile_ammo],5];
        if(count _nearestboxes == 0) then {
          [_position] call mps_ammobox;
        };
      };

    }forEach mps_ammobox_list;
  };
      */  

[]spawn {
  
  sleep 60;
  hint parseText format
  ["
  <t align='center' size='1.5' shadow='1' color='#ffffff' shadowColor='#000000'>
  PATROL OPS</t><t align='center' size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'> HUNTER'Z
        </t><br /><br /><t align='left' shadow='1' color='#ffffff' shadowColor='#000000'>This server runs a heavily modified, persistent Patrol Ops mission. Respawn time is several minutes. For more information, ask a member of staff.
"];
  
};

if (!hz_debug && ((side player) != civilian)) then {
  [player] joinsilent (creategroup [SIDE_A select 0,true]);
};

//call compile preprocessFileLineNumbers "notes.sqf";

/*
//looks like not needed in Arma 3

//option to change viewdistance in vehicle
if(isnil "limitviewdistance") then {limitviewdistance = false;};
[]spawn {
  while {true} do {
    sleep 5;
    if ((vehicle player) != player) then {
      
      _veh = vehicle player;
      mps_clientVehicle_hud_act = _veh addAction [localize "STR_Client_HUD_menu",(mps_path+"action\mps_hud_switch.sqf"),[],-1,false,false,"",""];
      waituntil {sleep 5;(vehicle player) == player};
      _veh removeaction mps_clientVehicle_hud_act;
      
    };
  };
};
*/

if (!Hz_debug) then {

	removeallweapons player;
	removeallitems player;
	removeAllAssignedItems player;
	removeVest player;
	removeBackpack player;
	removeHeadgear player;	
	removeGoggles player;
	
};

_uid = getplayeruid player;
if(_uid in BanList) then {
	
	removeUniform player;
	Hz_pers_clientReadyForLoad = true;
	uisleep 5;	
  "-1" call Hz_fnc_arrestPlayer;	
};

[] execvm "SA_AdvancedTowing\advancedTowingInit.sqf";

waituntil {Receiving_finish};
sleep 1;
if (!mps_debug && !hz_debug) then {["Bad Company Presents...",format["Patrol Ops Hunter'z\n%1",toupper(worldname)],"Mission by\nK.Hunter","Patrol Ops Framework\nby EightySix"] spawn mps_intro;} else {intro_cam_done = true;};
waitUntil {intro_cam_done};

if(!hz_debug) then {

  // player check
 supervisorHandler = [] spawn {

    if (call Hz_func_isSupervisor) exitwith{Hz_pops_restrictionSupervisorCheckPassed = true;};
    
    _uid = getPlayerUID player;

    while {true} do {
      
      _allPlayers = [];
      _uids = [];

      {
        if (isPlayer _x) then
        {
          _allPlayers pushBack _x;
        };
      } forEach playableUnits;
      
      
      {
			
        _uids pushBack (getPlayerUID _x);   
        
      } foreach _allplayers;
      
      
      _condition = true;			
			
			{
			
				if (_x in _uids) exitwith {
				
					_condition = false;
				
				};
			
			} foreach Hz_pops_restrictions_supervisorList;
      
      if (_condition) then {
        
        _deadplayers = [];
        
        {
          if (isPlayer _x) then
          {
            _deadplayers pushBack _x;
          };
        } forEach Alldead;
        
        _deaduids = [];
        
        {
				
					_deaduids pushBack (getPlayerUID _x);
				
				} foreach _deadplayers;
        
        _condition = true;				
				
				{
				
					if(_x in _deaduids) exitwith {
					
					_condition = false;
					
					};
				
				} foreach Hz_pops_restrictions_supervisorList;
        
        if (_condition && (alive player)) then {
				
					Hz_pops_restrictionSupervisorCheckPassed = false;
					//in case he's using store or something...
					if (dialog) then {
						waituntil {!dialog};
						disableUserInput true;
						hintsilent "Please wait...";
						uisleep 5;
						disableUserInput false;
						uisleep 0.1;
					};
          endMission "publicRestriction"; 
          
        } else {Hz_pops_restrictionSupervisorCheckPassed = true;}; 
				
				
			} else {Hz_pops_restrictionSupervisorCheckPassed = true;}; 
      
      sleep 20;
    };

  };

} else {
	Hz_pops_restrictionSupervisorCheckPassed = true;
};



//public player ratio limitation
waituntil {sleep 0.1; !isnil "Hz_playertype"};
if ((toupper Hz_playertype) != "SUPERVISOR") then {

  if ((Hz_publicPlayerRatioLimit > 0) && 
      ((toupper Hz_playertype) != "JOINTOP") &&
      ((toupper Hz_playertype) != "PUBLICNOLIMIT")) then {

    _countSupervisors = ({(getplayeruid _x) in Hz_pops_restrictions_supervisorList} count playableunits) + 
    ({(getplayeruid _x) in Hz_pops_restrictions_supervisorList} count alldead);    

    _countNonSupervisors = ({!((getplayeruid _x) in Hz_pops_restrictions_supervisorList)} count playableunits) + 
    ({if(isplayer _x) then {!((getplayeruid _x) in Hz_pops_restrictions_supervisorList)} else {false}} count alldead);  

    
    if ((_countSupervisors/_countNonSupervisors) < Hz_publicPlayerRatioLimit) then {
      
			Hz_pops_restrictionPublicLimitCheckPassed = false;		
      endMission "playerLimit"; 
      
    } else {		
		
			Hz_pops_restrictionPublicLimitCheckPassed = true;
			
			//less has priority
			player setVariable ["JoinTime",serverTime,true];
			
			//becomes redundant so kill other loop
			terminate supervisorHandler;
			
			[] spawn {
			
				sleep 20;
				
				_joinTime = player getVariable "JoinTime";
				
				while {true} do {
				
					_countSupervisors = ({(getplayeruid _x) in Hz_pops_restrictions_supervisorList} count playableunits) + 
					({(getplayeruid _x) in Hz_pops_restrictions_supervisorList} count alldead);    

					_countNonSupervisors = ({!((getplayeruid _x) in Hz_pops_restrictions_supervisorList)} count playableunits) + 
					({if(isplayer _x) then {!((getplayeruid _x) in Hz_pops_restrictions_supervisorList)} else {false}} count alldead);  
					
					if (
							((_countSupervisors/_countNonSupervisors) < Hz_publicPlayerRatioLimit)
							&& {
									(_countSupervisors == 0)
									||
									{
										((vehicle player) == player)
										&& {
										
													_fobPos = call Hz_func_locateFOB;
													if (_fobPos isEqualTo [0,0,0]) then {
													
														((player distance (markerpos "respawn_west")) < 500)
													
													} else {
													
														((player distance (markerpos "respawn_west")) < 500)
														||
														{(player distance _fobPos) < 500}
													
													}
											}										
									}									
								}							
						) then {
						
						//check who's next to be kicked
						_highest = 0;
						{
						
							if (isPlayer _x) then {
							
								_value = _x getVariable ["JoinTime",0];
							
								if (_value > _highest) then {
								
									_highest = _value;
								
								};
							
							};
						
 						} foreach (alldead + playableunits);
						
						if (_highest <= _joinTime) then {
						
							//in case he's using store or something...
							if (dialog) then {
								waituntil {!dialog};
								disableUserInput true;
								hintsilent "Please wait...";
								uisleep 5;
								disableUserInput false;
								uisleep 0.1;
							};
							endMission "playerLimit"; 
							
						};
						
					};
					
					sleep 20;
				
				};			
			
			};
		
		};
    
  } else {Hz_pops_restrictionPublicLimitCheckPassed = true;};

} else {Hz_pops_restrictionPublicLimitCheckPassed = true;};

setterraingrid 50;
setviewdistance 1600;

waituntil {sleep 0.1; !isnil "Hz_pops_restrictionSupervisorCheckPassed"};
waituntil {sleep 0.1; !isnil "Hz_pops_restrictionPublicLimitCheckPassed"};

if (!Hz_pops_restrictionSupervisorCheckPassed || !Hz_pops_restrictionPublicLimitCheckPassed) exitwith {};

_exit = false;

if (isMultiplayer && {Hz_pops_enableDetainUnrecognisedUIDs}) then {
	
	if (!((getPlayerUID player) in Hz_pops_releasedUIDs)) then {
	
		_exit = true;
	
		//ping supervisors
		[-1, {
		
			if (call Hz_func_isSupervisor) then {
		
				hint "A new player has joined and is now being detained!";
		
			};
		
		}] call CBA_fnc_globalExecute;		
	
		[] spawn {
		
			player setvariable ["animAllowed",false];
			player forceWalk true;
		
			Hz_pops_abortClimbEH = player addEventHandler ["AnimChanged", {
					if (local (_this select 0) && {_this select 1 == "ACE_Climb"}) then {
							// abort climb animation
							[_this select 0, "AmovPercMstpSnonWnonDnon", 2] call ace_common_fnc_doAnimation;
							
					};
			}];
		
			call Hz_pers_API_disablePlayerSaveStateOnDisconnect;
			player setposatl Hz_pops_detainPosition;				
			
			sleep 1;
			
			waituntil {sleep 1; ((!alive player) || ((player distance Hz_pops_detainPosition) > 50))};

			if ((player distance Hz_pops_detainPosition) > 50) then {
			
				Hz_pops_releasedUIDs pushBack (getPlayeruid player);
				publicVariable "Hz_pops_releasedUIDs";
				call Hz_pers_API_enablePlayerSaveStateOnDisconnect;
				player removeEventHandler ["AnimChanged",Hz_pops_abortClimbEH];	
				player setvariable ["animAllowed",true];	
				player forceWalk false;				
				Hz_pers_clientReadyForLoad = true;
			
			};
		
		};
	
	};
	
};

[] spawn {

	sleep 5;
	_uid = getPlayerUID player;
	_index = -1;
	{

		if (_x == _uid) exitWith {_index = _foreachIndex};

	} foreach Hz_pops_restrictions_supervisorList;

	if (_index == -1) exitWith {};

	rankInsignia = Hz_pops_supervisor_rankPatches select _index;

	fnc_setRankInsignia = {

		[player , ""] call BIS_fnc_setUnitInsignia;
		sleep 2;
		[player , rankInsignia] call BIS_fnc_setUnitInsignia;

	};

	player addEventHandler ["InventoryClosed",{

		[] spawn fnc_setRankInsignia;

	}];

	[missionNamespace,"arsenalClosed", {

		[] spawn fnc_setRankInsignia;
		
	}] call BIS_fnc_addScriptedEventHandler;

	call fnc_setRankInsignia;

};

[] spawn {

	_uid = getplayeruid player;
	_tentpos = getMarkerPos _uid;
	_tentposx = _tentpos select 0;
	_tentposy = _tentpos select 1;
	_tentposz = _tentpos select 2;

	mps_rallypoint_tent = objnull;

	if(!((_tentposx == 0) && (_tentposy == 0) && (_tentposz == 0))) then {
		
		_objectsarr = _tentpos nearEntities [[Hz_pops_rallyTentType],100];
		
		{if(_x getvariable "owneruid" == _uid) exitWith {mps_rallypoint_tent = _x;};} foreach _objectsarr;
		
		//Tent destroyed
		if(!alive mps_rallypoint_tent) exitwith {deletemarker _uid;};
		
		RALLY_STATUS = true;
		
		//Replaced with extended persistency
		/*
		hint "Would you like to deploy at your tent?";
		sleep 2;
		mps_respawned_player = false;
		createDialog "mps_respawn_dialog";
		*/
		
		waituntil {
			sleep 60;  
			!alive mps_rallypoint_tent
		};

		deleteVehicle mps_rallypoint_tent;
		deleteMarker _uid;

		RALLY_STATUS = false;
		
	};


};

if (_exit) exitWith {};

Hz_pers_clientReadyForLoad = true;
showScoretable 0;


[] spawn {
	scriptName "Hz_ACE_advanced_fatigue_rebalance";		
	while {true} do {
			sleep 5;
			ace_advanced_fatigue_anfatigue = 1;
	};
};
