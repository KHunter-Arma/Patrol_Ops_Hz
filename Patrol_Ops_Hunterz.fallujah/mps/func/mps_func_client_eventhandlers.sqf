// Written by EightySix & Hunter

//mps_self_heal_condition = "damage player > 0.2 && damage player < 0.9";
mps_rally_condition = "player distance ( getMarkerPos format[""respawn_%1"",(SIDE_A select 0)] ) > 2000 && !RALLY_STATUS && (((position player) select 2) < 2) && ((vehicle player) == player)";

//mps_rallypoint = player addaction ["<t color=""#ffc600"">Build Tent</t>",(mps_path+"action\mps_buildtent.sqf"),[],0,false,false,"",mps_rally_condition];
mps_client_hud_act = player addAction [localize "STR_Client_HUD_menu",(mps_path+"action\mps_hud_switch.sqf"),[],-1,false,false,"",""];
//actionreset = 0;
Killed_EH_block = false;

/*
if( if( !isNil "ace_wounds_enabled" ) then { false } else { true } ) then {

  mps_self_heal = player addaction ["<t color=""#ff0000"">Apply First Aid to self</t>",(mps_path+"action\mps_ais_firstaid_self.sqf"),[],99,true,true,"",mps_self_heal_condition];

};
*/

[player,["HandleScore", {false}]] remoteExecCall ["addEventHandler",2,false];

player addEventHandler ["Deleted", {
	params ["_dude"];
	if ("Files" in (magazines _dude)) then {
		Hz_pops_failFileTask = true;
		publicVariable "Hz_pops_failFileTask";
	};
}];

player addEventHandler ["InventoryOpened", {
	_container = _this select 1;
	if (_container getVariable ["RespawnedPlayerCorpse", false]) then {
		true
	} else {
		// dead player (could possibly also be valid for some other unknown cases...)
		if (isPlayer _container) then {
			_container spawn {
				disableSerialization;
				_timeout = time + 2;
				waitUntil {
					uisleep 0.1;
					(!isNull (findDisplay 602)) || {time > _timeout}
				};
				while {!isNull (findDisplay 602)} do {
					if (_this getVariable ["RespawnedPlayerCorpse", false]) exitWith {
						(findDisplay 602) closeDisplay 2;
					};
					uisleep 0.1;					
				};
			};
		};
	}
}];

player addEventHandler ["GetInMan",{

	if (!isnil {player getVariable "ace_medical_ivBags"}) then {
	
		if !((toUpper typeof (_this select 2)) in ["CUP_C_S1203_AMBULANCE_CIV","CUP_B_LR_AMBULANCE_CZ_W","CUP_B_LR_AMBULANCE_GB_W","C_VAN_02_MEDEVAC_F","CUP_B_HMMWV_AMBULANCE_USMC"]) exitwith {
		
			moveout player;
			hintsilent "You can only board an ambulance";
		
		};
	
		if ((_this select 1) != "cargo") then {
		
			moveout player;
			(_this select 2) spawn {
			
				uisleep 0.3;
				player moveInCargo _this;
			
			};
		
		};		
	
	};

}];

player addEventHandler ["SeatSwitchedMan",{

	if (!isnil {player getVariable "ace_medical_ivBags"}) then {
			
		if (((assignedVehicleRole player) select 0) == "Driver") then {
					
			hint "You're not able to drive";
			moveout player;
			(_this select 2) spawn {
			
				uisleep 0.3;
				player moveInCargo _this;
			
			};
		
		};
	
	};

}];

//player addEventHandler ["Killed",{player spawn mps_respawn_gear}];

gogglesAtDeath = "";
ownedWepHolders = [];
handgunWeaponPlayer = "";
primaryWeaponPlayer = "";
secondaryWeaponPlayer = "";
binocularPlayer = "";

