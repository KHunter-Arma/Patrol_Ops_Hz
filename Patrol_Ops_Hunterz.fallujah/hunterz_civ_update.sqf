_trigger = _this select 0;
_civarray = _this select 1;
_safeactivation = _this select 2;

switch (_trigger) do {

case h_civ_trigger_0: { h_civarray_0 = _civarray; h_civsafe_0 = _safeactivation;};
case h_civ_trigger_1: { h_civarray_1 = _civarray; h_civsafe_1 = _safeactivation;};
case h_civ_trigger_2: { h_civarray_2 = _civarray; h_civsafe_2 = _safeactivation;};
case h_civ_trigger_3: { h_civarray_3 = _civarray; h_civsafe_3 = _safeactivation;};
case h_civ_trigger_4: { h_civarray_4 = _civarray; h_civsafe_4 = _safeactivation;};
case h_civ_trigger_5: { h_civarray_5 = _civarray; h_civsafe_5 = _safeactivation;};
case h_civ_trigger_6: { h_civarray_6 = _civarray; h_civsafe_6 = _safeactivation;};
case h_civ_trigger_7: { h_civarray_7 = _civarray; h_civsafe_7 = _safeactivation;};
case h_civ_trigger_8: { h_civarray_8 = _civarray; h_civsafe_8 = _safeactivation;};
case h_civ_trigger_9: { h_civarray_9 = _civarray; h_civsafe_9 = _safeactivation;};
case h_civ_trigger_10: { h_civarray_10 = _civarray; h_civsafe_10 = _safeactivation;};
case h_civ_trigger_11: { h_civarray_11 = _civarray; h_civsafe_11 = _safeactivation;};
case h_civ_trigger_12: { h_civarray_12 = _civarray; h_civsafe_12 = _safeactivation;};
case h_civ_trigger_13: { h_civarray_13 = _civarray; h_civsafe_13 = _safeactivation;};
case h_civ_trigger_14: { h_civarray_14 = _civarray; h_civsafe_14 = _safeactivation;};
case h_civ_trigger_15: { h_civarray_15 = _civarray; h_civsafe_15 = _safeactivation;};
case h_civ_trigger_16: { h_civarray_16 = _civarray; h_civsafe_16 = _safeactivation;};
case h_civ_trigger_17: { h_civarray_17 = _civarray; h_civsafe_17 = _safeactivation;};
case h_civ_trigger_18: { h_civarray_18 = _civarray; h_civsafe_18 = _safeactivation;};
case h_civ_trigger_19: { h_civarray_19 = _civarray; h_civsafe_19 = _safeactivation;};
case h_civ_trigger_20: { h_civarray_20 = _civarray; h_civsafe_20 = _safeactivation;};
case h_civ_trigger_21: { h_civarray_21 = _civarray; h_civsafe_21 = _safeactivation;};
case h_civ_trigger_22: { h_civarray_22 = _civarray; h_civsafe_22 = _safeactivation;};
case h_civ_trigger_23: { h_civarray_23 = _civarray; h_civsafe_23 = _safeactivation;};
case h_civ_trigger_24: { h_civarray_24 = _civarray; h_civsafe_24 = _safeactivation;};
case h_civ_trigger_25: { h_civarray_25 = _civarray; h_civsafe_25 = _safeactivation;};
case h_civ_trigger_26: { h_civarray_26 = _civarray; h_civsafe_26 = _safeactivation;};
case h_civ_trigger_27: { h_civarray_27 = _civarray; h_civsafe_27 = _safeactivation;};
case h_civ_trigger_28: { h_civarray_28 = _civarray; h_civsafe_28 = _safeactivation;};
case h_civ_trigger_29: { h_civarray_29 = _civarray; h_civsafe_29 = _safeactivation;};
case h_civ_trigger_30: { h_civarray_30 = _civarray; h_civsafe_30 = _safeactivation;};

default {hint "Hunter'z Civilian Script error. Failed to update variables. Check trigger names.";};

};

//if (civ_debug) then {sleep 4; [-1, {hint "Vars updated";}] call CBA_fnc_globalExecute;};