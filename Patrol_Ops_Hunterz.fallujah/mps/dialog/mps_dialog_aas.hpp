class mps_aas_loadout {
	idd = 86800;
	movingEnable = 1;
	onLoad = "nul = [] spawn mps_func_aas_gui;";
	objects[] = {};
	class controlsBackground {
		class aasback : HW_RscPicture {
			idc = -1;
			x = 0.2; y = 0.05;
			w = 1.0; h = 1.0;
			text = "\ca\ui\data\ui_missions_background_ca.paa";
		};
	};

	class controls {
		class equiploadout : HW_RscGUIShortcutButton {
			idc = 86801;
			text = "Equip Loadout"; 
			action = "if(mps_ace_enabled) then { [] spawn mps_func_aas_loadout_ace; } else { [] spawn mps_func_aas_loadout; };";
			x = 0.64;
			y = 0.80;
			default = true;
		};
		class cancelbutton : HW_RscGUIShortcutButton {
			idc = 86802;
			text = "Cancel"; 
			action = "closeDialog 0;";
			x = 0.45;
			y = 0.80;
			default = true;
		};
		class Class : HW_RscStructuredText {
			x = 0.23; y = 0.09;
			w = 0.45; h = 0.20;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "Aircraft Armourment System";
		};
		class point_0_desc : HW_RscStructuredText {
			x = 0.25; y = 0.19;
			w = 0.45; h = 0.20;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "Main Gun:";
		};
		class point_1_desc : HW_RscStructuredText {
			x = 0.40; y = 0.29;
			w = 0.45; h = 0.20;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "Load Points: ";
		};
		class point_5_desc : HW_RscStructuredText {
			x = 0.25; y = 0.59;
			w = 0.45; h = 0.20;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "Flares:";
		};
		class fuel_level_desc : HW_RscStructuredText {
			x = 0.25; y = 0.70;
			w = 0.45; h = 0.20;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.543, 0.5742, 0.4102, 1};
			text = "Fuel:";
		};

		class point_0 : HW_RscComboBox {
			idc = 86810;
			x = 0.40; y = 0.19;
			w = 0.25; h = 0.045;
		};
		class point_1 : HW_RscComboBox {
			idc = 86811;
			x = 0.25; y = 0.35;
			w = 0.25; h = 0.045;
		};
		class point_2 : HW_RscComboBox {
			idc = 86812;
			x = 0.55; y = 0.35;
			w = 0.25; h = 0.045;
		};
		class point_3 : HW_RscComboBox {
			idc = 86813;
			x = 0.40; y = 0.42;
			w = 0.25; h = 0.045;
		};
		class point_4 : HW_RscComboBox {
			idc = 86814;
			x = 0.40; y = 0.49;
			w = 0.25; h = 0.045;
		};
		class point_5 : HW_RscComboBox {
			idc = 86815;
			x = 0.40; y = 0.59;
			w = 0.25; h = 0.045;
		};
		class fuel_level : HW_RscSlider {
			idc = 86816;
			x = 0.4; y = 0.7;
		};
	};
};