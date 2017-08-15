           //Can't find a practical way of disabling CMS when it should be off. This eventhandler resets all CMS damage when hit. Gives nice CMS visual effects when hit but doesn't register damage :)
           //Needs Bad Company version of CMS to assure full functionality. Otherwise weird stuff is prone to happen despite all of these measures...           
           
           _unit = player;

           sleep 3;
           if(alive _unit) then {
               
            _unit setvariable ["cms_bloodVolume",100];
            _unit setvariable ["cms_bloodPressure",[80,120]];
            _unit setvariable ["cms_bloodLoss",0];
            _unit setvariable ["cms_heartRate",80];
            _unit setvariable ["cms_painStatus", 0];
            _unit setvariable ["cms_statusBodyParts", [0,0,0,0]];
            _unit setvariable ["cms_openWounds", [[0,0,0],[0,0,0],[0,0,0],[0,0,0]]];
            _unit setvariable ["cms_airwayStatus", true];
            _unit setvariable ["cms_bones", [[0,0],[0,0],[0,0],[0,0,0,0]]];
            _unit setvariable ["cms_cardiacArrest", false];
            _unit setvariable ["cms_isUnconscious", false];
            
            };