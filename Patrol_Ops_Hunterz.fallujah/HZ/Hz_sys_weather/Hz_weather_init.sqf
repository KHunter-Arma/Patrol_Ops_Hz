waitUntil {!isnil "mps_timeset"};

if(isnil "nukeweather") then {nukeweather = false;};
if(isnil "Hz_overrideweather") then {Hz_overrideweather = false;};
if(isnil "weather_change") then {weather_change = false;};

Hz_sys_weather_fnc_weatherSync = compile preprocessfilelinenumbers "Hz\Hz_sys_weather\Hz_sys_weather_fnc_weatherSync.sqf";
Hz_weather_fnc_AI_VD_fog_adjuster = compile preprocessfilelinenumbers "Hz\Hz_sys_weather\Hz_weather_fnc_AI_VD_fog_adjuster.sqf";
Hz_weather_syncClient = compile preprocessfilelinenumbers "Hz\Hz_sys_weather\Hz_weather_syncClient.sqf";
Hz_weather_fnc_initSpecialWeather = compile preprocessfilelinenumbers "Hz\Hz_sys_weather\Hz_weather_fnc_initSpecialWeather.sqf";
Hz_weather_handleAIWeatherSkills = compile preprocessfilelinenumbers "Hz\Hz_sys_weather\Hz_weather_handleAIWeatherSkills.sqf";
Hz_weather_fnc_revertAISkills = compile preprocessfilelinenumbers "Hz\Hz_sys_weather\Hz_weather_fnc_revertAISkills.sqf";

if (isServer) then {

  Hz_weather_func_dynamicWeather = compile preprocessfilelinenumbers "HZ\Hz_sys_weather\Hz_weather_func_dynamicWeather.sqf";

  weather_fog = Hz_weather_avg_fog;
  weather_rain = Hz_weather_avg_rain;
  weather = Hz_weather_avg_overcast;
  _sign1 = 1;
  if ((random 1) < 0.5) then {_sign1 = -1;};       
  _sign2 = 1;
  if ((random 1) < 0.5) then {_sign2 = -1;}; 
  weather_wind = [(14*Hz_weather_avg_wind*_sign1*(1 - (random 0.1))),(14*Hz_weather_avg_wind*_sign2*(1 - (random 0.1))),true]; 

};

if (!isDedicated) then {

  waitUntil {!isNull player};
  
};

call Hz_weather_fnc_initSpecialWeather;

if (Hz_overrideweather) exitWith {};

if (!isDedicated) then {

  "weather" addPublicVariableEventHandler {call Hz_weather_syncClient;};

};

if (isServer) then {  
  
  call Hz_weather_func_dynamicWeather;

};

[] spawn {

	scriptname "Hz_pops_weather";
  waituntil {sleep 1; !isnil "weather_wind"};
  call compile preprocessFileLineNumbers "Hz\Hz_sys_weather\Hz_sys_weather_main.sqf";
  
};