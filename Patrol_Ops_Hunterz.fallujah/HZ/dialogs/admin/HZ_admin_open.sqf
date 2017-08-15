//#define playableunits switchableunits

private ["_players"];
disableSerialization;

CreateDialog "HZ_admin";

_players = playableunits;
{if(isplayer _x) then {_players set [count _players,_x]};}foreach alldead;
Hz_admin_player_UIDs = [];

//Fill in Listbox
{
    lbAdd[5133,name _x];
    Hz_admin_player_UIDs set [count Hz_admin_player_UIDs, getplayeruid _x];
    
    } forEach _players;
    
Hz_admin_selected_UID = "0";

