// Written by EightySix & Hunter

//mps_self_heal_condition = "damage player > 0.2 && damage player < 0.9";
mps_rally_condition = "player distance ( getMarkerPos format[""respawn_%1"",(SIDE_A select 0)] ) > 2000 && !RALLY_STATUS && ((position player) select 2) < 2";

mps_rallypoint = player addaction ["<t color=""#ffc600"">Build Rallypoint</t>",(mps_path+"action\mps_buildtent.sqf"),[],0,true,true,"",mps_rally_condition];
mps_client_hud_act = player addAction [localize "STR_Client_HUD_menu",(mps_path+"action\mps_hud_switch.sqf"),[],-1,false,false,"",""];
//actionreset = 0;
Killed_EH_block = false;

if( if( !isNil "ace_wounds_enabled" ) then { false } else { true } ) then {

//	mps_self_heal = player addaction ["<t color=""#ff0000"">Apply First Aid to self</t>",(mps_path+"action\mps_ais_firstaid_self.sqf"),[],99,true,true,"",mps_self_heal_condition];

};


/*
if( isNil "CMSEH" ) then {

player addEventHandler ["Hit",

[] spawn {



};];
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
               WaitUntil{sleep 0.1; openMap false; 0 fadeSound 0; acre_sys_core_globalVolume = 0; alive player };
               
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
                       
                player addaction ["<t color=""#ffc600"">Build Rallypoint</t>",(mps_path+"action\mps_buildtent.sqf"),[],0,true,true,"",mps_rally_condition];
                player addAction [localize "STR_Client_HUD_menu",(mps_path+"action\mps_hud_switch.sqf"),[],-1,false,false,"",""];
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
        
        sleep (random 3);
        
        if(Hz_patrol_task_in_progress)  then { 
        
        mps_mission_deathcount = mps_mission_deathcount - 1; 
        publicVariable "mps_mission_deathcount";
        sleep 1;
        //Lives limit deprecated -- replaced by financial failure
      //  hint parseText format["Acceptable Mission Casualties Left: %1",mps_mission_deathcount];
        
        } else {
    
        hz_funds = hz_funds - 50000;
        publicVariable "hz_funds";

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


player addeventhandler ["Respawn", {
    
_unit = _this select 0;
_corpse = _this select 1;

[_unit,_corpse] spawn {           
                
_unit = _this select 0;
_corpse = _this select 1;

_unit setvariable ["known_by_CAS",false,true];

removeallweapons _unit;
removeallitems _unit;

[_unit, "ALL"] call ACE_fnc_RemoveGear;
[_unit,1,1,1,true] call ACE_fnc_PackIFAK;
[_corpse,0,0,0,true] call ACE_fnc_PackIFAK;


_weponback = [_corpse] call ACE_fnc_WeaponOnBackName;
[_corpse, ""] call ACE_fnc_AddWeaponOnBack;

[_unit, _weponback] call ACE_fnc_AddWeaponOnBack;

{_unit addweapon _x;} foreach weapons _corpse;
removeallitems _corpse;
{_unit addmagazine _x;} foreach magazines _corpse;
removeallweapons _corpse;

_MagazinesList = [_corpse] call ACE_fnc_RuckMagazinesList;
{
    _success = [_unit, _x select 0, _x select 1] call ACE_fnc_PackMagazine; 
} forEach _MagazinesList;

_WeaponsList = [_corpse] call ACE_fnc_RuckWeaponsList;
{
   _success = [_unit, _x select 0, _x select 1] call ACE_fnc_PackWeapon;
} forEach _WeaponsList;

[_corpse, "ALL"] call ACE_fnc_RemoveGear;
_corpse setvariable ["NoDelete",false,true];
 
//trying to solve that dreadful bug.... 
sleep 3;
//if((toupper _weponback) == (toupper (secondaryweapon player))) then {player removeweapon _weponback;};
//if((toupper _weponback) == (toupper (primaryweapon player))) then {player removeweapon _weponback;};
if(_weponback in (weapons player)) then {player removeweapon _weponback;};
[_corpse,0,0,0,true] call ACE_fnc_PackIFAK;

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


// Hunter'z Event Handlers

"mp_c130_main"          addPublicVariableEventHandler {[]execvm "logistics\mplights.sqf"; };
"weather"               addPublicVariableEventHandler {[]execvm "logistics\weathersync.sqf"; };
"baboom"                addPublicVariableEventHandler {[]execvm "lk\nuke\nuke.sqf"; };
"disablesimdead"        addPublicVariableEventHandler {{_x enablesimulation false;} foreach alldead; };

ehready = true;