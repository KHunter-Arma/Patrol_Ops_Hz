// Written by Xeno
// Apadted by EightySix

private ["_disp","_control","_backgroundControl","_maxWidth","_pos","_newval","_score","_total","_side","_text"];
disableSerialization;

if( isNil "mps_progress_show" ) then { mps_progress_show = false; };
if( !mps_progress_show ) then { call mps_progress_toggle; };

	_score = _this select 0;
	_total = _this select 1;
	_side = _this select 2;
	_text = "Capturing...";
	if(count _this > 3) then {_text = _this select 3};

	mps_progress_timer = 15;

	_disp = uiNamespace getVariable "DPROGBAR";
	_backgroundControl = _disp displayCtrl 3600;
	_titletext = _disp displayCtrl 3900;
	_control = _disp displayCtrl 3800;
	_pos = ctrlPosition _control;

	_maxWidth = (ctrlPosition _backgroundControl select 2) - 0.02;

	_newval = (_maxWidth * (_score / _total)) max 0.02;
	_newval = _newval min 0.38;
	_pos set [2, _newval];
	_color = [1,0,0,0.8];
	_color = switch (_side) do{
		case east: {[1,0,0,0.8]};
		case west: {[0,0,1,0.8]};
		default    {[0,1,0,0.8]};
	};

	_titletext ctrlSetText _text;
	_control ctrlSetPosition _pos;
	_control ctrlSetBackgroundColor _color;
	_control ctrlCommit 0;

