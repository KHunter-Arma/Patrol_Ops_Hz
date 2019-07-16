private _pos = markerpos _this;

private _goodBuildings = [];
private _posFound = false;
{

	if ((alive _x) && {(count ([_x] call BIS_fnc_buildingPositions)) > 2}) then {
	
		_goodBuildings pushback _x;
	
	};

} foreach (nearestObjects [_pos,["House"],50]);

{
	{			
		if ((lineIntersects [AGLToASL _x, AGLToASL [_x select 0,_x select 1,150]]) && {(count (_x nearEntities ["CAManBase",2])) == 0}) exitwith {		
			player setposatl _x;
			_posFound = true;			
		};			
	} foreach ([_x] call BIS_fnc_buildingPositions);
	if (_posFound) exitwith {};
} foreach _goodBuildings;
