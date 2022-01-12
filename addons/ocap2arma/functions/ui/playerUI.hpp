class O2A_button : RscButton
{
	active = 1;
	fade = 0;
	size = GUI_GRID_H;
	colorFocused[] = {0.8,0.8,0.8,1};
	colorBackground[] = {0,0,0,0.7};
	period = -1;
	colorDisabled[] = {0,0,0,0.7};
	colorBackgroundDisabled[] = {0,0,0,0.7};
	colorBackgroundActive[] = {1,0.5,0,0.7};

	shadow = 1;

	tooltipColorShade[] = {0,0,0,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	//onUnload = "systemchat str _x";
};


class PlayerControls {
	idd = 1314;
	type = 0;
	controls[]=
	{
		playpause,
		AddSpeed,
		ReduceSpeed,
		progress,
		timeElapsed,
		speedText,
		toggleMarkers,
		toggleSided,
		PH1,
		ph2,
		PH3,
		ViewDistanceBar,
		viewDistanceValue
	};

	class playpause: O2A_button
	{
		idc = 1600;
		text = "PLAY"; //--- ToDo: Localize;
		action = "_paused = localNamespace getvariable ['O2A_PLAYER_paused',false]; _ctrl = (findDisplay 1314 displayCtrl 1600);localNamespace setvariable ['O2A_PLAYER_paused',!(_paused)];if (_paused) then { _ctrl ctrlSetText 'PAUSE'} else {_ctrl ctrlSetText 'PLAY'};"
		onUnload = "systemchat str _this";
		x = 0.453594 * safezoneW + safezoneX;
		y = 0.896 * safezoneH + safezoneY;
		w = 0.0876563 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class AddSpeed: O2A_button
	{
		idc = 1601;
		action = "_speed = localNamespace getvariable ['O2A_PLAYER_speed',10]; _newSpeed = _speed+1; if (_newSpeed > 20) then {_newSpeed = 20}; localNamespace setvariable ['O2A_PLAYER_speed',_newSpeed];"
		text = ">>"; //--- ToDo: Localize;
		x = 0.546406 * safezoneW + safezoneX;
		y = 0.896 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class ReduceSpeed: O2A_button
	{
		idc = 1602;
		text = "<<"; //--- ToDo: Localize;
		action = "_speed = localNamespace getvariable ['O2A_PLAYER_speed',10]; _newSpeed = _speed-1; if (_newSpeed < 1) then {_newSpeed = 1}; localNamespace setvariable ['O2A_PLAYER_speed',_newSpeed];"
		x = 0.412344 * safezoneW + safezoneX;
		y = 0.896 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class progress: RscXSliderH
	{
		idc = 1900;
		shadow = 1;
		text = "timebar"; //--- ToDo: Localize;
		x = 0.298906 * safezoneW + safezoneX;
		y = 0.863 * safezoneH + safezoneY;
		w = 0.309375 * safezoneW;
		h = 0.011 * safezoneH;
		onSliderPosChanged = "localNamespace setvariable ['O2A_PLAYER_Frame',_this#1]";
		sliderStep = 1;
		sliderPosition = 0;
	};

	class timeElapsed: RscText
	{
		idc = 1000;
		colorBackground[] = {0,0,0,0};
		shadow = 1;
		onDraw = "systemchat str _this";
		text = ""; //--- ToDo: Localize;
		x = 0.613437 * safezoneW + safezoneX;
		y = 0.863 * safezoneH + safezoneY;
		w = 0.0928125 * safezoneW;
		h = 0.011 * safezoneH;
	};
	class speedText: RscText
	{
		idc = 1001;
		colorBackground[] = {0,0,0,0};
		shadow = 1;
		text = "speed x10"; //--- ToDo: Localize;
		x = 0.365937 * safezoneW + safezoneX;
		y = 0.896 * safezoneH + safezoneY;
		w = 0.04125 * safezoneW;
		h = 0.044 * safezoneH;
	};

	class toggleMarkers: O2A_button
	{
		idc = 1603;
		text = "Toggle Markers"; //--- ToDo: Localize;
		action = "_showMarkers = localNamespace getvariable ['O2A_VAR_showPlayerMarkers',true]; _ctrl = (findDisplay 1314 displayCtrl 1603);localNamespace setvariable ['O2A_VAR_showPlayerMarkers',!(_showMarkers)];";//if (_showMarkers) then { _ctrl ctrlSetBackgroundColor [1,0.5,0,0.7] } else {_ctrl ctrlSetBackgroundColor [0,0,0,0.7]};"
		//onLoad = "_showMarkers = localNamespace getvariable ['O2A_VAR_showPlayerMarkers',true]; _ctrl = (findDisplay 1314 displayCtrl 1603);localNamespace setvariable ['O2A_VAR_showPlayerMarkers',!(_showMarkers)];";//if (_showMarkers) then { _ctrl ctrlSetBackgroundColor [1,0.5,0,0.7] } else {_ctrl ctrlSetBackgroundColor [0,0,0,0.7]};"
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.192 * safezoneH + safezoneY;
		w = 0.0721875 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class toggleSided: O2A_button
	{
		idc = 1604;
		text = "Sided Markers"; //--- ToDo: Localize;
		action = "_sidedMarkers = localNamespace getvariable ['O2A_VAR_sidedMarkerColors',true]; _ctrl = (findDisplay 1314 displayCtrl 1604);localNamespace setvariable ['O2A_VAR_sidedMarkerColors',!(_sidedMarkers)];";//if (_sidedMarkers) then { _ctrl ctrlSetBackgroundColor [1,0.5,0,0.7] } else {_ctrl ctrlSetBackgroundColor [0,0,0,0.7]};"
		//onLoad = "_sidedMarkers = localNamespace getvariable ['O2A_VAR_sidedMarkerColors',true]; _ctrl = (findDisplay 1314 displayCtrl 1604);localNamespace setvariable ['O2A_VAR_sidedMarkerColors',!(_sidedMarkers)];";//if (_sidedMarkers) then { _ctrl ctrlSetBackgroundColor [1,0.5,0,0.7] } else {_ctrl ctrlSetBackgroundColor [0,0,0,0.7]};"
		x = 0.37625 * safezoneW + safezoneX;
		y = 0.192 * safezoneH + safezoneY;
		w = 0.0721875 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class PH1: O2A_button
	{
		idc = 1605;
		text = "PH1"; //--- ToDo: Localize;
		x = 0.45875 * safezoneW + safezoneX;
		y = 0.192 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ph2: O2A_button
	{
		idc = 1606;
		text = "PH2"; //--- ToDo: Locali_sidedMarkerskers
		x = 0.546406 * safezoneW + safezoneX;
		y = 0.192 * safezoneH + safezoneY;
		w = 0.0721875 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class PH3: O2A_button
	{
		idc = 1607;
		text = "PH3"; //--- ToDo: Localize;
		x = 0.628906 * safezoneW + safezoneX;
		y = 0.192 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.022 * safezoneH;
	};


	class ViewDistanceBar: RscXSliderH
	{
		idc = 1901;
		text = "ViewDistance"; //--- ToDo: Localize;
		onload = "_this#0 sliderSetPosition viewDistance";
		onSliderPosChanged = "setviewdistance (_this#1);(findDisplay 1314 displayCtrl 1002) ctrlSetText format ['ViewDistance: %1',_this#1]";
		sliderStep = 100;
		shadow = 1;
		sliderRange[] = {500,12000};
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.17 * safezoneH + safezoneY;
		w = 0.324844 * safezoneW;
		h = 0.011 * safezoneH;
	};
	class viewDistanceValue: RscText
	{
		idc = 1002;
		colorBackground[] = {0,0,0,1};
		onload = "(_this#0) ctrlSetText format ['ViewDistance: %1',viewDistance]";
		text = "Viewdistance: 3000"; //--- ToDo: Localize;
		x = 0.628906 * safezoneW + safezoneX;
		y = 0.17 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.011 * safezoneH;
	};


};


/* #Hamyre
$[
	1.063,
	["playargui",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1600,"playpause",[1,"play",["0.453594 * safezoneW + safezoneX","0.896 * safezoneH + safezoneY","0.0876563 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"AddSpeed",[1,">>",["0.546406 * safezoneW + safezoneX","0.896 * safezoneH + safezoneY","0.0360937 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"ReduceSpeed",[1,"<<",["0.412344 * safezoneW + safezoneX","0.896 * safezoneH + safezoneY","0.0360937 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1900,"progress",[1,"timebar",["0.298906 * safezoneW + safezoneX","0.863 * safezoneH + safezoneY","0.309375 * safezoneW","0.011 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"timeElapsed",[1,"5320 | 1:05:25 - 3:20:15",["0.613437 * safezoneW + safezoneX","0.863 * safezoneH + safezoneY","0.0928125 * safezoneW","0.011 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"speedText",[1,"speed x10",["0.365937 * safezoneW + safezoneX","0.896 * safezoneH + safezoneY","0.04125 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"toggleMarkers",[1,"Toggle Markers",["0.29375 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.0721875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1604,"toggleSided",[1,"Sided Markers",["0.37625 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.0721875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1605,"PH1",[1,"PH1",["0.45875 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1606,"ph2",[1,"PH2",["0.546406 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.0721875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1607,"PH3",[1,"PH3",["0.628906 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1901,"ViewDistanceBar",[1,"ViewDistance",["0.29375 * safezoneW + safezoneX","0.17 * safezoneH + safezoneY","0.324844 * safezoneW","0.011 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"viewDistanceValue",[1,"Viewdistance: 3000",["0.628906 * safezoneW + safezoneX","0.17 * safezoneH + safezoneY","0.0773437 * safezoneW","0.011 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
