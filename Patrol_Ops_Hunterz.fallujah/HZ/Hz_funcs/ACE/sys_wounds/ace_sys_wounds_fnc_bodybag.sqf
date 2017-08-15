/* ace_sys_wounds(.pbo) - fnc_bodybag.sqf | (c) 2012, 2013 by rocko */

#include "script_component.hpp"

PARAMS_1(_body);

_pos = getPos _body;
_pos set [2, _body distance _pos];
_bodybag = "Body" createVehicle _pos;
_bodybag setDir (getDir _body);
_bodybag setPos _pos;
if (!isNil {_body getVariable QGVAR(deadbody_vname)}) then {
	_bodybag setVariable [QGVAR(deadbody_vname), _body getVariable QGVAR(deadbody_vname), true];
};

//Hunter: instead of delete we move to 0,0,0 to make sure we don't break functionality of some other dead-body dependant scripts
//deleteVehicle _body;
_body setpos [0,0,0];

player removeMagazine "ACE_Bodybag";

false