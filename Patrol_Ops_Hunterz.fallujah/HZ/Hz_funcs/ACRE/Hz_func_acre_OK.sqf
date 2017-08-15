#include "script_component.hpp"
private ["_return","_testVal", "_fail", "_testFunc"];
#define __INTERVAL 0.001

_return = true;

if(isNil(QUOTE(GVAR(pipeHandle)))) then {
if(time > 15) then { 

//ACRE not connected to TS3
_return = false; 
};

};

if(_return) then {

 //Test to check JayArma2Lib errors   
        
	_testFunc = LIB_fnc_testFunc;
	if(isNil "_testFunc") then {

     _return = false;
        
            
	} else {
		_testVal = [] call LIB_fnc_testFunc;
		_fail = true;
		
		if(!(isNil "_testVal")) then {
			if(_testVal == "AA") then {
				_fail = false;
			};
		};
		
		if(_fail) then {

         _return = false;
        
            
		};
	};
};



_return