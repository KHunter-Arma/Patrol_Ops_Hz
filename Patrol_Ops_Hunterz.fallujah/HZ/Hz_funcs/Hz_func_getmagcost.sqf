private ["_return","_magazine"];

_magazine = _this;
_magazine = toupper _magazine;

_return = switch (_magazine) do {
    
case ("30RND_556X45_STANAG") : {30};
case ("30RND_545X39_AK") : {30};
case ("30RND_556X45_STANAGSD") : {33};
case ("ACE_30RND_556X45_SB_STANAG") : {95};
case ("ACE_10RND_762X39_B_SKS") : {20};

case ("ACE_RDGM") : {30};
case ("SMOKESHELL") : {52};

case ("IGLA") : {140000};
case ("STINGER") : {183300};

case ("ACE_TOURNIQUET") : { 9 };
case ("ACE_MORPHINE") : { 1 };
case ("ACE_BANDAGE") : { 8 };
case ("ACE_EPINEPHRINE") : { 69 };
case ("ACE_LARGEBANDAGE") : { 11 };
case ("ACE_MEDKIT") : { 25 };        
            

default {
    
  _return = -1;
  _return;
        
};

};

_return;