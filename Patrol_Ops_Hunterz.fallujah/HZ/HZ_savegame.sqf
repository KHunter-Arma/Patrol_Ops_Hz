#include "debug_console.hpp"

////// PARSING DESCRIPTORS ///////
#define ONE_D_ARRAY  1
#define NESTED_ARRAY_STRUCT 2
#define ARRAY_OF_STRUCTS 3
/////////////////////////////////

#define DEFAULT_MAX_ARRAY_SIZE 50
#define DEFAULT_MAX_NESTED_ARRAY_SIZE 5

private ["_save"];

gamesaved = false;

if(isServer) then {
	
	if (isnil "Hz_save_lock") then {Hz_save_lock = false;};     
	if (Hz_save_lock) exitwith {};
	Hz_save_lock = true;

	//{_x enablesimulation false;}foreach allunits;

	/*
deletevehicle hz_trigger_save;
hz_trigger_save = nil;
publicvariable "hz_trigger_save";
*/
	
	hz_veh_type_array = [];
	hz_veh_dam_array = [];
	hz_veh_dir_array = [];
	hz_veh_pos_array = [];
	//hz_veh_contents_array = [];
	hz_veh_gear_ammo_array = [];
	hz_veh_gear_wep_array = [];
	hz_veh_fuel_array = [];
	hz_veh_turret_mag_array = [];
	
	hz_fort_type_array = [];
	hz_fort_dam_array = [];
	hz_fort_dir_array = [];
	hz_fort_pos_array = [];

	medbox_gear_ammo_array = [];
	medbox_gear_wep_array = [];
	medbox_pos_array = [];
	medbox_dir_array = [];
	emptybox_gear_ammo_array = [];
	emptybox_gear_wep_array = [];
	emptybox_pos_array = [];
	emptybox_dir_array = [];

	rallypos = [];
	rallyuids = [];
	rallynames = [];
	
	hz_save_mines_type_array = [];
	hz_save_mines_pos_array = [];
	hz_save_mines_dir_array = [];
	
	
	// Joint Ops
	
	hz_save_jointOps_veh_type = [];
	hz_save_jointOps_veh_dir = [];
	hz_save_jointOps_veh_pos = [];
	
	hz_save_jointOps_ammocrate_wepTypes = [];
	hz_save_jointOps_ammocrate_wepCount = [];
	
	hz_save_jointOps_ammocrate_magTypes = [];
	hz_save_jointOps_ammocrate_magCount = [];  
	
	hz_save_jointOps_medcrate_wepTypes = [];
	hz_save_jointOps_medcrate_wepCount = [];
	
	hz_save_jointOps_medcrate_magTypes = [];
	hz_save_jointOps_medcrate_magCount = [];  
	
	{
		
		if (alive _x) then {
			
			hz_save_jointOps_veh_type set [count hz_save_jointOps_veh_type,(typeof _x)];
			hz_save_jointOps_veh_dir set [count hz_save_jointOps_veh_dir,(getdir _x)];
			hz_save_jointOps_veh_pos set [count hz_save_jointOps_veh_pos,(getposatl _x)];
		};
		
	} foreach Hz_save_jointOps_vehicles;
	
	if (alive JOPS_AMMOCRATE) then {
		
		hz_save_jointOps_ammocrate_magTypes = (getMagazineCargo _x) select 0;
		hz_save_jointOps_ammocrate_magCount = (getMagazineCargo _x) select 1;
		
		hz_save_jointOps_ammocrate_wepTypes = (getWeaponCargo _x) select 0;
		hz_save_jointOps_ammocrate_wepCount = (getWeaponCargo _x) select 1;
		
	};
	
	if (alive JOPS_MEDICALBOX) then {
		
		hz_save_jointOps_medcrate_magTypes = (getMagazineCargo _x) select 0;
		hz_save_jointOps_medcrate_magCount = (getMagazineCargo _x) select 1;
		
		hz_save_jointOps_medcrate_wepTypes = (getWeaponCargo _x) select 0;
		hz_save_jointOps_medcrate_wepCount = (getWeaponCargo _x) select 1;
		
	};    
	

	hz_save_parsingInfo = [
	["hz_veh_type_array",ONE_D_ARRAY],["hz_veh_dam_array",ONE_D_ARRAY],["hz_veh_dir_array",ONE_D_ARRAY],["hz_veh_pos_array",ONE_D_ARRAY],
	["hz_veh_fuel_array",ONE_D_ARRAY],["hz_fort_type_array",ONE_D_ARRAY],
	["hz_fort_dam_array",ONE_D_ARRAY],["hz_fort_dir_array",ONE_D_ARRAY],["hz_fort_pos_array",ONE_D_ARRAY],
	["medbox_pos_array",ONE_D_ARRAY],["medbox_dir_array",ONE_D_ARRAY],["emptybox_pos_array",ONE_D_ARRAY],["emptybox_dir_array",ONE_D_ARRAY],
	["rallypos",ONE_D_ARRAY],["rallyuids",ONE_D_ARRAY],["rallynames",ONE_D_ARRAY],
	["hz_save_mines_type_array",ONE_D_ARRAY],["hz_save_mines_pos_array",ONE_D_ARRAY],["hz_save_mines_dir_array",ONE_D_ARRAY],
	
	["hz_veh_gear_ammo_array",ARRAY_OF_STRUCTS],["hz_veh_gear_wep_array",ARRAY_OF_STRUCTS],
	["emptybox_gear_ammo_array",ARRAY_OF_STRUCTS],["emptybox_gear_wep_array",ARRAY_OF_STRUCTS],["medbox_gear_ammo_array",ARRAY_OF_STRUCTS],["medbox_gear_wep_array",ARRAY_OF_STRUCTS],
	
	["hz_save_jointOps_veh_type",ONE_D_ARRAY],["hz_save_jointOps_veh_dir",ONE_D_ARRAY],["hz_save_jointOps_veh_pos",ONE_D_ARRAY],
	["hz_save_jointOps_ammocrate_magTypes",ONE_D_ARRAY],["hz_save_jointOps_ammocrate_magCount",ONE_D_ARRAY],["hz_save_jointOps_ammocrate_wepTypes",ONE_D_ARRAY],["hz_save_jointOps_ammocrate_wepCount",ONE_D_ARRAY],
	["hz_save_jointOps_medcrate_magTypes",ONE_D_ARRAY],["hz_save_jointOps_medcrate_magCount",ONE_D_ARRAY],["hz_save_jointOps_medcrate_wepTypes",ONE_D_ARRAY],["hz_save_jointOps_medcrate_wepCount",ONE_D_ARRAY]
	
	];

	{
		if(!isnull _x) then {
			if ((alive _x) && (((getposatl _x) select 2) < 10000)) then {
				
				//if(isnil (_x getvariable "R3F_LOG_objets_charges")) then {_x setvariable ["R3F_LOG_objets_charges",[],true];};
				//hz_veh_contents_array = hz_veh_contents_array + [(_x getvariable "R3F_LOG_objets_charges")];
				hz_veh_type_array set [count hz_veh_type_array,(typeof _x)];
				hz_veh_dam_array set [count hz_veh_dam_array,(getdammage _x)];
				hz_veh_dir_array set [count hz_veh_dir_array,(getdir _x)];
				hz_veh_pos_array set [count hz_veh_pos_array,(getposatl _x)];
				hz_veh_fuel_array set [count hz_veh_fuel_array,fuel _x];
				
				// _pos = getposatl _x;
				//if(abs(_pos select 2) < 0.3) then {hz_veh_pos_array = hz_veh_pos_array + [[_pos select 0, _pos select 1, 0]];} else {hz_veh_pos_array = hz_veh_pos_array + [_pos];};
				hz_veh_gear_ammo_array set [count hz_veh_gear_ammo_array,(getMagazineCargo _x)];
				hz_veh_gear_wep_array set [count hz_veh_gear_wep_array,(getWeaponCargo _x)];
				
				_turrPaths = [(configfile >> "cfgvehicles" >> (typeof _x) >> "turrets")] call BIS_fnc_returnVehicleTurrets;
				_turrCount = count _turrPaths;
				if (_turrCount > 0) then {
					
					_arrayofMagArrays = [];
					//filter
					_filtered = [];
					{
						_turret = [];    
						if((typename _x) != "ARRAY") then {_turret = [_x];} else {_turret = _x;};
						if((count _turret) > 0) then {_filtered set [count _filtered,_turret];};
					}foreach _turrPaths;
					_turrPaths = _filtered;
					_turrCount = count _turrPaths;
					
					if(_turrCount > 0) then {			
						for "_i" from 0 to (_turrCount - 1) do {

							_turret = _turrPaths select _i;
							_mags = _x magazinesturret _turret;
							_magArray = [[],[]];

							{			
								if(!(_x in (_magArray select 0))) then {					
									_magType = _x;
									_cnt = {_x == _magType} count _mags;
									(_magArray select 0) set [count (_magArray select 0),_magType];
									(_magArray select 1) set [count (_magArray select 1),_cnt];					
								};		
							}foreach _mags;

							_arrayofMagArrays set [count _arrayofMagArrays,_magArray];
						};
					};                                
					_index = count hz_veh_turret_mag_array;
					hz_veh_turret_mag_array set [_index,[_turrPaths,_arrayofMagArrays]];
					
				} else {
					
					hz_veh_turret_mag_array set [count hz_veh_turret_mag_array,[]];
					
				};
				
			};
		};
	}foreach hz_veh_array;

	{
		if(!isnull _x) then {
			if ((alive _x) && (((getposatl _x) select 2) < 10000)) then {
				// hz_fort_contents_array = hz_fort_contents_array + [(_x getvariable "R3F_LOG_objets_charges")];
				hz_fort_type_array set [count hz_fort_type_array,(typeof _x)];
				hz_fort_dam_array set [count hz_fort_dam_array,(getdammage _x)];
				hz_fort_dir_array set [count hz_fort_dir_array,(getdir _x)];
				hz_fort_pos_array set [count hz_fort_pos_array,(getposatl _x)];
			};
		};
	}foreach hz_fort_array;

	{
		if(!isnull _x) then {
			if ((alive _x) && (((getposatl _x) select 2) < 10000)) then {
				medbox_gear_ammo_array set [count medbox_gear_ammo_array,(getMagazineCargo _x)];
				medbox_gear_wep_array set [count medbox_gear_wep_array,(getWeaponCargo _x)];
				medbox_pos_array set [count medbox_pos_array,(getposatl _x)];
				medbox_dir_array set [count medbox_dir_array,(getdir _x)];
			};
		};   
	}foreach medbox_array;
	
	{
		if(!isnull _x) then {
			if ((alive _x) && (((getposatl _x) select 2) < 10000)) then {
				emptybox_gear_ammo_array set [count emptybox_gear_ammo_array,(getMagazineCargo _x)];
				emptybox_gear_wep_array set [count emptybox_gear_wep_array,(getWeaponCargo _x)];
				emptybox_pos_array set [count emptybox_pos_array,(getposatl _x)];
				emptybox_dir_array set [count emptybox_dir_array,(getdir _x)];
				
			};
		};
	}foreach emptybox_array;


	{
		if(!isnull _x) then {
			if (alive _x && ((_x distance [3.125,-0.62974,-0.466614]) > 50)) then {
				
				rallypos set [count rallypos,(getposatl _x)];
				rallyuids set [count rallyuids,(_x getvariable "owneruid")];
				rallynames set [count rallynames,(_x getvariable "owner")];
				
				
			};
		};
	}foreach rallytents;

	if(!isnull sandbags) then {sandbagspos = getposatl sandbags;} else {sandbagspos = [0,0,0];};
	
	/*    
		{
		
		
		} foreach nearestobjects [markerpos "hz_map_centre",[],Hz_mapRadius];
		*/
	
	_save = format ["hz_save_parsingInfo = %1;",hz_save_parsingInfo];
	conFile(_save);
	
	{
		_objectName = _x select 0;
		
		switch (_x select 1) do {
			
		case ONE_D_ARRAY : {
				
				_splitArrays = [(missionnamespace getvariable [_objectName,[]]), DEFAULT_MAX_ARRAY_SIZE] call Hz_save_func_arraySplitter;
				[_splitArrays, _objectName] call Hz_save_func_splitArrayWriter;     
				
			};
			
		case NESTED_ARRAY_STRUCT : {
				
				[(missionnamespace getvariable [_objectName,[]]), _objectName, DEFAULT_MAX_ARRAY_SIZE] call Hz_save_func_nestedArrayStructWriter;
				
			};
			
		case ARRAY_OF_STRUCTS : {
				
				[(missionnamespace getvariable [_objectName,[]]), _objectName, DEFAULT_MAX_ARRAY_SIZE] call Hz_save_func_structArrayWriter;
				
			};
			
			default {};    
			
		};
		
	}foreach hz_save_parsingInfo;   

	_splitArrays = [hz_veh_turret_mag_array, DEFAULT_MAX_NESTED_ARRAY_SIZE] call Hz_save_func_arraySplitter;
	[_splitArrays, "hz_veh_turret_mag_array"] call Hz_save_func_splitArrayWriter;

	_save = format ["Hz_funds = %1;",Hz_funds];
	conFile(_save);

	_save = format ["civ_killed_count = %1;",civ_killed_count];
	conFile(_save);

	_save = format ["sandbagspos = %1;",sandbagspos];
	conFile(_save);

	_save = format ["nuke_event = %1;",nuke_event];
	conFile(_save);

	if(!isnil "Hz_save_radar_spawn_timer") then {
		_save = format ["Hz_save_radar_spawn_timer = %1;",Hz_save_radar_spawn_timer];
		conFile(_save);

	};
	if(!isnil "Hz_save_radar_pos") then {
		_save = format ["Hz_save_radar_pos = %1;",Hz_save_radar_pos];
		conFile(_save);

	};

	if(!isnil "Hz_save_arty_spawn_timer") then {
		_save = format ["Hz_save_arty_spawn_timer = %1;",Hz_save_arty_spawn_timer];
		conFile(_save);

	};
	if(!isnil "Hz_save_arty_pos") then {
		_save = format ["Hz_save_arty_pos = %1;",Hz_save_arty_pos];
		conFile(_save);

	};
	
	if(!isnil "Hz_save_arty_rocketArty") then {
		_save = format ["Hz_save_arty_rocketArty = %1;",Hz_save_arty_rocketArty];
		conFile(_save);
	};

	_save = format ["newgCount = %1;",gCount];
	conFile(_save);

	_save = format ["BanList = %1;",BanList];
	conFile(_save);

	_save = format ["Hz_save_prev_tasks_list = %1;",Hz_save_prev_tasks_list];
	conFile(_save);

	_save = format ["Hz_save_destroyedMapBuildingIDs = %1;",Hz_save_destroyedMapBuildingIDs];
	conFile(_save);

	_save = "loaddone = true;";
	conFile(_save);

	conClose();

	gamesaved = true;
	publicvariable "gamesaved";

	Hz_save_lock = false;

} else {

	[] spawn {

		hintsilent "Saving game.....";
		waituntil {hintsilent "Saving game."; sleep 0.1; hintsilent "Saving game..";sleep 0.1; hintsilent "Saving game...";sleep 0.1; hintsilent "Saving game....";sleep 0.1;hintsilent "Saving game...";sleep 0.1; hintsilent "Saving game..";sleep 0.1; gamesaved};
		hint "Save successful!";
	};
};