#include "dialogs.cpp"
//View Distance Changer


class ViewDistanceChanger {
	idd = VDG_DIALOG_IDD; 
	movingEnable = 1;
	onLoad = "nul = [] spawn VDG_fnc_fillDistanceSelector;";
	class controlsBackground {
		class Border {
			type = CT_STATIC;
			idc = UNDEFINED_IDC;
			style = ST_HUD_BACKGROUND;
			font = FontM;
			colorText[] = { 0.6, 0.5, 0, 0.9 };
			colorBackground[] = {0.2, 0.2, 0, 0.8};
			sizeEx = 0.025;
			soundClick[] = {"ui\ui_ok", 0.2, 1};
			soundEnter[] = {"ui\ui_over", 0.2, 1};
			soundEscape[] = {"ui\ui_cc", 0.2, 1};
			soundPush[] = {"", 0.2, 1};
			text = "";
			
			x = 0.295;
			y = 0.605;
			w = 0.27;
			h = 0.26;
		};
		
		class Background {
			type = CT_STATIC;
			idc = UNDEFINED_IDC;
			style = ST_HUD_BACKGROUND;
			font = FontM;
			colorText[] = { 0.6, 0.5, 0, 0.9 };
			colorBackground[] = {0.1, 0.1, 0, 0.4};
			sizeEx = 0.025;
			soundClick[] = {"ui\ui_ok", 0.2, 1};
			soundEnter[] = {"ui\ui_over", 0.2, 1};
			soundEscape[] = {"ui\ui_cc", 0.2, 1};
			soundPush[] = {"", 0.2, 1};
			text = "";
			
			x = 0.3;
			y = 0.61;
			w = 0.26;
			h = 0.25;
		};
	};
	
	objects[] = { };
	class controls { 	
		class Title : RscStaticTextvdg {
			text = "Select viewdistance";
			x = 0.33;
			y = 0.63;
			w = 0.38;
			h = 0.05;
		
		};
		
		class Author : RscStaticTextvdg {
			text = "by [EVO] Curry";
			x = 0.33;
			y = 0.785;
			w = 0.38;
			h = 0.05;
		};
		
		class DistanceSelector : RscComboBoxvdg {
			idc = VDG_DISTSELECTOR_IDC;
			x = 0.33; 
			y = 0.68;
			w = 0.2; 
			h = 0.025;
		};
	
		class btnApply : RscButtonvdg {
			idc = VDG_BTNAPPLY_IDC;
			x = 0.33;
			y = 0.73;
			w = 0.08; 
			h = 0.04;
			text = "Apply";
			action = "nul = [] spawn VDG_fnc_onClickApply";
		};
		
		
		class btnCancel : RscButtonvdg {
			x = 0.44; 
			y = 0.73;
			w = 0.08; 
			h = 0.04;
			text = "Cancel";
			action = "nul = [] spawn VDG_fnc_onClickCancel";
		};
	}; 		
};