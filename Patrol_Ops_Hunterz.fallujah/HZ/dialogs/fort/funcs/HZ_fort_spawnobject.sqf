private ["_obj","_exit"];

if(!hz_debug) then {

	//Player check

	if ([] call Hz_func_isSupervisor) then {

	if (!((toUpper hz_fort_selected) in Hz_restricted_vehs)) then {
	
		//Check funds
		if(Hz_funds >= hz_fort_cost) then {
			
			Hz_funds = Hz_funds - hz_fort_cost;
			publicvariable "Hz_funds";
			
			_obj = hz_fort_selected createVehicle (markerpos "hz_buyfortification");
			
			/*
		if(typeof _obj == "WarfareBDepot") then {
		
		[0, {_this addEventHandler ["HandleDamage", {_obj = _this select 0; _health = getdammage _obj; _newhealth = _this select 2; _damage = _newhealth - _health; _damage = _damage * 20; _return = _health + _damage; _return}];
		}, _obj] call CBA_fnc_globalExecute;
			
		};
		*/
			if(hz_fort_selected == "FlagCarrierIONwhite_PMC") then {_obj setFlagTexture "media\flag3.jpg";}; 
			
			if((hz_fort_selected == "ACE_USVehicleBox_EP1") || (hz_fort_selected == "ACE_BandageBoxWest")) then {
				clearweaponcargoglobal _obj;
				clearmagazinecargoglobal _obj;
				
				if(hz_fort_selected == "ACE_USVehicleBox_EP1") then {
					
					_obj setvehicleinit "this addaction [""<t color=""""#00CC00"""">"" +""Transfer all items to crate"",""HZ\Hz_funcs\Hz_func_remove_gear.sqf"",nil,-10]; this addaction [""<t color=""""#ffc100"""">"" +""Rearrange Radios"",""HZ\Hz_funcs\Hz_func_rearrangeACRERadios.sqf"",nil,-11];";
					processinitcommands; 
					emptybox_array set [count emptybox_array, _obj];
					publicvariable "emptybox_array";

				};

				if(hz_fort_selected == "ACE_BandageBoxWest") then {
					
					_obj setvehicleinit "this addaction [""<t color=""""#FF0000"""">"" +""Transfer medical items to crate"",""HZ\Hz_funcs\Hz_func_remove_medical_gear.sqf"",nil,-10];";
					processinitcommands;      
					
					medbox_array set [count medbox_array, _obj];
					publicvariable "medbox_array";
					
				};
				
			} else {
				/*
		switch (true) do {
				
				case (count hz_fort_array < 71) : {hz_fort_array = hz_fort_array + [_obj]; publicvariable "hz_fort_array"; };
				case (count hz_fort_array2 < 71) : {hz_fort_array2 = hz_fort_array2 + [_obj]; publicvariable "hz_fort_array2"; };
				case (count hz_fort_array3 < 71) : {hz_fort_array3 = hz_fort_array3 + [_obj]; publicvariable "hz_fort_array3"; };
				case (count hz_fort_array4 < 71) : {hz_fort_array4 = hz_fort_array4 + [_obj]; publicvariable "hz_fort_array4";};
				case (count hz_fort_array5 < 71) : {hz_fort_array5 = hz_fort_array5 + [_obj]; publicvariable "hz_fort_array5";};
				default {hint "Hunter'z Fortification Store Error: Unable to save item!";};
				
				};    
		*/
				
				if(!isnil "hz_veh_array" && _obj iskindof "StaticWeapon") then {
					
					hz_veh_array = hz_veh_array + [_obj];
					publicvariable "hz_veh_array";         
					_obj setvehicleammo 0;
					
				} else {
					
					hz_fort_array = hz_fort_array + [_obj];
					publicvariable "hz_fort_array"; 
					
				};
				
			};
			
			hint "Your order has been delivered!";

		} else {

			hint "Insufficient funds!";

		};
		
		} else {
		
		hint "You are not authorised to buy this asset!";
		
		};

	} else {

		hint "You are not authorised to make purchases on this server!";

	};

} else {

	hint "DEBUG MODE: Object spawn succesful!";

	_obj = hz_fort_selected createVehicle (markerpos "hz_buyfortification");
	
	hz_fort_array = hz_fort_array + [_obj];
	publicvariable "hz_fort_array";
	
	if(hz_fort_selected == "FlagCarrierIONwhite_PMC") then {_obj setFlagTexture "media\flag3.jpg";}; 
	

};
