/*
	Copyright © 2010,International Development & Integration Systems, LLC
	All rights reserved.
	http://www.idi-systems.com/

	For personal use only. Military or commercial use is STRICTLY
	prohibited. Redistribution or modification of source code is 
	STRICTLY prohibited.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
	"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
	LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
	FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
	COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES INCLUDING,
	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
	CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
	LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
	ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
	POSSIBILITY OF SUCH DAMAGE.
*/
//fnc_io_server.sqf
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
private ["_return", "_server", "_ping"];

#define __INTERVAL 0.001
GVAR(hasErrored) = false;
FUNC(serverReadLoop) = {
	private["_ret", "_pipeHandle"];

	_ret = nil;
	_exit = false;
	_count = 0;
	
	if(!(isNil QUOTE(GVAR(pipeHandle)))) then {
		while {!_exit && _count < 50} do {
			_ret = [GVAR(pipeHandle)] call LIB_fnc_readPipe;
			if(!(isNil "_ret")) then {
				if(!(_ret == "_JERR_FALSE")) then {
					if(_ret != "_JERR_NULL") then {
						TRACE_1("got message", _ret);
						_ret call GVAR(ioEventFnc);
					} else {
						_exit = true;
					};
				} else {
					GVAR(hasErrored) = true;
					diag_log text format["%1 ACRE: ACRE HAS EXPERIENCED A PIPE ERROR AND PIPE IS NOW CLOSING!", COMPAT_diag_tickTime];
					if(isMultiplayer) then {
						hint format["ACRE HAS EXPERIENCED A PIPE ERROR (MOST LIKELY A TIMEOUT) AND PIPE IS NOW CLOSING!"];
					};
					[GVAR(pipeHandle)] call LIB_fnc_closePipe;
					GVAR(pipeHandle) = nil;
					_exit = true;
				};
			} else {
				_exit = true;
			};
			_count = _count + 1;
		};
		// diag_log text format["~~~~~~~~~~~~~~!!!!!!!!!!!!!!!!!!!! READ COUNT: %1", _count];
	};
};

FUNC(server) = {
	GVAR(pipeHandle) = nil;
	_connectionFnc = {
		LOG("~~~~~~~~~~~~~CONNNNNECTION FUNNNNNNCTION CALLED!!!!!!!!!!!!!!!!!");
		if(GVAR(runServer)) then {
			if(isNil QUOTE(GVAR(pipeHandle))) then {
				LOG("ATEEEMPTING TO OPEN PIPE!");
				GVAR(pipeHandle) = ["\\.\pipe\acre_comm_pipe"] call LIB_fnc_openPipe;
				if(isNil(QUOTE(GVAR(pipeHandle)))) then { 
					if(time > 15) then {
						if(isMultiplayer) then {
                                                    
                                                        Hz_ACRE_start_successful = false;
                                                        
							COMPAT_hintSilent "WARNING: ACRE IS NOT CONNECTED TO TEAMSPEAK!";
							// we need to reset all player status too
						};
						[] call acre_sys_core_fnc_resetAllPlayers;
						LOG("Teamspeak3 not responding, trying again.");
					};
					GVAR(serverStarted) = false;
				} else {
                                    
                                        Hz_ACRE_start_successful = true;
                                            
					LOG("PIPE OPENED!");
					if(GVAR(hasErrored) && isMultiplayer) then {
						hint format["ACRE HAS RECOVRED FROM A CLOSED PIPE!"];
					};
					GVAR(hasErrored) = false;
					diag_log text format["%1 ACRE: Pipe opened.", COMPAT_diag_tickTime];
					[] call acre_sys_core_fnc_resetAllPlayers;
					GVAR(serverStarted) = true;
				};
			};
		} else {
			[(_this select 1)] call acre_sys_sync_fnc_perFrame_remove;
		};
	};
	[_connectionFnc, 5] call acre_sys_sync_fnc_perFrame_add;
	GVAR(serverStarted) = true;
};
FUNC(ping) = {
	_pingFunc = {
		if(!isNull player) then {
			if(GVAR(serverStarted)) then {
				LOG("ARMA2 TO TS3: PING!");
				// diag_log text format["%1 ACRE: ping!", diag_tickTime];
				_ret = [GVAR(pipeHandle), "ping:"] call LIB_fnc_writePipe;
				if(!(GVAR(runServer))) then {
					diag_log text format["%1 ACRE: Server shutting down ping loop.", COMPAT_diag_tickTime];
					[(_this select 1)] call acre_sys_sync_fnc_perFrame_remove;
				};
			};
		};
	};
	[_pingFunc, 2] call acre_sys_sync_fnc_perFrame_add;
};

// test dsound.dll
[] spawn { // OK
	private["_testVal", "_fail", "_testFunc"];
	
	_testFunc = LIB_fnc_testFunc;
	if(isNil "_testFunc") then {
		while { true } do {
                    
                        Hz_ACRE_start_successful = false;
                            
			diag_log "ACRE: @JayArmA2Lib addon not enabled! Check jayarma2lib installation!";
			hint "ACRE: @JayArmA2Lib addon not enabled! Check jayarma2lib installation!";
			sleep 5; // OK
		};
	} else {
		_testVal = [] call LIB_fnc_testFunc;
		_fail = true;
		
		if(!(isNil "_testVal")) then {
			if(_testVal == "AA") then {
				_fail = false;
			};
		};
		
		if(_fail) then {
			while { true } do {
                            
                                Hz_ACRE_start_successful = false;
                                    
				diag_log "ACRE: JayArma2Lib not installed! Check jayarma2lib installation!";
				hint "ACRE: JayArma2Lib not installed! Check jayarma2lib installation!";
				sleep 5; // OK
			};
		};
	};
	
	GVAR(serverHandle) = [FUNC(serverReadLoop), 0] call acre_sys_sync_fnc_perFrame_add;
	
	GVAR(runserver) = true;
	LOG("server started");
	
	GVAR(pingProcessId) = [] spawn FUNC(ping); // OK
	GVAR(processId) = [] spawn FUNC(server); // OK
	
	
	
	_return = GVAR(processId);
};

true
