_vehicle = _this select 0;
_caller = _this select 1;
_actionarray = _this select 3;
_action = _actionarray select 0;
_carrier = _this select 0;
_loadpos = _carrier ModelToWorld [0,-13,-5.5];
_cargo = _carrier getVariable "cargo";
_act1 = _carrier getVariable "act1";
_carried = objNull;

if (((typeOf vehicle player) == "C130J_US_EP1") && (player != (driver vehicle player))) exitwith {};

if (_action == "load") then {
	if (_cargo == "") then {
		_near = nearestObjects [_loadpos, ["Land","Ship"], 8];
		_obj = _near select 0;
                
                if((count crew (vehicle _obj)) > 0) then {_carried = vehicle _obj;} else {_carried = _obj;};
                
                _bound = boundingBox _obj;
		
		_width = (_bound select 1 select 0) - (_bound select 0 select 0);
		_length = (_bound select 1 select 1) - (_bound select 0 select 1);
		_height = (_bound select 1 select 2) - (_bound select 0 select 2);
		
		if (count _near > 0) then {
			player sidechat format ["x:%1 y:%2 z:%3",_width,_length,_height];
			if ((_width <= 10.0) && (_length <= 22) && (_height <= 12)) then {
				//_carrier setVariable ["cargo",_obj];
				_carrier removeAction _act1;
                                
                                
                                
				_carrier animate ["ramp_top", 1];
				_carrier animate ["ramp_bottom", 1];
                              
                               _carrier setVariable ["cargo",_carried,true];
                               carried = true;
                               
                               _carried lock true;
                               
                               hint "Lowering ramp...";
                               
				sleep 3;
                                
                                hint format ["Loading %1 into cargo now...",typeOf _obj];
                                _lower = true;
                                _heightcorrection = 0;
                                _widthcorrection = 0;
                                _lengthcorrection = -2;
                if (_carried iskindof "M1A1") then {if (typeof _carried == "M1A2_US_TUSK_MG_EP1")exitwith{_heightcorrection = 0.3; _lengthcorrection = -2.2;};_lengthcorrection = -2.5;_heightcorrection = -1.4; _widthcorrection = 0.35;};
                if (_carried iskindof "M2A2_Base") then {_lengthcorrection = -1;_heightcorrection = 0.1;};
                if (_carried iskindof "ACE_StrykerBase") then {_lengthcorrection = 0;_heightcorrection = -2.5;};
                if (_carried iskindof "StrykerBase_EP1") then {_lengthcorrection = -3;_heightcorrection = -0.2;};
                if (_carried iskindof "HMMWV_Base") then {_lengthcorrection=-2;_heightcorrection = 0.3; if (_carried iskindof "HMMWV_Avenger") then {_heightcorrection = 0.6;};if (_carried iskindof "HMMWV_M998A2_SOV_DES_EP1") then {_heightcorrection = -0.2;};};
                if (_carried iskindof "MTVR") then {_heightcorrection = -0.2;};
                if (_carried iskindof "BAF_Jackal2_BASE_D") then {_heightcorrection = -0.5;_lengthcorrection=-3;};
                if (_carried iskindof "LandRover_Base") then {_heightcorrection = -0.5;};
                if (_carried iskindof "BAF_FV510_D") then {_heightcorrection = 0.3;_lengthcorrection = -1.1;};
                if (_carried iskindof "SUV_PMC") then {_heightcorrection = -0.5;};
                
                
                
                                
                                for "_i" from -52 to 8 do {

                                if (_lower) then {_carried attachTo [_carrier,[0+_widthcorrection,_i/4,-3.5 +_heightcorrection]];} else {_carried attachTo [_carrier,[0+_widthcorrection,_i/4,-2.5+_heightcorrection]];};

                                sleep 0.08;
                                if (_i > -40 && _i < -30) then {_carried setvectorup[0,-0.1,1];};
                                if (_i > -30 && _i < -20) then {_carried setvectorup[0,-0.2,1];  _lower = false;};
                                if (_i > -20 && _i < -10) then {_carried setvectorup[0,-0.1,1];};
                                if (_i > -10 && _i < 0) then {_carried setvectorup[0,0,1];};
                                };
                                
                                _carried attachTo [_carrier,[0 + _widthcorrection,2+_lengthcorrection,-2.5+_heightcorrection]];
                                hint "Cargo loaded.";
				//_carried setVariable ["evh",_id];
				//_carried setVariable ["carrier",_carrier];
				sleep 2;
				_carrier animate ["ramp_top", 0];
				_carrier animate ["ramp_bottom", 0];
				sleep 1;
                                
				_id = _carrier addaction ["<t color='#0000FF'>Unload</t>", "logistics\cargoscript.sqf", ["drop"],0,true,true,"","driver  _target == _this"];
				_carrier setVariable ["act1",_id,true];
                                
                                [_carrier, _carried]spawn {
                                    
                                  //private ["_carrier","_carried"];
                                   
                                  _carrier = _this select 0;
                                  _carried = _this select 1;
                                  _istank = false;
                                  if (_carried iskindof "Tank") then {_istank = true;};
                                  _initdamage = getdammage _carrier;
                                           
                                   hint "Cargo loaded.";
                                  _ehk = _carrier addMPeventhandler ["MPkilled", {_this execvm "logistics\destroyaircargo.sqf";}];
                                  damagedc130 = false;
                                   _ehh = _carrier addMPeventhandler ["MPhit", {damagedc130 = true;}];
                                   
                                   // damage handler
                                   while {carried} do {
                                       
                                     // _ehf = _carried addeventhandler ["fired",{_carried setdammage (getdammage _carried + 0.1); _carrier setdammage (getdammage _carrier + 0.1);}];     
                                       
                                       if (damagedc130) then {
                                           
                                               if (istank) then {_carried setdamage (((getdammage _carrier) - _initdamage) / 4);} else {_carried setdamage ((getdammage _carrier) - _initdamage);};
                                       
                                       {_x setdamage (getdammage _carried);}foreach crew _carried;
                                       };
                                       
                                       sleep 0.1;
                                       
                                       if(!alive _carrier) exitwith {_carried setdamage 1;};
                                           
                                           };
                                           
                                     _carrier removeMPeventhandler ["MPkilled", _ehk];
                                     _carrier removeMPeventhandler ["MPhit", _ehh];
                                     //_carried removeeventhandler ["fired", _ehf];
                                                
                                };
                                
                                
			} else {
				player sideChat "This won't fit in the cargospace";
                                hint "This won't fit in the cargospace";
			};
		} else {
			player sideChat "Nothing in range";
                        hint "Nothing in range";
		};
	} else {
		player sideChat "Cargo is already full";
                hint "Cargo is already full";
                _carrier removeaction _act1;
                _id = _carrier addaction ["<t color='#0000FF'>Unload</t>", "logistics\cargoscript.sqf", ["drop"],0,true,true,"","driver  _target == _this"];
		_carrier setVariable ["act1",_id,true];
               // if((count crew _cargo) != 0) then {{_x moveinCargo _carrier;} forEach crew _cargo;};
	};
        
};

