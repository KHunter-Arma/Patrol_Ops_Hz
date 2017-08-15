#define LARGE_CHOPPERS []
#define FIGHTER_JETS []
#define LARGE_PLANES []

private ["_type","_ret"];

_type = toupper _this;

_ret = switch (true) do {

case (_this iskindof "BMP2_BASE") :  {460};
case (_this iskindof "LAV25_Base") : {270};
case (_this iskindof "M2A2_Base") : {700};
case (_this iskindof "UAZ_Base") : {80};
case (_this iskindof "pook_HEMTT") : {600};
case (_this iskindof "HMMWV_Base") : {100};
case (_this iskindof "M113_Base") : {360};
case (_this iskindof "Stryker_Base_EP1") : {200};
case (_this iskindof "M1A1") : {1900};
case (_this iskindof "Wheeled_APC") : {300};
case (_this iskindof "Tracked_APC") : {500};
case (_this iskindof "Tank") : {1000};
case (_this iskindof "Truck") : {300}; //accurate for both Urals and MTVRs
case (_this iskindof "Car") : {50};
case (_this iskindof "pook_H13_base") : {240};
case (_this iskindof "usec_bell206") : {1300};
case (_type in LARGE_CHOPPERS) : {4000};
case (_this iskindof "GNT_C185") : {220};
case (_type in FIGHTER_JETS) : {0};
case (_type in LARGE_PLANES) : {40000};
case (_this iskindof "Plane") : {10000};
case (_this iskindof "Helicopter") : {1500};
case (_this iskindof "pook_SOCR_M2") : {681};
case (_this iskindof "RHIB") : {818};
case (_this iskindof "Boat") : {20};

default {0};

};

_ret