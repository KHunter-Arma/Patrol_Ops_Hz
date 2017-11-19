waituntil {sleep 1; !isnil "weather"};
waituntil {sleep 1; !isnil "weather_wind"};
waituntil {sleep 1; !isnil "weather_fog"};
waituntil {sleep 1; !isnil "weather_rain"};

if(weather_change) then {
    
    waituntil {sleep 1; !isnull player};
    uisleep 30;

    150 setovercast weather;
    
    [] spawn {
        
    uisleep 160;
    forceWeatherChange;
     
    30 setrain weather_rain;
    uisleep 40;
    forceWeatherChange;
    150 setfog weather_fog;
    uisleep 160;
    forceWeatherChange;
    
    };
    
    setwind weather_wind;
    
    uisleep 350;
    forceWeatherChange;
    
};

//precise weather sync (now handled locally except for weather change)
//high fog values can cause very sudden changes, so the loop must run very fast (Arma 2)
while {!Hz_overrideweather} do {

    sleep 1;
    if(weather_change) then {
        
      waituntil {sleep 5; !weather_change};
    
    };
    
    call Hz_sys_weather_fnc_weatherSync;
        
};