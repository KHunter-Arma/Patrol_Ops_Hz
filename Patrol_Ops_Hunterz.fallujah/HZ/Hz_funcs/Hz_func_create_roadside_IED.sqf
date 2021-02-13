/*

            Hunter'z Roadside IED Function

Places a roadside IED. Make sure IED is of type that arms automatically when created.
In ACE, use "Editor" type mines to achieve this.

Params: [position,radius,type of mine]


*/

private ["_radius", "_type", "_roadarr", "_road", "_roadpos", "_iedpos", "_ieddir", "_ied", "_pos"];

_pos = _this select 0;
_radius = _this select 1;
_type = _this select 2;

_roadarr = _pos  nearroads _radius;
if ((count _roadarr) < 1) exitwith {};
_road = _roadarr select 0;

_roadpos = getposatl _road;

_iedpos = (boundingbox _road) select 0;
_iedpos = _road modeltoworld _iedpos;

_iedpos = [_iedpos select 0,_iedpos select 1, -0.1];

_ieddir = (getdir _road) + 90;

_ied = _type createvehicle [0,0,0];
_ied setdir _ieddir;
_ied setposatl _iedpos;
