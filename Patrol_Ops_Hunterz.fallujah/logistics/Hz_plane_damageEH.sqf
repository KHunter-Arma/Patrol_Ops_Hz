
private ["_plane","_damage","_return"];

_plane = _this select 0;

_damage = _this select 2;
_return = _damage;

if(_damage > 0.75) then {

   if (local _plane) then {
        
_plane setfuel 0;
_return = 0.75;

};

if (!(_plane getvariable ["Hz_plane_EH_captive_mutex",false])) then {

_plane addeventhandler ["GetOut",{(_this select 2) setcaptive false;}];
{_x setcaptive true;}foreach crew _plane;
if (local _plane) then {_plane setvariable ["Hz_plane_EH_captive_mutex",true,true];};
    
};


};

if(!local _plane) exitwith {};

_return