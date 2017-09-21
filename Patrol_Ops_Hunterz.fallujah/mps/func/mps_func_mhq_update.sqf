// Written by EightySix

private["_mhq","_status","_side","_pos"];

	_mhq = _this select 0;
	_status = _this select 1;

	_side = _mhq getVariable "mhq_side";
	_pos = position _mhq;

	if(_side == playerSide) then {
		if(_status) then {
			deleteMarker MHQ_MARKER;
			MHQ_MARKER = createMarkerlocal ["Respawn_MHQ",_pos];
			MHQ_MARKER setmarkerTypelocal "mil_flag";
			switch (_side) do{
				case west: {MHQ_MARKER setMarkerColorlocal "ColorBlue";};
				case east: {MHQ_MARKER setMarkerColorlocal "ColorRed"; };
				default {MHQ_MARKER setMarkerColorlocal "ColorGreen"; };
			};
			MHQ_Marker setMarkerTextlocal " MHQ";
			MHQ_STATUS = true;
			hint "MHQ Deployed";
			mhq_action = _mhq addAction ["Undeploy  MHQ",(mps_path+"action\mps_mhq_remove.sqf"),[],-1,true,true,"",""];
			mhq_jump_action = _mhq addAction ["Redeploy to Base",(mps_path+"action\mps_teleport.sqf"),[],-1,true,true,"",""];
		}else{
			_mhq removeAction mhq_action;
			_mhq removeAction mhq_jump_action;
			deleteMarkerlocal MHQ_MARKER;
			hint "MHQ Removed";
			MHQ_STATUS = false;
		};
	};