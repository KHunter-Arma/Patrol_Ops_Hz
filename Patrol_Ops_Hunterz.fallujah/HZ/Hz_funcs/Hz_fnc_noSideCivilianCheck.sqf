if ((typeName _this) == "ARRAY") then {
	
	private _units = _this select {(alive _x) && {!captive _x}};
	
	if ((count _units) == 0) exitWith {};
	
	// assuming all units in the array are part of the same group in any condition!
	
	private _grp = group (_units select 0);	
	private _side = side _grp;

	{
		if ((side _x) != _side) exitwith {
			(units _grp) joinsilent (createGroup [_side, true]);
		};
	} foreach _units;

} else {
	
	if ((!alive _this) || {captive _this}) exitWith {};
		
	private _grp = group _this;	
	private _side = side _grp;

	if ((side _this) != _side) then {
		(units _grp) joinsilent (createGroup [_side, true]);
	};

};