// Written by *
// Adapted by EightySix

if (isNil {(_this select 0)}) exitWith {};
if (isNull (_this select 0)) exitWith {};
if(!mps_airdrop_enable) exitWith {hint "Airdrop Disabled, Please Land to Unload"};

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

private ["_side","_paraSize","_paraName","_paraPos","_veh","_dropPos","_dropHeight","_pos","_classNameToDrop","_classNameToDropOrig","_cargoPos","_cargoRelPos","_crate","_para"];

_paraSize = 1;

_veh = _this select 0;
_dropPos = position (_this select 0);
sleep 0.02;

if (count _this < 1) then {_classNameToDrop = "land";} else {_classNameToDrop = _this select 1;};

_classNameToDropOrig = _classNameToDrop;
if (_classNameToDrop == "reammobox") then {
	_classNameToDrop = mission_base_ammobox;
};

if (_classNameToDrop == "land") then {		
	_paraSize = 2; //big chute
	_classNameToDrop = "HMMWV_M2"; //HMMWV
	if (side player == east) then {_classNameToDrop = "UAZ_MG_INS"};
	if (side player == resistance) then {_classNameToDrop = "UAZ_MG_INS"};
};

_paraName = "";
switch (_paraSize) do {
	_side = side player;
	if (!(_side in ["East","West"])) then {_side = "West";};
	case 0: {_paraName = format["Parachute%1_EP1",_side],;};
	case 1: {_paraName = format["ParachuteMedium%1_EP1",_side];};
	case 2: {_paraName = format["ParachuteBig%1_EP1",_side];};
	default {textLogFormat ["DROP_ ERROR: Wrong _paraSize"];};
};

_pos = [(_dropPos select 0), (_dropPos select 1), (_dropPos select 2) - 30];

textLogFormat["DROP_ side %1 para %2 size %3",_side,_para, _paraSize];	 

_cargoRelPos = [0,0,0];
_cargoPos = [(_pos select 0) + (_cargoRelPos select 0), (_pos select 1) + (_cargoRelPos select 1), (_pos select 2) + (_cargoRelPos select 2)];

_crate = createvehicle [_classNameToDrop,_cargoPos,[],0,"NONE"];	
_crate setVelocity [(((velocity _veh) select 0) / 2),(((velocity _veh) select 1) / 2),((velocity _veh) select 2)-25];
_crate setDir (direction _veh);

textLogFormat["SUPPLYDROP_ Pos cargoRelPos _cargoPos actpos %1",[_pos,_cargoRelPos, _cargoPos, position _crate]];

if (_classNameToDropOrig != "reammobox") then {
	sleep 0.7;
}else{
	[_crate] call FNC_SMOKE;
};

_cratePos = position _crate;

if ((_cratePos select 2)< 0) then {_cratePos = _cargoPos;};
_pos = _cratePos;

_paraPos = [(_pos select 0) + (_cargoRelPos select 0), (_pos select 1) + (_cargoRelPos select 1), (_pos select 2) + (_cargoRelPos select 2)];
_para = createvehicle [_paraName, _paraPos ,[],0,"NONE"];
_para setDir (direction _veh);
_para setVelocity [((velocity _crate) select 0),((velocity _crate) select 1) ,((velocity _crate) select 2) ];

_crate attachTo [_para,[0,0,0],"paraEnd"];
_smoke = "SmokeShellGreen" createvehicle position _crate;
_smoke attachTo [_crate,[0,0,2]];

textLogFormat["DROP_	-> pos %1 %2",position _para,_classNameToDrop];

sleep 1.0;

[_crate, _para,_classNameToDrop] spawn {
	_crate = _this select 0;
	_para = _this select 1;
	_classNameToDrop = _this select 2;

	private ["_groundHitPos"];
	_groundHitPos = [1000,10,0];
	if ((_crate isKindOf "ReammoBox")) then {
		WaitUntil {if (!isNil "_para") then {_groundHitPos = position _para}; groundHitPos = _groundHitPos; textLogFormat ["SUPPLYD ROP_ crate flying down: %1", ((position _crate) select 2)]; (((((position _crate) select 2) < 0.1) && (((position _crate) select 2) >= 0.0)) || ((position _para) select 2 < 3)	|| (isNil "_para"))};
		detach _crate; 
		textLogFormat ["SUPPLYD ROP_ ground hit: %1", ((position _crate) select 2)];

		private ["_crateDir"];
		_crateDir = direction _crate;
		deleteVehicle _crate;

		unloaded_ammobox = [_groundHitPos select 0, _groundHitPos select 1, 0];

//		_crate = createvehicle [_classNameToDrop,[_groundHitPos select 0, _groundHitPos select 1, 0.0],[],0,"NONE"];		
//		_crate setDir _crateDir;
//		_crate addEventHandler ["Killed",{(_this select 0) spawn {sleep 60; deleteVehicle _this}}];
//		crateDebug = _crate;
//		deleteVehicle _crate;
	} else {
		WaitUntil {textLogFormat ["SUPPLYD ROP_ crate flying down: %1", ((position _crate) select 2)];((((position _crate) select 2) < 0.6) || (isNil "_para"))};
		detach _crate;
		_crate SetVelocity [0,0,-5];					 
		textLogFormat ["SUPPLYD ROP_ ground hit: %1", ((position _crate) select 2)];
		sleep 0.3;
		_crate setPos [(position _crate) select 0, (position _crate) select 1, 0.6];
	};
};

textLogFormat ["SUPPLYDROP_ on ground: %1", ((position _crate) select 2)];