/* ace_interact_menu_fnc_createAction
 *
 * Argument:
 * 0: Action name <STRING>
 * 1: Name of the action shown in the menu <STRING>
 * 2: Icon <STRING>
 * 3: Statement <CODE>
 * 4: Condition <CODE>
 * 5: Insert children code <CODE> (Optional)
 * 6: Action parameters <ANY> (Optional)
 * 7: Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
 * 8: Distance <NUMBER> (Optional)
 * 9: Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
 * 10: Modifier function <CODE> (Optional)
 */
 
 /* ace_interact_menu_fnc_addActionToObject
 * 
 * Argument:
 * 0: Object the action should be assigned to <OBJECT>
 * 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
 * 2: Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
 * 3: Action <ARRAY>
 */
 
private _action = [
	"Hz_requestTask",
	"Request mission",
	"\x\Hz\Hz_mod_economy\media\Hunterz_iconSmall.paa",
	{
	
		if(!taskrequested) then {
		
			if (serverTime > 14400) exitWith {
				if (!isnil "srvrst_mtx") exitWith {
					hint "Server is already scheduled to restart. Server will save and restart automatically after all players return to the lobby.";
				};
				remoteExec ["srvrst", 2, false];
				hintc "WARNING!\nServer has been running for more than 4 hours. A restart is required before requesting a mission. Server is now scheduled to automatically save and restart after all players return to the lobby.";
			};
		
			private _exit = false;
			private _fobPos = call Hz_func_locateFOB;
			private _basePos = markerpos "BASE";
			
			if (_fobPos isEqualTo [0,0,0]) then {
			
				{
			
					if ((_x distance _basePos) > 1000) exitWith {
					
						_exit = true;
					
					};
			
				} foreach playableUnits;				
			
			} else {
			
				{
			
					if (((_x distance _basePos) > 1000) || ((_x distance _fobPos) > 250)) exitWith {
					
						_exit = true;
					
					};
			
				} foreach playableUnits;
			
			};			
									
			if (_exit) exitWith {
			
				hint "All players must be at base or FOB to request a mission.";
			
			};
		
			taskrequested = true;
			publicVariable "taskrequested";
			
			hint "Mission requested. You will receive a new mission once the mission conditions are met.";
		
		} else {
		
			hint "A new mission has already been requested. You will receive a new mission only if all mission conditions are met.";
		
		};
	},
	{(player getvariable ["TL",false]) || hz_debug}
] call ace_interact_menu_fnc_createAction;

[player,1,["ACE_SelfActions"],_action] call ace_interact_menu_fnc_addActionToObject;

_action = [
	"Hz_initJointOp",
	"Initialise Joint Operation",
	"\x\Hz\Hz_mod_economy\media\Hunterz_iconSmall.paa",
	{
		if(!taskrequested && !jointops) then {
		
			jointops = true;
			publicVariable "jointops";
		
			hint "Initialising joint ops... You will receive a new task once the task conditions are met.";
		
		} else {
		
			hint "A new task has already been requested. You will receive a new task only if all task conditions are met.";
		
		};
	},
	{(player getvariable ["TL",false]) || hz_debug}
] call ace_interact_menu_fnc_createAction;

[player,1,["ACE_SelfActions"],_action] call ace_interact_menu_fnc_addActionToObject;

_action = [
	"Hz_adminMenu",
	"Admin System",
	"\x\Hz\Hz_mod_economy\media\Hunterz_iconSmall.paa",
	{
		[] execvm "HZ\dialogs\admin\HZ_admin_open.sqf";
	},
	{([] call Hz_func_isSupervisor) || hz_debug}
] call ace_interact_menu_fnc_createAction;

[player,1,["ACE_SelfActions"],_action] call ace_interact_menu_fnc_addActionToObject;