call compile preprocessFileLineNumbers "initUPSRespawn.sqf";
call compile preprocessfilelinenumbers "lk\nuke\nenvi.sqf";
Receiving_finish = false;
if (!isDedicated) then {

	onPreloadFinished { Receiving_finish = true; onPreloadFinished {}; };

};

if (is3DEN) then {

	waitUntil {sleep 1; !is3DEN};

};

if (isServer) then {

	Hz_pops_fnc_handleFirstTimeLaunch = compile preprocessFileLineNumbers "Hz_pops_fnc_handleFirstTimeLaunch.sqf";
	Hz_pops_fnc_setupRestrictions = compile preprocessFileLineNumbers "\Hz_cfg\Hz_econ\setup.sqf";
	Hz_pops_fnc_persistencyPostLoadCustomFunction = compile preprocessFileLineNumbers "Hz_pops_fnc_persistencyPostLoadCustomFunction.sqf";

};

introseqdone = false; 
#include "HZ\init_Hz.sqf" 

/*

if (civ_debug) then {

[]spawn {
    
      _civilians = [];
      _markeradded = [];
      _index = 0;
      
      while {true} do {

{if (side _x == civilian) then {

_civilians = _civilians + [_x];

};}foreach allunits;

{if !(_x in _markeradded) then {

_pos = getpos _x;
_index = random 1;
_indexstring = format ["%1",_index];
createmarker [_indexstring,_pos];

_indexstring setMarkerType "Warning";
_indexstring setMarkerColor "ColorRed";

_markeradded = _markeradded + [_x];

};}foreach _civilians;

sleep 5;
};
};
};

*/


diag_log format ["###### %1 ######", missionName];
diag_log [diag_frameno, diag_ticktime, time, "Executing init.sqf"];

// For SP/Mission Testing
	if(isNil "paramsArray") then { paramsArray = [-1,3,999,4,0,4,1,1,1,9,0,0,0,1,0,1,0,1,5,0,0]; };

// Mission Parameters
	mps_params = paramsArray;   

[] execVM "mps\init_mps.sqf";       

if(!isDedicated) then {
	WaitUntil{ !(isNull player) && !isNil "mps_init" && Receiving_finish };
}else{
	Receiving_finish = true;
	WaitUntil{!isNil "mps_init"};
};

if(Hz_weather_Snow) then {

	[2016,12,25,mps_mission_hour,30] call mps_timeset;
        if(isServer) then {Hz_overrideweather = true; publicvariable "Hz_overrideweather";};
        weather = 1;
        0 setovercast weather;
        []spawn {
            if(isnil "Hz_overrideweather") then {Hz_overrideweather = true;};
            while {Hz_overrideweather} do {
						
                0 setrain 0;
                0 setovercast 1;								
								0 setlightnings 0;
                0 setfog 0.2;
								forceweatherchange;
								
								// Goon snowstorm script
								/* Goon/Gooncorp 2015  */
								
									_obj = (vehicle player);
									_pos = getposASL _obj;
								 _n =  abs(wind select 0) + abs(wind select 1) + abs(wind select 2);
								 _velocity = wind;
								 _color = [1, 1, 1];   


								_hndl = ppEffectCreate ["colorCorrections", 1501];
								_hndl ppEffectEnable true;
								_hndl ppEffectAdjust [0.8, 0.8, 0.0, [.3, .3, 1.0, .1], [.88, .88, .93, .45], [1 , 1, 1, 0.03]];//white 
								_hndl ppEffectCommit 0;


				 
								 _snowflakes1 = "#particlesource" createVehicleLocal _pos; 
					 //_snowflakes1  attachto [player, [0,0,12]];
								 _snowflakes1  setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 14, 2, 0], "", "Billboard", 1, 22, [0, 0, 6], _velocity, (0), 1.69, 1, 1, [1.5], [[1,1,1,0],[1,1,1,1],[1,1,1,1]],[1000], 0, 0, "", "", _obj];
								 _snowflakes1  setParticleRandom [0, [24 + (random 2),24 + (random 2), 4], [0, 0, 0], 0, 0, [0, 0, 0, .03], 0, 0];
								 _snowflakes1  setParticleCircle [0, [0, 0, 0]];
								 _snowflakes1  setDropInterval 0.001; 


								 _snowflakes2 = "#particlesource" createVehicleLocal _pos; 
					 //_snowflakes2  attachto [player, [0,0,12]];
								 _snowflakes2  setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 12, 2, 0], "", "Billboard", 1, 14, [0, 0, 6], _velocity, (0), 1.39, 0, 0, [.2], [[1,1,1,0],[1,1,1,1],[1,1,1,1]],[1000], 0, 0, "", "", _obj];
								 _snowflakes2  setParticleRandom [0, [14 + (random 2),14 + (random 2), 5], [0, 0, 0], 0, 0, [0, 0, 0, 2], 0, 0];
								_snowflakes2  setParticleCircle [0, [0, 0, 0]];
								 _snowflakes2  setDropInterval 0.004; 


								 _clouds1 = "#particlesource" createVehicleLocal _pos; 
					 //_clouds1  attachto [player, [0,0,12]];
								 _clouds1  setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 12, 2, 0], "", "Billboard", 1,22, [0, 0, 16], _velocity, (_n * 4), 1.72, 1, 1, [22 + random 33], [[1,1,1,0],[1,1,1,1],[1,1,1,0]],[1000], 0, 0, "", "", _obj];
								 _clouds1  setParticleRandom [3, [55 + (random 8),55 + (random 10), 55], [2, 2, 0], 0, 0, [0, 0, 0, 0], 0, 0];
								 _clouds1  setParticleCircle [0, [0, 0, 0]];
								 _clouds1  setDropInterval 0.05; 

								 _clouds2 = "#particlesource" createVehicleLocal _pos; 
					// _clouds2  attachto [player, [0,0,12]];
								 _clouds2  setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 13, 6, 0], "", "Billboard", 1, 22, [0, 0, 36], _velocity, (0), 1.52, 1, 1, [5 + random 23], [[1,1,1,0],[1,1,1,.4],[1,1,1,0]],[1000], 0, 0, "", "", _obj];
								 _clouds2  setParticleRandom [3, [24 + (random 8),24 + (random 10), 15], [2, 2, 0], 0, 0, [0, 0, 0, 0], 0, 0];
								 _clouds2  setParticleCircle [0, [0, 0, 0]];
								 _clouds2  setDropInterval 0.1; 

								 sleep 30;
								 deletevehicle _snowflakes1;
								 deletevehicle _snowflakes2;
								 deletevehicle _clouds1;
								 deletevehicle _clouds2;
								
                };
        };
        
} else {
        // This sets the date from the mission parameters on the server and all JIP players are then set to the server time.
        [2016,07,25,mps_mission_hour,30] call mps_timeset;
        if(isServer) then {Hz_overrideweather = false; publicvariable "Hz_overrideweather";};

};       

