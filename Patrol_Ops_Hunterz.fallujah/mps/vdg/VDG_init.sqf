//VDG_init.sqf
/*
To use put the following in the init.sqf
#include "vdg\VDG_init.sqf" 
*/
#include "defines.cpp"
#define VDG_autoStart
#define VDG_respawn

VDG_initDone 		= false;
VDG_showAction		= true;
VDG_fnc_fillDistanceSelector = {
	for [{_x=1},{_x<=30},{_x=_x+1}] do {
		_value = 500*_x;
		_index = lbAdd [VDG_DISTSELECTOR_IDC,format["%1",_value]];
		lbSetValue [VDG_DISTSELECTOR_IDC,_index,_value];
		if(viewDistance == _value) then {
			lbSetCurSel [VDG_DISTSELECTOR_IDC,_index];
		}; 
	};
};

VDG_fnc_onClickApply = {
	_value = lbValue [VDG_DISTSELECTOR_IDC,lbCurSel VDG_DISTSELECTOR_IDC];
	closeDialog VDG_DIALOG_IDD;
	setViewDistance _value;
	hint format["Viewdistance: %1 m",_value];
};

VDG_fnc_onClickCancel = {
	closeDialog VDG_DIALOG_IDD;
};

VDG_addAction = {
	_id = _this addAction ["<t color='#888800'>Viewdistance</t>","mps\vdg\scripts\addAction.sqf",[],0,false,true,"","VDG_showAction && (vehicle _this) == _target"];
	_id
};



VDG_onRespawn = {
	waitUntil {!isNull player};
	_id = player addAction ["<t color='#888800'>Viewdistance</t>","mps\vdg\scripts\addAction.sqf",[],0,false,true,"","VDG_showAction && (vehicle _this) ==  _target"];
	_id
};
#ifdef VDG_autoStart
player spawn VDG_addAction;
#endif
#ifdef VDG_respawn
player addEventHandler ["Respawn",VDG_onRespawn];
#endif
VDG_initDone 		= true;
