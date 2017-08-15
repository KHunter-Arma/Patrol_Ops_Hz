// =========================================================================================================
//  Urban Patrol Script  
//  Version: 2.1.0
//  Author: Kronzky (www.kronzky.info / kronzky@gmail.com)
// ---------------------------------------------------------------------------------------------------------
//  Required parameters:
//    unit          = Unit to patrol area (1st argument)
//    markername    = Name of marker that covers the active area. (2nd argument)
//    (e.g. nul=[this,"town"] execVM "ups.sqf")
//
//  Optional parameters: 
//    random        = Place unit at random start position.
//    randomdn      = Only use random positions on ground level.
//    randomup      = Only use random positions at top building positions. 
//    min:n/max:n   = Create a random number (between min and max) of 'clones'.
//    init:string   = Cloned units' init string.
//    prefix:string = Cloned units' names will start with this prefix.
//    nomove        = Unit will stay at start position until enemy is spotted.
//    nofollow      = Unit will only follow an enemy within the marker area.
//    delete:n      = Delete dead units after 'n' seconds.
//    nowait        = Do not wait at patrol end points.
//    noslow        = Keep default behaviour of unit (don't change to "safe" and "limited").
//    noai          = Don't use enhanced AI for evasive and flanking maneuvers.
//    showmarker    = Display the area marker.
//    trigger       = Display a message when no more units are left in sector.
//    empty:n       = Consider area empty, even if 'n' units are left.
//    track         = Display a position and destination marker for each unit.
//
// =========================================================================================================

#define HZ_DEBUG(X) if(hz_debug_patrols) then {hint X;}

if (!isServer) exitWith {};

private ["_members","_originalGroup", "_passengerarr", "_driver", "_commander", "_gunner", "_istank", "_vehicle", "_allin", "_issoldier", "_friends", "_enemies",  "_grp", "_lead",  "_waiting", "_loop"];

// how close unit has to be to target to generate a new one 
#define CLOSEENOUGH 100

//#define DEBUG_HZ

// ---------------------------------------------------------------------------------------------------------
//echo format["[K] %1",_this];

// convert argument list to uppercase
_UCthis = [];
for [{_i=0},{_i<count _this},{_i=_i+1}] do {_e=_this select _i; if (typeName _e=="STRING") then {_e=toUpper(_e)};_UCthis set [_i,_e]};

// ***************************************** SERVER INITIALIZATION *****************************************

// global functions
if (isNil("KRON_UPS_INIT")) then {
    KRON_UPS_INIT=0;
    
    // find a random position within a radius
    KRON_randomPos = {private["_cx","_cy","_rx","_ry","_cd","_sd","_ad","_tx","_ty","_xout","_yout"];_cx=_this select 0; _cy=_this select 1; _rx=_this select 2; _ry=_this select 3; _cd=_this select 4; _sd=_this select 5; _ad=_this select 6; _tx=random (_rx*2)-_rx; _ty=random (_ry*2)-_ry; _xout=if (_ad!=0) then {_cx+ (_cd*_tx - _sd*_ty)} else {_cx+_tx}; _yout=if (_ad!=0) then {_cy+ (_sd*_tx + _cd*_ty)} else {_cy+_ty}; [_xout,_yout]};
    // find any building (and its possible building positions) near a position
    KRON_PosInfo = {private["_pos","_lst","_bld","_bldpos"];_pos=_this select 0; _lst= nearestObjects [_pos,["House","vbs2_house"],20]; if (count _lst==0) then {_bld=0;_bldpos=0} else {_bld=_lst select 0; _bldpos=[_bld] call KRON_BldPos}; [_bld,_bldpos]};
    /// find the highest building position	
    KRON_BldPos = {private ["_bld","_bi","_bldpos","_maxZ","_bp","_bz","_higher"];_bld=_this select 0;_maxZ=0;_bi=0;_bldpos=0;while {_bi>=0} do {_bp = _bld BuildingPos _bi;if ((_bp select 0)==0) then {_bi=-99} else {_bz=_bp select 2; _higher = ((_bz>_maxZ) || ((abs(_bz-_maxZ)<.5) && (random 1>.5))); if ((_bz>4) && _higher) then {_maxZ=_bz; _bldpos=_bi}};_bi=_bi+1};_bldpos};
    KRON_OnRoad = {private["_pos","_car","_tries","_lst"];_pos=_this select 0; _car=_this select 1; _tries=_this select 2; _lst=_pos nearRoads 4; if ((count _lst!=0) && (_car || !(surfaceIsWater _pos))) then {_tries=99}; (_tries+1)};
    KRON_getDirPos = {private["_a","_b","_from","_to","_return"]; _from = _this select 0; _to = _this select 1; _return = 0; _a = ((_to select 0) - (_from select 0)); _b = ((_to select 1) - (_from select 1)); if (_a != 0 || _b != 0) then {_return = _a atan2 _b}; if ( _return < 0 ) then { _return = _return + 360 }; _return};
    KRON_distancePosSqr = {(((_this select 0) select 0)-((_this select 1) select 0))^2 + (((_this select 0) select 1)-((_this select 1) select 1))^2};
    KRON_relPos = {private["_p","_d","_a","_x","_y","_xout","_yout"];_p=_this select 0; _x=_p select 0; _y=_p select 1; _d=_this select 1; _a=_this select 2; _xout=_x + sin(_a)*_d; _yout=_y + cos(_a)*_d;[_xout,_yout,0]};
    KRON_rotpoint = {private["_cp","_a","_tx","_ty","_cd","_sd","_cx","_cy","_xout","_yout"];_cp=_this select 0; _cx=_cp select 0; _cy=_cp select 1; _a=_this select 1; _cd=cos(_a*-1); _sd=sin(_a*-1); _tx=_this select 2; _ty=_this select 3; _xout=if (_a!=0) then {_cx+ (_cd*_tx - _sd*_ty)} else {_cx+_tx}; _yout=if (_a!=0) then {_cy+ (_sd*_tx + _cd*_ty)} else {_cy+_ty}; [_xout,_yout,0]};
    KRON_stayInside = {
        private["_np","_nx","_ny","_cp","_cx","_cy","_rx","_ry","_d","_tp","_tx","_ty","_fx","_fy"];
        _np=_this select 0;	_nx=_np select 0;	_ny=_np select 1;
        _cp=_this select 1;	_cx=_cp select 0;	_cy=_cp select 1;
        _rx=_this select 2;	_ry=_this select 3;	_d=_this select 4;
        _tp = [_cp,_d,(_nx-_cx),(_ny-_cy)] call KRON_rotpoint;
        _tx = _tp select 0; _fx=_tx;
        _ty = _tp select 1; _fy=_ty;
        if (_tx<(_cx-_rx)) then {_fx=_cx-_rx};
        if (_tx>(_cx+_rx)) then {_fx=_cx+_rx};
        if (_ty<(_cy-_ry)) then {_fy=_cy-_ry};
        if (_ty>(_cy+_ry)) then {_fy=_cy+_ry};
        if ((_fx!=_tx) || (_fy!=_ty)) then {_np = [_cp,_d*-1,(_fx-_cx),(_fy-_cy)] call KRON_rotpoint};
        _np;
    };
    // Misc
    KRON_getArg = {private["_cmd","_arg","_list","_a","_v"]; _cmd=_this select 0; _arg=_this select 1; _list=_this select 2; _a=-1; {_a=_a+1; _v=format["%1",_list select _a]; if (_v==_cmd) then {_arg=(_list select _a+1)}} foreach _list; _arg};
    KRON_deleteDead = {private["_u","_s"];_u=_this select 0; _s= _this select 1; _u removeAllEventHandlers "killed"; sleep _s; deletevehicle _u};
    
    KRON_AllWest=[];
    KRON_AllEast=[];
    KRON_AllRes=[];
    KRON_KnownEnemy=[objNull,objNull];
    
    // find all units in mission
    {
        _s = side _x;
        switch (_s) do {
            case west: 
            { KRON_AllWest set [count KRON_AllWest,_x];};
            case east: 
            { KRON_AllEast set [count KRON_AllEast,_x];};
            case resistance: 
            {KRON_AllRes set [count KRON_AllRes,_x];};
        };
    }forEach allUnits;
    
    if (isNil("KRON_UPS_Debug")) then {KRON_UPS_Debug=0};
    KRON_HQ="Logic" createVehicle [0,0];
    KRON_UPS_Instances=0;
    KRON_UPS_Total=0;
    KRON_UPS_Exited=0;
    KRON_UPS_INIT=1;
};
if ((count _this)<2) exitWith {
    if (format["%1",_this]!="INIT") then {hint "UPS: Unit and marker name have to be defined!"};
};
_exit = false;
_onroof = false;

