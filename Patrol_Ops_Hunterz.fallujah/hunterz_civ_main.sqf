/*
!!!!Execute upon both activation and deactivation!!!!
*/

//If trigger will stay switched on for an extended period of time, might need an external script to monitor if all civs are still alive and update civtotal.

#define SAFE_DISTANCE_FOR_SPAWN 300
#define CIV_KILLED_COUNT_BEFORE_RAGE 5000 //deprecated for now so keep it too high

//#define playableunits switchableunits

if (civ_debug) exitWith {_this spawn Hz_spawncivs;};

private ["_ForceSpawnAtHouses","_numinput","_mutex","_exit","_civarray","_num","_count","_newcivarray","_roadarr","_client","_civtype","_group","_civ","_road","_spawnpos","_buildings","_wait","_group1","_group2","_group3","_civgroups","_killcivs","_trigger","_pos","_radius","_ownerIDs"];

if (civ_debug) then {hint "inside main script";};

_trigger = _this select 0;
_pos = getpos _trigger;
_radius = (triggerArea _trigger) select 0;
_civarray = _trigger getVariable ["civarray",[]];
_mutex = _trigger getVariable ["mutex",true];
_ForceSpawnAtHouses = false;
_numinput = 0;

//optional, if true then use house positions to spawn civs instead of roads
if((count _this) > 1) then {_ForceSpawnAtHouses = _this select 1;};

//optional, for manual control of number of civs to spawn in area, rather than auto calculation.
if((count _this) > 2) then {_numinput = _this select 2;};


//if (civ_debug) then {sleep 4; [-1, {hint format ["%1",_this];}] call CBA_fnc_globalExecute; sleep 10;};

if (!isServer) exitwith {};
if(!Hz_civ_initdone) exitwith {};
if(!_mutex) exitwith {};

_exit = false;
if(!isnil "Hz_civ_global_safe") then {
  if(!Hz_civ_global_safe) exitwith {_exit = true;};
  Hz_civ_global_safe = false;
};
if(_exit) exitwith{};

_trigger setVariable ["mutex",false];

if (civ_debug) then {hint format ["%1",_pos];sleep 10;};