player addEventHandler ["Killed",{
  
  if(Killed_EH_block) exitwith {};
  Killed_EH_block = true;
	
	_player = _this select 0;
	
  _player setvariable ["NoDelete",true,true];
  
  handgunWeaponPlayer = handgunWeapon _player;
  primaryWeaponPlayer = primaryWeapon _player;
  secondaryWeaponPlayer = secondaryWeapon _player;
	binocularPlayer = binocular _player; //odd case but looks like needed
	
	gogglesAtDeath = goggles _player;
	ownedWepHolders = [];
  
  mps_killed_event = [(_this select 0),(_this select 1),PlayerSide]; publicVariable "mps_killed_event";
  
  //player removeAction mps_self_heal;
    
  _player spawn {
	
		_player = _this;  
		
    sleep 2;
		
		_player action ["nvGogglesOff", _player];		
		
		_hasEarplugs = _player getvariable ["ACE_hasEarPlugsin",false];
		
		_weaponsNeedToBeFound = [];
		 
		{
		
			if (_x != "") then {
			
				_weaponsNeedToBeFound pushBack _x;
			
			};
		
		} foreach [handgunWeaponPlayer,primaryWeaponPlayer,secondaryWeaponPlayer,binocularPlayer];    

		_acreVol = [] call acre_api_fnc_getGlobalVolume;
		_vd = viewDistance;
		
		setViewDistance 250;
		setObjectViewDistance 250;
		
		//player setVariable ["acre_sys_core_isDisabled", true, true];
		{[_x,0] call acre_api_fnc_setRadioVolume} foreach (call acre_api_fnc_getCurrentRadioList);
    
		while {true} do {
    
			//try to resolve loop getting stuck with exitwith instead...
			if (alive player) exitwith {};
      
      openMap false;
			0 fadeSound 0;			
			[0] call acre_api_fnc_setGlobalVolume;			
		
		};
		
		if ((vehicle _player) == _player) then {
      
			_weaponHolders = nearestObjects [_player, ["WeaponHolderSimulated","WeaponHolder","GroundWeaponHolder"],30];
			
			{	
				_weps = weaponCargo _x;
				_wepHolder = _x;
				
				{
				
					if (_x in _weaponsNeedToBeFound) then {
					
						_weaponsNeedToBeFound = _weaponsNeedToBeFound - [_x];
						
						if (!(_wepHolder in ownedWepHolders)) then {
						
							ownedWepHolders pushBack _wepHolder;
						
						};
					
					};
				
				} foreach _weps;
			
			} foreach _weaponHolders;
      
		};
		    
    Killed_EH_block = false;
    
    if (nukeweather) then {
      
      snow attachto [player, [0,5,3]];
			
    };
		
		if (Hz_weather_sandstorm) then {
		
			["DESTROY"] call HA_fnc_sandStorm;
			["INIT",[false,"ALTERNATIVE_LOW",true,"DISABLE"]] call HA_fnc_sandStorm;  

		};
		
		sleep 5;
    
    //player removeaction mps_rallypoint;
    player removeaction mps_client_hud_act;
		player removeAction Hz_pops_roadPickupAction;
    
   [_acreVol] call acre_api_fnc_setGlobalVolume;	 
	 
	 [] spawn {
		sleep 7;
		{[_x,0.8] call acre_api_fnc_setRadioVolume} foreach (call acre_api_fnc_getCurrentRadioList);
	 };	 
		//player setVariable ["acre_sys_core_isDisabled", false, true];
		setViewDistance _vd;
		setObjectViewDistance _vd;
		if (_hasEarplugs) then {player setvariable ["ACE_hasEarPlugsin",true]};
    0 fadesound 1;
		
		[player,["HandleScore", {false}]] remoteExecCall ["addEventHandler",2,false];
		    
   // mps_rallypoint = player addaction ["<t color=""#ffc600"">Build Rallypoint</t>",(mps_path+"action\mps_buildtent.sqf"),[],0,false,false,"",mps_rally_condition];
    mps_client_hud_act = player addAction [localize "STR_Client_HUD_menu",(mps_path+"action\mps_hud_switch.sqf"),[],-1,false,false,"",""];
		call compile preprocessFileLineNumbers "logistics\moveRoadTiles.sqf";
    
    if(nukeweather) then {terminate ashhandle; sleep 5; ashhandle = player spawn ash;};
    
  };
	
  
  []spawn {
	
		_exit = false;
		
		if (Hz_pops_enableDetainUnrecognisedUIDs) then {
	
			if (!((getPlayerUID player) in Hz_pops_releasedUIDs)) then {
			
				_exit = true;
			
			};
			
		};
		
		if ((getPlayerUID player) in BanList) then {
		
			_exit = true;
		
		};
		
		if (_exit) exitWith {};
    
    if (!(player getVariable ["JointOps",false])) then {
    
			sleep (random 3);
					
			Hz_econ_funds = Hz_econ_funds - Hz_pops_playerDeathPenalty;
			publicVariable "Hz_econ_funds";
		
    };
    
    sleep 7;
    hint "You were killed. While your team-mates look for you and realise you are dead in a few moments, how about you make yourself a coffee? Or maybe browse the internet for some funny cat pictures? Anyway you will respawn in a couple of minutes...";

  };

  [] call mps_player_killed;

  //   mps_client_hud_act = player addAction [localize "STR_Client_HUD_menu",(mps_path+"action\mps_hud_switch.sqf"),[],-1,false,false,"",""];

  //if( if( !isNil "ace_wounds_enabled" ) then { false } else { true } ) then {

  //	mps_self_heal = player addaction ["<t color=""#FF0000"">Apply First Aid to self</t>",(mps_path+"action\mps_ais_firstaid_self.sqf"),[],99,true,true,"",mps_self_heal_condition];
  //			mps_rallypoint = player addaction ["<t color=""#ffc600"">Build Rallypoint</t>",(mps_path+"action\mps_buildtent.sqf"),[],0,true,true,"",mps_rally_condition];
  //};

}];

