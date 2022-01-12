/*
  Draws marker for groups in the distance

  disabled - no practical use 
*/


/*
addMissionEventHandler ["Draw3D",{
  {
    _units = groupsUnits get _x;
    if (count _units < 6) exitwith {};

    _name = _x;
    _groupPos = [0,0,0];
    {
      _obj = MarcadoresFisicos get _x;
      _frameData = _obj getvariable ["frameData",[]];
      if (_frameData isequalto []) exitwith {};

      _frameData params ["_id","_position","_direction","_firing","_posFired","_alive","_invehicle"];
      if (_alive && !_invehicle) then {
        //_groupPos vectoradd _position;
        {
          _newval = (_groupPos select _foreachindex) + _x;
          _groupPos set [_foreachindex,_newval];
        }foreach _position;
      };
    }foreach _units;

    _groupPos = _groupPos vectorMultiply (1/(count _units));


    //systemchat str _groupPos;
    _distanceCam = (_groupPos distance camera);
    if (_distanceCam < viewDistance && _distanceCam > 1000);

    _side = EntitiesListData get (_units#0) select 4;
    _color = [0.5,0.5,0.5,1];
    _icon = "";

    if (_side isequalto "WEST") then {_color = [0.2,0.5,0.8,1];_icon = "\A3\ui_f\data\map\markers\nato\b_inf.paa"};
    if (_side isequalto "EAST") then {_color = [0.7,0.2,0.2,1];_icon = "\A3\ui_f\data\map\markers\nato\o_inf.paa"};
    if (_side isequalto "GUER") then {_color = [0.2,0.7,0.2,1];_icon = "\A3\ui_f\data\map\markers\nato\n_inf.paa"};


    _k = 10/_distanceCam;
    drawIcon3D[
      _icon,
      _color,
      _groupPos,
      1,//_size,
      1,//_size,
      0,
      _name,
      2,
      0.03,
      "RobotoCondensed",
      "center",
      false,
      0,
      -0.7*_k
    ];
  } foreach groupsUnits


}];
