_timeout = time + 30;
waitUntil {sleep 1; (!isnil "Hz_AI_param_skillSpotDistance") || (time > _timeout)};
waitUntil {(!isnil "Hz_AI_param_skillSpotTime") || (time > _timeout)};
waitUntil {(!isnil "Hz_AI_param_skillAimingAccuracy") || (time > _timeout)};

if (time > _timeout) then {

	Hz_AI_param_skillSpotDistance = 1;
	Hz_AI_param_skillSpotTime = 1;
	Hz_AI_param_skillAimingAccuracy = 0.6;

};

if (isnil "Hz_weather_original_AIskillSpotDistance") then {Hz_weather_original_AIskillSpotDistance = Hz_AI_param_skillSpotDistance;};
if (isnil "Hz_weather_original_AIskillSpotTime") then {Hz_weather_original_AIskillSpotTime = Hz_AI_param_skillSpotTime;};
if (isnil "Hz_weather_original_AIskillAccuracy") then {Hz_weather_original_AIskillAccuracy = Hz_AI_param_skillAimingAccuracy;};

Hz_AI_param_skillSpotDistance = _this select 0;
Hz_AI_param_skillSpotTime = _this select 1;
Hz_AI_param_skillAimingAccuracy = _this select 2;

sleep 10;

{

	if (local _x) then {
	
		_x setSkill ["spotTime", Hz_AI_param_skillSpotTime];
		_x setSkill ["spotDistance", Hz_AI_param_skillSpotDistance];
		_x setSkill ["aimingAccuracy", Hz_AI_param_skillAimingAccuracy]; 
	
	};
	
} foreach allunits;

if (_this select 3) then {

	_timeout = time + 120;
	waitUntil {sleep 1; (!isnil "Hz_AI_TPWLOS_PFHandle") || (time > _timeout)};
	if (!isnil "Hz_AI_TPWLOS_PFHandle") then {

		sleep 10;
		[Hz_AI_TPWLOS_PFHandle] call cba_fnc_removeperframehandler;
		Hz_AI_TPWLOS_PFHandle = -999;

	};

};