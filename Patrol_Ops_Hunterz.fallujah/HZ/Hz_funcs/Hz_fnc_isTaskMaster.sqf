if (!Hz_enableHC || (HC_taskMasterName == "_SERVER_")) then {

	isServer

} else {

	(call Hz_fnc_isHC) && ((name player) == HC_taskMasterName)

}