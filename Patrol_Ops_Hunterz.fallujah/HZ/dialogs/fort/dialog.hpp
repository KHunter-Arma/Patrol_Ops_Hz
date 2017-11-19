class HZ_fort_main {

	idd = -1;
	movingenable = true;

		class Controls {
			
			class HZ_fort_BOX: BOX
			{
				idc = 4131;
				x = 0.208334 * safezoneW + safezoneX;
				y = 0.150833 * safezoneH + safezoneY;
				w = 0.583334 * safezoneW;
				h = 0.7 * safezoneH;
				colorBackground[] = {0,0,0, 0.8 }; 
			};

			class HZ_fort_frame: RscFrame
			{
				idc = 4132;
				x = 0.208334 * safezoneW + safezoneX;
				y = 0.150833 * safezoneH + safezoneY;
				w = 0.583334 * safezoneW;
				h = 0.7 * safezoneH;
			};
			class HZ_fort_list: RscListbox
			{
				idc = 4133;
				text = "Available Fortifications";
				x = 0.220208 * safezoneW + safezoneX;
				y = 0.295832 * safezoneH + safezoneY;
				w = 0.263541 * safezoneW;
				h = 0.550833 * safezoneH;
				colorSelectBackground[] = {0.45703125,0.18359375,0,0.8};
				colorSelectBackground2[] = {0.45703125,0.18359375,0,0.8};
				colorSelect[] = {0.99609375, 0.98046875, 0.3671875, 1};
				colorSelect2[] = {0.99609375, 0.98046875, 0.3671875, 1};
				onLBSelChanged="call HZ_fort_update_dialog;";
			};
			class HZ_fort_pic: RscPicture
			{
				idc = 4134;
				text = "#(argb,8,8,3)color(0,0,0,0)";
				x = 0.502605 * safezoneW + safezoneX;
				y = 0.294167 * safezoneH + safezoneY;
				w = 0.270833 * safezoneW;
				h = 0.2375 * safezoneH;
			};
			class HZ_fort_cost: RscText
			{
				idc = 4135;
				text = "Item Cost: $";
				x = 0.484376 * safezoneW + safezoneX;
				y = 0.634367 * safezoneH + safezoneY;
				w = 0.23 * safezoneW;
				h = 0.0608335 * safezoneH;
				colorText[] = {0.99609375, 0.98046875, 0.3671875, 1};
				SizeEx = 0.03;
			};
			class HZ_fort_funds: RscText
			{
				idc = 4136;
				text = "Available Funds: $";
				x = 0.484375 * safezoneW + safezoneX;
				y = 0.699168 * safezoneH + safezoneY;
				w = 0.23 * safezoneW;
				h = 0.0616668 * safezoneH;
				colorText[] = {0.99609375, 0.98046875, 0.3671875, 1};
				SizeEx = 0.03;
			};
			class HZ_fort_button_buy: RscButton
			{
				idc = 4137;
				text = "Buy Item";
				x = 0.487188 * safezoneW + safezoneX;
				y = 0.774166 * safezoneH + safezoneY;
				w = 0.104688 * safezoneW;
				h = 0.0633334 * safezoneH;
				colorBackground[] = {0.45703125,0.18359375,0,0.8};
				colorBackgroundActive[] = {1,0,0,1};
				action = "call HZ_fort_spawnobject;";
			};
			class HZ_fort_version: RscText
			{
				idc = 4138;
				text = "v0.02";
				x = 0.716146 * safezoneW + safezoneX;
				y = 0.825833 * safezoneH + safezoneY;
				w = 0.0729165 * safezoneW;
				h = 0.0208333 * safezoneH;
			};
			class HZ_fort_button_exit: RscButton
			{
				idc = 4139;
				text = "Exit";
				x = 0.610104 * safezoneW + safezoneX;
				y = 0.775 * safezoneH + safezoneY;
				w = 0.104688 * safezoneW;
				h = 0.0633334 * safezoneH;
				colorBackground[] = {0.45703125,0.18359375,0,0.8};
				colorBackgroundActive[] = {1,0,0,1};
				action = "closeDialog 0;";
			};
			class HZ_fort_title: RscText
			{
				idc = 4140;
				text = "Hunter'z Fortification Store";
				style = ST_CENTER;
				colorBackground[] = {0,0,0,1};
				colorText[] = {0,1,1,.9};
				SizeEx = 0.1;
				x = 0.253126 * safezoneW + safezoneX;
				y = 0.169166 * safezoneH + safezoneY;
				w = 0.5 * safezoneW;
				h = 0.1 * safezoneH;
			};
			class HZ_fort_info: RscText
			{
				idc = 4141;
				text = "No information available.";
				x = 0.483438 * safezoneW + safezoneX;
				y = 0.549166 * safezoneH + safezoneY;
				w = 0.309896 * safezoneW;
				h = 0.0866667 * safezoneH;
			};



	};

};