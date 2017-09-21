/********* HUNTER'Z SAVE SYSTEM  ***************
************************************************

		FUNCTION SPLIT ARRAY WRITER
		
author:		K.Hunter

arguments:	_this select 0: _arrayofArrays		(type: array)
            _this select 1: _varName          (type: string)	
			
return: 	nothing

************************************************
************************************************/
#include "debug_console.hpp"

private ["_arrayName","_msg","_arrayofArrays","_varName","_numofArrays"];

_arrayofArrays = _this select 0;
_varName = _this select 1;  //string

_numofArrays = count _arrayofArrays;

for "_i" from 1 to _numofArrays do {

    _arrayName = format ["%1_%2",_varName,_i];
    _msg = format ["%1 = %2;",_arrayName,(_arrayofArrays select (_i - 1))];
    conFile(_msg);
};

