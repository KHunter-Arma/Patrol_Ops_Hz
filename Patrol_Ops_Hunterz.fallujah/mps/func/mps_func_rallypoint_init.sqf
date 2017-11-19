// Written by Eightysix

if(isServer) then {

	if(isNil "mps_rallies") then { mps_rallies = []; publicVariable "mps_rallies"; };

};

if(!isDedicated) then {

player addAction ["Build Tent","mps\action\mps_buildtent.sqf",nil,0];

};