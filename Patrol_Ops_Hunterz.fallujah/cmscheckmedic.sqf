if(isServer) exitwith {};

//Hunter: I really have no idea why I made it this way. Could have just checked for medics with local code on JIP client...

//CMS check for B.A.D. PMC medics
_uid = getPlayerUID player;

if (isnil "MED_A") then {MED_A = false;};

if ((MED_A) && ((typeof player == "US_Soldier_Medic_EP1") || (typeof player == "BAF_Soldier_Medic_MTP") || (typeof player == "Mercenary_Default28") || (typeof player == "Soldier_Medic_PMC") || (typeof player == "BAF_Soldier_Medic_W") || (typeof player == "BAF_Soldier_Medic_DDPM"))) then {

    // There is a medic online
    
    mediconline = true;
    publicvariable "mediconline";
    
};