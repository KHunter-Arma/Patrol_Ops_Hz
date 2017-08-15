_vehicle = _this select 0;

_type = typeof _vehicle;

switch (_type) do {

case "C130J_US_EP1" : {
        
        _vehicle addaction ["<t color='#e6e600'>Open Passenger Door</t>","logistics\opendoor.sqf","",0,true,true,"","(driver  _target == _this || !(_this in crew _target)) && !(_target getvariable 'Door1_open')"];
        _vehicle addaction ["<t color='#e6e600'>Close Passenger Door</t>","logistics\closedoor.sqf","",0,true,true,"","(driver  _target == _this || !(_this in crew _target)) && (_target getvariable 'Door1_open')"];
        _vehicle addaction ["<t color='#e6e600'>Open Ramp</t>","logistics\openramps.sqf","",0,true,true,"","(driver  _target == _this || !(_this in crew _target)) && !(_target getvariable 'Ramp_open')"];
        _vehicle addaction ["<t color='#e6e600'>Close Ramp</t>","logistics\closeramps.sqf","",0,true,true,"","(driver  _target == _this || !(_this in crew _target)) && (_target getvariable 'Ramp_open')"];
        _vehicle addaction ["<t color='#e6e600'>Open Cargo Doors</t>","logistics\opencargodoors.sqf","",0,true,true,"(driver  _target == _this || !(_this in crew _target)) && !(_target getvariable 'Door2_open')"];
        _vehicle addaction ["<t color='#e6e600'>Close Cargo Doors</t>","logistics\closecargodoors.sqf","",0,true,true,"(driver  _target == _this || !(_this in crew _target)) && !(_target getvariable 'Door2_open')"];
        _vehicle addaction ["<t color='#ff0000'>Get ready for HALO Jump</t>","logistics\haloready.sqf","",0,true,true,"","driver  _target != _this"];
        _vehicle addaction ["<t color='#ff0000'>Cargo: Red Light on</t>","logistics\redlight.sqf","",0,true,true,"","(driver  _target == _this) && !(_target getvariable 'Redlight')"];
        _vehicle addaction ["<t color='#00ff00'>Cargo: Green Light</t>","logistics\greenlight.sqf","",0,true,true,"","(driver  _target == _this) && !(_target getvariable 'Greenlight')"];
        _vehicle addaction ["<t color='#ffffff'>Turn on cargo lights</t>","logistics\cargolights_on.sqf","",0,true,true,"","(driver  _target == _this) && !(_target getvariable 'Cargolight')"];
        _vehicle addaction ["<t color='#ffffff'>Turn off cargo lights</t>","logistics\cargolights_off.sqf","",0,true,true,"","(driver  _target == _this) && (_target getvariable 'Cargolight')"];
        _vehicle addaction ["<t color='#ffffff'>Cabin light on</t>","logistics\cabinlight_on.sqf","",0,true,true,"","(driver  _target == _this) && !(_target getvariable 'Cabinlight')"];
        _vehicle addaction ["<t color='#ffffff'>Cabin light off</t>","logistics\cabinlight_off.sqf","",0,true,true,"","(driver  _target == _this) && (_target getvariable 'Cabinlight')"];
                };
case "MV22" : {
        
        _vehicle addaction ["<t color='#e6e600'>Open Passenger Door</t>","logistics\opendoor.sqf","",0,true,true,"","(driver  _target == _this || !(_this in crew _target)) && !(_target getvariable 'Door1_open')"];
        _vehicle addaction ["<t color='#e6e600'>Close Passenger Door</t>","logistics\closedoor.sqf","",0,true,true,"","(driver  _target == _this || !(_this in crew _target)) && (_target getvariable 'Door1_open')"];   
        _vehicle addaction ["<t color='#e6e600'>Open Ramp</t>","logistics\openramps.sqf","",0,true,true,"","(driver  _target == _this || !(_this in crew _target)) && !(_target getvariable 'Ramp_open')"];
        _vehicle addaction ["<t color='#e6e600'>Close Ramp</t>","logistics\closeramps.sqf","",0,true,true,"","(driver  _target == _this || !(_this in crew _target)) && (_target getvariable 'Ramp_open')"];
        _vehicle addaction ["<t color='#ff0000'>Get ready for HALO Jump</t>","logistics\haloready.sqf","",0,true,true,"","driver  _target != _this"];
        
                    };
case "BAF_Merlin_HC3_D" : {
    
        _vehicle addaction ["<t color='#e6e600'>Open Left Door</t>","logistics\openmerlinleft.sqf","",0,true,true,"","(driver  _target == _this || !(_this in crew _target)) && !(_target getvariable 'Door1_open')"];
        _vehicle addaction ["<t color='#e6e600'>Close Left Door</t>","logistics\closemerlinleft.sqf","",0,true,true,"","(driver  _target == _this || !(_this in crew _target)) && (_target getvariable 'Door1_open')"];   
        _vehicle addaction ["<t color='#e6e600'>Open Right Door</t>","logistics\openmerlinright.sqf","",0,true,true,"","(driver  _target == _this || !(_this in crew _target)) && !(_target getvariable 'Door2_open')"];
        _vehicle addaction ["<t color='#e6e600'>Close Right Door</t>","logistics\closemerlinright.sqf","",0,true,true,"","(driver  _target == _this || !(_this in crew _target)) && (_target getvariable 'Door2_open')"];       
                
                    };

};