//SPAWN FUNC
_ownerIDs = [];
if(Hz_civ_enable_client_processing) then {{_ownerIDs set [count _ownerIDs, owner _x];}foreach playableunits;};

  //Determine number of civs to spawn for this location
  _buildings = nearestObjects [_pos, ["House"], 500];
  _count = count _buildings;
  _num = 0;
  _wait = false;
  if (_numinput > 0) then {
    _num = _numinput;
  } else {    
    _num = floor (Hz_civ_multiplier * (sqrt _count));
  };

  //Check if civs already exist in area

  if(count _civarray > 0) then {

    _count = {alive _x} count _civarray;
    _num = _num - _count;
    if(_num < 0) exitwith {};

    _newcivarray = [];

    {if (alive _x) then {_newcivarray set [count _newcivarray,_x];};}foreach _civarray;

    _civarray = _newcivarray;

  };

  if (_num == 0) exitwith {};

  if ((civtotal + _num) > maxcivcount) then {_num = maxcivcount - civtotal;};


  //create single group for entire area?
  _group1 = creategroup civilian;
  _group2 = creategroup civilian;
  _group3 = creategroup civilian;

  _civgroups = [_group1,_group2,_group3];

  _civ = objNull;

  //Find near roads
  _roadarr = [];
  if(_ForceSpawnAtHouses)then {
    _roadarr = nearestobjects [_pos,["House"],_radius];  
  }else {
    _roadarr = _pos nearroads _radius;   

		if ((count _roadarr) < 100) then {
		
			_ForceSpawnAtHouses = true;
			_roadarr = nearestobjects [_pos,["House"],_radius];  
		
		};
		
  };
  
  //filter
  _thisList = [];
  _temp = +(list _trigger);
  {
    _veh = vehicle _x;    
    
    if (!(_veh in _thisList)) then {_thisList set [count _thisList, _veh];};
    
  } foreach _temp;
  
  
  _temp = +_roadarr;
  {
    
    _remove = false;
    
    {
      
      if (_x in _thisList) exitWith {_remove = true;};
      
    } foreach (nearestobjects [_x,["CAManBase","LandVehicle"],SAFE_DISTANCE_FOR_SPAWN]);
    
    if (_remove) then {_roadarr = _roadarr - [_x];};
    
  } foreach _temp;  
  
  // if (count _roadarr < (_radius / 100))

  //SPAWN LOOP
  for "_x" from 1 to _num do {

    //Choose random road. Try and make them spawn on the side rather than in the middle
    _road = _roadarr call BIS_fnc_selectRandom;
    //_spawnpos = [((getpos _road) select 0) - 8,((getpos _road) select 1) - 8,((getpos _road) select 2)];
		
		if (!_ForceSpawnAtHouses) then {_roadarr = _roadarr - [_road];};
		
		_spawnpos = [];
		
		if (!_ForceSpawnAtHouses) then {
		
    _spawnpos = (boundingbox _road) select 0;
    _spawnpos = _road modeltoworld _spawnpos;
    _spawnpos = [(_spawnpos select 0),(_spawnpos select 1),0];
		
		} else {
		
			_bPos = _road buildingPos -1;
		
			if ((count _bPos) > 0) then {
			
			_spawnpos = _bPos call bis_fnc_selectrandom;
			
			} else {
			
			_spawnpos = [[(getpos _road) select 0,(getpos _road) select 1, 0],50,1,0] call mps_getFlatArea;
			
			};
		
		};

    //Choose _civ behaviour (normal or hostile) based on probability. If hostile is chosen use hoscivarray

    //Execute Hunter'z _civ funcs:  add handguns to 10% of civs + suicide bombers
    
    
    if (civ_killed_count < CIV_KILLED_COUNT_BEFORE_RAGE) then { //check if civilians are pissed off at you
      
      if ((random 1) < hz_civ_hostileChance) then {
        
        _civtype = hoscivtypes call BIS_fnc_selectRandom;
        _group = _civgroups call BIS_fnc_selectRandom;
        _civ = _group createUnit [ _civtype, _spawnpos, [], 2, "NONE" ];
        
        _civarray set [count _civarray,_civ];  
        
        _civ setskill 0.2;
        _civ setskill ["aimingSpeed",0.6];
        _civ setskill ["aimingShake",0];
        _civ setskill ["reloadSpeed",0.2];
        _civ setskill ["spotDistance",0.2];
        _civ setskill ["aimingAccuracy",0.1];
        _civ setskill ["spotTime",1];
        _civ allowFleeing 0.5;
        removeAllWeapons _civ;
        removeAllItems _civ;
				
				_civ setposatl _spawnpos;
        
        if(Hz_civ_enable_client_processing) then {_client = _ownerIDs call BIS_fnc_selectRandom; _civ setowner _client;};
        
        if ((random 1) > 0.5) then {
          // hint "spawned makarov";          
          _civ addMagazine "CUP_8Rnd_9x18_Makarov_M";
          _civ addMagazine "CUP_8Rnd_9x18_Makarov_M";
          _civ addMagazine "CUP_8Rnd_9x18_Makarov_M";
          _civ addMagazine "CUP_8Rnd_9x18_Makarov_M";
          _civ addMagazine "CUP_8Rnd_9x18_Makarov_M";
          _civ addMagazine "CUP_8Rnd_9x18_Makarov_M";
          _civ addMagazine "CUP_8Rnd_9x18_Makarov_M";
          _civ addMagazine "CUP_8Rnd_9x18_Makarov_M";
          _civ addWeapon "CUP_hgun_Makarov";
          //_civ selectweapon "Makarov";
          //_civ action ["loadmagazine",_civ, _civ, 0, 1 ,currentweapon _civ,currentweapon _civ];
          
          [_civ,SIDE_B select 0, SIDE_A select 0] spawn Hz_sinisterCiv;
          
          
          //[_this,3,3,"Rnd","Sw",20,"bin","","Run"] execVM "IED_Man_v6.sqf";
          //null = [this,10,5,"Rnd","Sw",0,"bin","","Run"] execVM "IED_Man_v6.sqf";
          //Sw: teleport to each location to find a suitable hiding spot, Mo: run to each location
          //"": with makarov, "NoGun": without gun
          //0: random time before deploying IED
          //"Run": run after bombing.
          //"Rnd": random ied type. GrndS = BAF IED Ground small. GrndL = BAF IED Ground large. GarbS = BAF IED Garbage small. GarbL = BAF IED Garbage large.
          //10: buildings to try.
          //5: objects to try.
          //"bin": use binoculars
          //http://www.armaholic.com/page.php?id=12180
          
          //                 if(Hz_civ_enable_client_processing) then {_client = _ownerIDs call BIS_fnc_selectRandom; _civ setowner _client;};
          
        } else {
          
          // hint "spawned revolver";
          if ((random 1) < 0.95) then  {
            _civ addMagazine "CUP_6Rnd_45ACP_M";
            _civ addMagazine "CUP_6Rnd_45ACP_M";
            _civ addMagazine "CUP_6Rnd_45ACP_M";
            _civ addMagazine "CUP_6Rnd_45ACP_M";
            _civ addMagazine "CUP_6Rnd_45ACP_M";
            _civ addMagazine "CUP_6Rnd_45ACP_M";
            _civ addMagazine "CUP_6Rnd_45ACP_M";
            _civ addMagazine "CUP_6Rnd_45ACP_M";
            _civ addWeapon "CUP_hgun_TaurusTracker455";
            //_civ selectweapon "revolver_EP1";
            //_civ action ["loadmagazine",_civ, _civ, 0, 1 ,currentweapon _civ,currentweapon _civ];
            
            [_civ,SIDE_B select 0, SIDE_A select 0] spawn Hz_sinisterCiv;           
            
            //        if(Hz_civ_enable_client_processing) then {_client = _ownerIDs call BIS_fnc_selectRandom; _civ setowner _client;};
            
          } else {

            /*
                                        _this addMagazine "20Rnd_B_765x17_Ball";
                                        _this addMagazine "20Rnd_B_765x17_Ball";
                                        _this addWeapon "Sa61_EP1";
                                        */
            //  hint "spawned IED";
            _civ setskill 1;
            _civ addMagazine "IEDUrbanBig_Remote_Mag";
            [_civ,[SIDE_A select 0],"CUP_Sh_122_HE"] execVM "suicideBomber.sqf";
            //http://www.armaholic.com/page.php?id=20562
            
            _civ setunitpos "UP";
            
            if (random 1 > 0.5) then {_civ addweapon "B_OutdoorPack_tan";};

          }; };			  
      } else {
        
        _civtype = allcivtypes call BIS_fnc_selectRandom;
        _group = _civgroups call BIS_fnc_selectRandom;
        _civ = _group createUnit [ _civtype, _spawnpos, [], 2, "NONE" ];
        _civarray set [count _civarray,_civ];  
        
        _civ setSkill 0;
        _civ allowFleeing 1;
        removeAllWeapons _civ;
        removeAllItems _civ;       
				
				_civ setposatl _spawnpos;
        
        if ((random 1) > 0.96) then {_civ addweapon "B_OutdoorPack_tan";};          
        //  [_this] joinSilent civs;  
        group _civ setBehaviour "SAFE";      
        _civ addEventHandler ["killed", {// waituntil {!isnil mps_mission_deathcount; sleep 2;};
          
          _civ = _this select 0;
          _killer = _this select 1;
          
          _condition = false;
          
          if (isplayer _killer) then {_condition = true;} else {
          
          //hit and run detection
          if (_civ == _killer) then {
          
          //civ might be sent away so keep radius large
          _nearCars = nearestobjects [_civ,["LandVehicle"],100];
          
          {
          
          if (((speed _x) > 10) && (isplayer (driver _x))) exitwith {_condition = true;};
          
          } foreach _nearCars;
          
          };
          
          };
        
          if (_condition) then {
          
            if (_killer getvariable ["JointOps",false]) then {
            
            [-1, {
            
            if (player getvariable ["JointOps",false]) then {
            
            hint "Civilian casualties are unacceptable. Command is sure to cut our budget in this theatre if this continues.";
            
            };
            
            }] call CBA_fnc_globalExecute;
            
            } else {
          
            mps_mission_deathcount = mps_mission_deathcount - 1; 
            Hz_econ_funds = Hz_econ_funds - 100000;
            publicvariable "Hz_econ_funds";
            publicVariable "mps_mission_deathcount";
            [-1, {
            
            if (!(player getvariable ["JointOps",false])) then {
            
            hint "Civilian casualties are unacceptable. We lost $100000 in compensation, but the big loss will come from losing support from our clients.";
            
            };
            
            }] call CBA_fnc_globalExecute;
            civ_killed_count = civ_killed_count + 1;
            
            if (civ_killed_count > CIV_KILLED_COUNT_BEFORE_RAGE) then {
              
              [-1, {hint parsetext format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>Civilian casualties have reached outrageous numbers. Civilians will now start rebelling against you!</t>"];}] call CBA_fnc_globalExecute;    
              
            };
            
          };  
          
          };
          
        }];
        
        if(Hz_civ_enable_client_processing) then {_client = _ownerIDs call BIS_fnc_selectRandom; _civ setowner _client;};
        
      };
      
    } else { 
      //civilians pissed off
      
      if ((random 1) > 0.2) then {
        
        _civtype = hoscivtypes call BIS_fnc_selectRandom;
        _group = _civgroups call BIS_fnc_selectRandom;
        _civ = _group createUnit [ _civtype, _spawnpos, [], 2, "NONE" ];
        _civarray set [count _civarray,_civ];  
        
        _civ allowFleeing 0.5;
        _civ setskill 0.2;
        _civ setskill ["aimingSpeed",0.6];
        _civ setskill ["spotDistance",0.5];
        _civ setskill ["aimingAccuracy",0.2];
        _civ setskill ["spotTime",0.5];
        removeAllWeapons _civ;
        removeAllItems _civ;
				
				_civ setposatl _spawnpos;
        
        if(Hz_civ_enable_client_processing) then {_client = _ownerIDs call BIS_fnc_selectRandom; _civ setowner _client;};
        
        if ((random 1) < 0.7) then {
          
          [_civ] joinSilent (createGroup EAST);
          _civ addMagazine "30Rnd_762x39_AK47";
          _civ addMagazine "30Rnd_762x39_AK47";
          _civ addMagazine "30Rnd_762x39_AK47";
          _civ addMagazine "30Rnd_762x39_AK47";
          _civ addWeapon "AK_47_M";
          //_civ selectweapon "AK_47_M";
          //_civ action ["loadmagazine",_civ, _civ, 0, 1 ,currentweapon _civ,currentweapon _civ];
          
          (group _civ) setBehaviour "SAFE";
          _civ setunitpos "UP";
          
          //    if(Hz_civ_enable_client_processing) then {_client = _ownerIDs call BIS_fnc_selectRandom; _civ setowner _client;};
          
        } else   {
          [_civ] joinSilent (createGroup EAST);
          
          if ((random 1) > 0.1) then  {
            _civ addWeapon "RPG7V";
            _civ addMagazine "OG7";
            _civ addMagazine "OG7";
            //_civ selectweapon "RPG7V";
            //_civ action ["loadmagazine",_civ, _civ, 0, 1 ,currentweapon _civ,currentweapon _civ];                               
            (group _civ) setBehaviour "SAFE";
            _civ setunitpos "UP";
            
            //      if(Hz_civ_enable_client_processing) then {_client = _ownerIDs call BIS_fnc_selectRandom; _civ setowner _client;};
            
          } else {

            /*
                                        _this addMagazine "20Rnd_B_765x17_Ball";
                                        _this addMagazine "20Rnd_B_765x17_Ball";
                                        _this addWeapon "Sa61_EP1";
                                        */
            _civ setskill 0.5;
            _civ addMagazine "BAF_ied_v1";
            [_civ,[WEST],"PipeBomb"] execVM "suicideBomber.sqf";
            _civ setunitpos "UP";
            //http://www.armaholic.com/page.php?id=20562
          };
        };
      } else {
        
        _civtype = allcivtypes call BIS_fnc_selectRandom;
        _group = _civgroups call BIS_fnc_selectRandom;
        _civ = _group createUnit [ _civtype, _spawnpos, [], 2, "NONE" ];       
        _civarray set [count _civarray,_civ];  
        
        _civ setSkill 0;
        _civ allowFleeing 1;
        removeAllWeapons _civ;
        removeAllItems _civ;
				
				_civ setposatl _spawnpos;
        
        //[_civ] joinSilent civs;              
        group _civ setBehaviour "SAFE";                
        _civ addEventHandler ["killed", {
          
          
          if (isplayer (_this select 1)) then {
            mps_mission_deathcount = mps_mission_deathcount - 1; 
            Hz_econ_funds = Hz_econ_funds - 100000;
            publicvariable "Hz_econ_funds";
            publicVariable "mps_mission_deathcount";
            [-1, {hint "Civilian casualties are unacceptable. We lost $100000 as compensation, and we'll lose even more if this ends up in the news...";}] call CBA_fnc_globalExecute;
            civ_killed_count = civ_killed_count + 1;	
          };  
        } ];
        
        if(Hz_civ_enable_client_processing) then {_client = _ownerIDs call BIS_fnc_selectRandom; _civ setowner _client;};
        
      };
    };


    //Add _civ to total count (global)
    civtotal = civtotal + 1;

    if (civ_debug) then {[-1, {hint format["%1",_civarray];}] call CBA_fnc_globalExecute;};


  };

if (civ_debug) then {sleep 4; [-1, {hint format ["Script done. returned civarray: %1",_civarray];}] call CBA_fnc_globalExecute; sleep 5;};

_trigger setVariable ["civarray",_civarray];
_trigger setVariable ["mutex",true];

publicvariable "civtotal";

if(!isnil "Hz_civ_global_safe") then {Hz_civ_global_safe = true;};