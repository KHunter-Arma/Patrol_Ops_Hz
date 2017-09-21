// Written by BON_IF
// Adpated by EightySix

disableSerialization;

_display = findDisplay 86030;
_unitlist = _display displayCtrl 86033;
_queuelist = _display displayCtrl 86034;

_queuelist ctrlSetText format["Units queued: %1",count mps_recruit_queue ];


_weaponstring = "";
{
	_displname = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_picture = getText (configFile >> "CfgVehicles" >> _x >> "portrait");
	_weaponstring = format["%1",_displname,_picture];
	_unitlist lbAdd _weaponstring;
} foreach mps_recruit_unittypes;