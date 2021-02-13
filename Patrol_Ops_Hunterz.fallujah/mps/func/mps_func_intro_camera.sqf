// Written by EightySix

if(isDedicated || (call Hz_fnc_isHC)) exitWith{};
private ["_time", "_object", "_pos1", "_pos2", "_xpos1", "_ypos1", "_zpos1", "_xpos2", "_ypos2", "_zpos2", "_camera", "_head", "_line", "_nul0"];

// Get Date from Server
	setDate date;

// Set View Distance
setterraingrid 50;
setviewdistance 8000;  

// Timescale
	_time = _this select 0;

// Set Camera Object
	_object = Player;

// Set Camera Path
	_pos1 = [position player,120,1200,true,2] call mps_new_position;
	_pos2 = [position player,0,1,true,2] call mps_new_position;

// Set Camera Start position
	_xpos1 = _pos1 select 0;
	_ypos1 = _pos1 select 1;
	_zpos1 = (_pos1 select 2) + 1500;

// Set Camera End Position
	_xpos2 = _pos2 select 0;
	_ypos2 = _pos2 select 1;
	_zpos2 = (_pos2 select 2) + 3;

// Create camera at start
	_camera = "camera" camCreate [_xpos1, _ypos1, _zpos1];
	_camera camSetTarget _object;
	_camera camSetFOV 1.5;
	_camera camCommit 0;
	_camera cameraEffect ["internal","back"];
	showcinemaborder false;

WaitUntil{camCommitted _camera && time > 0};

// Create News Feed Overlay
//	_head = parsetext "<t size='2'>TITLE</t><br/>SubTitle";
//	_line = parsetext "Scrolling Menu";
//	_nul0 = [_head,_line] spawn BIS_fnc_AAN;

// Move Camera to Destination
	_camera camSetPos [_xpos2, _ypos2, _zpos2];
	_camera camSetTarget _object;
	_camera camSetFOV 0.200;
	_camera camCommit _time*0.9;

WaitUntil{camCommitted _camera};

// Remove News Feed
//	3000 cuttext ["","plain"];

//Destroy camera
	camDestroy _camera;
	player cameraEffect ["terminate","back"];
        
	intro_cam_done = true;
