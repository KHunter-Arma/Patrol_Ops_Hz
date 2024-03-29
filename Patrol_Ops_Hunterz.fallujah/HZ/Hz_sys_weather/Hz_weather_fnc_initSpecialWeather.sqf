if (!isServer) then {
  waitUntil {!isnil "Hz_overrideweather"};
	if (time < 300) then {
		sleep 10;
	};
} else {
	waitUntil {!isnil "Hz_pers_serverInitialised"};
	sleep 0.1;
	waitUntil {Hz_pers_serverInitialised};	
};

switch (true) do {

  case (Hz_weather_Snow) : {

    //winter date for shorter days
    [2016,12,25,mps_mission_hour,30] call mps_timeset;
    
    if(isServer) then {
      
			// gentle snow -- not a snowstorm. TODO: snowstorm script that actually has good visual effects... (adapt from sandstorm?)
      weather_wind = [2,2,true];
      weather = 1;
      weather_rain = 0;
      weather_fog = 0.2;
      
      publicVariable "weather";
      publicVariable "weather_wind";
      publicVariable "weather_rain";
      publicVariable "weather_fog";
      
      0 setovercast weather;
      0 setFog weather_fog;
      setwind weather_wind;
      0 setrain weather_rain;      
      
      Hz_overrideweather = true;
      publicvariable "Hz_overrideweather";
    
    };

    if (isServer || (call Hz_fnc_isHC)) then {
    
      call Hz_weather_fnc_AI_VD_fog_adjuster;
			[0.4,0.4,0.5,0.5,true] call Hz_weather_handleAIWeatherSkills;
    
    };
    
    if (isDedicated) exitWith {};
		
		if (call Hz_fnc_isHC) exitWith {		
			[]spawn {      
				while {Hz_overrideweather} do {	
					0 setlightnings 0;
					call Hz_sys_weather_fnc_weatherSync;					
					sleep 30;					
				};    
			};	
		};
		
		snow_color = ppEffectCreate ["colorCorrections", 1501];
		snow_color ppEffectEnable true;
		snow_color ppEffectAdjust [0.8, 0.8, 0.0, [.3, .3, 1.0, .1], [.88, .88, .93, .45], [1 , 1, 1, 0.03]];//white 
		snow_color ppEffectCommit 0;

    []spawn {
		
			player setUnitTrait ["camouflageCoef",0.2];
			player setUnitTrait ["audibleCoef",0.3];
      
      0 setlightnings 0;
			call Hz_sys_weather_fnc_weatherSync;
			
			// Based on Goon's snowstorm script
        /* Goon/Gooncorp 2015  */
                 
			_obj = (vehicle player);
			_pos = (getPos _obj);
			_n =  vectorMagnitude wind;
			_velocity = wind;
			
			_snowflakes1 = "#particlesource" createVehicleLocal _pos; 
			_snowflakes1  attachto [player, [0,0,12]];
			_snowflakes1  setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 14, 2, 0], "", "Billboard", 1, 22, [0, 0, 6], _velocity, (0), 1.69, 1, 1, [1.5], [[1,1,1,0],[1,1,1,1],[1,1,1,1]],[1000], 0, 0, "", "", _obj];
			_snowflakes1  setParticleRandom [0, [24 + (random 2),24 + (random 2), 4], [0, 0, 0], 0, 0, [0, 0, 0, .03], 0, 0];
			_snowflakes1  setParticleCircle [0, [0, 0, 0]];
			_snowflakes1  setDropInterval 0.001; 


			_snowflakes2 = "#particlesource" createVehicleLocal _pos; 
			_snowflakes2  attachto [player, [0,0,12]];
			_snowflakes2  setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 12, 2, 0], "", "Billboard", 1, 14, [0, 0, 6], _velocity, (0), 1.39, 0, 0, [.2], [[1,1,1,0],[1,1,1,1],[1,1,1,1]],[1000], 0, 0, "", "", _obj];
			_snowflakes2  setParticleRandom [0, [14 + (random 2),14 + (random 2), 5], [0, 0, 0], 0, 0, [0, 0, 0, 2], 0, 0];
			_snowflakes2  setParticleCircle [0, [0, 0, 0]];
			_snowflakes2  setDropInterval 0.004; 


			_clouds1 = "#particlesource" createVehicleLocal _pos; 
			_clouds1  attachto [player, [0,0,12]];
			_clouds1  setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 12, 2, 0], "", "Billboard", 1,22, [0, 0, 16], _velocity, (_n * 4), 1.72, 1, 1, [22 + random 33], [[1,1,1,0],[1,1,1,1],[1,1,1,0]],[1000], 0, 0, "", "", _obj];
			_clouds1  setParticleRandom [3, [55 + (random 8),55 + (random 10), 55], [2, 2, 0], 0, 0, [0, 0, 0, 0], 0, 0];
			_clouds1  setParticleCircle [0, [0, 0, 0]];
			_clouds1  setDropInterval 0.05; 

			_clouds2 = "#particlesource" createVehicleLocal _pos; 
			_clouds2  attachto [player, [0,0,12]];
			_clouds2  setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 13, 6, 0], "", "Billboard", 1, 22, [0, 0, 36], _velocity, (0), 1.52, 1, 1, [5 + random 23], [[1,1,1,0],[1,1,1,.4],[1,1,1,0]],[1000], 0, 0, "", "", _obj];
			_clouds2  setParticleRandom [3, [24 + (random 8),24 + (random 10), 15], [2, 2, 0], 0, 0, [0, 0, 0, 0], 0, 0];
			_clouds2  setParticleCircle [0, [0, 0, 0]];
			_clouds2  setDropInterval 0.1; 
			
			waitUntil {
				
				0 setlightnings 0;
        call Hz_sys_weather_fnc_weatherSync;
			
				sleep 10;
				!Hz_overrideweather
			};
			
			deletevehicle _snowflakes1;
			deletevehicle _snowflakes2;
			deletevehicle _clouds1;
			deletevehicle _clouds2; 
    
    };
    
  };
  
  case (Hz_weather_sandstorm) : {
  
    [2016,07,25,mps_mission_hour,30] call mps_timeset;
		
    _waitForNight = true;
		_waitForMorning = false;
		
     if (hasInterface) then {
			
			sandstorm_color = ppEffectCreate ["ColorCorrections",1500]; 
			sandstorm_color ppEffectEnable true; 
			sandstorm_color ppEffectAdjust [0.875,0.875,-0.1,[1.652,0.764,0,0.12],[1,1,1,0.8],[0.835,0,0,0],[0,0,-0.265,-0.194,-0.017,0.279,0.624],1,0.001,0,0,1,1,1]; 
			sandstorm_color ppEffectForceInNVG false; 
			sandstorm_color ppEffectCommit 0;
			
			_time = daytime;
			if ((_time >= 19.27) || {_time < 4.84}) then {
			
				_waitForNight = false;
				_waitForMorning = true;
				sandstorm_color ppEffectAdjust [0.875,0.875,-0.1,[1.652,0.764,0,0.01],[1,1,1,0.8],[0.835,0,0,0],[0,0,-0.265,-0.194,-0.017,0.279,0.624],1,0.001,0,0,1,1,1]; 
				sandstorm_color ppEffectCommit 0;
			
			};

			sandstorm_grain = ppEffectCreate ["FilmGrain",2000]; 
			sandstorm_grain ppEffectEnable true; 
			sandstorm_grain ppEffectAdjust [0.05,2,2,0.1,12.5,10,true]; 
			sandstorm_grain ppEffectForceInNVG true; 
			sandstorm_grain ppEffectCommit 0;
			
      ["INIT",[false,"ALTERNATIVE_LOW",true,"DISABLE"]] call HA_fnc_sandStorm;      
    
    }; 
		
     if(isServer) then {
      
      weather_wind = [14,14,true];
      weather = 0;
      weather_rain = 0;
      weather_fog = 0.4;
      
      publicVariable "weather";
      publicVariable "weather_wind";
      publicVariable "weather_rain";
      publicVariable "weather_fog";
      
      0 setovercast weather;
      0 setFog weather_fog;
      setwind weather_wind;
      0 setrain weather_rain;      
      
      Hz_overrideweather = true;
      publicvariable "Hz_overrideweather";
    
    };

    if (isServer || (call Hz_fnc_isHC)) then {
    
      call Hz_weather_fnc_AI_VD_fog_adjuster; //call to set variables once
			Hz_max_desired_server_VD = 300; //override result because sand is OP
			Hz_min_desired_server_VD = 0;
			[0,0,0,0,true] call Hz_weather_handleAIWeatherSkills;
    
    };
    
    if (isDedicated) exitWith {};		
		if (call Hz_fnc_isHC) exitWith {		
			[]spawn {      
				while {Hz_overrideweather} do {					
					call Hz_sys_weather_fnc_weatherSync;					
					sleep 90;					
				};    
			};	
		};

    [_waitForNight, _waitForMorning] spawn {
		
			_waitForNight = _this select 0;
			_waitForMorning = _this select 1;
		
			player setUnitTrait ["camouflageCoef",0.05];
			player setUnitTrait ["audibleCoef",0.2];
      
      while {Hz_overrideweather} do {
			
				if (_waitForNight && {daytime >= 19.27}) then {
				
					_waitForNight = false;
					_waitForMorning = true;
					
					sandstorm_color ppEffectAdjust [0.875,0.875,-0.1,[1.652,0.764,0,0.01],[1,1,1,0.8],[0.835,0,0,0],[0,0,-0.265,-0.194,-0.017,0.279,0.624],1,0.001,0,0,1,1,1]; 
					sandstorm_color ppEffectCommit 600;
				
				} else {
				
					if (_waitForMorning && {daytime >= 4.84} && {daytime < 19}) then {
					
						_waitForNight = true;
						_waitForMorning = false;
						
						sandstorm_color ppEffectAdjust [0.875,0.875,-0.1,[1.652,0.764,0,0.12],[1,1,1,0.8],[0.835,0,0,0],[0,0,-0.265,-0.194,-0.017,0.279,0.624],1,0.001,0,0,1,1,1]; 
						sandstorm_color ppEffectCommit 600;
					
					};
				
				};
				
				_logicSound = "logic" createVehicleLocal (getpos player);
				_logicSound attachto [player,[0,0,25]];
				_logicSound say3D "Sandstorm";
        
        call Hz_sys_weather_fnc_weatherSync;
        
        sleep 174;
				
				deleteVehicle _logicSound;
        
      };
    
    };
  
  };

  default {
  
    //default summer day for longer days
    [2016,07,25,mps_mission_hour,30] call mps_timeset;  
    
    if(isServer) then {
    
      Hz_overrideweather = false;
      publicvariable "Hz_overrideweather";
      
    };

  };

};

//JIP nuke effects
if(!isServer && nukeweather && !(call Hz_fnc_isHC)) then {

  [] call compile preprocessfilelinenumbers "lk\nuke\nenvi.sqf";
  player spawn envi;
  ashhandle = player spawn ash;
  windv=true;
  player spawn windef;

};