waitUntil {!isNull player};

[] spawn {

scriptname "Hz_pops_HCmain";

_timescaler1 = 0;
_timescaler2 = 0;
_timescaler3 = 0;

	while {true} do {
		
		//3.8 minute loop    
		uisleep 233;
		_timescaler1 = _timescaler1 + 1;
		_timescaler2 = _timescaler2 + 1;
		_timescaler3 = _timescaler3 + 1;
		
		// unglitch garrisoned infantry etc.
		{
		
			if (local _x) then {
			
				if ((vehicle _x) == _x) then {
			
					if (((animationState _x) find "afal") != -1) then {
					
						if ((_x distance (_x getVariable ["animCorrectionOldPos",getposatl _x])) < 1) then {
						
							_posASL = getPosASL _x;
							_endPos = _posASL vectorAdd [0,0,-2];
							_beginPos = _posASL vectorAdd [0,0,100];
							_correctionPos = ((lineIntersectsSurfaces [_beginPos, _endPos, _x]) select 0) select 0;
							if (isnil "_correctionPos") exitWith {};
							_x setPosASL [_posASL select 0, _posASL select 1, (_correctionPos select 2) + 0.5];
						
						};
						
						_x setVariable ["animCorrectionOldPos",getposatl _x];
								
					};
				
				};
			
			};
		
		} foreach allunits;
		
		if((count alldead) > Hz_max_deadunits) then {

			//dead body cleanup    
			{
			
				if (local _x) then {
				
					if(_x iskindof "CAManBase") then {
					
						_dude = _x;
					
						if(!(_x getvariable ["NoDelete",false]) && ((_x distance (markerpos "respawn_west")) > 300) && (({(_x distance _dude) < 300} count playableUnits) < 1)) then {
						
							_weaponHolders = nearestObjects [_x,["WeaponHolderSimulated"],3];
					
							{								
								deletevehicle _x;							
							} foreach _weaponHolders;					
						
							_veh = vehicle _x;
							if (_veh == _x) then {							
								deletevehicle _x;							
							} else {							
								_veh deleteVehicleCrew _x;							
							};
						
						};
					
					};
				
				};

			}foreach AllDead;

		};
		/*
		{
	
			if (local _x) then {
		
				if (({alive _x} count (units _x)) < 1) then {
				
					deletegroup _x;
				
				};
			
			};
	
		}foreach allgroups;
		*/
		//3 hour loop
		if(_timescaler3 > 45) then {
			
			{
			
				if (local _x) then {
			
					//dead vehicle cleanup
					if ((_x iskindof "LandVehicle") || (_x iskindof "Air") || (_x iskindof "Boat_F")) then {
					
							_veh = _x;
					
							if(!(_x getvariable ["NoDelete",false]) && (({(_x distance _veh) < 2000} count playableUnits) < 1)) then {
							
								{
									_veh deleteVehicleCrew _x;							
								} foreach crew _veh;
							
								deleteVehicle _veh;					
							
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

scriptname "Hz_pops_HCdiag";

while {true} do {

	diag_log format ["### Hz_diag: %1, %2, %3, %4, %5, %6",diag_fps,viewDistance, count diag_activeSQFScripts, {local _x} count allunits, {local _x} count vehicles, {local agent _x} count agents];

	uisleep 5;

	if(diag_fps < Hz_min_desired_server_FPS) then {if(viewdistance > (Hz_min_desired_server_VD + 200)) then {setviewdistance (viewdistance - 200);}else {setviewdistance Hz_min_desired_server_VD;};} else {
	if(diag_fps > Hz_max_desired_server_FPS) then {if(viewdistance < (Hz_max_desired_server_VD - 200)) then {setviewdistance (viewdistance + 200);}else {setviewdistance Hz_max_desired_server_VD;};};};

};
