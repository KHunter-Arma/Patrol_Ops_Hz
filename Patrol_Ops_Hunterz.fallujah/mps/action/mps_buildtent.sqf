// Inspired by Code34
// Added into framework do to popular demand


private ["_types","_text","_uid","_tent","_nearobj","_mypos"];
if(isNil "mps_lock_action") then { mps_lock_action = false; };
if (mps_lock_action) then {
	hint "Wait for the current action to end...";
}else{
	private ["_position", "_mydir"];

	

	if ( ( ( position player ) distance ( getmarkerpos format["respawn_%1", ( SIDE_A select 0 ) ] ) ) < 1000 ) exitwith { 
		hint "Too close to base.";
	};
	
	_nearobj = nearestobjects [player, [], 150];
	_types = [];
	{if ( !((typeof _x) in _types) ) then {_types = _types + [typeof _x];};} foreach _nearobj;
	
	if (   (!("WarfareBDepot" in _types)) || ( (!("FlagCarrierIONwhite_PMC" in _types)) && (!("FlagCarrierUSA_EP1" in _types)) && (!("FlagCarrierNATO_EP1" in _types)) && (!("FlagCarrierBAF" in _types)) ) ) exitwith { 
		
		hint "You can only deploy a rallypoint in a FOB. Read the mission notes to learn how to build a FOB correctly in Hunter'z Patrol Ops.";
	};

	mps_lock_action = true;

	_mydir = getdir player;
	_mypos = getposatl player;
	_position =  [(getposatl player select 0) + ((sin _mydir) * 2), (getposatl player select 1) + ((cos _mydir) * 2), 0];

	if(isnull mps_rallypoint_tent) then {

		if(!mps_debug) then {
			player playMove "AinvPknlMstpSlayWrflDnon_medic";
			sleep 8;
			if!(alive player) exitwith {mps_lock_action = false}; 
		};

		mps_rallypoint_tent = "ACamp_EP1" createvehicle _position;
		mps_rallypoint_tent setposatl _position;
		mps_rallypoint_tent setVariable ["owner", name player, true];
		mps_rallypoint_tent setVariable ["owneruid", getplayeruid player, true];
		mps_rallypoint_tent setDir (_mydir - 90);
		
		_text = format["this addAction [""<t color='#ffc600'>Remove tent of %1</t>"", ""mps\action\mps_removetent.sqf"",[],0,false];", name player];
		mps_rallypoint_tent setVehicleInit _text;
		processInitCommands;


		_uid = getplayeruid player;
		createMarker [_uid,_position];
		
		sleep 1;
		_tent = mps_rallypoint_tent;
		rallytents = rallytents + [_tent];
		publicvariable "rallytents";

		/*

		deleteMarker RALLY_MARKER;
		RALLY_MARKER setmarkerTypelocal "mil_flag";

		switch ( SIDE_A select 0 ) do{
			case west: { RALLY_MARKER setMarkerColorlocal "ColorBlue";};
			case east: { RALLY_MARKER setMarkerColorlocal "ColorRed"; };
			default { RALLY_MARKER setMarkerColorlocal "ColorGreen"; };
		};

		RALLY_MARKER setMarkerTextlocal " Rallypoint";
								
								*/
		
		RALLY_STATUS = true;
		hint "Rallypoint Deployed";

	} else {
		hint "Rallypoint Removed";
	};

	mps_lock_action = false;

	[] spawn {
		
		waituntil {sleep 60; (!alive mps_rallypoint_tent)};
		
		deleteVehicle mps_rallypoint_tent;
		deleteMarker (getplayeruid player);

		//hint "Rallypoint Removed";

		RALLY_STATUS = false;
		
	};
	
};