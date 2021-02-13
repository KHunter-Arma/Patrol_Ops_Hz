private ["_count", "_type", "_temp", "_temp2", "_randomIndex", "_val", "_faction", "_class"];

if(!(call Hz_fnc_isTaskMaster)) exitWith{};

mps_class_commander = [];
mps_class_tl = [];
mps_class_mg = [];
mps_class_at = [];
mps_class_aa = [];
mps_class_crew = [];
mps_class_pilot = [];
mps_class_eng = [];
mps_class_sniper = [];
mps_opfor_inf = [];
mps_opfor_riflemen = [];
mps_opfor_ins_riflemen = [];
mps_opfor_crewmen = [];
mps_opfor_pilot = [];
mps_opfor_sniper = [];
mps_opfor_ins = [];
mps_opfor_ins_car = [];
mps_opfor_ins_ncov = [];
mps_opfor_ins_truck = [];
mps_opfor_leader = [];
mps_opfor_commander = [];
mps_opfor_armor = [];
mps_opfor_apc = [];
mps_opfor_aa = [];
mps_opfor_car = [];
mps_opfor_atkh = [];
mps_opfor_atkp = [];
mps_opfor_lbomber = [];
mps_opfor_hbomber = [];
mps_opfor_airsup = [];
mps_opfor_static = [];
mps_opfor_ins_static = [];
mps_opfor_tankdestroyer = [];
mps_opfor_ncov = [];
mps_opfor_ncoh = [];
mps_opfor_truck = [];
mps_opfor_cargoplane = [];
mps_ammo_loadable_veh = [];
mps_repair_vehicles = [];
mps_liftchoppers = [];
mps_liftable = [];
mps_transports = [];
mps_transportable_containers = [];
mps_loadable_objects = [];
mps_recruit_unittypes = [];

mps_blufor_leader = [];
mps_blufor_commander = [];
mps_blufor_inf = [];
mps_blufor_riflemen = [];
mps_blufor_crewmen = [];
mps_blufor_sniper = [];
mps_blufor_armor = [];
mps_blufor_apc = [];
mps_blufor_aa = [];
mps_blufor_car = [];
mps_blufor_atkh = [];
mps_blufor_atkp = [];
mps_blufor_lbomber = [];
mps_blufor_hbomber = [];
mps_blufor_airsup = [];
mps_blufor_static = [];
mps_blufor_tankdestroyer = [];
mps_blufor_ncov = [];
mps_blufor_ncoh = [];
mps_blufor_truck = [];
mps_blufor_cargoplane = [];


