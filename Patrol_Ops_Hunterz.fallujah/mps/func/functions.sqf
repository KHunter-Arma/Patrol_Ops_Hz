/***********************************************************************************
************************************************************************************
       These are functions that spawn guns on roofs. Imported to Patrol Ops
by K.Hunter from ACE Insurgency, the fantastic work of Pogoman, Kol9yn and Fireball.
************************************************************************************
***********************************************************************************/



// find all valid houses which offer a certain minimum count of positions
findHouses = { 
	private ["_buildings","_minPositions","_enterables","_alive"];
	_buildings = nearestObjects [_this select 0, ["House","mesto3istan","istan202","istan2","istan2b","istan3hromada","hotel","istan3","istan4","istan4big","istan203","istan4detaily1","istan203a","istan204a","istan4biginverse"], _this select 1]; 
	_minPositions = (_this select 2) - 1;
	_alive = _this select 3;
	
	_enterables = []; 	
	{ 
		if (
			format["%1", _x buildingPos _minPositions] != "[0,0,0]" 
		&& EP1HOUSES 
		&& !(typeOf _x in ILLEGALHOUSES) && (alive _x || !_alive)
		) then { 
			_enterables set [count _enterables, _x]; 
		}; 
	} forEach _buildings; 
	_enterables
}; 

getGroup = { 
    private ["_side","_prefix","_name","_suffix"];
    _prefix = _this select 0; 
    _name   = _this select 1; 
    _suffix = _this select 2; 
	_side   = _this select 3;
	
	call compile format["
		if isNil ""%1%2%3"" exitWith { %1%2%3 = createGroup %4; %1%2%3 };
		if isNull %1%2%3 exitWith { %1%2%3 = createGroup %4; %1%2%3 }; 
		%1%2%3
	", _prefix, _name, _suffix, _side]; 
}; 


spawnAIGuns = {
    
        private ["_id","_gCount","_house","_houses"];
	_houses = [CENTERPOS,AORADIUS, 3, true] call findHouses; 	
	_gCount = gCount; 
	while{ _gCount < maxStaticGuns && count _houses > 0 && gunspawntimeroff} do{
                staticactive = true;
		_house = _houses select random(count _houses - 1); 
		_id	   = GUNROOFPOSITIONS find (typeOf _house); 
        if (_id != -1 && _house distance startLocation > 2000) then { 
			if (count nearestObjects[getPosATL _house, eastStationaryGuns, 50] == 0) then { 
				[_id, _house, _gCount] call createRoofGun;
				_gCount = _gCount + 1;
                                gCount = _gCount;
                                publicvariable "gCount";
			}; 
		}; 
		_houses = _houses - [_house];
                
                gunspawnindex = gunspawnindex + 1;
                
                if((gunspawnindex > maxStaticGuns) && gCount < maxStaticGuns) then {gunspawntimeroff = false; [] spawn {sleep 18000; gunspawntimeroff = true; [] call spawnAIGuns;};} else {staticactive = false;};     
                
		};
}; 

createRoofGun = { 	
	private ["_class","_housePositions","_id","_housePosition","_classId","_gun","_house","_dir","_grp","_gCount","_ai"]; 
	_id		= _this select 0;
	_house	= _this select 1;
	_gCount = _this select 2;
    
	_housePositions = GUNROOFPOSITIONS select (_id+1); 
	_housePosition  = (_housePositions select random (count _housePositions - 1)) select 0; 
	_classId        = (_housePositions select random (count _housePositions - 1)) select 1; 
	if (_classId <= 0.2) then { _class = stationaryGunsLow select random(count stationaryGunsLow - 1); }; 
	if (_classId > 0.2 && _classId < 0.5) then { _class = stationaryGunsMed select random(count stationaryGunsMed - 1); }; 
	if (_classId >= 0.5) then { _class = stationaryGunsHigh select random(count stationaryGunsHigh - 1); }; 
	_gun = createVehicle [_class, spawnPos, [], 0, "None"];
        gunsarr = gunsarr + [_gun];
	for "_j" from 0 to 10 do { _gun addMagazine (magazines _gun select 0); };
	_gun setPosATL (_house buildingPos _housePosition); 
	_dir = ((boundingCenter _house select 0) - (getPosATL _gun select 0)) atan2 ((boundingCenter _house select 1) - (getPosATL _gun select 1)); 
	_dir = (360 - _dir); 
	//_dir = ((getPosATL startLocation select 0) - (getPosATL _gun select 0)) atan2 ((getPosATL startLocation select 1) - (getPosATL _gun select 1)); 
	_gun setDir _dir;
	_grp = ["static","Grp",str _gCount,"east"] call getGroup; 
	_ai  = _grp createUnit [staticClass, [0,0,0], [], 0, "NONE"];
	_ai assignAsGunner _gun;
        _ai moveInGunner _gun;
        
        //Activate mortar script if gun is mortar
        if(_gun iskindof "2b14_82mm_TK_INS_EP1") then {_gun execVM "mortar\mortar.sqf";};
        
        //DEBUG
       // player setpos ([(getpos _ai select 0),(getpos _ai select 1),(getpos _ai select 2)+2]);
       // sleep 12;
        
	_grp setFormDir _dir;
	//if DEBUG then { [_house, _ai] call createDebugMarker; };  		
};









// Probe function
// A workaround for hasSurface
// Creates probe object at a given position, and checks to see if this position has solid ground (diff in height less than 1m) after simulation 


/*
RUFS_ProbeSurface = {
    private ["_pos", "_bball", "_probe", "_zi", "_zf", "_zdiff", "_vel", "_hasSurface"];
    _pos = _this select 0;
    _zi = _pos select 2;
    _bball = "Rabbit"; // our furry little friend
    _probe = _bball createVehicle _pos;
    _probe setpos _pos;
    _vel = -60;
    _probe setVelocity [0, 0 , -60]; // force the object to crash downward
    while {_vel > 0.1 && _vel < -0.1} do {
        _vel = velocity _probe select 2;
    };
    _zf = getposATL _probe select 2;
    _zdiff = _zi - _zf;
    // find difference in height
    if (_zdiff > 0.5 || _zdiff < -1) then {
        _hasSurface = false;
        hint "surface unsuitable";
    } else {
        _hasSurface = true;
        hint "surface suitable";
    };
    deletevehicle _probe;
    // output result
    _hasSurface
};
*/