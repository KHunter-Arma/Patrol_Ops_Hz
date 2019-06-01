AIvcl_respawn_UPS = compile preprocessFileLineNumbers "AIvcl_respawn_UPS\AIvcl_respawn_UPS.sqf";
Hz_pops_patrols_startUPS = compile preprocessFileLineNumbers "AIvcl_respawn_UPS\UPSvcl_init.sqf";
Hz_pops_deleteVehicleArray = [];
Hz_pops_UPSRespawnArray = [];

// UPS respawn thread
[] spawn {

	while {true} do {

		sleep 20;

		{
		
			if (alive _x) then {
		
				if ((count crew _x) == 0) then {
				//moved to dead vehicle main cleanup loop instead for ambience
				/*
					if (({ isplayer _x} count nearestObjects [getposatl _x,["CAManBase"],1000]) == 0) then {
					
						Hz_pops_deleteVehicleArray = Hz_pops_deleteVehicleArray - [_x];
						deletevehicle _x;				
					
					};
				*/
				} else {
				
					//failed spawn?...
					if (canMove _x) then {
					
						_grp = group _x;
						{deletevehicle _x} foreach crew _x;
						{deletevehicle _x} foreach units _grp;
						Hz_pops_deleteVehicleArray = Hz_pops_deleteVehicleArray - [_x];
						deletevehicle _x;	
						deleteGroup _grp;
					
					};
				
				};
			
			} else {
			
				Hz_pops_deleteVehicleArray = Hz_pops_deleteVehicleArray - [_x];
			
			};

		} foreach Hz_pops_deleteVehicleArray;
		
		{
		
			_randomIndex = floor random (count Hz_pops_UPSRespawnArray);
		
			_randomPatrol = Hz_pops_UPSRespawnArray select _randomIndex; 
		
			if 	(			
						(!missionload)
					&& {(count allunits) < Hz_max_ambient_units}
					&& {({isplayer _x} count nearestObjects[markerpos (_randomPatrol select 2),["CAManBase"],5000] < 1) || hz_debug}
					) exitWith {
								 
					  _randomPatrol spawn AIvcl_respawn_UPS;
						Hz_pops_UPSRespawnArray set [_randomIndex,"nil"];
						Hz_pops_UPSRespawnArray = Hz_pops_UPSRespawnArray - ["nil"];
			
					};
		
		} foreach Hz_pops_UPSRespawnArray;
        
		{
		
			if (local _x) then {
			
				if ((_x getVariable ["Hz_disabledPatrol",false]) && {(time - (_x getvariable ["Hz_AI_lastCriticalDangerTime",-600])) > 300} && {({isplayer _x} count (nearestObjects [getpos leader _x,["CAManBase"],2000])) < 1}) then {
				
					{
					
						_veh = vehicle _x;
						
						{
						
							deleteVehicle _x;
						
						} foreach crew _veh;

						deleteVehicle _veh;
						deleteVehicle _x;
					
					} foreach units _x;  

					//deleteGroup _x;
				
				};
			
			};
		
		} foreach allGroups;    

	};

};

UPS_respawn_initDone = true;

