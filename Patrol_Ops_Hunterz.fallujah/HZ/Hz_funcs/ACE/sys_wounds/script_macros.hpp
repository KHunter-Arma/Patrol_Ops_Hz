#include "\x\cba\addons\main\script_macros_common.hpp"

// Default versioning level
#define DEFAULT_VERSIONING_LEVEL 2

// RGB Colors
#define RGB_GREEN 0, 0.5, 0, 1
#define RGB_BLUE 0, 0, 1, 1
#define RGB_ORANGE 0.5, 0.5, 0, 1
#define RGB_RED 1, 0, 0, 1
#define RGB_YELLOW 1, 1, 0, 1
#define RGB_WHITE 1, 1, 1, 1
#define RGB_GRAY 0.5, 0.5, 0.5, 1
#define RGB_BLACK 0, 0, 0, 1
#define RGB_MAROON 0.5, 0, 0, 1
#define RGB_OLIVE 0.5, 0.5, 0, 1
#define RGB_NAVY 0, 0, 0.5, 1
#define RGB_PURPLE 0.5, 0, 0.5, 1
#define RGB_FUCHSIA 1, 0, 1, 1
#define RGB_AQUA 0, 1, 1, 1
#define RGB_TEAL 0, 0.5, 0.5, 1
#define RGB_LIME 0, 1, 0, 1
#define RGB_SILVER 0.75, 0.75, 0.75, 1

#include "script_macros_menudef.hpp"

#define ACE_NOARMORY class Armory { disabled = 1; }
#define ACE_ARMORY class Armory { disabled = 0; }
#define ACE_ACEARMORY class Armory { disabled = 0; author = "A.C.E."; }



// Weapon defaults
// NOTE !!!! - Do not forget to dummy-update the configs that use these defines, or the changes won't activate due to binarization!
#define ACE_DEFAULT_WEAPONS "Throw", "Put"
#define ACE_ROCK_PAPER_SCISSORS "ItemMap","ItemCompass","ItemWatch","ItemRadio"

#define ACE_DEFAULT_SLOTS "1	 + 	4	 + 12*		256	 + 2*	4096	 + 	2	 + 8*	16  + 12*131072"

#define ACE_NOGRIP handAnim[] = {}
#define ACE_DISTANCE_DEFAULT distanceZoomMin = 300; distanceZoomMax = 300

#include "script_macros_optics.hpp"

#define ACE_NOZEROING discreteDistance[] = {}; \
			discreteDistanceInitIndex = 0; \
			weaponInfoType = "RscWeaponEmpty"
			
#define ACE_NOTURRETZEROING discreteDistance[] = {}; \
			discreteDistanceInitIndex = 0; \
			turretInfoType = "RscWeaponEmpty"

#define ACE_LASER irLaserPos = "laser pos"; \
					irLaserEnd = "laser dir"; \
					irDistance = 300

#define ACE_LASER_DISTANCE_VANILLA irDistance = 300
					
#define ACE_NOLASER	irLaserPos = "laser pos"; \
					irLaserEnd = "laser dir"; \
					irDistance = 0

#define ACE_SUPPRESSED ace_suppressed = 1; \
			fireLightDuration = 0; \
			fireLightIntensity = 0

// TODO: Cleanup in all the configs around
#define ACE_M_MAG(x,y)	class _xx_##x {magazine = ##x; count = ##y;}
#define ACE_M_WEP(x,y)	class _xx_##x {weapon = ##x; count = ##y;}

// Vehicle defines
// ACE_canBeLoad = This vehicle acts as transporter, i.e you can load stuff into it
// ACE_canBeCargo = This vehicle acts as cargo, i.e you can load this item into other vehicles
#define ACE_CARGO_FRONT 	ACE_canBeLoad = false; ACE_canBeCargo = true; ACE_canGear = false; ACE_canLoadFront = true
#define ACE_CARGO_ONLY 		ACE_canBeLoad = false; ACE_canBeCargo = true; ACE_canGear = false; ACE_canLoadFront = false
#define ACE_LOAD_ONLY 		ACE_canBeLoad = true; ACE_canBeCargo = false; ACE_canGear = false; ACE_canLoadFront = false
#define ACE_GEAR_ONLY		ACE_canBeLoad = true; ACE_canBeCargo = false; ACE_canGear = true; ACE_canLoadFront = false
#define ACE_NOCARGOLOAD		ACE_canBeLoad = false; ACE_canBeCargo = false; ACE_canGear = false; ACE_canLoadFront = false

// Increased FOV for tank driver
// Increased Default US Tank driver optic
#define ACE_DRIVEROPTIC_TANK_US driverOpticsModel = "\x\ace\addons\m_veh_optics\driver\optika_tank_driver_west.p3d"
// Increased Default RU Tank driver optic
#define ACE_DRIVEROPTIC_TANK_RU driverOpticsModel = "\x\ace\addons\m_veh_optics\driver\optika_tank_driver_east.p3d"
// Increased Default NON Specified driver optic
#define ACE_DRIVEROPTIC_TANK driverOpticsModel = "\x\ace\addons\m_veh_optics\driver\optika_tank_driver.p3d"
// Increased Default EP1 NON Specified driver optic
// Default black border thing needs finish
#define ACE_DRIVEROPTIC_TANK_EP1 driverOpticsModel = "\x\ace\addons\m_veh_optics\driver\optika_tank_driver.p3d"

#define ACE_BWC ace_bwc = 1

// Scripting macros
#define ACE_wind	([] call ace_sys_wind_deflection_fnc_wind)

// In vehicle or on foot
#define ONFOOT(x) (x == vehicle x)
#define INVEHICLE(x) (x != vehicle x)

#define ACE_BIS_WOUNDING_ENABLED (!isNil "BIS_IS_initDamVars")
// Does this work, due to BWC_CONFIG(NAME) ?
#undef BWC_CONFIG

#define BWC_CONFIG(NAME) class NAME { \
		units[] = {}; \
		weapons[] = {}; \
		requiredVersion = REQUIRED_VERSION; \
		requiredAddons[] = {}; \
		version = VERSION; \
		ACE_BWC; \
}

#define ACE_FLASHLIGHT class FlashLight { \
			color[] = {0.9, 0.9, 0.7, 0.9}; \
			ambient[] = {0.1, 0.1, 0.1, 1.0}; \
			position = "flash dir"; \
			direction = "flash"; \
			angle = 30; \
			scale[] = {1, 1, 0.5}; \
			brightness = 0.1; \
		}
#define ACE_SMALL_FLASHLIGHT class FlashLight { \
			color[] = {0.9, 0.9, 0.7, 0.9}; \
			ambient[] = {0.1, 0.1, 0.1, 1.0}; \
			position = "flash dir"; \
			direction = "flash"; \
			angle = 20; \
			scale[] = {0.9, 0.9, 0.4}; \
			brightness = 0.09; \
		}
