// Written by EightySix

private["_obj","_veh","_range","_select"];

	_obj = _this select 0;
	_veh = _this select 1;

	_offset = [0,-1.8,1];
	_range  = [];
	_select = 0;
	
	if(_obj isKindof "Land_Misc_Cargo1A_EP1")	then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo1B")		then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo1B_EP1")	then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo1C")		then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo1C_EP1")	then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo1D")		then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo1D_EP1")	then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo1E")		then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo1E_EP1")	then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo1F")		then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo1G")		then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo2A_EP1")	then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo2B")		then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo2B_EP1")	then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo2C")		then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo2C_EP1")	then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo2D")		then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo2D_EP1")	then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo2E")		then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo2E_EP1")	then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Misc_Cargo1B_military")	then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-0.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Land_Misc_Cargo1E_EP1")	then { _range = [ [0,-1.9,1], [0,-0.5,1], [0,-1.8,1], [0,-1.8,1] ] };
	if(_obj isKindof "Misc_cargo_cont_tiny")	then { _range = [ [0,-1.7,0], [0,-0.5,0], [0,-0.8,0], [0,-1.3,0] ] };
	if(_obj isKindof "Misc_cargo_cont_net1")	then { _range = [ [0,-1.7,0], [0,-0.5,0], [0,-0.8,0], [0,-1.3,0] ] };
	if(_obj isKindof "Misc_cargo_cont_net3")	then { _range = [ [0,-1.7,1], [0,-0.5,1], [0,-1.0,1], [0,-1.3,1] ] };
	if(_obj isKindof "Misc_cargo_cont_small")	then { _range = [ [0,-1.0,1], [0,-0.2,1], [0,-0.2,1], [0,-1.0,1] ] };
	if(_obj isKindof "Misc_cargo_cont_small2")	then { _range = [ [0,-1.7,1], [0,-0.5,1], [0,-0.8,1], [0,-1.3,1] ] };
	if(_obj isKindof "Misc_cargo_cont_small_EP1")	then { _range = [ [0,-1.0,1], [0,-0.0,1], [0,-0.4,1], [0,-0.5,1] ] };

	if(_veh isKindof "MTVR")	then { _select = 0 };
	if(_veh isKindof "Kamaz_Base")	then { _select = 1 };
	if(_veh isKindof "Ural_Base")	then { _select = 2 };
	if(_veh isKindof "V3S_Base")	then { _select = 3 };
	
	

	if(count _range > 0) then {
		_offset = _range select _select;
	}else{ _offset = [0,-1.9,1] };

	if(_veh isKindof "ACE_Truck5tMGOpen")	then 
	{
		_offset = [0,-3.4,3.2];
	};
	
_offset;