//JIP nuke effects
if(!isServer && nukeweather) then {

[] call compile preprocessfilelinenumbers "lk\nuke\nenvi.sqf";
player spawn envi;
ashhandle = player spawn ash;
windv=true;
player spawn windef;
 
};
// This is the intro Sequence. Edit this line to have your own text fill the screen on intro.
if(!mps_debug && !hz_debug) then {["Bad Company Presents...",format["Patrol Ops Hunter'z\n%1",toupper(worldname)],"Mission by\nK.Hunter","Patrol Ops Framework\nby EightySix"] spawn mps_intro; } else {introseqdone = true;};


// This line prepares the outro. To call the outro, declare "mps_mission_finished = true" in a trigger or line of code to trigger the outro sequence.
//	[] call mps_outro;

// This calls the Patrol Ops Mission
// To use just the framework for your own missions, delete the line below.

 ["patrol_ops"] call mps_mission_sequence;

// This creates an Ammobox for a New / JIP Player on a marker called "ammobox_(playerside)"
//	sleep (random 5); [format["ammobox_%1",side player]] call mps_ammobox;

if(mps_debug) then {
	OnMapSingleClick "vehicle player SetPos [_pos select 0, _pos select 1, 0]"; player allowdamage false;
};
    
       "ban"      addPublicVariableEventHandler {[]execvm "HZ\admin\ban_EH.sqf"; };
       "kick"   addPublicVariableEventHandler {[]execvm "HZ\admin\kick_EH.sqf"; };
        
        
/*
if(isServer) then {
 
//ACM_INS settings
   
    waitUntil {!isNil {BIS_ACM1 getVariable "initDone"}};
    waitUntil {BIS_ACM1 getVariable "initDone"};
   [] spawn {
       waitUntil {!(isnil "BIS_fnc_init")};
       [0.3, BIS_ACM1] call BIS_ACM_setIntensityFunc;                 //Sets the intensity of the ACM, in other words, determines how active it will be. Starts at 0 ends at 1.0, its been known to fail using 0.7 and 0.8
       [BIS_ACM1, 400, 500] call BIS_ACM_setSpawnDistanceFunc;      // This is the radius on where the units will spawn around the unit the module is sync'd to, 400m being the minimal distance and 700m being the maximum. Minimum is 1 I believe.

	   [["INS"], BIS_ACM1] call BIS_ACM_setFactionsFunc;     // This tells the ACM which faction of units it will spawn. In this case it will spawn Takistani Insurgents
       [0.1, 0.3, BIS_ACM1] call BIS_ACM_setSkillFunc;                // This determines what the skill rating for the spawned units will be
       [0.8, 0.9, BIS_ACM1] call BIS_ACM_setAmmoFunc;               // This sets their amount of ammo they spawn with
       ["ground_patrol", 1, BIS_ACM1] call BIS_ACM_setTypeChanceFunc; //If you want ground patrols then leave it as a 1, if you don't put a 0. They will use random paths
       ["air_patrol", 0, BIS_ACM1] call BIS_ACM_setTypeChanceFunc;    // Same thing for air patrols
       [BIS_ACM1, ["INS_InfSquad","INS_InfSquad_Weapons","INS_InfSection_AT","INS_SniperTeam","INS_MilitiaSquad","INS_MotInfSquad","INS_MotInfSection"]] call BIS_ACM_addGroupClassesFunc;   // This determines which exact units will spawn from the group **Citation needed**
 
   };
 
};

sleep 3;

//ACRE
_ret = ["ACRE_PRC117F", [36.625, 37.775] ] call acre_api_fnc_setDefaultChannels;
_ret = ["ACRE_PRC117F", [20000, 20000] ] call acre_api_fnc_setDefaultPowers;

//if(isServer) then { mps_change_time = [9]; PublicVariable "mps_change_time"; mps_change_time call mps_timechange; };
*/

		execVM "R3F_LOG\init.sqf";      
		
		//ACRE settings
		[true] call acre_api_fnc_setRevealToAI;
		[0.3] call acre_api_fnc_setLossModelScale; //buggy