// Written by BON_IF
// Adpated by EightySix


private ["_queuepos","_update_queue","_display","_listbox","_sel","_unittype","_typename","_queuecount","_spawnpos","_unit"];
if(isDedicated) exitWith{};
if((count (units group player) + count mps_recruit_queue) >= mps_group_maxsize) exitWith {hint "You've reached the max. allowed group size."};

if(!([]call Hz_func_isSupervisor)) exitwith {hint "You are not allowed to recruit AI";};

disableSerialization;

_update_queue = {
	
private ["_display","_queuelist"];
_display = findDisplay 86030;
	_queuelist = _display displayCtrl 86034;
	_queuelist ctrlSetText format["Units queued: %1",count mps_recruit_queue];
};

_display = findDisplay 86030;
_listbox = _display displayCtrl 86033;
_sel = lbCurSel _listbox; if(_sel < 0) exitWith{};

_unittype = mps_recruit_unittypes select _sel;
_typename = lbtext [86033,_sel];

_queuepos = 0;
_queuecount = count mps_recruit_queue;
if(_queuecount > 0) then {
	_queuepos = (mps_recruit_queue select (_queuecount - 1)) + 1;
	hint parseText format["<t size='1.0' font='Zeppelin33' color='#ef2525'>%1</t> added to queue.",_typename];
};
mps_recruit_queue = mps_recruit_queue + [_queuepos];

[] call _update_queue;

WaitUntil{_queuepos == mps_recruit_queue select 0};
sleep (1.5 * (_queuepos min 1));
hint parseText format["Processing your <t size='1.0' font='Zeppelin33' color='#ffd800'>%1</t>.",_typename];

if(!mps_debug) then { sleep (6 + random 3); };

_spawnpos = [getPos bon_recruit_barracks,random 360,2] call mps_new_position;

_unit = group player createUnit [_unittype, _spawnpos, [], 0, "FORM"];
_unit setRank "PRIVATE";
_unit setSkill 0.6;
_unit setskill ["aimingSpeed",1];
_unit setskill ["spotDistance",1];
_unit setskill ["spotTime",1];
_unit setskill ["commanding",1];

_unit addaction ["<t color=""#FF0000"">" + "DisableMove for this unit", {_unit = _this select 0; _unit disableai "move";},[],-5];

if (_unittype == "BAF_Soldier_Medic_DDPM") then {sleep 5;_unit removeweapon "ACE_Rucksack_MOLLE_WMARPAT_Medic"; sleep 2; _unit addweapon "ACE_Rucksack_MOLLE_DMARPAT_Medic";};
[_unit] execVM (mps_path+"func\mps_func_recruit_unit_init.sqf");

hint parseText format["Your <t size='1.0' font='Zeppelin33' color='#008aff'>%1</t> %2 has arrived.\n(Cost: $5000)",_typename,name _unit];
Hz_funds = Hz_funds - 5000;
publicvariable "Hz_funds";
mps_recruit_queue = mps_recruit_queue - [_queuepos];

[] call _update_queue;