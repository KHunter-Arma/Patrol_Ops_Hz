//Call from initserver

HZ_spawncivs = compile preprocessFileLineNumbers "hunterz_civ_main.sqf";
Hz_despawncivs = compile preprocessFileLineNumbers "hunterz_civ_despawn.sqf";

civtotal = 0;
maxcivcount = 60;
civ_killed_count = 0;
hz_civ_hostileChance = 0.1;

allcivtypes = ["C_journalist_F","C_Journalist_01_War_F","C_man_p_beggar_F","LOP_Tak_Civ_Random"];

hoscivtypes = ["C_man_p_beggar_F","LOP_Tak_Civ_Random"];

if (civ_debug) then {[-1, {hint"Hunter'z Civilian Script initialised!";}] call CBA_fnc_globalExecute;};

//Comment out to disable. To enable set to true. If set to false, then civilian system will not initialise! I recommend using when there are triggers that are neighbouring each other, instead of triggers seperated nicely over the map. A map like Fallujah probably will need it if you split the city into sections.
// Hz_civ_global_safe = true;

//Offload processing of civilian AI to clients. This doesn't include hosile civs, since they stop attacking players when they're switched to client owner for some reason.
Hz_civ_enable_client_processing = false;
//increase multiplier to increase number of civs per area
Hz_civ_multiplier = 0.75;

Hz_civ_initdone = true;

