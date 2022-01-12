if (isnil "CfgMagazines") then {CfgMagazines = [(configFile >> "CfgMagazines") , 0] call BIS_fnc_returnChildren;};
if (isnil "cfgVehicles") then {cfgVehicles = [(configFile >> "CfgVehicles") , 0] call BIS_fnc_returnChildren;};
