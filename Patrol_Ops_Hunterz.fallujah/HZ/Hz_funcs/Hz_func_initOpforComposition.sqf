private ["_objects", "_ins", "_side", "_mannedVehicles", "_sentryType", "_return", "_grp", "_isTank", "_unitType", "_dude", "_unit","_pos"];
	
	_objects = _this select 0;
	_ins = false;
	_side = SIDE_B select 0;
	_mannedVehicles = [];
	_sentryType = "Microphone1_ep1";
	if ((count _this) > 1) then {_ins = _this select 1;};
	if ((count _this) > 2) then {_mannedVehicles = _this select 2;};
	if ((count _this) > 3) then {_sentryType = _this select 3;};
	
	
	if (_ins) then {
		
		_side = SIDE_C select 0;
		
	};
	
	_return = [];

	//restrict manned vehicles?
	if ((count _mannedVehicles) > 0) then { 
		
		{//man vehicles & static guns

			if (!(_x isKindOf "StaticWeapon")) then {_x setvehiclelock "locked";};
			
			if ((_x iskindof "LandVehicle") && (_foreachIndex in _mannedVehicles)) then {
				
				_grp = createGroup _side;      
				_isTank = false;
				if (!(_x isKindOf "Car") && !(_x isKindOf "StaticWeapon")) then {
					_isTank = true;
				} else {
					if (_x isKindOf "Wheeled_APC") then {_isTank = true;};      
				};
				
				if ((_x emptyPositions "gunner") > 0) then {
					
					_unitType = "";
					if (_ins) then {
						_unitType = mps_opfor_ins_riflemen call mps_getrandomelement;
					} else {        
						if (_isTank) then {
							_unitType = mps_opfor_crewmen call mps_getrandomelement;
						} else {
							_unitType = mps_opfor_riflemen call mps_getrandomelement;
						};        
					};
					
					_dude = _grp createUnit [_unitType, getpos _x, [], 200, "NONE"];
					_dude assignasgunner _x;
					_dude moveingunner _x;
					
					_grp deleteGroupWhenEmpty true;
					
					_return set [count _return, _dude];
					
				};

				if ((_x emptyPositions "commander") > 0) then {
					
					_unitType = "";
					if (_ins) then {
						_unitType = mps_opfor_ins_riflemen call mps_getrandomelement;
					} else {        
						if (_isTank) then {
							_unitType = mps_opfor_crewmen call mps_getrandomelement;
						} else {
							_unitType = mps_opfor_riflemen call mps_getrandomelement;
						};        
					};

					_dude = _grp createUnit [_unitType, getpos _x, [], 200, "NONE"];
					_dude assignascommander _x;
					_dude moveincommander _x;
					
					_return set [count _return, _dude];
					
				};			
				
			};

		}foreach _objects;
		
	} else {
		
		{//man vehicles & static guns

			if (_x iskindof "LandVehicle") then {
				
				_grp = createGroup _side;      
				_isTank = false;
				if (!(_x isKindOf "Car") && !(_x isKindOf "StaticWeapon")) then {
					_isTank = true;
				} else {
					if (_x isKindOf "Wheeled_APC") then {_isTank = true;};      
				};
				
				if ((_x emptyPositions "gunner") > 0) then {
					
					_unitType = "";
					if (_ins) then {
						_unitType = mps_opfor_ins_riflemen call mps_getrandomelement;
					} else {        
						if (_isTank) then {
							_unitType = mps_opfor_crewmen call mps_getrandomelement;
						} else {
							_unitType = mps_opfor_riflemen call mps_getrandomelement;
						};        
					};
					
					_dude = _grp createUnit [_unitType, getpos _x, [], 200, "NONE"];
					_dude assignasgunner _x;
					_dude moveingunner _x;
					
					_grp deleteGroupWhenEmpty true;
					
					_return set [count _return, _dude];
					
				};

				if ((_x emptyPositions "commander") > 0) then {
					
					_unitType = "";
					if (_ins) then {
						_unitType = mps_opfor_ins_riflemen call mps_getrandomelement;
					} else {        
						if (_isTank) then {
							_unitType = mps_opfor_crewmen call mps_getrandomelement;
						} else {
							_unitType = mps_opfor_riflemen call mps_getrandomelement;
						};        
					};

					_dude = _grp createUnit [_unitType, getpos _x, [], 200, "NONE"];
					_dude assignascommander _x;
					_dude moveincommander _x;
					
					_return set [count _return, _dude];
					
				};			
				
				if (!(_x isKindOf "StaticWeapon")) then {_x setvehiclelock "locked";};
				
			};

		}foreach _objects;
		
	};
	
	
	{//place any sentries
		
		_grp = createGroup _side;      

		if (_x iskindof _sentryType) then {
			
			_unitType = "";
			_pos = getposatl _x;
			deleteVehicle _x;
			
			if (_ins) then {
				
				_unitType = mps_opfor_ins_riflemen call mps_getrandomelement;
				
			} else {
				
				_unitType = mps_opfor_riflemen call mps_getrandomelement;
				
			};
			
			_unit = _grp createUnit [_unitType, _pos, [], 200, "NONE"];
			_unit forceSpeed 0;
			_unit setvariable ["Hz_noMove",true];
			_unit setposatl _pos;
			
			_grp deleteGroupWhenEmpty true;
			
			_return set [count _return, _unit];
			
		};

	}foreach _objects;
	
	_return