// Written by *
// Adpated by EightySix

if(isNil {(_this select 0)}) exitWith{};
if(isNull (_this select 0)) exitWith{};
if(!mps_airdrop_enable) exitWith{};

player addRating 200;

FNC_SMOKE = {
	[_this select 0,[0.2,0.2,0.8,0]] spawn { // [0.45,0.67,0.5,0]
		_sh=_this select 0;
		_col=_this select 1;
		_c1=_col select 0;
		_c2=_col select 1;
		_c3=_col select 2;

		sleep (20+random 1);
		_source = "#particlesource" createVehicleLocal getpos _sh;
		_source setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48], "", "Billboard", 1, 20, [0, 0, 0],
						[0.2, 0.1, 0.1], 0, 1.277, 1, 0.025, [0.1, 2, 6], [[_c1, _c2, _c3, 0.2], [_c1, _c2, _c3, 0.05], [_c1, _c2, _c3, 0]],
						 [1.5,0.5], 1, 0.04, "", "", _sh];
		_source setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
		_source setDropInterval 0.50;

		_source2 = "#particlesource" createVehicleLocal getpos _sh;
		_source2 setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 12, 8, 0], "", "Billboard", 1, 20, [0, 0, 0],
						[0.2, 0.1, 0.1], 0, 1.277, 1, 0.025, [0.1, 2, 6], [[_c1, _c2, _c3, 1], [_c1, _c2, _c3, 0.5], [_c1, _c2, _c3, 0]],
						 [0.2], 1, 0.04, "", "", _sh];
		_source2 setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.2], 0, 0, 360];
		_source2 setDropInterval 0.50;

		sleep (50+random 5);
		deletevehicle _source;
	};
};

private ["_side","_paraSize","_paraName","_paraPos","_dropPos","_dropHeight","_pos","_classNameToDrop","_cargoPos","_cargoRelPos","_crate","_para"];

_crate = _this select 0;
_classNameToDrop = _this select 1;

_paraSize = 1;
_paraName = "";

if (_classNameToDrop == "land") then {
	_paraSize = 2; //big chute
	_classNameToDrop = "HMMWV_M2"; //HMMWV
	if (side player == east) then {_classNameToDrop = "UAZ_MG_INS"};
	if (side player == resistance) then {_classNameToDrop = "UAZ_MG_INS"};
};

switch (_paraSize) do {
	_side = side player;
	if (!(_side in ["East","West"])) then {_side = "West";};
	case 0: {_paraName = format["Parachute%1_EP1",_side],;};
	case 1: {_paraName = format["ParachuteMedium%1_EP1",_side];};
	case 2: {_paraName = format["ParachuteBig%1_EP1",_side];};
	default {_paraName = format["ParachuteMedium%1_EP1",_side];};
};

_pos = [(position player) select 0,(position player) select 1,((position player) select 2) - 15];
_crate setVelocity [(((velocity player) select 0) / 2),(((velocity player) select 1) / 2),((velocity player) select 2)-25];

sleep 1;

_pos = [(position _crate) select 0,(position _crate) select 1,(position _crate) select 2];

_cargoRelPos = [0,0,0];
_cargoPos = [(_pos select 0) + (_cargoRelPos select 0), (_pos select 1) + (_cargoRelPos select 1), (_pos select 2) + (_cargoRelPos select 2)];
_crate setVelocity [(((velocity player) select 0) / 2),(((velocity player) select 1) / 2),((velocity player) select 2)-25];
_crate setDir (direction _crate);

sleep 1;

_paraPos = [(_pos select 0) + (_cargoRelPos select 0), (_pos select 1) + (_cargoRelPos select 1), (_pos select 2) + (_cargoRelPos select 2)];

_para = createvehicle [_paraName, _paraPos ,[],0,"NONE"];
_para setDir (direction _crate);
_para setVelocity [((velocity _crate) select 0),((velocity _crate) select 1) ,((velocity _crate) select 2) ];

_crate attachTo [_para,[0,0,0],"paraEnd"];
_smoke = "SmokeShellBlue" createvehicle position _crate;
_smoke attachTo [_crate,[0,0,2]];

sleep 1.0;

[_crate, _para] spawn {
	_crate = _this select 0;
	_para = _this select 1;

	private ["_groundHitPos"];
	_groundHitPos = [1000,10,0];

	WaitUntil { ((((position _crate) select 2) < 1) || (isNil "_para")) };
	detach _crate;
	_crate SetVelocity [0,0,-5];

	sleep 0.3;

};