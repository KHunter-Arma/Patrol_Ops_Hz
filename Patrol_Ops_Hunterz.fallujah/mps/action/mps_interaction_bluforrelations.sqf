private _person = _this select 0;

if(!(_person getVariable ["mps_questioned_relations",false])) then {
	
	private _relationsFactor = Hz_ambw_srel_relationsOwnSide/100;
	
	// chance the dude wants to talk to you
	if ((random 1) < _relationsFactor) then {

			switch (true) do {
				case (Hz_ambw_srel_relationsOwnSide > 134) : {
					hint selectRandom [
						"""Well I'll be damned. I never expected this kind of performance from you folks.""",
						"""You even make an Airforce man proud. That's a hell of an achievement."""
					];
				};
				case (Hz_ambw_srel_relationsOwnSide > 109) : {
					hint selectRandom [
						"""Your work has helped American interests in the region. We appreciate it.""",
						"""You've been doing alright. Keep that up and we might see those sorry jokers leave this country with their buttcheeks clenched soon."""
					];
				};
				case (Hz_ambw_srel_relationsOwnSide > 89) : {
					hint selectRandom [
						"""A US Marine is worth more than 10 of you put together, but I guess you've done alright...""",
						"""I still don't know why the hell we're not bombing those jokers to hell, but since we can't, I guess y'all are doing ok..."""
					];
				};
				case (Hz_ambw_srel_relationsOwnSide > 69) : {
					hint selectRandom [
						"""Y'all have made more mistakes than the US Airforce... hahahh""",
						"""Well, y'all are better than an army of scarecrows, I'll give you that much...""",
						"""Oh, you're still alive? I'm surprised given how incompetent you folks are..."""
					];
				};
				case (Hz_ambw_srel_relationsOwnSide > 49) : {
					hint selectRandom [
						"""Hah! You guys are even more useless than the Iraqis!... Oh, oops, no offence Ahmed...""",
						"""How about you get out of my face?""",
						"""We don't like your kind around here. That enough of an answer?"""
					];
				};
				default {
					hint selectRandom [
						"This guy is acting dismissive against you.",
						"This guy gives you a bad look and looks away to ignore you.",
						"""If it were up to me I'd have all your sorry asses shot..."""
					];
				};
			};
							
		_person setVariable ["mps_questioned_relations",true,true];
		
	} else {
	
		hint selectRandom [
							"This guy is acting dismissive against you.",
							"This guy gives you a bad look and looks away to ignore you.",
							"""If it were up to me I'd have all your sorry asses shot..."""
							];
		
		_person setVariable ["mps_questioned_relations",true,true];
	
	};	

} else {

	hint selectRandom [
		"""That's all I can tell you. Now if you'll excuse us...""",
		"""I'm trying to have a conversation here...""",
		"""What? Don't you have anything else to do?""",
		"""Shouldn't you be doing some work for us right about now?"""
		];

};