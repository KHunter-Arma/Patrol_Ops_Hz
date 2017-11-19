// Written by EightySix

private["_unit","_color","_distance"];

	_unit = _this select 0;

	_distance = round(player distance _unit);

	_color = "#77c753";
	if (damage _unit >= 0.5 ) then {_color = "#c75353";};
	if (!alive _unit) then {_color = "#000000";};

	if (rank _unit == "Private")	then { _text = format ["<t size='1'><img image='\CA\warfare2\Images\rank_private.paa'></t><br/><t size='1' shadow='1' color='%2'>%1 - %3m</t>", name _unit,_color,_distance]; };
	if (rank _unit == "Corporal")	then { _text = format ["<t size='1'><img image='\CA\warfare2\Images\rank_corporal.paa'></t><br/><t size='1' shadow='1' color='%2'>%1 - %3m</t>", name _unit,_color,_distance]; };
	if (rank _unit == "Sergeant")	then { _text = format ["<t size='1'><img image='\CA\warfare2\Images\rank_sergeant.paa'></t><br/><t size='1' shadow='1' color='%2'>%1 - %3m</t>", name _unit,_color,_distance]; };
	if (rank _unit == "Lieutenant")	then { _text = format ["<t size='1'><img image='\CA\warfare2\Images\rank_lieutenant.paa'></t><br/><t size='1' shadow='1' color='%2'>%1 - %3m</t>", name _unit,_color,_distance]; };
	if (rank _unit == "Captain")	then { _text = format ["<t size='1'><img image='\CA\warfare2\Images\rank_captain.paa'></t><br/><t size='1' shadow='1' color='%2'>%1 - %3m</t>", name _unit,_color,_distance]; };
	if (rank _unit == "Major")	then { _text = format ["<t size='1'><img image='\CA\warfare2\Images\rank_major.paa'></t><br/><t size='1' shadow='1' color='%2'>%1 - %3m</t>", name _unit,_color,_distance]; };
	if (rank _unit == "Colonel")	then { _text = format ["<t size='1'><img image='\CA\warfare2\Images\rank_colonel.paa'></t><br/><t size='1' shadow='1' color='%2'>%1 - %3m</t>", name _unit,_color,_distance]; };

_text;