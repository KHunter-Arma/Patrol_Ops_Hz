// Written by Xeno
// Adpated by EightySix

private ["_unit", "_curAnim", "_deathAnim", "_deathAnimCfg"];

	_unit = _this;

	_deathAnim = "";
	_curAnim = configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState _unit);

	if (isText (_curAnim >> "actions")) then {
		if ((vehicle _unit) == _unit) then {
			_deathAnimCfg = configFile >> "CfgMovesBasic" >> "Actions" >> getText (_curAnim >> "actions") >> "die";
			if (isText _deathAnimCfg) then {
				_deathAnim = getText _deathAnimCfg;
			};
		} else {
			_deathAnimCfg = configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState _unit);
			if (isArray (_deathAnimCfg >> "interpolateTo")) then {
				_deathAnim = getArray (_deathAnimCfg >> "interpolateTo") select 0;
			};
		};
	};

_deathAnim