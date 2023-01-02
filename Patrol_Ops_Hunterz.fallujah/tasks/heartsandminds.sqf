waitUntil {
	!isNull Hz_pops_heartsandmindsTaskRequester
};

_list = [
    "sar_daughter"
    ];
		
if(hz_debug) then {_list = ["sar_daughter"];};

_j = (count _list - 1) min (round random (count _list));
_next = _list select _j;
_prev = [];
if(isnil "Hz_save_prev_HMtasks_list") then {_prev = _list;} else {
  _prev = Hz_save_prev_HMtasks_list;
};

_lim = 0;

while{ _next IN _prev && _lim < count _list } do {
	_j = (count _list - 1) min (round random (count _list));
	_next = _list select _j;
	_lim = _lim + 1;
};

Hz_pops_baseSupportEnabled = false;
publicVariable "Hz_pops_baseSupportEnabled";

patrol_task_units = [];
patrol_task_vehs = [];
stopreinforcements = false;
publicVariable "stopreinforcements";
	
if(count _prev >= count _list) then {
	_prev = [_next];             
}else{
	_prev = _prev + [_next];
};   
Hz_save_prev_HMtasks_list = _prev;
publicVariable "Hz_save_prev_HMtasks_list";

Hz_pops_heartsandmindsInProgress = true;
publicvariable "Hz_pops_heartsandmindsInProgress";

call compile preprocessFileLineNumbers format["tasks\heartsandminds\%1.sqf",_next];

//reset flag so garrison script can keep working
{_x setvariable ["occupied",false];} foreach Hz_resetBuildingVars;
Hz_resetBuildingVars = [];      

sleep 120;
[] execvm "tasks\patrol_ops.sqf";