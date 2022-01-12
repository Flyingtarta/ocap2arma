/* #Likopu
$[
	1.063,
	["ocap2arma",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[-1000,"background",[1,"",["0.291378 * safezoneW + safezoneX","0.19002 * safezoneH + safezoneY","0.417656 * safezoneW","0.671 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.7],[-1,-1,-1,-1],"","-1"],[]],
	[-1200,"IMGLOGO",[1,"ocap2arma\img\ocap2arma_4_ui.paa",["0.329844 * safezoneW + safezoneX","0.214 * safezoneH + safezoneY","0.335156 * safezoneW","0.561 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"BK_frame ",[1,"Path to replay files (json.gz)",["0.309219 * safezoneW + safezoneX","0.335 * safezoneH + safezoneY","0.381563 * safezoneW","0.11 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[1400,"FolderPath",[1,"",["0.31953 * safezoneW + safezoneX","0.379 * safezoneH + safezoneY","0.360937 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2600,"",[1,"",["0.592812 * safezoneW + safezoneX","0.412 * safezoneH + safezoneY","0.0876563 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1801,"",[1,"Path to replay files (json.gz)",["0.30922 * safezoneW + safezoneX","0.456 * safezoneH + safezoneY","0.381563 * safezoneW","0.352 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[2601,"",[1,"Load",["0.597969 * safezoneW + safezoneX","0.819 * safezoneH + safezoneY","0.0876563 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"ListOfGZ",[1,"",["0.31953 * safezoneW + safezoneX","0.489 * safezoneH + safezoneY","0.360937 * safezoneW","0.297 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2700,"",[1,"cancel",["0.525781 * safezoneW + safezoneX","0.819 * safezoneH + safezoneY","0.0670312 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class ocap2arma {
	idd = 1314;
	onload = "blur = ppEffectCreate ['DynamicBlur', 400]; blur ppEffectAdjust [10]; blur ppEffectCommit 0;";
	onunload = "blur ppEffectEnable false;	ppEffectDestroy blur; blur = nil";
	class ControlsBackground {
		class background: RscText
		{
			idc = 1000;
			x = 0.291378 * safezoneW + safezoneX;
			y = 0.19002 * safezoneH + safezoneY;
			w = 0.417656 * safezoneW;
			h = 0.671 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
		};
		class IMGLOGO: RscPicture
		{
			idc = 1200;
			text = "ocap2arma\img\ocap2arma_4_ui.paa";
			x = 0.329844 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.335156 * safezoneW;
			h = 0.561 * safezoneH;
		};
		class BK_frame : RscFrame
		{
			idc = 1800;
			text = "Path to replay files (json.gz)"; //--- ToDo: Localize;
			x = 0.309219 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.381563 * safezoneW;
			h = 0.11 * safezoneH;
			sizeEx = 1 * GUI_GRID_H;
		};
		class frame: RscFrame
		{
			idc = 1801;
			text = "Replay files"; //--- ToDo: Localize;
			x = 0.30922 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.381563 * safezoneW;
			h = 0.352 * safezoneH;
			sizeEx = 1 * GUI_GRID_H;
		};

	};


	class controls {

		class FolderPath: RscEdit
		{
			idc = 16000;
			//onLoad = "['FolderPath_onload',_this] call o2a_fnc_ui_launcher";

			onLoad = "_this#0 ctrlSetText (profilenamespace getvariable ['O2A_VAR_PATH2GZ','']) ;['FolderPath_onload',_this] spawn o2a_fnc_ui_launcher";
			x = 0.31953 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.360937 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class ok_path: O2A_button
		{
			idc = 2600;
			text = "OK";
			colorBackground[] = {0,0,0,1};
			//onload = "['ok_path_action'] call o2a_fnc_ui_launcher;";
			action = "['ok_path_action'] call o2a_fnc_ui_launcher;";
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.022 * safezoneH;
		};

		class load_filepath: O2A_button
		{
			idc = 2601;
			text = "Load"; //--- ToDo: Localize;
			colorBackground[] = {0,0,0,1};
			//action = "uiNamespace setvariable ['O2A_VAR_GZLIST_SELECTED', lbCurSel 1500 ]";
			action = "['load_filepath'] call o2a_fnc_ui_launcher";
			x = 0.597969 * safezoneW + safezoneX;
			y = 0.819 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class ListOfGZ: RscListbox
		{
			idc = 1500;
			//columns = 1;
			colorBackground[] = {0,0,0,0};
			onLoad = "UiNamespace setvariable ['O2A_VAR_GZLIST_CTRL',_this#0]";
			x = 0.31953 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.360937 * safezoneW;
			h = 0.297 * safezoneH;
		};
		class RscButtonMenuCancel_2700: O2A_button
		{
			idc = 2700;
			text = "Cancel";
			action = "(findDisplay 1314) closeDisplay 2;{if (_x != findDisplay 0) then {_x closeDisplay 1}} foreach allDisplays";
			x = 0.525781 * safezoneW + safezoneX;
			y = 0.819 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};

};
