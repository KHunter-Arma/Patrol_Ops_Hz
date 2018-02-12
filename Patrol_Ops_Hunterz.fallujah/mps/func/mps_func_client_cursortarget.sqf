// Written by EightySix
// Inspired by R3F logistics

if(isDedicated) exitWith{};

private ["_cursTarget","_recruit_units","_intelaction1","_type","_condition_load","_condition_drag","_condition_unload"];


private["_cursTarget"];

	_condition_load = "(count nearestObjects [_target,mps_transports,8] > 0) && !(_target getVariable ""mps_loadable"")";
	_condition_drag = "!(_target getVariable ""mps_loadable"")";
	_condition_unload = "(_target getVariable ""mps_loadable"")";

	while {true} do {
            
		_cursTarget = objnull;
//		_ied_detonate = nil;
//		_ied_defuse = nil;
//		_load_container = nil;
//		_unld_container = nil;
//		_view_contents = nil;
//		_load_object = nil;
//		_select_object = nil;
//		_grab_object = nil;
//		_vehicle_repair = nil;
//		_vehicle_unflip = nil;
//		_srvpnt_ammobox = nil;
		_recruit_units = nil;
		_intelaction1 = nil;
//		_intelaction2 = nil;
//		_adminlock = nil;
//		_adminunlock = nil;
//		_adminreset = nil;

		_cursTarget = cursorTarget;

		if(!isNull _cursTarget && player distance _cursTarget < 6 && vehicle player == player) then {

			player reveal _cursTarget;

			_type = getText (configFile >> "CfgVehicles" >> typeof _cursTarget >> "displayName");
/*

			if ({_cursTarget isKindOf (_x select 0)} count mps_transportable_containers > 0) then {
				_loaded = _cursTarget getVariable "mps_loadable";
				if(isNil "_loaded") then {_cursTarget setVariable ["mps_loadable",false,true]};
			};

			if ( {_cursTarget isKindOf _x} count ["LandVehicle","Air"] > 0 ) then {
				_locked = _cursTarget getVariable "mps_veh_locked";
				if(isNil "_locked") then {_cursTarget setVariable ["mps_veh_locked",false,true]};
			};
*/


// IEDS
		//	if(!isNil {_cursTarget getVariable "mps_ied"}) then { _ied_detonate = _cursTarget addaction ["<t color=""#FF0000"">Blow IED</t>",(mps_path+"action\mps_ied_detonate.sqf"),[],99,true,true,"",""]; };
		//	if(!isNil {_cursTarget getVariable "mps_ied"}) then { _ied_defuse   = _cursTarget addaction ["<t color=""#F00000"">Defuse IED</t>",(mps_path+"action\mps_ied_defuse.sqf"),[],98,true,true,"",""]; };
// LOGISTICS CONTAINERS
		//	if ({_cursTarget isKindOf (_x select 0)} count mps_transportable_containers > 0 && {_cursTarget isKindOf _x} count ["LandVehicle"] == 0 ) then { _load_container = _cursTarget addaction [format[  "Load %1",_type],(mps_path+"action\mps_logistics_load_container.sqf"),[],-1,true,true,"",_condition_load]; };
		//	if ({_cursTarget isKindOf (_x select 0)} count mps_transportable_containers > 0) then { _unld_container = _cursTarget addaction [format["Unload %1",_type],(mps_path+"action\mps_logistics_unld_container.sqf"),[],-1,true,true,"",_condition_unload]; };
		//	if ({_cursTarget isKindOf (_x select 0)} count mps_transportable_containers > 0) then { _view_contents  = _cursTarget addAction [format["View contents of %1",_type], (mps_path+"action\mps_logistics_view_contents.sqf"),[],-1,true,true,"",""]; };
// LOGISTICS OBJECTS
		//	if ({_cursTarget isKindOf (_x select 0)} count mps_transportable_containers > 0) then { _load_object= _cursTarget addAction [format["...load into %1",_type], (mps_path+"action\mps_logistics_load_object.sqf"),[],1,true,true,"","mps_loading_in_progress"]; };
		//	if ({_cursTarget isKindOf (_x select 0)} count mps_loadable_objects > 0) then { _select_object = _cursTarget addAction [format["Load %1 into...",_type], (mps_path+"action\mps_logistics_select_object.sqf"),[],1,true,true,"",""]; };
		//	if ({_cursTarget isKindOf (_x select 0)} count mps_loadable_objects > 0) then { _grab_object = _cursTarget addAction [format["Grab %1",_type], (mps_path+"action\mps_logistics_grab_object.sqf"),[],1,true,true,"",""]; };
// Repair Action
		//	if ( {_cursTarget isKindOf _x} count ["LandVehicle","Air"] > 0 && (mps_player_class == "engineer" || !mps_class_limit) && ( damage _cursTarget > 0.1 || !canMove _cursTarget ) ) then { _vehicle_repair = _cursTarget addAction [format[localize "STR_Client_Repair_menu",_type],(mps_path+"action\mps_vehicle_repair.sqf"),[],-1,true,true,"",""]; };
		//	if ( {_cursTarget isKindOf _x} count ["LandVehicle","Air"] > 0 && ((vectorUp _cursTarget) select 2) < 0 ) then { _vehicle_unflip = _cursTarget addAction [format[localize "STR_Client_Unflip_menu",_type],(mps_path+"action\mps_vehicle_unflip.sqf"),[],-1,true,true,"",""]; };

// Get ammobox from service point
//			if ({_cursTarget isKindOf _x} count ["Base_WarfareBVehicleServicePoint"] > 0) then { _srvpnt_ammobox = _cursTarget addaction ["<t color=""#FFc600"">Grab Ammobox</t>",(mps_path+"action\mps_resupply_get_ammobox.sqf"),[],99,true,true,"",""]; };

// Unit Recruitment
			if ({_cursTarget isKindOf _x} count ["Base_WarfareBBarracks"] > 0) then { _recruit_units = _cursTarget addaction ["<t color=""#FFc600"">Recruit Unit</t>",(mps_path+"action\mps_recruit_dialog.sqf"),[],-1,true,true,"",""]; };

// Question Civillians
			if (_cursTarget isKindOf "Civilian" && ((side _cursTarget == civilian) || (captive _cursTarget)) && alive  _cursTarget) then { _intelaction1 = _cursTarget addAction [format["Question %1",_type], (mps_path+"action\mps_interaction_question.sqf"),[],1,true,true,"","(!isplayer _target) && ((_target distance _this) < 2)"]; };
		//	if ({_cursTarget isKindOf _x} count ["Man"] > 0 && side _cursTarget == civilian && !alive _cursTarget) then { _intelaction2 = _cursTarget addAction [format["Search %1 for Intel",_type], (mps_path+"action\mps_interaction_question.sqf"),[],1,true,true,"",""]; };

// ADMIN LOCK VEHICLE
		//	if( {_cursTarget isKindOf _x} count ["LandVehicle","Air"] > 0 && (serverCommandAvailable "#shutdown") ) then { _adminlock = _cursTarget addAction [format["Lock %1",_type], (mps_path+"action\mps_admin_lock.sqf"),1,1,true,true,"","!(_target getVariable ""mps_veh_locked"")"]; };
		//	if( {_cursTarget isKindOf _x} count ["LandVehicle","Air"] > 0 && (serverCommandAvailable "#shutdown") ) then { _adminunlock = _cursTarget addAction [format["Unlock %1",_type], (mps_path+"action\mps_admin_lock.sqf"),0,1,true,true,"","(_target getVariable ""mps_veh_locked"")"]; };
		//	if( {_cursTarget isKindOf _x} count ["LandVehicle","Air"] > 0 && (serverCommandAvailable "#shutdown") ) then { _adminreset = _cursTarget addAction [format["Reset %1",_type], (mps_path+"action\mps_admin_reset.sqf"),0,1,true,true,"","(_target getVariable ""mps_veh_locked"")"]; };

			waitUntil{ sleep 1; _cursTarget != cursorTarget };

		//	if(!isNil "_ied_detonate") then {_cursTarget removeAction _ied_detonate };
		//	if(!isNil "_ied_defuse")   then {_cursTarget removeAction _ied_defuse };
		//	if(!isNil "_load_container") then {_cursTarget removeAction _load_container };
		//	if(!isNil "_unld_container") then {_cursTarget removeAction _unld_container };
		//	if(!isNil "_view_contents") then {_cursTarget removeAction _view_contents };
		//	if(!isNil "_load_object") then {_cursTarget removeAction _load_object };
		//	if(!isNil "_select_object") then {_cursTarget removeAction _select_object };
		//	if(!isNil "_grab_object") then {_cursTarget removeAction _grab_object };
		//	if(!isNil "_vehicle_repair") then {_cursTarget removeAction _vehicle_repair };
		//	if(!isNil "_vehicle_unflip") then {_cursTarget removeAction _vehicle_unflip };
		//	if(!isNil "_srvpnt_ammobox") then {_cursTarget removeAction _srvpnt_ammobox };
			if(!isNil "_recruit_units") then {_cursTarget removeAction _recruit_units };
			if(!isNil "_intelaction1") then {_cursTarget removeAction _intelaction1 };
		//	if(!isNil "_intelaction2") then {_cursTarget removeAction _intelaction2 };
		//	if(!isNil "_adminlock") then {_cursTarget removeAction _adminlock };
               //     	if(!isNil "_adminunlock") then {_cursTarget removeAction _adminunlock };
		//	if(!isNil "_adminreset") then {_cursTarget removeAction _adminreset };
		};

		sleep 1;
	};