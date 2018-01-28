_this addaction ["<t color=""#42ebf4"">" + "Order spare tyre ($250)",{

	if (Hz_econ_funds < 250) exitwith{

		hint "Insufficient funds!"

	};

	_tyre = "ACE_Wheel" createvehicle [0,0,0];

	_tyre setpos (markerpos "spareTyreDelivery"); 

	Hz_econ_funds = Hz_econ_funds - 250;
	publicvariable "Hz_econ_funds";

	_tyre call hz_pers_api_addobject;

	hint "Spare tyre delivered";

}];

_this addaction ["<t color=""#42ebf4"">" + "Order jerry can ($30)",{

	if (Hz_econ_funds < 30) exitwith{

		hint "Insufficient funds!"

	};

	_tyre = "Land_CanisterFuel_F" createvehicle [0,0,0];

	_tyre setpos (markerpos "spareTyreDelivery"); 

	Hz_econ_funds = Hz_econ_funds - 30;
	publicvariable "Hz_econ_funds";

	_tyre call hz_pers_api_addobject;

	hint "Jerry can delivered";

}];