// ACE Self Interaction Conditions

// Self Interaction Menu not available if player is dead (thx cpt obvious) or unconscious
#define ACE_INTERACT_ALIVE (alive player)
#define ACE_INTERACT_UNCON (player call ace_sys_wounds_fnc_isUncon)

// If handcuffed also no actions available
#define ACE_INTERACT_CUFFED (player getVariable ["ace_sys_interaction_cuffed",false])

// Player is Player Vehicle
#define ACE_INTERACT_PLAYER (player == vehicle player)

// Player is climbing up a ladder
#define ACE_INTERACT_LADDER (animationState player in ["ladderriflestatic","laddercivilstatic"])

// Possible = Self interaction opens only if player is alive and conscious (can be in a vehicle)
#define ACE_SELFINTERACTION_POSSIBLE (!ACE_INTERACT_LADDER && {ACE_INTERACT_ALIVE} && {!ACE_INTERACT_UNCON} && {!ACE_INTERACT_CUFFED})

// Restricted = Self interaction opens only if player is alive and conscious (can NOT be in a vehicle, i.e Groundmarker, explosives ...)
#define ACE_SELFINTERACTION_RESTRICTED (ACE_SELFINTERACTION_POSSIBLE && {ACE_INTERACT_PLAYER})

// Close interaction menu if unconscious or handcuffed
#define ACE_INTERACT_FNC_EXIT if (ACE_INTERACT_UNCON || {ACE_INTERACT_CUFFED}) exitWith {}
#define ACE_ASSEMBLE (getNumber(configFile >> "CfgActions" >> "Assemble" >> "show") == 0)
#define ACE_DISASSEMBLE (getNumber(configFile >> "CfgActions" >> "DisAssemble" >> "show") == 0)
#define ACE_PIPEDEFAULT (getNumber(configFile >> "CfgMagazines" >> "PipeBomb" >> "useAction") == 0)
#define ACE_IDENTITYDEFAULT (isClass(configFile >> "CfgPatches" >> "ace_sys_combatdeaf"))
#define ACE_RUCKDEFAULT (isClass(configFile >> "CfgPatches" >> "ace_sys_stamina"))
