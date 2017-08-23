_tent = _this select 0;
_uid = _tent getvariable "owneruid";
if(!mps_debug) then {
        
          
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
        
	sleep 8;

	if!(alive player) exitwith {};
};
        rallytents = rallytents - [_tent];
        publicvariable "rallytents";        				
				
				deletevehicle (_this select 0);