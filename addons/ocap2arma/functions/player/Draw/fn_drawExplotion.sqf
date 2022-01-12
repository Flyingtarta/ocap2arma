/*
  Draws the explotions granades and smoke granades

  wip 30% done 
*/
params ["_imgpath","_startFrame","_endFrame","_direction","_pos","_classname"];

if ( (count _pos) isequalto 1) then {_pos = _pos select 0}else{_pos = _pos select 2};
_ammo = createVehicle [_classname,_pos,[],0,"CAN_COLLIDE"];

triggerammo _ammo;
_ammo setdamage 1;

if (_startFrame +1 < _endFrame) then {
  [_ammo,_endFrame] call {
    waituntil { _frame = localNamespace getvariable ["O2A_PLAYER_Frame",0]; _frame > _endFrame};
    deleteVehicle  _ammo;
  };
};
/*
 if !(["smoke","white"] findif {_x in _class} isequalto -1) then {
     if (count _pos isequalto 1) then {_pos = _pos select 0}else{_pos = _pos select 2};
     _pos = ASLToATL _pos;
     _AMMO = createVehicle ["SmokeShell",_pos,[],0,"CAN_COLLIDE"];
     triggerammo _AMMO;
     //"SmokeShell"

 }else{
     if (count _pos isequalto 1) then {_pos = _pos select 0}else{_pos = _pos select 2};
     _AMMO = createVehicle ["APERSTripMine_Wire_Ammo",_pos,[],0,"CAN_COLLIDE"];
     _pos = ASLToATL _pos;
     _ammo setdamage 1;
 }
