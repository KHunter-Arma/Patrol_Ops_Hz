// Written by BON_IF
// Adpated by EightySix

bon_backpack_caller = player;
createDialog "mps_backpack_dialog";
WaitUntil{not dialog};
bon_backpack_caller = nil;