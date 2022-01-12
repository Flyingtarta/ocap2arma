class listGZ {
	idd = 1314;
	type = 0;
	style = "0x10 + 0x20";
	controls[]=
	{
		//ListOfGZ_BACKGROUND,
		ListOfGZ,
		O2A_OK,
		O2A_cancel
	};

	class ControlsBackground {
		class ListOfGZ_BACKGROUND: RscText
		{
			idc = -1;
			//type = 0;
			//text = "#(argb,8,8,3)color(0,0,0,0.5)";
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.422812 * safezoneW;
			h = 0.341 * safezoneH;
			//syle = "0x10 + 0x20";
			//background = 1;
			colorBackground[] = {0,0,0,0.5};
		};
	};


	class ListOfGZ: RscListbox
	{
		idc = 1500;
		onLoad = "UiNamespace setvariable ['O2A_VAR_GZLIST_CTRL',_this#0]";
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.225 * safezoneH + safezoneY;
		w = 0.4125 * safezoneW;
		h = 0.264 * safezoneH;

		class columns {
			class Filename{
				x = 0.494844 * safezoneW + safezoneX;
				h = (0.341 * safezoneH) +  ( ( 0.341 * safezoneH) /3) ;
			};

			class MissionName {
				x = (0.494844 * safezoneW + safezoneX)*2;
				h = (0.341 * safezoneH) +  ( ( 0.341 * safezoneH) /2) ;
			};

			class Map {
				x = (0.494844 * safezoneW + safezoneX)*3;
				h = (0.341 * safezoneH) +  ( ( 0.341 * safezoneH) /1) ;
			};
		};

	};

	class O2A_OK: RscButtonMenuOK
	{
		action = "uiNamespace setvariable ['O2A_VAR_GZLIST_SELECTED', lbCurSel 1500 ]";
		x = 0.603125 * safezoneW + safezoneX;
		y = 0.511 * safezoneH + safezoneY;
		w = 0.103125 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class O2A_cancel: RscButtonMenuCancel
	{
		x = 0.494844 * safezoneW + safezoneX;
		y = 0.511 * safezoneH + safezoneY;
		w = 0.0979687 * safezoneW;
		h = 0.022 * safezoneH;
	};

};
