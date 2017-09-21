_unit = _this select 0;

sleep 1;

if (!(alive _unit)) exitwith {};

_alerter = _unit addeventhandler ["fired",{_loudness = (
		
		[_this select 0,_this select 1] call fnc_silenced) * 4;
		
		_nearunits = (_this select 0) nearentities [["Man"],_loudness];

		{

			if (((side _x) getfriend (side (_this select 0)) >= 0.6)) then {
			
				_nearunits = _nearunits - [_x];

			};

		} foreach _nearunits;

		{
			_eyes = eyePos _x;
			_focuseyes = eyePos (_this select 0);
			_obstruction = (lineintersectswith [_eyes,_focuseyes,_x,(_this select 0)]) select 0;
			_obstructed = if (isnil("_obstruction")) then {false} else {true};
			
			if (_obstructed) then
			{
				_distance = _x distance (_this select 0);
				if (_distance >= ((_loudness/4)*3)) then
				{
					_nearunits = _nearunits - [_x];
				};
			};
			
		} foreach _nearunits;
	

		{
	
			[_x,(_this select 0)] spawn fnc_cqc_react;

	
		} foreach _nearunits;
		
	}];

	
	