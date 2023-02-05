waitUntil {
	sleep 1;
	(!isNil "R3F_LOG_mutex_local_verrou") && {!isNil "R3F_LOG_CFG_string_condition_allow_logistics_on_this_client"}
};

Hz_pops_roadPickupAction = player addAction ["<t color=""#AAAAAA"">Move road segment</t>", {

	_nearRoads = nearestObjects [player, ["CUP_A1_Road_ces_d6konec","CUP_A1_Road_ces_d6","CUP_A1_Road_ces_d12","CUP_A1_Road_ces_d25"], 3];
	
	if ((count _nearRoads) < 1) exitWith {
		hint "There is no road segment that you can move near you";
	};
	
	_road = _nearRoads select 0;

	[_road] call R3F_LOG_FNCT_objet_deplacer;

}, nil, -99, false, true, "", "(call R3F_LOG_CFG_string_condition_allow_logistics_on_this_client) && {(vehicle _this) == _this}"];