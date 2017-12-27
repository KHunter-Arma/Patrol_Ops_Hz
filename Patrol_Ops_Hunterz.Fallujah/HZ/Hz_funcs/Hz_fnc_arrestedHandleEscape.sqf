//if not released, kick from server
//if released, also kick to force synchronisation

[] spawn {

  while {true} do {

    sleep 2;
    
    if (((getposatl player) distance Hz_pops_arrestPosition) > 50) then {
    
      endmission "LOSER";
    
    };

  };

};
