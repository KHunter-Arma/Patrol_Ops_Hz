private _person = _this select 0;

if(!(_person getVariable ["mps_questioned_relations",false])) then {
	
		private _exit = switch (stance _person) do {
		case ("STAND") : {false};
		case ("UNDEFINED") : {
			hint "It's probably not a good idea to question this person in this state...";
			true
		};
		default {
			hint selectRandom [
				"Better to wait until things calm down a bit before questioning this person...",
				"This person seems too frightened to answer any questions right now."
				];
			true
		};
	};
	
	if (_exit) exitWith {};
	
	doStop _person;
	[_person, player] remoteExecCall ["doWatch", _person, false];
	
	private _relationsFactor = Hz_ambw_srel_relationsCivilian/100;
	
	// chance a civilian wants to talk to you
	if ((random 1) < _relationsFactor) then {

		// chance a civilian understands the question (repeatable)
		if ((random 1) < 0.6) then {
			// chance a civilian is able to answer the question
			if ((random 1) < 0.95) then {
				// chance a civilian will actually say what they think
				if ((random 1) < 0.65) then {
					
					switch (true) do {
						case (Hz_ambw_srel_relationsCivilian > 134) : {
							hint selectRandom [
								"""We are really grateful for your help! We would be doomed without you!""",
								"""Everyone loves you around here. You guys give us confidence we will win this war!"""
							];
						};
						case (Hz_ambw_srel_relationsCivilian > 109) : {
							hint selectRandom [
								"""What you're doing is helping the people. I think most people would agree with me...""",
								"""You're really making a difference around here. Some people disagree but they're just stupid..."""
							];
						};
						case (Hz_ambw_srel_relationsCivilian > 89) : {
							hint selectRandom [
								"""Well, I guess you guys are ok...""",
								"""I don't really have anything to complain about. Whatever will help us win this war..."""
							];
						};
						case (Hz_ambw_srel_relationsCivilian > 69) : {
							hint selectRandom [
								"""Look, I know mistakes were made but most people are suspicious of you people.""",
								"""You're asking me? Well, I don't trust you. Is that enough of an answer?""",
								"""Some people say some nasty things about you people, but I really don't know what to think... I don't really care."""
							];
						};
						case (Hz_ambw_srel_relationsCivilian > 49) : {
							hint selectRandom [
								"""You don't give a shit about us and we know that...""",
								"""You're all the same... And you think you're helping us or something right?""",
								"""I would watch my back around here, if you know what I mean...""",
								"""Look I'm just trying to survive out here with my family. Please leave me alone!""",
								"This person is acting dismissive against you.",
								"This person looks at you afraid and doesn't seem to want to talk."
							];
						};
						default {
							hint selectRandom [
								"""Hahahaha... You can all burn in hell!""",
								"""Just leave us alone, please...""",
								"""Look I'm just trying to survive out here with my family. Please leave me alone!""",
								"This person is acting dismissive against you.",
								"This person gives you a bad look and looks away.",
								"This person is acting hostile towards you.",
								"This person looks at you afraid and doesn't seem to want to talk.",
								"""You can all burn in hell if you ask me!""",
								"""You're no better than the invaders!""",
								"""You're worse than the invading army!""",
								"""The justice of God will surely have you suffer for your acts!""",
								"""Look, what do you want from me? Please... don't hurt my family!""",
								"""And you still have the nerve to ask? Please, just leave us in peace..."""
							];
						};
					};
					
					_person setVariable ["mps_questioned_relations",true,true];
					
				} else {
				
					hint selectRandom [
						"This person gives you frightened looks and says they don't want to answer.",
						"""Look, I can't help you. They're watching...""",
						"This person seems suspicious and unlikely to give you an answer."
						];
						
				};
				
				_person setVariable ["mps_questioned_relations",true,true];

			} else {

				hint selectRandom [
							"This person has no idea what you're talking about.",
							"""I'm sorry, I can't help you."""
							];
							
			_person setVariable ["mps_questioned_relations",true,true];

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
							"This person looks at you afraid and doesn't seem to want to talk.",
							"""You can all burn in hell if you ask me!""",
							"""You're no better than the invaders!""",
							"""You're worse than the invading army!""",
							"""The justice of God will surely have you suffer for your acts!""",
							"""Look, what do you want from me? Please... don't hurt my family!""",
							"""And you still have the nerve to ask? Please, just leave us in peace..."""
							];
		
		_person setVariable ["mps_questioned_relations",true,true];
	
	};	

} else {

	hint "This person was already questioned";

};