// Written by EightySix

private["_mhq","_type","_status","_ns","_side"];

	_camoNet = "Land_CamoNetB_NATO";

	if(mps_oa) then{
		_camoNet = "Land_CamoNetB_NATO_EP1";
	};

	_mhq = _this select 0;
	_type = typeOf _mhq;
	if(count _this > 1) then { _type = _this select 1; };
	_status = _mhq getVariable "mhq_status";
	_ns = _mhq getVariable "mhq_status";
	_side = _mhq getVariable "mhq_side";
 	sleep 1;

	while{(damage _mhq < 1) && (if(_ns) then {_status}else{!_status}) } do { sleep 1; _status = _mhq getVariable "mhq_status"; };

	{ _x action ["eject",_mhq]; }foreach (crew _mhq);

	if(alive _mhq) then {

		_new = (typeOf _mhq) call mps_get_new_type;
		_status = _mhq getVariable "mhq_status";
		_pos = position _mhq;
		_dir = direction _mhq;

		if(!(isNil "_new")) then {
			deleteVehicle _mhq;
			_mhq = _new createVehicle [_pos select 0, _pos select 1, -0.4];
			_mhq setPos [_pos select 0, _pos select 1, -0.4];
			_mhq setDir _dir; sleep 0.125;
			_mhq setVariable ["mhq_side",_side,true];
			_mhq setVariable ["mhq_status",_status,true];
			if(!_status) then {_mhq setVariable ["liftable",true,true];};
			if(_status) then {
				[_mhq] spawn mps_object_c4only;
			};
		}else{
			if(_status) then {
				_mhq engineOn false;
				_mhq setVariable ["liftable",false,true];
				sleep 1;
				_camo =  _camoNet createVehicle _pos;
				_camo setDir (_dir + 90);
				_camo attachTo [_mhq,[0,0,0.4]];
			}else{
				_mhq setVariable ["liftable",true,true];
				_camo = nearestObject [_mhq,"House"];
				deleteVehicle _camo;
			};
		};
		sleep 1;
		[_mhq,_type] spawn mps_mhq_toggle;
		mhq_update = [_mhq,_status]; publicVariable "mhq_update"; if(isServer) then { mhq_update call mps_mhq_update;};
	};

	if(damage _mhq >= 1) then { mhq_update = [_mhq,false]; publicVariable "mhq_update"; sleep 30; deletevehicle _mhq; [_type,_side] call mps_mhq_respawn;};

if(true)exitWith{};