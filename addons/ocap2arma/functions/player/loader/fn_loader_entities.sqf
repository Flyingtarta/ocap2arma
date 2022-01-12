/*
O2A_FNC_LOADER_ENTITIES

Description:
  Loads the data from each entitie and save it in a global hasmap called ( EntitiesListData )
  and another one with all Framed Data divided in buffers

Global Varaibles created:
  EntitiesListData (hashmap)
  entityPositionalData (array of hasmaps)

*/

//Metadata from the mission used to calculate the different buffers
metaData params ["_name","_totalFrames","_wolrdName","_author","_timeStart","_timeMultiply"];
private _slices = floor (_totalFrames/_BUFFER_SIZE);

entityPositionalData = [];
for "_buffer" from 0 to _slices do {
  _data = ["ocap2arma.EntityPositionalData", [file, [ _buffer*_BUFFER_SIZE, (_buffer+1)*_BUFFER_SIZE] ]] call py3_fnc_callExtension;
  entityPositionalData pushback _data;
  //progressLoadingScreen (_buffer/_slices);
};
// makes hasmaps for each buffer using the frame as key
_endFrame = 0;
{_endFrame = _endFrame + count(_x) } foreach entityPositionalData;
private _entityPositionalDatahashes = [];
{
    _entityPositionalDatahashes pushback (createHashMapFromArray _x)
}foreach entityPositionalData;

entityPositionalData = _entityPositionalDatahashes;
_entityPositionalDatahashes = nil;
/*

  Import all propieties from each entity, data that has no changes in time in a easy acess hasmap

*/


_EntitiesList = ["ocap2arma.entitiesListData", [file] ] call py3_fnc_callExtension;
EntitiesListData = createHashMapFromArray _EntitiesList;

//group-> role fix
private _groups = createHashMap;
{
   _data = EntitiesListData get _x;
   _data params ["_name","_group","_isplayer","_rol","_side","_type"];
   if (count _data > 5) then {
  	if (_type isEqualTo "unit") then {
  		if ("@" in _rol) then {
  			_name = _rol splitString "@";
  			_groups set [(_group+_side),_name#1];
  		};
  	};
  };
}foreach EntitiesListData;

groupsUnits = createHashMap;
{
  _data = EntitiesListData get _x;
  if (count _data > 5) then {
    _data params ["_name","_unitGroup","_isplayer","_rol","_side","_type"];
    if (_type isEqualTo "unit") then {

      _data params ["_name","_unitGroup","_isplayer","_rol","_side","_type"];
      _newgroup = _groups getOrDefault [_unitGroup+_side,_unitGroup];
      _data set [1,_newgroup];
      EntitiesListData set [_x,_data];

      //Saves all units ids of its group
      _unitsInGroup = groupsUnits getOrDefault [_newgroup,[]];
      _unitsInGroup pushBack _x;
      groupsUnits set [_newgroup,_unitsInGroup];
    };
  };
}foreach EntitiesListData;


//since the function is so slow, we do it only when necessary
private _alreadyFound = createHashMap;
/*
Since we only have the vehicle name, seatch the vehicle classname using the vehicle name as input
In case some mod is mission, a placeholder is created
*/
{
  _data = EntitiesListData get _x;
  _largo = count _data;
  if (_largo < 4) then { //is a vehicle
    if (_largo isNotEqualTo 4) then {//classname
      _VehicleName = _data select 0;
      if ( (_alreadyFound getOrDefault [_VehicleName,""]) isnotequalto "" ) then {
          _data pushBack (_alreadyFound get _VehicleName);
      }else{
          _classname = [_VehicleName] call O2A_fnc_nameToClassName;
          _data pushBack _classname;
          if (_classname isequalto "Land_VR_Target_MRAP_01_F") then {hint "Some vehicles classname cant be found, are all mods used on mission loaded?"};
      };
      entitiesListData set [_x,_data];
    };
  };
}foreach entitiesListData;
