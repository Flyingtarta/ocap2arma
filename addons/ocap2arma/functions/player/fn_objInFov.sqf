/*

its only drawn if on camera fov (WIP)

return bool : its in fov or not 

*/

params["_pos","_camera"];

_wts = worldToScreen _pos;

true /*
if (_wts isequalto [] ) then {false} else {true};
/*
if ( (_wts findif {_val = abs _x; _val < 1.5 && 0.75 > _val}) isequalto -1) then {
  false
}else{
  True
};
