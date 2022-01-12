/*
 O2A_fnc_nameToClassName

 decription:
 	Given the name of the vehicle, it returns it class

input:
	["name"] : string of name

output:
	classname if found or "" when not
*/

params ["_name"];

_candidates = (cfgVehicles select {getText (_x >> "displayname") isequalto _name}) apply {configname _x};
reverse _candidates;
_classname = "";
{
  _veh = createvehicle [_x,[0,0,1000],[],0,"CAN_COLLIDE"];
  if (isnull _veh) then {
	  continue
  }else{
	  deleteVehicle _veh;
	  if (true) exitwith {_classname = _x};
  };
}foreach _candidates;
_classname
