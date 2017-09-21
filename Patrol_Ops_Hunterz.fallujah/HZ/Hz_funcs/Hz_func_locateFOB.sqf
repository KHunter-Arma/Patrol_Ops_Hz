private ["_FOBobject","_return","_HQlist"];

_FOBobject = objNull;
_HQlist = [];
_return = [0,0,0];

{

  if(typeof _x == "WarfareBDepot") then {_HQlist set [count _HQlist,_x];};  
  
} foreach hz_fort_array;


{
  
  if((count nearestobjects [_x,["ACamp_EP1"],100]) > 1) exitwith {_FOBobject = _x;};

} foreach _HQlist;

if(!isnull _FOBobject) then {_return = getposatl _FOBobject;};

_return