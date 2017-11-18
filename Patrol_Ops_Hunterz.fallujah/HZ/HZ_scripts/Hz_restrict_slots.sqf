waituntil {introseqdone};
    
if(player iskindof Hz_JointOp_UnitBaseType) then {
  
  if ((tolower Hz_playertype) != "jointop") then {

    disableUserInput true;
    hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! You are not authorized to use this slot. You will now be returned to the lobby</t>"];
    uisleep 3; 
    hintsilent parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! You are not authorized to use this slot. You will now be returned to the lobby</t>"];
    uisleep 2;
    disableUserInput false;
    uisleep 1;
    endMission "LOSER"; 
    
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
        
        hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! You have less than 8 members online. Joint operations are not available with less than 8 of your unit's members online.</t>"];
        sleep 5; 
        hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! You have less than 8 members online. Joint operations are not available with less than 8 of your unit's members online.</t>"];
        sleep 2;
        endMission "LOSER"; 

      };
      
    };

  };  
  
};  