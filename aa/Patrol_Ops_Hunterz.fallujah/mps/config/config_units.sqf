mps_config_units = [];

/*-------------------------------------------------------------/
CREATING ADDITIONAL CONFIGS

 format: ["faction","Class_ID","Unit_Type"]

 Faction is used to determine what is SIDE_A/B/C unit types

 Class_ID is used to restrict player gear and hostile unit spawn types:
	aa = Anti Air
	at = Anti Tank
	cr = Crewman
	mg = Machine Gunner / Automatic Rifleman
	na = Default such as Medic or other
	pi = Pilot
	sn = Sniper
	so = Soldier //Gives access to "Soldier" weapons (better than "na")
	tl = leader

 Unit_Type is the classname of the unit to use for ingame creation

/-------------------------------------------------------------*/

#include "config_addons\config_units_a3.sqf"