if((isNil "mps_civilian_intel") || {count mps_civilian_intel == 0}) exitwith {
	hint selectRandom [
		"This person has no idea what you're talking about.",
		"This person says they don't know anything about what you're asking."
	];
};

private _person = _this select 0;

if(!(_person getVariable ["mps_questioned",false])) then {

	private _exit = switch (behaviour _person) do {
		case ("COMBAT") : {
			hint selectRandom [
				"Better to wait until things calm down a bit before questioning this person...",
				"This person seems too frightened to answer any questions right now."
				];
			true
		};
		default {
			false			
		};
	};
	
	if (_exit) exitWith {};
	
	doStop _person;
	[_person, player] remoteExecCall ["doWatch", _person, false];
	[_person, _person getDir player] remoteExecCall ["setDir", _person, false];
	[_person, "UP"] remoteExecCall ["setUnitPos", _person, false];
	
	if ((!captive _person) && {_person getVariable ["Hz_ambw_civ_isHostile", false]}) exitWith {
		
		hint selectRandom [
			"This person has no idea what you're talking about.",
			"This person says they don't know anything about what you're asking.",
			"This person is acting dismissive against you.",
			"This person gives you a bad look and looks away.",
			"This person is acting hostile towards you.",
			"This person looks at you afraid and doesn't seem to want to talk.",
			"This person is confused about what you're asking.",
			"This person is becoming frustrated due to the language barrier.",
			"This person does not appear to understand what you're asking.",
			"This person has no idea what you're talking about.",
			"This person says they don't know anything about what you're asking.",
			"""I'm sorry, I can't help you.""",
			"This person seems suspicious and unlikely to give you any information."
		];
		
		_person setVariable ["mps_questioned",true,true];
		
	};

	private _relationsFactor = Hz_ambw_srel_relationsCivilian/100;
	
	// chance a civilian wants to talk to you
	if ((random 1) < _relationsFactor) then {
	
		private _targetPositions = mps_civilian_intel apply {[(_x call mps_get_position) distance2D _person, _x]};
		_targetPositions sort true;
		private _intel = _targetPositions select 0;
		
		private _target = _intel select 1;
		private _distance = _intel select 0;
		private _distanceFactor = switch (true) do {
			case (_distance < 1000) : {1};
			case (_distance < 2000) : {0.8};
			case (_distance < 4000) : {0.6};
			case (_distance < 8000) : {0.4};
			default {0.2};
		};

		// chance a civilian understands the question (repeatable)
		if ((random 1) < 0.6) then {
			// chance a civilian knows something
			if ((random 1) < (0.8*_distanceFactor)) then {
				// chance a civilian will actually say what they know
				if ((random 1) < 0.65) then {
				
					private _nearestLocTarget = nearestLocation [_target, ["Name", "NameCity", "NameCityCapital", "NameLocal", "NameMarine", "NameVillage", "ViewPoint"]];
					private _nearestLoc = nearestLocation [_person, ["Name", "NameCity", "NameCityCapital", "NameLocal", "NameMarine", "NameVillage", "ViewPoint"]];
					
					if (_nearestLoc == _nearestLocTarget) then {
						
						if (_distance < 150) then {
							hint selectRandom [
								"""Some trucks passed by here earlier. It might have something to do with what you're looking for... They've been moving about all day.""",
								"""Yes! They've been harassing us all day and there's a lot of them around here. It must have to do with what you're looking for! But I don't know exactly where they're keeping them...""",
								"""They've recently come here. I don't know what they're up to or if it's related to what you're looking for, but things have been unusual around this area lately..."""
							];
						} else {
							[_person, _target] spawn {
								params ["_person", "_target"];
								sleep 1;
								if ((!alive _person) || {_person call Hz_fnc_isUncon}) exitWith {};
								[_person, _target] remoteExecCall ["doWatch", _person, false];
								sleep 1;
								if ((!alive _person) || {_person call Hz_fnc_isUncon}) exitWith {};
								[_person, _person getDir _target] remoteExecCall ["setDir", _person, false];
								[_person, "gesturePoint"] remoteExecCall ["playActionNow", _person, false];
								sleep 4;
								if ((!alive _person) || {_person call Hz_fnc_isUncon}) exitWith {};
								[_person, player] remoteExecCall ["doWatch", _person, false];
							};
							hint selectRandom [
								"""I heard some trucks passing by up there earlier. Maybe it's related to what you're looking for.""",
								"""They were mostly positioned a little up that way.""",
								"""You should probably go this way. I saw a bunch of them hanging around in that area before."""
							];
						};
						
					} else {
						hint format [selectRandom [
							"""I heard there was some troop movement today near %1. You might want to take a look around there.""",
							"""Yes, I saw some trucks driving around when I was in %1 earlier today. I don't know if it's related to what you're looking for though...""",
							"""People have been talking about some unusual military activity near %1. Maybe you can ask someone there? They might know better...""",
							"""My friend who lives near %1 told me he heard a lot of shooting and shouting near his home today, and he says it wasn't the result of the usual kind of fighting we've got used to around here... It might be worth taking a look over there.""",
							"""My friend told me he heard a lot of shooting and shouting near his home today, and he says it wasn't the result of the usual kind of fighting we've got used to around here... It might be worth taking a look over there. He lives near %1.""",
							"""I don't know if this will help you, but I came across some soldiers from the invasion forces today. It looked like they were exchanging something with the militia. Oh, right, this was in %1. I was there earlier. I don't know if they're still there though."""
						], text _nearestLocTarget];
					};
					
					_person setVariable ["mps_questioned",true,true];
					
				} else {
				
					hint selectRandom [
						"This person gives you frightened looks and says they don't know anything.",
						"""Look, I can't help you. They're watching...""",
						"This person seems suspicious and unlikely to give you any information."
						];
						
				};
				
				_person setVariable ["mps_questioned",true,true];

			} else {

				hint selectRandom [
							"This person has no idea what you're talking about.",
							"This person says they don't know anything about what you're asking.",
							"""I'm sorry, I can't help you."""
							];
							
			_person setVariable ["mps_questioned",true,true];

			};
			
		} else {
		
			hint selectRandom [
							"This person is confused about what you're asking.",
							"This person is becoming frustrated due to the language barrier.",
							"This person does not appear to understand what you're asking."
							];
		
		};
		
	} else {
	
		hint selectRandom [
							"This person is acting dismissive against you.",
							"This person gives you a bad look and looks away.",
							"This person is acting hostile towards you.",
							"This person looks at you afraid and doesn't seem to want to talk."
							];
							
		_person setVariable ["mps_questioned",true,true];
	
	};	

} else {

	hint "This person was already questioned";

};