if (!isServer) then {

  //0 setfog weather_fog;

} else {

	_force = false;

/*
  if (Hz_max_desired_server_VD >= 200) then {0 setfog 0;} else {
  
  0 setfog (weather_fog/3);

  };
*/

	if ((overcast < (weather*0.98)) || (overcast > (weather*1.02))) then {
	
		5 setovercast weather;
		_force = true;
	
	};

	if ((fog < (weather_fog*0.98)) || (fog > (weather_fog*1.02))) then {
	
		5 setfog weather_fog;
		_force = true;
	
	};
	
	if ((rain < (weather_rain*0.98)) || (rain > (weather_rain*1.02))) then {
	
		5 setrain weather_rain;
		_force = true;
	
	};	
	
	uisleep 0.1;
	setwind weather_wind;
	
	if (_force) then {forceweatherchange};
	//forceweatherchange;
	
};





