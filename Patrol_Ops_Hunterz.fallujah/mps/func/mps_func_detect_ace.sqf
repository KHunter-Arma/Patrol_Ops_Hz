// Written by EightySix


if(!isServer) exitWith{};

	mps_ace_enabled = isClass(configFile/"CfgPatches"/"ace_main"); publicVariable "mps_ace_enabled";

	if(isNil "mps_ace_wounds") then {mps_ace_wounds = false}; publicVariable "mps_ace_wounds";

if(true) exitWith {};
