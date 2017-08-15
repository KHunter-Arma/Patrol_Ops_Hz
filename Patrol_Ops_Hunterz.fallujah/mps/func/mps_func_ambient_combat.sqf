//Written by K.Hunter



/////////////////////////////////////////////////////////
/*

WARNING! This script is deprecated. Patrol Ops Hunter'z no longer uses ACM

*/
/////////////////////////////////////////////////////////


sleep 10;
waitUntil {!(isNil "mps_ambient_insurgents")};
if(mps_ambient_insurgents) then
{

 
	//ACM_INS settings
                
		waitUntil {!isNil {BIS_ACM1 getVariable "initDone"}};
		waitUntil {BIS_ACM1 getVariable "initDone"};
                
         //      [-1, {hint "ACM initialised";}] call CBA_fnc_globalExecute;
                
                
		[] spawn 
		{
			waitUntil {!(isnil "BIS_fnc_init")};
			[1, BIS_ACM1] call BIS_ACM_setIntensityFunc;                 //Sets the intensity of the ACM, in other words, determines how active it will be. Starts at 0 ends at 1.0, its been known to fail using 0.7 and 0.8
			[BIS_ACM1, 100, 1500] call BIS_ACM_setSpawnDistanceFunc;      // This is the radius on where the units will spawn around the unit the module is sync'd to.
		//      [["BIS_TK","BIS_US","BIS_BAF_MTP"], BIS_ACM1] call BIS_ACM_setFactionsFunc;     // This tells the ACM which faction of units it will spawn.
                        [["BIS_TK","BIS_US"], BIS_ACM1] call BIS_ACM_setFactionsFunc;
			[0.2, 0.2, BIS_ACM1] call BIS_ACM_setSkillFunc;                // This determines what the skill rating for the spawned units will be
			[0.6, 1, BIS_ACM1] call BIS_ACM_setAmmoFunc;               // This sets their amount of ammo they spawn with
			["ground_patrol", 1, BIS_ACM1] call BIS_ACM_setTypeChanceFunc; //Chance of patrol type of appearing. 0.0 to 1.0
			["air_patrol", 0.2, BIS_ACM1] call BIS_ACM_setTypeChanceFunc;    // Same thing for air patrols
		//	[BIS_ACM1, ["TK_InfantrySquad","TK_InfantrySection","US_MQ9Flight","US_C130JFlight","US_CH47FFlight","BAF_Section_DDPM","BAF_Fireteam_DDPM","US_RifleSquad","US_DeltaForceTeam","US_AH64DFlight","US_UH60MFlight","US_MechanizedInfantrySquadICVM2","US_MechanizedInfantrySquadICVMK19","TK_MotorizedInfanterySquad","TK_InfantrySectionMG","TK_SniperTeam","TK_SpecialPurposeSquad","TK_MechanizedReconSection","TK_T55Platoon","TK_T72Platoon","TK_MechanizedInfantrySquadBMP2","TK_MechanizedInfantrySquadBTR60"]] call BIS_ACM_addGroupClassesFunc;   // This determines which exact units will spawn from the group **Citation needed**
 		 	[BIS_ACM1, ["TK_InfantrySquad","TK_InfantrySection","US_MQ9Flight","US_CH47FFlight","US_RifleSquad","US_DeltaForceTeam","US_AH64DFlight","US_UH60MFlight","US_MechanizedInfantrySquadICVM2","TK_MotorizedInfanterySquad","TK_InfantrySectionMG","TK_SniperTeam","TK_SpecialPurposeSquad","TK_MechanizedReconSection","TK_T55Platoon","TK_T72Platoon","TK_MechanizedInfantrySquadBMP2","TK_MechanizedInfantrySquadBTR60"]] call BIS_ACM_addGroupClassesFunc;   // This determines which exact units will spawn from the group **Citation needed**

                        
//[-1, {hint "ACM configured";}] call CBA_fnc_globalExecute;
 
 
 
                        sleep 10;
                        waitUntil {!isNil {BIS_ACM2 getVariable "initDone"}};
		        waitUntil {BIS_ACM2 getVariable "initDone"};
                        sleep 2;
                        [1, BIS_ACM2] call BIS_ACM_setIntensityFunc;                 //Sets the intensity of the ACM, in other words, determines how active it will be. Starts at 0 ends at 1.0, its been known to fail using 0.7 and 0.8
			[BIS_ACM2, 100, 1500] call BIS_ACM_setSpawnDistanceFunc;
			[["BIS_TK"], BIS_ACM2] call BIS_ACM_setFactionsFunc;     // This tells the ACM which faction of units it will spawn.
			[0.2, 0.2, BIS_ACM2] call BIS_ACM_setSkillFunc;                // This determines what the skill rating for the spawned units will be
			[0.6, 1, BIS_ACM2] call BIS_ACM_setAmmoFunc;               // This sets their amount of ammo they spawn with
			["ground_patrol", 1, BIS_ACM2] call BIS_ACM_setTypeChanceFunc; //Chance of patrol type of appearing. 0.0 to 1.0
			["air_patrol", 0, BIS_ACM2] call BIS_ACM_setTypeChanceFunc;    // Same thing for air patrols
 		 	[BIS_ACM2, ["TK_InfantrySquad","TK_InfantrySection","US_DeltaForceTeam","US_DeltaPatrolHMMWV","TK_MotorizedInfanterySquad","TK_InfantrySectionMG","TK_SniperTeam","TK_SpecialPurposeSquad","TK_MechanizedReconSection","TK_T55Platoon","TK_T72Platoon","TK_MechanizedInfantrySquadBMP2","TK_MechanizedInfantrySquadBTR60"]] call BIS_ACM_addGroupClassesFunc;   // This determines which exact units will spawn from the group **Citation needed**
 /*
                        [0.2, BIS_ACM3] call BIS_ACM_setIntensityFunc;                 //Sets the intensity of the ACM, in other words, determines how active it will be. Starts at 0 ends at 1.0, its been known to fail using 0.7 and 0.8
			[BIS_ACM3, 200, 500] call BIS_ACM_setSpawnDistanceFunc;
			[["BIS_TK","BIS_US","BIS_BAF_MTP","PMC_BAF"], BIS_ACM3] call BIS_ACM_setFactionsFunc;     // This tells the ACM which faction of units it will spawn.
			[0.1, 0.4, BIS_ACM3] call BIS_ACM_setSkillFunc;                // This determines what the skill rating for the spawned units will be
			[0.6, 1.0, BIS_ACM3] call BIS_ACM_setAmmoFunc;               // This sets their amount of ammo they spawn with
			["ground_patrol", 1.0, BIS_ACM3] call BIS_ACM_setTypeChanceFunc; //Chance of patrol type of appearing. 0.0 to 1.0
			["air_patrol", 0.3, BIS_ACM3] call BIS_ACM_setTypeChanceFunc;    // Same thing for air patrols
			[BIS_ACM3, ["TK_InfantrySquad","TK_InfantrySection","US_MQ9Flight","US_C130JFlight","US_CH47FFlight","BAF_Section","BAF_Fireteam","BAF_MSection","BAF_MTeam","BAF_MPatrol","BAF_MechSec","PMC_Field_Security_Patrol","PMC_Armored_Patrol","US_RifleSquad","US_Team","US_DeltaForceTeam","US_DeltaPatrolHMMWV","US_AH64DFlight","US_UH60MFlight","US_MH6JFlight","US_MechanizedInfantrySquadICVM2","US_MechanizedInfantrySquadICVMK19","US_MotorizedSection","TK_MotorizedPatrol","TK_MotorizedInfanterySquad","TK_InfantrySectionMG","TK_SniperTeam","TK_SpecialPurposeSquad","TK_MechanizedReconSection","TK_T55Platoon","TK_T72Platoon","TK_MechanizedInfantrySquadBMP2","TK_MechanizedInfantrySquadBTR60"]] call BIS_ACM_addGroupClassesFunc;   // This determines which exact units will spawn from the group **Citation needed**
 
                        [0.2, BIS_ACM4] call BIS_ACM_setIntensityFunc;                 //Sets the intensity of the ACM, in other words, determines how active it will be. Starts at 0 ends at 1.0, its been known to fail using 0.7 and 0.8
			[BIS_ACM4, 200, 500] call BIS_ACM_setSpawnDistanceFunc;
			[["BIS_TK","BIS_US","BIS_BAF_MTP","PMC_BAF"], BIS_ACM4] call BIS_ACM_setFactionsFunc;     // This tells the ACM which faction of units it will spawn.
			[0.1, 0.4, BIS_ACM4] call BIS_ACM_setSkillFunc;                // This determines what the skill rating for the spawned units will be
			[0.6, 1.0, BIS_ACM4] call BIS_ACM_setAmmoFunc;               // This sets their amount of ammo they spawn with
			["ground_patrol", 1.0, BIS_ACM4] call BIS_ACM_setTypeChanceFunc; //Chance of patrol type of appearing. 0.0 to 1.0
			["air_patrol", 0.3, BIS_ACM4] call BIS_ACM_setTypeChanceFunc;    // Same thing for air patrols
			[BIS_ACM4, ["TK_InfantrySquad","TK_InfantrySection","US_MQ9Flight","US_C130JFlight","US_CH47FFlight","BAF_Section","BAF_Fireteam","BAF_MSection","BAF_MTeam","BAF_MPatrol","BAF_MechSec","PMC_Field_Security_Patrol","PMC_Armored_Patrol","US_RifleSquad","US_Team","US_DeltaForceTeam","US_DeltaPatrolHMMWV","US_AH64DFlight","US_UH60MFlight","US_MH6JFlight","US_MechanizedInfantrySquadICVM2","US_MechanizedInfantrySquadICVMK19","US_MotorizedSection","TK_MotorizedPatrol","TK_MotorizedInfanterySquad","TK_InfantrySectionMG","TK_SniperTeam","TK_SpecialPurposeSquad","TK_MechanizedReconSection","TK_T55Platoon","TK_T72Platoon","TK_MechanizedInfantrySquadBMP2","TK_MechanizedInfantrySquadBTR60"]] call BIS_ACM_addGroupClassesFunc;   // This determines which exact units will spawn from the group **Citation needed**
 
                        [0.2, BIS_ACM5] call BIS_ACM_setIntensityFunc;                 //Sets the intensity of the ACM, in other words, determines how active it will be. Starts at 0 ends at 1.0, its been known to fail using 0.7 and 0.8
			[BIS_ACM5, 200, 500] call BIS_ACM_setSpawnDistanceFunc;
			[["BIS_TK","BIS_US","BIS_BAF_MTP","PMC_BAF"], BIS_ACM5] call BIS_ACM_setFactionsFunc;     // This tells the ACM which faction of units it will spawn.
			[0.1, 0.4, BIS_ACM5] call BIS_ACM_setSkillFunc;                // This determines what the skill rating for the spawned units will be
			[0.6, 1.0, BIS_ACM5] call BIS_ACM_setAmmoFunc;               // This sets their amount of ammo they spawn with
			["ground_patrol", 1.0, BIS_ACM5] call BIS_ACM_setTypeChanceFunc; //Chance of patrol type of appearing. 0.0 to 1.0
			["air_patrol", 0.3, BIS_ACM5] call BIS_ACM_setTypeChanceFunc;    // Same thing for air patrols
			[BIS_ACM5, ["TK_InfantrySquad","TK_InfantrySection","US_MQ9Flight","US_C130JFlight","US_CH47FFlight","BAF_Section","BAF_Fireteam","BAF_MSection","BAF_MTeam","BAF_MPatrol","BAF_MechSec","PMC_Field_Security_Patrol","PMC_Armored_Patrol","US_RifleSquad","US_Team","US_DeltaForceTeam","US_DeltaPatrolHMMWV","US_AH64DFlight","US_UH60MFlight","US_MH6JFlight","US_MechanizedInfantrySquadICVM2","US_MechanizedInfantrySquadICVMK19","US_MotorizedSection","TK_MotorizedPatrol","TK_MotorizedInfanterySquad","TK_InfantrySectionMG","TK_SniperTeam","TK_SpecialPurposeSquad","TK_MechanizedReconSection","TK_T55Platoon","TK_T72Platoon","TK_MechanizedInfantrySquadBMP2","TK_MechanizedInfantrySquadBTR60"]] call BIS_ACM_addGroupClassesFunc;   // This determines which exact units will spawn from the group **Citation needed**
 
                        [0.2, BIS_ACM6] call BIS_ACM_setIntensityFunc;                 //Sets the intensity of the ACM, in other words, determines how active it will be. Starts at 0 ends at 1.0, its been known to fail using 0.7 and 0.8
			[BIS_ACM6, 200, 500] call BIS_ACM_setSpawnDistanceFunc;
			[["BIS_TK","BIS_US","BIS_BAF_MTP","PMC_BAF"], BIS_ACM6] call BIS_ACM_setFactionsFunc;     // This tells the ACM which faction of units it will spawn.
			[0.1, 0.4, BIS_ACM6] call BIS_ACM_setSkillFunc;                // This determines what the skill rating for the spawned units will be
			[0.6, 1.0, BIS_ACM6] call BIS_ACM_setAmmoFunc;               // This sets their amount of ammo they spawn with
			["ground_patrol", 1.0, BIS_ACM6] call BIS_ACM_setTypeChanceFunc; //Chance of patrol type of appearing. 0.0 to 1.0
			["air_patrol", 0.3, BIS_ACM6] call BIS_ACM_setTypeChanceFunc;    // Same thing for air patrols
			[BIS_ACM6, ["TK_InfantrySquad","TK_InfantrySection","US_MQ9Flight","US_C130JFlight","US_CH47FFlight","BAF_Section","BAF_Fireteam","BAF_MSection","BAF_MTeam","BAF_MPatrol","BAF_MechSec","PMC_Field_Security_Patrol","PMC_Armored_Patrol","US_RifleSquad","US_Team","US_DeltaForceTeam","US_DeltaPatrolHMMWV","US_AH64DFlight","US_UH60MFlight","US_MH6JFlight","US_MechanizedInfantrySquadICVM2","US_MechanizedInfantrySquadICVMK19","US_MotorizedSection","TK_MotorizedPatrol","TK_MotorizedInfanterySquad","TK_InfantrySectionMG","TK_SniperTeam","TK_SpecialPurposeSquad","TK_MechanizedReconSection","TK_T55Platoon","TK_T72Platoon","TK_MechanizedInfantrySquadBMP2","TK_MechanizedInfantrySquadBTR60"]] call BIS_ACM_addGroupClassesFunc;   // This determines which exact units will spawn from the group **Citation needed**
 */
 
 
		};
                
                sleep 1;
                
                
                
                // re-initialize ACM. Thank you Katipo66 from the community
               []spawn {
                        
           //             _grpacm1 = creategroup resistance;
           //             _grpacm2 = creategroup resistance;
                        
                        while (true) do {
                    
                        sleep 3600;
                    
                        waituntil {sleep 120; count playableunits == 0;};
                      
           //           _typeguy = typeof ambguy;
                        _posguy1 = getpos ambguy;
                        _posguy2 = getpos ambguy_2;
                        ambguy setdamage 1;
                        ambguy_2 setdamage 1;
                        
                        sleep 180;
                        
                        waitUntil {sleep 2; alive ambguy};
                        ambguy setpos _posguy1;
                        ambguy setunitpos "down"; ambguy disableai "move"; ambguy disableai "target"; ambguy disableai "autotarget"; ambguy disableai "anim"; group ambguy setBehaviour "STEALTH"; removeallweapons ambguy;
                        waitUntil {sleep 2; alive ambguy_2};
                        ambguy_2 setpos _posguy2;
                        ambguy_2 setunitpos "down"; ambguy_2 disableai "move"; ambguy_2 disableai "target"; ambguy_2 disableai "autotarget"; ambguy_2 disableai "anim"; group ambguy_2 setBehaviour "STEALTH"; removeallweapons ambguy_2;

                        
                        sleep 10;
   /*                    
                       deletevehicle ambguy;
                       deletevehicle ambguy_2;
                        
                       
                       _LogicCenter1 = createCenter sideLogic;
                       _LogicGroup1 = createGroup _LogicCenter1;
                 
                 
                    _typeguy createunit [_posguy1, _grpacm1, "ambguy = this; this setPos [getPos this select 0, getPos this select 1, ((getPos this select 2)+10)]; this setunitpos ""down""; this disableai ""move""; this disableai ""target""; this disableai ""autotarget""; this disableai ""fsm""; this disableai ""anim""; this allowdamage false; this addEventHandler [""HandleDamage"", {false}]; group this setBehaviour ""STEALTH""; removeallweapons this;",
                                           0, "private"];
                        
                        waitUntil {alive ambguy};
                        "AmbientCombatManager" createUnit [[0,0,0], _LogicGroup1, "BIS_ACM3 = this;"];
                        BIS_ACM3 synchronizeObjectsAdd [ambguy];
                        
                       waitUntil {!isNil {BIS_ACM3 getVariable "initDone"}};
                       _fsm1 = BIS_ACM3 execFSM "ca\modules\ambient_combat\data\fsms\ambientcombat.fsm";
                       waitUntil {BIS_ACM3 getVariable "initDone"};
                       
                       
                        [1, BIS_ACM3] call BIS_ACM_setIntensityFunc;                 //Sets the intensity of the ACM, in other words, determines how active it will be. Starts at 0 ends at 1.0, its been known to fail using 0.7 and 0.8
			[BIS_ACM3, 100, 1500] call BIS_ACM_setSpawnDistanceFunc;      // This is the radius on where the units will spawn around the unit the module is sync'd to.
                        [["BIS_TK","BIS_US"], BIS_ACM3] call BIS_ACM_setFactionsFunc;
			[0.2, 0.2, BIS_ACM3] call BIS_ACM_setSkillFunc;                // This determines what the skill rating for the spawned units will be
			[0.6, 1, BIS_ACM3] call BIS_ACM_setAmmoFunc;               // This sets their amount of ammo they spawn with
			["ground_patrol", 1, BIS_ACM3] call BIS_ACM_setTypeChanceFunc; //Chance of patrol type of appearing. 0.0 to 1.0
			["air_patrol", 0.2, BIS_ACM3] call BIS_ACM_setTypeChanceFunc;    // Same thing for air patrols
 		 	[BIS_ACM3, ["TK_InfantrySquad","TK_InfantrySection","US_MQ9Flight","US_CH47FFlight","US_RifleSquad","US_DeltaForceTeam","US_AH64DFlight","US_UH60MFlight","US_MechanizedInfantrySquadICVM2","TK_MotorizedInfanterySquad","TK_InfantrySectionMG","TK_SniperTeam","TK_SpecialPurposeSquad","TK_MechanizedReconSection","TK_T55Platoon","TK_T72Platoon","TK_MechanizedInfantrySquadBMP2","TK_MechanizedInfantrySquadBTR60"]] call BIS_ACM_addGroupClassesFunc;   // This determines which exact units will spawn from the group **Citation needed**
        
        sleep 60;
                       
                       _LogicCenter2 = createCenter sideLogic;
                       _LogicGroup2 = createGroup _LogicCenter2;
                       _typeguy createunit [_posguy2, _grpacm2, "ambguy_2 = this; this setPos [getPos this select 0, getPos this select 1, ((getPos this select 2)+10)]; this setunitpos ""down""; this disableai ""move""; this disableai ""target""; this disableai ""autotarget""; this disableai ""fsm""; this disableai ""anim""; this allowdamage false; this addEventHandler [""HandleDamage"", {false}]; group this setBehaviour ""STEALTH""; removeallweapons this;",
                                            0, "private"];
                        
                        waitUntil {alive ambguy_2};
                        "AmbientCombatManager" createUnit [[0,0,0], _LogicGroup1, "BIS_ACM4 = this;"];
                        BIS_ACM4 synchronizeObjectsAdd [ambguy];
                        
                       waitUntil {!isNil {BIS_ACM4 getVariable "initDone"}};
                       _fsm2 = BIS_ACM4 execFSM "ca\modules\ambient_combat\data\fsms\ambientcombat.fsm";
                       waitUntil {BIS_ACM4 getVariable "initDone"};                    
                      
                       
                       
		*/	
            
                     };
    

               };
                
 
} else {

 
	//ACM_INS settings
   /*
		waitUntil {!isNil {BIS_ACM getVariable "initDone"}};
		waitUntil {BIS_ACM getVariable "initDone"};
		[] spawn 
		{
			waitUntil {!(isnil "BIS_fnc_init")};
			[0.0, BIS_ACM] call BIS_ACM_setIntensityFunc;                 //Sets the intensity of the ACM, in other words, determines how active it will be. Starts at 0 ends at 1.0, its been known to fail using 0.7 and 0.8
			[BIS_ACM, 10000, 20000] call BIS_ACM_setSpawnDistanceFunc;      // This is the radius on where the units will spawn around the unit the module is sync'd to, 400m being the minimal distance and 700m being the maximum. Minimum is 1 I believe.

			[["RU"], BIS_ACM] call BIS_ACM_setFactionsFunc;     // This tells the ACM which faction of units it will spawn. In this case it will spawn Takistani Insurgents
			[0.1, 0.3, BIS_ACM] call BIS_ACM_setSkillFunc;                // This determines what the skill rating for the spawned units will be
			[0.8, 0.9, BIS_ACM] call BIS_ACM_setAmmoFunc;               // This sets their amount of ammo they spawn with
			["ground_patrol", 0, BIS_ACM] call BIS_ACM_setTypeChanceFunc; //If you want ground patrols then leave it as a 1, if you don't put a 0. They will use random paths
			["air_patrol", 0, BIS_ACM] call BIS_ACM_setTypeChanceFunc;    // Same thing for air patrols
			[BIS_ACM, ["RU_InfSquad"]] call BIS_ACM_addGroupClassesFunc;   // This determines which exact units will spawn from the group **Citation needed**
 
		};
*/
ambguy setdamage 1;
ambguy_2 setdamage 1;
sleep 10;
deletevehicle ambguy;
deletevehicle ambguy_2;



};

