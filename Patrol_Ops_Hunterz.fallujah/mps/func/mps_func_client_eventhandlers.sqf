// Written by EightySix & Hunter

//mps_self_heal_condition = "damage player > 0.2 && damage player < 0.9";
mps_rally_condition = "player distance ( getMarkerPos format[""respawn_%1"",(SIDE_A select 0)] ) > 2000 && !RALLY_STATUS && (((position player) select 2) < 2) && ((vehicle player) == player)";

mps_rallypoint = player addaction ["<t color=""#ffc600"">Build Tent</t>",(mps_path+"action\mps_buildtent.sqf"),[],0,false,false,"",mps_rally_condition];
mps_client_hud_act = player addAction [localize "STR_Client_HUD_menu",(mps_path+"action\mps_hud_switch.sqf"),[],-1,false,false,"",""];
//actionreset = 0;
Killed_EH_block = false;

/*
if( if( !isNil "ace_wounds_enabled" ) then { false } else { true } ) then {

  mps_self_heal = player addaction ["<t color=""#ff0000"">Apply First Aid to self</t>",(mps_path+"action\mps_ais_firstaid_self.sqf"),[],99,true,true,"",mps_self_heal_condition];

};
*/

//player addEventHandler ["Killed",{player spawn mps_respawn_gear}];

