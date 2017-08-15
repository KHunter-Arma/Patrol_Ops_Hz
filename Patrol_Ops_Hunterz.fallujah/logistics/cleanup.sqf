private ["_countNull", "_myGroupX", "_townguys", "_veh", "_weather", "_rand", "_timescaler1", "_timescaler2", "_timescaler3", "_last", "_samepos", "_gunsarr", "_temp", "_flameEffects"];

//initial cleanup to get rid of all dead patrols in the beginning
/*
        sleep 3600;
        
        {deleteVehicle _x;
        }foreach AllDead;
*/

/*


//isNull cleanup
[]spawn {

    while {true} do {
        
     sleep 604800;
    
    _countNull = 0;
{
    if (isNull _x) then
    {
        _countNull = _countNull + 1;
        _myGroupX = group _x;
        _x removeAllMPEventHandlers "mpkilled";
        _x removeAllMPEventHandlers "mphit";
        _x removeAllMPEventHandlers "mprespawn";
        _x removeAllEventHandlers "FiredNear";
        _x removeAllEventHandlers "HandleDamage";
        _x removeAllEventHandlers "Killed";
        _x removeAllEventHandlers "Fired";
        _x removeAllEventHandlers "Local";
        _x removeAllEventHandlers "Hit";
        clearVehicleInit _x;
        deleteVehicle _x;
        deleteGroup _myGroupX;
        _x = nil;
    };
sleep 1;} forEach allMissionObjects "";
    };
};


*/




                        /*[] spawn {

                               while {true} do {
                        uisleep 500;
                        {_x enablesimulation false;} foreach alldead;
                        publicvariable "disablesimdead";
                        {deletegroup _x;} foreach allgroups;



                        /*
                        _townguys = [];
                        {if(isplayer _x && ((_x distance (markerpos "ao_centre")) < 3000)) then {_townguys = _townguys + [_x];};} foreach playableunits;

                        if (count _townguys < 1) then {

                               {if(side _x == civilian) then {
                                   if(vehicle _x != _x) then {
                                       _veh = vehicle _x;
                                       moveout _x;
                                       _veh setdamage 1;
                                       deletevehicle _x;
                                       deletevehicle _veh;

                                       } else{
                                           _x setdamage 1; 
                                           deletevehicle _x;
                                           };
                                    };
                                 }foreach allunits;

                           };
                           


                        };

                        };*/



/*
//Respawn town static guns
[] spawn { 
        while {true} do {
           uisleep 259400;
           if(!staticactive)then {call spawnAIGuns;}; };       
        };
   */     
        
  /*      
//randomise weather
[]spawn {
    nukeweather = false;
    while {true} do {
    
        _weather = 0;
        _rand = _weather + random 1;
        
        if (!nukeweather) then {    if(_rand < 0.8) then {_weather = _weather + random 0.1;}else {if(_rand < 0.95)then{_weather = _weather + 0.2 + random 0.3;}else{_weather = _weather + 0.7 + random 0.3;};};     } else {
            
            if(_rand < 0.2) then {_weather = _weather + random 0.1;}else {if(_rand < 0.8)then{_weather = _weather + 0.7 + random 0.3;}else{_weather = 1;};};     };
      
        weather = _weather;
        publicvariable "weather";
        600 setovercast weather;
        
            uisleep 3750;
            
            {if((_x iskindof "StaticWeapon" || _x iskindof "Air") && (side _x == east)) then {_x setvehicleammo 1;};}foreach vehicles;
            {if(!isnull _x) then {if((count crew _x) < 0) then {tempbikes = tempbikes - [_x]; deletevehicle _x; };};}foreach tempbikes;
            publicvariable "tempbikes";
            
};
};
*/

weather_fog = Hz_weather_avg_fog;
weather_rain = Hz_weather_avg_rain;
weather = Hz_weather_avg_overcast;
 _sign1 = 1;
if ((random 1) < 0.5) then {_sign1 = -1;};       
_sign2 = 1;
if ((random 1) < 0.5) then {_sign2 = -1;}; 
weather_wind = [(14*Hz_weather_avg_wind*_sign1*(1 - (random 0.1))),(14*Hz_weather_avg_wind*_sign2*(1 - (random 0.1))),true]; 
call Hz_weather_func_dynamicWeather;

//Server DVD
[] spawn {
    
if(!isDedicated) exitwith {};        
    
while {true} do {
    
uisleep 5;

if(diag_fps < Hz_min_desired_server_FPS) then {if(viewdistance > (Hz_min_desired_server_VD + 200)) then {setviewdistance (viewdistance - 200);}else {setviewdistance Hz_min_desired_server_VD;};} else {
if(diag_fps > Hz_max_desired_server_FPS) then {if(viewdistance < (Hz_max_desired_server_VD - 200)) then {setviewdistance (viewdistance + 200);}else {setviewdistance Hz_max_desired_server_VD;};};};

};
  
}; 


