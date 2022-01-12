/*
  Description:
    Takes al information from markers, based from the image file saved on ocap, looks back in config to find the magazine and ammo

  Global Variable created:
    explosiveData (hashMap):

  Author:
    FlyingTarta


          #0 classname
          #1 startFrame
          #2 EndFrame
          #3 Direction
          #4 Positions 1 or 3 values : calculate parabola (?
*/



ExplosivesData = [];

_ExplosivesDataPY = ["ocap2arma.ExplosivesData", [file] ] call py3_fnc_callExtension;
//first use frame as key
explosiveData = createHashMap;
private _alreadyFound = createHashMap;
if (isnil "CfgMagazines") then {CfgMagazines = [(configFile >> "CfgMagazines") , 0] call BIS_fnc_returnChildren};

{
  _data = _x;
  _pictureName = _data select 0;
  _ammoClassname = "";
  _imageSource = "";
  _search = _alreadyFound getOrDefault [_pictureName,"nope"];
  if (_search isequalto "nope") then {
    //search the matching config on cfgmagazines
    _idx = CfgMagazines findif {
      _imageSource = gettext (_x >> "picture");
      _name = _imageSource splitString "\";
      if (count _name > 0) then {
        _name = _name select (count _name -1);
        _imagename = _name select [0, count _name -4];
        _found = _imagename isequalto _pictureName;
        //if (_found) then {_imageSource = gettext (_x >> "picture")};
        _found
      }else{
        false
      };
    };
    if (_idx isequalto -1) then {
      _ammoClassname = "";//not found
      _alreadyFound set [_pictureName,""];
    }else{
      _ammoClassname =  gettext ((CfgMagazines select _idx)>>"ammo");
      _alreadyFound set [_pictureName,_ammoClassname];
    };
  }else{
      _ammoClassname = _search;
  };
  _data pushback _ammoClassname;
  _data set [0,_imageSource];
  _explo = explosiveData getOrDefault [_x#1,[]];
  _explo pushBack _data;
  explosiveData set [_x#1,_explo];
}foreach _ExplosivesDataPY;
_ExplosivesDataPY = nil;//clear variable
