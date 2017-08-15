//EH now only used during weather change. Static sync is done locally and continuously by loop

//Confirmed from tests that more than 1 weather component can't transition smoothly. The last one will override the ones that came before, and once finished the rest will kick in immediately without transition phase
//So we have to do it sequentially

if(isServer) exitwith {};

setwind weather_wind;
ACE_wind = [weather_wind select 0,weather_wind select 1, 0];
300 setovercast weather;

[] spawn {

sleep 310;
60 setrain weather_rain;
sleep 70;
300 setfog weather_fog;

};

