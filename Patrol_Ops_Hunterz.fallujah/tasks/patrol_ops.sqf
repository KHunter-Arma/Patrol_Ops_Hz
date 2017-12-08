mps_mission_score = 0;

/*

if(count mps_loc_hills > 0) then {

  _location = [["hill"]] call mps_getNewLocation;
  

  [_location] spawn CREATE_OPFOR_AIRPATROLS;

};
*/

_list = [
  //  "def_base",
	//	"def_castle",
		"esc_speaker"		
    ];
		
if(hz_debug) then {_list = ["esc_speaker"];};

//init
taskrequested = false;
publicvariable "taskrequested";
stopreinforcements = true;

waituntil {missionload = false; sleep 10; taskrequested || jointops};

_j = (count _list - 1) min (round random (count _list));
_next = _list select _j;
_prev = [];
if(isnil "Hz_save_prev_tasks_list") then {_prev = _list;} else {
  _prev = Hz_save_prev_tasks_list;
};

for "_i" from 1 to mps_mission_counter do {

  _lim = 0;

  while{ _next IN _prev && _lim < count _list } do {
    _j = (count _list - 1) min (round random (count _list));
    _next = _list select _j;
    _lim = _lim + 1;
  };

  waituntil {missionload = false; sleep 10; taskrequested || jointops};
  
  if(jointops) exitwith {[] execvm "tasks\joint_ops.sqf";};
  
  _continue = false;
  
  if ((_next == "sad_scud") && !hz_debug) then {
    
    if (((count playableUnits) + ({isplayer _x} count alldead)) >= 8) then {_continue = true;};        
    
  } else {
    
    _continue = true;
    
  };
  
  if (_continue) then {
    
    if(!hz_debug) then {
      
      waituntil {sleep 5; 
        (
        ((count playableunits) > 3) && 
        (({_x getvariable ["TL",false]} count playableunits) > 0) &&
        (({_x getvariable ["PMC",false]} count playableunits) > 2)
        )};
      
    };
    
    missionload = true; 
    
    waituntil {sleep 5;
      (count allunits) < Hz_max_units_before_task};
    
    patrol_task_units = [];
    patrol_task_vehs = [];
    stopreinforcements = false;
    
    //check to see conditions are still true after last wait
    if (
        (((count playableunits) > 3) && 
          (({_x getvariable ["TL",false]} count playableunits) > 0) &&
          (({_x getvariable ["PMC",false]} count playableunits) > 2)) 
        || hz_debug
        ) 
    
    then {
      
      if(count _prev >= count _list) then {
        _prev = [_next];             
      }else{
        _prev = _prev + [_next];
      };   
      Hz_save_prev_tasks_list = _prev;
      
			mps_mission_status = 1;
      Hz_patrol_task_in_progress = true;
      publicvariable "Hz_patrol_task_in_progress";
			
      call compile preprocessFileLineNumbers format["tasks\types\%1.sqf",_next];      
      
      //reset flag so garrison script can keep working
      {_x setvariable ["occupied",false];} foreach Hz_resetBuildingVars;
      Hz_resetBuildingVars = [];      
      
      mps_mission_status = 0;
      Hz_patrol_task_in_progress = false;
      publicvariable "Hz_patrol_task_in_progress";
      
    };
    
    taskrequested = false;
    publicvariable "taskrequested";
    stopreinforcements = true;
    
  } else {
  
    if(count _prev >= count _list) then {
      _prev = [_next];             
    }else{
      _prev = _prev + [_next];
    };   
    Hz_save_prev_tasks_list = _prev;
  
  };
  
};