player addEventHandler ["Killed",{
  
  if(Killed_EH_block) exitwith {};
  Killed_EH_block = true;
  player setvariable ["NoDelete",true,true];
  
  mps_killed_event = [(_this select 0),(_this select 1),PlayerSide]; publicVariable "mps_killed_event";
  
  //player removeAction mps_self_heal;
  
  disableUserInput false;
  
  [] spawn {

    [cim_action_getDown1] call CBA_fnc_removePlayerAction;
    [cim_action_getDownAll] call CBA_fnc_removePlayerAction;
    [cim_action_getAway1] call CBA_fnc_removePlayerAction;
    [cim_action_getAwayAll] call CBA_fnc_removePlayerAction;
    [cim_action_getInside1] call CBA_fnc_removePlayerAction;
    [cim_action_getInsideAll] call CBA_fnc_removePlayerAction;
    [cim_action_StopCar] call CBA_fnc_removePlayerAction;
    [cim_action_Search] call CBA_fnc_removePlayerAction;
    [cim_action_Disarm] call CBA_fnc_removePlayerAction;
    [cim_action_getDownAll] call CBA_fnc_removePlayerAction;
    [cim_action_Pacify] call CBA_fnc_removePlayerAction;
    [cim_action_Arrest] call CBA_fnc_removePlayerAction;
    [cim_action_release] call CBA_fnc_removePlayerAction;
    [cim_action_uncuff] call CBA_fnc_removePlayerAction;
    player removeaction mps_rallypoint;
    player removeaction mps_client_hud_act;     
    
    sleep 2;
    WaitUntil{openMap false; 0 fadeSound 0; acre_sys_core_globalVolume = 0; alive player };
    
    Killed_EH_block = false;
    
    if (nukeweather) then {
      
      snow attachto [player, [0,5,3]];
      
    };
    
    [cim_action_getDown1] call CBA_fnc_removePlayerAction;
    [cim_action_getDownAll] call CBA_fnc_removePlayerAction;
    [cim_action_getAway1] call CBA_fnc_removePlayerAction;
    [cim_action_getAwayAll] call CBA_fnc_removePlayerAction;
    [cim_action_getInside1] call CBA_fnc_removePlayerAction;
    [cim_action_getInsideAll] call CBA_fnc_removePlayerAction;
    [cim_action_StopCar] call CBA_fnc_removePlayerAction;
    [cim_action_Search] call CBA_fnc_removePlayerAction;
    [cim_action_Disarm] call CBA_fnc_removePlayerAction;
    [cim_action_getDownAll] call CBA_fnc_removePlayerAction;
    [cim_action_Pacify] call CBA_fnc_removePlayerAction;
    [cim_action_Arrest] call CBA_fnc_removePlayerAction;
    [cim_action_release] call CBA_fnc_removePlayerAction;
    [cim_action_uncuff] call CBA_fnc_removePlayerAction;
    player removeaction mps_rallypoint;
    player removeaction mps_client_hud_act;
    
    sleep 5;
    acre_sys_core_globalVolume = 1;
    0 fadesound 1;
    
    mps_rallypoint = player addaction ["<t color=""#ffc600"">Build Rallypoint</t>",(mps_path+"action\mps_buildtent.sqf"),[],0,false,false,"",mps_rally_condition];
    mps_client_hud_act = player addAction [localize "STR_Client_HUD_menu",(mps_path+"action\mps_hud_switch.sqf"),[],-1,false,false,"",""];
    cim_action_getDown1 = [['<t color="#FF0000">'+"Verbal Command: Get down!"+'</t>', (mps_path+"nielsen_cim_reinit\nielsen_cim_getDown_Client.sqf"), [player,false,cursorTarget], 10, false, true, CIM_Module getVariable "nielsen_cim_key_getDown","cim_key_pressed AND (side cursorTarget == CIVILIAN) AND (cursorTarget isKindof ""MAN"") AND (cursorTarget distance player > 2)"]] call CBA_fnc_addPlayerAction;
    cim_action_getDownAll = [['<t color="#FF0000">'+"Verbal Command: Get down!"+'</t>', (mps_path+"nielsen_cim_reinit\nielsen_cim_getDown_Client.sqf"), [player,true], 10, false, true, CIM_Module getVariable "nielsen_cim_key_getDown","cim_key_pressed AND !((cursorTarget isKindof ""MAN"") AND (side cursorTarget == CIVILIAN))"]] call CBA_fnc_addPlayerAction;

    cim_action_getAway1 = [['<t color="#FF0000">'+"Verbal Command: Clear area!"+'</t>', (mps_path+"nielsen_cim_reinit\nielsen_cim_getAway_Client.sqf"), [player,false,cursorTarget], 9, false, true, CIM_Module getVariable "nielsen_cim_key_getAway","cim_key_pressed AND (side cursorTarget == CIVILIAN) AND (cursorTarget isKindof ""MAN"") AND (cursorTarget distance player > 2)"]] call CBA_fnc_addPlayerAction;
    cim_action_getAwayAll = [['<t color="#FF0000">'+"Verbal Command: Clear area!"+'</t>', (mps_path+"nielsen_cim_reinit\nielsen_cim_getAway_Client.sqf"), [player,true], 9, false, true, CIM_Module getVariable "nielsen_cim_key_getAway","cim_key_pressed AND !((cursorTarget isKindof ""MAN"") AND (side cursorTarget == CIVILIAN))"]] call CBA_fnc_addPlayerAction;

    cim_action_getInside1 = [['<t color="#FF0000">'+"Verbal Command: Get inside!"+'</t>', (mps_path+"nielsen_cim_reinit\nielsen_cim_getInside_Client.sqf"), [player,false,cursorTarget], 8, false, true, CIM_Module getVariable "nielsen_cim_key_getInside","cim_key_pressed AND (side cursorTarget == CIVILIAN) AND (cursorTarget isKindof ""MAN"") AND (cursorTarget distance player > 2)"]] call CBA_fnc_addPlayerAction;
    cim_action_getInsideAll = [['<t color="#FF0000">'+"Verbal Command: Get inside!"+'</t>', (mps_path+"nielsen_cim_reinit\nielsen_cim_getInside_Client.sqf"), [player,true], 8, false, true, CIM_Module getVariable "nielsen_cim_key_getInside","cim_key_pressed AND !((cursorTarget isKindof ""MAN"") AND (side cursorTarget == CIVILIAN))"]] call CBA_fnc_addPlayerAction;

    cim_action_StopCar = [['<t color="#FF0000">'+"Verbal Command: Get out of the car!"+'</t>', (mps_path+"nielsen_cim_reinit\nielsen_cim_stopCar_Client.sqf"), [player], 7, false, true, CIM_Module getVariable "nielsen_cim_key_stopCar","cim_key_pressed AND (side cursorTarget == CIVILIAN) AND (cursorTarget isKindof ""CAR"") AND (cursorTarget distance player <= 75);"]] call CBA_fnc_addPlayerAction;

    cim_action_Search = [['<t color="#FF0000">'+"Search individual!"+'</t>', (mps_path+"nielsen_cim_reinit\nielsen_cim_search_Client.sqf"), [player], 10, false, true, CIM_Module getVariable "nielsen_cim_key_Search","cim_key_pressed AND (side cursorTarget == CIVILIAN) AND (alive cursorTarget) AND (cursorTarget distance player <= 2) AND (cursorTarget isKindof ""MAN"") AND !(cursorTarget in CIM_List_Searched)"]] call CBA_fnc_addPlayerAction;
    cim_action_Disarm = [['<t color="#FF0000">'+"Remove Belongings!"+'</t>', (mps_path+"nielsen_cim_reinit\nielsen_cim_disarm_Client.sqf"), [player], 10, false, true, CIM_Module getVariable "nielsen_cim_key_Search","cim_key_pressed AND (side cursorTarget == CIVILIAN) AND (alive cursorTarget) AND (cursorTarget distance player <= 2) AND (cursorTarget isKindof ""MAN"") AND (cursorTarget in CIM_List_Searched)"]] call CBA_fnc_addPlayerAction;

    cim_action_Pacify = [['<t color="#FF0000">'+"Key-cuff individual!"+'</t>', (mps_path+"nielsen_cim_reinit\nielsen_cim_Pacify_Client.sqf"), [player], 9, false, true, CIM_Module getVariable "nielsen_cim_key_Pacify","cim_key_pressed AND (side cursorTarget == CIVILIAN) AND (alive cursorTarget) AND (cursorTarget distance player <= 2) AND (cursorTarget isKindof ""MAN"") AND !(cursorTarget in CIM_List_Keycuff) AND (_target hasWeapon ""ACE_KeyCuffs"")"]] call CBA_fnc_addPlayerAction;
    
    cim_action_Arrest = [['<t color="#FF0000">'+"Detain individual!"+'</t>', (mps_path+"nielsen_cim_reinit\nielsen_cim_arrest_Client.sqf"), [player], 8, false, true, CIM_Module getVariable "nielsen_cim_key_Arrest","cim_key_pressed AND (side cursorTarget == CIVILIAN) AND (alive cursorTarget) AND (cursorTarget distance player <= 2) AND (group cursorTarget != group _target) AND (cursorTarget isKindof ""MAN"")"]] call CBA_fnc_addPlayerAction;

    cim_action_release = [['<t color="#FF0000">'+"Release individual!"+'</t>', (mps_path+"nielsen_cim_reinit\nielsen_cim_release_Client.sqf"), [player], 8, false, true, CIM_Module getVariable "nielsen_cim_key_release","cim_key_pressed AND (side cursorTarget == CIVILIAN) AND (alive cursorTarget) AND (cursorTarget distance player <= 2) AND (group cursorTarget == group _target) AND (cursorTarget isKindof ""MAN"")"]] call CBA_fnc_addPlayerAction;

    cim_action_uncuff = [['<t color="#FF0000">'+"Uncuff individual!"+'</t>', (mps_path+"nielsen_cim_reinit\nielsen_cim_uncuff_Client.sqf"), [player], 9, false, true, CIM_Module getVariable "nielsen_cim_key_release","cim_key_pressed AND (side cursorTarget == CIVILIAN) AND (alive cursorTarget) AND (cursorTarget distance player <= 2) AND (cursorTarget in CIM_List_KeyCuff) AND (cursorTarget isKindof ""MAN"")"]] call CBA_fnc_addPlayerAction;

    //  hint "Civilian Module reinitialised!";
    
    if(nukeweather) then {terminate ashhandle; sleep 5; ashhandle = player spawn ash;};
    
  };
  
  
  
  []spawn{
    
    if (!(player getVariable ["JointOps",false])) then {
    
    sleep (random 3);
    
    if(Hz_patrol_task_in_progress)  then {
      
      mps_mission_deathcount = mps_mission_deathcount - 1; 
      publicVariable "mps_mission_deathcount";
      sleep 1;
      //Lives limit deprecated -- replaced by financial failure
      //  hint parseText format["Acceptable Mission Casualties Left: %1",mps_mission_deathcount];
      
    } else {
      
      Hz_econ_funds = Hz_econ_funds - 50000;
      publicVariable "Hz_econ_funds";

    };
    
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

		_weaponHolder = (nearestObjects [_corpse, ["WeaponHolderSimulated"],5]) select 0;
		_weaponsItems = weaponsitemscargo _weaponHolder;

		deletevehicle _weaponHolder;
		removeAllWeapons _corpse;
		removeAllItems _corpse;
		removeAllAssignedItems _corpse;
		removeUniform _corpse;
		removeVest _corpse;
		removeBackpack _corpse;
		removeHeadgear _corpse;
		removeGoggles _corpse;
		
		uisleep 3;

    removeAllWeapons _corpse;
		removeAllItems _corpse;
		removeAllAssignedItems _corpse;
		removeUniform _corpse;
		removeVest _corpse;
		removeBackpack _corpse;
		removeHeadgear _corpse;
		removeGoggles _corpse;
		
		uisleep 1;
		
		_unit addvest _vestType;
		_unit addUniform _uniformType;
		_unit addbackpack _backpackType;
		_unit addHeadgear _headGear;
		_unit addGoggles _goggles;
		
		uisleep 1;
		
		{
			_unit addWeapon (_x select 0);
			
			//add magazine
			_magArray = _x select 4;
			if ((count _magArray) > 0) then {
				_unit addWeaponItem [(_x select 0), [(_magArray select 0), (_magArray select 1)]];
			};
			
			//Grenade launcher?
			if ((typename (_x select 5)) == "ARRAY") then {
				
				_magArray = _x select 5;
				if ((count _magArray) > 0) then {
					_unit addWeaponItem [(_x select 0), [(_magArray select 0), (_magArray select 1)]];
				};

			};
			
			//attachments
			_unit addWeaponItem [_x select 0, _x select 1];
			_unit addWeaponItem [_x select 0, _x select 2];
			_unit addWeaponItem [_x select 0, _x select 3];

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
		
		{
			_unit linkItem _x;
		}foreach _assignedItems;
		
    _corpse setvariable ["NoDelete",false,true];

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