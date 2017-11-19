//class Params {
	class option00 { //MISSIONTIME	Mission: Operation Time
		title=$STR_DESC_OPT0;
		values[]={-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
		default=-1;
		texts[]={"Real time","0030H","0130H","0230H","0330H","0430H","0530H","0630H","0730H","0830H","0930H","1030H","1130H","1230H","1330H","1430H","1530H","1630H","1730H","1830H","1930H","2030H","2130H","2230H","2330H"};
	};
	class option01 { //MISSIONTYPE	Mission: Operation Type
		title=$STR_DESC_OPT1;
		values[]={0,1,2,3,4,5,99};
		default=99;
		texts[]={"Target Capture","Town Capture","Task Force Ops","Search and Rescue","General Operations","Hard Operations","All Operations"};
	};
	class option02 { //MISSIONCOUNT	Number of Operations
		title=$STR_DESC_OPT2;
		values[]={1,3,5,7,9,15,20,30,50,999};
		default=999;
		texts[]={"1","3","5","7","9","15","20","30","50","A LOT"};
	};
	class option03 { //MISSIONDIFF	Mission: Enemy Difficulty
		title=$STR_DESC_OPT3;
		values[]={4};
		default=4;
		texts[]={"Hunter'z: Managed by developer"};
	};
	class option04 { //HALOLIMITS	Mission: Halo Limitation
		title=$STR_DESC_OPT4;
		values[]={7};
		default=7;
		texts[]={"Hunter'z: Disabled by Default"};
	};
	class option05 { //DEATHCOUNT	Mission: Casualty Limitation
		title=$STR_DESC_OPT5;
		values[]={100};
		default=100;
		texts[]={"Hunter'z: Financial Failure Conditions"};
	};
	class option06 { //AIRDROPSENBLE	Mission: Player Airdrop Ability
		title=$STR_DESC_OPT6;
		values[]={0};
		default=0;
		texts[]={"Hunter'z: Disabled by Default"};
	};
	class option07 { //LIFTCHPRENBLE	Mission: Lift Chopper
		title=$STR_DESC_OPT7;
		values[]={0};
		default=0;
		texts[]={"Hunter'z: Disabled by Default"};
	};
	class option08 { //RECRUITENBLE	Mission: Enable Recruitable AI
		title=$STR_DESC_OPT8;
		values[]={0,1};
		default=1;
		texts[]={"Disabled","Enabled"};
	};
	class option09 { //INJURYFACTOR	Player: Injury Tolerance
		title=$STR_DESC_OPT9;
		values[]={0};
		default=0;
		texts[]={"Hunter'z: Disabled by Default"};
	};
	class option10 { //RESTRICTCAM	Player: Restrict 3rd Person
		title=$STR_DESC_OPT10;
		values[]={2};
		default=2;
		texts[]={"Hunter'z: Disabled by Default"};
	};
	class option11 { //VEHCLASSLIMIT	Player: Limitation of Class
		title=$STR_DESC_OPT11;
		values[]={0};
		default=0;
		texts[]={"Hunter'z: Disabled by Default"};
	};
	class option13 { //RANKSYSENBLE	Player: Ranking System
		title=$STR_DESC_OPT13;
		values[]={0};
		default=0;
		texts[]={"Hunter'z: Disabled by Default"};
	};
	class option14 { // Gear Restriction by RANK
		title=$STR_DESC_OPT14;
		values[]={0};
		default=0;
		texts[]={"Hunter'z: Disabled by Default"};
	};
	class option15 { //AMBIECOUNT	Ambient: Roadside IED Potential
		title=$STR_DESC_OPT15;
		values[]={0,10,30,60};
		default=0;
		texts[]={"Off","Rare","Possible","Likely"};
	};
	class option16 { //AMBCIVILLIAN	Ambient: Civilians
		title=$STR_DESC_OPT16;
		values[]={1};
		default=1;
		texts[]={"Hunter'z: Enabled by Default"};
	};
	class option17 { //AMBINSURGENTS	Ambient: Patrols
		title=$STR_DESC_OPT17;
		values[]={0};
		default=0;
		texts[]={"Hunter'z: Enabled by Default"};
	};
	class option18 { //AMBAIRPARTOLS	Ambient: Air Patrols
		title=$STR_DESC_OPT18;
		values[]={0,1};
		default=1;
		texts[]={"Disabled","Enabled"};
	};
        
        class option19 { //recruitable AI numbers
		title=$STR_DESC_OPT19;
		values[]={1,2,3,4,5,6,7,8};
		default=5;
		texts[]={"Disabled","1","2","3","4","5","6","7"};
	};
        
        class option20 { //autoload
        title="Auto Load";
        values[]={0,1};
        default=1;
        texts[]={"Disabled","Enabled"};
	};
        
        class option21 {
        title="Auto Save Frequency";
        values[]={0,10800,21600,43200,86400};
        default=10800;
        texts[]={"Disabled","3 hours","6 hours","12 hours","24 hours"};
	};

//};