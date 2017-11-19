// Written by Xeno
// Adapted by EightySix
/*
	disableserialization;

private["_unit","_text","_driver","_crew","_distance"];

	_driver = false;
	_crew = false;
	_unit = _this;

	if (isnil "BIS_fnc_3dCredits_n") then {BIS_fnc_3dCredits_n = 2733;};

	BIS_fnc_3dCredits_n cutrsc ["po2_3dhud_Text","plain"];
	BIS_fnc_3dCredits_n = BIS_fnc_3dCredits_n + 1;

	_display = uinamespace getvariable "po2_3dhud";
	_control = _display displayctrl 9999;
	_control ctrlsetfade 1;
	_control ctrlcommit 0;
	_control ctrlsetstructuredtext parsetext _text;
	_control ctrlcommit 0;

	while{_unit IN mps_player_list && isNil "mps_mission_finished"} do{

		_text = [_unit] call mps_func_display_getnameNrank;
		_driver = [_unit,"driver"] call mps_class_check;
		_crew = [_unit,"crew"] call mps_class_check;

		_position = getPosATL _unit;

		_pos3d = [_position select 0,_position select 1,(_position select 2) + 2.1];
		_distance = player distance _pos3d;
		_alpha = [_distance] call mps_func_calculate_alpha;
		_scale = 0.3;

		if (_alpha < 1 && mps_hud_active && !visibleMap && !_crew || _alpha < 1 && mps_hud_active && !visibleMap && _driver) then {

			_pos2D = worldtoscreen _pos3d;

			if (count _pos2D > 0) then {
				_control ctrlsetscale _scale;
				_control ctrlsetposition [(_pos2D select 0) - _scale / 2,(_pos2D select 1)];
				_control ctrlsetstructuredtext parsetext _text;
				_control ctrlsetfade (_alpha^3);
				_control ctrlcommit 0.01;
			} else {
				_control ctrlsetfade 1;
				_control ctrlcommit 0.1;
			};
		}else{
			_control ctrlsetfade 1;
			_control ctrlcommit 0.1;
		};

		sleep 0.005;

	};

	_control ctrlsetfade 1;
	_control ctrlcommit 0.1;
        
        */