//used in respawn EH - normally defined only on server
Hz_pers_fnc_convert1DArrayTo2D = {
	
	private ["_return", "_typeArray", "_countArray", "_index"];
	
	_return = [[],[]];
	_typeArray = _return select 0;
	_countArray = _return select 1;

	{
		_index = _typeArray find _x;

		if (_index == -1) then {
			
			_typeArray pushBack _x;
			_countArray pushBack 1;
			
		} else {
			
			_countArray set [_index, (_countArray select _index) + 1]; 
			
		};

	} foreach _this;

	_return

};

player addeventhandler ["Respawn", {

  _this spawn {

    _unit = _this select 0;
    _corpse = _this select 1;
		
		if ((!isNil "_corpse") && {isObjectHidden _corpse}) then {
			deleteVehicle _corpse;
			sleep 1;
		};
		
		if ((isNil "_corpse") || {isNull _corpse}) exitWith {
			
			sleep 7;
			waitUntil {
				sleep 1;
				mps_respawned_player
			};
			sleep 3;
			
			hint "Your body was unable to be recovered. Your gear has been lost.";
		
		};
		
		_corpse setVariable ["RespawnedPlayerCorpse", true, true];
				
		_vestType = vest _corpse;
		_uniformType = uniform _corpse;
		_backpackType = backpack _corpse;
		_headgear = headgear _corpse;
		_goggles = goggles _corpse;
		_assignedItems = assignedItems _corpse;
		
		_backpackMags = [];

		if(!isnull (backpackContainer _corpse)) then {
			_backpackMags = magazinesAmmoCargo backpackContainer _corpse;
		};

		_vestMags = [];
		
		if(!isnull (vestContainer _corpse)) then {
			_vestMags = magazinesAmmoCargo vestContainer _corpse;
		};

		_uniformMags = [];
		
		if(!isnull (uniformContainer _corpse)) then {
			_uniformMags = magazinesAmmoCargo uniformContainer _corpse;
		};

		_temp = [];
		{

			if (!("CA_Magazine" in ([(configfile >> "cfgmagazines" >> _x), true] call bis_fnc_returnParents))) then {

				_temp pushback _x;

			};

		} foreach uniformItems _corpse;

		_uniformItems = _temp call Hz_pers_fnc_convert1DArrayTo2D;

		_temp = [];
		{

			if (!("CA_Magazine" in ([(configfile >> "cfgmagazines" >> _x), true] call bis_fnc_returnParents))) then {

				_temp pushback _x;

			};

		} foreach vestItems _corpse;

		_vestItems = _temp call Hz_pers_fnc_convert1DArrayTo2D;

		_temp = [];
		{

			if (!("CA_Magazine" in ([(configfile >> "cfgmagazines" >> _x), true] call bis_fnc_returnParents))) then {

				_temp pushback _x;

			};

		} foreach backpackItems _corpse;

		_backpackItems = _temp call Hz_pers_fnc_convert1DArrayTo2D;

		_weaponsItems = weaponsitems _corpse;
				
		{
			_weaponsItems = _weaponsItems + (weaponsitemscargo _x);
			deletevehicle _x;		
		} foreach ownedWepHolders;
		
		/*
		{diag_log _x} foreach [_vestType,
		_uniformType,
		_backpackType,
		_headGear,
		_goggles,
		_weaponsItems,
		_vestMags,
		_vestItems,
		_backpackMags,
		_backpackItems,
		_uniformMags,
		_uniformItems,
		_assignedItems]; 
		*/
		
		removeAllWeapons _corpse;
		removeAllItems _corpse;
		removeAllAssignedItems _corpse;
		
		// AWM compatibility (does weird things with animation and dialogs during respawn loadout handling)
		if ((player getVariable ["awm_sys_takeEH", -1]) != -1) then {
			player removeEventHandler ["Take", player getVariable "awm_sys_takeEH"];
			player removeEventHandler ["Put", player getVariable "awm_sys_putEH"];
			[] spawn {
				sleep 20;
				if (!alive player) exitWith {};
				awm_sys_weaponItems = primaryWeaponItems player;
				private _takeEH = player addEventHandler ["Take", {call awm_sys_fnc_handleItems}];
				player setVariable ["awm_sys_takeEH", _takeEH];
				private _putEH = player addEventHandler ["Put", {call awm_sys_fnc_handleItems}];
				player setVariable ["awm_sys_putEH", _putEH];
			};
			sleep 0.1;
		};
		
		sleep 5;
		
    removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;	
		removeGoggles _unit;
		
		sleep 1;
		
		_unit addvest _vestType;
		clearMagazineCargoGlobal (vestContainer _unit);
		clearWeaponCargoGlobal (vestContainer _unit);
		clearItemCargoGlobal (vestContainer _unit);
		_unit addUniform _uniformType;
		clearItemCargoGlobal (uniformContainer _unit);
		clearMagazineCargoGlobal (uniformContainer _unit);
		clearWeaponCargoGlobal (uniformContainer _unit);
		_unit addbackpack _backpackType;
		clearItemCargoGlobal (backpackContainer _unit);
		clearMagazineCargoGlobal (backpackContainer _unit);
		clearWeaponCargoGlobal (backpackContainer _unit);
		_unit addHeadgear _headGear;
	  _unit addGoggles gogglesAtDeath;
		
		sleep 1;
		
		{
				
			if (
					((_x select 0) == handgunWeaponPlayer)
					|| ((_x select 0) == primaryWeaponPlayer)
					|| ((_x select 0) == secondaryWeaponPlayer)
					|| ((_x select 0) in _assignedItems)
					) then {
			
				_unit addWeapon (_x select 0);	
				
				//add magazine
				_magArray = _x select 4;
				if ((count _magArray) > 0) then {
					_unit addWeaponItem [(_x select 0), [(_magArray select 0), (_magArray select 1)], true];
				};
				
				//attachments
				_wep = _x select 0;
				_wepComponents = _wep call BIS_fnc_weaponComponents;
				
				{
				
					if ((_x != "") && {!((tolower _x) in _wepComponents)}) then {
					
						_unit addWeaponItem [_wep, _x, true];
						sleep 0.1;
					
					};
				
				} foreach [_x select 1, _x select 2, _x select 3, _x select 6];
				
				_magArray = _x select 5;
				if ((count _magArray) > 0) then {
					_unit addWeaponItem [(_x select 0), [(_magArray select 0), (_magArray select 1)], true];
				};
				
			};

		} foreach _weaponsItems;
		
		_container = vestContainer _unit;
		{
			_container addMagazineAmmoCargo [_x select 0, 1, _x select 1];
		}foreach _vestMags;

		{
			_container addItemCargoGlobal [_x,(_vestItems select 1) select _foreachIndex];
		} foreach (_vestItems select 0);

		_container = backpackContainer _unit;
		{
			_container addMagazineAmmoCargo [_x select 0, 1, _x select 1];
		}foreach _backpackMags;

		{
			_container addItemCargoGlobal [_x,(_backpackItems select 1) select _foreachIndex];
		} foreach (_backpackItems select 0);

		_container = uniformContainer _unit;
		{
			_container addMagazineAmmoCargo [_x select 0, 1, _x select 1];
		}foreach _uniformMags;

		{
			_container addItemCargoGlobal [_x,(_uniformItems select 1) select _foreachIndex];
		} foreach (_uniformItems select 0);
		
		//addMagazineAmmoCargo does not add empty magazines...
		{

			if ((_x select 1) == 0) then {
			
				_unit addMagazine [_x select 0,0];
			
			};

		} foreach (_uniformMags + _vestMags + _backpackMags);
		
		{
			//does not add binoculars
			_unit linkItem _x;
		}foreach _assignedItems;
		
		if ("Files" in (magazines _unit)) then {
			_unit removeItem "Files";
			_files = "Item_Files" createVehicle [0,0,50000];
			sleep 1;
			_files setposatl ((getposatl _corpse) vectoradd [0,0,0.3]);
		} else {
			_corpse setvariable ["NoDelete",false,true];
		};    
		
		ownedWepHolders = [];
		
  };

}];





