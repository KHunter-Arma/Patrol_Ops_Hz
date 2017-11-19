// Written by R3F logistics
// Adapted by EightySix

if (mps_lock_action) then {
	player globalChat "The current operation isn't finished.";
}else{
	mps_lock_action = true;
	mps_loading_in_progress = true;
	mps_selected_object = _this select 0;

	_checkloaded = mps_selected_object getVariable "mps_container_stored";
	if (isNil "_checkloaded") then {
		mps_selected_object setVariable ["mps_container_stored", objNull, false];
	};

	hint format ["Select a container to load the %1 into...", getText (configFile >> "CfgVehicles" >> (typeOf mps_selected_object) >> "displayName")];
	mps_lock_action = false;
};