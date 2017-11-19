// Written by EightySix

	121 cuttext ["Select Redeployment Point", "BLACK OUT"];

	mps_teleport_status = true;

	createDialog "mps_respawn_dialog";

waitUntil {!dialog};

	121 cuttext ["Redeploying...", "BLACK FADED"];
	sleep 3;
	121 cuttext ["", "BLACK IN"];

	mps_teleport_status = false;