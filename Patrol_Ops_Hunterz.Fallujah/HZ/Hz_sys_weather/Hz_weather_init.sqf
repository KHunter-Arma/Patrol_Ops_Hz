if(isnil "nukeweather") then {nukeweather = false;};
if(isnil "Hz_overrideweather") then {Hz_overrideweather = false;};
if(isnil "weather_change") then {weather_change = false;};
Hz_sys_weather_fnc_weatherSync = compile preprocessfilelinenumbers "Hz\Hz_sys_weather\Hz_sys_weather_fnc_weatherSync.sqf";
Hz_weather_fnc_AI_VD_fog_adjuster = compile preprocessfilelinenumbers "Hz\Hz_sys_weather\Hz_weather_fnc_AI_VD_fog_adjuster.sqf";

[] spawn {

  waituntil {sleep 1; !isnil "ace_wind_fnc_getWind"};
  waituntil {sleep 1; !isnil "ace_sys_wind_deflection_fnc_wind"};
  waituntil {sleep 1; !isnil "weather_wind"};
  
  sleep 1;
  
  //make use of alread existing ACE per-frame EH to output custom wind
  ace_wind_fnc_getWind = {[weather_wind select 0,weather_wind select 1, 0]};
  ace_sys_wind_deflection_fnc_wind = ace_wind_fnc_getWind;
  call compile preprocessFileLineNumbers "Hz\Hz_sys_weather\Hz_sys_weather_main.sqf";
  
};