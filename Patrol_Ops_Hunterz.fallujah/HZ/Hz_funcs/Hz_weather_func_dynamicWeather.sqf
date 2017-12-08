#define MAX_WIND_SPEED 14

private ["_sign","_sign1","_sign2","_windx","_windy"];

if(!Hz_overrideweather) then {  

  weather_change = true;
  publicvariable "weather_change";
  
  if (!nukeweather) then {
    
    if((random 1) < Hz_weather_change_chance) then {
      
      
      if ((random 1) < 0.5) then {
        
        //freaky random weather
        
        _sign = 1;
        if ((random 1) < 0.5) then {_sign = -1;};                   
        weather = weather + ((0.2 + (random 0.8))*_sign); 

        _sign = 1;
        if ((random 1) < 0.5) then {_sign = -1;};                   
        weather_rain = weather_rain + ((0.2 + (random 0.8))*_sign); 

        _sign = 1;
        if ((random 1) < 0.5) then {_sign = -1;};                   
        weather_fog = weather_fog + ((0.2 + (random 0.8))*_sign); 
        
        _sign1 = 1;
        if ((random 1) < 0.5) then {_sign1 = -1;};       
        _sign2 = 1;
        if ((random 1) < 0.5) then {_sign2 = -1;}; 
		_windx = (weather_wind select 0) + (_sign1*(0.2 + (random 0.8))*MAX_WIND_SPEED);
		_windy = (weather_wind select 1) + (_sign2*(0.2 + (random 0.8))*MAX_WIND_SPEED);
        weather_wind = [_windx,_windy,true];               
        
      } else {
        
        //return to average
        
        _sign = 1;
        if ((random 1) < 0.5) then {_sign = -1;};                  
        weather = Hz_weather_avg_overcast + ((random 0.1)*_sign);

        _sign = 1;
        if ((random 1) < 0.5) then {_sign = -1;};                  
        weather_rain = Hz_weather_avg_rain + ((random 0.1)*_sign);

        _sign = 1;
        if ((random 1) < 0.5) then {_sign = -1;};                  
        weather_fog = Hz_weather_avg_fog + ((random 0.1)*_sign);
        
        _sign1 = 1;
        if ((random 1) < 0.5) then {_sign1 = -1;};       
        _sign2 = 1;
        if ((random 1) < 0.5) then {_sign2 = -1;}; 
        weather_wind = [(MAX_WIND_SPEED*Hz_weather_avg_wind*_sign1*(1 - (random 0.1))),(MAX_WIND_SPEED*Hz_weather_avg_wind*_sign2*(1 - (random 0.1))),true]; 
        
      };

      
    } else {
      
      _sign = 1;
      if ((random 1) < 0.5) then {_sign = -1;};                  
      weather = weather + ((random 0.1)*_sign);

      _sign = 1;
      if ((random 1) < 0.5) then {_sign = -1;};                  
      weather_rain = weather_rain + ((random 0.1)*_sign);

      _sign = 1;
      if ((random 1) < 0.5) then {_sign = -1;};                  
      weather_fog = weather_fog + ((random 0.1)*_sign);
      
      _sign1 = 1;
      if ((random 1) < 0.5) then {_sign1 = -1;};       
      _sign2 = 1;
      if ((random 1) < 0.5) then {_sign2 = -1;}; 
      weather_wind = [((weather_wind select 0)*_sign1*(1 - (random 0.1))),((weather_wind select 1)*_sign2*(1 - (random 0.1))),true]; 
      
    };
    
    
  } else {
    
    _sign = 1;
      if ((random 1) < 0.5) then {_sign = -1;};                  
      weather = weather + ((random 1)*_sign);

      weather_rain = 1;
      
      _sign = 1;
      if ((random 1) < 0.5) then {_sign = -1;};                  
      weather_fog = weather_fog + ((random 0.5)*_sign);
      
      if(weather_fog < 0.2) then {weather_fog = 0.2};
    
    weather_wind = [-MAX_WIND_SPEED,-MAX_WIND_SPEED,true];
    
  };
  
  _windx = weather_wind select 0;
  _windy = weather_wind select 1;
  
  if(_windx > MAX_WIND_SPEED) then {_windx = MAX_WIND_SPEED;};
  if(_windy > MAX_WIND_SPEED) then {_windy = MAX_WIND_SPEED;};
  if(_windx < -MAX_WIND_SPEED) then {_windx = -MAX_WIND_SPEED;};
  if(_windy < -MAX_WIND_SPEED) then {_windy = -MAX_WIND_SPEED;};
  
  weather_wind = [_windx, _windy, true]; 
  
  if (weather_fog > 1) then {weather_fog = 1;};
  if (weather_fog < 0) then {weather_fog = 0;};
  if (weather_rain > 1) then {weather_rain = 1;};
  if (weather_rain < 0) then {weather_rain = 0;};
  if (weather > 1) then {weather = 1;};
  if (weather < 0) then {weather = 0;};
  
  //heavy rain creates fog-like effect which causes AI to see further than players
  //only allow heavy rain when heavy fog exists for now
  if (weather_fog < 0.8) then {
  
    if (weather_rain > 0.5) then {weather_rain = 0.5;};
  
  };
  
  sleep 10;
  publicvariable "weather_fog";
  publicvariable "weather_wind";
  publicvariable "weather_rain";
  sleep 5;
  publicvariable "weather";
  
	[] spawn {
    
    sleep 150;
    call Hz_weather_fnc_AI_VD_fog_adjuster;
    
    sleep 530;
    weather_change = false;
    publicvariable "weather_change";
    
  };
	
  call Hz_weather_syncClient;
  
}; 