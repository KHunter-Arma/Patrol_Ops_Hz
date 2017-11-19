// Written by BON_IF
// Adapted by EightySix

if( isDedicated ) exitWith {};
if( mps_ace_wounds )  exitWith {};
if( if(isNil "ace_wounds_enabled" ) then {false}else{true} ) exitWith {};

if( isNil "mps_ais_factor" ) then {mps_ais_factor = 4;};

_unit = player;
mps_sys_injury = true;

"ais_in_agony" addPublicVariableEventHandler {
	_unit = (_this select 1) select 0;
	_in_agony = (_this select 1) select 1;
	_side = _unit getVariable "ais_side";
	if(playerSide == _side) then{
		if(_in_agony) then{
			[_side,"HQ"] sideChat format["%1 is down and needs help",name _unit];
			_fa_action = _unit addAction [format["<t color='#FF0000'>First Aid to %1</t>",name _unit],(mps_path+"action\mps_ais_firstaid.sqf"),_unit,10,false,true,"",
				"{not isNull (_target getVariable _x)} count ['healer','dragger'] == 0 && alive _target && vehicle _target == _target
			"];
			_drag_action = _unit addAction [format["<t color='#FFC600'>Drag %1</t>",name _unit],(mps_path+"action\mps_ais_drag.sqf"),_unit,10,false,true,"",
				"{not isNull (_target getVariable _x)} count ['healer','dragger'] == 0 && alive _target && vehicle _target == _target
			"];
			_unit setVariable ["fa_action",_fa_action,false];
			_unit setVariable ["drag_action",_drag_action,false];
			[_unit] execFSM (mps_path+"fsm\mps_ais_marker.fsm");
		} else {
			_unit removeAction (_unit getVariable "fa_action");
			_unit removeAction (_unit getVariable "drag_action");
			_unit setVariable ["fa_action",nil,false];
			_unit setVariable ["drag_action",nil,false];
		};
	};
};

_unit setVariable ["ais_headhit",0,false];
_unit setVariable ["ais_bodyhit",0,false];
_unit setVariable ["ais_overall",0,false];
_unit setVariable ["ais_unit_died",false,false];

/*
_unit setVariable ["ais_handledamage",compile (preprocessFileLineNumbers (mps_path+"func\mps_func_ais_handledamage.sqf")),false];
sleep 0.1; // precompilation time
_handledamage = _unit addEventHandler ["HandleDamage",{_this call ((_this select 0) getVariable "ais_handleDamage")}];
*/

//Testing alternative
	mps_ais_handledamage = compile preprocessFileLineNumbers (mps_path+"func\mps_func_ais_handledamage.sqf");
	_handledamage = _unit addEventHandler ["HandleDamage",{_this call mps_ais_handledamage}];

[_unit] execFSM (mps_path+"fsm\mps_ais_injury.fsm");