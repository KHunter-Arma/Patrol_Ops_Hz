private _exit = false;

while {!_exit} do {

	waitUntil {alive player};
	
	sleep 2;
	
	if (((getposatl player) distance Hz_pops_arrestPosition) > 5) then {
	
		if !((getPlayerUID player) in BanList) exitWith {
		
			_exit = true;
		
		};
	
		//endmission "Escaped";
		
		player setposatl Hz_pops_arrestPosition;
	
	};

};	

//we don't want dem inmate uniforms being used...
removeUniform player;
