   /*
   
   //// Black Ops  /////
   
   Mercenary_Default9 - XM8 (short sleeve standard)
   Mercenary_Default10 - XM8 GL (long sleeve standard)
   Mercenary_Default26 - Assault (squad leader)
   Mercenary_Default22 - Operator (team leader)
   Mercenary_Default28 - Medic
   
   ///////Desert dudes////////
   
   Mercenary_Default4 - Woodland pants
   Mercenary_Default21 - ACU pants
   Mercenary_Default23 - This is the Medic. MTP pants (helmet is also MTP on this one)
   Mercenary_Default20 - Digital Desert Camo. Copied from US Marines
   
   */
   
if (isnil "JOINTOP_MEDICS") then {JOINTOP_MEDICS = ["76561198361995785"];};
if (isnil "JOINTOP_ARMORED") then {JOINTOP_ARMORED = [];};
if (isnil "JOINTOP_PILOT") then {JOINTOP_PILOT = [];};
if (isnil "JOINTOP_ARTY") then {JOINTOP_ARTY = [];};

 
private ["_specialslotarr"];
_specialslotarr = ["Mercenary_Default9","Mercenary_Default10","Mercenary_Default26","Mercenary_Default22","Mercenary_Default28", //black ops
 "Mercenary_Default21","Mercenary_Default4","Mercenary_Default23","Mercenary_Default20" //desert uniform
 ]; 
 
 waituntil {introseqdone};
 
 if ((typeOf player) in _specialslotarr) then {
 
       
        hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>Warning, you are in a reserved slot. Authorization check will now commence!</t>"];
        sleep 15;



        if (!((getPlayerUID player) in Hz_specialpermissions)) then {

        hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! You are not authorized to use this slot. You will now be returned to the lobby</t>"];
        sleep 5; 
        hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! You are not authorized to use this slot. You will now be returned to the lobby</t>"];
        sleep 2;
        endMission "LOSER"; 
        } else {

        hint parseText format ["<t size='1.5' shadow='1' color='#00E500' shadowColor='#000000'>Authorization successful. Welcome %1.</t>", name player];

        };
 
 } else {
 
     if (!(player iskindof "Civilian")) then {
         
         if (player iskindof "Soldier_Base_PMC") then { 
     
            hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>Warning, you are in a reserved slot. Authorization check will now commence!</t>"];
            sleep 15;



            if ((tolower Hz_playertype) == "public") then {

                hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! You are not authorized to use this slot. You will now be returned to the lobby</t>"];
                sleep 5; 
                hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! You are not authorized to use this slot. You will now be returned to the lobby</t>"];
                sleep 2;
                endMission "LOSER"; 
            } else {

                hint parseText format ["<t size='1.5' shadow='1' color='#00E500' shadowColor='#000000'>Authorization successful. Welcome %1.</t>", name player];

            };
            
          } else {
              
               if(player iskindof "USMC_Soldier_Base") then {
               
                  hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>Warning, you are in a reserved slot. Authorization check will now commence!</t>"];
                sleep 15;
          
                if ((tolower Hz_playertype) != "jointop") then {

                    hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! You are not authorized to use this slot. You will now be returned to the lobby</t>"];
                    sleep 5; 
                    hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! You are not authorized to use this slot. You will now be returned to the lobby</t>"];
                    sleep 2;
                    endMission "LOSER"; 
                    
                } else {

                    hint parseText format ["<t size='1.5' shadow='1' color='#00E500' shadowColor='#000000'>Authorization successful. Welcome %1.\nNotice: You have 5 minutes until you gather at least 8 of your unit members into this slot before you are kicked.</t>", name player];
                    
                    player setvariable ["JointOps",true,true];
                    
                    if((getplayeruid player) in JOINTOP_MEDICS) then {player setvariable["cms_medicClass",true];};    
                    
                    [] spawn compile preprocessfilelinenumbers "HZ\Hz_scripts\Hz_jointOpRestrictVehicles.sqf";
                    
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
                
               } else {   
              
                hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>Warning, you are in a reserved slot. Authorization check will now commence!</t>"];
                sleep 15;
          
                if (!((tolower Hz_playertype) == "supervisor")) then {

                    hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! You are not authorized to use this slot. You will now be returned to the lobby</t>"];
                    sleep 5; 
                    hint parseText format ["<t size='1.5' shadow='1' color='#ff0000' shadowColor='#000000'>WARNING! You are not authorized to use this slot. You will now be returned to the lobby</t>"];
                    sleep 2;
                    endMission "LOSER"; 
                } else {

                    hint parseText format ["<t size='1.5' shadow='1' color='#00E500' shadowColor='#000000'>Authorization successful. Welcome %1.</t>", name player];

                };
                
            };  
          
          };  
              
     };

 };