private ["_obj","_exit"];

if (hz_fort_cost == -1) exitWith {hint "Item is not in stock!"};

if(!hz_debug) then {

	//Player check

	if ([] call Hz_func_isSupervisor) then {
		
		//Check funds
		if(Hz_econ_funds >= hz_fort_cost) then {
			
			Hz_econ_funds = Hz_econ_funds - hz_fort_cost;
			publicvariable "Hz_econ_funds";
			
			_obj = hz_fort_selected createVehicle (markerpos "hz_buyfortification");
			[_obj] call Hz_fnc_vehicleInit;

			if(hz_fort_selected iskindof "ReammoBox") then {
				
				clearweaponcargoglobal _obj;
				clearmagazinecargoglobal _obj;
				
				_obj call Hz_pers_API_addCrate;
				
			} else {
				
				_obj call Hz_pers_API_addObject;
				
			};
			
			hint "Your order has been delivered!";

		} else {

			hint "Insufficient funds!";

		};

	} else {

		hint "You are not authorised to make purchases!";

	};

} else {

	hint "DEBUG MODE: Object spawn succesful!";

	_obj = hz_fort_selected createVehicle (markerpos "hz_buyfortification");

};
