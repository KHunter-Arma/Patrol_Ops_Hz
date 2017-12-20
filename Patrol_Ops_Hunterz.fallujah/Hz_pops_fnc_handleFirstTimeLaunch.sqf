#include "\x\Hz\Hz_mod_persistency\parsing_descriptors.txt"

["Hz_econ_funds",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["civ_killed_count",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["nuke_event",ONE_D_ARRAY,true] call Hz_pers_API_addMissionVariable;
["Hz_save_radar_spawn_timer",SINGLE_VARIABLE,false] call Hz_pers_API_addMissionVariable;
["Hz_save_radar_pos",SINGLE_VARIABLE,false] call Hz_pers_API_addMissionVariable;
["Hz_save_arty_spawn_timer",SINGLE_VARIABLE,false] call Hz_pers_API_addMissionVariable;
["Hz_save_arty_pos",SINGLE_VARIABLE,false] call Hz_pers_API_addMissionVariable;
["Hz_save_arty_rocketArty",SINGLE_VARIABLE,false] call Hz_pers_API_addMissionVariable;
["BanList",ONE_D_ARRAY,true] call Hz_pers_API_addMissionVariable;
["Hz_save_prev_tasks_list",ONE_D_ARRAY,false] call Hz_pers_API_addMissionVariable;
["weather_fog",SINGLE_VARIABLE,false] call Hz_pers_API_addMissionVariable;
["weather_wind",SINGLE_VARIABLE,false] call Hz_pers_API_addMissionVariable;
["weather_rain",SINGLE_VARIABLE,false] call Hz_pers_API_addMissionVariable;
["weather",SINGLE_VARIABLE,false] call Hz_pers_API_addMissionVariable;
["nukeweather",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["nukeweatherCounter",SINGLE_VARIABLE,false] call Hz_pers_API_addMissionVariable;
["owner",true] call Hz_pers_API_addObjectVariable;
["owneruid",true] call Hz_pers_API_addObjectVariable;

if (Hz_pops_enableDetainUnrecognisedUIDs) then {
	
	["Hz_pops_releasedUIDs",ONE_D_ARRAY,true] call Hz_pers_API_addMissionVariable;
	
};