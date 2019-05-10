{

	if ((side _x) == civilian) exitwith {
		
		_this joinsilent (createGroup [SIDE_A select 0,true]);
				
	};

} foreach _this;