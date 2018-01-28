//warning! do not change the order of these or the delays (Arma 2)


if ((overcast < (weather*0.98)) || (overcast > (weather*1.02))) then {
	
		5 setovercast weather;
	
};	

if (!isServer) then {

  //0 setfog weather_fog;

} else {

/*

  if (Hz_max_desired_server_VD >= 200) then {0 setfog 0;} else {
  
  0 setfog (weather_fog/3);

  };
*/

	if ((fog < (weather_fog*0.98)) || (fog > (weather_fog*1.02))) then {
	
		5 setfog weather_fog;
	
	};
	
	if ((rain < (weather_rain*0.98)) || (rain > (weather_rain*1.02))) then {
	
		5 setrain weather_rain;
	
	};	
	
	uisleep 0.1;
	setwind weather_wind;
	//forceweatherchange;
	
};





