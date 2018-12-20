if (!isnil "Hz_weather_original_AIskillAccuracy") then {

	Hz_AI_param_skillSpotDistance = Hz_weather_original_AIskillSpotDistance;
	Hz_AI_param_skillSpotTime = Hz_weather_original_AIskillSpotTime;
	Hz_AI_param_skillAimingAccuracy = Hz_weather_original_AIskillAccuracy;
	
	{

		if (local _x) then {
		
			_x setSkill ["spotTime", Hz_AI_param_skillSpotTime];
			_x setSkill ["spotDistance", Hz_AI_param_skillSpotDistance];
			_x setSkill ["aimingAccuracy", Hz_AI_param_skillAimingAccuracy];
		
		};
		
	} foreach allunits;

};

if ((!isnil "Hz_AI_TPWLOS_PFHandle") && {Hz_AI_TPWLOS_PFHandle == -999}) then {

	Hz_AI_TPWLOS_PFHandle = [tpwlos_fnc_mainloop,0.5] call cba_fnc_addperframehandler;

};

