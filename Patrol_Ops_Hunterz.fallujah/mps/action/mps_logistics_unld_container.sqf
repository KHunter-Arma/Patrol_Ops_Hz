// Written by EightySix

	_container = _this select 0;

	player playMove "ActsPercSnonWnonDnon_carFixing2";

	sleep 8;

	if(!alive player) exitWith{player playMoveNow "AmovPercMstpSlowWrflDnon"};

	_container setvariable ["mps_loadable",false,true];

if(true) exitWith{player playMoveNow "AmovPercMstpSlowWrflDnon"};