//EH now only used during weather change. Static sync is done locally and continuously by loop

//Confirmed from tests (Arma 2) that more than 1 weather component can't transition smoothly. The last one will override the ones that came before, and once finished the rest will kick in immediately without transition phase
//So we have to do it sequentially

[] spawn {

setwind weather_wind;
sleep 1;
forceWeatherChange;
sleep 1;

300 setovercast weather;

uisleep 310;
forceWeatherChange;
60 setrain weather_rain;
uisleep 70;
forceWeatherChange;
300 setfog weather_fog;
uisleep 310;
forceWeatherChange;

};

