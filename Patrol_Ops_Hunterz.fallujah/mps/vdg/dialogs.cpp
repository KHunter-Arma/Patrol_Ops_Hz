//Resources
#include "defines.cpp"

class RscStaticTextvdg {
	type = CT_STATIC;
	idc = UNDEFINED_IDC;
	style = ST_LEFT;
	font = FontM;
	colorText[] = { 0.6, 0.5, 0, 0.9 };
	colorBackground[] = {0, 0, 0, 0};
	sizeEx = 0.03;
	soundClick[] = {"ui\ui_ok", 0.2, 1};
	soundEnter[] = {"ui\ui_over", 0.2, 1};
	soundEscape[] = {"ui\ui_cc", 0.2, 1};
	soundPush[] = {"", 0.2, 1};
	text = "StaticText";
};

class RscButtonvdg {
	idc = UNDEFINED_IDC;
	type = CT_BUTTON;
	style = ST_CENTER;
	default = false;
	font = FontM;
	sizeEx = 0.03;
	colorText[] = { 0.6, 0.5, 0, 1 };
	colorFocused[] = { 0.4, 0.4, 0, 1 }; 
	colorDisabled[] = { 0.2, 0.2, 0, 1 };
	colorBackground[] = { 0.4, 0.4, 0, 0.8 };
	colorBackgroundDisabled[] = {0.4, 0.4, 0, 0.9 };
	colorBackgroundActive[] = { 0.4, 0.4, 0, 1 };
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorShadow[] = { 0, 0, 0, 0.5 };
	colorBorder[] = { 0, 0, 0, 1 };
	borderSize = 0;
	soundEnter[] = { "", 0, 1 };  // no sound
	soundPush[] = { "", 0.1, 1 };
	soundClick[] = { "", 0, 1 };  // no sound
	soundEscape[] = { "", 0, 1 };  // no sound
	text = "";
};

class RscPicturevdg {
	type = CT_STATIC;
	idc = UNDEFINED_IDC;
	style = ST_PICTURE;
	colorText[] = {0.75, 0.75, 0.75, 1};
	colorBackground[] = {0, 0, 0, 0};
	font = "Bitstream";
	sizeEx = 0.025;
	soundClick[] = {"ui\ui_ok", 0.2, 1};
	soundEnter[] = {"ui\ui_over", 0.2, 1};
	soundEscape[] = {"ui\ui_cc", 0.2, 1};
	soundPush[] = {"", 0.2, 1};
	w = 0.275;
	h = 0.04;
	text = "";
};

class RscListBoxvdg {
	idc = UNDEFINED_IDC;
	type = CT_LISTBOX;
	style = ST_SINGLE + LB_TEXTURES;
	font = "Zeppelin32";
	sizeEx = 0.04221;
    rowHeight = 0.03;
	color[] = {1, 1, 1, 1};
	colorText[] = {1, 1, 1, 0.75};
	colorScrollbar[] = {0.95, 0.95, 0.95, 1};
	colorSelect[] = {0.95, 0.95, 0.95, 1};
	colorSelect2[] = {0.95, 0.95, 0.95, 1};
	colorSelectBackground[] = {0.6, 0.8392, 0.4706, 1.0};
	colorSelectBackground2[] = {0.6, 0.8392, 0.4706, 1.0};
	columns[] = {0.1, 0.7, 0.1, 0.1};
	period = 0;
	colorBackground[] = {0, 0, 0, 1};
	maxHistoryDelay = 1.0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	soundSelect[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\ca\ui\data\igui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\igui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\igui_arrow_top_ca.paa";
		border = "\ca\ui\data\igui_border_scroll_ca.paa";
	};
};

class RscComboBoxvdg {
	idc = UNDEFINED_IDC;
	type = CT_COMBO;
	style = ST_LEFT;
	
	font = "TahomaB";
	sizeEx = 0.025;
	
	rowHeight = 0.025;
	wholeHeight = 4 * 0.025;
	
	color[] = {1, 1, 1, 1};
	colorText[] = {1, 1, 1, 0.75};
	colorScrollbar[] = {0.95, 0.95, 0.95, 1};
	colorSelect[] = {0.95, 0.95, 0.95, 1};
	colorSelect2[] = {0.95, 0.95, 0.95, 1};
	colorSelectBackground[] = {0.6, 0.6, 0.4706, 1.0};
	colorSelectBackground2[] = {0.6, 0.6, 0.4706, 1.0};
	columns[] = {0.1, 0.7, 0.1, 0.1};
	period = 0;
	colorBackground[] = {0, 0, 0, 1};
	maxHistoryDelay = 1.0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	soundSelect[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	soundExpand[] = {"", 0.09, 1};
	soundCollapse[] = {"", 0.09, 1};
	arrowFull = "\ca\ui\data\igui_arrow_top_active_ca.paa";
	arrowEmpty = "\ca\ui\data\igui_arrow_top_ca.paa";
	
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\ca\ui\data\igui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\igui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\igui_arrow_top_ca.paa";
		border = "\ca\ui\data\igui_border_scroll_ca.paa";
	};
};