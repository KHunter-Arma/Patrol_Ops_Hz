halocarried = true;
gogogo = false;

_plane = _this select 0;
_guy = _this select 1;
_type = typeof _plane;

if (_guy in crew _plane) then {moveout _guy;};

if(_type == "C130J_US_EP1") then {

_side = 1;
_dist = 2.5;
if (random 1 < 0.5) then{_side = -1;};
_dist = _dist + (random 7) - (random 7);

_guy attachto [_plane,[_side,_dist,-4.5]];
} else { //MV22

_dist = 2.5;
_dist = _dist + (random 5) - (random 5);

_guy attachto [_plane,[0,_dist,-2.5]];


};

sleep 1;
_guy setdir 180;


[_plane, _guy]spawn {
                                    
                                  //private ["_plane","_guy"];
                                   
                                  _plane = _this select 0;
                                  _guy = _this select 1;
                                  _initdamage = getdammage _plane;

                                    _ehk = _plane addMPEventHandler ["mpkilled", {_guy setdamage 0.95; detach _guy;}];
                                  damagedc130 = false;
                                   _ehh = _plane addMPEventHandler ["mphit", {damagedc130 = true;}];
                                   
                                   // damage handler
                                   while {halocarried} do {
                                       
                                     // _ehf = _guy addeventhandler ["fired",{_guy setdammage (getdammage _guy + 0.1); _plane setdammage (getdammage _plane + 0.1);}];     
                                       
                                       if (damagedc130) then {
                                           
                                               _guy setdamage ((getdammage _plane) - _initdamage);
                                       
                                       };
                                       
                                       sleep 0.1;
                                       
                                       if !(alive _plane) exitwith {_guy setdamage 0.95; detach _guy;};
                                           
                                           };
                                           
                                     _plane removeAllMPEventHandlers  "mpkilled";
                                     _plane removeAllMPEventHandlers "mphit";
                                     damagedc130 = false;
                                     //_guy removeeventhandler ["fired", _ehf];
                                                
                                };

hint "Wait for the pilot to open the ramps before jumping. When you're ready to jump, press 0-0-1 to go!";

waituntil {sleep 0.5; gogogo};

detach _guy;
sleep 0.5;
_guy execVM "x\ace\addons\sys_eject\jumpout_cord.sqf";
halocarried = false;

//below action replaced by trigger in the mission because you can't use action menu while attached to something
//_guy addaction ["<t color='#ff0000'>GO GO GO</t>","logistics\halojump.sqf","",0,true,true,""];