/*

[] spawn {
    
waitUntil {!(isNil "mps_ambient_insurgents")};

if(mps_ambient_insurgents) then {
    
        player addEventHandler ["killed",  {_handle = [] execVM "logistics\acm_reinit.sqf"}];
                };

};
*/
[] spawn {

	waitUntil {
		sleep 0.1;
		!isNil "Hz_playertype"
	};
	sleep 0.1;

	if ((toupper Hz_playertype) == "SUPERVISOR") then {

		private _uid = getPlayerUID player;
		private _rankFactor = (Hz_pops_supervisor_ranks select (Hz_pops_restrictions_supervisorList find _uid)) - 2;
		private _qualificationsFactor = _rankFactor;
		
		private _qualifications = [];
		{
			if (_uid == (_x select 0)) exitWith {
				_qualifications = (_x select 1) - ["TL", "SL"];		
				_qualificationsFactor = _qualificationsFactor + (count _qualifications);
			};
		} foreach Hz_pops_UIDdatabase;
		
		if (_qualificationsFactor < 0) then {
			_qualificationsFactor = 0;
		};
			
		Hz_pops_playerDeathPenalty = Hz_econ_penaltyPerPlayerdeath + Hz_econ_penaltyPerPlayerdeathPerQualification * _qualificationsFactor;
		
	} else {

		// half the cost for recruits
		Hz_pops_playerDeathPenalty = Hz_econ_penaltyPerPlayerdeath / 2;
		
	};
	
};

