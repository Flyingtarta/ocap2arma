/*
  Description:
    Replay preloader:
      - Lists al gz in mission folder

*/

private _gzinfolder = [];
["ocap2arma.cleanVariables", [] ] call py3_fnc_callExtension;
waituntil {!isnull (finddisplay 46)};
private _path = "";

if (_gzinfolder isequalto [] ) then {
  systemchat "didnt found a gz";
  private _path = profilenamespace getvariable ['O2A_VAR_PATH2GZ',""];
  createDialog "selectFolderGZ";
  _notValid = true;
  _gzinfolder = [];
  while {_notValid} do {
    createDialog "selectFolderGZ";
    _response = UiNamespace setvariable ['O2A_RESPONSE2PATH',nil];
    waitUntil {! isnil {UiNamespace getvariable 'O2A_RESPONSE2PATH'}};
    _response = UiNamespace getvariable 'O2A_RESPONSE2PATH';

    if (!_response) exitwith {(finddisplay 46) closeDisplay 1};
    closeDialog 1;
    _path = UiNamespace getvariable ["O2A_newPath",""];
    _gzinfolder = ["ocap2arma.listJsonFiles", [_path] ] call py3_fnc_callExtension;

    if (_gzinfolder isnotequalto []) then {
      _notValid = false;
      profilenamespace setvariable ['O2A_VAR_PATH2GZ',_path];
    }else{
      hint "Path no valid | No json.gz found";
    };

  };
  //hint str _gzinfolder;
};

if (count _gzinfolder isequalto 1) then {
  file = _path + (_gzinfolder select 0);
}else{//if there more than one

  createDialog "listGZ";
  sleep 0.1;
  _control = uiNamespace getvariable "O2A_VAR_GZLIST_CTRL";//variable of control of the list
  {

    _fileName = _x;
    _path = profilenamespace getvariable ['O2A_VAR_PATH2GZ',""];
    _metaData = ["ocap2arma.missionMetaData", [_path + "\" + _x ] ] call py3_fnc_callExtension;
    _map = _metaData#2;
    _name = _metadata#0;
    _spacer = 100 - (count str _map + count str _name);
    _space = " ";
    for "_" from 0 to _spacer do {_space = _space + " "};
    if !(isclass (configFile >> "CfgWorlds" >> _map)) then {_map = _map + "MOD NOT LOADED!"};
    _control lbadd (_name + _space + _map);
    ["ocap2arma.cleanVariables", [] ] call py3_fnc_callExtension;
  }foreach _gzinfolder;

  _selected = -1;
  waituntil { _selected = uiNamespace Getvariable 'O2A_VAR_GZLIST_SELECTED'; !isnil {_selected}};
  _path = profilenamespace getvariable ['O2A_VAR_PATH2GZ',""];
  file = _path + "\" + (_gzinfolder select _selected);
  ["ocap2arma.cleanVariables", [] ] call py3_fnc_callExtension;
  _metadata = ["ocap2arma.missionMetaData", [file] ] call py3_fnc_callExtension;
  _map = _metaData#2;
  //if (_map isnotequalto worldname) then { //Change to the mission map
  if (isclass (configFile >> "CfgWorlds" >> _map)) then {
    profilenamespace setvariable ['temporalFile',nil];
    profilenamespace setvariable ['temporalFile',file];

    disableSerialization;
    playScriptedMission [_map, {
    	private _grp = createGroup west;
    	private _player = _grp createUnit ["B_Soldier_F", [worldSize/2,worldSize/2,0], [], 0, "NONE"];
      _player allowDamage false;
    	selectPlayer _player;
    }, missionConfigFile, true];
    {if (_x != findDisplay 0) then {_x closeDisplay 1}} foreach allDisplays;
    true
  }else{
    false
  };

};
