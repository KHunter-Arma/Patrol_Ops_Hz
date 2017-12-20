if (_this == "-1") then {

	call Hz_pers_API_disablePlayerSaveStateOnDisconnect;
	
	Hz_func_isSupervisor = {false};
	
	player addEventHandler ["AnimChanged", {
					if (local (_this select 0) && {_this select 1 == "ACE_Climb"}) then {
							// abort climb animation
							[_this select 0, "AmovPercMstpSnonWnonDnon", 2] call ace_common_fnc_doAnimation;
							
					};
	}];
	
	moveout player;
	player setPosATL Hz_pops_arrestPosition;
	
	removeallweapons player;
	removeallitems player;
	removeAllAssignedItems player;
	removeVest player;
	removeBackpack player;
	removeHeadgear player;	
	removeGoggles player;
	
	player addUniform "TRYK_OVERALL_flesh";
  player setvariable ["TL",false,true];
  player setvariable ["PMC",false,true];
  
  call Hz_fnc_arrestedHandleEscape;

} else {

	if(_this == "0") then {
			
		hint "Error\nNo player selected!";

	} else {
	
		if (_this in BanList) exitWith {hint "Player is already jailed!"};
	
		BanList pushBackUnique _this;
    publicvariable "BanList";
	
		_target = objNull;
	
		{
		
			if (isPlayer _x) then {
			
				if ((getplayeruid _x) == _this) exitWith {
				
					_target = _x;
				
				};
			
			};
		
		} foreach (playableUnits + alldead + switchableUnits);
	
		if (!isNull _target) then {
	
			_target remoteExecCall ["Hz_pers_API_disablePlayerSaveStateOnDisconnect",_target,false];
			_target remoteExecCall ["removeAllItems",_target,false];
			_target remoteExecCall ["removeAllWeapons",_target,false];
			removeVest _target;
			removeUniform _target;
			_target remoteExecCall ["removeBackpack",_target,false];
			_target remoteExecCall ["removeAllAssignedItems",_target,false];
			removeHeadgear _target;
			removeGoggles _target;
			
			[missionNamespace, ["Hz_func_isSupervisor",{false}]] remoteExecCall ["setVariable",_target,false];
			
			[_target, ["AnimChanged", {
					if (local (_this select 0) && {_this select 1 == "ACE_Climb"}) then {
							[_this select 0, "AmovPercMstpSnonWnonDnon", 2] call ace_common_fnc_doAnimation;							
					};
			}]] remoteExecCall ["addEventHandler",_target,false];
			
			_target addUniform "TRYK_OVERALL_flesh";
			
			moveout _target;
			_target setPosATL Hz_pops_arrestPosition;
		
		};
    
    _target setvariable ["TL",false,true];
    _target setvariable ["PMC",false,true];
    
    [] remoteExecCall ["Hz_fnc_arrestedHandleEscape",_target,false];   

		closeDialog 0; 

		hint "Player arrested!";

	};

};


