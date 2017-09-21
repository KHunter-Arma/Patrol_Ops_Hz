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

#include "\x\cba\addons\main\script_macros_common.hpp"

#ifndef PRELOAD_ADDONS
	#define PRELOAD_ADDONS class CfgAddons \
{ \
	class PreloadAddons \
	{ \
		class ADDON \
		{ \
			list[]={ QUOTE(ADDON) }; \
		}; \
	}; \
};
#endif


/**
ARMA2/VBS2 COMPAT SECTION
**/

#include "script_lib.hpp"
#include "script_command_replace.hpp"


/**
END ARMA2/VBS2 COMPAT SECTION
**/

// local event handler naming macro
#define ACRE_EVENT(x) QUOTE(acre_##x)

#define CALL_RPC(proc,params)	[proc, params] call acre_sys_rpc_fnc_callRemoteProcedure;

#define NO_DEDICATED	if(isDedicated) exitWith { }
#define NO_CLIENT		if(!isServer) exitWith { }

#define ACRE_OBELISK	acre_sys_server_obelisk

#define RGB_GREEN 0, 0.5, 0, 1
#define RGB_BLUE 0, 0, 1, 1
#define RGB_ORANGE 0.5, 0.5, 0, 1
#define RGB_RED 1, 0, 0, 1
#define RGB_YELLOW 1, 1, 0, 1
#define RGB_WHITE 1, 1, 1, 1
#define RGB_GRAY 0.5, 0.5, 0.5, 1
#define RGB_BLACK 0, 0, 0, 1
#define RGB_MAROON 0.5, 0, 0, 1
#define RGB_OLIVE 0.5, 0.5, 0, 1
#define RGB_NAVY 0, 0, 0.5, 1
#define RGB_PURPLE 0.5, 0, 0.5, 1
#define RGB_FUCHSIA 1, 0, 1, 1
#define RGB_AQUA 0, 1, 1, 1
#define RGB_TEAL 0, 0.5, 0.5, 1
#define RGB_LIME 0, 1, 0, 1
#define RGB_SILVER 0.75, 0.75, 0.75, 1

#define FREE_RADIO_POSTFIX "_freeRadio"
#define METADATA_POSTFIX "_metadata"

#define MASTER_RADIO_LIST "a2ts_sys_radio_masterRadioList"
#define ACRE_OBELISK acre_sys_server_obelisk

#define INDEX_CARRY_BY 		0
#define INDEX_USE_BY 		1

#define ACTIVE_RADIO "acre_active_radio"

#define OPEN_RADIO_PATH "\idi\clients\acre\addons\sys_radio\fnc_openRadio.sqf"
#define LIST_RADIO_PATH "\idi\clients\acre\addons\sys_radio\fnc_listRadios.sqf"

#define ACRE_INDEX_CONTROLLERDATA		2 
#define ACRE_INDEX_UIDATA				1
#define ACRE_INDEX_TXDATA				0

#define ACRE_INDEX_FREQUENCY			0
#define ACRE_INDEX_POWER				1

#define ACRE_CONTROLLERDATA(var) (var select ACRE_INDEX_CONTROLLERDATA)
#define ACRE_UIDATA(var) (var select ACRE_INDEX_UIDATA)
#define ACRE_TXDATA(var) (var select ACRE_INDEX_TXDATA)

#define ACRE_SET_CONTROLLERDATA(var, data) var set [ACRE_INDEX_CONTROLLERDATA, data]
#define ACRE_SET_UIDATA(var, data) var set [ACRE_INDEX_UIDATA, data]
#define ACRE_SET_TXDATA(var, data) var set [ACRE_INDEX_TXDATA, data]

#define ACRE_FREQ(var) ((var select ACRE_INDEX_TXDATA) select ACRE_INDEX_FREQUENCY)
#define ACRE_POWER(var) ((var select ACRE_INDEX_TXDATA) select ACRE_INDEX_POWER)

#define ACRE_HINT(title,line1,line2)	[title, line1, line2] call acre_sys_list_fnc_displayHint;

#define ACRE_DEBUG_LOG(message,value1)									ACRE_DEBUG_STR = ACRE_DEBUG_STR + format["%1 %2:%3 %4%5", COMPAT_diag_tickTime, __FILE__, __LINE__, QUOTE(message), toStr[10]];\
																		player sideChat format["%1 %2:%3 %4", COMPAT_diag_tickTime, __FILE__, __LINE__, QUOTE(message)];

#define ACRE_DEBUG_TRACE1(message,value1)								ACRE_DEBUG_STR = ACRE_DEBUG_STR + format["%1 %2:%3 %4 %5%6", COMPAT_diag_tickTime, __FILE__, __LINE__, QUOTE(message), value1, toStr[10]];\
																		player sideChat format["%1 %2:%3 %4%5", COMPAT_diag_tickTime, __FILE__, __LINE__, QUOTE(message), value1];
													
