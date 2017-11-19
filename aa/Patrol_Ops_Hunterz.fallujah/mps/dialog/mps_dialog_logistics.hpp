class mps_logistics_dialog {
	idd = 86601;
	name = "mps_logistics_dialog";
	movingEnable = false;
	controlsBackground[] = {mps_logistics_gui_background};
	objects[] = {};
	controls[] = {mps_logistics_gui_title,mps_logistics_gui_contents,mps_logistics_gui_content_list,mps_logistics_gui_credits,mps_logistics_gui_unload,mps_logistics_gui_close};
	class mps_logistics_gui_text {
		idc = -1;
		type = CT_STATIC;
		style = ST_LEFT;
		x = 0.0; w = 0.3;
		y = 0.0; h = 0.03;
		sizeEx = 0.023;
		colorBackground[] = {0.5, 0.5, 0.5, 0};
		colorText[] = {0.85, 0.85, 0.85, 1};
		font = "Zeppelin32";
		text = "";
	};
	class mps_logistics_gui_button {
		idc = -1;
		type = 16;
		style = 0;
		text = "btn";
		action = "";
		x = 0;
		y = 0;
		w = 0.23;
		h = 0.11;
		size = 0.03921;
		sizeEx = 0.03921;
		color[] = {0.543, 0.5742, 0.4102, 1.0};
		color2[] = {0.95, 0.95, 0.95, 1};
		colorBackground[] = {1, 1, 1, 1};
		colorbackground2[] = {1, 1, 1, 0.4};
		colorDisabled[] = {1, 1, 1, 0.25};
		periodFocus = 1.2;
		periodOver = 0.8;
		class HitZone {
			left = 0.004;
			top = 0.029;
			right = 0.004;
			bottom = 0.029;
		};
		class ShortcutPos {
			left = 0.0145;
			top = 0.026;
			w = 0.0392157;
			h = 0.0522876;
		};
		class TextPos {
			left = 0.05;
			top = 0.034;
			right = 0.005;
			bottom = 0.005;
		};
		textureNoShortcut = "";
		animTextureNormal = "\ca\ui\data\ui_button_normal_ca.paa";
		animTextureDisabled = "\ca\ui\data\ui_button_disabled_ca.paa";
		animTextureOver = "\ca\ui\data\ui_button_over_ca.paa";
		animTextureFocused = "\ca\ui\data\ui_button_focus_ca.paa";
		animTexturePressed = "\ca\ui\data\ui_button_down_ca.paa";
		animTextureDefault = "\ca\ui\data\ui_button_default_ca.paa";
		period = 0.4;
		font = "Zeppelin32";
		soundEnter[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
		soundPush[] = {"\ca\ui\data\sound\new1", 0.09, 1};
		soundClick[] = {"\ca\ui\data\sound\mouse3", 0.07, 1};
		soundEscape[] = {"\ca\ui\data\sound\mouse1", 0.09, 1};
		class Attributes {
			font = "Zeppelin32";
			color = "#E5E5E5";
			align = "left";
			shadow = "true";
		};
		class AttributesImage {
			font = "Zeppelin32";
			color = "#E5E5E5";
			align = "left";
			shadow = "true";
		};
	};
	class mps_logistics_gui_list {
		type = CT_LISTBOX;
		style = ST_LEFT;
		idc = -1;
		text = "";
		w = 0.275;
		h = 0.04;
		colorSelect[] = {1, 1, 1, 1};
		colorText[] = {1, 1, 1, 1};
		colorBackground[] = {0.8,0.8,0.8,1};
		colorSelectBackground[] = {0, 0, 0, 1};
		colorScrollbar[] = {0.2, 0.2, 0.2, 1};
		arrowEmpty = "\ca\ui\data\ui_arrow_combo_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_combo_active_ca.paa";
		wholeHeight = 0.45;
		rowHeight = 0.06;
		color[] = {0.8, 0.8, 0.8, 1};
		colorActive[] = {0,0,0,1};
		colorDisabled[] = {0,0,0,0.3};
		font = "Zeppelin32";
		sizeEx = 0.035;
		soundSelect[] = {"",0.1,1};
		soundExpand[] = {"",0.1,1};
		soundCollapse[] = {"",0.1,1};
		maxHistoryDelay = 1;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
		class ScrollBar {
			color[] = {1, 1, 1, 0.6};
			colorActive[] = {1, 1, 1, 1};
			colorDisabled[] = {1, 1, 1, 0.3};
			thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
			arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
			arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
			border = "\ca\ui\data\ui_border_scroll_ca.paa";
		};
	};
	class mps_logistics_gui_background {
		idc = -1;
		type = CT_STATIC;
		style = ST_PICTURE;
		x = 0.25; w = 0.5;
		y = 0.1; h = 0.8;
		colorText[] = {1, 1, 1, 1};
		colorBackground[] = {0,0,0,0};
		text = "\ca\ui\data\ui_gameoptions_background_ca.paa";
		font = "Zeppelin32";
		sizeEx = 0.032;
	};
	class mps_logistics_gui_title : mps_logistics_gui_text {
		idc = 86605;
		x = 0.28; w = 0.4;
		y = 0.125; h = 0.05;
		sizeEx = 0.05;
		text = "";
	};
	class mps_logistics_gui_contents : mps_logistics_gui_text {
		idc = 86602;
		x = 0.255; w = 0.4;
		y = 0.185; h = 0.03;
		sizeEx = 0.03;
		text = "";
	};
	class mps_logistics_gui_content_list : mps_logistics_gui_list {
		idc = 86603;
		x = 0.26; w = 0.45;
		y = 0.22; h = 0.44;
		onLBDblClick = "call mps_moveable_unload;";
	};
	class mps_logistics_gui_credits : mps_logistics_gui_text {
		idc = 86606;
		x = 0.250; w = 0.19;
		y = 0.737; h = 0.02;
		sizeEx = 0.02;
		colorText[] = {0.5, 0.5, 0.5, 0.75};
		text = "";
	};
	class  mps_logistics_gui_unload : mps_logistics_gui_button {
		idc = 86604;
		x = 0.355; w = 0.18;
		y = 0.66;
		sizeEx = 0.02;
		text = "";
		action = "call mps_moveable_unload;";
	};
	class mps_logistics_gui_close : mps_logistics_gui_button {
		idc = 86607;
		x = 0.537; w = 0.16;
		y = 0.66;
		text = "";
		action = "closeDialog 0;"; 
	};
};