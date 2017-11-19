_list = ["cap_town","def_camp","def_town"];

_j = (count _list - 1) min (round random (count _list));
_next = _list select _j;

if (((count playableunits) > 14) && 
    (({_x getvariable ["TL",false]} count playableunits) > 0) &&
    (({_x getvariable ["PMC",false]} count playableunits) > 2) &&                
    (({_x getvariable ["JointOps",false]} count playableunits) > 7)
    ) then { 
    
        missionload = true; 
        taskrequested = true;
        publicvariable "taskrequested";                
                
         //get rid of ambient patrols       
        {
            if((_x getvariable ["Hz_Patrolling",false]) || (_x getvariable ["Hz_Attacking",false]) ||(_x getvariable ["Hz_Supporting",false])) then {

                 {
                     _veh = vehicle _x;

                    deletevehicle _x;
                    deletevehicle _veh;
                 }foreach units _x;
        
            };
        
        }foreach allgroups;
        
        {_x setvehiclelock "unlocked";} foreach Hz_save_jointOps_vehicles;
        
        Hz_max_deadunits = Hz_max_deadunits/2;
        
        Hz_max_allunits = Hz_max_allunits*1.1;
        
        patrol_task_units = [];
        patrol_task_vehs = [];
        stopreinforcements = false;
                                    
	_script = [] execVM format["tasks\jops_types\%1.sqf",_next];
        
        mps_mission_status = 1;
        Hz_patrol_task_in_progress = true;
        publicvariable "Hz_patrol_task_in_progress";
	waitUntil{sleep 10; scriptdone _script};
        mps_mission_status = 0;
        Hz_patrol_task_in_progress = false;
        publicvariable "Hz_patrol_task_in_progress";
        
        taskrequested = false;
        publicvariable "taskrequested";
        stopreinforcements = true;
        
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

[] execvm "tasks\patrol_ops.sqf";
