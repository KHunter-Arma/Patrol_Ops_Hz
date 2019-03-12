_type = _this select 0;
_airportID = _this select 1;

_plane = ([[15000,-25000,10000], 0, _type, createGroup west] call BIS_fnc_spawnVehicle) select 0;

ambient_plane = _plane;

_grp = group _plane;

sleep 1;

_grp setCombatMode "WHITE";
_grp setBehaviour "CARELESS";
_plane disableAI "FSM";
_plane disableAI "AUTOCOMBAT";
_plane disableAI "TARGET";
_plane disableAI "AUTOTARGET";

clearItemCargoGlobal _plane;
clearWeaponCargoGlobal _plane;
clearMagazineCargoGlobal _plane;
clearBackpackCargoGlobal _plane;
_plane lockDriver true;
{

	_plane lockTurret [_x,true];

} foreach allTurrets [_plane, false];

_plane addEventHandler ["Engine", {

	params ["_plane", "_engineState"];

	if (!_engineState) then {
	
		_plane spawn {
		
			sleep (300 + (random 3600));
			
			_this doMove [15000, 25000,10000];
			_this flyInHeight 1000;
			
			waitUntil {
			
				sleep 10;
				
				if (alive _this) then {
				
					((getposatl _this) select 2) > 10
				
				} else {
				
					true
				
				}
			
			};
			
			if (!alive _this) exitWith {};
			
			sleep 300;
			
			{
			
				deletevehicle _x;
			
			} foreach crew _this;
			
			deleteVehicle _this;
		
		};
	
	} else {
	
		_plane forcespeed 10;
		
	};


}];

_plane addEventHandler ["LandedTouchDown", { 

	_this spawn {

		 params ["_plane", "_airportID"]; 

		_runwayDir = getdir _plane;

		waitUntil {
		
			sleep 2; 
			
			(speed _plane) < 10
			
		};

		_plane forceSpeed 10;

		waitUntil {
		
			sleep 5;	
			_plane forceSpeed 10;
			
			if (alive _plane) then {
			
				((180 - (abs ((abs ((getdir _plane) - _runwayDir)) - 180))) > 90)
			
			} else {
			
				true
			
			}	
			
		};
		
		if (!alive _plane) exitWith {};

		waitUntil {
		
			sleep 5;
			if (isEngineOn _plane) then {_plane forceSpeed 10};
			
			if (alive _plane) then {
			
				((180 - (abs ((abs ((getdir _plane) - _runwayDir)) - 180))) < 20)
			
			} else {
			
				true
			
			}	
			
		};

		sleep 0.5;
		_plane forceSpeed -1;

	};

}];

_plane flyInHeight 1000;
_plane landat _airportID;