#define ACRE_DEBUG_TRACE2(message,value1,value2)						ACRE_DEBUG_STR = ACRE_DEBUG_STR + format["%1 %2:%3 %4 %5 %6%7", COMPAT_diag_tickTime, __FILE__, __LINE__, QUOTE(message), value1, value2, toStr[10]];\
																		player sideChat format["%1 %2:%3 %4 %5 %6", COMPAT_diag_tickTime, __FILE__, __LINE__, QUOTE(message), value1, value2];
													
#define ACRE_DEBUG_TRACE3(message,value1,value2,value3)					ACRE_DEBUG_STR = ACRE_DEBUG_STR + format["%1 %2:%3 %4 %5 %6 %7%8", COMPAT_diag_tickTime, __FILE__, __LINE__, QUOTE(message), value1, value2, value3, toStr[10]];\
																		player sideChat format["%1 %2:%3 %4 %5 %6 %7", COMPAT_diag_tickTime, __FILE__, __LINE__, QUOTE(message), value1, value2, value3];
													
#define ACRE_DEBUG_TRACE4(message,value1,value2,value3,value4)			ACRE_DEBUG_STR = ACRE_DEBUG_STR + format["%1 %2:%3 %4 %5 %6 %7 %8%9", COMPAT_diag_tickTime, __FILE__, __LINE__, QUOTE(message), value1, value2, value3, value4, toStr[10]];\
																		player sideChat format["%1 %2:%3 %4 %5 %6 %7 %8", COMPAT_diag_tickTime, __FILE__, __LINE__, QUOTE(message), value1, value2, value3, value4];
													
#define ACRE_DEBUG_TRACE5(message,value1,value2,value3,value4,value5)	ACRE_DEBUG_STR = ACRE_DEBUG_STR + format["%1 %2:%3 %4 %5 %6 %7 %8 %9%10", COMPAT_diag_tickTime, __FILE__, __LINE__, QUOTE(message), value1, value2, value3, value4, value5, toStr[10]];\
																		player sideChat format["%1 %2:%3 %4 %5 %6 %7 %8 %9", COMPAT_diag_tickTime, __FILE__, __LINE__, QUOTE(message), value1, value2, value3, value4, value5];
													
							
#define ACRE_DEBUG_FLUSH				copyToClipboard ACRE_DEBUG_STR;\
										ACRE_DEBUG_STR = "";

#define IS_REMOTE(radio)	

#define __CFG_GAPI_FUNCTION(x, y) getText ( configFile >> "CfgAcreRadios" >> x >> "interface" >> y )

#define GETPOSASLDIS(x)	(x call acre_sys_signal_fnc_getPosASLAtDistance)
		
#include "script_radio_macro.hpp"

/*
Component Types
*/
#define COMPONENT_ANTENNA 	"ACRE_COMPONENT_ANTENNA"
#define COMPONENT_FILL		"ACRE_COMPONENT_FILL"
#define	COMPONENT_HANDSET	"ACRE_COMPONENT_HANDSET"
#define COMPONENT_HEADSET	"ACRE_COMPONENT_HEADSET"

/*
Voice Curve Models
*/
#define	ACRE_CURVE_MODEL_ORIGINAL		0
#define	ACRE_CURVE_MODEL_AMPLITUDE		1
#define	ACRE_CURVE_MODEL_SELECTABLE_A	2
#define	ACRE_CURVE_MODEL_SELECTABLE_B	3

/*
Antenna Defines
*/
// polarization
#define VERTICAL_POLARIZE	0
#define HORIZONTAL_POLARIZE	1

// connectors
#define CONNECTOR_TNC			0 // TNC screw jack style antenna connector
#define CONNECTOR_BNC			1 // BNC locking jack style antenna connector
#define CONNECTOR_U_283			2 // 5 or 6 pin audio/data (5 pin can work on 6 pin connecter)
#define CONNECTOR_CONN_MC2127 	3 // 27 pin data connector

#define AVERAGE_MAN_HEIGHT	1.8288

#define ACRE_M_MAG(x,y)	class _xx_##x {magazine = ##x; count = ##y;}
#define ACRE_M_WEP(x,y)	class _xx_##x {weapon = ##x; count = ##y;}

#define ACRE_TEXT_RED(Text) ("<t color='#FF0000'>" + ##Text + "</t>")

#define ACREALIVE(obj)		(alive obj)

#define REMOTEDEBUGMSG(msg)	["acre_sys_server_remoteDebugMsg", msg] call LIB_fnc_globalEvent;