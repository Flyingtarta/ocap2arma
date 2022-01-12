/*
  Creates the object to represent players and vehicles, for units uses the VR ones, and for vehicles the actual vehicles ( mods need to be loaded )
*/


_BUFFER_SIZE = localNamespace getvariable ["O2A_VAR_BUFFER_SIZE",200];
if ( count (entitiesListData get (_this#0)) isNotEqualTo 4 ) then { //defines if its a unit or an vehicle
  /*
  -----------------------------------------
      If its an unit
  -----------------------------------------

  */
  params [
      "_id",
      "_position",
      "_direction",
      "_firing",
      "_posFired",
      "_alive",
      "_invehicle"
  ];
  (EntitiesListData get _id) params [
      "_name",
      "_group",
      "_isplayer",
      "_rol",
      "_side",
      "_type"
  ];
  private _O2AFrame = localNamespace getvariable ["O2A_PLAYER_Frame",0];
  private _bufferSelect = floor (_O2AFrame/_BUFFER_SIZE);
  private _buffer = (entityPositionalData select _bufferSelect);
  private _speedx = localNamespace getvariable ["O2A_PLAYER_speed",10];
  _obj = MarcadoresFisicos getOrDefault [_id,objNull];
  if (_obj isequalto objNull) then {
      _marcador = "";
      if (_side isequalto "WEST") then {_marcador = "B_Soldier_VR_F"};
      if (_side isequalto "EAST") then {_marcador = "O_Soldier_VR_F"};
      if (_side isequalto "GUER") then {_marcador = "I_Soldier_VR_F"};
      if (_side isequalto "CIV") then  {_marcador = "C_Soldier_VR_F"};

      _obj = createVehicle [_marcador, [0,0,1000],[],0,"CAN_COLLIDE"];
      _obj setname _name;
      if !(_side isequalto "CIV") then {_obj switchmove "AidlPercMstpSrasWpstDnon_AI"}; //if not civilean has "agresive" animation
      _obj enableSimulation false;
      //_MarcadoresFisicos pushBackUnique [_name,_obj];
      MarcadoresFisicos set [_id,_obj];
      _obj setvariable ["frameData",_this];
  }else{
      //_obj = _MarcadoresFisicos select _idx select 1;
      _obj = MarcadoresFisicos get _id;
      _obj setvariable ["frameData",_this];
      /*
      _obj setposasl _position;
      _obj setdir _direction;
      */
      if (_invehicle && _alive) exitwith {_obj hideObject true};

      if  ( !([_position,camera] call O2A_fnc_objInFov || _obj distance camera > 300)) then {
          if (true) exitwith {_obj hideObject true};
      }else{
          if (isObjectHidden _obj)then{_obj hideObject false};
      };
      ///////////////////////////////////////// DELIRIO ZONE///////////////////////////////////////////////
      _speed = localNamespace getvariable ["O2A_PLAYER_speed",10];
      if ( localNamespace getvariable ["O2A_PLAYER_smooth",true] && _obj distance2d camera < 100 ) then {
          _entitiesData = _buffer get _O2AFrame;
          if (isnil "_entitiesData") exitwith {
              _obj setdir _direction;
              _obj setposasl _position;
              break
          };
          _data = (_entitiesData select {_x#0 == _id});

          if (isnil "_data") exitwith {
              _obj setdir _direction;
              _obj setposasl _position;
              break
          };

          _speedx = localNamespace getvariable ["O2A_PLAYER_speed",10];
          if (_speedx isequalto 1 && _obj distance2d camera < 100) then {
            private _futureFrame = (localNamespace getvariable ["O2A_PLAYER_Frame",0]) + 1;
            private _bufferSelect = floor (_O2AFrame/_BUFFER_SIZE);
            private _buffer = (entityPositionalData select _bufferSelect);
            _future = _buffer get _futureFrame;
            _idxF = _future findif {_x#0 isequalto _id};
            _futureData = _future select _idxF;
            if (_idxF isequalto -1) exitwith {};
            _futureData params["","_FuturePos","_FutureDir","",""];

            if !(isnil "_futurepos") then {
                [_obj,_position,_futurepos,_direction,_futureDir] call {
                    params ["_obj","_pos","_futurepos","_dir","_futureDir"];
                    private _speedx = localNamespace getvariable ["O2A_PLAYER_speed",10];
                    _extraFrames  = abs (floor 10/_speedx);
                    for "_i" from 1 to _extraFrames  do {
                        sleep (1/ (_speedx*10));
                        _dirF = linearconversion [0,_extraFrames+1,_i,_dir,_futureDir];
                        _posf = vectorLinearConversion [0,_extraFrames+1,_i,_pos,_futurepos];
                        _posagl = asltoagl _posf;
                        _obj setpos _posagl;
                        _obj setdir _dirF;
                    };//for
                };//spawn
            };//ifnil
          }else{
            _obj setdir _direction;
            _obj setposasl _position;
          };
      } else {
          _obj setdir _direction;
          _obj setposasl _position;
      };
      if (!_alive && ((animationState _obj) isnotequalto "AinjPfalMstpSnonWrflDnon_carried_Up") ) then {_obj switchmove "AinjPfalMstpSnonWrflDnon_carried_Up"};
      if (_alive /*&& ((animationState _obj) isequalto "AinjPfalMstpSnonWrflDnon_carried_Up") */) then {_obj switchmove "AidlPercMstpSrasWpstDnon_AI"};
      if (_side isequalto "CIV") then {_obj switchmove "AidlPercMstpSrasWpstDnon_AI"};
  };
}else{
  /*
    -----------------------------------------

    In case of vehicles

    -----------------------------------------
  */
  params[
    "_id",
    "_position",
    "_direction",
    "_crew",
    "_alive"
  ];
  (EntitiesListData get _id) params [
    "_name",
    "_clase",
    "_type",
    "_classname"
  ];

  private _O2AFrame = localNamespace getvariable ["O2A_PLAYER_Frame",0];
  private _bufferSelect = floor (_O2AFrame/_BUFFER_SIZE);
  private _buffer = (entityPositionalData select _bufferSelect);
  private _speedx = localNamespace getvariable ["O2A_PLAYER_speed",10];
  _obj = MarcadoresFisicos getOrDefault [_id,objNull];
  if (_obj isequalto objNull) then {//Didnt created yet
    _obj = createVehicle [_classname,_position,[],500,"NONE"];
    if (isNull _obj) then {
      systemchat str [ "Error al crear vehiculo",_name,_classname];
      _obj = createVehicle ["Land_VR_Target_MRAP_01_F",[0,0,5000],[],500,"CAN_COLLIDE"];
    };
    _obj setname _name;
    _obj enableSimulation false;
    _obj allowDamage false;
    MarcadoresFisicos set [_id,_obj];
    _obj setvariable ["FrameData",_this];
  }else{
    _obj = MarcadoresFisicos get _id;
    _obj setvariable ["FrameData",_this];
    //if !(alive)
    if !([_position,camera] call O2A_fnc_objInFov || _obj distance camera > 500 ) then {
        if (true) exitwith {
            if !(isObjectHidden _obj)then{_obj hideObject true};
        };
    }else{
        if (isObjectHidden _obj)then{_obj hideObject false};
    };

    _speed = localNamespace getvariable ["O2A_PLAYER_speed",10];
    if ( localNamespace getvariable ["O2A_PLAYER_smooth",true] && _obj distance2d camera < 300 ) then {
        _entitiesData = _buffer get _O2AFrame;
        if (isnil "_entitiesData") exitwith {
            _obj setdir _direction;
            _obj setposasl _position;
            break
        };
        _data = (_entitiesData select {_x#0 == _id});

        if (isnil "_data") exitwith {
            _obj setdir _direction;
            _obj setposasl _position;
            break
        };

        /*
          Delirio zone
        */
        _speedx = localNamespace getvariable ["O2A_PLAYER_speed",10];
        if (_speedx isequalto 1) then {
          private _futureFrame = (localNamespace getvariable ["O2A_PLAYER_Frame",0]) + 1;
          private _bufferSelect = floor (_O2AFrame/_BUFFER_SIZE);
          private _buffer = (entityPositionalData select _bufferSelect);
          _future = _buffer get _futureFrame;
          _idxF = _future findif {_x#0 isequalto _id};
          _futureData = _future select _idxF;
          if (_idxF isequalto -1) exitwith {};
          _futureData params["","_FuturePos","_FutureDir","",""];

          if !(isnil "_futurepos") then {
              [_obj,_position,_futurepos,_direction,_futureDir] call {
                  params ["_obj","_pos","_futurepos","_dir","_futureDir"];
                  private _speedx = localNamespace getvariable ["O2A_PLAYER_speed",10];
                  _extraFrames  = abs (floor 10/_speedx);
                  for "_i" from 1 to _extraFrames  do {
                      //_posf = (_i/10) bezierInterpolation [_pos,_future];
                      sleep (1/ (_speedx*10));
                      _dirF = linearconversion [0,_extraFrames+1,_i,_dir,_futureDir];
                      _posf = vectorLinearConversion [0,_extraFrames+1,_i,_pos,_futurepos];
                      _obj setposasl _posf;
                      _obj setdir _dirF;
                  };//for
              };//spawn
          };//ifnil
        }else{
          _obj setdir _direction;
          _obj setposasl _position;
        };//sm0oth
    } else {
        _obj setdir _direction;
        _obj setposasl _position;
    };
  };
  if (_alive) then {_obj setDamage 0} else {_obj setDamage 1};

  if (_alive && (count _crew > 0) ) then {_obj engineOn true} else{ _obj engineOn false};
};
