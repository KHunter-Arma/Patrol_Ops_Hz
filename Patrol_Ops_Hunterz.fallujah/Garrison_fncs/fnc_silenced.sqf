_firer = _this select 0;
_weapon = _this select 1;
_ammo = gettext (configfile >> "cfgmagazines" >> (currentmagazine _firer) >> "ammo");
_loudness = getnumber (configfile >> "cfgammo" >> _ammo >> "audiblefire");
if (_loudness < 1) then {_loudness = (_loudness * 20)};

_loudness