// ---------------------------------------------------------------------------------------------------------
waitUntil {KRON_UPS_INIT==1};
sleep (random 2);

KRON_UPS_Instances =	KRON_UPS_Instances + 1;

// get name of area marker 
_areamarker = _this select 1;
if (isNil ("_areamarker")) exitWith {
    hint "UPS: Area marker not defined.\n(Typo, or name not enclosed in quotation marks?)";
};	

_centerpos = [];
_centerX = [];
_centerY = [];
_rangeX = 0;
_rangeY = 0;
_areadir = 0;
_areaname = "";
_areatrigger = objNull;
_showmarker = "HIDEMARKER";

//get area info
    if (typeName _areamarker=="String") then {
        // remember center position of area marker
        _centerpos = getMarkerPos _areamarker;
        _centerX = abs(_centerpos select 0);
        _centerY = abs(_centerpos select 1);
        
        // X/Y range of target area
        _areasize = getMarkerSize _areamarker;
        _rangeX = _areasize select 0;
        _rangeY = _areasize select 1;
        // marker orientation (needed as negative value!)
        _areadir = (markerDir _areamarker) * -1;
        
        _areaname = _areamarker;
        
        // show area marker 
        _showmarker = if ("SHOWMARKER" in _UCthis) then {"SHOWMARKER"} else {"HIDEMARKER"};
        if (_showmarker=="HIDEMARKER") then {
            _areamarker setMarkerPos [-abs(_centerX),-abs(_centerY)];
        };
    } else {
        _centerpos = getPos _areamarker;
        _centerX = abs(_centerpos select 0);
        _centerY = abs(_centerpos select 1);
        
        // X/Y range of target area
        _rangeX = triggerArea _areamarker select 0;
        _rangeY = triggerArea _areamarker select 1;
        // marker orientation (needed as negative value!)
        _areadir = (getDir _areamarker) * -1;
        
        _areaname = vehicleVarName _areamarker;
    };
    // update trigger position
    if !(isNull _areatrigger) then {
        _areatrigger setPos [_centerX,_centerY];
    };


sleep 0.1;

// unit that's moving
_obj = _this select 0;		
_npc = _obj;
// is anybody alive in the group?
_exit = true;
_originalGroup = grpnull;

if (typename _obj=="OBJECT") then {
    
    if (alive _npc) then {_exit = false; _originalGroup = group _npc;};		
} else {
    
    if(typename _obj == "GROUP") then {
        
        {if (alive _x) then {_npc = leader _obj; _exit = false;};} forEach (units _obj);
        _originalGroup = _obj;
        
    } else {
        
        if (count _obj>0) then {
            {if(!isnull _x) then {if (alive _x) then {_npc = _x; _exit = false;};};} forEach _obj;
        };
    };  
};

