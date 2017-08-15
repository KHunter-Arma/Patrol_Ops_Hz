

private ["_crate","_content","_count"];
_crate = _this select 0;

_content = getWeaponCargo _crate;
_count = count (_content select 1);

switch (true) do {
    
case (_count < 40) : {
hint parseText format ["<t color='#00CC00'>Crate is safe for saving</t>"];
};

case (_count < 60) : {
hint parseText format ["<t color='#FFFF00'>Crate is running out of space for safe saving!</t>"];
};

case (_count >= 60) : {
hint parseText format ["<t color='#FF0000'>Crate is not safe to save!</t>"];
};

default {hint "Unknown error"};

};