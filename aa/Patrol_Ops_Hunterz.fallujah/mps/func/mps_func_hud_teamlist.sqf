// Written by Kochleffel
// Adapted by Code34
// Adapted by EightySix
/*
if (!local player) exitWith {};

private ["_crew","_text","_vehicle","_role","_name","_ctrl"];
disableSerialization;
uiNamespace setVariable ['crewdisplay', objnull];

while{isNil "mps_mission_finished"} do{
	if(isnull (uiNamespace getVariable "crewdisplay")) then { cutrsc ["infomessage", "PLAIN"];};
	if(vehicle player != player) then {
		if(!visibleMap) then{
			_crew = crew (vehicle player);
			_vehicle = vehicle player;
			_name= getText (configFile >> "CfgVehicles" >> (typeOf vehicle player) >> "DisplayName");
			_text= format ["<t size='1.35' shadow='2' color='#77c753'>%1</t><br/>", _name];
			{
				if(!(format["%1", name _x] == "") and !(format["%1", name _x] == "Error: No unit")) then {
					_role = assignedVehicleRole _x;
					switch(_x)do {
						case commander _vehicle: { _text=_text+format ["<t size='1.35' shadow='2' color='#77c753'>%1</t> <t size='1.5'><img image='"+mps_path+"media\icon_commander.paa'></t><br/>", name _x]; };
						case gunner _vehicle: { _text=_text+format ["<t size='1.35' shadow='2' color='#77c753'>%1</t> <t size='1.5'><img image='"+mps_path+"media\icon_gunner.paa'></t><br/>", name _x]; };
						case driver _vehicle: { _text=_text+format ["<t size='1.35' shadow='2' color='#77c753'>%1</t> <t size='1.5'><img image='"+mps_path+"media\icon_driver.paa'></t><br/>", name _x]; };
						default	{
							if(format["%1", (_role select 0)] != "Turret") then {
								_text=_text+format ["<t size='1.35' shadow='1' color='#567656'>%1</t> <t size='1.5'><img image='"+mps_path+"media\icon_cargo.paa'></t><br/>", name _x];
							} else {
								_text=_text+format ["<t size='1.35' shadow='2' color='#77c753'>%1</t> <t size='1.5'><img image='"+mps_path+"media\icon_gunner.paa'></t><br/>", name _x];
							};
						};
					};
				};
			} forEach _crew;
		}else{
			_text = "";
		};
	} else {
		if(mps_hud_active && !visibleMap) then{
			_text = "<t size='1.35' shadow='2' color='#77c753'>Team List<br/></t>";
			{	
				_rank = _x;
				{
					_color = "#77c753";
					if(!(format["%1", name _x] == "") and !(format["%1", name _x] == "Error: No unit")) then {
						if (damage _x >= 0.4 ) then {_color = "#FF4444";};
						If (!alive _x) then {_color = "#000000";};
						if ((rank _x == "Private") and _rank == "Private") then { _text=_text+format ["<t size='1.35' shadow='1' color='%2'>%1</t> <t size='1.5'><img image='\CA\warfare2\Images\rank_private.paa'></t><br/>", name _x,_color]; };
						if ((rank _x == "Corporal") and _rank == "Corporal") then { _text=_text+format ["<t size='1.35' shadow='1' color='%2'>%1</t> <t size='1.5'><img image='\CA\warfare2\Images\rank_corporal.paa'></t><br/>", name _x,_color]; };
						if ((rank _x == "Sergeant")  and _rank == "Sergeant") then { _text=_text+format ["<t size='1.35' shadow='1' color='%2'>%1</t> <t size='1.5'><img image='\CA\warfare2\Images\rank_sergeant.paa'></t><br/>", name _x,_color]; };
						if ((rank _x == "Lieutenant") and _rank == "Lieutenant") then { _text=_text+format ["<t size='1.35' shadow='1' color='%2'>%1</t> <t size='1.5'><img image='\CA\warfare2\Images\rank_lieutenant.paa'></t><br/>", name _x,_color]; };
						if ((rank _x == "Captain") and _rank == "Captain") then { _text=_text+format ["<t size='1.35' shadow='1' color='%2'>%1</t> <t size='1.5'><img image='\CA\warfare2\Images\rank_captain.paa'></t><br/>", name _x,_color]; };
						if ((rank _x == "Major") and _rank == "Major") then { _text=_text+format ["<t size='1.35' shadow='1' color='%2'>%1</t> <t size='1.5'><img image='\CA\warfare2\Images\rank_major.paa'></t><br/>", name _x,_color]; };
						if ((rank _x == "Colonel") and _rank == "Colonel") then { _text=_text+format ["<t size='1.35' shadow='1' color='%2'>%1</t> <t size='1.5'><img image='\CA\warfare2\Images\rank_colonel.paa'></t><br/>", name _x,_color];};
						sleep 0.001;
					};
				}foreach (units(player));
			} foreach ["Colonel", "Major", "Captain", "Lieutenant", "Sergeant", "Corporal", "Private"];
		}else{
			_text = "";
		};
	};
	_ctrl = (uiNamespace getVariable 'crewdisplay') displayCtrl 102;
	_ctrl ctrlSetStructuredText parseText _text;
	sleep 1;
};
	_text = "";
	_ctrl = (uiNamespace getVariable 'crewdisplay') displayCtrl 102;
	_ctrl ctrlSetStructuredText parseText _text;

*/