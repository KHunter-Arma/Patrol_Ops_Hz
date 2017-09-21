////// PARSING DESCRIPTORS ///////
#define ONE_D_ARRAY  1
#define NESTED_ARRAY_STRUCT 2
#define ARRAY_OF_STRUCTS 3
/////////////////////////////////

private ["_pos","_array1","_array2","_tyrepos","_veh","_wepindex","_ammoindex","_index","_fort","_box","_heightcorrection","_tent","_name","_uid","_text","_indexveh","_indexfort","_indexfort2","_indexfort3","_indexfort4","_indexfort5","_indexmedbox","_indexemptybox","_indexrally"];

if(isServer) then {
    
    deletevehicle hz_trigger_load;
 
    loaddone = false;
    call compile preprocessfilelinenumbers "\ACE_LOAD_GAME\ACE_gamesave.txt";
    sleep 1;

    //Load Cash
    publicvariable "Hz_funds";

    //destroy manually marked buildings. Note: buildings must be destroyed in "natural" ways to make sure JIP sync with all types of buildings
    //old array with bridge segments: Hz_save_destroyedMapBuildingIDs = [9349,9350,9352,96605,90529,96592,95978,89697,95976,96601,96600,93754,96646];
    {
         
        _x spawn {   

            for "_i" from 1 to 200 do {
                _pos = getposatl ([0,0,0] nearestobject _this);
                _pos = [_pos select 0, _pos select 1, 1000];
                _sh = "Sh_120_sabot" createvehicle [0,0,1000];
                _sh setposatl _pos;
                _sh setvelocity [0,0,-10000];
                sleep 0.1;
            };
        
        };
        
        sleep (random 3);
    
    } foreach Hz_save_destroyedMapBuildingIDs;
    
    sleep 60;

    {
        _objectName = _x select 0;
            
        switch (_x select 1) do {
      
            case ONE_D_ARRAY : {
                
                _objectName call Hz_save_func_arrayParser;     
                        
            };
            
            case NESTED_ARRAY_STRUCT : {
                
                _parsedStruct = _objectName call Hz_save_func_nestedArrayStructParser;
                missionnamespace setvariable [_objectName,_parsedStruct];
                
            };
                    
            case ARRAY_OF_STRUCTS : {
                
                _objectName call Hz_save_func_structArrayParser;
                        
            };
  
            default {};    
      
        };
        
        sleep 1;
    
    }foreach hz_save_parsingInfo;   
    
    //currently this doesn't fit into any structure, so we save/load it separately
    "hz_veh_turret_mag_array" call Hz_save_func_arrayParser;

    //Initialise load environment
    _indexveh = (count hz_veh_type_array) - 1;  
    _indexfort = (count hz_fort_type_array) - 1;
    _indexmedbox = (count medbox_dir_array) - 1;
    _indexemptybox = (count emptybox_dir_array) - 1;
    _indexrally = (count rallynames) - 1;

    deletevehicle medbox1;// medbox1 = nil; publicvariable "medbox1";
    deletevehicle medbox2;// medbox2 = nil; publicvariable "medbox2";
    deletevehicle medbox3; //medbox3 = nil; publicvariable "medbox3";
    deletevehicle medbox4; //medbox4 = nil; publicvariable "medbox4";
    deletevehicle emptybox1;// emptybox1 = nil; publicvariable "emptybox1";
    deletevehicle emptybox2; //emptybox2 = nil; publicvariable "emptybox2";
    deletevehicle emptybox3; //emptybox3 = nil; publicvariable "emptybox3";
    deletevehicle emptybox4;// emptybox4 = nil; publicvariable "emptybox4";
    deletevehicle emptybox5; //emptybox5 = nil; publicvariable "emptybox5";
    deletevehicle emptybox6; //emptybox6 = nil; publicvariable "emptybox6";
    deletevehicle emptybox7; //emptybox7 = nil; publicvariable "emptybox7";
    deletevehicle emptybox8; //emptybox8 = nil; publicvariable "emptybox8";
    medbox_array = [];
    emptybox_array = [];

    ///////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////


    // Check for nuke events
    if(count nuke_event > 0) then {
    
        {
            _pos = markerpos _x;
            _array1 = nearestobjects [_pos,[],300];
            _array2 = nearestobjects [_pos,[],500];
            _array1 = _array1 - Hz_nuke_damageExceptions;
            _array2 = _array2 - Hz_nuke_damageExceptions;
            
            //JIP
            narray2 = narray2 + _array2;
            narray1 = narray1 + _array1;
                 
            {  
                _x setdamage 1;
            }foreach _array2;    
                    
            {
                deletevehicle _x;
                // _x hideobject true;
            }foreach _array1;       
        
        }foreach nuke_event;      
        
        //client-side sync required at JIP for full sync. narray 2 is enough
        publicvariable "narray2";
                
    };

    /////////////////////////////////////////////////////////////////////////////////////////

    //Load Vehicles
    _index = 0;
    _tyrepos = [0,0,0];
    
    if (_indexveh >= 0) then {
    
        for "_i" from 0 to _indexveh do {

            if((hz_veh_type_array select _index == "ACE_Spare_Tyre_HDAPC") || (hz_veh_type_array select _index == "ACE_Spare_Tyre_HD") || (hz_veh_type_array select _index == "ACE_Spare_Tyre")) then {
			
                if((hz_veh_pos_array select _index) distance [0,0,0] > 10) then {_tyrepos = hz_veh_pos_array select _index;}; 
		  
            };
				
            _veh = (hz_veh_type_array select _index) createvehicle [-5000,0,0];
            hz_veh_array set [count hz_veh_array,_veh];
            clearMagazineCargoGlobal _veh;
            clearWeaponCargoGlobal _veh;

            _wepindex = (count ((hz_veh_gear_wep_array select _index) select 0)) - 1;
            for "_a" from 0 to _wepindex do {
                _veh addWeaponCargoGlobal[(((hz_veh_gear_wep_array select _index) select 0) select _a),(((hz_veh_gear_wep_array select _index) select 1) select _a)];
            };
            _ammoindex = (count ((hz_veh_gear_ammo_array select _index) select 0)) - 1;
            for "_b" from 0 to _ammoindex do {
                _veh addMagazineCargoGlobal[(((hz_veh_gear_ammo_array select _index) select 0) select _b),(((hz_veh_gear_ammo_array select _index) select 1) select _b)];
            };
            _veh setdir (hz_veh_dir_array select _index);
            _pos = hz_veh_pos_array select _index;
            if(_pos distance [0,0,0] > 10) then {_veh setposatl _pos;} else {_veh setposatl _tyrepos;};
            [_veh] call Hz_func_setvehicleinit;
        
            _veh setvehicleammo 0;
            _veh setfuel (hz_veh_fuel_array select _index);
						_veh setdamage (hz_veh_dam_array select _index);

            if((count (hz_veh_turret_mag_array select _index)) > 0) then {

                _turrCount = count ((hz_veh_turret_mag_array select _index) select 0);
                for "_i" from 0 to (_turrCount - 1) do {
			
                    _turrPath = ((hz_veh_turret_mag_array select _index) select 0) select _i;
                    _magsCount = count ((((hz_veh_turret_mag_array select _index) select 1) select _i) select 0);
                    _magArray = ((hz_veh_turret_mag_array select _index) select 1) select _i;
                        
                    if(_magsCount > 0) then {
                        
                        for "_j" from 0 to (_magsCount - 1) do {
                            
                            for "_k" from 1 to ((_magArray select 1) select _j) do {
                        
                                //Turret locality is an extremely weird case in Arma. Best is to execute globally and hope that everything goes fine...
                                //This EH is added during init of Hz logistics, which should always run before load
                                ["Hz_econ_addMagazineTurret", [_veh, (_magArray select 0) select _j,_turrPath]] call CBA_fnc_globalEvent;
                            
                            };
                        
                        };    
                    };
                };

            };
            //_veh setvariable ["R3F_LOG_objets_charges",(hz_veh_contents_array select _index),true];
            _index = _index + 1;
            sleep 0.01;
        };
    };
    
    publicvariable "hz_veh_array";

    ///////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////


    //Load fortifications and objects
    _index = 0;    
    if (_indexfort >= 0) then {
        for "_i" from 0 to _indexfort do {
            _fort = (hz_fort_type_array select _index) createvehicle [0,0,0];
            _fort setVariable ["objectLocked", true, true];
            /*
    if(typeof _fort == "WarfareBDepot") then {
     _fort addEventHandler ["HandleDamage", {_obj = _this select 0; _health = getdammage _obj; _newhealth = _this select 2; _damage = _newhealth - _health; _damage = _damage * 20; _return = _health + _damage; _return}];
    };
*/
            hz_fort_array set [count hz_fort_array,_fort];
            _fort setdamage (hz_fort_dam_array select _index);
            _fort setdir (hz_fort_dir_array select _index);
            _fort setposatl (hz_fort_pos_array select _index);
            if(_fort iskindof "FlagCarrierIONwhite_PMC") then {_fort setFlagTexture "media\flag3.jpg";}; 
            _index = _index + 1;

        };
    };  

    publicvariable "hz_fort_array";

    ///////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////
    if(_indexemptybox >= 0) then {
        //Load supply boxes
        _index = 0;
        for "_i" from 0 to _indexemptybox do {
            _box = "ACE_USVehicleBox_EP1" createvehicle [0,0,0];
            _box setVariable ["objectLocked", true, true];
            clearWeaponCargoglobal _box;
            clearMagazineCargoglobal _box;

            _wepindex = (count ((emptybox_gear_wep_array select _index) select 0)) - 1;
            for "_a" from 0 to _wepindex do {
                _box addWeaponCargoGlobal[(((emptybox_gear_wep_array select _index) select 0) select _a),(((emptybox_gear_wep_array select _index) select 1) select _a)];

            };

            _ammoindex = (count ((emptybox_gear_ammo_array select _index) select 0)) - 1;
            for "_b" from 0 to _ammoindex do {
                _box addMagazineCargoGlobal[(((emptybox_gear_ammo_array select _index) select 0) select _b),(((emptybox_gear_ammo_array select _index) select 1) select _b)];
            };

            _box setdir (emptybox_dir_array select _index);
            _box setposatl (emptybox_pos_array select _index);
            //_heightcorrection = [((emptybox_pos_array select _index) select 0) , ((emptybox_pos_array select _index) select 1) , (((getposatl _box) select 2) + 0.375)];
            //_box setposatl _heightcorrection;
      
            emptybox_array set [count emptybox_array, _box];

            _index = _index + 1;
            sleep 0.1;

        };

        {
            _x setvehicleinit "this addaction [""<t color=""""#00CC00"""">"" +""Transfer all items to crate"",""HZ\Hz_funcs\Hz_func_remove_gear.sqf"",nil,-10]; this addaction [""<t color=""""#ffc100"""">"" +""Rearrange Radios"",""HZ\Hz_funcs\Hz_func_rearrangeACRERadios.sqf"",nil,-11];";
        }foreach emptybox_array;
        processinitcommands;         
    };           

    sleep 0.1;
    
    publicvariable "emptybox_array";

    //////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////
    if(_indexmedbox >= 0) then {
        //Load medical supply boxes
        _index = 0;
        for "_i" from 0 to _indexmedbox do {
            _box = "ACE_BandageBoxWest" createvehicle [0,0,0];
            _box setVariable ["objectLocked", true, true];
            clearWeaponCargoglobal _box;
            clearMagazineCargoglobal _box;

            _wepindex = (count ((medbox_gear_wep_array select _index) select 0)) - 1;
            for "_a" from 0 to _wepindex do {
                _box addWeaponCargoGlobal[(((medbox_gear_wep_array select _index) select 0) select _a),(((medbox_gear_wep_array select _index) select 1) select _a)];
            };

            _ammoindex = (count ((medbox_gear_ammo_array select _index) select 0)) - 1;
            for "_b" from 0 to _ammoindex do {
                _box addMagazineCargoGlobal[(((medbox_gear_ammo_array select _index) select 0) select _b),(((medbox_gear_ammo_array select _index) select 1) select _b)];
            };


            _box setdir (medbox_dir_array select _index);
            _box setposatl (medbox_pos_array select _index);

            medbox_array set [count medbox_array, _box];

            _index = _index + 1;
            sleep 0.1;

        };

        {
            _x setvehicleinit "this addaction [""<t color=""""#FF0000"""">"" +""Transfer medical items to crate"",""HZ\Hz_funcs\Hz_func_remove_medical_gear.sqf"",nil,-10];";
        }foreach medbox_array;
        processinitcommands;     
    };          

    sleep 0.1;
    
    publicvariable "medbox_array";

    ///////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////

    //Load rallypoints
    _index = 0;
    if(_indexrally >= 0) then {
        for "_i" from 0 to _indexrally do {
            _tent = "ACamp_EP1" createvehicle [0,0,0];
            _pos = rallypos select _index;
            _tent setposatl _pos;
            _name = rallynames select _index;
            _uid = rallyuids select _index;
            _text = format["this addAction [""<t color='#ffc600'>Remove tent of %1</t>"", ""mps\action\mps_removetent.sqf"",[],0,false];", _name];
            _tent setVehicleInit _text;
            _tent setvariable ["owner", _name, true];
            _tent setvariable ["owneruid", _uid, true];
            rallytents = rallytents + [_tent];
            createMarker [_uid,_pos];
            syncJIPmarkers = syncJIPmarkers + [_uid];
            sleep 0.1;
            _index = _index + 1;

        };
        processInitCommands;   
    };
   
    sleep 1;
    publicvariable "rallytents";


    ///////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////

    sandbags setposatl sandbagspos;
    
    publicvariable "BanList";
    
    ///////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////
    
    // Joint Ops
    _indexvehjops = (count hz_save_jointOps_veh_type) - 1;
    
    if(_indexvehjops >= 0) then {
        for "_i" from 0 to _indexvehjops do {
				
            _veh = (hz_save_jointOps_veh_type select _i) createvehicle [-5000,0,0];
            Hz_save_jointOps_vehicles set [count Hz_save_jointOps_vehicles,_veh];
            clearMagazineCargoGlobal _veh;
            clearWeaponCargoGlobal _veh;
            _veh setdir (hz_save_jointOps_veh_dir select _i);
            _veh setposatl (hz_save_jointOps_veh_pos select _i);
        
            sleep 0.01;
        };    
    };
    
    {_x setvehiclelock "locked";} foreach Hz_save_jointOps_vehicles;
    
    publicvariable "Hz_save_jointOps_vehicles";
    
    _indexwepjops = (count hz_save_jointOps_ammocrate_wepTypes) - 1;
    
    if (_indexwepjops >= 0) then {
    
        for "_i" from 0 to _indexwepjops do {
    
            JOPS_AMMOCRATE addweaponcargoglobal [hz_save_jointOps_ammocrate_wepTypes select _i, hz_save_jointOps_ammocrate_wepCount select _i];
    
        };
    };
    
    _indexmagjops = (count hz_save_jointOps_ammocrate_magTypes) - 1;
    
    if (_indexmagjops >= 0) then {
        
        for "_i" from 0 to _indexmagjops do {
    
            JOPS_AMMOCRATE addmagazinecargoglobal [hz_save_jointOps_ammocrate_magTypes select _i, hz_save_jointOps_ammocrate_magCount select _i];
    
        };
    
    };
    
    _indexwepjops = (count hz_save_jointOps_medcrate_wepTypes) - 1;
    
    if (_indexwepjops >= 0) then {
    
        for "_i" from 0 to _indexwepjops do {
    
            JOPS_MEDICALBOX addweaponcargoglobal [hz_save_jointOps_medcrate_wepTypes select _i, hz_save_jointOps_medcrate_wepCount select _i];
    
        };
    };
    
    _indexmagjops = (count hz_save_jointOps_medcrate_magTypes) - 1;
    
    if (_indexmagjops >= 0) then {
    
        for "_i" from 0 to _indexmagjops do {
    
            JOPS_MEDICALBOX addmagazinecargoglobal [hz_save_jointOps_medcrate_magTypes select _i, hz_save_jointOps_medcrate_magCount select _i];
    
        };
    };
    
		//apply persistent weather
		
    if (nukeweather) then {[] spawn nukeWeatherCountdown;};
    publicVariable "nukeweather";
		call Hz_weather_func_dynamicWeather;

    ///////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////

    gameloaded = true;
    publicvariable "gameloaded";

    /////////////////////////////////////////////////////////////////////////////////////////////
    /*

                                    LOAD COMPLETE
                                    

    *////////////////////////////////////////////////////////////////////////////////////////////




    //Client message
} else {

    hintsilent "Loading game.....";
    waituntil {gameloaded};
    hint "Load successful!";

};