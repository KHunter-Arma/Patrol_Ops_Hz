// Written by BON_IF
// Adpated by EightySix

if(!(local player)) exitWith{};

_vehicle = _this select 0;
_boxloaded = _vehicle getVariable "vehicle_ammobox";

if(if(isNil "_boxloaded") then {true} else {not _boxloaded}) then{
		hint format["%1",localize "STR_Client_ammobox_none"];
} else {
	if(getPos _vehicle select 2 > 2 && getPos _vehicle select 2 < 160) exitWith {hint "Land or Climb >160m in order to drop ammobox."};

	if(getPos _vehicle select 2 < 3) then {
		if(abs (speed _vehicle) > 1) then {
			hint format["%1",localize "STR_Client_ammobox_fast"];
		} else {
			_vehiclerightside = (_vehicle modelToWorld [3,-2,0]); _vehiclerightside set [2,0];
			unloaded_ammobox = _vehiclerightside;
			_vehicle setVariable ["vehicle_ammobox",false,true];
		};
	} else {
		if(!mps_airdrop_enable) exitWith {hint "Airdrop Disabled. Land to unload ammobox.";};
		[_vehicle,mission_mobile_ammo] execVM (mps_path+"func\mps_func_ammobox_airdrop.sqf");
		_vehicle setVariable ["vehicle_ammobox",false,true];
	};

	WaitUntil{not isNil "unloaded_ammobox"};

	mps_create_ammobox = [side player,unloaded_ammobox]; publicVariable "mps_create_ammobox"; [unloaded_ammobox] spawn mps_ammobox;
	unloaded_ammobox = nil;
};

if(true) exitWith{};