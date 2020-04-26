private _display = 0;

hz_reward = hz_reward*Hz_econ_globalTaskRewardMultiplier;

if(hz_reward >= 1000000) then {

	_display = format ["%1 million",(hz_reward / 1000000)];

} else {

	_display = hz_reward;

};

(format["We've earned $%1 for completing the mission!", _display]) remoteexeccall ["hint",0,false];

Hz_econ_funds = Hz_econ_funds + hz_reward;
publicvariable "Hz_econ_funds";