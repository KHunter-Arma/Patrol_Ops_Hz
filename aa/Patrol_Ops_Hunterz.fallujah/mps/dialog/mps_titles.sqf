//class RscTitles {
	class infomessage {
		idd = 101;
		movingEnable=0;
		duration = 1000000000;
		fadein=0;
		name="infomessage";
		controlsBackground[] = {"crewtext","rankoverlay"};
		onLoad = "uiNamespace setVariable ['crewdisplay', _this select 0];";
		onunLoad = "uiNamespace setVariable ['crewdisplay', objnull];";
		class crewtext {
			idc = 102;
			type = CT_STRUCTURED_TEXT;
			style = ST_RIGHT;
			x = safeZoneX;
			y = (safeZoneY + 0.4);
			w = safeZoneW;
			h = 0.5;
			size = 0.02;
			colorBackground[] = {0,0,0,0};
			colortext[] = {0,0,0,0.7};
			text ="";
			class Attributes {
				align = "right";
				valign = "middle";
				size = "1";
				shadow = true;
				shadowColor = "#2D2D2D";
			};
		};
		class rankoverlay {
			idc = 86041;
			type = CT_STRUCTURED_TEXT;
			style = ST_CENTER;
			x = safeZoneX;
			y = (safeZoneY);
			w = safeZoneW;
			h = 0.5;
			size = 0.02;
			colorBackground[] = {0,0,0,0};
			colortext[] = {0,0,0,0.7};
			text = $STR_MISSION_NAME;
			class Attributes {
				align = "center";
				valign = "middle";
				size = "1";
				shadow = true;
				shadowColor = "#2D2D2D";
			};
		};
	};
	class XProgressBar {
		idd = -1;
		movingEnable = 0;
		objects[] = {};
		duration = 1e+011;
		name = "XProgressBar";
		onLoad="uiNamespace setVariable ['DPROGBAR', _this select 0]";
		onUnload = "";
		controlsBackground[] = {};
		class controls {
			class XProgressBarBackground {
				idc = 3600;
				type = CT_STATIC;
				style = 128;
				x = 0.3;
				y = "((SafeZoneH + SafeZoneY) - (1 + 0.165))*-1";
				w = 0.4;
				h = 0.04;
				sizeEx = 0.023;
				colorText[] = {0, 0, 0, 1};
				colorBackground[] = {0,0,0,0.5};
				font = "Zeppelin32";
				text = "";
				shadow = 2;
			};
			class XProgressBarX {
				idc = 3800;
				type = CT_STATIC;
				style = 128;
				x = 0.31;
				y = "((SafeZoneH + SafeZoneY) - (1 + 0.170))*-1";
				w = 0.02;
				h = 0.03;
				sizeEx = 0.023;
				colorText[] = {0, 0, 0, 1};
				colorBackground[] = {0.543, 0.5742, 0.4102, 0.8};
				font = "Zeppelin32";
				shadow = 2;
				text = "";
			};
			class XProgress_Label {
				idc = 3900;
				type = CT_STATIC;
				style = ST_LEFT;
				x = 0.405;
				y = "((SafeZoneH + SafeZoneY) - (1 + 0.175))*-1";
				w = 0.2;
				h = 0.02;
				sizeEx = 0.035;
				colorBackground[] = {1,1,1,0};
				colorText[] = {0.543, 0.5742, 0.4102, 1.0};
				font = "Zeppelin32";
				shadow = 2;
				text = "Capturing...";
			};
		};
	};

	class BBRscStructuredText {
		access = 0;
		type = 13;
		idc = -1;
		style = 0;
		colorText[] = {0.8784,0.8471,0.651,1};
		class Attributes {
			font = "Zeppelin32";
			color = "#e0d8a6";
			align = "center";
			shadow = 1;
		};
		x = 0;
		y = 0;
		h = 0.035;
		w = 0.1;
		text = "";
		size = 0.03921;
		shadow = 2;
	};

	class po2_3dhud_Text {
		idd = -1;
		movingEnable = 1;
		duration = 1e+011;
		fadein = 0;
		fadeout = 0;
		name = "d_BIS_dynamicText";
		onload = "uinamespace setvariable ['po2_3dhud',_this select 0];";
		onUnload = "uinamespace setvariable ['po2_3dhud',nil];";
		class controls {
			class Text: BBRscStructuredText {
				idc = 9999;
				style = "1 + 16";
				text = "";
				x = 0;
				y = 0.45;
				w = 1;
				h = 10000;
				colorText[] = {1,1,1,1};
				colorBackground[] = {0,0,0,0};
				size = "(0.05 / 1.17647) * safezoneH";
				sizeEx = 0.4;
				class Attributes {
					font = "TahomaB";
					color = "#ffffff";
					align = "center";
					shadow = 0;
					valign = "top";
				};
			};
		};
	};
//};