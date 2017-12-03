if(isServer) then {

//Sync weather effects with JIP and modify weather coefficients
nukeweather = true;
publicvariable "nukeweather";

[] spawn nukeWeatherCountdown;
    
        _randommarker = ["nukepos1","nukepos2","nukepos3","nukepos4","nukepos5","nukepos6"] call mps_getrandomelement;
        nuke_event = nuke_event + [_randommarker];
            _pos = markerpos _randommarker;
            nukepos setpos _pos;
                uisleep 4.8;
                    } else {uisleep 5;};

[] execvm "lk\nuke\damage.sqf";
if(isServer) exitwith {};

_nukedist = player distance nukepos;

if (_nukedist > (viewDistance/3)) then {setViewDistance (_nukedist*3);};

	setaperture 2;

	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [0.5];
	"dynamicBlur" ppEffectCommit 3;

	uisleep 0.1;

	"dynamicBlur" ppEffectAdjust [2];
	"dynamicBlur" ppEffectCommit 1;

	"dynamicBlur" ppEffectAdjust [1];
	"dynamicBlur" ppEffectCommit 4;

//nul = [nukepos] execvm "lk\nuke\damage.sqf";

//*******************************************************************
//*******************************************************************

_Cone = "#particlesource" createVehicleLocal getpos nukepos;
_Cone setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48], "", "Billboard", 1, 10, [0, 0, 0],
				[0, 0, 0], 0, 1.275, 1, 0, [40,80], [[0.25, 0.25, 0.25, 0], [0.25, 0.25, 0.25, 0.5], 
				[0.25, 0.25, 0.25, 0.5], [0.25, 0.25, 0.25, 0.05], [0.25, 0.25, 0.25, 0]], [0.25], 0.1, 1, "", "", nukepos];
_Cone setParticleRandom [2, [1, 1, 30], [1, 1, 30], 0, 0, [0, 0, 0, 0.1], 0, 0];
_Cone setParticleCircle [10, [-10, -10, 20]];
_Cone setDropInterval 0.005;

_top = "#particlesource" createVehicleLocal getpos nukepos;
_top setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 3, 48, 0], "", "Billboard", 1, 21, [0, 0, 0],
				[0, 0, 65], 0, 1.7, 1, 0, [100,80,110], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", nukepos];
_top setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_top setDropInterval 0.002;

_top2 = "#particlesource" createVehicleLocal getpos nukepos;
_top2 setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 3, 112, 0], "", "Billboard", 1, 22, [0, 0, 0],
				[0, 0, 60], 0, 1.7, 1, 0, [100,80,100], [[1, 1, 1, 0.5],[1, 1, 1, 0]], [0.07], 1, 1, "", "", nukepos];
_top2 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_top2 setDropInterval 0.002;

_smoke = "#particlesource" createVehicleLocal getpos nukepos;
_smoke setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
				[0, 0, 70], 0, 1.7, 1, 0, [50,20,120], 
				[[1, 1, 1, 0.4],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0]]
				, [0.5, 0.1], 1, 1, "", "", nukepos];
_smoke setParticleRandom [0, [10, 10, 15], [15, 15, 7], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_smoke setDropInterval 0.002;
/*
_Wave = "#particlesource" createVehicleLocal getpos nukepos;
_Wave setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48], "", "Billboard", 1, 20/2, [0, 0, 0],
				[0, 0, 0], 0, 1.5, 1, 0, [50, 100], [[0.1, 0.1, 0.1, 0.5], 
				[0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0.3], [1, 1, 1, 0]], [1,0.5], 0.1, 1, "", "", nukepos];
_Wave setParticleRandom [2, [20, 20, 20], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
_Wave setParticleCircle [50, [-80, -80, 2.5]];
_Wave setDropInterval 0.0002;
*/

_wave = "#particlesource" createvehiclelocal getpos nukepos;
_wave setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48], "", "Billboard", 1, 300, [0, 0, 0],
				[0, 0, 0], 0, 1.5, 1, 0, [50, 100], [[0.1, 0.1, 0.1, 0.5], [0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0.3], [1, 1, 1, 0]],
                                [1,0.5], 0.1, 1, "", "", nukepos];
_wave setParticleRandom [300, [20, 20, 20], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
_wave setParticleCircle [150, [-80, -80, 2.5]];
_wave setDropInterval 0.0002;

_light = "#lightpoint" createVehicleLocal [((getpos nukepos select 0)),(getpos nukepos select 1),((getpos nukepos select 2)+800)];
_light setLightAmbient[1500, 1200, 1000];
_light setLightColor[1500, 1200, 1000];
_light setLightBrightness 1000000.0;

//*******************************************************************
//*******************************************************************

0 setfog 0;
0 setrain 0;

uisleep 3;

_Wave setDropInterval 0.001;
deletevehicle _top;
deletevehicle _top2;

uisleep 2;

if (_nukedist < 600) then {player say "nuke2s"} else {player say "nuke1s"};

uisleep 1;

player spawn envi;


player spawn quake;


uisleep 1;
setaperture -1;

_top3 = "#particlesource" createVehicleLocal getpos nukepos;
_top3 setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 3, 48, 0], "", "Billboard", 1, 24, [0, 0, 450],
				[0, 0, 49], 0, 1.7, 1, 0, [120,130,150], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", nukepos];
