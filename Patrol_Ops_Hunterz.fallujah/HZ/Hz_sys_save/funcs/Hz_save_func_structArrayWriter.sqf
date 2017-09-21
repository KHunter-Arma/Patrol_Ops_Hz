/********* HUNTER'Z SAVE SYSTEM  ***************
************************************************

		FUNCTION STRUCT ARRAY WRITER

author:     K.Hunter
		
arguments:  _this select 0: Array of nested array structs (type: array)
            _this select 1: Array name                    (type: string)
            _this select 2: Max array size                (type: number)

return: 	  nothing

************************************************
************************************************/

private ["_array","_arrayName","_maxSize","_element","_foreachIndex"];

_array = _this select 0;
_arrayName = _this select 1;
_maxSize = _this select 2;

if ((count _array) > 0) then {

    {
        _element = _x;        
        // this is to prevent the system from breaking down - otherwise this is an unexpected input
        if((typename _x) != "ARRAY") then {_element = [_x];};
    
        [_element,format ["%1_%2",_arrayName,_foreachIndex],_maxSize] call Hz_save_func_nestedArrayStructWriter;
    
    } foreach _array;

};