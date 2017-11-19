nukev=false;

nul = [lkcom] execVM "lk\menu\close_menu.sqf";


nul = [] execvm "lk\nuke\nuke_var.sqf";

hint "Click on the map to designate target-area";

nukepos = "HeliHEmpty" createVehicle (position player);




_path = "\ca\air2\cruisemissile\";
_pathS = _path + "data\scripts\";


nukehold=true;
titleText ["Click on the map to designate target-area","plain down"];
onMapSingleClick "nukepos setPos _pos; nukehold=false";
waituntil{!nukehold};
onMapSingleClick "";
titleText ["", "plain down"];

_dropPosition = getpos nukepos;
nukemarker = createMarkerLocal ["nukemarker", position nukepos]; 
hint "Nuclear Strike inbound at designated location";
nul = [lkcom] execVM "lk\menu\close_menu.sqf";
nukev=true;

nukemarker setmarkerposLocal getPos nukepos;
nukemarker setMarkerTypeLocal "Destroy";
nukemarker setMarkerTextLocal "  Nuclear Strike";
nukemarker setMarkerColorLocal "ColorRed";

_cruise = createVehicle ["Chukar",_dropPosition,[], 0, "FLY"];
_cruise setVectorDir [ 0.1,- 1,+ 0.5];
_cruise setPos [(getPos _cruise select 0),(getPos _cruise select 1),1000];
_cruise setVelocity [0,2,0] ;
_cruise flyInHeight 1000;
_cruise setSpeedMode "FULL";

sleep 0.5; 
_dropPosX = _dropPosition select 0;
_dropPosY = _dropPosition select 1;
_dropPosZ = _dropPosition select 2;

_droppos1 = [_dropPosX + 4, _dropPosY + 4, _dropPosZ];
_droppos2 = [_dropPosX + 8, _dropPosY + 8, _dropPosZ];

_planespawnpos = [_dropPosX , _dropPosY , _dropPosZ + 1000];

_misFlare = createVehicle ["cruiseMissileFlare1",_planespawnpos,[], 0, "NONE"];
_misFlare inflame true;
_cruise setVariable ["cruisemissile_level", false];
[_cruise, _misFlare] execVM (_pathS + "cruisemissileflare.sqf");
_cruise setObjectTexture [0, _path + "data\exhaust_flame_ca"];
[_cruise] execVM (_pathS + "exhaust1.sqf");
sleep 7;

waitUntil {!alive _cruise};
nul = [nukepos] execvm "lk\nuke\nuke.sqf";
deletevehicle _misFlare;
deletevehicle _cruise;
