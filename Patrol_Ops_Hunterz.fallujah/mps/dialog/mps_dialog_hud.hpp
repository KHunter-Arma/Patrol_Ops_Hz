class mps_hud_dialog {
	idd = 86001;
	movingEnable = true;
	enableSimulation = true;
	onLoad = "[_this] spawn mps_func_hud_menu_update";

	__EXEC( _xSpacing = 0.0075;  _ySpacing = 0.01;)
	__EXEC( _xInit = 12 * _xSpacing; _yInit = 18 * _ySpacing;)
	__EXEC( _windowWidth = 101; _windowHeight = 64;)
	__EXEC( _windowBorder = 1;)

	class controlsBackground {
		class Mainback : HW_RscPicture {
			idc = 0;
			x = 0.042;
			y = 0.101;
			w = 1.0;
			h = 0.836601;
			text = "\ca\ui\data\igui_background_addrecord_ca.paa";
		};	
		class SettingsTitle : HW_RscText {
			idc = 0;
			x = 0.15;
			y =  0.147;
			w = __EVAL(17.5 * _xSpacing);
			h = __EVAL(3 * _ySpacing);
			colorText[] = Color_White;
			colorBackground[] = { 1, 1, 1, 0 };
			sizeEx = 0.03;
			text = $STR_Client_HUD_view;
		};
		class ViewdistTitle : HW_RscText {
			idc = 86002;
			x = 0.15;
			y =  0.26;
			w = __EVAL(35 * _xSpacing);
			h = __EVAL(3 * _ySpacing);
			colorText[] = Color_White;
			colorBackground[] = { 1, 1, 1, 0 };
			sizeEx = 0.035;
			text = "";
		};
		class GrasslayerTitle : HW_RscText {
			idc = 0;
			x = 0.5;
			y =  0.195;
			w = __EVAL(35 * _xSpacing);
			h = __EVAL(3 * _ySpacing);
			colorText[] = Color_White;
			colorBackground[] = { 1, 1, 1, 0 };
			sizeEx = 0.035;
			text = $STR_Client_HUD_grass;
		};
	};
	class controls
	{
		class ViewSlider : HW_RscSlider {
			idc = 86003;
			x = 0.0606555;
			y = 0.34;
			w = 0.45;
			h = __EVAL(5 * _ySpacing);
		};
		class GrassList {
			idc = 86004;
			type = CT_TOOLBOX;
			style = ST_LEFT;
			x = 0.6; y = 0.235;
			w = __EVAL(35 * _xSpacing); h = __EVAL(20 * _ySpacing);
			colorText[] = Color_White;
			colorTextSelect[] = {0, 0, 1, 1};
			colorSelect[] = {0, 0, 0, 1};
			colorTextDisable[] = {0, 0, 0, 1};
			color[] = { 0, 0, 0, 1 };
			colorDisable[] = { 0, 0, 0, 1 };
			coloSelectedBg[] = { 1, 1, 1, 0 };
			font = "Zeppelin32";
			sizeEx = 0.025;
			rows = 5;
			columns = 1;
			strings[] = {"Ultra","High","Medium","Low","Off"};
			onToolBoxSelChanged = "GrassLayer = (_this select 1); GrassLayerChanged=true;";
		};
		class hudButton: HW_RscGUIShortcutButton {
			idc = 1;
			x = 0.375;
			y = 0.465;
			text = $STR_Client_HUD_toggle;
			onButtonClick = "if(!mps_hud_active) then {mps_hud_active = true;}else{mps_hud_active = false; };";
		};
		class CloseButton: HW_RscGUIShortcutButton {
			idc = 0;
			x = 0.595;
			y = 0.465;
			text = "Close";
			onButtonClick = "CloseDialog 0";
		};
	};
};