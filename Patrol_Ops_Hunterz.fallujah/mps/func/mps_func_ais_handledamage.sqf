// Written by BON_IF
// Adapted by EightySix

private ['_agony','_unit','_bodypart','_damage','_returndamage'];

_unit 		= _this select 0;
_bodypart	= _this select 1;
_damage		= _this select 2;

_return = _damage / (mps_ais_factor max 1);
_revive_factor = (mps_ais_factor max 1) * 1.5;

_agony = false;

switch _bodypart do {

	case "" : { _damage = damage vehicle _unit + _return;

		_unit setVariable ["ais_overall",_damage,false];

		if(_damage >= 0.9) then {

			_agony = true;

			if(_damage >= _revive_factor) then {_unit setVariable ["ais_unit_died",true,false]};

		};

	};

	case "body" : { _damage = (_unit getVariable "ais_bodyhit") + _return;

		_unit setVariable ["ais_bodyhit",_damage,false];

		if(_damage >= 0.9) then {

			_agony = true;

			if(_damage >= _revive_factor) then {_unit setVariable ["ais_unit_died",true,false]}

		};

	};

	case "head_hit" : { _damage = (_unit getVariable "ais_headhit") + _return;

		_unit setVariable ["ais_headhit",_damage,false];

		if(_damage >= 0.9) then {

			_agony = true;

			if(_damage >= _revive_factor) then {_unit setVariable ["ais_unit_died",true,false]}

		};

	};

	default {};

};

if(_agony && not (_unit getVariable "ais_agony")) then{ _unit setVariable ["ais_agony",true,false]; };

_return