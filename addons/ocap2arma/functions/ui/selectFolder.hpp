
class selectFolderGZ {
	idd = 1314;
	type = 0;

	controls[] = {
		O2A_Ok,
		O2A_cancel,
		FolderPath,
		//selectFolderGZ_BK
	};
	class ControlsBackground {
		class selectFolderGZ_BK: RscPicture
		{
			idc = -1;
			//type = 0;
			//style=16;
			//text = "#(argb,8,8,3)color(0,0,0,0.5)";
			//text = "";
			//canModify = 0;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.391875 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			//background = 1;
		};
	};
	class staticText: RscText
	{
		idc = 1000;
		text = "Folder path to replay OCAP2 files (json.gz): "; //--- ToDo: Localize;
		x = 0.314375 * safezoneW + safezoneX;
		y = 0.434 * safezoneH + safezoneY;
		w = 0.366094 * safezoneW;
		h = 0.022 * safezoneH;
	};

	class O2A_Ok: RscButtonMenuOK
	{
		action = "UiNamespace setvariable ['O2A_RESPONSE2PATH',true]; UiNamespace setvariable ['O2A_newPath',ctrlText 16000];";
		x = 0.613437 * safezoneW + safezoneX;
		y = 0.511 * safezoneH + safezoneY;
		w = 0.0721875 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class O2A_cancel: RscButtonMenuCancel
	{
		action = "UiNamespace setvariable ['O2A_RESPONSE2PATH',false]";
		text = "Go back";
		x = 0.525781 * safezoneW + safezoneX;
		y = 0.511 * safezoneH + safezoneY;
		w = 0.0670312 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class FolderPath: RscEdit
	{
		idc = 16000;
		canModify = 1;
		onLoad = "UiNamespace setvariable ['O2A_newPath',_this#0];_this#0 ctrlSetText (profilenamespace getvariable ['O2A_VAR_PATH2GZ','Paste directory where all GZ are located, then hit OK'])";
		text = "path"; //--- ToDo: Localize;
		x = 0.314375 * safezoneW + safezoneX;
		y = 0.467 * safezoneH + safezoneY;
		w = 0.37125 * safezoneW;
		h = 0.022 * safezoneH;
	};

};