if (_action == "drop") then {
    
	_carrier removeAction _act1;
	//_id = _cargo getVariable "evh";
	//_cargo removeEventHandler ["GetOut", _id];
        hint "Lowering ramp...";
        _carrier animate ["ramp_top", 1];
	_carrier animate ["ramp_bottom", 1];
	sleep 3;
        
        
	if ((getpos _carrier select 2) > 20) then {
               hint "Cargo is releasing now, hold it steady!";
                 /* BELOW CODE DOES NOT WORK IN MP IF CARGO OR CARRIER HAVE OTHER PLAYERS IN IT. YOU WILL SUFFER FROM A BAD "ACCIDENT"!
                   
                _droppos = _carrier ModelToWorld [0,-20,-12];
                detach _cargo;
                _cargo setpos _droppos;
                sleep 0.1;
                */
                _lower = false;
                _heightcorrection = 0;
                _widthcorrection = 0;
                _lengthcorrection = -2;
                if (_carried iskindof "M1A1") then {if (typeof _carried == "M1A2_US_TUSK_MG_EP1")exitwith{_heightcorrection = 0.3; _lengthcorrection = -2.2;};_lengthcorrection = -2.5;_heightcorrection = -1.4; _widthcorrection = 0.35;};
                if (_carried iskindof "M2A2_Base") then {_lengthcorrection = -1;_heightcorrection = 0.1;};
                if (_carried iskindof "ACE_StrykerBase") then {_lengthcorrection = 0;_heightcorrection = -2.5;};
                if (_carried iskindof "StrykerBase_EP1") then {_lengthcorrection = -3;_heightcorrection = -0.2;};
                if (_carried iskindof "HMMWV_Base") then {_lengthcorrection=-2;_heightcorrection = 0.3; if (_carried iskindof "HMMWV_Avenger") then {_heightcorrection = 0.6;};if (_carried iskindof "HMMWV_M998A2_SOV_DES_EP1") then {_heightcorrection = -0.2;};};
                if (_carried iskindof "MTVR") then {_heightcorrection = -0.2;};
                if (_carried iskindof "BAF_Jackal2_BASE_D") then {_heightcorrection = -0.5;_lengthcorrection=-3;};
                if (_carried iskindof "LandRover_Base") then {_heightcorrection = -0.5;};
                if (_carried iskindof "BAF_FV510_D") then {_heightcorrection = 0.3;_lengthcorrection = -1.1;};
                if (_carried iskindof "SUV_PMC") then {_heightcorrection = -0.5;};
                
                for "_i" from -4 to 24 do {
                    
                if (_lower) then {_cargo attachTo [_carrier,[0+_widthcorrection,-_i/2,-3.5+_heightcorrection]];} else {_cargo attachTo [_carrier,[0+_widthcorrection,-_i/4,-2.5+_heightcorrection]];};
                
                sleep 0.08;
                if (_i > 10 && _i < 20) then {_cargo setvectorup[0,-0.1,1];};
                if (_i > 20 && _i < 30) then {_cargo setvectorup[0,-0.2,1];  _lower = true;};
                if (_i > 30 && _i < 40) then {_cargo setvectorup[0,-0.1,1];};
                if (_i > 40 && _i < 50) then {_cargo setvectorup[0,0,1];};
                };
                _cargo attachTo [_carrier,[0+_widthcorrection,-13+_lengthcorrection,-8+_heightcorrection]];
                sleep 0.3;
                detach _cargo;
                carried = false;
                hint "Cargo is out!";
                
                c130cargo = _cargo;
                publicvariable "c130cargo";
                
                _cargo setVelocity (velocity _carrier);
                //_cargo setDir (getDir _carrier);
                
		waituntil {((getposatl _cargo) select 2) < 750};
                
               _carrier animate ["ramp_top", 0];
	       _carrier animate ["ramp_bottom", 0];
                
               _chute = "ParachuteBigWest" createVehicle [(getpos _cargo select 0),(getpos _cargo select 1),(getpos _cargo select 2) + 10];
		//_chute setpos (_cargo ModelToWorld [0,0,3]);
                //_chute setVelocity ((velocity _cargo));
		_chute attachTo [_cargo,[0,0,3]];
                sleep 0.5;
                _cargo setvectorup [0,0,1];
                sleep 0.5;
                _cargo setvectorup [0,1,1];
                 sleep 0.5;
                _cargo setvectorup [0,2,1];
                 sleep 0.5;
                _cargo setvectorup [0,1,1];
                 sleep 0.5;
                _cargo setvectorup [0,-1,1];
                 sleep 0.5;
                _cargo setvectorup [0,0,1];
                
                _verticalsp = -70;
                
                _cargo setvelocity [((velocity _cargo) select 0)-10,((velocity _cargo) select 1)-10,_verticalsp+10];
                
                while {((getpos _cargo) select 2) > 20} do {
                    
               _cargo setvelocity [((velocity _cargo) select 0),((velocity _cargo) select 1),_verticalsp];
               if (_verticalsp < -4) then {_verticalsp = _verticalsp + 2;} else {_verticalsp = -4;};
                sleep 0.3;
                hintsilent format ["Cargo Vertical Speed: %1 m/s\nCargo Altitude: %2 m", velocity _cargo select 2,getpos _cargo select 2];
                };
                
                //_cargo setvelocity [((velocity _cargo) select 0),((velocity _cargo) select 1),-4];
               waituntil {_cargo setvelocity [0,0,-4]; ((getpos _cargo) select 2) < 5};
               if(alive _cargo)then {hint "Cargo has landed!"; } else {hint "Cargo was destroyed!";};
               
                sleep 2;
                detach _chute;
                _chute setdamage 1;
                _landpos = getpos _cargo;
                _cargo lock false;
                "SmokeShellOrange" createVehicle _landpos;
                "F_40mm_yellow"    createVehicle [(_landpos select 0),(_landpos select 1),(_landpos select 2) + 400 ];
                "F_40mm_blue"    createVehicle [(_landpos select 0),(_landpos select 1),(_landpos select 2) + 400 ];
                sleep 70;
                "SmokeShellBlue" createVehicle _landpos;
                "F_40mm_yellow"    createVehicle [(_landpos select 0),(_landpos select 1),(_landpos select 2) + 400 ];
                "F_40mm_blue"    createVehicle [(_landpos select 0),(_landpos select 1),(_landpos select 2) + 400 ];
	} else {
            
                // Commented out code below replaced with alternative method. Detaching cargo first is not safe for MP.
                
		//detach _cargo;
		//_cargo setpos _loadpos;
               
           //     _cargo attachTo [_carrier,[0,-13,-3.5]]; // this position is safe to release a large vehicle on the ground. More margin probably needed for airdrop.
            //    sleep 1;
            //    detach _cargo;
                
                hint "Cargo is being released...";
                
                _lower = false;
                 _heightcorrection = 0;
                _widthcorrection = 0;
                _lengthcorrection = -2;
                if (_carried iskindof "M1A1") then {if (typeof _carried == "M1A2_US_TUSK_MG_EP1")exitwith{_heightcorrection = 0.3; _lengthcorrection = -2.2;};_lengthcorrection = -2.5;_heightcorrection = -1.4; _widthcorrection = 0.35;};
                if (_carried iskindof "M2A2_Base") then {_lengthcorrection = -1;_heightcorrection = 0.1;};
                if (_carried iskindof "ACE_StrykerBase") then {_lengthcorrection = 0;_heightcorrection = -2.5;};
                if (_carried iskindof "StrykerBase_EP1") then {_lengthcorrection = -3;_heightcorrection = -0.2;};
                if (_carried iskindof "HMMWV_Base") then {_lengthcorrection=-2;_heightcorrection = 0.3; if (_carried iskindof "HMMWV_Avenger") then {_heightcorrection = 0.6;};if (_carried iskindof "HMMWV_M998A2_SOV_DES_EP1") then {_heightcorrection = -0.2;};};
                if (_carried iskindof "MTVR") then {_heightcorrection = -0.2;};
                if (_carried iskindof "BAF_Jackal2_BASE_D") then {_heightcorrection = -0.5;_lengthcorrection=-3;};
                if (_carried iskindof "LandRover_Base") then {_heightcorrection = -0.5;};
                if (_carried iskindof "BAF_FV510_D") then {_heightcorrection = 0.3;_lengthcorrection = -1.1;};
                if (_carried iskindof "SUV_PMC") then {_heightcorrection = -0.5;};
                
                
                for "_i" from -8 to 48 do {
                    
                if (_lower) then {_cargo attachTo [_carrier,[0+_widthcorrection,-_i/4,-3.5+_heightcorrection]];} else {_cargo attachTo [_carrier,[0+_widthcorrection,-_i/4,-2.5+_heightcorrection]];};
                
                sleep 0.08;
                if (_i > 10 && _i < 20) then {_cargo setvectorup[0,-0.1,1];};
                if (_i > 20 && _i < 30) then {_cargo setvectorup[0,-0.2,1];  _lower = true;};
                if (_i > 30 && _i < 40) then {_cargo setvectorup[0,-0.1,1];};
                if (_i > 40 && _i < 50) then {_cargo setvectorup[0,0,1];};
                };
                _cargo attachTo [_carrier,[0+_widthcorrection,-13+_lengthcorrection,-3.5+_heightcorrection]];
                sleep 1;
                detach _cargo;
                _cargo setVelocity (velocity _carrier);
                carried = false;
                 hint "Cargo released.";
                _cargo lock false;
		_carrier animate ["ramp_top", 0];
		_carrier animate ["ramp_bottom", 0];
	};
        
	_carrier setVariable ["cargo","",true];
	_id = _carrier addaction ["<t color='#0000FF'>Load cargo</t>", "logistics\cargoscript.sqf", ["load"],0,true,true,"","driver  _target == _this"];
	_carrier setVariable ["act1",_id,true];

};