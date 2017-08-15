

if(Hz_admin_selected_UID == "0") then {
    
hint "Error\nNo player selected!";

} else {

ban = Hz_admin_selected_UID; 
publicvariable "ban"; 

closeDialog 0; 

hint "Player banned!";

};