#define JOINTOP_PILOT_CLASSES ["USMC_Soldier_Pilot"]
#define JOINTOP_ARMORED_CLASSES ["ACE_USMC_Soldier_Crew_D"]

_UID = getplayeruid player;
_unitType = "inf";

_restrictedVehTypes = ["Air","Tank","StaticMortar","StaticCannon"];

switch (true) do {

case ((_UID in "JOINTOP_ARTY")) : {_restrictedVehTypes = _restrictedVehTypes - ["StaticMortar","StaticCannon"];};
case ((_UID in "JOINTOP_ARMORED") && ((typeof player) in JOINTOP_ARMORED_CLASSES)) : {_restrictedVehTypes = _restrictedVehTypes - ["Tank"];};
case ((_UID in "JOINTOP_PILOT") && ((typeof player) in JOINTOP_PILOT_CLASSES)) : {_restrictedVehTypes = _restrictedVehTypes - ["Air"];};
default {};

};


while {true} do {
    
sleep 5;    

_veh = vehicle player;
_check = false;

{
    if(_veh iskindof _x) exitwith {_check = true;};

} foreach _restrictedVehTypes;

if (_check) then {
    
     if((player == (gunner _veh)) || (player == (commander _veh)) || (player == (driver _veh))) then {

     hint "You are not authorized to use this asset!";
     moveout player;
     sleep 0.1;
     player moveincargo _veh;

     };               
                
};

};