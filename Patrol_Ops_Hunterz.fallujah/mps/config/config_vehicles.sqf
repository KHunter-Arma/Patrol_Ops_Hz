mps_config_vehicles = [];

/*-------------------------------------------------------------/
CREATING ADDITIONAL CONFIGS

 format: ["faction","Class_ID","Unit_Type",Ammobox,resupply,liftchopper/liftable,transports,capacity/size]

 e.g.
	["BIS_US", "cargoc", "HMMWV_DES_EP1",1,0,1,0,100],
	["BIS_US", "attakh", "AH6J_EP1",0,0,0,0,0],
	["OBJECT","cargo","Land_Misc_Cargo2C",0,0,0,0,200],
	["ITEM","item","Pchela1T",0,0,0,0,15]

 Faction is used to determine what is SIDE_A/B/C unit types

 Class_ID is used to player interaction and hostile unit spawn types:
	attakc = Armed Light Vehicle
	attakh = Armed Helicopter
	attakp = Armed Plane
	cargoc = Unarmed Light Vehicle
	cargoh = Unarmed Helicopter
	cargop = Unarmed Plane
	mobiaa = Mobile Anti Air Vehicle
	tank = Heavy Armour
	apc = Armoured Personell Carrier
	mhq = MHQ vehicle (not used)
    Logistics
	cargo = Container for Objects
	item = Draggable / Loadable objects (must be less than 20 in size otherwise too heavy for players)

 Unit_Type is the classname of the unit to use for ingame creation

 Ammobox Flag (0 or 1) to enable vehicle to load an ammobox
 Resupply Flag (0 or 1) to enable vehicle/object to become a supply vehicle/object
 liftchopper/liftable Flag (0 or 1) to enable if helicopter, to become a lift chopper, if other, to become a liftable object
 transports Flag (0 or 1) to enable vehicle to carry a shipping container
 capacity/size:
	if declared > 20, the object can have objects loaded inside up to the capacity set.
	if declared < 20 && > 0, the object can be dragged/loaded by players as cargo
	Set as 0 to disable logistics on the object type

/-------------------------------------------------------------*/

#include "config_addons\config_vehicles_a3.sqf"