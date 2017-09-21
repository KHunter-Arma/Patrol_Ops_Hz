/********* HUNTER'Z SAVE SYSTEM  ***************
************************************************

		FUNCTION ARRAY PARSER

author:		K.Hunter
		
arguments: _this: _varName	(type: string)

return: 	nothing

************************************************
************************************************/

private ["_varName", "_resultingArray", "_exit", "_index", "_arrayName", "_array", "_count", "_varname"];

_varName = _this;

_resultingArray = []; //parsed array

_exit = false;
_index = 1;
while {!_exit} do {

    _arrayName = format ["%1_%2",_varName,_index];
    _array = missionnamespace getvariable [_arrayName,[]];
    _count = count _array;
	
    if (_count > 0) then {
	
        for "_i" from 0 to (_count - 1) do {
		
            _resultingArray set [count _resultingArray,_array select _i];
		
        };
	
    } else {_exit = true;};

    _index = _index + 1;
	
};

missionnamespace setvariable [_varname,_resultingArray];