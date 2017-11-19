// Written by BON_IF
// Adapted by EightySix

if(!isServer) exitWith{};

_objects = _this;
_location = position (_objects select 0);



While{mps_mission_status == 1} do{sleep 60};
sleep 1800;
While{{isPlayer _x} count nearestObjects [_location,["Man","LandVehicle","Air"],2000] > 0} do {sleep 20};

{ if(vehicle _x != _x) then {deleteVehicle vehicle _x}; } foreach _objects;
sleep 1;
{ if(count units _x < 2) then {deleteGroup group _x}; deleteVehicle _x; } foreach _objects;
sleep 1;