_top3 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_top3 setDropInterval 0.002;

uisleep 4;
deletevehicle _top3;


//damage effects with local args
if(((nukepos distance player) < 1001)  && ((nukepos distance player) > 500)) then {if (player == (vehicle player)) then {player setvelocity [8.5 + random 4,(-8.5) - (random 4),5]; player setvectorup [0,-1,0.5]; player setdir random 360; player switchMove "aidlppnemstpsraswrfldnon0s";} else {_veh = vehicle player; _veh setvelocity [10,-10,1]; _veh setvectorup [0,-1,0.5]; _veh setdir random 360;
if((typeof _veh == "ATV_US_EP1") || (typeof _veh == "ATV_CZ_EP1") || (typeof _veh == "BAF_ATV_D")|| (_veh iskindof "Motorcycle") || (_veh iskindof "StaticWeapon")) then {(player setdamage ((getdammage player) + 0.8));}else{if(_veh iskindof "Car")then {(player setdamage ((getdammage player) + 0.5));};};
if ((alive player) && ((random 1) < 0.8)) then {[player, (random 60)] call ace_blackoutall;};
};};


uisleep 4;

if (player distance nukepos < 4000) then {
	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit 1;
};

_top4 = "#particlesource" createVehicleLocal getpos nukepos;
_top4 setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 3, 48, 0], "", "Billboard", 1, 22, [0, 0, 770],
				[0, 0, 30], 0, 1.7, 1, 0, [100,120,140], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", nukepos];
_top4 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_top4 setDropInterval 0.002;

//damage effects with local args
if(((nukepos distance player) < 2001) && ((nukepos distance player) > 1000)) then {if (player == (vehicle player)) then {player setvelocity [8.5 + random 2,(-8.5) - (random 2),3]; player setvectorup [0,-1,0.5]; player setdir random 360; player switchMove "aidlppnemstpsraswrfldnon0s";} else {_veh = vehicle player; _veh setvelocity [5,-5,0]; _veh setvectorup [0,-1,0.5]; _veh setdir random 360;
if((typeof _veh == "ATV_US_EP1") || (typeof _veh == "ATV_CZ_EP1") || (typeof _veh == "BAF_ATV_D")|| (_veh iskindof "Motorcycle") || (_veh iskindof "StaticWeapon")) then {(player setdamage ((getdammage player) + 0.5));}else{if(_veh iskindof "Car")then {(player setdamage ((getdammage player) + 0.2));};};
if ((alive player) && ((random 1) < 0.5)) then {[player, (random 60)] call ace_blackoutall;};
};};



uisleep 3;

_top4 setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 3, 48, 0], "", "Billboard", 1, 25, [0, 0, 830],
				[0, 0, 30], 0, 1.7, 1, 0, [100,120,140], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", nukepos];



_Wave setDropInterval 0.001*10;
_Wave setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48], "", "Billboard", 1, 20/2, [0, 0, 0],
				[0, 0, 0], 0, 1.5, 1, 0, [50, 100], [[0.1, 0.1, 0.1, 0.5], 
				[0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0.3], [1, 1, 1, 0]], [1,0.5], 0.1, 1, "", "", nukepos];
_Wave setParticleCircle [50, [-40, -40, 2.5]];

ashhandle = player spawn ash;
windv=true;
player spawn windef;
30 setovercast 0.2;


deleteVehicle _light;

60 setRain 0;

uisleep 4;
deletevehicle _top4;

_i = 0;

while {_i < 100} do
	{
	_light setLightBrightness (100.0 - _i)/100;
	_i = _i + 1;
	uisleep 0.1;
	};

for "_i" from 0 to 15 do {
	_smoke setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
					[0, 0, 60+_i], 0, 1.7, 1, 0, [40,15,120], 
					[[1, 1, 1, 0.4],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0]]
					, [0.5, 0.1], 1, 1, "", "", nukepos];
};


_timeNow = time;
waituntil {(time - _timeNow) > 180};

_smoke setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
				[0, 0, 30], 0, 1.7, 1, 0, [40,25+10,80], 
				[[1, 1, 1, 0.2],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0]]
				, [0.5, 0.1], 1, 1, "", "", nukepos];

_smoke setDropInterval 0.012;
_Cone setDropInterval 0.02;
_Wave setDropInterval 0.01;


uisleep 10;
deleteVehicle _Wave;
deleteVehicle _cone;
deleteVehicle _smoke;
//deletevehicle snow;

/*
uisleep 300;

"filmGrain" ppEffectEnable false;
uisleep 10;
"colorCorrections" ppEffectEnable false;
uisleep 10;
60 setovercast 0;
windv=false;
setwind [0,0,true];
*/