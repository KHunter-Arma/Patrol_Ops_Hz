// Written by EightySix

/*

private["_object","_x","_y","_camera"];

	_object = _this select 0;

	camUseNVG false;

	_x = _object select 0;
	_y = _object select 1;

	_camera = "camera" camCreate [_x + random 15,_y + random 15,1];
	_camera camSetTarget _object;
	_camera camSetFOV 0.700;
	_camera camCommit 0;

	WaitUntil{camCommitted _camera};

	_camera cameraEffect ["internal","back"];
	showcinemaborder false;

	_camera camSetPos [_x,_y,8];
	_camera camSetTarget _object;
	_camera camSetFOV 0.900;

	_camera camCommit 10;

	WaitUntil{camCommitted _camera};

	while {!mps_respawned_player} do {sleep 1;};
	
	player cameraEffect ["terminate","back"];

	camDestroy _camera;

*/