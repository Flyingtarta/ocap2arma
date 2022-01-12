//fix Color
_mapMarkers = ["ocap2arma.mapMarkers", [file] ] call py3_fnc_callExtension;
private _colorsHashMap = createHashMapFromArray
[
  ["000000", "ColorBlack"],
  ["808080", "ColorGrey"],
  ["E60000", "ColorRed"],
  ["804000", "ColorBrown"],
  ["D96600", "ColorOrange"],
  ["D9D900", "ColorYellow"],
  ["809966", "ColorKhaki"],
  ["00CC00", "ColorGreen"],
  ["0000FF", "ColorBlue"],
  ["FF4D66", "ColorPink"],
  ["FFFFFF", "ColorWhite"],
  ["004D99", "ColorWEST"],
  ["800000", "ColorEAST"],
  ["008000", "ColorGUER"],
  ["660080", "ColorCIV"],
  ["B39900", "ColorUNKNOWN"],
  ["004D99", "colorBLUFOR"],
  ["800000", "colorOPFOR"],
  ["008000", "colorIndependent"],
  ["660080", "colorCivilian"],
  ["B13339", "Color1_FD_F"],
  ["ADBF83", "Color2_FD_F"],
  ["F08231", "Color3_FD_F"],
  ["678B9B", "Color4_FD_F"],
  ["B040A7", "Color5_FD_F"],
  ["5A595A", "Color6_FD_F"]
];

{
  _data = _x select 1;
  _color = _data select 5;
  _placerID = _data select 4;
  if (_placerID isequalto -1) then {
    _originalColor = _colorsHashMap getOrDefault [_color,"ColorBlack"];
    _data set [5, [_originalColor,_originalColor] ];
  }else{

    _placerSide = (entitiesListData get _placerID) select 4;

    _originalColor = _colorsHashMap getOrDefault [_color,"ColorBlack"];
    _playerColor = "";
    if (_placerSide isequalto "WEST") then {_playerColor = "ColorWEST"};
    if (_placerSide isequalto "EAST") then {_playerColor = "ColorEAST"};
    if (_placerSide isequalto "GUER") then {_playerColor = "ColorGUER"};
    if (_placerSide isequalto "CIV")  then {_playerColor = "ColorCIV"	};
    _data set [5, [_originalColor,_playerColor] ];
  };
  _mapMarkers set [_foreachindex,[_x select 0,_data]];
}foreach _mapMarkers;

mapMarkers = createHashMapFromArray _mapMarkers;
