// Written by BON_IF
// Adapted by EightySix

disableSerialization;

_display = (_this select 0) select 0;

sliderSetRange [86003, 250 , 501 max visual_settings_maxallowed_viewdist];

sliderSetPosition [86003,vpos];

	while {dialog} do {

		vpos = (sliderPosition 86003);

		setviewdistance vpos;

		ctrlSetText [86002, format["Viewdistance %1m",(round vpos)]];

		if(GrassLayerchanged) then{

			switch GrassLayer do {

				case 4 : {setTerrainGrid 50};

				case 3 : {setTerrainGrid 25};

				case 2 : {setTerrainGrid 12.5};

				case 1 : {setTerrainGrid 6.25};

				case 0 : {setTerrainGrid 3.125};

				default {setTerrainGrid 6.25};

			};

			GrassLayerChanged = false;

		};

		sleep 0.01;

	};
