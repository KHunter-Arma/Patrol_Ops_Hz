// Written by BON_IF
// Adpated by EightySix

_dragee = _this select 3;
_dragger = _this select 1;

if( isNull _dragee ) exitWith {};
if( _dragee distance _dragger > 2.5 || {not isNull (_dragee getVariable _x)} count ['healer','dragger'] > 0 ) exitWith{};

_dragger playMove "acinpknlmstpsraswrfldnon";

sleep 2;

_dragee attachTo [_dragger,[0.1, 1.01, 0]];
_dragee setVariable ["dragger",_dragger,true];

_dropaction = _dragger addAction [format["<t color='#FFC600'>Drop %1</t>",name _dragee], (mps_path+"action\mps_ais_drop.sqf"),_dragee, 0, false, true];

while { (_dragee getVariable "dragger" == _dragger) && (alive _dragger) /*&& alive _draggee*/ } do { sleep 1; };

detach _dragger;
detach _dragee;

_dragger playAction "released";
_dragee setVariable ["dragger",ObjNull,true];
_dragger removeAction _dropaction;

_dropaction = nil;

if(true) exitWith{};