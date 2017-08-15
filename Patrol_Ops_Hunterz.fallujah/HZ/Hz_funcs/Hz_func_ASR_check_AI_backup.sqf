private ["_found","_dest","_friendlyGrps","_l","_enemyside","_grp","_return"];

_grp = _this;
_found = false;
_return = [];
_dest = [0,0,0];
_enemyside = west;
_side = side _grp;

if(_side == west) then {_enemyside = east;};

if (count (_grp call CBA_fnc_getAlive) > 1) then {

	_friendlyGrps = [leader _grp, allGroups, Hz_AI_param_radioRange, {_x != _grp && side _x == _side}] call CBA_fnc_getNearest;
	if (count _friendlyGrps > 0) then {

            _troubleVal = 0;

		{ // find some friendlies in trouble
                _l = leader _x;
			if ((behaviour _l) == "COMBAT" && !((vehicle _l) iskindof "Air")) then {
				
				_enemyForce = _l call asr_ai_sys_aiskill_fnc_enemyForce;
                                    
                                        if (_enemyForce > _troubleVal) then {
					_found = true;
					_dest = getPosATL _l;
                                        _troubleVal = _enemyForce;
				};
			};
		} forEach _friendlyGrps;

	};

};

_return = [_found,_dest];

_return

