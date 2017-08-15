//Call from initserver

civtotal = 0;
maxcivcount = 30;
civ_killed_count = 0;

allcivtypes = ["TK_CIV_Takistani01_EP1","TK_CIV_Takistani02_EP1","TK_CIV_Takistani03_EP1","TK_CIV_Takistani04_EP1","TK_CIV_Takistani05_EP1","TK_CIV_Takistani06_EP1","TK_CIV_Worker01_EP1","TK_CIV_Worker02_EP1","TK_CIV_Woman01_EP1","TK_CIV_Woman02_EP1","TK_CIV_Woman03_EP1","CIV_EuroMan01_EP1","Citizen3_EP1","Haris_Press_EP1"];

hoscivtypes = ["TK_CIV_Takistani01_EP1","TK_CIV_Takistani02_EP1","TK_CIV_Takistani03_EP1","TK_CIV_Takistani04_EP1","TK_CIV_Takistani05_EP1","TK_CIV_Takistani06_EP1","TK_CIV_Worker01_EP1","TK_CIV_Worker02_EP1"];



if (civ_debug) then {[-1, {hint"Hunter'z Civilian Script initialised!";}] call CBA_fnc_globalExecute;};

//To disable, set to nil. To enable set to true. If set to false, then civilian system will not initialise! I recommend using when there are triggers that are neighbouring each other, instead of triggers seperated nicely over the map. A map like Fallujah probably will need it if you split the city into sections.
Hz_civ_global_safe = nil;

//Offload processing of civilian AI to clients. This doesn't include hosile civs, since they stop attacking players when they're switched to client owner for some reason.
Hz_civ_enable_client_processing = false;
//increase multiplier to increase number of civs per area
Hz_civ_multiplier = 0.75;

Hz_civ_initdone = true;