{

/*
  switch ((_x select 1)) do {
  case "at": { mps_class_at = mps_class_at + [(_x select 2)]};
  case "cr": { mps_class_crew = mps_class_crew + [(_x select 2)]};
  case "en": { mps_class_eng = mps_class_eng + [(_x select 2)]};
  case "mg": { mps_class_mg = mps_class_mg + [(_x select 2)]};
  case "pi": { mps_class_pilot = mps_class_pilot + [(_x select 2)]};
  case "sn": { mps_class_sniper = mps_class_sniper + [(_x select 2)]};
    //	case "so": {  };
    default    {  };
  };
*/

  if( (_x select 0) == (SIDE_A select 1) ) then {
	
    //mps_recruit_unittypes = mps_recruit_unittypes + [(_x select 2)];
		
		//Hunter'z weighted distribution
    _count = _x select 3;
    _type = _x select 2;
    
    if(_count > 0) then {
      
      for "_i" from 1 to _count do {
        
        mps_blufor_inf set [count mps_blufor_inf,_type];
        
      };
      
    };         
    
    if( (_x select 1) == "tl") then { mps_blufor_leader = mps_blufor_leader + [(_x select 2)]; };
    if( (_x select 1) == "co") then { mps_blufor_commander = mps_blufor_commander + [(_x select 2)]; };
    if( (_x select 1) == "rf") then { mps_blufor_riflemen = mps_blufor_riflemen + [(_x select 2)]; };
    if( (_x select 1) == "cr") then { mps_blufor_crewmen = mps_blufor_crewmen + [(_x select 2)]; };
		if( (_x select 1) == "sn") then { mps_blufor_sniper = mps_blufor_sniper + [(_x select 2)]; };	
		
  };
	
  if((_x select 0) == (SIDE_B select 1)) then {
    
    //Hunter'z weighted distribution
    _count = _x select 3;
    _type = _x select 2;
    
    if(_count > 0) then {
      
      for "_i" from 1 to _count do {
        
        mps_opfor_inf set [count mps_opfor_inf,_type];
        
      };
      
    };         
    
    if( (_x select 1) == "tl") then { mps_opfor_leader = mps_opfor_leader + [(_x select 2)]; };
    if( (_x select 1) == "co") then { mps_opfor_commander = mps_opfor_commander + [(_x select 2)]; };
    if( (_x select 1) == "rf") then { mps_opfor_riflemen = mps_opfor_riflemen + [(_x select 2)]; };
    if( (_x select 1) == "cr") then { mps_opfor_crewmen = mps_opfor_crewmen + [(_x select 2)]; };
    if( (_x select 1) == "pl") then { mps_opfor_pilot = mps_opfor_pilot + [(_x select 2)]; };
		if( (_x select 1) == "sn") then { mps_opfor_sniper = mps_opfor_sniper + [(_x select 2)]; };
		
  };
	
  if((_x select 0) == (SIDE_C select 1)) then {
    
    //Hunter'z weighted distribution
    _count = _x select 3;
    _type = _x select 2;
    
    if(_count > 0) then {
      
      for "_i" from 1 to _count do {
        
        mps_opfor_ins set [count mps_opfor_ins,_type];
        
      };
      
    };         
    
    if( (_x select 1) == "rf") then { mps_opfor_ins_riflemen = mps_opfor_ins_riflemen + [(_x select 2)]; };
    
  };
	
} forEach mps_config_units;

//Spread out and reassemble
_temp = +mps_opfor_inf;
_temp2 = [];

{
  if ((count mps_opfor_inf) == 0) exitwith {};
	_randomIndex = floor (random (count mps_opfor_inf));
  _val =  mps_opfor_inf select _randomIndex;
  _temp2 set [count _temp2,_val];
	mps_opfor_inf set [_randomIndex,""];
  mps_opfor_inf = mps_opfor_inf - [""];    
} foreach _temp;

mps_opfor_inf = +_temp2;

_temp = +mps_opfor_ins;
_temp2 = [];

{
  if ((count mps_opfor_ins) == 0) exitwith {};
	_randomIndex = floor (random (count mps_opfor_ins));
  _val =  mps_opfor_ins select _randomIndex;
  _temp2 set [count _temp2,_val];
	mps_opfor_ins set [_randomIndex,""];
  mps_opfor_ins = mps_opfor_ins - [""];   
  
} foreach _temp;

mps_opfor_ins = +_temp2;

_temp = +mps_blufor_inf;
_temp2 = [];

{
  if ((count mps_blufor_inf) == 0) exitwith {};
	_randomIndex = floor (random (count mps_blufor_inf));
  _val =  mps_blufor_inf select _randomIndex;
  _temp2 set [count _temp2,_val];
	mps_blufor_inf set [_randomIndex,""];
  mps_blufor_inf = mps_blufor_inf - [""];   
  
} foreach _temp;

mps_blufor_inf = +_temp2;


