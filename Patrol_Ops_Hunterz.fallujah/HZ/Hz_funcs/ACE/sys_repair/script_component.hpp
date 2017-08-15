#define COMPONENT sys_repair
#include "\x\ace\addons\main\script_mod.hpp"

// #define DEBUG_ENABLED_SYS_REPAIR

#ifdef DEBUG_ENABLED_SYS_REPAIR
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_SYS_REPAIR
	#define DEBUG_SETTINGS DEBUG_SETTINGS_SYS_REPAIR
#endif

#include "\x\ace\addons\main\script_macros.hpp"

#define GET_CTRL(a) ((findDisplay 66361) displayCtrl ##a)

#define GET_SELECTED_DATA(a) ([##a] call FUNC(get_selected_data))
#define GET_SELECTED_VEHICLE ([] call FUNC(get_selected_vehicle))
#define GET_SELECTED_TURRET ([] call FUNC(get_selected_turret))
#define GET_CURRENT_MAGAZINES_TURRET [] call FUNC(get_current_magazines_turret)
#define GET_WEAPONS_TURRET ((GET_SELECTED_VEHICLE) weaponsTurret (GET_SELECTED_TURRET))

#define __HIDE(y) ((findDisplay 66361) displayCtrl ##y) ctrlEnable false
#define __SHOW(y) ((findDisplay 66361) displayCtrl ##y) ctrlEnable true

#define CHANGABLE_WEAPONS []
