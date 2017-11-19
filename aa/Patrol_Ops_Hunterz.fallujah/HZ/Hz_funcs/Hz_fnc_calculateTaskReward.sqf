private ["_squadCount", "_additionalRewards", "_rewardMultiplier", "_deathPenalty"];

_squadCount = _this select 0;
_additionalRewards = _this select 1;
_rewardMultiplier = _this select 2;

hz_reward = ((Hz_econ_perSquadReward * _squadCount) + _additionalRewards + Hz_econ_aux_rewards);

_deathPenalty = (mps_mission_deathlimit - mps_mission_deathcount) * Hz_penalty_multiplier_per_death;

hz_reward = (hz_reward - _deathPenalty)*_rewardMultiplier;