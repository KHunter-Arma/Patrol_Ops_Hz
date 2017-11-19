// Written by BON_IF
// Adapted by EightySix

_unit = _this select 0;

_unit action ["eject",vehicle _unit];
sleep 2;

hint format["%1 %2 has been dismissed",getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayname"),name _unit];

deleteVehicle _unit;