private "_dist";

if (isnil "Hz_weather_original_max_server_VD") then {Hz_weather_original_max_server_VD = Hz_max_desired_server_VD;};
if (isnil "Hz_weather_original_min_server_VD") then {Hz_weather_original_min_server_VD = Hz_min_desired_server_VD;};
if (isnil "Hz_weather_original_AI_skill_spotDistance") then {Hz_weather_original_AI_skill_spotDistance = Hz_AI_skill_spotDistance;};
if (isnil "Hz_weather_original_AI_skill_spotTime") then {Hz_weather_original_AI_skill_spotTime = Hz_AI_skill_spotTime;};

//below 0.05 has no effect in render distance
if (weather_fog > 0.05) then {
    
  //  Hz_AI_skill_spotTime = Hz_weather_original_AI_skill_spotTime/2;    

		_dist = 2.539e9 - 4.263e9*(cos(weather_fog*0.3623)) - 1.452e8*(sin(weather_fog*0.3623)) + 
					 2.492e9*(cos(2*weather_fog*0.3623)) + 1.703e8*(sin(2*weather_fog*0.3623)) - 9.71e8*(cos(3*weather_fog*0.3623)) - 1e8*(sin(3*weather_fog*0.3623)) + 
					 2.277e8*(cos(4*weather_fog*0.3623)) + 3.15e7*(sin(4*weather_fog*0.3623)) - 2.442e7*(cos(5*weather_fog*0.3623)) - 4.261e6*(sin(5*weather_fog*0.3623));

		if (_dist < Hz_weather_original_max_server_VD) then {
    
        Hz_max_desired_server_VD = _dist;
     
     /*
        //less than 200 VD is not possible, so we instead reduce their spotting ability...
        if(_dist < 200) then {
        
            Hz_AI_skill_spotTime = ((4270075376612379*_dist)/576460752303423488 - 12037/25000)*Hz_AI_skill_spotTime;
            Hz_AI_skill_spotDistance = ((4270075376612379*_dist)/576460752303423488 - 12037/25000)*Hz_weather_original_AI_skill_spotDistance;
        
        };
      */  
            
    } else {
    
        Hz_max_desired_server_VD = Hz_weather_original_max_server_VD;
        Hz_AI_skill_spotDistance = Hz_weather_original_AI_skill_spotDistance;
        Hz_AI_skill_spotTime = Hz_weather_original_AI_skill_spotTime;
    };

} else {

    Hz_max_desired_server_VD = Hz_weather_original_max_server_VD;
    Hz_AI_skill_spotDistance = Hz_weather_original_AI_skill_spotDistance;
    Hz_AI_skill_spotTime = Hz_weather_original_AI_skill_spotTime;

};

if (Hz_max_desired_server_VD <= Hz_weather_original_min_server_VD) then {

    Hz_min_desired_server_VD = 0;

} else {
    
    Hz_min_desired_server_VD = Hz_weather_original_min_server_VD;
    
};


/*

{
    
    _x setskill ["spotDistance",Hz_AI_skill_spotDistance];     
    _x setskill ["spotTime",Hz_AI_skill_spotTime];     
            
}foreach allunits;

*/