if(isServer) exitwith {};

waituntil {sleep 0.1; !isnull player};
waituntil {sleep 0.1; alive player};

/*

if (!isnil "CMSEH") then {
    
    player removeeventhandler ["HandleDamage", CMSEH];
    hint "A B.A.D. PMC certified medic is now on duty. ACE wounds disabled. CMS is now active!";
    //ace_sys_wounds_enabled = false;
    player setvariable ["ace_w_allow_dam",0];
    CMSEH = nil;
    //cms_enableCombatMedicalSystem = true;
    
    };

    _uid = getPlayerUID player;
    
if (((_uid == "76561198012587329") || (_uid == "76561198080472574")) && ((typeof player == "US_Soldier_Medic_EP1") || (typeof player == "BAF_Soldier_Medic_MTP") || (typeof player == "Mercenary_Default28") || (typeof player == "Soldier_Medic_PMC") || (typeof player == "BAF_Soldier_Medic_W") || (typeof player == "BAF_Soldier_Medic_DDPM"))) then {
    
        // Player is a certified medic
            player setvariable["cms_medicClass",true,true];
    
};

*/

if (!(player getvariable ["cms_enable",false])) then {
    
    hint "A B.A.D. PMC certified medic is now on duty. ACE wounds disabled. CMS is now active!";
       
    player call ace_sys_wounds_fnc_RemovePain;
    player call  ace_sys_wounds_fnc_RemoveBleed;
    player call  ace_sys_wounds_fnc_RemoveBleed;
    player call  ace_sys_wounds_fnc_RemoveBleed;
    player call  ace_sys_wounds_fnc_RemoveBleed;
    player call  ace_sys_wounds_fnc_RemoveBleed;
    player setvariable ["ace_w_allow_dam",0];
    player removealleventhandlers "HandleDamage";
    player setvariable ["cms_enable",true,true];
    
    };

/*
_uid = getPlayerUID player;
    
if (((_uid == "76561198012587329") || (_uid == "76561198080472574")) && ((typeof player == "US_Soldier_Medic_EP1") || (typeof player == "BAF_Soldier_Medic_MTP") || (typeof player == "Mercenary_Default28") || (typeof player == "Soldier_Medic_PMC") || (typeof player == "BAF_Soldier_Medic_W") || (typeof player == "BAF_Soldier_Medic_DDPM"))) then {
    
        // Player is a certified medic
        player setvariable["cms_medicClass",true,true];
    
};

*/