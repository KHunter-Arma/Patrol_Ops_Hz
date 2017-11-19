// Written by Xeno
// Adpated by EightySix

private ["_vehicle","_caller","_id"];

_vehicle = _this select 0;
_caller = _this select 1;
_id = _this select 2;

if(!mps_airdrop_enable && getPos _vehicle select 2 > 20) then {hint "Airdrop Disabled. Lower the vehicle to the ground to unload."};
if(getPos _vehicle select 2 > 30 && getPos _vehicle select 2 < 170) exitWith {hint "Lower or Climb >170m in order to drop vehicle."};

if (_caller == driver _vehicle) then {
	_vehicle removeAction _id;
	Vehicle_Released = true;
};

if (true) exitWith {};
