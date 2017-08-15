#define COMPONENT sys_wounds
#include "\x\ace\addons\main\script_mod.hpp"

// #define DEBUG_ENABLED_SYS_WOUNDS

#ifdef DEBUG_ENABLED_SYS_WOUNDS
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_SYS_WOUNDS
	#define DEBUG_SETTINGS DEBUG_SETTINGS_SYS_WOUNDS
#endif

#include "\x\ace\addons\main\script_macros.hpp"

#define EPI "ACE_Epinephrine"
#define BND "ACE_Bandage"
#define LRGBND "ACE_LargeBandage"
#define MOR "ACE_Morphine"
#define CAT "ACE_Tourniquet"
#define KIT "ACE_Medkit"

// Timings
#define DELAY (7 + random 8)
#define CYCLE_TIME 0.15 // 0.15? Xeno: The 0.15 cycle time is to have a quite tight loop running. Afair some features need this.
#define CYCLE_TIME_FACTOR 10


// Legend
// DIV = DIVIDER
// COEF = COEFICIENT
// DAM = DAMAGE
// CEIL = CEILING (MAXIMUM)
// FLOOR = (MINIMUM)

// TODO: Convert dividers to coef??
// TODO: Add constants for states ?
// TODO: Add constant for SH MAX_BLEED (before death) (currently: 1) - Also need to add the defines for the 0.99 ...
// TODO: Improve constant naming consistency

/* STATES
	800 - Bleeding
	801 - Blackouts every now and then
	802 - Permanent unconscious
	10000 - DEAD
*/

// Prevents units from dying upon impact alone, only used when hd2 does not force a damage
#define MAX_UNFORCED_DAM 0.89

// PMR - Poor Mans Revive
// Head / Body
#define MAX_PMR_DAM 0.89
#define HEAD_BODY_MAX_PMR_DAM 0.7
// Hands / Legs
#define MAX_PMR_DAM2 9
#define ARMS_LEGS_MAX_PMR_DAM MAX_PMR_DAM2
#define MAX_UNC_TIME 9999999

#define STAMINA_COEF 1

///////////////////////////////////
// hd2 - effects of the hit itself

// Max damage for each state, if more damage, then pick next state. When beyond STATE_801_MAX, state 802 starts
#define STATE_800_HEAD_BODY_DAM_MAX 0.5
#define STATE_800_ARMS_LEGS_DAM_MAX 8
#define STATE_801_HEAD_BODY_DAM_MAX 0.8
#define STATE_801_ARMS_LEGS_DAM_MAX 15

#define STATE_801_BLOSS_COEF 2
#define STATE_802_BLOSS_COEF 4

// These values are added to the current (bloodloss, pain, etc) rate upon hit
// Bloss/pain values of the unit are increased by the current rate every few frames
// until bleeding stopped + pain stopped and not unconsciouss anymore
// and are only used for head and body shots
#define STATE_800_BLOSS_ADD 0.0004 // 0.0003
#define STATE_800_PAIN_ADD 0.0003  //0.00005
#define STATE_801_BLOSS_ADD 0.0006  //0.0006
#define STATE_801_PAIN_ADD 0.0002 //0.0002
#define STATE_802_BLOSS_ADD 0.0008  //0.001
#define STATE_802_PAIN_ADD 0.0001

// "" part, head, body, arms, legs
// Applied on input damage (damage given as parameter by engine handleDamage eventhandler)
#define OVERALL_DAM_COEF 1
#define HEAD_DAM_COEF 1.2
#define BODY_DAM_COEF 0.6 // Lowered to account for increased damage, and lower damage decrease on distance, as per v1.60
#define HANDS_DAM_COEF 0.25
#define LEGS_DAM_COEF 0.35

#define DIFFICULTY_COMPENSATION_COEF 1.2

// Workaround for easily breaking legs from falling
#define FALL_DAM_TRESHOLD 0.125
#define FALL_DAM_DIV 3.33

#define HEAD_BODY_DAM_BLOSS_DIV 15000
#define ARMS_LEGS_DAM_BLOSS_DIV 35000

// How much BLOSS will the hit itself cause (coef is used upon bloss calculation from hit/energy)
#define HIT_BLOSS_COEF 220 // 150 // 100 // ????

#define BLOSS_MOVE_COEF 0.44
#define PAIN_MOVE_COEF 0.88

// Used to reduce the damage somewhat
// TODO needs to be looked at why exactly
#define DAMAGE_DIFF_DIV 3

// Used to ignore damage lower than floor for units inside vehicles
// to workaround issue where non explosive projectile hitting the vehicle, cause damage to crew inside (without actual penetrating the vehicle)
#define VEH_CREW_DAM_FLOOR 0.02
// Used for "" part, checking for minimal damage when inside vehicle. Ignore lower.
#define MIN_PART_DAM 0.15


// Energy, Penetration, etc
#define PENETRATION_CEIL 220
#define BLOSS_COEF 0.00022 // 0.00013
#define BLOSS_DIV 2000
#define HANDS_BLOSS_DIV 3000
#define ENERGY_COEF 0.00012 // 0.00012

#define BASE_PENETRATION_COEF 36 // Will be * _penetrationMultiplier


// Falling
#define ALWAYS_FALL_THRESHOLD 875
#define RANDOM_FALL_THRESHOLD 475
#define RANDOM_FALL_CHANCE 33 // ABORT if random(100) > RANDOM_FALL_CHANCE

#define KNOCK_OUT_TIME_BASE 4
#define FALL_ENERGY_DIV 750 // KNOCK_OUT_TIME_BASE is used at this energy level, and will be increased if more energy, and decreased if less energy

// AI Skill Handicap - Used when in State 800 or higher
#define AI_SKILL_COEF 0.5

///////////////////////////////////
// Statehandler - continues effects after hit, applied each 0.15s,
// until dead or going out of 800-802 state (e.g after bandaged, morphine, epi etc)

// Min initial value when statehandler starts
#define SH_INIT_MIN_BLEED 0.1
#define SH_INIT_MIN_PAIN 0.1

// Max bleed/pain for each state, if more, then pick next state. When beyond STATE_801_MAX, state 802 starts
#define SH_STATE_800_MAX_BLEED 0.4 //0.4
#define SH_STATE_800_MAX_PAIN 0.5 //0.6
#define SH_STATE_801_MAX_BLEED 0.6 //0.75
#define SH_STATE_801_MAX_PAIN 0.8 //0.95


// Medication defines
// CPR 
#define __cardiactime1 	20 //TODO: Adjust
#define __cardiactime2 	30 //TODO: Adjust
// CAT PAIN DELAY
#define CAT_INDUCED_PAIN_DELAY 30
// How long does the morphine work
#define MOR_DURATION 2000

//////////////////////////
// MenuDef (Others/Self)

// What damage is considered heavy (and thus need others to assist, cannot do self)
#define LOW_DAMAGE_CEIL 0.3
