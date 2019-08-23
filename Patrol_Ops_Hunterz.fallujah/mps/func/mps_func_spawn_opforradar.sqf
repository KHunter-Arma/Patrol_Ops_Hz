private ["_radarlocation","_site","_location","_marker","_towervehs","_car_type","_vehgrp","_towergroup","_staticgrp","_newComp","_TargetDetectionRate","_grp","_Defendercount","_script2","_script"];

// Original radar tower air patrol script by EightySix. Modified by K.Hunter to include
// AI CAS and air superiority scripts.
/*=============================================================================
===============================================================================

				Intelligent AI CAS and air superiority scripts by K.Hunter

===============================================================================
==============================================================================*/

//////////////////////////////////////////////////////////////////////////////
/*
										PARAMS            
*/
//////////////////////////////////////////////////////////////////////////////

//useful for simulating how advanced enemy sensors or optics are [unit: seconds]         
_TargetDetectionRate = 30;           

/////////////////////////////////////////////////////////////////////////////





// WARNING : DEPRECATED CAS functions -- being phased out and replaced with AI mod



if(!(call Hz_fnc_isAiMaster)) exitWith{};

//init delay
sleep 60;

private["_radarlocation","_site","_location"];

while {true} do {

	Hz_radarObjects = [];

	if(Hz_save_radar_spawn_timer == 0) then {       
		
		_site = switch (SIDE_B select 0) do {
		case east : {"RadarSite1_RU"};
		case west : {"RadarSite1_US"};
			default     {"RadarSite1_RU"};
		};

		if(mps_oa) then {
			_site = switch (SIDE_B select 0) do {
			case east : {"RadarSite1_TK_EP1"};
			case west : {"RadarSite1_TK_EP1"};
				default     {"RadarSite1_TK_EP1"};
			};
		};       
		
		_radarlocation = [0,0,0];

		while {isNil "heli_radar"} do {
			
			if((format ["%1",Hz_save_radar_pos]) == "[0,0,0]") then {
				
				_location = [["hills"]] call mps_getNewLocation;
				_radarlocation = [position _location,6000,1,2] call mps_getFlatArea;
				
				waituntil {sleep 10; ({(_x distance _radarlocation) < 4000} count playableunits) < 1};
				
			} else {
				
				_radarlocation = Hz_save_radar_pos;  
				
			};
			
			//_newComp = [_radarlocation, random 360,_site] call BIS_fnc_dyno;
			_newComp = [_radarlocation, random 360, (call compile preprocessFileLineNumbers "Compositions\Opfor\Bases\radar_station.sqf")] call BIS_fnc_objectsMapper;
			
			{if(typeOf _x IN ["TK_WarfareBAntiAirRadar_Base_EP1","76n6ClamShell","76n6ClamShell_EP1","BASE_WarfareBAntiAirRadar"]) then {heli_radar = _x; [heli_radar] spawn mps_object_c4only;}; }forEach _newcomp;
			
			if(isNil "heli_radar") then {sleep 10;} else {
				
				Hz_save_radar_pos = _radarlocation;
				
				Hz_radarObjects = [_newComp] call Hz_func_initOpforComposition;		
				
			};

		};
		
		//debug
		heli_radar addEventHandler ["Killed", {
				diag_log "Air radar killed";
				diag_log str _this;
				diag_log format ["Server time: %1",serverTime];
			}];

		if(Hz_max_ambient_units > 0) then {
			
			Hz_max_ambient_units = Hz_max_ambient_units + 20;
			Hz_max_units_before_task = Hz_max_units_before_task + 20;
			Hz_max_allunits = Hz_max_allunits + 20;
			Hz_max_deadunits = Hz_max_deadunits - 20;
			
		};

		//hint format["Radar %1 at %2", heli_radar , _radarlocation ];

		if(mps_debug) then {
			_marker = createMarkerLocal ["masarkerh",_radarlocation];
			_marker setMarkerTypeLocal "mil_triangle";
			_marker setMarkerColorLocal "ColorRed";
			mission_sidechat = format["OPFOR Radar created at grid %1.",mapGridPosition _radarlocation]; publicVariable "mission_sidechat";
			[WEST,"HQ"] sideChat mission_sidechat;
			
			//     [-1, {hint format ["OPFOR Radar created at grid %1.",mapGridPosition _radarlocation];}] call CBA_fnc_globalExecute; 
			
		};

		//[_radarlocation] spawn CREATE_OPFOR_TOWER;

		for "_i" from 1 to 3 do {
			_grp = [_radarlocation,"INF",(6 + random 8),25,"standby"] call CREATE_OPFOR_SQUAD;
			if(random 1 > 0.5) then {
				_car_type = mps_opfor_aa call mps_getRandomElement;
				_vehgrp = [_car_type,(SIDE_B select 0),_radarlocation,100] call mps_spawn_vehicle;
				sleep 1;              
				{if(!((vehicle _x) in Hz_radarObjects)) then {Hz_radarObjects set [count Hz_radarObjects, vehicle _x];}; Hz_radarObjects set [count Hz_radarObjects, _x];}foreach units _vehgrp;
			};
			
			_grp setformation "DIAMOND";
			
		};
		
		for "_i" from 1 to (round(random 5)) do { _staticgrp = [_radarlocation,"nocleanup"] call CREATE_OPFOR_STATIC; {if(!((vehicle _x) in Hz_radarObjects)) then {Hz_radarObjects set [count Hz_radarObjects, vehicle _x];}; Hz_radarObjects set [count Hz_radarObjects, _x]; }foreach units _staticgrp;};


		patrol_helo_radarlocations = nearestLocations [ [0,0], ["Name","NameCity","NameCityCapital","NameVillage","NameLocal"], 50000];

		// Air superiority script

		_script2 = [_TargetDetectionRate] spawn {

			private ["_jet1","_jet2","_groupgrp2","_jettype","_TargetDetectionRate","_waitfor"];
			
			_TargetDetectionRate = _this select 0;
			
			While { damage heli_radar < 1} do{

				_jet1 = nil;
				_jet2 = nil;

				_groupgrp2 = createGroup (SIDE_B select 0);
				_jettype = mps_opfor_airsup call mps_getrandomelement;

				_jet1 = ([[(position heli_radar select 0)+10000,(position heli_radar select 1)+12000,4000], 180, _jettype, _groupgrp2] call BIS_fnc_spawnVehicle) select 0;
				_jet2 = ([[(position heli_radar select 0)+10100,(position heli_radar select 1)+12100,4000], 180, _jettype, _groupgrp2] call BIS_fnc_spawnVehicle) select 0;

				_groupgrp2 setvariable ["Hz_defending",true];
				_groupgrp2 deleteGroupWhenEmpty true;

				_jet1 flyinheight 4000;
				_jet2 flyinheight 4000;

				{_x setskill 1; _x disableai "AUTOTARGET";} foreach crew _jet1;
				{_x setskill 1; _x disableai "AUTOTARGET";} foreach crew _jet2;

				_jet1 setvehiclelock "LOCKED";
				_jet2 setvehiclelock "LOCKED";

				[_jet1,_jet2] spawn {
					
					
					private ["_wp","_jet1","_jet2","_groupgrp2"];
					_jet1 = _this select 0;
					_jet2 = _this select 1;
					_groupgrp2 = group _jet1;
					airpatroloverride1 = false;
					airpatroloverride2 = false;
					
					_wp = _groupgrp2 addWaypoint [(markerpos "air_patrol"),2000];
					
					//Waypoint loop
					while {alive heli_radar && ((((getposatl _jet1) select 2) > 20) || (((getposatl _jet2) select 2) > 20))} do {
						
						sleep 180;   
						deleteWaypoint _wp;
						dostop _jet1;
						dostop _jet2; 
						
						if(!alive heli_radar) exitwith{};
						
						waituntil {sleep 5; (!airpatroloverride1 && !airpatroloverride2)};
						
						_wp = _groupgrp2 addWaypoint [(markerpos "air_patrol3"),2000];
						_wp setWaypointType "MOVE";
						_jet1 flyinheight 3000;
						_jet2 flyinheight 3000;
						
						sleep 180;
						
						deleteWaypoint _wp;
						dostop _jet1;
						dostop _jet2;
						
						if(!alive heli_radar) exitwith{};
						
						waituntil {sleep 5; (!airpatroloverride1 && !airpatroloverride2)};
						
						_wp = _groupgrp2 addWaypoint [(markerpos "air_patrol"),2000];
						_wp setWaypointType "MOVE";
						_jet1 flyinheight 4000;
						_jet2 flyinheight 4000;
						
						
						/*
											_wp = _groupgrp2 addWaypoint [(markerpos "air_patrol"),7000];
											_wp setWaypointType "SAD";
								*/
						
					};
					
					//retreat once radar is destroyed
					if(!alive heli_radar) then {
						
						_groupgrp2 setCombatMode "BLUE";
						_groupgrp2 setSpeedMode "FULL";
						_wp = _groupgrp2 addWaypoint [[0,20000,5000],2000];
						waituntil {sleep 30; [0,10000,5000] distance _jet1 < 5000};
						{_jet2 deletevehicleCrew _x} foreach crew _jet2;
						{_jet1 deletevehicleCrew _x} foreach crew _jet1;
						deletevehicle _jet1;
						deletevehicle _jet2;
						
					};     
					
				};

				sleep 20;
				
				_groupgrp2 setBehaviour "COMBAT";
				_groupgrp2 setCombatMode "BLUE";
				_groupgrp2 setSpeedMode "FULL";
				
				//Reveal targets loop
				[_jet1,_TargetDetectionRate] spawn {
					
					
					private ["_height","_chopper","_TargetDetectionRate","_pilot"];
					_chopper = _this select 0;
					_TargetDetectionRate = _this select 1;
					_pilot = driver _chopper;
					while {(((getposatl _chopper) select 2) > 20) && (alive heli_radar)} do {
						sleep _TargetDetectionRate; 
						{   _height = ((getposatl _x) select 2);
							if ((_height > 50) && ((side _x) == west) && ((_x distance (markerpos "respawn_west")) > 2000)) then {
								airpatroloverride1 = true;
								//deleteWaypoint ((waypoints (group _chopper)) select 0);
								if(((getposatl _chopper) select 2) > 800) then {_chopper flyinheight 500;};
								if(_x iskindof "Plane") then {(group _chopper) setSpeedMode "FULL";} else {(group _chopper) setSpeedMode "LIMITED";};
								_pilot reveal [_x, 4];
								_x setvariable ["known_by_CAS",true]; if(!(_x iskindof "CAManBase")) then {{_x setvariable ["known_by_CAS",true];}foreach crew _x;}; 
								(group _chopper) setCombatMode "RED";
								_pilot dotarget _x;
								waituntil {/*if((velocity _chopper select 2) < -200 && (getposatl _chopper select 2) < 1000) then {_chopper setvelocity [0,0,1000];};*/if(!((assignedtarget _pilot) iskindof "Air")) exitwith {true}; sleep 3; _pilot reveal [_x, 4]; _pilot dotarget _x; (((_x distance (markerpos "respawn_west")) < 2000) || (((getposatl _chopper) select 2) < 20) || (getposatl _x select 2 < 50)  )};
							} else {    
								(group _chopper) setCombatMode "BLUE";
								if(!isnull (assignedtarget _pilot)) then {_pilot doWatch objNull;};
								if(((getposatl _chopper) select 2) < 1000) then {_chopper flyinheight 1800;}; 
								(group _chopper) setSpeedMode "FULL";
								airpatroloverride1 = false;
								_chopper setfuel 1; _chopper setVehicleAmmo 1;
							};
							
						} foreach (nearestObjects [_chopper, ["Air"], 10000]);
					};
					airpatroloverride1 = false;
				};
				
				[_jet2,_TargetDetectionRate] spawn {
					
					
					private ["_height","_chopper","_TargetDetectionRate","_pilot"];
					_chopper = _this select 0;
					_TargetDetectionRate = _this select 1;
					_pilot = driver _chopper;
					while {(((getposatl _chopper) select 2) > 20) && (alive heli_radar)} do {
						sleep _TargetDetectionRate;
						{_height = ((getposatl _x) select 2);
							if ((_height > 50) && ((side _x) == west) && ((_x distance (markerpos "respawn_west")) > 2000)) then {
								airpatroloverride2 = true;
								//deleteWaypoint ((waypoints (group _chopper)) select 0);
								if(((getposatl _chopper) select 2) > 800) then {_chopper flyinheight 500;};
								if(_x iskindof "Plane") then {(group _chopper) setSpeedMode "FULL";} else {(group _chopper) setSpeedMode "LIMITED";};
								_pilot reveal [_x, 4];
								_x setvariable ["known_by_CAS",true]; if(!(_x iskindof "CAManBase")) then {{_x setvariable ["known_by_CAS",true];}foreach crew _x;}; 
								(group _chopper) setCombatMode "RED";
								_pilot dotarget _x;
								waituntil {/*if((velocity _chopper select 2) < -200 && (getposatl _chopper select 2) < 1000) then {_chopper setvelocity [0,0,1000];};*/if(!((assignedtarget _pilot) iskindof "Air")) exitwith {true}; sleep 3; _pilot reveal [_x, 4]; _pilot dotarget _x; (((_x distance (markerpos "respawn_west")) < 2000) || (((getposatl _chopper) select 2) < 20) || (getposatl _x select 2 < 50)  )};
							} else {
								(group _chopper) setCombatMode "BLUE";
								if(!isnull (assignedtarget _pilot)) then {_pilot doWatch objNull;};
								if(((getposatl _chopper) select 2) < 1000) then {_chopper flyinheight 1800;}; 
								(group _chopper) setSpeedMode "FULL";
								airpatroloverride2 = false;
								_chopper setfuel 1; _chopper setVehicleAmmo 1;
							};
						} foreach (nearestObjects [_chopper, ["Air"], 10000]);
					};
					airpatroloverride2 = false;
				};

				if(hz_debug_air) then {vehicle player attachto [_jet2, [0,-50,10]];jet2 = _jet2; _jet2 spawn {while {true} do {sleep 1; hintsilent format ["Height: %1\nPilot target: %2",((getposatl player) select 2), assignedTarget driver _this];};}; 
				};

				
				while { if(!isNil "_jet1") then { (((getposatl _jet1) select 2) > 20) }else{false} || if(!isNil "_jet2") then { (((getposatl _jet2) select 2) > 20) }else{false} } do {sleep 60;};

				_waitfor = 1800;
				_waitfor = (_waitfor + (random 10800)); // wait before spawning new vehicles
				sleep _waitfor; 


				//sleep 60;
				{
					_veh = vehicle _x;
					if (_veh == _x) then {							
						deletevehicle _x;							
					} else {							
						_veh deleteVehicleCrew _x;							
					};
				}forEach (units _groupgrp2);
				if(!isNil "_jet1") then { deleteVehicle _jet1; };
				if(!isNil "_jet2") then { deleteVehicle _jet2; };

				
				deletegroup _groupgrp2;

			};

		};

		// CAS Script

		_script = [_TargetDetectionRate] spawn {
			
			
			private ["_helo2","_TargetDetectionRate","_helo1","_groupgrp1","_types","_helotype","_waitfor"];
			
			_TargetDetectionRate = _this select 0;
			
			While { damage heli_radar < 1} do{
				
				
				_helo1 = nil;
				_helo2 = nil;

				_groupgrp1 = createGroup (SIDE_B select 0);
				
				_types = [];
				_types = mps_opfor_atkh + mps_opfor_atkp;
				_helotype = _types call mps_getRandomElement;
				

				_helo1 = ([[(position heli_radar select 0)+10000,(position heli_radar select 1)+10000,1000], 180, _helotype, _groupgrp1] call BIS_fnc_spawnVehicle) select 0;
				
				_groupgrp1 deleteGroupWhenEmpty true;
				
				_helo1 setvehiclelock "LOCKED";
				
				if (_helotype in mps_opfor_atkp) then { _helo1 flyinheight 400;} else {_helo1 flyinheight 250;};
				
				
				_helo2 = ([[(position heli_radar select 0)+10100,(position heli_radar select 1)+10100,1000], 180, _helotype, _groupgrp1] call BIS_fnc_spawnVehicle) select 0;
				
				if (_helotype in mps_opfor_atkp) then { _helo2 flyinheight 400;} else {_helo2 flyinheight 250;};

				_helo2 setvehiclelock "LOCKED";
				
				_groupgrp1 setvariable ["Hz_attacking",true];
								
				{_x setskill 1;} foreach crew _helo1;
				{_x setskill 1;} foreach crew _helo2;
				//Waypoint loop
				[_helo1,_helo2] spawn {
					
					
					private ["_wp","_helo1","_helo2","_groupgrp1"];
					_helo1 = _this select 0;
					_helo2 = _this select 1;
					_groupgrp1 = group _helo1;
					sleep 5;
					
					_wp = _groupgrp1 addWaypoint [(markerpos "air_patrol"),700];
					_wp setWaypointType "SAD";
					sleep 300;
					
					while {(((getposatl _helo1) select 2) > 20) || (((getposatl _helo2) select 2) > 20)} do {
						
						deleteWaypoint _wp;
						_wp = _groupgrp1 addWaypoint [(markerpos "air_patrol2"),500];
						_wp setWaypointType "SAD";
						sleep 300;
						
						deleteWaypoint _wp;
						_wp = _groupgrp1 addWaypoint [(markerpos "air_patrol"),500];
						_wp setWaypointType "SAD";
						
						
					};
					
					
				};
				
				
				/*
							_radarlocations = patrol_helo_radarlocations call mps_getArrayPermutation;
		{
			if(position _x distance getMarkerPos format["respawn_%1",(SIDE_A select 0)] > 6000) then {
				_wp = _groupgrp1 addWaypoint [position _x,100];
			};

		} foreach _radarlocations;
							
		_wp = _groupgrp1 addWaypoint [waypointPosition [_groupgrp1,0],100];
		_wp setWaypointType "CYCLE";
								*/
				
				_groupgrp1 setBehaviour "COMBAT";
				_groupgrp1 setCombatMode "RED";
				_groupgrp1 setSpeedMode "FULL";
				
				//Reveal targets loop
				/*           
							if(_helo1 iskindof "Helicopter") then {
									
							//CAS is helicopter  
							[_helo1, _TargetDetectionRate] spawn {
									
							
private ["_nearunits","_targets","_TargetDetectionRate","_chopper","_gunner","_grp"];
_TargetDetectionRate = _this select 1;       
							_chopper = _this select 0; 
							_gunner = gunner _chopper;
							_grp = group _chopper;
							
							_chopper spawn {
											
private ["_target","_jet","_pilot","_gunner"];
_jet = _this;
											_pilot = driver _jet;
											_gunner = gunner _jet;
											while {(((getposatl _jet) select 2) > 20)} do {
													waituntil {sleep 1; (assignedtarget _pilot iskindof "LandVehicle") || (((getposatl _jet) select 2) < 20)};
													waituntil {sleep 0.1; (_jet aimedAtTarget [(assignedtarget _pilot)] > 0) || (((getposatl _jet) select 2) < 20)};
													_target = assignedtarget _pilot;
													_pilot fireAtTarget [_target];
													sleep 0.5;
													_pilot fireAtTarget [_target];
													sleep 0.5;
													_pilot fireAtTarget [_target];
													sleep 5;
													};
													};
							
							while {(((getposatl _chopper) select 2) > 20)} do {
														sleep _TargetDetectionRate; 
														_nearunits = nearestObjects [_chopper, ["Car","Tank","CAManBase","Motorcycle","StaticWeapon"], 1500];
														_targets = [];
														{if (((side _x) == west) && ((_x distance (markerpos "respawn_west")) > 1000)) then {_targets set [count _targets, _x];};}foreach _nearunits;
														
														
															if (count _targets > 0) then {
																		_grp setSpeedMode "LIMITED";
																				{_gunner reveal [_x, 4]; _x setvariable ["known_by_CAS",true]; if(!(_x iskindof "CAManBase")) then {{_x setvariable ["known_by_CAS",true];}foreach crew _x;}; }foreach _targets;
																						
																} else {
																		_grp setSpeedMode "FULL";
																		_chopper setfuel 1; _chopper setVehicleAmmo 1;
																				};
																				
																				
									};
									};
							
							[_helo2,_TargetDetectionRate] spawn {
									
							
private ["_nearunits","_targets","_chopper","_TargetDetectionRate","_gunner","_grp"];
_chopper = _this select 0;
							_TargetDetectionRate = _this select 1;
							_gunner = gunner _chopper;
							_grp = group _chopper;
							
							_chopper spawn {
											
private ["_target","_jet","_pilot","_gunner"];
_jet = _this;
											_pilot = driver _jet;
											_gunner = gunner _jet;
											while {(((getposatl _jet) select 2) > 20)} do {
													waituntil {sleep 1; (assignedtarget _pilot iskindof "LandVehicle") || (((getposatl _jet) select 2) < 20)};
													waituntil {sleep 0.1; (_jet aimedAtTarget [(assignedtarget _pilot)] > 0) || (((getposatl _jet) select 2) < 20)};
													_target = assignedtarget _pilot;
													_pilot fireAtTarget [_target];
													sleep 0.5;
													_pilot fireAtTarget [_target];
													sleep 0.5;
													_pilot fireAtTarget [_target];
													sleep 5;
													};
													}; 
							
							
							while {(((getposatl _chopper) select 2) > 20)} do {
														sleep _TargetDetectionRate; 
														_nearunits = nearestObjects [_chopper, ["Car","Tank","CAManBase","Motorcycle","StaticWeapon"], 1500];
														_targets = [];
														{if (((side _x) == west) && ((_x distance (markerpos "respawn_west")) > 1000)) then {_targets set [count _targets, _x];};}foreach _nearunits;
														
														
															if (count _targets > 0) then {
																	_grp setSpeedMode "LIMITED";
																			{_gunner reveal [_x, 4]; _x setvariable ["known_by_CAS",true]; if(!(_x iskindof "CAManBase")) then {{_x setvariable ["known_by_CAS",true];}foreach crew _x;}; }foreach _targets;
																} else {
																		_grp setSpeedMode "FULL";
																				_chopper setfuel 1; _chopper setVehicleAmmo 1;
																				};
																				
																				
									};
									};
							
							} else {
							//CAS is jet    
							[_helo1,_TargetDetectionRate] spawn {
									
							
private ["_bombs","_nearunits","_targets","_chopper","_TargetDetectionRate","_pilot","_grp"];
_chopper = _this select 0;
							_TargetDetectionRate = _this select 1;
							_pilot = driver _chopper;
							_grp = group _chopper;
							_bombs = false;
							if (_chopper iskindof "ACE_L39_TK_FAB250") then {
									_bombs = true;
									_chopper spawn {
											
private ["_handle","_jet","_pilot"];
_jet = _this;
											_pilot = driver _jet;
											while {(((getposatl _jet) select 2) > 20)} do {
													waituntil {sleep 1; (assignedtarget _pilot iskindof "LandVehicle") || (((getposatl _jet) select 2) < 20)};
													waituntil {sleep 0.1; ((_jet distance (assignedtarget _pilot)) < 220) || (((getposatl _jet) select 2) < 20)};
													//_pilot fireAtTarget [(assignedtarget _pilot), "ACE_AirBombLauncher"];
													sleep 0.5;
												// _jet setWeaponReloadingTime [_pilot, "ACE_AirBombLauncher", 0];
													_handle = _pilot fireAtTarget [(assignedtarget _pilot), "ACE_AirBombLauncher"];
													if(_handle) then {_jet allowdamage false;};
													sleep 5;
													_jet allowdamage true;
													};
													}; 
													};
							while {(((getposatl _chopper) select 2) > 20)} do {
														sleep _TargetDetectionRate; 
														_nearunits = nearestObjects [_chopper, ["Car","Tank"], 5000];
														_targets = [];
														{if (((side _x) == west) && ((_x distance (markerpos "respawn_west")) > 1000) && (isEngineOn _x)) then {_targets set [count _targets, _x];};}foreach _nearunits;
														
														if (count _targets > 0) then {
														
															if(!_bombs) then {_grp setSpeedMode "LIMITED";};
																			{ _pilot reveal [_x, 4]; _x setvariable ["known_by_CAS",true]; if(!(_x iskindof "CAManBase")) then {{_x setvariable ["known_by_CAS",true];}foreach crew _x;};}foreach _targets;
														
														} else {
																				_grp setSpeedMode "FULL";
																				_chopper setfuel 1; _chopper setVehicleAmmo 1;
																				};
									};
									};
							
							
							[_helo2,_TargetDetectionRate] spawn {
									
							
private ["_bombs","_nearunits","_targets","_chopper","_TargetDetectionRate","_pilot","_grp"];
_chopper = _this select 0;
							_TargetDetectionRate = _this select 1;
							_pilot = driver _chopper;
							_grp = group _chopper;
							_bombs = false;
							if (_chopper iskindof "ACE_L39_TK_FAB250") then {
									_bombs = true;
									_chopper spawn {
											
private ["_handle","_jet","_pilot"];
_jet = _this;
											_pilot = driver _jet; 
											while {(((getposatl _jet) select 2) > 20)} do {
													waituntil {sleep 1; (assignedtarget _pilot iskindof "LandVehicle") || (((getposatl _jet) select 2) < 20)};
												// hint "got target"; 
													waituntil {sleep 0.1; ((_jet distance (assignedtarget _pilot)) < 220) || (((getposatl _jet) select 2) < 20)};
												// hint "firing";
													//_pilot fireAtTarget [(assignedtarget _pilot), "ACE_AirBombLauncher"];
													sleep 0.5;
												// _jet setWeaponReloadingTime [_pilot, "ACE_AirBombLauncher", 0];
													_handle = _pilot fireAtTarget [(assignedtarget _pilot), "ACE_AirBombLauncher"];
													if(_handle) then {_jet allowdamage false;};
													sleep 5;
													_jet allowdamage true;
													};
													}; 
													};
							
							while {(((getposatl _chopper) select 2) > 20)} do {
														sleep _TargetDetectionRate; 
														_nearunits = nearestObjects [_chopper, ["Car","Tank"], 5000];
														_targets = [];
														{if (((side _x) == west) && ((_x distance (markerpos "respawn_west")) > 1000)&& (isEngineOn _x)) then {_targets set [count _targets, _x];};}foreach _nearunits;
														
														if (count _targets > 0) then {
														
																		if(!_bombs) then {_grp setSpeedMode "LIMITED";};
																				{ _pilot reveal [_x, 4]; _x setvariable ["known_by_CAS",true]; if(!(_x iskindof "CAManBase")) then {{_x setvariable ["known_by_CAS",true];}foreach crew _x;};}foreach _targets;
																			
														
														} else {
																				_grp setSpeedMode "FULL";
																				_chopper setfuel 1; _chopper setVehicleAmmo 1;
																				};
									};
									};
							
							
							
							};
					
					if(hz_debug_cas) then {vehicle player attachto [_helo2, [0,-50,10]]; helo2 = _helo2; _helo2 spawn {while {true} do {sleep 1; hintsilent format ["Height: %1\nPilot target: %2\nGunner target: %3",((getposatl player) select 2), assignedTarget driver _this, assignedTarget gunner _this];};};};


*/  



				/*
					_camera = "camera" camCreate (getpos _helo2);
					while {true}    do{
			_camera camSetTarget (assignedtarget _helo2);
				_camera camSetRelPos [100,-100,300];
	_camera camCommit 0;
				_camera cameraEffect ["internal","back"];
	showcinemaborder false;
							
							sleep 10;
							};
							*/
				
				
				
				// while { if(!isNil "_helo1") then { damage _helo1 < 1 }else{false} || if(!isNil "_helo2") then { damage _helo2 < 1 }else{false} } do {sleep 30;};
				while { if(!isNil "_helo1") then { (((getposatl _helo1) select 2) > 20) }else{false} || if(!isNil "_helo2") then { (((getposatl _helo2) select 2) > 20)  }else{false} } do {sleep 60;};
				
				{_x setvariable ["known_by_CAS",false];} foreach allunits;
				
				_waitfor = 2700;
				_waitfor = _waitfor + (random 18900); // min. 45m - max 6h
				sleep _waitfor; 


				//sleep 60;
				{
					_veh = vehicle _x;
					if (_veh == _x) then {							
						deletevehicle _x;							
					} else {							
						_veh deleteVehicleCrew _x;							
					};
				}forEach (units _groupgrp1);
				if(!isNil "_helo1") then { deleteVehicle _helo1; };
				if(!isNil "_helo2") then { deleteVehicle _helo2; };
				
				deletegroup _groupgrp1;
				
			};
		};


		While{ damage heli_radar < 1} do { 
			
			if((({side _x == (SIDE_B select 0)} count nearestobjects [_radarlocation,["CAManBase"],750]) < 20) && (count allunits < Hz_max_allunits)) then {

				//call reinforcements
				//_paradrop = true;
				//if((random 1) < 0.5) then {_paradrop = false;};
				_paragrp = creategroup (SIDE_B select 0);
				[_paragrp,[-5000,15000,500],_radarlocation,true] call CREATE_OPFOR_PARADROP;
				_paragrp deleteGroupWhenEmpty true;

				uisleep 450;

			};

		};

		if(Hz_max_ambient_units > 0) then {
			
			Hz_max_ambient_units = Hz_max_ambient_units - 20;
			Hz_max_units_before_task = Hz_max_units_before_task - 20;
			Hz_max_allunits = Hz_max_allunits - 20;
			Hz_max_deadunits = Hz_max_deadunits + 20;
			
		};


		//terminate _script;
		//terminate _script2;

		//mission_commandchat = "Enemy Radar Destroyed - Enemy can't call in further Air Support"; publicVariable "mission_commandchat";

		//[-1, {hint "Enemy Air Radar Destroyed - Enemy air support will be severely affected for some time!";}] call CBA_fnc_globalExecute;


		[_radarlocation] spawn {

			_position = _this select 0;

			while{ {isPlayer _x} count nearestObjects[_position,["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 60 };
			{deletevehicle _x}forEach Hz_radarObjects;

		};

	};


	heli_radar = nil;
	Hz_save_radar_pos = [0,0,0];

	//Min 2 weeks, max 5 weeks
	if(Hz_save_radar_spawn_timer == 0) then {Hz_save_radar_spawn_timer = 1209600 + (random 1814400);};

	while {Hz_save_radar_spawn_timer > 0} do {sleep 60; Hz_save_radar_spawn_timer = Hz_save_radar_spawn_timer - 60;};

	Hz_save_radar_spawn_timer = 0;

};

