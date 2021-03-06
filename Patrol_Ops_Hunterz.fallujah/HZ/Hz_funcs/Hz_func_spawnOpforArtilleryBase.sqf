
private ["_artylocation", "_newComp", "_rocketArty", "_composition", "_location", "_newcomp", "_grp", "_dude", "_i", "_marker", "_defendersGrp", "_carspawnpos", "_car_type", "_vehgrp", "_staticgrp", "_aliveGuns", "_cond", "_paragrp"];

if(!(call Hz_fnc_isAiMaster)) exitWith{};

//init delay
//sleep 60;

while {true} do {
	
	if(Hz_save_arty_spawn_timer == 0) then {       

		arty_guns = [];
		Hz_artyBaseObjects = [];
		_artylocation = [];
		_newComp = [];

		_rocketArty = false;
		_composition = "Compositions\Opfor\Bases\Arty_base.sqf";
		if ((random 1) < 0.5) then {

			_rocketArty = true;
			_composition = "Compositions\Opfor\Bases\grad_base.sqf";

		};

		while {(count arty_guns) < 1} do {
			
			if((format ["%1",Hz_save_arty_pos]) == "[0,0,0]") then {
				
				_location = [["hills"]] call mps_getNewLocation;
				_artylocation = [position _location,6000] call Hz_func_findspawnpos;    
				
				waituntil {sleep 10; ({(_x distance _artylocation) < 4000} count playableunits) < 1};

			} else {
				
				_artylocation = Hz_save_arty_pos;  
				
				if (Hz_save_arty_rocketArty) then {
					
					_rocketArty = true;
					_composition = "Compositions\Opfor\Bases\grad_base.sqf";
					
				} else {
					
					_rocketArty = false;
					_composition = "Compositions\Opfor\Bases\Arty_base.sqf";
					
				};   
			};
			
			_newComp = [_artylocation, random 360,(call compile preprocessfilelinenumbers _composition)] call BIS_fnc_ObjectsMapper;
			{ if(((toupper typeOf _x) == "D30_TK_INS_EP1") || ((toupper typeOf _x) == "GRAD_TK_EP1")) then {arty_guns set [count arty_guns,_x];}; }forEach _newcomp;
			
			if((count arty_guns) < 1) then {sleep 10;} else {Hz_save_arty_pos = _artylocation;};

		};

		if(Hz_max_ambient_units > 0) then {
			
			Hz_max_ambient_units = Hz_max_ambient_units + 35;
			Hz_max_units_before_task = Hz_max_units_before_task + 35;
			Hz_max_allunits = Hz_max_allunits + 35;
			Hz_max_deadunits = Hz_max_deadunits - 35;
			
		};

		{
				
      if(_x iskindof "sa_m109a6_M795_pallet") then {clearweaponcargoglobal _x; clearmagazinecargoglobal _x;};		

		}foreach _newComp;

		
		if (!_rocketArty) then {	
			
			Hz_save_arty_rocketArty = false;
			
			{
				
				_x setvariable ["nodelete",true];
				_grp = creategroup (SIDE_B select 0);

				for "_i" from 1 to 3 do {
					_dude = _grp createUnit [(mps_opfor_riflemen call mps_getrandomelement), _artylocation, [], 50, "NONE"];
					if(_i == 1) then {_dude assignasgunner _x; _dude moveingunner _x;} else {_dude assignascargo _x; _dude moveincargo _x;};
				};
				
				_grp deleteGroupWhenEmpty true;
				
				[_x] spawn Hz_AI_artillery;
				_x setvehiclelock "locked";
				_x setvariable ["R3F_LOG_disabled",true];

			} foreach arty_guns;

		} else {

			Hz_save_arty_rocketArty = true;

			{
				
				_x setvariable ["nodelete",true];
				_grp = creategroup (SIDE_B select 0);

				for "_i" from 1 to 2 do {
					_dude = _grp createUnit [(mps_opfor_riflemen call mps_getrandomelement), _artylocation, [], 50, "NONE"];
					if(_i == 1) then {_dude assignasgunner _x; _dude moveingunner _x;} else {_dude assignascargo _x; _dude moveincargo _x;};
				};	
				
				_grp deleteGroupWhenEmpty true;
				
				[_x] spawn Hz_AI_rocketArtillery;
				_x setvehiclelock "locked";
				_x setvariable ["R3F_LOG_disabled",true];

			} foreach arty_guns;	

		};
    
    [_newComp] call Hz_func_initOpforComposition;

		if(mps_debug) then {
			_marker = createMarkerLocal ["masarkerh",_artylocation];
			_marker setMarkerTypeLocal "mil_triangle";
			_marker setMarkerColorLocal "ColorRed";
			mission_sidechat = format["OPFOR Arty base created at grid %1.",mapGridPosition _artylocation]; publicVariable "mission_sidechat";
			[WEST,"HQ"] sideChat mission_sidechat;               
		};

		//_defendersGrp = creategroup (SIDE_B select 0);
		_carspawnpos = [(_artylocation select 0) + 350,(_artylocation select 1) + 350,0];

		for "_i" from 1 to 3 do {
			_grp = [_artylocation,"INF",(6 + random 8),20,"standby"] call CREATE_OPFOR_SQUAD;                 

			if(random 1 > 0.7) then {
				_car_type = (mps_opfor_car+mps_opfor_apc) call mps_getRandomElement;
				_vehgrp = [_car_type,SIDE_B,_carspawnpos,100] call mps_spawn_vehicle;
				sleep 1;
				
				{if(!((vehicle _x) in Hz_artyBaseObjects)) then {Hz_artyBaseObjects set [count Hz_artyBaseObjects, vehicle _x];}; Hz_artyBaseObjects set [count Hz_artyBaseObjects,_x];}foreach units _vehgrp;
				//(units _vehgrp) joinSilent _defendersGrp;
			};
			
			{
				Hz_artyBaseObjects set [count Hz_artyBaseObjects,_x];
				
			} foreach units _grp;
			
			_grp setformation "DIAMOND";
			
		};

		//for "_i" from 1 to (round(random 5)) do { _staticgrp = [_artylocation,"nocleanup"] call CREATE_OPFOR_STATIC; {if(!((vehicle _x) in Hz_artyBaseObjects)) then {Hz_artyBaseObjects = Hz_artyBaseObjects + [vehicle _x];};}foreach units _staticgrp; (units _staticgrp) joinSilent _defendersGrp;};

		//debug
		{
		
			_x addEventHandler ["Killed", {
				diag_log "Arty gun killed";
				diag_log str _this;
				diag_log format ["Server time: %1",serverTime];
			}];
		
		}foreach arty_guns;
		
		_aliveGuns = count arty_guns;
		_cond = true;
		While{_cond} do { 
			
			if((({side _x == (SIDE_B select 0)}count (_artylocation nearEntities [["CAManBase"],750])) < 20) && (count allunits < Hz_max_allunits)) then {

				//call reinforcements
				_paragrp = creategroup (SIDE_B select 0);
				[_paragrp,[-5000,15000,500],_artylocation,true] call CREATE_OPFOR_PARADROP;
				_paragrp deleteGroupWhenEmpty true;

				sleep 600;

			};

			{
				if(!alive _x) then {_aliveGuns = _aliveGuns - 1;};

			}foreach arty_guns;

			if(_aliveGuns == 0) then {_cond = false;};

		};

		if(Hz_max_ambient_units > 0) then {
			
			Hz_max_ambient_units = Hz_max_ambient_units - 35;
			Hz_max_units_before_task = Hz_max_units_before_task - 35;
			Hz_max_allunits = Hz_max_allunits - 35;
			Hz_max_deadunits = Hz_max_deadunits + 35;
			
		};


		[_artylocation] spawn {

private ["_position"];
            
_position = _this select 0;

			while{ {(_x distance _position) < 5000} count playableunits > 0} do { sleep 60 };
			{deletevehicle _x}forEach Hz_artyBaseObjects;

		};

	};


	arty_guns = [];
	Hz_save_arty_pos = [0,0,0];

	//Min 2 weeks, max 4 weeks
	if(Hz_save_arty_spawn_timer == 0) then {Hz_save_arty_spawn_timer = 1209600 + (random 1209600);};

	while {Hz_save_arty_spawn_timer > 0} do {sleep 60; Hz_save_arty_spawn_timer = Hz_save_arty_spawn_timer - 60;};

	Hz_save_arty_spawn_timer = 0;

};

