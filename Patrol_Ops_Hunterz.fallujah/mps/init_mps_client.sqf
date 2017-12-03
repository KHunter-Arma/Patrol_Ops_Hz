private ["_objectsarr","_uid","_tentpos","_tentposx","_tentposy","_tentposz"];

// Client Initialise

if(isDedicated) exitWith {};

if (!hz_debug && isMultiplayer) then {

  //delete UPS markers on client...
  deleteMarkerlocal "UPS";

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

// Begin Client Cursor Monitoring for actions on objects
[] execVM (mps_path+"func\mps_func_client_cursortarget.sqf");
GrassLayerchanged = false;

// Remove all gear from a joining player and equip defaults
//	[] execVM (mps_path+"config\config_defaultgear.sqf");


waitUntil {!(isNull player)};

sleep 1;

_uid = getplayeruid player;
if(_uid in BanList) then {

  hintc "You are banned from this server";
  endmission "End3";

};

// Publicvariabled from server init. Used to sync destroyed objects/buildings from nuke for JIP
if (count narray2 > 0) then {{_x setdamage 1;} foreach narray2;};

// Setup Respawn Variables
mps_body = player;
mps_death_effect = [] spawn {};

// Setup Client Event Handlers
call compile preprocessFileLineNumbers (mps_path+"func\mps_func_client_eventhandlers.sqf");

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
  [player] joinsilent (creategroup (SIDE_A select 0));
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

waituntil {introseqdone};

removeallweapons player;
removeallitems player;

if(!hz_debug) then {

  // player check
  [] spawn {

    if (call Hz_func_isSupervisor) exitwith{Hz_pops_restrictionSupervisorCheckPassed = true;};
    
    _uid = getPlayerUID player;

    while {true} do {
      
      _allPlayers = [];
      _uids = [];

      {
        if (isPlayer _x) then
        {
          _allPlayers = _allPlayers + [_x];
        };
      } forEach playableUnits;
      
      
      {
        _uid = getPlayerUID _x;
        _uids = _uids + [_uid];   
        
      }foreach _allplayers;
      
      
      _condition = {if (_x in _uids) exitwith {false}; true}foreach Hz_pops_restrictions_supervisorList;
      
      if (_condition) then {
        
        _deadplayers = [];
        
        {
          if (isPlayer _x) then
          {
            _deadplayers = _deadplayers + [_x];
          };
        } forEach Alldead;
        
        _deaduids = [];
        
        {_deaduids = _deaduids + [getPlayerUID _x];}foreach _deadplayers;
        
        _condition = {if(_x in _deaduids) exitwith {false}; true}foreach Hz_pops_restrictions_supervisorList;
        
        if (_condition) then {
				
					Hz_pops_restrictionSupervisorCheckPassed = false;
          
          hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! You are not allowed to play on this server without being supervised by a trained B.A.D. PMC member! You will now be returned to the lobby.</t>"];
          sleep 10;
          endMission "LOSER"; 
          
        } else {Hz_pops_restrictionSupervisorCheckPassed = true;}; };
      
      sleep 300;
    };

  };

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
			
      hint "WARNING\nThe maximum number of public players currently allowable on the server has been reached. You will now be returned to the lobby.";
			sleep 10;
      endMission "LOSER"; 
      
    } else {Hz_pops_restrictionPublicLimitCheckPassed = true;};
    
  } else {Hz_pops_restrictionPublicLimitCheckPassed = true;};

} else {Hz_pops_restrictionPublicLimitCheckPassed = true;};

setterraingrid 50;
setviewdistance 1600;

waituntil {sleep 0.1; !isnil "Hz_pops_restrictionSupervisorCheckPassed"};
waituntil {sleep 0.1; !isnil "Hz_pops_restrictionPublicLimitCheckPassed"};

if (!Hz_pops_restrictionSupervisorCheckPassed || !Hz_pops_restrictionPublicLimitCheckPassed) exitwith {};

Hz_pers_clientReadyForLoad = true;

_uid = getplayeruid player;
_tentpos = getMarkerPos _uid;
_tentposx = _tentpos select 0;
_tentposy = _tentpos select 1;
_tentposz = _tentpos select 2;

mps_rallypoint_tent = objnull;

if(!((_tentposx == 0) && (_tentposy == 0) && (_tentposz == 0))) then {
  
  _objectsarr = nearestobjects [_tentpos,[Hz_pops_rallyTentType],100];
  
  {if(_x getvariable "owneruid" == _uid) then {mps_rallypoint_tent = _x;};} foreach _objectsarr;
  
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

