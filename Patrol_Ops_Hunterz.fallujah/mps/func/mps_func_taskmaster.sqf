// TaskMaster 0.30 By Shuko (SHK)
// Modified by EightySix

	mps_tasks_initDone = false;

	mps_tasks_add = {
		if isserver then {
			private ["_name","_short","_long","_cond","_marker","_state","_dest"];
			_name = _this select 0;
			_short = _this select 1;
			_long = _this select 2;
			if (count _this > 3) then { _cond = _this select 3 } else { _cond = true };
			if (count _this > 4) then { _marker = _this select 4 } else { _marker = [] };
			if (count _this > 5) then { _state = _this select 5 } else { _state = "created" };
			if (count _this > 6) then { _dest = _this select 6 } else { _dest = 0 };
			mps_tasks_Tasks set [count mps_tasks_Tasks, [_name,_short,_long,_cond,_marker,_state,_dest]];
			publicvariable "mps_tasks_Tasks";
			if (!isdedicated && mps_tasks_initDone) then {
				mps_tasks_Tasks spawn mps_tasks_handleEvent;
			};
		};
	};
	mps_tasks_addNote = {
		private "_cond";
		if (count _this > 2) then { _cond = _this select 2 } else { _cond = true };
		{
			if ( [_x,_cond] call mps_tasks_checkCond ) then {
				_x creatediaryrecord ["Diary",[_this select 0,_this select 1]];
				if (time > 10) then{ hintsilent "Diary note added." };
			};
		} foreach	(if ismultiplayer then {playableunits} else {switchableunits});
	};
	mps_tasks_addTask = {
		private ["_handle","_handles","_name","_state","_marker","_dest"];
		_handles = [];
		_name = _this select 0;
		_marker = _this select 4;
		_state = _this select 5;
		_dest = _this select 6;
		if mps_debug then { diag_log format ["mps_Taskmaster> addTask: %1, %2, %3, %4",_name,_marker,_state,_dest]};
		{
			if ( [_x,(_this select 3)] call mps_tasks_checkCond ) then {
				_handle = _x createsimpletask [_name];
				_handle setsimpletaskdescription [(_this select 2),(_this select 1),""];
				_handle settaskstate _state;
				if (_state in ["created","assigned"]) then {
					_x setcurrenttask _handle;
				};
				
                                
                                /* Hunter'z: Remove 3D task waypoint
                                switch (toupper(typename _dest)) do {
					case "OBJECT": { if(mps_co) then { _handle setsimpletasktarget [_dest,true] }else{ _handle setsimpletaskdestination (position _dest) }; };
					case "STRING": { _handle setsimpletaskdestination (getmarkerpos _dest) };
					case "ARRAY": { _handle setsimpletaskdestination _dest };
                                };
				
                                */
                                
				_handles set [count _handles,_handle];
				
				if (_x == player) then {
					if (mps_tasks_showHints) then { [_handle,_state] call mps_tasks_showHint };
					
					if (count _marker > 0) then {
						if !(_state in ["succeeded","failed","canceled"]) then {
							if (typename (_marker select 0) == typename "") then {
								_marker = [_marker];
							};
							private ["_m","_t","_c","_txt"];
							{
								_m = createmarkerlocal [(_x select 0),(_x select 1)];
								_m setmarkershapelocal "ICON";
								
								_t = "selector_selectedMission";
								if (count _x > 2) then {
									private "_tmp";
									_tmp = (_x select 2); 
									if (_tmp != "") then {
										_t = _tmp;
									};
								};
								_m setmarkertypelocal _t;
								
								_c = "ColorRed";
								if (count _x > 3) then {
									private "_tmp";
									_tmp = (_x select 3); 
									if (_tmp != "") then {
										_c = _tmp;
									};
								};
								_m setmarkercolorlocal _c;
								
								if (count _x > 4) then {_m setmarkertextlocal (_x select 4)};

								if (count _x > 5) then {_m setMarkerSizeLocal  (_x select 5)};
								
							} foreach _marker;
						};
					};
				};
			};
		} foreach (if ismultiplayer then {playableunits} else {switchableunits});
		mps_tasks_TasksLocal set [count mps_tasks_TasksLocal,[_name,_state,_handles]];
	};
	mps_tasks_assign = {
		if isserver then {
			private "_task";
			for "_i" from 0 to (count mps_tasks_Tasks - 1) do {
				if (_this == ((mps_tasks_Tasks select _i) select 0)) then {
					_task =+ mps_tasks_Tasks select _i;
					_task set [5,"assigned"];
					mps_tasks_Tasks set [_i,_task];
				};
			};
                            publicvariable "mps_tasks_Tasks";
			if (!isdedicated && mps_tasks_initDone) then {
				mps_tasks_Tasks spawn mps_tasks_handleEvent;
			};
		};
	};
	mps_tasks_checkCond = {
		private ["_unit","_cond"];
		_unit = _this select 0;
		_cond = _this select 1;
		if (!isNil "_cond") then {
			if mps_debug then { diag_log format ["mps_Taskmaster> typename condition: %1",typename _cond]};
			switch (typename _cond) do {
				case (typename grpNull): { (_unit in (units _cond)) };
				case (typename objNull): { _unit == _cond };
				case (typename WEST): { (side _unit == _cond) };
				case (typename true): { _cond };
				case (typename ""): {
					if (_cond in ["USMC","INS","CDF","RU","CIV","GUE","CIV_RU"]) then {
						(faction _unit == _cond)
					} else {
						(call compile format ["%1",_cond])
					};
				};
				default { false };
			};
		} else { false };
	};
	mps_tasks_getAssigned = {
		private "_l";
		_l = [];
		{
			if ((_x select 5) == "assigned") then {
				_l set [count _l,(_x select 0)];
			};
		} foreach mps_tasks_Tasks;
		_l;
	};
	mps_tasks_getState = {
		private "_s";
		{
			if (_this == (_x select 0)) exitwith {
				_s = (_x select 5);
			};
		} foreach mps_tasks_Tasks;
		_s;
	};
	mps_tasks_handleEvent = {
		waituntil {alive player};
		private "_name";
		{
			_name = _x select 0;
			if (_name call mps_tasks_hasTaskLocal) then {
				if ([_name,(_x select 5)] call mps_tasks_hasStateChanged) then {
					if mps_debug then { diag_log format ["mps_Taskmaster> handleEvent calling updateTask: %1",_name]};
					_x call mps_tasks_updateTask;
				};
			} else {
				if mps_debug then { diag_log format ["mps_Taskmaster> handleEvent calling addTask: %1",_name]};
				_x call mps_tasks_addTask;
				if (!isdedicated && mps_tasks_initDone) then {
					playSound "IncomingTask";
				};
			};
		} foreach _this;
	};
	mps_tasks_hasState = {
		private "_b";
		_b = false;
		{
			if ((_this select	0) == (_x select 0)) then {
				if (((_this select 0) call mps_tasks_getState) == (_this select 1)) then {
					_b = true;
				};
			};
		} foreach mps_tasks_Tasks;
		_b;
	};
	mps_tasks_hasStateChanged = {
		private "_b";
		_b = false;
		{
			if ((_this select 0) == (_x select 0)) then {
				if ((_this select 1) != (_x select 1)) exitwith {
					_b = true;
				};
			};
		} foreach mps_tasks_TasksLocal;
		_b;
	};
	mps_tasks_hasTask = {
		private "_b";
		_b = false;
		{
			if (_this == (_x select 0)) exitwith { _b = true };
		} foreach mps_tasks_Tasks;
		_b;
	};
	mps_tasks_hasTaskLocal = {
		private "_b";
		_b = false;
		{
			if (_this == (_x select 0)) exitwith { _b = true };
		} foreach mps_tasks_TasksLocal;
		_b;
	};

	mps_tasks_isCompleted = {
		private "_b";
		_b = false;
		{
			if (_this == (_x select 0)) then {
				if ((_x select 5) in ["succeeded","failed","canceled"]) then {
					_b = true;
				};
			};
		} foreach mps_tasks_Tasks;
		_b;
	};
	mps_tasks_showHint = {
		private "_p";
		_p = switch (tolower (_this select 1)) do {
			case "created": { [localize "str_taskNew", [1,1,1,1], "taskNew"] };
			case "current": { [localize "str_taskSetCurrent", [1,1,1,1], "taskCurrent"] };
			case "assigned": { [localize "str_taskSetCurrent", [1,1,1,1], "taskCurrent"] };
			case "succeeded": { [localize "str_taskAccomplished", [0.600000,0.839215,0.466666,1.000000], "taskDone"] };
			case "failed": { [localize "str_taskFailed", [0.972549,0.121568,0.000000,1.000000], "taskFailed"] };
			case "canceled": { [localize "str_taskCancelled", [0.750000,0.750000,0.750000,1.000000], "taskFailed"] };
		};
		taskHint [format [(_p select 0) + "\n%1", ((taskDescription (_this select 0)) select 1)], (_p select 1), (_p select 2)];
	};
	mps_tasks_upd = {
		if isserver then {
			private ["_task","_state"];
			_state = (_this select 1);
			for "_i" from 0 to (count mps_tasks_Tasks - 1) do {
				_task =+ (mps_tasks_Tasks select _i);
				if ((_task select 0) == (_this select 0)) then {
					_task set [5,_state];
				};
				mps_tasks_Tasks set [_i,_task];
			};
			if (count _this > 2) then {
				switch (typename (_this select 2)) do {
					case (typename ""): { (_this select 2) call mps_tasks_assign };
					case (typename []): { (_this select 2) spawn { sleep 1; _this call mps_tasks_add} };
				};
			};
			publicvariable "mps_tasks_Tasks";
			if (!isdedicated && mps_tasks_initDone) then {
				mps_tasks_Tasks spawn mps_tasks_handleEvent;
			};
		};
	};
	mps_tasks_updateTask = {
		private ["_task","_name","_state","_handle","_marker"];
		for "_i" from 0 to (count mps_tasks_TasksLocal - 1) do {
			_task =+ mps_tasks_TasksLocal select _i;
			_name = _task select 0;
			if (_name == (_this select 0)) then {
				_marker = _this select 4;
				_state = _this select 5;
				_task set [1,_state];
				mps_tasks_TasksLocal set [_i,_task];
				{
					_handle = _x;
					{
						if (_handle in (simpletasks _x)) then {
							_handle settaskstate _state;
							
							if (_x == player) then {
								if (mps_tasks_showHints) then { [_handle,_state] call mps_tasks_showHint };
								
								if (count _marker > 0) then {
									if (_state in ["succeeded","failed","canceled"]) then {
										if mps_debug then { diag_log format ["mps_Taskmaster> updateTask deleting marker: %1, state: %2",_marker,_state]};
										if (typename (_marker select 0) == typename "") then {
											_marker = [_marker];
										};
										{
											deletemarkerlocal (_x select 0);
										} foreach _marker;
									};
								};
							};
						};
					} foreach (if ismultiplayer then {playableunits} else {switchableunits});
				} foreach (_task select 2);
			};
		};
	};
