//#define DEBUG_MODE_FULL
#include "script_component.hpp"

PARAMS_1(_vehlist);

if (typeName _vehlist != "ARRAY") then { _vehlist = [_vehlist]; };
if ((count _vehlist == 0) && {(vehicle player != player)}) then {
	_vehlist = [vehicle player];
};

if ((_vehList select 0) getVariable [QGVAR(rearm_busy), false] && {((_vehList select 0) getVariable [QGVAR(rearm_busyState), 0]) >= time}) exitWith { hint "Busy already..." };

createDialog "ACE_DYNAMIC_RELOAD";
uiNamespace setVariable [QGVAR(vehlist),_vehlist];

lbClear GET_CTRL(66363);
{
	GET_CTRL(66363) lbAdd (getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName"));
	GET_CTRL(66363) lbSetData [(lbSize GET_CTRL(66363))-1,typeOf _x];
} forEach _vehlist;

GET_CTRL(66363) lbSetCurSel 0;
[] call FUNC(fill_turret_list);