_timescaler1 = 0;
_timescaler2 = 0;
_timescaler3 = 0;
if(isnil "Hz_func_AI_isUncon") then {Hz_func_AI_isUncon = {false};};

while {true} do
	{
        
        //3.8 minute loop    
	uisleep 233;
        _timescaler1 = _timescaler1 + 1;
        _timescaler2 = _timescaler2 + 1;
        _timescaler3 = _timescaler3 + 1;
        
        //track unconscious units and kill them if they're lying at the same place for more than 10 minutes
        {
            if((local _x) && (_x call Hz_func_AI_isUncon) && (alive _x)) then {
            
                if((count (_x getvariable ["Hz_AI_unconTracker",[]])) < 1) then {_x setvariable ["Hz_AI_unconTracker",[time,getpos _x]];};
                    
                _last = _x getvariable "Hz_AI_unconTracker";
                
                _samepos = (format (_last select 1)) == (format (getpos _x));
                
                if(_samepos) then {
                    
                   if(((time - (_last select 0)) > 600)) then {
                   
                    _x setdamage 1;
                   
                   };
                   
                } else {
                    
                 _x setvariable ["Hz_AI_unconTracker",[time,getpos _x]];   
                            
                };                           
            
            };
            
        }foreach allunits;
        
        if((count alldead) > Hz_max_deadunits) then {

            //dead body cleanup    
            {
                if(_x iskindof "CAManBase") then {if(!(_x getvariable ["NoDelete",false]) && ((_x distance (markerpos "respawn_west")) > 300)) then {deleteVehicle _x;};};

            }foreach AllDead;

        };
        
        //reset position of dudes with no weapons at base (they tend to drift over time for some reason)
        {_x setposatl (_x getvariable "pos");}foreach position_correction;
        
        //reset flag so garrison script can keep working
        {_x setvariable ["occupied",false];}foreach Hz_resetBuildingVars;
        
     //   waituntil {sleep 300; {isPlayer _x}count playableunits < 1 };
       
        // Reset ALICE
     /*   {if(_x iskindof "Civilian") then {_x enablesimulation true; sleep 0.1; (vehicle _x) setdamage 1;}}foreach allunits;
        sleep 5;
        deletevehicle alice;
        alice = "Alice2Manager" createvehicle [0,0,0];
        alice setVehicleInit "call compile preprocessFileLineNumbers ""mip\init-alice2.sqf"";";
        processInitCommands;
      */
        
       
        //_gunsarr = nearestObjects[CENTERPOS, eastStationaryGuns, AORADIUS];
        _gunsarr = gunsarr;
        {if ((!alive gunner _x) || (count crew _x == 0)) then {_gunsarr = _gunsarr - [_x]; deletevehicle _x; gCount = gCount - 1; }; sleep 0.1;}foreach gunsarr;
        gunsarr = _gunsarr;
        //for remote debugging
        publicvariable "gCount"; 
        
            
       // SAM setVehicleAmmo 1;
        
       
       //50 minute loop
       if(_timescaler1 > 12) then {
           _timescaler1 = 0;
           
           _temp = +tempbikes;
            {if(!isnull _x) then {if((count (crew _x)) < 1) then {_temp = _temp - [_x]; deletevehicle _x; };};}foreach tempbikes;
            tempbikes = +_temp;
            publicvariable "tempbikes";
           {deletegroup _x;}foreach allgroups;
           
           };
       
       
       //3 hour loop
       if(_timescaler3 > 45) then {
           
         //dead vehicle cleanup
       {
            if ((_x iskindof "LandVehicle") || (_x iskindof "Air") || (_x iskindof "Boat")) then {if(!(_x getvariable ["NoDelete",false])) then {
                								
										// does not work reliably										
										_flameEffects = _x getvariable ["ace_burnObj",[]];
                    {deletevehicle _x} foreach _flameEffects;
										//alternative -- does not get rid of sound!!!!!!!!!!
										{
											deletevehicle _x;
										}foreach nearestobjects [_x,["ace_flameout_1"],30];
										//*sigh* delete sound source....
										{
											deletevehicle _x;
										}foreach nearestobjects [_x,[],2];
										deleteVehicle _x;	
                };};
                
        }foreach AllDead;      
                   
       
       _timescaler3 = 0;

       call Hz_weather_func_dynamicWeather;
       call Hz_func_setrealtime;
        
       };
       
       //6 hour loop
       if(_timescaler2 > 90) then {
           
           _timescaler2 = 0; 
           
           if(!staticactive)then {call spawnAIGuns;}; 
           
           };
        
        
        
      /*  for cleaning up player groups once they leave the server. probably not needed...
      
        {deleteGroup _x; sleep 1;} forEach groupsarray;
        publicvariable "groupsarray";
        
        */
    }; 