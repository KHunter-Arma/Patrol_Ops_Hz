//compile functions and init global vars
HZ_spawncivs = compile preprocessFileLineNumbers "hunterz_civ_main.sqf";
Hz_despawncivs = compile preprocessFileLineNumbers "hunterz_civ_despawn.sqf";
Hz_civ_global_safe = true;
civtotal = 0;
civ_killed_count = 0;

// ==========================================================================
//                                PARAMETERS
// ==========================================================================

maxcivcount = 60;
hz_civ_hostileChance = 0.1;

allcivtypes = ["C_journalist_F","C_Journalist_01_War_F","C_man_p_beggar_F","LOP_Tak_Civ_Random","LOP_Tak_Civ_Random","LOP_Tak_Civ_Random","LOP_Tak_Civ_Random","C_man_p_beggar_F","LOP_Tak_Civ_Random","LOP_Tak_Civ_Random","LOP_Tak_Civ_Random","LOP_Tak_Civ_Random"];

hoscivtypes = ["C_man_p_beggar_F","LOP_Tak_Civ_Random","LOP_Tak_Civ_Random","LOP_Tak_Civ_Random","LOP_Tak_Civ_Random"];

// If enabled, multiple triggers won't be able to spawn civilians at exactly the same time. Could be useful if your triggers are all meshed up into each other and you drive fast...
Hz_ambw_civ_forceGlobalMutex = false;

//Offload processing of civilian AI to clients. This doesn't include hosile civs, since they refuse to attack enemies when they switch owner to client for some reason (Arma 2).
Hz_civ_enable_client_processing = false;

//increase multiplier to increase number of civs per area
Hz_civ_multiplier = 0.75;

// ==========================================================================
// ==========================================================================


Hz_civ_initdone = true;
if (civ_debug) then {[-1, {hint"Hunter'z Civilian Script initialised!";}] call CBA_fnc_globalExecute;};