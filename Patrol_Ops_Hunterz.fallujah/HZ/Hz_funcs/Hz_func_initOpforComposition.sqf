  private ["_return","_ins","_side","_isTank","_unitType","_dude","_objects"];
  
  _objects = _this select 0;
  _ins = false;
  _side = SIDE_B select 0;
  if ((count _this) > 1) then {_ins = _this select 1; _side = SIDE_C select 0;};
  
  _return = [];
  
  {//man vehicles & static guns

    if (_x iskindof "LandVehicle") then {
      
      _isTank = false;
      if (!(_x isKindOf "Car") && !(_x isKindOf "StaticWeapon")) then {
        _isTank = true;
      } else {
        if (_x isKindOf "Wheeled_APC") then {_isTank = true;};      
      };
      
      if ((_x emptyPositions "gunner") > 0) then {
        
        _unitType = "";
        if (_ins) then {
          _unitType = mps_opfor_ins_riflemen call bis_fnc_selectrandom;
        } else {        
          if (_isTank) then {
            _unitType = mps_opfor_crewmen call bis_fnc_selectrandom;
          } else {
            _unitType = mps_opfor_riflemen call bis_fnc_selectrandom;
          };        
        };
        
        _dude = (creategroup _side) createUnit [_unitType, getpos _x, [], 200, "NONE"];
        _dude assignasgunner _x;
        _dude moveingunner _x;
        
        _return set [count _return, _dude];
        
      };

      if ((_x emptyPositions "commander") > 0) then {
      
        _unitType = "";
        if (_ins) then {
          _unitType = mps_opfor_ins_riflemen call bis_fnc_selectrandom;
        } else {        
          if (_isTank) then {
            _unitType = mps_opfor_crewmen call bis_fnc_selectrandom;
          } else {
            _unitType = mps_opfor_riflemen call bis_fnc_selectrandom;
          };        
        };

        _dude = (creategroup _side) createUnit [_unitType, getpos _x, [], 200, "NONE"];
        _dude assignascommander _x;
        _dude moveincommander _x;
        
        _return set [count _return, _dude];
        
      };			
      
      if (!(_x isKindOf "StaticWeapon")) then {_x setvehiclelock "locked";};
      
    };

  }foreach _objects;
  
  _return