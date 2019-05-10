_this addaction ["<t color=""#42ebf4"">" + "Order spare tyre ($250)",{

	if (Hz_econ_funds < 250) exitwith {

		hint "Insufficient funds!"

	};

	_tyre = "ACE_Wheel" createvehicle [0,0,50000];

	_tyre setposatl [(markerpos "spareTyreDelivery") select 0, (markerpos "spareTyreDelivery") select 1, 2]; 		
	_tyre spawn {
	
		_nearTyres = nearestobjects [_this, ["ACE_Wheel"],4];
	
		{
		
			_x allowDamage false;
			_x setDamage 0;
			
		} foreach _nearTyres;
		
		uisleep 3;
		
		{
			
			_x setDamage 0;
			_x allowDamage true;
			
		} foreach _nearTyres;
	
	};	

	Hz_econ_funds = Hz_econ_funds - 250;
	publicvariable "Hz_econ_funds";

	_tyre call hz_pers_api_addobject;

	hint "Spare tyre delivered";

},[],-5];

_this addaction ["<t color=""#42ebf4"">" + "Order jerry can ($30)",{

	if (Hz_econ_funds < 30) exitwith{

		hint "Insufficient funds!"

	};

	_tyre = "Land_CanisterFuel_F" createvehicle [0,0,50000];

	_tyre setposatl [(markerpos "spareTyreDelivery") select 0, ((markerpos "spareTyreDelivery") select 1) - 1, 0.3]; 
	
	_tyre allowDamage false;
	_tyre spawn {
	
		sleep 1;
		_this setDamage 0;
		_this allowDamage true;
	
	};	

	Hz_econ_funds = Hz_econ_funds - 30;
	publicvariable "Hz_econ_funds";

	_tyre call hz_pers_api_addobject;

	hint "Jerry can delivered";

},[],-6];