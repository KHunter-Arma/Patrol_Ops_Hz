//warning! do not change the order of these or the delays
0 setovercast weather;

if (!isDedicated) then {

  0 setfog weather_fog;

} else {

  if (Hz_max_desired_server_VD >= 200) then {0 setfog 0;} else {
  
  0 setfog (weather_fog/3);

  };

};

0 setrain weather_rain;
uisleep 0.1;
setwind weather_wind;
forceweatherchange;
