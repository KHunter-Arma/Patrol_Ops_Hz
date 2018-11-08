private "_dist";

if (isnil "Hz_weather_original_max_server_VD") then {Hz_weather_original_max_server_VD = Hz_max_desired_server_VD;};
if (isnil "Hz_weather_original_min_server_VD") then {Hz_weather_original_min_server_VD = Hz_min_desired_server_VD;};

//below 0.05 has no effect in render distance
if (weather_fog > 0.05) then {
  
  //switch to other formula above this value
  if (weather_fog < 0.7) then {
    
    _dist = (1765564809185467*cos deg ((8*pi*weather_fog)/7))/33554432 - (576350079198247*cos deg ((4*pi*weather_fog)/7))/524288 + (1889183716827921*cos deg ((12*pi*weather_fog)/7))/8388608 - (2789724412483215*cos deg ((16*pi*weather_fog)/7))/33554432 + (123546630309875*cos deg ((20*pi*weather_fog)/7))/16777216 - (8689947551699389*sin deg ((4*pi*weather_fog)/7))/8388608 + (931086277017623*sin deg ((8*pi*weather_fog)/7))/1048576 - (2256461218808255*sin deg ((12*pi*weather_fog)/7))/8388608 + (2623381394293107*sin deg ((16*pi*weather_fog)/7))/268435456 + (2946375736382771*sin deg ((20*pi*weather_fog)/7))/536870912 + 3763453892296507/4194304;
    
    if (_dist < Hz_weather_original_max_server_VD) then {
      
      Hz_max_desired_server_VD = _dist;
      
    } else {
      
      Hz_max_desired_server_VD = Hz_weather_original_max_server_VD;
    };
		
		call Hz_weather_fnc_revertAISkills;

  } else {

    //around 0.8 render distance drops below minimum hard limit of 200
    if (weather_fog <= 0.8) then {

      _dist = -850*weather_fog + 859.2;

      Hz_max_desired_server_VD = _dist;
			
			call Hz_weather_fnc_revertAISkills;

    } else {

      Hz_max_desired_server_VD = 100;
			[0,0,0.1,true] call Hz_weather_handleAIWeatherSkills;

    };

  };    
  
  
} else {

  Hz_max_desired_server_VD = Hz_weather_original_max_server_VD;
	
	call Hz_weather_fnc_revertAISkills;

};

if (Hz_max_desired_server_VD <= Hz_weather_original_min_server_VD) then {

  Hz_min_desired_server_VD = 0;

} else {
  
  Hz_min_desired_server_VD = Hz_weather_original_min_server_VD;
  
};
