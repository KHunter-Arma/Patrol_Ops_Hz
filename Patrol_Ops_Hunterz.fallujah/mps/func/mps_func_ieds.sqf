// Written by BON_IF
// Adapted by EightySix

private ["_iedpos","_offset","_ied"];

if( !isServer ) exitWith {};
if( isNil "mps_ied_count" || isNil "mps_ambient_insurgents" ) exitWith { };

mps_ieds = [
	"Land_Misc_Garb_Heap_EP1",
	"hiluxWreck",
	"datsun01Wreck",
	"datsun02Wreck",
	"SKODAWreck",
	"UAZWreck",
	"BMP2Wreck",
	"BRDMWreck"
];

if(!mps_ace_enabled) then {
	mps_ieds = mps_ieds + [
		"BAF_ied_v1",
		"BAF_ied_v2",
		"BAF_ied_v3",
		"BAF_ied_v4"
	];
};


_iedpositions = [];
_roads = (getMarkerPos format["respawn_%1",(SIDE_A select 0)]) nearRoads 20000;

for "_i" from 1 to mps_ied_count do {

	for "_searchcount" from 1 to 10000 do {
		_j = (count _roads - 1) min (round random (count _roads));
		_iedpos = _roads select _j;
		if(
			{_iedpos distance _x < 1000} count _iedpositions == 0 &&
			_iedpos distance (getMarkerPos format["respawn_%1",(SIDE_A select 0)]) > 1000 &&
			_iedpos distance (getMarkerPos format["respawn_%1",(SIDE_B select 0)]) > 1000
		) exitWith{};
		_iedpos = nil;
	};

	if(not isNil "_iedpos") then {
		_roads = _roads - [_iedpos];
		_iedpositions = _iedpositions + [_iedpos];
		_j = (count mps_ieds - 1) min (round random (count mps_ieds));
		_ied = (mps_ieds select _j) createVehicle [(position _iedpos) select 0,(position _iedpos) select 1, 0];
		if(random 2 > 1) then {_offset = [-7.5 - random 3,0,0]} else {_offset = [7.5 + random 3,0,0]};
		_ied setPosATL (_iedpos modelToWorld _offset);
		_ied setVariable ["mps_ied",true,true];
		_ied execFSM (mps_path+"fsm\mps_ied_sensor.fsm");

		if(random 1 > 0.6 && mps_ambient_insurgents) then {
			_ied spawn {
				waitUntil{ { side _x == (SIDE_A select 0) } count nearestObjects[position _this,["Man","LandVehicle"],800] > 0 && alive _this };
				_grp = [position _this,"INS",(2 + random 4),20,"standby"] call CREATE_OPFOR_SQUAD;
			};
		};

		_iedpos = nil;
		_ied = nil;
	};
};

if(mps_debug) then {
	{ (createMarkerLocal [str round random 999999,position _x]) setMarkerTypeLocal "dot"; } foreach _iedpositions;
};
