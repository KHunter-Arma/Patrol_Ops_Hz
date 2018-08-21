private _vehicle = _this select 0;

[_vehicle] call Hz_fnc_vehicleInit;

_vehicle setPlateNumber "B.A.D. PMC";

[_vehicle,["Killed",{

{_x setDamage 1} foreach ((_this select 0) getVariable ["R3F_LOG_objets_charges", []]);

}]] remoteExecCall ["addEventHandler",2,false];