// give this group a unique index
_grpidx = format["%1",KRON_UPS_Instances];
_grpname = format["%1_%2",(side _npc),_grpidx];

// remember the original group members, so we can later find a new leader, in case he dies
_members = units _npc;
      
        
        KRON_UPS_Total = KRON_UPS_Total + (count _members);
        
        // what type of "vehicle" is unit ?
        _isman = _npc isKindOf "Man";
        _iscar = _npc isKindOf "LandVehicle";
        _isboat = _npc isKindOf "Ship";
        _isplane = _npc isKindOf "Air";
        
        _passengerarr = [];
        _driver = objnull;
        _commander = objnull;
        _gunner = objnull;
        _istank = false;
        _vehicle = objnull;
        _vehicleset = 0;
        _allin = true;
        _allout = false;
        
        
        {if ((vehicle _x) != _x) then {
            
            if(_vehicleset < 1) then {        
                _vehicle = vehicle _x; 
                
                _driver = driver _vehicle;
                _commander = commander _vehicle;
                _gunner = gunner _vehicle;        
                _vehicleset = 1;
            };
                   
            if ((_vehicle iskindof "Tank") && !(_vehicle iskindof "Tracked_APC")) exitwith {_istank = true;};
            
            if((_x != (driver _vehicle)) && (_x != (gunner _vehicle)) && (_x != (commander _vehicle))) then {
                
                _passengerarr set [count _passengerarr, _x];
                
                _x assignascargo _vehicle;
            };
        };
        if (_istank) exitwith {};
        
    }foreach _members;
    
    
    //make sure vehicle crews take command only when all infantry in the squad are wiped out -- needed to make some features work properly
    
    {_x setrank "COLONEL";} foreach _members;
    
    if(_istank) then {
    
    {_x setrank "PRIVATE";} foreach (crew _vehicle);
    
    } else {    
        
    {_x setrank "PRIVATE";} foreach [_driver,_gunner,_commander];
    
    };
        
    
    //_gunner assignasgunner _vehicle;
    //_commander assignascommander _vehicle;
    //_driver assignasdriver _vehicle;
    
    
    
    // check to see whether group is an enemy of the player (for attack and avoidance maneuvers)
    // since countenemy doesn't count vehicles, and also only counts enemies if they're known, 
    // we just have to brute-force it for now, and declare *everyone* an enemy who isn't a civilian
    _issoldier = side _npc != civilian;
    
    _friends=[];
    _enemies=[];	
    _sharedenemy=0;
    //TODO: FIND A WAY TO DETERMINE ASSOCIATION OF RESISTANCE UNITS
    if (_issoldier) then {
        switch (side _npc) do {
            case west:
            { _friends=_friends+KRON_AllWest; _enemies=_enemies+KRON_AllEast+KRON_AllRes; _sharedenemy=0; };
            case east:
            { _friends=_friends+KRON_AllEast; _enemies=_enemies+KRON_AllWest+KRON_AllRes; _sharedenemy=1; };
            case resistance:
            { _enemies=_enemies+KRON_AllEast+KRON_AllWest; _sharedenemy=2; };
        };
        {
            _friends=_friends-[_x];
            //Hunter: Uhhh... no       
            //	_x disableAI "autotarget";
        } forEach _members;
    };
    sleep 0.1;
    
    // global unit variable to externally influence script 
    _named = false;
    _npcname = str(side _npc);
    if ("NAMED" in _UCthis) then {
        _named = true;
        _npcname = format["%1",_npc];
        _grpidx = _npcname;
    };
    // create global variable for this group
    call compile format ["KRON_UPS_%1=1",_npcname];
    
    // store some trig calculations
    _cosdir=cos(_areadir);
    _sindir=sin(_areadir);
    
    // minimum distance of new target position
    if (_rangeX==0) exitWith {
        hint format["UPS: Cannot patrol Sector: %1\nArea Marker doesn't exist",_areaname]; 
    };
    _mindist=(_rangeX^2+_rangeY^2)/4;
    
    // remember the original mode & speed
    _orgMode = behaviour _npc;
    _orgSpeed = speedmode _npc;
    _speedmode = _orgSpeed;
    
    // set first target to current position (so we'll generate a new one right away)
    _currPos = getpos _npc;
    _orgPos = _currPos;
    _orgWatch=[_currPos,50,getDir _npc] call KRON_relPos; 
    _orgDir = getDir _npc;
    _avoidPos = [0,0];
    _flankPos = [0,0];
    _attackPos = [0,0];
    
    _dist = 0;
    _lastdist = 0;
    _lastmove1 = 0;
    _lastmove2 = 0;
    _maxmove=0;
    _moved=0;
    
    _damm=0;
    _dammchg=0;
    _lastdamm = 0;
    _timeontarget = 0;
    
    _fightmode = "walk";
    _fm=0;
    _gothit = false;
    _hitPos=[0,0,0];
    _react = 99;
    _lastdamage = 0;
    _lastknown = 0;
    _opfknowval = 0;
    
    _sin90=1; _cos90=0;
    _sin270=-1; _cos270=0;
    
    // set target tolerance high for choppers & planes
    _closeenough=CLOSEENOUGH;
    if (_isplane) then {_closeenough=1000};
    
    sleep 0.1;
    // ***************************************** optional arguments *****************************************
    
    // wait at patrol end points
    _pause = if ("NOWAIT" in _UCthis) then {"NOWAIT"} else {"WAIT"};
    // don't move until an enemy is spotted
    _nomove  = if ("NOMOVE" in _UCthis) then {"NOMOVE"} else {"MOVE"};
    // don't follow outside of marker area
    _nofollow = if ("NOFOLLOW" in _UCthis) then {"NOFOLLOW"} else {"FOLLOW"};
    // share enemy info 
    _shareinfo = if ("NOSHARE" in _UCthis) then {"NOSHARE"} else {"SHARE"};
    // "area cleared" trigger activator
    _usetrigger = if ("TRIGGER" in _UCthis) then {"TRIGGER"} else {if ("NOTRIGGER" in _UCthis) then {"NOTRIGGER"} else {"SILENTTRIGGER"}};
    // suppress fight behaviour
    if ("NOAI" in _UCthis) then {_issoldier=false};
    // adjust cycle delay 
    _cycle = ["CYCLE:",5,_UCthis] call KRON_getArg;
    // drop units at random positions
    _initpos = "ORIGINAL";
    if ("RANDOM" in _UCthis) then {_initpos = "RANDOM"};
    if ("RANDOMUP" in _UCthis) then {_initpos = "RANDOMUP"}; 
    if ("RANDOMDN" in _UCthis) then {_initpos = "RANDOMDN"}; 
    // don't position groups or vehicles on rooftops
    if ((_initpos!="ORIGINAL") && ((!_isman) || (count _members)>1)) then {_initpos="RANDOMDN"};
    // set behaviour modes (or not)
    _noslow = if ("NOSLOW" in _UCthis) then {"NOSLOW"} else {"SLOW"};
    if (_noslow!="NOSLOW") then {
        _npc setbehaviour "safe"; 
        _npc setSpeedMode "limited";
        _speedmode = "limited";
        
        //    if(_vehicle iskindof "rhs_t80b_taki")  then {  hint "unit behaviour set to safe";};
    }; 
    
    // make start position random 
    if (_initpos!="ORIGINAL") then {
        // find a random position (try a max of 20 positions)
        _try=0;
        _bld=0;
        _bldpos=0;
        while {_try<20} do {
            _currPos=[_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
            if ((_initpos=="RANDOMUP") || ((_initpos=="RANDOM") && (random 1>.75))) then {
                _posinfo=[_currPos] call KRON_PosInfo;
                // _posinfo: [0,0]=no house near, [obj,-1]=house near, but no roof positions, [obj,pos]=house near, with roof pos
                _bld=_posinfo select 0;
                _bldpos=_posinfo select 1;
            };
            if (_isplane || _isboat || !(surfaceiswater _currPos)) then {
                if (((_initpos=="RANDOM") || (_initpos=="RANDOMUP")) && (_bldpos>0)) then {_try=99};
                if (((_initpos=="RANDOM") || (_initpos=="RANDOMDN")) && (_bldpos==0)) then {_try=99};
            };
            _try=_try+1;
        };
        if (_bldpos==0) then {
            if (_isman) then {
                {_x setPos _currPos} foreach units _npc; 
            } else {
                _npc setPos _currPos;
            };
        } else {
            // put the unit on top of a building
            _npc setPos (_bld buildingPos _bldpos); 
            _npc setUnitPos "up";
            _currPos = getPos _npc;
            _onroof = true;
            _exit=true; // don't patrol if on roof
        };
    };
    sleep 0.1;
    
    // track unit
    _track = 	if (("TRACK" in _UCthis) || (KRON_UPS_Debug>0)) then {"TRACK"} else {"NOTRACK"};
    _trackername = "";
    _destname = "";
    if (_track=="TRACK") then {
        _track = "TRACK";
        _trackername=format["trk_%1",_grpidx];
        _markerobj = createMarker[_trackername,[0,0]];
        _markerobj setMarkerShape "ICON";
        _markertype = if (isClass(configFile >> "cfgMarkers" >> "WTF_Dot")) then {"WTF_DOT"} else {"DOT"};
        _trackername setMarkerType _markertype;
        _markercolor = switch (side _npc) do {
            case west: {"ColorGreen"};
            case east: {"ColorRed"};
            case resistance: {"ColorBlue"};
            default {"ColorBlack"};
        };
        _trackername setMarkerColor _markercolor;
        _trackername setMarkerText format["%1",_grpidx];
        _trackername setmarkerpos _currPos; 
        _trackername setMarkerSize [.5,.5];
        
        _destname=format["dest_%1",_grpidx];
        _markerobj = createMarker[_destname,[0,0]];
        _markerobj setMarkerShape "ICON";
        _markertype = if (isClass(configFile >> "cfgMarkers" >> "WTF_Flag")) then {"WTF_FLAG"} else {"FLAG"};
        _destname setMarkerType _markertype;
        _destname setMarkerColor _markercolor;
        _destname setMarkerText format["%1",_grpidx];
        _destname setMarkerSize [.5,.5];
    };	
    sleep 0.1;
    
    // delete dead units
    _deletedead = ["DELETE:",0,_UCthis] call KRON_getArg;
    if (_deletedead>0) then {
        {_x addEventHandler['killed',format["[_this select 0,%1] spawn KRON_deleteDead",_deletedead]]}forEach _members;
    };
    
    // how many group clones?
    // TBD: add to global side arrays?
    _mincopies = ["MIN:",0,_UCthis] call KRON_getArg;
    _maxcopies = ["MAX:",0,_UCthis] call KRON_getArg;
    if (_mincopies>_maxcopies) then {_maxcopies=_mincopies};
    if (_maxcopies>140) exitWith {hint "Cannot create more than 140 groups!"};
    if (_maxcopies>0) then {
        if !(_isMan) exitWith {hint "Vehicles cannot be cloned."};
        _copies=_mincopies+round(random (_maxcopies-_mincopies));
        // any init strings?
        _initstr = ["INIT:","",_UCthis] call KRON_getArg;
        
        // name of clones
        _nameprefix = ["PREFIX:","UPSCLONE",_UCthis] call KRON_getArg;
        
        // create the clones
        for "_grpcnt" from 1 to _copies do {
            // group leader
            _unittype=typeof _npc;
            // copy groups
            if (isNil ("KRON_cloneindex")) then {
                KRON_cloneindex = 0;
            }; 
            // make the clones civilians
            // use random Civilian models for single unit groups
            if ((_unittype=="Civilian") && (count _members==1)) then {_rnd=1+round(random 20); if (_rnd>1) then {_unittype=format["Civilian%1",_rnd]}};
            
            _grp=createGroup side _npc;
            _lead = _grp createUnit [_unittype, getpos _npc, [], 0, "form"];
            KRON_cloneindex = KRON_cloneindex+1;
            _lead setVehicleVarName format["%1%2",_nameprefix,KRON_cloneindex];
            call compile format["%1%2=_lead",_nameprefix,KRON_cloneindex];
            _lead setBehaviour _orgMode;
            _lead setSpeedMode _orgSpeed;
            _lead setSkill skill _npc;
            _lead setVehicleInit _initstr;
            [_lead] join _grp;
            _grp selectLeader _lead;
            // copy team members (skip the leader)
            _c=0;
            {
                _c=_c+1;
                if (_c>1) then {
                    _newunit = _grp createUnit [typeof _x, getpos _x, [],0,"form"];
                    KRON_cloneindex = KRON_cloneindex+1;
                    _newunit setVehicleVarName format["%1%2",_nameprefix,KRON_cloneindex];
                    call compile format["%1%2=_newunit",_nameprefix,KRON_cloneindex];
                    _newunit setBehaviour _orgMode;
                    _newunit setSpeedMode _orgSpeed;
                    _newunit setSkill skill _x;
                    _newunit setVehicleInit _initstr;
                    [_newunit] join _grp;
                };
            } foreach _members;
            _nul=[_lead,_areamarker,_pause,_noslow,_nomove,_nofollow,_initpos,_track,_showmarker,_shareinfo,"DELETE:",_deletedead] execVM "ups.sqf";
            sleep 1;
            if(!isnil "zeu_Groups") then {if(!(_grp in zeu_Groups)) then {zeu_Groups set [count zeu_Groups, _grp];};};
        };	
        processInitCommands;
    };
    sleep 0.1;
    
    // units that can be left for area to be "cleared"
    _zoneempty = ["EMPTY:",0,_UCthis] call KRON_getArg;
    
    // create area trigger
    if (_usetrigger!="NOTRIGGER") then {
        _trgside = switch (side _npc) do { case west: {"WEST"}; case east: {"EAST"}; case resistance: {"GUER"}; case civilian: {"CIV"};};
        _trgname="KRON_Trig_"+_trgside+"_"+_areaname;
        _flgname="KRON_Cleared_"+_areaname;
        // has the trigger been created already?
        KRON_TRGFlag=-1;
        call compile format["%1=false",_flgname];
        call compile format["KRON_TRGFlag=%1",_trgname];
        if (isNil ("KRON_TRGFlag")) then {
            // trigger doesn't exist yet, so create one (make it a bit bigger than the marker, to catch path finding 'excursions' and flanking moves)
            call compile format["%1=createTrigger['EmptyDetector',[_centerX,_centerY]];",_trgname];
            call compile format["_areatrigger = %1",_trgname];
            call compile format["%1 setTriggerArea[_rangeX*1.5,_rangeY*1.5,markerDir _areaname,true]",_trgname];
            call compile format["%1 setTriggerActivation[_trgside,'PRESENT',true]",_trgname];
            call compile format["%1 setEffectCondition 'true'",_trgname];
            call compile format["%1 setTriggerTimeout [5,7,10,true]",_trgname];
            if (_usetrigger!="SILENTTRIGGER") then {
                _markerhide = [-_centerX,-_centerY];
                _markershow = [_centerX,_centerY];
                if (_showmarker=="HIDEMARKER") then {
                    _markershow = [-_centerX,-_centerY];
                };
                call compile format["%1 setTriggerStatements['count thislist<=%6', 'titletext [''SECTOR <%2> CLEARED'',''PLAIN''];''%2'' setmarkerpos %4;%3=true;', 'titletext [''SECTOR <%2> HAS BEEN RE-OCCUPIED'',''PLAIN''];''%2'' setmarkerpos %5;%3=false;']", _trgname,_areaname,_flgname,_markerhide,_markershow,_zoneempty];
            } else {
                call compile format["%1 setTriggerStatements['count thislist<=%3', '%2=true;', '%2=false;']", _trgname,_flgname,_zoneempty];
            };
        };
        sleep 0.1;
    };
    
    // init done
    _makenewtarget=true;
    _newpos=false;
    _targetPos = _currPos;
    _swimming = false;
    _waiting = if (_nomove=="NOMOVE") then {9999} else {0};
    
    // exit if something went wrong during initialization (or if unit is on roof)
    if (_exit) exitWith {
        if ((KRON_UPS_DEBUG>0) && !_onroof) then {hint "Initialization aborted"};
    };
    
    
    //Hunter'z funcs
    
    _fnc_generateNewTarget = {
        
        private ["_targetPos","_tries","_roadlist","_vehicle","_currPos","_centerX","_centerY","_rangeX","_rangeY","_cosdir","_sindir","_areadir","_mindist","_grp","_movepos"];
        
        _currPos = _this select 0;
        _centerX = _this select 1;
        _centerY = _this select 2;
        _rangeX = _this select 3;
        _rangeY = _this select 4;
        _cosdir = _this select 5;
        _sindir = _this select 6;
        _areadir = _this select 7;
        _mindist = _this select 8;
        _grp = _this select 9;
        _vehicle = _this select 10;
        
        switch (true) do {
            
            case (_grp getvariable ["Hz_Attacking",false]) : {
                
                _grp getvariable ["Hz_AI_lastDangerCausePos",(((leader _grp) neartargets viewDistance) select 0) select 0]
                
            };
            
            case (_grp getvariable ["Hz_Supporting",false]) : {
                
                //not called for support
                
            };
            
            case (_grp getvariable ["Hz_Patrolling",false]) : {
                
                // find a new target that's not too close to the current position
                _targetPos=_currPos;
                _tries=0;
                while {(([_currPos,_targetPos] call KRON_distancePosSqr) < _mindist) && (_tries<40)} do {
                    _tries=_tries+1;
                    // generate new target position (on the road)
                        _targetPos=[_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos; 
                        
                        if (surfaceIsWater _targetPos) then {_targetPos=_currPos;};
                        
                        if (!isnull _vehicle) then {
                            _roadlist = _targetPos nearRoads 100;
                            if (count _roadlist>0) then {
                                _targetPos = getPos (_roadlist select 0);
                                _tries=99;
                            };
                        };
                        //_road=[_targetPos,(_isplane||_isboat),_road] call KRON_OnRoad;
                        sleep 0.01;
                        
                };
                
                _targetPos
            };
            
            default {_currPos};
            
        } 
        
    };
    
    
    _fnc_checkConditions = {
        
        switch (true) do {
            
            case (_this getvariable ["Hz_Attacking",false]) : {
                
                    true
                
            };
            
            case (_this getvariable ["Hz_Supporting",false]) : {
                
                _this getvariable ["Hz_Attacking",false] //allow transition from attack->support when danger is over
                
            };
            
            case (_this getvariable ["Hz_Patrolling",false]) : {
                
                false
                
            };
            
            default {true};
            
        }
        
    };
    
    _fnc_dismount = {
        
        private ["_vehicle","_passengerarr","_driver","_timeout","_targetPos"];
        _vehicle = _this select 0;
        _passengerarr = _this select 1;
        _driver = _this select 2;
        
        if (((count _passengerarr) > 0) && (alive _vehicle)) then {
             
            _vehicle forcespeed 0;
            if ((typeof _vehicle) in (mps_opfor_ncov+mps_opfor_ins_truck+mps_opfor_truck+["BAF_Offroad_D"])) then {
                
                [_driver] allowgetin false;
                [_driver] orderGetIn false;
                unassignvehicle _driver; 
                dogetout _driver;
            };
            
            _passengerarr allowgetin false;
             _passengerarr orderGetIn false;
            { unassignVehicle _x; } forEach _passengerarr;
            dogetout _passengerarr;
            
            {_timeout = time + 5; waituntil {sleep 1; [_x] ordergetin false; (((vehicle _x) == _x) || (!(alive _x)) || (!(canmove _vehicle)) || (time > _timeout))};} foreach _passengerarr;
                    
            _vehicle domove (getpos _vehicle);
            _vehicle forceSpeed -1;
            sleep 1;
            {_x forcespeed -1;}foreach _passengerarr;
            _vehicle forcespeed 1;
        };
        
    };
    
    _fnc_mount = {
        
        private ["_vehicle","_passengerarr","_driver","_timeout","_targetPos"];           
        
        _vehicle = _this select 0;
        _passengerarr = _this select 1;
        _driver = _this select 2;   
        
        if (((count _passengerarr) > 0) && (alive _vehicle)) then {                      
            
            if(!canmove _vehicle) exitwith {};  
            
            dostop _driver;
            _vehicle forcespeed 0;
            
            if ( (typeof _vehicle) in (mps_opfor_ncov+mps_opfor_ins_truck+mps_opfor_truck+["BAF_Offroad_D"])) then {
                
                if(!alive _driver) then {_driver = _passengerarr select 0; _passengerarr = _passengerarr - [_driver];};

                [_driver] allowgetin true;
                [_driver] orderGetIn true;
                _driver assignasdriver _vehicle;   
                
            };
             
             _passengerarr allowgetin true;
             _passengerarr orderGetIn true;
            {_x assignascargo _vehicle;} foreach _passengerarr;
            
            {_timeout = time + 20; waituntil {sleep 1; [_x]ordergetin true; (((vehicle _x) == _vehicle) || (!(alive _x)) || (!(canmove _vehicle)) || (time > _timeout))};} foreach _passengerarr;
            
            _vehicle domove (getpos _vehicle);
            _vehicle forcespeed -1;
            sleep 1;
            _vehicle forcespeed -1;
            
        };
        
    };
    
    // ***********************************************************************************************************
    // ************************************************ MAIN LOOP ************************************************
    _loop=true;
    _currcycle=_cycle;
    
    _originalGroup setvariable ["Hz_Patrolling",true];
    
    while {_loop} do {
        
        sleep 0.01;
        // keep track of how long we've been moving towards a destination
        _timeontarget=_timeontarget+_currcycle;
        
        // anyone dead?
        _temp = +_members;
        {
            if (!alive _x) then {
                _members=_members-[_x]; 
                if(_x in _passengerarr) then {_passengerarr = _passengerarr - [_x];};
            };
            
        } foreach _temp;
        sleep 0.01;          
        
        //for mechanised check if vehicle still mobile
        if !(isNull _vehicle) then {
            
            if ((!(canmove _vehicle)) || (!(alive _vehicle))) then {
                
                { unassignVehicle _x; } forEach _passengerarr;
                unassignVehicle _driver;
                [_driver] orderGetIn false;
                unassignVehicle _commander;
                [_commander] orderGetIn false;
                unassignVehicle _gunner;
                [_gunner] orderGetIn false;
                
                //make it not mechanised anymore -- reset values to default
                _vehicle = objNull;
                _passengerarr = [];
                _allin = true;
                _allout = false;
                _istank = false;
                
            }else {_vehicle setfuel 1;};
        }; 
        
        
        
        // nobody left alive, exit routine
        if ((count _members)==0) then {
            _exit=true;
        } else {
            
            _npc = leader _originalgroup;
            if (isPlayer _npc) then {_exit=true};
            
        };
               
        //fockin' arma...
        _allin = true;
        {if((vehicle _x) == _x) then {_allin = false;};}foreach _passengerarr;
        
        // current position
        _currPos = getpos _npc;
        
        if((toupper (behaviour _npc)) == "COMBAT") then {
            
            //Attack mode
            
            if((!_allout) && !isnull _vehicle) then {
                [_vehicle, _passengerarr,_driver] call _fnc_dismount;
                _allout = true;
            };
            
            if(_originalGroup getvariable ["Hz_Attacking",false]) then { 
                
                //our previous WP was an attack type
                
                //check if danger exists
                if((time - (_originalGroup getvariable ["Hz_AI_lastTrueDangerTime",0])) < 120) then {
                    
                    //check conditions
                    if((_originalGroup call _fnc_checkConditions) || _makenewtarget) then {
                        _targetPos = [_currPos,_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir,_mindist,_originalGroup,_vehicle] call _fnc_generateNewTarget;
                        _newpos = true;
                        _makenewtarget=false;
                    };
                } else {
                    //danger doesn't exist -- switch to combat patrol
                    //arma... y u no have goto?	
                    _backupCheck = _originalGroup call Hz_func_ASR_check_AI_backup;

                    if(_backupCheck select 0) then {

                        //Support mode		

                        if(_originalGroup getvariable ["Hz_Supporting",false]) then { 

                            //our previous WP was a support type

                            //check conditions
                            if((_originalGroup call _fnc_checkConditions) || _makenewtarget) then {
                                _targetPos = _backupCheck select 1;
                                _newpos = true;
                            };

                        } else {

                            _originalGroup setvariable ["Hz_Patrolling",false];
                            _originalGroup setvariable ["Hz_Supporting",true];
                            _originalGroup setvariable ["Hz_Attacking",false];

                            _targetPos = _backupCheck select 1;
                            _newpos = true;

                        };

                    } else {

                        //Patrol mode		

                        if(_originalGroup getvariable ["Hz_Patrolling",false]) then { 

                            //our previous WP was a patrol type

                            //check conditions
                            if((_originalGroup call _fnc_checkConditions) || _makenewtarget) then {
                                _targetPos = [_currPos,_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir,_mindist,_originalGroup,_vehicle] call _fnc_generateNewTarget;
                                _newpos = true;
                                _makenewtarget=false;
                            };

                        } else {

                            _originalGroup setvariable ["Hz_Patrolling",true];
                            _originalGroup setvariable ["Hz_Supporting",false];
                            _originalGroup setvariable ["Hz_Attacking",false];

                            _targetPos = [_currPos,_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir,_mindist,_originalGroup,_vehicle] call _fnc_generateNewTarget;
                            _newpos = true;
                            _makenewtarget=false;

                        };

                    };
            
                };
                
                
            } else {
               
                if((time - (_originalGroup getvariable ["Hz_AI_lastTrueDangerTime",0])) < 120) then {
                    
                    _originalGroup setvariable ["Hz_Patrolling",false];
                    _originalGroup setvariable ["Hz_Supporting",false];
                    _originalGroup setvariable ["Hz_Attacking",true];
    
                    _targetPos = [_currPos,_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir,_mindist,_originalGroup,_vehicle] call _fnc_generateNewTarget;
                    _newpos = true;
                    _makenewtarget=false;
                    
                } else {
                    //danger doesn't exist -- switch to combat patrol
                    //arma... y u no have goto?	
                    _backupCheck = _originalGroup call Hz_func_ASR_check_AI_backup;

                    if(_backupCheck select 0) then {

                        //Support mode		

                        if(_originalGroup getvariable ["Hz_Supporting",false]) then { 

                            //our previous WP was a support type

                            //check conditions
                            if((_originalGroup call _fnc_checkConditions) || _makenewtarget) then {
                                _targetPos = _backupCheck select 1;
                                _newpos = true;
                            };

                        } else {

                            _originalGroup setvariable ["Hz_Patrolling",false];
                            _originalGroup setvariable ["Hz_Supporting",true];
                            _originalGroup setvariable ["Hz_Attacking",false];

                            _targetPos = _backupCheck select 1;
                            _newpos = true;

                        };

                    } else {

                        //Patrol mode		

                        if(_originalGroup getvariable ["Hz_Patrolling",false]) then { 

                            //our previous WP was a patrol type

                            //check conditions
                            if((_originalGroup call _fnc_checkConditions) || _makenewtarget) then {
                                _targetPos = [_currPos,_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir,_mindist,_originalGroup,_vehicle] call _fnc_generateNewTarget;
                                _newpos = true;
                                _makenewtarget=false;
                            };

                        } else {

                            _originalGroup setvariable ["Hz_Patrolling",true];
                            _originalGroup setvariable ["Hz_Supporting",false];
                            _originalGroup setvariable ["Hz_Attacking",false];

                            _targetPos = [_currPos,_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir,_mindist,_originalGroup,_vehicle] call _fnc_generateNewTarget;
                            _newpos = true;
                            _makenewtarget=false;

                        };

                    };	
                };
                
            };	
            
        } else {
                                
            if((!_allin) && !isnull _vehicle) then {
                [_vehicle, _passengerarr,_driver] call _fnc_mount;
                _allin = true;
            };	
                        
            _backupCheck = _originalGroup call Hz_func_ASR_check_AI_backup;
            
            if(_backupCheck select 0) then {
                
                //Support mode		
                
                if(_originalGroup getvariable ["Hz_Supporting",false]) then { 
                    
                    //our previous WP was a support type
                    
                    //check conditions
                    if((_originalGroup call _fnc_checkConditions) || _makenewtarget) then {
                        _targetPos = _backupCheck select 1;
                        _newpos = true;
                    };
                    
                } else {
                    
                    _originalGroup setvariable ["Hz_Patrolling",false];
                    _originalGroup setvariable ["Hz_Supporting",true];
                    _originalGroup setvariable ["Hz_Attacking",false];
                    
                    _targetPos = _backupCheck select 1;
                    _newpos = true;
                    
                };
                
                _originalGroup setbehaviour "AWARE";
                
            } else {
                
                //Patrol mode		
                
                if(_originalGroup getvariable ["Hz_Patrolling",false]) then { 
                    
                    //our previous WP was a patrol type
                    
                    //check conditions
                    if((_originalGroup call _fnc_checkConditions) || _makenewtarget) then {
                        _targetPos = [_currPos,_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir,_mindist,_originalGroup,_vehicle] call _fnc_generateNewTarget;
                        _newpos = true;
                        _makenewtarget=false;
                    };
                    
                } else {
                    
                    _originalGroup setvariable ["Hz_Patrolling",true];
                    _originalGroup setvariable ["Hz_Supporting",false];
                    _originalGroup setvariable ["Hz_Attacking",false];
                    
                    _targetPos = [_currPos,_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir,_mindist,_originalGroup,_vehicle] call _fnc_generateNewTarget;
                    _newpos = true;
                    _makenewtarget=false;
                    
                };
                
            };
            
        };
        
        if (!_newpos && !_exit) then {
            // track our progress since last cycle
            // distance to target
            _dist = [_currPos,_targetPos] call KRON_distancePosSqr;
            if (_lastdist==0) then {_lastdist=_dist};
            _moved = abs(_dist-_lastdist);
            // adjust the target tolerance for fast moving vehicles
            if (_moved>_maxmove) then {_maxmove=_moved; if ((_maxmove/40) > _closeenough) then {_closeenough=_maxmove/40}};
            // how much did we move in the last three cycles?
            _totmove=_moved+_lastmove1+_lastmove2;
            
            // we're either close enough, seem to be stuck, or are getting damaged, so find a new target 
            if ((_dist<=_closeenough) || (_totmove<0.2)) then {
                
                    //path-finding failed
                    if(((((expecteddestination (leader _grp)) select 0) select 2) > 10000) && (_totmove<0.2)) then {
										
										_howFar = 750;										
										if (_dist < 800) then {_howFar = 250;};

                    _somePos = [leader _originalGroup, _howFar, ([leader _originalGroup, _targetPos] call BIS_fnc_dirTo)] call BIS_fnc_relPos;
                    
                    //act as if we got new target. reset values and give move order
                    _dist=0; 
                    _moved=0; 
                    _lastmove1=10; 
                    _timeontarget = 0;
                    
                    _originalGroup move _somePos;

                    sleep 5;                                        

                } else {

                    _makenewtarget=true;

                };
                        
            } else {
                
               // {_x domove _targetPos;}foreach _members;
                    
            };
                        
        } else {
            
            //got new target. reset values and give move order       
						
            _dist=0; 
            _moved=0; 
            _lastmove1=10; 
            _timeontarget = 0;
            _newpos = false;
            
            _originalGroup move _targetPos;
            
            sleep 5;
            
          {(vehicle _x) domove _targetPos;} foreach _members;
            
        };
        sleep 0.01;  
        
        if(!_allin || _istank) then {
                
            if((behaviour _npc) == "COMBAT") then {

                _vehicle forcespeed -1;

            } else {

                if((_npc distance _vehicle) > 100) then {
                    
                  _vehicle forcespeed ((speed _npc)/1.5); 

                } else {

                    if((vehicle _npc) != _vehicle) then {
        
                        _vehicle forcespeed 1;
                    
                    } else {
                    
                        _vehicle forcespeed -1;
                    
                    };

                }; 

            };     
        };    
        
        if (!_exit) then {       
            
            //save values for next cycle
            _lastdist = _dist; _lastmove2 = _lastmove1; _lastmove1 = _moved;
            
        };   
        
        if ((_exit) || (isNil("_npc"))) then {
            _loop=false;
        } else {
            
            sleep _currcycle;
            
        //fockin' arma...
        _allout = true;
        {if((vehicle _x) != _x) then {_allout = false;};}foreach _passengerarr;
            
        };
    };
    
    /*
    if !(isNil("_npc")) then {
        {doStop _x; _x domove getPos _x; _x move getPos _x} forEach _members;
    };
    */
    
    _originalGroup setvariable ["Hz_Patrolling",false];
    KRON_UPS_Exited=KRON_UPS_Exited+1;
    if (_track=="TRACK") then {
        _trackername setMarkerType "Dot";
        _destname setMarkerType "Empty";
    };
    _friends=nil;
    _enemies=nil;
    
    