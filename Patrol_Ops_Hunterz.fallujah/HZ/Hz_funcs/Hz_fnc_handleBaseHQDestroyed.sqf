params ["_thisTrigger"];

_objs = [];
_missionStart = time < 300;

{
	if (_x inArea _thisTrigger) then {
		if (_missionStart && {_x isKindOf "CAManBase"}) then {
			deletevehicle _x;
		};
		if ((!(_x isKindOf "CAManBase")) && {!(_x isKindOf "LandVehicle")}) then {
			_x setDammage 1;
			_objs pushBack _x;
		};
	};
}foreach nearestobjects [_thisTrigger,[],(triggerArea _thisTrigger) select 0];

[getpos _thisTrigger, (triggerArea _thisTrigger) select 2, _objs] spawn {

	uisleep 3;
	{deleteVehicle _x} foreach (_this select 2);

	if (Hz_HQUnderConstruction) then {
		
		_spawnedObjs = [_this select 0, (_this select 1) + 180, call compile preprocessfilelineNumbers "Compositions\Other\baseHQ_constructionSite.sqf"] call BIS_fnc_objectsMapper;

		_civGrp = createGroup civilian;

		{
			if ((typeof _x) == "Microphone1_ep1") then {
			
				_dudepos = getpos _x;
				_dudedir = getdir _x;
				deletevehicle _x;
				_dude = _civGrp createUnit ["C_Man_ConstructionWorker_01_Vrana_F",_dudepos, [], 50, "NONE"]; 
				_dude setDir _dudedir;
				_dude setpos _dudepos;
				dostop _dude;
				_dude disableai "MOVE";
				
				_dude setVariable ["mps_interaction_disabled",true,true];
			
			};
			
			if (_x isKindOf "LandVehicle") then {
				_x setvehicleLock "LOCKED";
			};
			
		} foreach _spawnedObjs;
		
		_civGrp deleteGroupWhenEmpty true;
		
	} else {
	
		_ruin = Hz_HQRuinType createVehicle [0,0,12000];
		_ruin setdir (_this select 1);
		_ruin setpos (_this select 0);
		
	};	
	
	if (time < 300) then {
	
		_table = Hz_HQStoreReplacementTableType createVehicle Hz_HQStoreReplacementTablePos;
		_table setDir Hz_HQStoreReplacementTableDir;
		_table setpos Hz_HQStoreReplacementTablePos;
		
		_grp = createGroup (SIDE_A select 0);
		
		_johnDude = _grp createUnit [Hz_HQStoreReplacementDudeType,Hz_HQStoreReplacementDudePos, [], 50, "NONE"]; 
		_johnDude setDir Hz_HQStoreReplacementDudeDir;
		_johnDude setpos Hz_HQStoreReplacementDudePos;
		_johnDude addGoggles Hz_HQStoreReplacementDudeGoggles;
		[_johnDude, Hz_HQStoreReplacementDudeFace] remoteExecCall ["setFace", 0, true];
		_johnDude forcespeed 0;
		_johnDude disableai "move";
		_johnDude setSkill 0;
		John = _johnDude;
		publicVariable "John";
		
		_johnDude setVariable ["mps_interaction_disabled", true, true];
		
		{
			_dude = _grp createUnit [Hz_baseGuardType, Hz_HQStoreReplacementDudePos, [], 50, "NONE"];
			_dude setUnitLoadout _x;
		} foreach Hz_baseGuards;

		sleep 0.1;
		_newgrp = createGroup (SIDE_A select 0);
		(units _grp) joinSilent _newgrp;
		sleep 0.1;
		deleteGroup _grp;
		_newgrp deleteGroupWhenEmpty true;

	};
};
