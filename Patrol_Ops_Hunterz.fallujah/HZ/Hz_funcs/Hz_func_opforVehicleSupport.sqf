
private ["_INS","_vehicletype","_otherReward","_fate","_CASchance","_TankChance","_IFVchance","_AAchance","_CarChance"];
_CASchance = _this select 0;
_TankChance = _this select 1;
_IFVchance = _this select 2;
_AAchance = _this select 3;
_CarChance = _this select 4;                
_INS = false;

if((count _this) > 5) then {

	if ((_this select 5) == "INS") then {
	
		_INS = true;
	
	};	

};
     
     
_vehicletype = [];
_otherReward = 0;

if(!_INS) then{
    
_fate = random 1;
if(_fate <= _CASchance) then {_vehicletype = mps_opfor_atkp + mps_opfor_atkh; _otherReward = _otherReward + Hz_econ_CAS_reward;} else {
_fate = random 1; 
if(_fate <= _TankChance) then {_vehicletype = mps_opfor_armor; _otherReward = _otherReward + Hz_econ_Tank_reward;} else {
_fate = random 1; 
if(_fate <= _IFVchance) then {_vehicletype = mps_opfor_apc; _otherReward = _otherReward + Hz_econ_IFV_reward;} else {
_fate = random 1; 
if(_fate <= _AAchance) then {_vehicletype = mps_opfor_aa; _otherReward = _otherReward + Hz_econ_AA_reward;} else {
_fate = random 1; 
if(_fate <= _CarChance) then {_vehicletype = mps_opfor_car; _otherReward = _otherReward + Hz_econ_Car_reward;} else {

};};};};};

} else {

_fate = random 1; 
if(_fate <= _CarChance) then {_vehicletype = mps_opfor_ins_car; _otherReward = _otherReward + Hz_econ_Car_reward;};
    
};


[_vehicletype, _otherReward]