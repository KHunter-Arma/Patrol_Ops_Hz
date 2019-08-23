AIvcl_respawn_UPS = compile preprocessFileLineNumbers "AIvcl_respawn_UPS\AIvcl_respawn_UPS.sqf";
Hz_pops_patrols_startUPS = compile preprocessFileLineNumbers "AIvcl_respawn_UPS\UPSvcl_init.sqf";
Hz_pops_deleteVehicleArray = [];
Hz_pops_UPSRespawnArray = [];

// UPS respawn thread
[] spawn {

	scriptname "Hz_pops_UPSrespawn";

	while {true} do {

		sleep 20;

		{
		
			if (!alive _x) then {
					
				Hz_pops_deleteVehicleArray = Hz_pops_deleteVehicleArray - [_x];
			
			};

		} foreach Hz_pops_deleteVehicleArray;
		
		{
		
			_randomIndex = floor random (count Hz_pops_UPSRespawnArray);
		
			_randomPatrol = Hz_pops_UPSRespawnArray select _randomIndex; 
		
			if 	(			
						(!missionload)
					&& {(count allunits) < Hz_max_ambient_units}
					&& {_mpos = markerpos (_randomPatrol select 2); (({(_mpos distance _x) < 4000} count playableunits) < 1) || hz_debug}
					) exitWith {
								 
					  _randomPatrol spawn AIvcl_respawn_UPS;
						Hz_pops_UPSRespawnArray set [_randomIndex,"nil"];
						Hz_pops_UPSRespawnArray = Hz_pops_UPSRespawnArray - ["nil"];
			
					};
		
		} foreach Hz_pops_UPSRespawnArray;
        
		{
		
			if (local _x) then {
			
				if ((_x getVariable ["Hz_disabledPatrol",false]) && {(time - (_x getvariable ["Hz_AI_lastCriticalDangerTime",-600])) > 600} && {_leadPos = getpos leader _x; ({(_x distance _leadPos) < 2000} count playableunits) < 1}) then {
				
					_veh = objnull;									
					{
					
						_veh = vehicle _x;					
						unassignvehicle _x;
						_x action ["Eject", _veh];	
					
					} foreach units _x;	
					(units _x) ordergetin false;
					(units _x) allowgetin false;
					_x leaveVehicle _veh;	
					
					//_x setVariable ["Hz_defending",false];
					_x setVariable ["Hz_disabledPatrol",false];
					_x setVariable ["Hz_disabledEjectedPatrol",true];
				
				};
			
			};
		
		} foreach allGroups;

		{
		
			if (local _x) then {
			
				if ((_x getVariable ["Hz_disabledEjectedPatrol",false]) && {(time - (_x getvariable ["Hz_AI_lastCriticalDangerTime",-600])) > 900} && {_leadPos = getpos leader _x; ({(_x distance _leadPos) < 2000} count playableunits) < 1}) then {
				
					{
						_veh = vehicle _x;
						if (_veh == _x) then {							
							deletevehicle _x;							
						} else {							
							_veh deleteVehicleCrew _x;							
						};
					} foreach units _x;
				
				};
			
			};		
		
		} foreach allGroups;

	};

};

UPS_respawn_initDone = true;

