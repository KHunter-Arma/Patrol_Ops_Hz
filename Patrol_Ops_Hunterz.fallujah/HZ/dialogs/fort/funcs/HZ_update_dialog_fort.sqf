private ["_display","_element","_pic"];
_element = _this select 1;
disableSerialization;

_display = format ["Available funds: $%1",Hz_econ_funds];
if(Hz_econ_funds >= 1000000) then {
	_display = format ["Available funds: $%1 million",(Hz_econ_funds / 1000000)];
};
ctrlSetText [4136, _display];

hz_fort_selected = Hz_fort_fortificationList select _element;
hz_fort_cost = hz_fort_selected call Hz_fort_getObjectCost;

_display = format ["Item Cost: $%1",hz_fort_cost];
if(hz_fort_cost >= 1000000) then {
	_display = format ["Item Cost: $%1 million",(hz_fort_cost / 1000000)];	
};
ctrlSetText [4135, _display];

_pic = gettext (configfile >> "cfgVehicles" >> hz_fort_selected >> "EditorPreview");

if (_pic == "\A3\EditorPreviews_F\Data\CfgVehicles\Default\Prop.jpg") then {

	_pic = gettext (configfile >> "cfgVehicles" >> hz_fort_selected >> "picture");

	if(_pic == "pictureStaticObject") then {_pic = gettext (configfile >> "cfgVehicles" >> hz_fort_selected >> "icon");};

};
ctrlSetText [4134,_pic];