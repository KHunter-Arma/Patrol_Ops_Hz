// Written by BON_IF
// Adpated by EightySix

_unit = _this select 0;

if(isServer) then{
	[_unit] execFSM (mps_path+"fsm\mps_recruit_lifecycle.fsm");
} else {
	mps_recruit_newunit = _unit;
	publicVariable "mps_recruit_newunit";
};

_unit addAction [format["<t color='#949494'>Dismiss %1</t>",name _unit],(mps_path+"action\mps_unit_dismiss.sqf"),[],-10,false,true,""];