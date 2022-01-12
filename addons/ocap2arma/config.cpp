class CfgPatches
{
	class ocap2arma
	{
		// Meta information for editor
		name = "Ocap2Arma";
		author = "FlyingTarta";
		//url = "http://xkcd.com";
		requiredVersion = 2.0;
		// Required addons, used for setting load order.
		// When any of the addons is missing, pop-up warning will appear when launching the game.
		requiredAddons[] = { "A3_Functions_F" };
		units[] = {};
		weapons[] = {};
	};
};

class cfgFunctions {
  #include "functions\O2A_fncs.hpp"
};

#include "common.hpp"
#include "functions\O2A_gui.hpp"


class CfgMainMenuSpotlight // RscDisplayMain >> Spotlight works but is considered obsolete since SPOTREP #00064
{
	class Ocap2ArmaDOU
	{
		text = "OCAP 2 ARMA replay"; // Text displayed on the square button, converted to upper-case
		onload = "systemchat str alldisplays";
		textIsQuote = 0; // 1 to add quotation marks around the text
		picture = "\a3\Ui_f\Data\GUI\Rsc\RscDisplayMain\spotlight_1_apex_ca.paa"; // Square picture, ideally 512x512
		video = "\a3\Ui_f\Video\spotlight_1_Apex.ogv"; // Video played on mouse hover
		//action = "(finddisplay 1) ctrlcreate ['selectFolderGZ',-1]"; // Code called upon clicking, passed arguments are [<button:Control>]
		action = "[] call O2A_FNC_ocap2arma";
		//action = "(findDisplay 0) createdisplay 'selectFolderGZ'";
		actionText = "actiontext"; // Text displayed in top left corner of on-hover white frame
		condition = "true"; // Condition for showing the spotlight
	};
};


class Cfg3DEN
{
	class EventHandlers
	{
		class mySection
		{
			//OnTerrainNew = "[] call O2A_FNC_ocap2arma";
			OnTerrainNew = "[] call O2A_fnc_edenButton";
			// <handlerName> = <handlerExpression>
		};
	};
};


/*

class ctrlMenuStrip;
class display3DEN
{
	class Controls
	{
		class MenuStrip: ctrlMenuStrip
		{
			class Items
			{
				class Tools
				{
					items[] += {"O2A_PLAYER"}; // += must be used; you want to expand the array, not override it!
				};
				class O2A_PLAYER
				{
					text = "OCAP2ARMA PLAYER"; // Item text
					//picture = "\MyAddon\data\myAwesomeTool_ca.paa"; // Item picture
					action = "[] call O2A_FNC_ocap2Arma";// Expression called upon clicking; ideally, it should call your custom function
          opensNewWindow = 1;// Adds ... to the name of the menu entry, indicating the user that a new window will be opened.
				};
			};
		};
	};
};

/*
class ctrlStaticBackgroundDisable;
class ctrlStaticBackgroundDisableTiles;
class ctrlMenuStrip;
class Display3DEN
{
	class Controls
	{
		class MenuStrip: ctrlMenuStrip
		{
			class Items
			{
				items[]=
				{
					"O2A_PLAYER"
				};
				class O2A_PLAYER
				{
					text="OCAP2ARMA PLAYER";
					items[]=
					{
						"O2A_BUTTON"
					};
				};
				class O2A_BUTTON
				{
					text="Open";
					action="[] call O2A_FNC_ocap2Arma;";
				};
			};
		};
	};
};
*/
