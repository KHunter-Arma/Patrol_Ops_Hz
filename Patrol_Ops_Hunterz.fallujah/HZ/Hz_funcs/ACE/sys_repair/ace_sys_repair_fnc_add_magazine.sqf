//#define DEBUG_MODE_FULL
#include "script_component.hpp"

#define HZ_ADDMAG_TIME 30

//Turret locality is an extremely weird case in Arma. Best is to execute all commands globally and hope that everything goes fine...

[] spawn {
	_veh = GET_SELECTED_VEHICLE;
	_magazine = GET_SELECTED_DATA(66368);
	_cap = [] call FUNC(get_capacity);
	_index_turret = GET_SELECTED_TURRET;
	
	TRACE_4("",_veh,_magazine,_cap,_index_turret);

	_repairTime = HZ_ADDMAG_TIME; // TODO
	_magCapacity = getNumber (configFile >> "CfgMagazines" >> _magazine >> "count");
	_ammo = gettext (configFile >> "CfgMagazines" >> _magazine >> "ammo");
	
    //    if (toupper _magazine == "SMOKELAUNCHERMAG") then {_cap = [_cap select 0, 3];};
        
	if (((_cap select 0) + _magCapacity) <= _cap select 1) then {
		
		if (_index_turret select 0 < 1) then {
				
				_muzzle = "";
				_magazine_not_compatible = true;
				{
					if (_magazine in getArray(configFile >> "CfgWeapons" >> _x >> "magazines")) then{
						_magazine_not_compatible = false;
						_muzzle = _x;
					};
				} forEach (weapons _veh);
				if (_magazine_not_compatible) then {
					{
						{
							if (_magazine_not_compatible && {_magazine in (getArray(configFile >> "CfgWeapons" >> _x >> "magazines"))}) then {
								_magazine_not_compatible = false;
                                                                ["Hz_econ_addVehicleWeapon", [_veh, _x]] call CBA_fnc_globalEvent;
								_muzzle = _x;
							};
						} forEach _x;
					} forEach CHANGABLE_WEAPONS;
				};
				
				_roundPrice = _ammo call Hz_econ_func_getAmmoPrice;
                                if (_roundPrice == -1) exitwith {hint "This type of munition is not in stock!";};
				_roundsInMag = _veh ammo _muzzle;
                                _newMag = false;
                                if(_roundsInMag == _magCapacity) then {_newMag = true; _roundsInMag = 0;};  
				_cost = _roundPrice * (_magCapacity - _roundsInMag);
				
				if(hz_funds < _cost) exitwith {hint "Insufficient funds!";};
				
				[QGVAR(setBusyRea), [_veh, _repairTime]] call CBA_fnc_globalEvent;

			{ __HIDE(_x); } foreach [66371,66372,66373];
			_veh setVariable ["ACE_PB_Result", 0];
			[10,[localize "STR_CFG_CUTSCENES_REARM"],true,false,_veh] spawn ace_progressbar;
			waitUntil { (_veh getVariable "ACE_PB_Result" != 0) };
			
			if (_veh getVariable "ACE_PB_Result" != 1) exitwith {};
				
				if(!_newMag) then {["Hz_econ_removeVehMagazine", [_veh, _magazine]] call CBA_fnc_globalEvent;}; // Remove empty ones first
				["Hz_econ_addVehMagazine", [_veh, _magazine]] call CBA_fnc_globalEvent;
				
				hint format ["Cost: $%1",_cost];
				hz_funds = hz_funds - _cost;
				publicvariable "hz_funds";
				

		} else {
		
		 /*
			_dummyveh = (typeof _veh) createvehicle [-20000,0,0];
			sleep 0.1;
                      
			_maxCount = {_x == _magazine} count (_dummyveh magazinesturret GET_SELECTED_TURRET);
			deletevehicle _dummyveh;
			_currCount = {_x == _magazine} count (_veh magazinesturret GET_SELECTED_TURRET);		                                                  
                       
			if(_currCount >= _maxCount) exitwith {hint "Already at maximum capacity with this type of munition";};
		     */
				_roundPrice = _ammo call Hz_econ_func_getAmmoPrice;
                                if (_roundPrice == -1) exitwith {hint "This type of munition is not in stock!";};
				_cost = _roundPrice * _magCapacity;
				
				if(hz_funds < _cost) exitwith {hint "Insufficient funds!";};
				
				[QGVAR(setBusyRea), [_veh, _repairTime]] call CBA_fnc_globalEvent;

			{ __HIDE(_x); } foreach [66371,66372,66373];
			_veh setVariable ["ACE_PB_Result", 0];
			[10,[localize "STR_CFG_CUTSCENES_REARM"],true,false,_veh] spawn ace_progressbar;
			waitUntil { (_veh getVariable "ACE_PB_Result" != 0) };
			
			if (_veh getVariable "ACE_PB_Result" != 1) exitwith {};
				
				TRACE_1("Adding magazine","");                                
				["Hz_econ_addMagazineTurret", [_veh, _magazine,GET_SELECTED_TURRET]] call CBA_fnc_globalEvent;
				
				hint format ["Cost: $%1",_cost];
				hz_funds = hz_funds - _cost;
				publicvariable "hz_funds";
				
		};
		
		[QGVAR(unsetBusyRea), _veh] call CBA_fnc_globalEvent;
			{ __SHOW(_x); } foreach [66371,66372,66373];
			
	};
	[] call FUNC(fill_current_magazines_list);
	//[_veh] call FUNC(fill_transportMagazines);
};