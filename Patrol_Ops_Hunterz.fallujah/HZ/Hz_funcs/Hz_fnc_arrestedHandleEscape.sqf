[] spawn {

	_exit = false;

  while {!_exit} do {

    sleep 2;
    
    if (((getposatl player) distance Hz_pops_arrestPosition) > 5) then {
    
			if !((getPlayerUID player) in BanList) exitWith {
			
				call Hz_pers_API_enablePlayerSaveStateOnDisconnect;
				_exit = true;
			
			};
		
			/*
		
			call Hz_pers_API_disablePlayerSaveStateOnDisconnect;
      endmission "Escaped";
			
			*/
			
			player setposatl Hz_pops_arrestPosition;
    
    };

  };
	
	if (!Hz_pops_clientInitDone) then {
	
		[] execVM (mps_path+"init_mps_client.sqf");
	
	};
	
};	
