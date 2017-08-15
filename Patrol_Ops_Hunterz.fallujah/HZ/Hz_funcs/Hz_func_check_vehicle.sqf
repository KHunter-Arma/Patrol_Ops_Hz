

private ["_veh","_type"];

_veh = vehicle player;
_type = toupper (typeof _veh);

{

	if (_type iskindof _x) then {
			
	 if((player == (gunner _veh)) || (player == (commander _veh)) || (player == (driver _veh))) then {
	 
	 hint "You are not trained to use this vehicle!";
	 moveout player;
	 sleep 0.1;
	 player moveincargo _veh;
			 
	 };               
									
	};

} foreach Hz_econ_restrictedVehicles;