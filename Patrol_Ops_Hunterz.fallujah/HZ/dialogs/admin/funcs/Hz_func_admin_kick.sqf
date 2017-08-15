if(Hz_admin_selected_UID == "0") exitwith {hint "Error\nNo player selected!";};

kick = Hz_admin_selected_UID; 
publicvariable "kick"; 

closeDialog 0; 

hint "Player kicked!";
