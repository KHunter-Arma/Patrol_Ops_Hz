if (_this == "-1") then {
	
	Hz_func_isSupervisor = {false};
	
	player addEventHandler ["AnimChanged", {
					if (local (_this select 0) && {_this select 1 == "ACE_Climb"}) then {
							// abort climb animation
							[_this select 0, "AmovPercMstpSnonWnonDnon", 2] call ace_common_fnc_doAnimation;
							
					};
	}];
	
	moveout player;
	sleep 0.1;
	player setPosATL Hz_pops_arrestPosition;
	sleep 0.1;
	
	if ((toUpper uniform player) != "TRYK_OVERALL_FLESH") then {
	
		player call Hz_fnc_transferGearToNearestAmmoCrate;
		player addUniform "TRYK_OVERALL_flesh";
	
	};	
	
  player setvariable ["TL",false,true];
  player setvariable ["PMC",false,true];
  
  call Hz_fnc_arrestedHandleEscape;

} else {

	if(_this == "0") then {
			
		hint "Error\nNo player selected!";

	} else {
	
		if (_this in BanList) exitWith {
		
				closeDialog 0;
				hint "Player is already jailed!";
			
		};
	
		BanList pushBackUnique _this;
    publicvariable "BanList";
			
		private _target = objNull;
	
		{
		
			if (isPlayer _x) then {
			
				if ((getplayeruid _x) == _this) exitWith {
				
					_target = _x;
				
				};
			
			};
		
		} foreach (playableUnits + alldead + switchableUnits);
	
		if (!isNull _target) then {		
		
			"-1" remoteExec ["Hz_fnc_arrestPlayer",_target,false];
		
		};

		closeDialog 0; 
		hint "Player arrested!";

	};

};


