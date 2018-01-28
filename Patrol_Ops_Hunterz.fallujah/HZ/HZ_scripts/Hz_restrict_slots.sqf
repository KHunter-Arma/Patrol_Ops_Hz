waituntil {introseqdone};
    
if((getplayeruid player) in Hz_Officers) then {player setvariable ["TL",true,true];};
if(((getplayeruid player) in Hz_pops_restrictions_supervisorList) || ((getplayeruid player) in Hz_pops_restrictions_publicNoRatioLimit)) then {player setvariable ["PMC",true,true];};
		
if(player iskindof Hz_JointOp_UnitBaseType) then {
  
  if ((tolower Hz_playertype) != "jointop") then {
	
		call Hz_pers_API_disablePlayerSaveStateOnDisconnect;
    endMission "wrongSlot"; 
    
  } else {

    hint parseText format ["<t size='1.5' shadow='1' color='#00E500' shadowColor='#000000'>Authorization successful. Welcome %1.\nNotice: You have 5 minutes until you gather at least 8 of your unit members into this slot before you are kicked.</t>", name player];
    
    player setvariable ["JointOps",true,true];
    
    [] spawn {
      
      _counter = 0;

      while {_counter < 300 && (({_x getvariable ["JointOps",false]}count playableunits) < 8)} do {

        _counter = _counter + 1; 
        sleep 1;

      };

      if (({_x getvariable ["JointOps",false]}count playableunits) < 8) then {
        
        call Hz_pers_API_disablePlayerSaveStateOnDisconnect;
        endMission "JointOpManpower"; 

      };
      
    };

  };  
  
};  