   private "_return";
	 
	 _return = [];
		
		{//man vehicles & static guns

    if (_x iskindof "LandVehicle") then {
		
			if ((_x emptyPositions "gunner") > 0) then {

				_dude = (creategroup (SIDE_B select 0)) createUnit ["TK_Soldier_EP1", getpos _x, [], 50, "NONE"];
				_dude assignasgunner _x;
				_dude moveingunner _x;
				_dude call Hz_func_AI_SetSkill;  
				_x setvehiclelock "locked";
				
				_return set [count _return, _dude];
				
			};

			if ((_x emptyPositions "commander") > 0) then {

				_dude = (creategroup (SIDE_B select 0)) createUnit ["TK_Soldier_EP1", getpos _x, [], 50, "NONE"];
				_dude assignascommander _x;
				_dude moveincommander _x;
				_dude call Hz_func_AI_SetSkill;  
				_x setvehiclelock "locked";
				
				_return set [count _return, _dude];
				
			};			
			
    };

    }foreach _this;
		
		_return