if isserver then {
	mps_tasks_Tasks = []; // Array member: ["Name","Title","Desc","Marker","State"]
	if (!isnil "_this") then {
		if (count _this > 0) then {
			private ["_task","_tasks","_i"];
			_tasks = _this select 0;
			for [{_i=(count _tasks - 1)},{_i>-1},{_i=_i-1}] do {
				(_tasks select _i) call mps_tasks_add;
			};
		};
	};
	publicvariable "mps_tasks_Tasks";
	if mps_debug then {
		diag_log "-- mps_tasks_Tasks --";
		diag_log mps_tasks_Tasks;
	};
	
};
if !isdedicated then {
	mps_tasks_showHints = false;
	mps_tasks_TasksLocal = []; // Array member: ["TaskName","TaskState",TaskHandles]
	if (!isnil "_this") then {
		if (count _this > 1) then {
			private ["_notes","_i"];
			_notes = _this select 1;
			for [{_i=(count _notes - 1)},{_i>-1},{_i=_i-1}] do {
				(_notes select _i) call mps_tasks_addNote;
			};
		};
	};
	[] spawn {
		waituntil {!isnull player};
		waituntil {!isnil "mps_tasks_Tasks"};
		if mps_debug then {diag_log format ["mps_Taskmaster> Tasks received first time: %1",mps_tasks_Tasks]};
		private "_sh";
		_sh = mps_tasks_Tasks spawn mps_tasks_handleEvent;
		waituntil {scriptdone _sh};
		mps_tasks_showHints = true;
		mps_tasks_initDone = true;

		"mps_tasks_Tasks" addpublicvariableeventhandler {
			(_this select 1) spawn mps_tasks_handleEvent;
		};
	};
};