"mission_groupchat"	addPublicVariableEventHandler { player groupChat (_this select 1) };

"mission_globalchat"	addPublicVariableEventHandler { player globalChat (_this select 1) };

"mission_sidechat"	addPublicVariableEventHandler { [side player,"HQ"] sideChat (_this select 1) };

"mission_commandchat"	addPublicVariableEventHandler { [side player,"HQ"] commandChat (_this select 1) };

"mission_hint"		addPublicVariableEventHandler { hint parseText format["%1",_this select 1]; };

"mission_advhint"	addPublicVariableEventHandler { _message = _this select 1; _title = _message select 0; _content = _message select 1; _step = _message select 2; [_title,_content,_step] spawn mps_adv_hint; };

"mps_progress_bar_update"	addPublicVariableEventHandler { (_this select 1) call mps_progress_update; };

//"mps_mission_deathcount"	addPublicVariableEventHandler { hint parseText format["Acceptable Mission Casualties Left: %1",_this select 1]; };

"mps_admin_vehicle_lock" addPublicVariableEventHandler { (_this select 1) call mps_lock_vehicle; };

"mps_admin_vehicle_unlock" addPublicVariableEventHandler {  (_this select 1) call mps_unlock_vehicle; };

"mps_change_time" addPublicVariableEventHandler {  (_this select 1) spawn mps_timechange; };

"baboom"                addPublicVariableEventHandler {[]execvm "lk\nuke\nuke.sqf"; };