{
  _faction = (_x select 0);
  _class = (_x select 1);
	
	if( (_x select 0) == (SIDE_A select 1) ) then {
    switch ((_x select 1)) do {
    case "tank": { mps_blufor_armor  = mps_blufor_armor  + [(_x select 2)]};
    case "apc": { mps_blufor_apc = mps_blufor_apc + [(_x select 2)]};
    case "mobiaa": { mps_blufor_aa = mps_blufor_aa + [(_x select 2)]};
    case "attakc": { mps_blufor_car = mps_blufor_car + [(_x select 2)]};
    case "attakh": { mps_blufor_atkh = mps_blufor_atkh + [(_x select 2)]};
    case "attakp": { mps_blufor_atkp = mps_blufor_atkp + [(_x select 2)]};
		case "Lbomber": { mps_blufor_lbomber = mps_blufor_lbomber + [(_x select 2)]; mps_blufor_atkp = mps_blufor_atkp + [(_x select 2)]};
    case "Hbomber": { mps_blufor_hbomber = mps_blufor_hbomber + [(_x select 2)]};
		case "airsup": { mps_blufor_airsup = mps_blufor_airsup + [(_x select 2)]};
		case "tdest": { mps_blufor_tankdestroyer = mps_blufor_tankdestroyer + [(_x select 2)]};		
		case "cargoc": { mps_blufor_ncov = mps_blufor_ncov + [(_x select 2)]};
    case "cargoh": { mps_blufor_ncoh = mps_blufor_ncoh + [(_x select 2)]};
    case "truck": { mps_blufor_truck = mps_blufor_truck + [(_x select 2)]};
		case "static": { mps_blufor_static = mps_blufor_static + [(_x select 2)]};
    case "cargop": { mps_blufor_cargoplane = mps_blufor_cargoplane + [(_x select 2)] };
      default    {  };
    };
  };

  if( (_x select 0) == (SIDE_B select 1) ) then {
    switch ((_x select 1)) do {
    case "tank": { mps_opfor_armor  = mps_opfor_armor  + [(_x select 2)]};
    case "apc": { mps_opfor_apc = mps_opfor_apc + [(_x select 2)]};
    case "mobiaa": { mps_opfor_aa = mps_opfor_aa + [(_x select 2)]};
    case "attakc": { mps_opfor_car = mps_opfor_car + [(_x select 2)]};
    case "attakh": { mps_opfor_atkh = mps_opfor_atkh + [(_x select 2)]};
    case "attakp": { mps_opfor_atkp = mps_opfor_atkp + [(_x select 2)]};
		case "Lbomber": { mps_opfor_lbomber = mps_opfor_lbomber + [(_x select 2)]; mps_opfor_atkp = mps_opfor_atkp + [(_x select 2)]};
    case "Hbomber": { mps_opfor_hbomber = mps_opfor_hbomber + [(_x select 2)]};
		case "airsup": { mps_opfor_airsup = mps_opfor_airsup + [(_x select 2)]};
		case "tdest": { mps_opfor_tankdestroyer = mps_opfor_tankdestroyer + [(_x select 2)]};		
		case "cargoc": { mps_opfor_ncov = mps_opfor_ncov + [(_x select 2)]};
    case "cargoh": { mps_opfor_ncoh = mps_opfor_ncoh + [(_x select 2)]};
    case "truck": { mps_opfor_truck = mps_opfor_truck + [(_x select 2)]};
		case "static": { mps_opfor_static = mps_opfor_static + [(_x select 2)]};
    case "cargop": { mps_opfor_cargoplane = mps_opfor_cargoplane + [(_x select 2)] };
      default    {  };
    };
  };
  
  if( (_x select 0) == (SIDE_C select 1) ) then {
    switch ((_x select 1)) do {
    case "attakc": { mps_opfor_ins_car = mps_opfor_ins_car + [(_x select 2)]};
    case "cargoc": { mps_opfor_ins_ncov = mps_opfor_ins_ncov + [(_x select 2)]};
    case "truck": { mps_opfor_ins_truck = mps_opfor_ins_truck + [(_x select 2)]};
		case "static": { mps_opfor_ins_static = mps_opfor_ins_static + [(_x select 2)]};
      default {  };
    };
  };
	
	/*
	
  if( (_x select 3) > 0) then { mps_ammo_loadable_veh = mps_ammo_loadable_veh + [(_x select 2)]};
  if( (_x select 4) > 0) then { mps_repair_vehicles = mps_repair_vehicles + [(_x select 2)]};
	

  if ( (_x select 5) > 0 && (_x select 2) isKindof "AIR") then {
    	mps_liftchoppers = mps_liftchoppers + [(_x select 2)]
  }else{
    	if( (_x select 5) > 0) then { mps_liftable = mps_liftable + [(_x select 2)]};
  };
	


  if( (_x select 6) > 0) then { mps_transports = mps_transports + [(_x select 2)]};
  if( (_x select 7) > 20) then { mps_transportable_containers = mps_transportable_containers + [[(_x select 2),(_x select 7)]]};
  if( (_x select 7) > 0 && (_x select 7) <= 20 && (_x select 1) == "item") then { mps_loadable_objects = mps_loadable_objects + [[(_x select 2),(_x select 7)]]};

	*/	
	
} forEach mps_config_vehicles;

