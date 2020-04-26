AIvcl_respawn_UPS = compile preprocessFileLineNumbers "AIvcl_respawn_UPS\AIvcl_respawn_UPS.sqf";
Hz_pops_patrols_startUPS = compile preprocessFileLineNumbers "AIvcl_respawn_UPS\UPSvcl_init.sqf";
Hz_pops_baseSupport = compile preprocessFileLineNumbers "Hz_pops_baseSupport.sqf";
Hz_pops_baseSupportOffline = true;
Hz_pops_baseSupportEnabled = true;
Hz_pops_deleteVehicleArray = [];
Hz_pops_UPSRespawnArray = [];
Hz_pops_UpsOpforUnits = [];
Hz_pops_UpsBluforUnits = [];
Hz_pops_UpsGrnforUnits = [];

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

		if ((!missionload) && {(count allunits) < Hz_max_ambient_units}) then {
			
			{
				if (!alive _x) then {
					Hz_pops_UpsGrnforUnits = Hz_pops_UpsGrnforUnits - [_x];
				};
			} foreach Hz_pops_UpsGrnforUnits;
			{
				if (!alive _x) then {
					Hz_pops_UpsOpforUnits = Hz_pops_UpsOpforUnits - [_x];
				};
			} foreach Hz_pops_UpsOpforUnits;
			{
				if (!alive _x) then {
					Hz_pops_UpsBluforUnits = Hz_pops_UpsBluforUnits - [_x];
				};
			} foreach Hz_pops_UpsBluforUnits;
			
			_countGrnfor = count Hz_pops_UpsGrnforUnits;
			_countBlufor = count Hz_pops_UpsBluforUnits;
			_countOpfor = count Hz_pops_UpsOpforUnits;
			
			_GrnforArray = [];
			_BluforArray = [];
			_OpforArray = [];			
			{
				switch (_x select 4) do {
					case blufor : {
						_BluforArray pushBack _x;		
					};
					case opfor : {
						_OpforArray pushBack _x;	
					};
					case resistance : {
						_GrnforArray pushBack _x;	
					};
				};		
			} foreach Hz_pops_UPSRespawnArray;
			
			_patrolArray = Hz_pops_UPSRespawnArray;			
			switch (true) do {
				case (((count _GrnforArray) > 0) && {(_countGrnfor < (0.65*_countOpfor)) || {_countGrnfor < (0.65*_countBlufor)}}) : {
					_patrolArray = _GrnforArray;
				};
				case (((count _BluforArray) > 0) && {(_countBlufor < (0.65*_countOpfor)) || {_countBlufor < (0.65*_countGrnfor)}}) : {
					_patrolArray = _BluforArray;
				};
				case (((count _OpforArray) > 0) && {(_countOpfor < (0.65*_countBlufor)) || {_countOpfor < (0.65*_countGrnfor)}}) : {
					_patrolArray = _OpforArray;
				};
			};
						
			{						
				_randomIndex = floor random (count _patrolArray);
				
				_randomPatrol = _patrolArray select _randomIndex; 
				
				_mpos = markerpos (_randomPatrol select 2);
				
				if ((({(_mpos distance _x) < 3000} count playableunits) < 1) || {hz_debug}) exitWith {
					
					_randomPatrol spawn AIvcl_respawn_UPS;
					_randomIndex = Hz_pops_UPSRespawnArray find _randomPatrol;
					Hz_pops_UPSRespawnArray set [_randomIndex,"nil"];
					Hz_pops_UPSRespawnArray = Hz_pops_UPSRespawnArray - ["nil"];		
				};		
			} foreach _patrolArray;
			
		};
		
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

