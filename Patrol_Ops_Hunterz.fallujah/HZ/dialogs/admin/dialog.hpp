class HZ_admin {

	idd = -1;
	movingenable = true;

		class Controls {
			
			class HZ_admin_BOX: BOX
			{
				idc = 5131;
				x = 0.208334 * safezoneW + safezoneX;
				y = 0.150833 * safezoneH + safezoneY;
				w = 0.583334 * safezoneW;
				h = 0.7 * safezoneH;
				colorBackground[] = {0,0,0, 0.8 }; 
			};

			class HZ_admin_frame: RscFrame
			{
				idc = 5132;
				x = 0.208334 * safezoneW + safezoneX;
				y = 0.150833 * safezoneH + safezoneY;
				w = 0.583334 * safezoneW;
				h = 0.7 * safezoneH;
			};
			class HZ_admin_list: RscListbox
			{
				idc = 5133;
				text = "Players Online";
				x = 0.220208 * safezoneW + safezoneX;
				y = 0.295832 * safezoneH + safezoneY;
				w = 0.263541 * safezoneW;
				h = 0.550833 * safezoneH;
				colorSelectBackground[] = {0.45703125,0.18359375,0,0.8};
				colorSelectBackground2[] = {0.45703125,0.18359375,0,0.8};
				colorSelect[] = {0.99609375, 0.98046875, 0.3671875, 1};
				colorSelect2[] = {0.99609375, 0.98046875, 0.3671875, 1};
				onLBSelChanged="_this call HZ_admin_update_dialog;";
			};
			/*class HZ_admin_pic: RscPicture
			{
				idc = 5134;
				text = "#(argb,8,8,3)color(0,0,0,0)";
				x = 0.502605 * safezoneW + safezoneX;
				y = 0.294167 * safezoneH + safezoneY;
				w = 0.270833 * safezoneW;
				h = 0.2375 * safezoneH;
			};
			class HZ_admin_cost: RscText
			{
				idc = 5135;
				text = "Item Cost: $";
				x = 0.484376 * safezoneW + safezoneX;
				y = 0.634367 * safezoneH + safezoneY;
				w = 0.23 * safezoneW;
				h = 0.0608335 * safezoneH;
				colorText[] = {0.99609375, 0.98046875, 0.3671875, 1};
				SizeEx = 0.03;
			};
			class HZ_admin_funds: RscText
			{
				idc = 5136;
				text = "Available Funds: $";
				x = 0.484375 * safezoneW + safezoneX;
				y = 0.699168 * safezoneH + safezoneY;
				w = 0.23 * safezoneW;
				h = 0.0616668 * safezoneH;
				colorText[] = {0.99609375, 0.98046875, 0.3671875, 1};
				SizeEx = 0.03;
			};*/			
			class HZ_admin_button_arrest: RscButton
			{
				idc = 5137;
				text = "Arrest";
				x = 0.487188 * safezoneW + safezoneX;
				y = 0.774166 * safezoneH + safezoneY;
				w = 0.104688 * safezoneW;
				h = 0.0633334 * safezoneH;
				colorBackground[] = {1,0.05,0,0.8};
				colorBackgroundActive[] = {1,0,0,1};
				action = "Hz_admin_selected_UID spawn Hz_fnc_arrestPlayer";
			};
			/*
			class HZ_admin_button_ban: RscButton
			{
				idc = 5137;
				text = "Ban";
				x = 0.487188 * safezoneW + safezoneX;
				y = 0.774166 * safezoneH + safezoneY;
				w = 0.104688 * safezoneW;
				h = 0.0633334 * safezoneH;
				colorBackground[] = {1,0.05,0,0.8};
				colorBackgroundActive[] = {1,0,0,1};
				action = "call Hz_func_admin_ban";
			};
			*/
			class HZ_admin_version: RscText
			{
				idc = 5138;
				text = "v0.01 alpha";
				x = 0.746146 * safezoneW + safezoneX;
				y = 0.825833 * safezoneH + safezoneY;
				w = 0.0729165 * safezoneW;
				h = 0.0208333 * safezoneH;
			};
			class HZ_admin_button_release: RscButton
			{
				idc = 5139;
				text = "Release";
				x = 0.640104 * safezoneW + safezoneX;
				y = 0.775 * safezoneH + safezoneY;
				w = 0.104688 * safezoneW;
				h = 0.0633334 * safezoneH;
				colorBackground[] = {1,0.5,0,1};
				colorBackgroundActive[] = {1,0.3,0,1};
				action = "if (Hz_admin_selected_UID != ""0"") then {BanList = BanList - [Hz_admin_selected_UID]; publicvariable ""BanList""; hint ""Player released"";} else {hint ""Error\nNo player selected!""};";
			};
			/*			
			class HZ_admin_button_kick: RscButton
			{
				idc = 5139;
				text = "Kick";
				x = 0.640104 * safezoneW + safezoneX;
				y = 0.775 * safezoneH + safezoneY;
				w = 0.104688 * safezoneW;
				h = 0.0633334 * safezoneH;
				colorBackground[] = {1,0.5,0,1};
				colorBackgroundActive[] = {1,0.3,0,1};
				action = "call Hz_func_admin_kick";
			};
			*/
			class HZ_admin_title: RscText
			{
				idc = 5140;
				text = "Hunter'z Admin System";
				style = ST_CENTER;
				colorBackground[] = {0,0,0,1};
				colorText[] = {0.25,0.25,0.25,.9};
				SizeEx = 0.1;
				x = 0.253126 * safezoneW + safezoneX;
				y = 0.169166 * safezoneH + safezoneY;
				w = 0.5 * safezoneW;
				h = 0.1 * safezoneH;
			};
			class HZ_admin_button_exit: RscButton
			{
				idc = 5141;
				text = "Close Interface";
				x = 0.483438 * safezoneW + safezoneX;
				y = 0.549166 * safezoneH + safezoneY;
				w = 0.209896 * safezoneW;
				h = 0.0866667 * safezoneH;
				colorBackground[] = {0.2,0.2,1,1};
				colorBackgroundActive[] = {0,0,1,1};
				action = "closeDialog 0;";
			};


	};

};