params ["_handler","_params"];


if (_handler isequalto "FolderPath_onload") then {
  // ['FolderPath_onload'] call o2a_fnc_ui_launcher
  _control = findDisplay 1314 displayctrl 16000;
  UiNamespace setvariable ['O2A_newPath',_control];
  _path = profilenamespace getvariable ['O2A_VAR_PATH2GZ',""];
  if (_path isequalto"") then {
    _control ctrlSetText 'Paste directory where all GZ are located';
  }else{
    _control ctrlSetText (profilenamespace getvariable ['O2A_VAR_PATH2GZ',""]);
  };
};

if (_hanlder isequalto "ok_path_onload") then {
  _path = profilenamespace getvariable ['O2A_VAR_PATH2GZ',""];
  if (_path isNotEqualTo "") then {
    _gzinfolder = [];
    _gzinfolder = ["ocap2arma.listJsonFiles", [_path] ] call py3_fnc_callExtension;
    if (_gzinfolder isNotEqualTo []) then {
      ['ok_path_action'] call o2a_fnc_ui_launcher;
    };
  };
};


if (_handler isequalto "ok_path_action") then {
  /*

  // ['ok_path_action'] call o2a_fnc_ui_launcher

  */

  private _controlPath = findDisplay 1314 displayctrl 16000;
  private _path = ctrlText _controlPath;

  //_path = ctrlText (UiNamespace getvariable ["O2A_newPath",16000]);
  private _gzinfolder = [];
  if (_path isnotequalto "" && _path isnotequalto 'Paste directory where all GZ are located') then {
    UiNamespace setvariable ['O2A_newPath',ctrlText 16000];
    //_path profilenamespace getvariable ['O2A_VAR_PATH2GZ',_path];
    _gzinfolder = ["ocap2arma.listJsonFiles", [_path] ] call py3_fnc_callExtension;
  };

  if (_gzinfolder isnotequalto []) then {
    localNamespace setvariable ["ListOfGZInPath",_gzinfolder];
    profilenamespace setvariable ['O2A_VAR_PATH2GZ',_path];

    _control = uiNamespace getvariable "O2A_VAR_GZLIST_CTRL";
    {
      _fileName = _x;
      //_path = profilenamespace getvariable ['O2A_VAR_PATH2GZ',""];
      _metaData = ["ocap2arma.missionMetaData", [_path + "\" + _x ] ] call py3_fnc_callExtension;
      _map = _metaData#2;
      _name = _metadata#0;
      _control lbadd _name;
      if !(isclass (configFile >> "CfgWorlds" >> _map)) then {
        _map = _map + " MOD NOT LOADED!";
        _control lbSetTextRight [_foreachindex,_map];
        _control lbsetcolor [_foreachindex,[1,0,0,1]];
        _control lbSetColorRight [_foreachindex,[1,0,0,1]];
      }else{
        _control lbSetTextRight [_foreachindex,_map];
      };
      ["ocap2arma.cleanVariables", [] ] call py3_fnc_callExtension;
    }foreach _gzinfolder;
  }else{
    hint "Path no valid | No json.gz found";
  };
};

if (_handler isequalto "load_filepath") then {
  //"['load_filepath'] call o2a_fnc_ui_launcher"
  private _lbControl = findDisplay 1314 displayCtrl 1500;
  private _LBselected =  lbCurSel _lbControl;
  private _path = profilenamespace getvariable ['O2A_VAR_PATH2GZ',""];
  private _listOfGz = localNamespace getvariable ["ListOfGZInPath",[]];

  if (_listOfGz isNotEqualTo [] && _path isNotEqualTo "" ) then {
    file = _path + "\" + (_listOfGz select _LBselected);
    ["ocap2arma.cleanVariables", [] ] call py3_fnc_callExtension;
    _metadata = ["ocap2arma.missionMetaData", [file] ] call py3_fnc_callExtension;
    _map = _metaData#2;
    if (isclass (configFile >> "CfgWorlds" >> _map)) then {
      profilenamespace setvariable ['temporalFile',nil];
      profilenamespace setvariable ['temporalFile',file];

      disableSerialization;
      playScriptedMission [_map, {
      	private _grp = createGroup west;
      	private _player = _grp createUnit ["B_Soldier_F", [worldSize/2,worldSize/2,0], [], 0, "NONE"];
        _player allowDamage false;
      	selectPlayer _player;
        /*[] spawn {
          waitUntil {!(isnull findDisplay 46)};
          //[] call O2A_fnc_player;
        };
        */
      }, missionConfigFile, true];
      {if (_x != findDisplay 0) then {_x closeDisplay 1}} foreach allDisplays;
    };
  };
};
