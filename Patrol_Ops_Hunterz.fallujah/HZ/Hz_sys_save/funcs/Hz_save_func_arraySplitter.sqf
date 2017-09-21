/********* HUNTER'Z SAVE SYSTEM  ***************
************************************************

		FUNCTION ARRAY SPLITTER

author:		K.Hunter
		
arguments:	_this select 0: _array		(type: array)
            _this select 1: _maxSize	(type: number)	
			
return:     _outputArrayofArrays      (type: array)

************************************************
************************************************/

private ["_array", "_maxSize", "_outputArrayofArrays", "_outputArrayCount", "_index", "_temp"];

_array = _this select 0;
_maxSize = _this select 1;

// this is to prevent the system from breaking down - otherwise this is an unexpected input
if((typename _array) != "ARRAY") then {_array = [_array];};

_outputArrayCount = (floor ((count _array)/_maxSize)) + 1;
_outputArrayofArrays = [];
_index = 0;

if(_outputArrayCount > 1) then {

    for "_i" from 1 to _outputArrayCount do {

        _temp = [];
	
        for "_j" from 0 to (_maxSize - 1) do {
	
            if(_index == (count _array)) exitwith {};   
                
            _temp set [_j,_array select _index];
            _index = _index + 1;
	
        };
	
        _outputArrayofArrays set [count _outputArrayofArrays, _temp];
 
    };

} else {

    _outputArrayofArrays = [_array];

};

_outputArrayofArrays