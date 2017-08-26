

private ["_veh","_type"];

_veh = vehicle player;
_type = toupper (typeof _veh);

{

	if (_type iskindof _x) then {
		
		if ((player == (driver _veh)) && ((speed _veh) < 3) && (((getposatl _veh) select 2) < 3)) then {
			
			hint "You are not trained to use this vehicle!";
			moveout player;
			sleep 0.01;
			player moveincargo _veh;
			
		} else {
			
			if((player == (gunner _veh)) || (player == (commander _veh))) then {
				
				hint "You are not trained to use this vehicle!";
				moveout player;
				sleep 0.01;
				player moveincargo _veh;
				
			};        
			
		};
		
	};

} foreach Hz_restricted_vehs;