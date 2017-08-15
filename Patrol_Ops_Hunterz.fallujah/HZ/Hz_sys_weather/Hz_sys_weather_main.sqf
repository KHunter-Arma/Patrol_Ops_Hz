waituntil {sleep 1; !isnil "weather"};
waituntil {sleep 1; !isnil "weather_wind"};
waituntil {sleep 1; !isnil "weather_fog"};
waituntil {sleep 1; !isnil "weather_rain"};

if(weather_change) then {
    
    waituntil {sleep 1; !isnull player};
    sleep 30;

    150 setovercast weather;
    
    [] spawn {
        
     sleep 160;
     
    30 setrain weather_rain;
    sleep 40;    
    150 setfog weather_fog;
    
    };
    
    setwind weather_wind;
    ACE_wind = [weather_wind select 0,weather_wind select 1, 0];
    
    sleep 350;
    
    
};

//precise weather sync (now handled locally except for weather change)
//high fog values can cause very sudden changes, so the loop must run very fast
while {!Hz_overrideweather} do {

    //uisleep 1;
    if(weather_change) then {
        
        waituntil {sleep 5; !weather_change};
    
    };
    
    call Hz_sys_weather_fnc_weatherSync;
        
};