/*
publicVariable "mps_class_commander";
publicVariable "mps_class_tl";
publicVariable "mps_class_mg";
publicVariable "mps_class_at";
publicVariable "mps_class_aa";
publicVariable "mps_class_crew";
publicVariable "mps_class_pilot";
publicVariable "mps_class_eng";
publicVariable "mps_class_sniper";
publicVariable "mps_ammo_loadable_veh";
publicVariable "mps_repair_vehicles";
publicVariable "mps_liftchoppers";
publicVariable "mps_liftable";
publicVariable "mps_transports";
publicVariable "mps_transportable_containers";
publicVariable "mps_loadable_objects";
*/

//BAF Desert
//mps_recruit_unittypes = mps_recruit_unittypes + ["Soldier_Bodyguard_M4_PMC","Soldier_Bodyguard_AA12_PMC","Soldier_Sniper_KSVK_PMC","Soldier_Medic_PMC","Soldier_MG_PKM_PMC","Soldier_AT_PMC","Soldier_Engineer_PMC","Soldier_GL_M16A2_PMC","Soldier_M4A3_PMC","Soldier_AA_PMC","BAF_crewman_DDPM","BAF_Soldier_FAC_DDPM","BAF_Soldier_AA_DDPM","BAF_Soldier_EN_DDPM","BAF_Soldier_GL_DDPM","BAF_Pilot_DDPM","BAF_Soldier_Medic_DDPM","BAF_Soldier_DDPM","BAF_Soldier_L_DDPM","BAF_Soldier_Marksman_DDPM","BAF_Soldier_AR_DDPM","BAF_Soldier_MG_DDPM","BAF_Soldier_HAT_DDPM","BAF_Soldier_AT_DDPM","BAF_Soldier_N_DDPM"];    

//mps_recruit_unittypes = mps_recruit_unittypes + ["Soldier_Bodyguard_M4_PMC","Soldier_Bodyguard_AA12_PMC","Soldier_Sniper_KSVK_PMC","Soldier_Medic_PMC","Soldier_MG_PKM_PMC","Soldier_AT_PMC","Soldier_Engineer_PMC","Soldier_GL_M16A2_PMC","Soldier_M4A3_PMC","Soldier_AA_PMC","BAF_crewman_MTP","BAF_Soldier_FAC_MTP","BAF_Soldier_AA_MTP","BAF_Soldier_EN_MTP","BAF_Soldier_GL_MTP","BAF_Pilot_MTP","BAF_Soldier_Medic_MTP","BAF_Soldier_MTP","BAF_Soldier_L_MTP","BAF_Soldier_Marksman_MTP","BAF_Soldier_AR_MTP","BAF_Soldier_MG_MTP","BAF_Soldier_HAT_MTP","BAF_Soldier_AT_MTP","BAF_Soldier_N_MTP"];    

mps_recruit_unittypes = ["Soldier_Bodyguard_M4_PMC"];

publicVariable "mps_recruit_unittypes";
