_list = ["cap_town","def_camp","def_town"];

_j = (count _list - 1) min (round random (count _list));
_next = _list select _j;

if (((count playableunits) > 14) && 
    (({_x getvariable ["TL",false]} count playableunits) > 0) &&
    (({_x getvariable ["PMC",false]} count playableunits) > 2) &&                
    (({_x getvariable ["JointOps",false]} count playableunits) > 7)
    ) then { 
    
        Hz_ambw_pat_disablePatrols = true; 
				publicVariable "Hz_ambw_pat_disablePatrols";
        taskrequested = true;
        publicvariable "taskrequested";     
        
        {_x setvehiclelock "unlocked";} foreach Hz_save_jointOps_vehicles;
        
        Hz_max_deadunits = Hz_max_deadunits/2;
        
        Hz_max_allunits = Hz_max_allunits*1.1;
        
        patrol_task_units = [];
        patrol_task_vehs = [];
        stopreinforcements = false;
				publicVariable "stopreinforcements";
                                    
	_script = [] execVM format["tasks\jops_types\%1.sqf",_next];
        
        Hz_patrol_task_in_progress = true;
        publicvariable "Hz_patrol_task_in_progress";
	waitUntil{sleep 10; scriptdone _script};
        Hz_patrol_task_in_progress = false;
        publicvariable "Hz_patrol_task_in_progress";
        
        taskrequested = false;
        publicvariable "taskrequested";
        stopreinforcements = true;
				publicVariable "stopreinforcements";
        
        Hz_max_deadunits = Hz_max_deadunits*2;
        Hz_max_allunits = Hz_max_allunits/1.1;
        
        [] spawn {
        
        waituntil {sleep 300; (count (playersnumber west)) < 1};
        
        {_x setvehiclelock "locked";} foreach Hz_save_jointOps_vehicles;
        
        };

} else {
    
[-1, {hint "Joint Ops unavailable at this time";}] call CBA_fnc_globalExecute;    
        
};

jointops = false;
publicvariable "jointops";

sleep 120;
[] execvm "tasks\patrol_ops.sqf";
