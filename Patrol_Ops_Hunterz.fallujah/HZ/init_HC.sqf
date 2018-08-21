waitUntil {!isNull player};

if ((name player) == HC_patrolsName) then {

	waitUntil {!isnil "Hz_pops_UPSPassToHCArray"};
	waitUntil {!isnil "Hz_max_ambient_units"};
	
	//copy array in case HC loses connection later
	Hz_pops_UPSRespawnArray = +Hz_pops_UPSPassToHCArray;

	Hz_max_ambient_units = Hz_max_ambient_units*3;
	sleep 600;
	Hz_max_ambient_units = Hz_max_ambient_units/3;

};

[] spawn {

_timescaler1 = 0;
_timescaler2 = 0;
_timescaler3 = 0;

	while {true} do {
		
		//3.8 minute loop    
		uisleep 233;
		_timescaler1 = _timescaler1 + 1;
		_timescaler2 = _timescaler2 + 1;
		_timescaler3 = _timescaler3 + 1;
		
		if((count alldead) > Hz_max_deadunits) then {

			//dead body cleanup    
			{
			
				if (local _x) then {
				
					if(_x iskindof "CAManBase") then {
					
						_dude = _x;
					
						if(!(_x getvariable ["NoDelete",false]) && ((_x distance (markerpos "respawn_west")) > 300) && (({(_x distance _dude) < 300} count playableUnits) < 1)) then {
						
							_weaponHolders = nearestObjects [_x, ["WeaponHolderSimulated"],3];
					
							{
								
								deletevehicle _x;
							
							} foreach _weaponHolders;					
						
							deleteVehicle _x;
						
						};
					
					};
				
				};

			}foreach AllDead;

		};
		
		{
	
			if (local _x) then {
		
				if (({alive _x} count (units _x)) < 1) then {
				
					deletegroup _x;
				
				};
			
			};
	
		}foreach allgroups;
		
		//3 hour loop
		if(_timescaler3 > 45) then {
			
			{
			
				if (local _x) then {
			
					//dead vehicle cleanup
					if ((_x iskindof "LandVehicle") || (_x iskindof "Air") || (_x iskindof "Boat_F")) then {
					
							_veh = _x;
					
							if(!(_x getvariable ["NoDelete",false]) && (({(_x distance _veh) < 300} count playableUnits) < 1)) then {
							
								deleteVehicle _x;				
							
							};
						
					};
					
				};
				
			}foreach AllDead;      
			
			_timescaler3 = 0;
			
		};
		
		//6 hour loop
		if(_timescaler2 > 90) then {
			
			_timescaler2 = 0; 
			
		};

	}; 

};

while {true} do {

	diag_log format ["### Hz_diag: %1, %2, %3, %4",diag_fps,viewDistance, count diag_activeSQFScripts, {local _x} count allunits, {local _x} count vehicles];

	uisleep 5;

	if(diag_fps < Hz_min_desired_server_FPS) then {if(viewdistance > (Hz_min_desired_server_VD + 200)) then {setviewdistance (viewdistance - 200);}else {setviewdistance Hz_min_desired_server_VD;};} else {
	if(diag_fps > Hz_max_desired_server_FPS) then {if(viewdistance < (Hz_max_desired_server_VD - 200)) then {setviewdistance (viewdistance + 200);}else {setviewdistance Hz_max_desired_server_VD;};};};

};