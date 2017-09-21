			
                        
private ["_no","_ret"];
_ret = [];
_no = (positionCameraToWorld [0,0,0]) nearEntities [["Car","Tank","Air"], 80];
if (count _no > 0) then {
    
        {
                if (_x isKindOf "Tank" || {_x isKindOf "Wheeled_APC"}) then {
                        if (_x call ace_v_alive) then {_ret set [count _ret, _x]};
                } else {
                        if (!(_x isKindOf "ParachuteBase") && (!(_x isKindOf "StaticWeapon")) && (!(_x isKindOf "Ship")) && (!(_x isKindOf "BIS_Steerable_Parachute")) && (!(_x isKindOf "ATV_Base_EP1")) && (!(_x isKindOf "Motorcycle")) && (alive _x) && (!(_x getvariable ["Hz_vehicles_noRadioSound",false]))) then {
                                _ret set [count _ret, _x];
                        };
                };
        } forEach _no;
};
_ret