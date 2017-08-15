_tent = _this select 0;
_uid = _tent getvariable "owneruid";
if(!mps_debug) then {
        
          
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
        
	sleep 8;

	if!(alive player) exitwith {};
};
        rallytents = rallytents - [_tent];
        publicvariable "rallytents";        				
				
				if ((_this select 0) == mps_rallypoint_tent) then {
				
        RALLY_STATUS = false;
				deletemarker _uid;
				
				};
				
				deletevehicle (_this select 0);