disableSerialization;

CreateDialog "HZ_fort_main";

[nil, 0] call HZ_fort_update_dialog;

//Fill in Listbox
{

	lbAdd [4133,gettext (configFile >> "cfgvehicles" >> _x >> "displayname")];

} forEach Hz_fort_fortificationList;
