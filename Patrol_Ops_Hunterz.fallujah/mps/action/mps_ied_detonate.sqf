// Written by BON_IF
// Adpated by EightySix

	_ied = _this select 0;

	_caller = _this select 1;
	_randomtime = 10 + round random 10;
	_delay = _randomtime;
	
	player playMove "ActsPercSnonWnonDnon_carFixing2";
	sleep _randomtime;
	player playMoveNow "AmovPercMstpSlowWrflDnon";
	
	if(not alive player) exitwith { player playMoveNow "AmovPercMstpSlowWrflDnon"; mps_lock_action = false; };
	
	if(getNumber (configFile >> "CfgVehicles" >> typeof _caller >> "canDeactivateMines") < 1) then {
		if(_randomtime > 12) then {
			player sideChat "IED detonation failed. Detonating in 1 second!";
			sleep 1;
			_ied setvariable ["bon_ied_blowit",true,true];
		} else {
			mission_commandchat = format["%1 has set the self destruct",name player]; publicVariable "mission_commandchat"; player sideChat mission_commandchat;

			sleep 1;	mission_commandchat = "10 Seconds to Detonation"; 	publicVariable "mission_commandchat"; hint mission_commandchat;
			sleep 7;	mission_commandchat = "3.."; 				publicVariable "mission_commandchat"; hintsilent mission_commandchat;
			sleep 1;	mission_commandchat = "2.."; 				publicVariable "mission_commandchat"; hintsilent mission_commandchat;
			sleep 1;	mission_commandchat = "1.."; 				publicVariable "mission_commandchat"; hintsilent mission_commandchat;
		};
	}else {
			mission_commandchat = format["%1 has set the self destruct",name player]; publicVariable "mission_commandchat"; player sideChat mission_commandchat;

			sleep 1;	mission_commandchat = "10 Seconds to Detonation"; 	publicVariable "mission_commandchat"; hint mission_commandchat;
			sleep 7;	mission_commandchat = "3.."; 				publicVariable "mission_commandchat"; hintsilent mission_commandchat;
			sleep 1;	mission_commandchat = "2.."; 				publicVariable "mission_commandchat"; hintsilent mission_commandchat;
			sleep 1;	mission_commandchat = "1.."; 				publicVariable "mission_commandchat"; hintsilent mission_commandchat;
		};
		
	

	sleep random 2;
	hintsilent "";

	_ied setvariable ["bon_ied_blowit",true,true];
	
	if(true) exitwith { player playMoveNow "AmovPercMstpSlowWrflDnon"; };