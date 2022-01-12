profilenamespace setvariable ["temporalFile",nil];
playScriptedMission ["VR", {
		private _grp = createGroup west;
		private _player = _grp createUnit ["B_Soldier_F", [worldSize/2,worldSize/2,0], [], 0, "NONE"];
	  _player allowDamage false;
		selectPlayer _player;
		[] spawn {
			waituntil {!isnull (finddisplay 46)};
			(findDisplay 46) createdisplay "ocap2arma";
		};
  }, missionConfigFile, true];
{if (_x != findDisplay 0) then {_x closeDisplay 1}} foreach allDisplays;
{if (_x != findDisplay 0) then {_x closeDisplay 1}} foreach allDisplays;
