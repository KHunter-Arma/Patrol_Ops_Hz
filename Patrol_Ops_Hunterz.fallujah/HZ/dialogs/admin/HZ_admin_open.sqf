//#define playableunits switchableunits

private ["_players"];
disableSerialization;

CreateDialog "HZ_admin";

_players = playableunits;
{if(isplayer _x) then {_players set [count _players,_x]};}foreach alldead;
Hz_admin_player_UIDs = [];

//rank filter
_supervisorRank = Hz_pops_supervisor_ranks select (Hz_pops_restrictions_supervisorList find (getplayeruid player));
_temp = +_players;
{
	_index = Hz_pops_restrictions_supervisorList find (getplayeruid _x);
	
	if (_index != -1) then {
	
		_rank = Hz_pops_supervisor_ranks select _index;
		
		if (_rank >= _supervisorRank) then {_players = _players - [_x];};
	
	};

} foreach _temp;

//Fill in Listbox
{
    lbAdd[5133,name _x];
    Hz_admin_player_UIDs set [count Hz_admin_player_UIDs, getplayeruid _x];
    
} forEach _players;
    
Hz_admin_selected_UID = "0";

