
private ["_dirn","_dire","_dist","_intel_loc","_distintel","_intel","_hint","_person"];

if(isNil "mps_civilian_intel") exitwith {
	if (random 1 < 0.5) then {
		
		hint "This person has no idea what you're talking about.";
		
	} else {
	
		hint "This person says they don't know anything about what you're asking.";
	
	};
};
if(count mps_civilian_intel == 0) exitwith {
	if (random 1 < 0.5) then {
		
		hint "This person has no idea what you're talking about.";
	
	} else {
	
		hint "This person says they don't know anything about what you're asking.";
	
	};
};

_person = (_this select 0);

if(!(_person getVariable ["mps_questioned",false])) then {

	if ((random 1) < 0.5) then {

		if ((random 1) < 0.5) then {

			_intel_loc = mps_civilian_intel call mps_getRandomElement;
			_intel_loc = (_intel_loc) call mps_get_position;

			_dirn = "NORTH"; if( ( position player select 1 ) > (_intel_loc select 1) ) then {_dirn = "SOUTH"};
			_dire = "EAST"; if( ( position player select 0 ) > (_intel_loc select 0) ) then {_dire = "WEST"};
			_distintel = ( position player ) distance2d _intel_loc;
			_dist = "not far away";
			
			if (_distintel < 300) then {_dist = "not far away from here.";};
			if (_distintel > 300 && _distintel < 800) then {if(random 1 < 0.5) then {_dist = "a few hundred metres away from here.";}else {"not very near."};};
			if (_distintel > 800) then {if(random 1 < 0.5) then {_dist = "far away.";}else {"more than a kilometer away."};};
			

			_intel = [
			format["This person is indicating to your map at Grid Ref: %1", mapGridPosition _intel_loc],

			format["This person is indicating your target is roughly %1 %2, %3",_dirn,_dire,_dist],
			format["This person is indicating your target is roughly %1, %2",_dirn,_dist],
			format["This person is indicating your target is roughly %1, %2",_dire,_dist],

			format["This person is indicating your target is roughly %1 %2, %3",_dirn,_dire,_dist],
			format["This person is indicating your target is roughly %1. They are not sure how far away.",_dirn],
			format["This person is indicating your target is roughly %1 and says it's probably not too far away from here.",_dire],

			format["This person is indicating roughly %1 %2",_dirn,_dire],
			format["This person is indicating roughly %1",_dirn],
			format["This person is indicating roughly %1",_dire]

			//format["This person is indicating roughly %1 %2",_dirn,_dire],
			//format["This person is indicating roughly %1",_dirn],
			//format["This person is indicating roughly %1",_dire]
			];

			_hint =  _intel call mps_getRandomElement;

			hint format["%1",_hint];
			
		} else {
			
			if (random 1 < 0.5) then {
			
				hint "This person has no idea what you're talking about.";
			
			} else {
			
				hint "This person says they don't know anything about what you're asking.";
			
			};
			
		};
		
		_person setVariable ["mps_questioned",true,true];

	} else {

		hint ([
					"This person is confused about what your asking",
					"This person is becoming frustrated due to the language barrier",
					"This person does not appear to understand what you're asking",
					"Yallah yallah ziyed move!!!",
					//"I... err... English... no... ehm...",
					"Leave me alone you infidels!",
					"The justice of Allah will soon rain fire upon all you imperialists!"        

					] call mps_getRandomElement);

	};

} else {

	hint "This person has already been questioned";

};