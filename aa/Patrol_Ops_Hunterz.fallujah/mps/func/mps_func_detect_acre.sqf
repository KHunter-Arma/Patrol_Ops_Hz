// Written by MSO Team
// Modified by Eightysix

if(isDedicated) exitWith{};

mps_acre_enabled = isClass(configFile/"CfgPatches"/"acre_main");

if (mps_acre_enabled) then {
	
	runOnPlayers = {
		[] spawn {
			waitUntil {!isNil "mps_ikey"};
			["player", [mps_ikey], 4, [mps_path+"func\mps_func_callAcreSync.sqf", "main"]] call CBA_ui_fnc_add;
		};
	};
	
	if (!isDedicated) then {
		if (!isNull player) then {
			call runOnPlayers;
		}else{
			[] spawn {
				waitUntil {!isNull player};
				call runOnPlayers;
			};
		};
	};
};