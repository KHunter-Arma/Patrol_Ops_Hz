// Written by EightySix

if(isNil "MHQ_STATUS") then {MHQ_STATUS = false};
if(isNil "RALLY_STATUS") then {RALLY_STATUS = false};

_this select 0 displayCtrl 86009 ctrlSetText (localize "STR_AIS_button_RALLY_text");
_this select 0 displayCtrl 86006 ctrlSetText (localize "STR_AIS_button_MHQ_text");

while {dialog} do {

	if (!MHQ_STATUS) then {
		_this select 0 displayCtrl 86006 ctrlShow false;
	}else{
		_this select 0 displayCtrl 86006 ctrlShow true;
	};

	if (!RALLY_STATUS || (({alive _x} count nearestobjects [mps_rallypoint_tent,["WarfareBDepot"],150]) < 1) || (player getvariable ["JointOps",false])) then {
		_this select 0 displayCtrl 86009 ctrlShow false;
	}else{
		_this select 0 displayCtrl 86009 ctrlShow true;
	};

	sleep 1;

};