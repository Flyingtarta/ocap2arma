waituntil {!(isnull (findDisplay 313))};
//mission
#include "\a3\ui_f\hpp\definedikcodes.inc"

_curatorDisplay = findDisplay 313;
([] call BIS_fnc_GUIGrid) params ["", "", "_GUI_GRID_W", "_GUI_GRID_H"];
_GUI_GRID_W = _GUI_GRID_W / 40;
_GUI_GRID_H = _GUI_GRID_H / 25;
_btn = _curatorDisplay ctrlCreate ["O2A_button", 13140];
_btn ctrlSetPosition [//23.6
	safezoneX + safezoneW - 12 * _GUI_GRID_W,
	safeZoneY + 1.1 * _GUI_GRID_H,
	11 * _GUI_GRID_W,
	1 * _GUI_GRID_H
];
_btn ctrlSetTooltip "OPEN OCAP2ARMA PLAYER";
_btn ctrlSetText "OCAP2ARMA";
_btn ctrlCommit 0;

_btn ctrlAddEventHandler ["ButtonClick",{[] call O2A_FNC_ocap2arma}];

_curatorDisplay displayAddEventHandler ["KeyDown",{
	params ["_curatorDisplay", "_key"];
	if (_key in actionkeys 'curatorToggleInterface') then {
		_screenshotMode = uiNamespace getVariable ["RscDisplayCurator_screenshotMode", false];
		_btn = _curatorDisplay displayCtrl 13140;
		_btn ctrlEnable _screenshotMode;
		_fade = [0,1] select !_screenshotMode;
		_btn ctrlSetFade _fade;
		_btn ctrlCommit 0.1;
	};
}];
