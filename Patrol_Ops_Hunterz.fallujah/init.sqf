HC_taskMasterName = "HC_2"; //_SERVER_ to pass to server
HC_patrolsName = "HC";
Receiving_finish = false;

if (!isDedicated && hasInterface) then {

	onPreloadFinished {
  
    Receiving_finish = true;
    onPreloadFinished {};
    
  };

};

diag_log format ["###### %1 ######", missionName];
diag_log "Executing init_Hz.sqf";

#include "HZ\init_Hz.sqf" 

diag_log "init_Hz done";

if (isServer) then {
	
	Hz_pops_fnc_handleFirstTimeLaunch = compile preprocessFileLineNumbers "Hz_pops_fnc_handleFirstTimeLaunch.sqf";
	Hz_pops_fnc_setupRestrictions = compile preprocessFileLineNumbers "\Hz_cfg\Hz_econ\setup.sqf";
	Hz_pops_fnc_persistencyPostLoadCustomFunction = compile preprocessFileLineNumbers "Hz_pops_fnc_persistencyPostLoadCustomFunction.sqf";

};

introseqdone = false;

// For SP/Mission Testing
	if(isNil "paramsArray") then { paramsArray = [-1,3,999,4,0,4,1,1,1,9,0,0,0,1,0,1,0,1,5,0,0]; };

// Mission Parameters
	mps_params = paramsArray;   

[] execVM "mps\init_mps.sqf";       

if (hasInterface) then {

	WaitUntil{ !(isNull player) && !isNil "mps_init" && Receiving_finish };
/*	
	//try to safely resolve 'stuck in loading screen bug' of Arma 3...
	WaitUntil{ !(isNull player) && !isNil "mps_init"};
	_counter = 0;
	WaitUntil { 
		
		sleep 1;
		_counter = _counter + 1;
		
		(Receiving_finish || ((_counter > 20) && (diag_fps > 20)))
	
	};
	
	if (!Receiving_finish) then {endLoadingScreen};
*/	
} else {

	if (call Hz_fnc_isHC) then {waitUntil {(name player) != "Error: No vehicle"}};
	Receiving_finish = true;
	WaitUntil{!isNil "mps_init"};
};

// This is the intro Sequence. Edit this line to have your own text fill the screen on intro.
if(!mps_debug && !hz_debug && !isDedicated && !(call Hz_fnc_isHC)) then {["Bad Company Presents...",format["Patrol Ops Hunter'z\n%1",toupper(worldname)],"Mission by\nK.Hunter","Patrol Ops Framework\nby EightySix"] spawn mps_intro; } else {introseqdone = true;};


// This line prepares the outro. To call the outro, declare "mps_mission_finished = true" in a trigger or line of code to trigger the outro sequence.
//	[] call mps_outro;

// This calls the Patrol Ops Mission
// To use just the framework for your own missions, delete the line below.

 ["patrol_ops"] call mps_mission_sequence;

// This creates an Ammobox for a New / JIP Player on a marker called "ammobox_(playerside)"
//	sleep (random 5); [format["ammobox_%1",side player]] call mps_ammobox;

if(mps_debug) then {
	//OnMapSingleClick "vehicle player SetPos [_pos select 0, _pos select 1, 0]"; player allowdamage false;
};
    
"ban" addPublicVariableEventHandler {[]execvm "HZ\admin\ban_EH.sqf"; };
"kick" addPublicVariableEventHandler {[]execvm "HZ\admin\kick_EH.sqf"; };

if (!(call Hz_fnc_isHC)) then {

	execVM "R3F_LOG\init.sqf";      

};