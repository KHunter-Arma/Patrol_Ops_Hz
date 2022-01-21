_timeout = time + 30;
waitUntil {sleep 1; (!isnil "Hz_AI_param_skillSpotDistance") || (time > _timeout)};
waitUntil {(!isnil "Hz_AI_param_skillSpotTime") || (time > _timeout)};
waitUntil {(!isnil "Hz_AI_param_skillAimingAccuracy") || (time > _timeout)};
waitUntil {(!isnil "Hz_AI_param_skillAimingShake") || (time > _timeout)};

if (time > _timeout) then {

	Hz_AI_param_skillSpotDistance = 1;
	Hz_AI_param_skillSpotTime = 1;
	Hz_AI_param_skillAimingAccuracy = 0.025;
	Hz_AI_param_skillAimingShake = 0.05;

};

if (isnil "Hz_weather_original_AIskillSpotDistance") then {Hz_weather_original_AIskillSpotDistance = Hz_AI_param_skillSpotDistance;};
if (isnil "Hz_weather_original_AIskillSpotTime") then {Hz_weather_original_AIskillSpotTime = Hz_AI_param_skillSpotTime;};
if (isnil "Hz_weather_original_AIskillAccuracy") then {Hz_weather_original_AIskillAccuracy = Hz_AI_param_skillAimingAccuracy;};
if (isnil "Hz_weather_original_AIskillShake") then {Hz_weather_original_AIskillShake = Hz_AI_param_skillAimingShake;};

Hz_AI_param_skillSpotDistance = Hz_AI_param_skillSpotDistance*(_this select 0);
Hz_AI_param_skillSpotTime = Hz_AI_param_skillSpotTime*(_this select 1);
Hz_AI_param_skillAimingAccuracy = Hz_AI_param_skillAimingAccuracy*(_this select 2);
Hz_AI_param_skillAimingShake = Hz_AI_param_skillAimingShake*(_this select 3);

// TODO: need parameters for hostile civilian skill level to scale those too...

sleep 10;

{

	if (local _x) then {
	
		_x setSkill ["spotDistance", (_x skill "spotDistance")*(_this select 0)];
		_x setSkill ["spotTime", (_x skill "spotTime")*(_this select 1)];
		_x setSkill ["aimingAccuracy", (_x skill "aimingAccuracy")*(_this select 2)];
		_x setSkill ["aimingShake", (_x skill "aimingShake")*(_this select 3)];
	
	};
	
} foreach allunits;

if (_this select 4) then {

	_timeout = time + 120;
	waitUntil {sleep 1; (!isnil "Hz_AI_TPWLOS_PFHandle") || (time > _timeout)};
	if (!isnil "Hz_AI_TPWLOS_PFHandle") then {

		sleep 10;
		[Hz_AI_TPWLOS_PFHandle] call cba_fnc_removeperframehandler;
		Hz_AI_TPWLOS_PFHandle = -999;

	};

};