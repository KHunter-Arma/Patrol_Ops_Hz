#include "vehicleRestrictions_default.sqf"
#include "weaponRestrictions_default.sqf"
#include "itemRestrictions_default.sqf"
#include "attachmentRestrictions_default.sqf"
#include "magazineRestrictions_default.sqf"
#include "variables.sqf"
#include "UID_Database.sqf"

Hz_econ_cfg_magazineRestrictions = [];
Hz_econ_cfg_vehicleRestrictions = [];
Hz_econ_cfg_weaponsRestrictions = [];
Hz_econ_cfg_attachmentRestrictions = [];
Hz_econ_cfg_itemRestrictions = [];
Hz_econ_cfg_variables = [];

private ["_path","_uid","_qualifications"];

_path = "\Hz_cfg\Hz_econ\qualifications\";

{
	_uid = _x select 0;
	_qualifications = _x select 1;
	
	wepInfo = +Hz_econ_cfg_weaponsRestrictions_default;
	attachmentsInfo = +Hz_econ_cfg_attachmentRestrictions_default;
	magazinesInfo = +Hz_econ_cfg_magazineRestrictions_default;
	itemsInfo = +Hz_econ_cfg_itemRestrictions_default;
	vehiclesInfo = +Hz_econ_cfg_vehicleRestrictions_default;
	variableInfo = +Hz_econ_cfg_variables_default;
	
	#include "whitelisted_defaults.sqf"
	
	{
	
		call compile preprocessFileLineNumbers (_path + _x + ".sqf");
	
	} foreach _qualifications;

	Hz_econ_cfg_magazineRestrictions pushback [_uid, magazinesInfo];
	Hz_econ_cfg_vehicleRestrictions pushback [_uid, vehiclesInfo];
	Hz_econ_cfg_weaponsRestrictions pushback [_uid, wepInfo];
	Hz_econ_cfg_attachmentRestrictions pushback [_uid, attachmentsInfo];
	Hz_econ_cfg_itemRestrictions pushback [_uid, itemsInfo];
	Hz_econ_cfg_variables pushback [_uid, variableInfo];

} foreach _UID_Database;