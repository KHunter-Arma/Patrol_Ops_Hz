dismount = {
        
        private ["_vehicle","_passengerarr","_driver","_timeout","_targetPos"];
        _vehicle = _this select 0;
        _passengerarr = _this select 1;
        _driver = _this select 2;
        
        if (((count _passengerarr) > 0) && (alive _vehicle)) then {
             
            _vehicle forcespeed 0;
            if ((isnull (gunner _vehicle)) && ((_vehicle emptyPositions "gunner") == 0)) then {
                
								 unassignvehicle _driver; 
								dogetout _driver;
                [_driver] allowgetin false;
               
               
            };
            
						{ unassignVehicle _x; } forEach _passengerarr;
						dogetout _passengerarr;
            _passengerarr allowgetin false;       
            
            {_timeout = time + 5; waituntil {sleep 1; (((vehicle _x) == _x) || (!(alive _x)) || (!(canmove _vehicle)) || (time > _timeout))};} foreach _passengerarr;
                    
            _vehicle domove (getpos _vehicle);
            _vehicle forceSpeed -1;
            sleep 1;
            {_x forcespeed -1;}foreach _passengerarr;
        };
        
    };
    
    mount = {
        
        private ["_vehicle","_passengerarr","_driver","_timeout","_targetPos"];           
        
        _vehicle = _this select 0;
        _passengerarr = _this select 1;
        _driver = _this select 2;   
        
        if (((count _passengerarr) > 0) && (alive _vehicle)) then {                      
            
            if(!canmove _vehicle) exitwith {};  
            
						if ((vehicle _driver) == _vehicle) then {
						
							dostop _vehicle;
							_vehicle forcespeed 0;
						
						};            
            
            if ((isnull (gunner _vehicle)) && ((_vehicle emptyPositions "gunner") == 0)) then {
                
                if(!alive _driver) then {_driver = _passengerarr select 0; _passengerarr = _passengerarr - [_driver];};

                [_driver] allowgetin true;
                _driver assignasdriver _vehicle;   
                
            };
             
             _passengerarr allowgetin true;
            {_x assignascargo _vehicle;} foreach _passengerarr;
            
            {_timeout = time + 20; waituntil {sleep 1; (((vehicle _x) == _vehicle) || (!(alive _x)) || (!(canmove _vehicle)) || (time > _timeout))};} foreach _passengerarr;
						
						if ((vehicle _driver) == _driver) then {
						
							_driver forcespeed -1;
						
						};      
            
            sleep 1;
            _vehicle forcespeed -1;
            
        };
        
    };