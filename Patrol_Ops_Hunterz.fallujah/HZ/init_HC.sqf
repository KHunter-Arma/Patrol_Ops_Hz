waitUntil {!isNull player};

if ((name player) == HC_patrolsName) then {

	waitUntil {!isnil "Hz_pops_UPSPassToHCArray"};

	//copy array in case HC loses connection
	Hz_pops_UPSRespawnArray = +Hz_pops_UPSPassToHCArray;

	Hz_max_ambient_units = Hz_max_ambient_units + 80;
	sleep 300;
	Hz_max_ambient_units = Hz_max_ambient_units - 80;

};

while {true} do {

	diag_log format ["### Hz_diag: %1, %2",diag_fps,viewDistance, count diag_activeSQFScripts];

	uisleep 5;

	if(diag_fps < Hz_min_desired_server_FPS) then {if(viewdistance > (Hz_min_desired_server_VD + 200)) then {setviewdistance (viewdistance - 200);}else {setviewdistance Hz_min_desired_server_VD;};} else {
	if(diag_fps > Hz_max_desired_server_FPS) then {if(viewdistance < (Hz_max_desired_server_VD - 200)) then {setviewdistance (viewdistance + 200);}else {setviewdistance Hz_max_desired_server_VD;};};};

};
