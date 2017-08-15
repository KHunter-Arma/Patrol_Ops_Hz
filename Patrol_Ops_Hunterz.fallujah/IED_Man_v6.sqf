// [man, Max Buildings to try, Maximum Objects to try, IED TYPE, Move Type, Max Random Time to deploy IED,bin,nogun,"Run"] execvm 
//
//IED TYPE Can Be: GrndS , GrndL , Garbs , GarbL , Rnd
//
//Move Type Can Be: Sw , Mo
//
//

//private ["_IEDType","_RandomIED","chosenbuilding"];

_man = _this select 0;
_MBA = _this select 1;
_MOA = _this select 2;
_IEDType = _this select 3;
_MoveType = _this select 4;
_MRT = _this select 5;
_Binoc = _this select 6;
_Gun = _this select 7;
_Relocate = _this select 8;


//_RandomIED = floor (random 4);                      ---- for Chernarus use only garbage IEDs
_RandomIED = floor (random 2);
_IEDDetected = 0;
_HI = 0;
_OMTC = 15;
_DT = 8; //+++++++++++++++++++++++---Detection time given at each stance at each location---+++++++++++++++++++++++++++++++++++++++++++++++++
_KV = 0; //+++++++++++++++++++++++---Knowledge Value Required for IED Target---+++++++++++++++++++++++++++++++++++++++++++++++++
_OSS = 0; //+++++++++++++++++++++++++++++---Object Search Started, used as a switch to look for random locations after object locations---+++++++++++++++++++++++++++++++++++
_NFBA = 30; //++++++++++++++++++++++++++++++++---Number of failed building attempts, where there are no buildings of type in range, used to stop looking for buildings---++++++++++++++++++++++++++++++++
_Stance = 0;

Removeallitems _man;
_man setcaptive true;
_man setcombatmode "Blue";

Sleep (floor (random _MRT)); //+++++++++++++++++++++++++++++++---Generate Randon Time to Deploy IED---++++++++++++++++++++++++++++++++++++++++++++++++++++

//###########################################---Set Up man, Choose IED Type, Add to man, make him deploy it & Assign his position to _IEDPos---###############################################################

private ["_IED"];
Switch ( _IEDType ) do {
	Case "GrndS": {
		_IED = "BAF_IED_v3";
	};
	Case "GrndL": {
		_IED = "BAF_IED_v4";
	};
	Case "GarbS": {
		_IED = "BAF_IED_v1";
	};
	Case "GarbL": {
		_IED = "BAF_IED_v2";
	};
	Case "Rnd": {
		If ( _RandomIED == 0) then {
				_IED = "BAF_IED_v1";
		};
		If ( _RandomIED == 1) then {
				_IED = "BAF_IED_v2";
		};
		//If ( _RandomIED == 2) then {
		//		_IED = "BAF_IED_v3";
		//};
		//If ( _RandomIED == 3) then {
		//		_IED = "BAF_IED_v4";
		//};
	};
};


_man addweapon "binocular";
_IEDMuzzle = format ["%1_muzzle",_IED];
_man addMagazine format ["%1",_IED];
_man playmove "amovpercmstpsraswrfldnon_gear";
_man Fire format ["%1",_IEDMuzzle];
_iedpos = (getpos _man);
//_marker = createMarker ["iedpos", _iedpos]; 
_man setunitpos "up";
_ied addaction ["Disable IED", "disable_ied.sqf"];
sleep 2;

//######################################################---Delete the mans waypoints---#########################################################################################################################

[_man] join GrpNull;
_FS = createVehicle ["CIV_RU", [000,999,0], [], 0, ""];
_FakeGrp = group _FS;
[_man] joinsilent _FakeGrp;
[_man] join GrpNull;
deletevehicle _FS;

//#############################################---Set the Targets location & hide it---############################################################################################################################

_IEDTarget = createVehicle ["CIV_RU", [000,999,0], [], 0, ""];
Removeallweapons _IEDTarget;
_IEDTarget setdammage 1;
Sleep 4;
_IEDTarget hideobject True;
_IEDTarget setpos _IEDPos;
_man setcombatmode "blue";

//#############################################---FIND A HIDING LOCATION---#######################################################################################################################################

While { _IEDDetected == 0 && _OMTC >= 0  } do {

	_HI = (Floor(random 29)); //++++++++++++++++++++++++++++++++++++++++++---Pick random House---+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	_BT = "land_house_C_10_EP1";

	If (_HI == 0) then { _BT = "land_house_C_10_EP1";};
	If (_HI == 1) then { _BT = "land_house_C_3_EP1";};
	If (_HI == 2) then { _BT = "land_house_C_4_EP1";};
	If (_HI == 3) then { _BT = "land_house_C_11_EP1";};
	If (_HI == 4) then { _BT = "land_house_C_2_EP1";};
	If (_HI == 5) then { _BT = "land_house_C_12_EP1";};
	If (_HI == 6) then { _BT = "land_house_C_9_EP1";};
	If (_HI == 7) then { _BT = "land_house_C_1_EP1";};
	If (_HI == 8) then { _BT = "land_house_C_1_v2_EP1";};
	If (_HI == 9) then { _BT = "land_house_C_5_EP1";};
	If (_HI == 10) then { _BT = "land_house_C_5_v1_EP1";};
	If (_HI == 11) then { _BT = "land_house_C_5_v2_EP1";};
	If (_HI == 12) then { _BT = "land_house_C_5_v3_EP1";};
	If (_HI == 13) then { _BT = "land_house_L_1_EP1";};
	If (_HI == 14) then { _BT = "land_house_L_3_EP1";};
	If (_HI == 15) then { _BT = "land_house_L_4_EP1";};
	If (_HI == 16) then { _BT = "land_house_L_6_EP1";};
	If (_HI == 17) then { _BT = "land_house_L_7_EP1";};
	If (_HI == 18) then { _BT = "land_house_L_8_EP1";};
	If (_HI == 19) then { _BT = "land_house_L_9_EP1";};
	If (_HI == 20) then { _BT = "land_house_K_1_EP1";};
	If (_HI == 21) then { _BT = "land_house_K_3_EP1";};
	If (_HI == 22) then { _BT = "land_house_K_5_EP1";};
	If (_HI == 23) then { _BT = "land_house_K_6_EP1";};
	If (_HI == 24) then { _BT = "land_house_K_7_EP1";};
	If (_HI == 25) then { _BT = "land_house_K_8_EP1";};
	If (_HI == 26) then { _BT = "land_A_Minaret_Porto_EP1";};
	If (_HI == 27) then { _BT = "land_A_Mosque_Big_Minaret_1_EP1";};
	If (_HI == 28) then { _BT = "land_A_Mosque_Big_Minaret_2_EP1";};
	If (_HI == 29) then { _BT = "land_A_Minaret_EP1";};

	//-------Find buildings put in _BuildingArray then only pick the ones between 30m & 120m & put those in _RangeBuildingArray in order of distance from _man--------------------------------------------------

	_BuildingArray = nearestobjects [_man, [_BT],120];

	If ( count _BuildingArray == 0 ) then { _NFBA = _NFBA - 1; };

	_RangeBuildingArray = [];

	{
	If ( _IEDPos distance _x >= 25 && _IEDPos distance _x <= 120 ) then {
		_RangeBuildingArray = _RangeBuildingArray + [_x];
	};
	}
	Foreach _BuildingArray;

	//--------IF We have a Building Then Continue, if not then bypass this section Assuming we've tried all buildings we want to try)---------------------------------------------------------------------------


	IF ( Count _RangebuildingArray >= 1 && _MBA != 0 ) then {


		//-------Randomly select 1 of the buildings, remove it from the array (_RangebuildingArray) & call it _ChosenBuilding----------------------------------------------------------------------------------------

		_RBC = count _RangeBuildingArray;

		_ChosenBuilding = _RangeBuildingArray select (Floor(random _RBC));

		_RangeBuildingArray = _RangeBuildingArray - [_ChosenBuilding];


		//-------Get all Positions in Chosen building & assign them to _BPA------------------------------------------------------------------------------------------------------------------------------------------

		_BPA = [];
		_bpan = 0;
		_bp = 0;
		_buildpos  = _ChosenBuilding buildingpos _bp;

			while {format ["%1", _buildpos] != "[0,0,0]"} do {
				_BPA set [_bpan, _buildpos];
				_bpan = _bpan +1;
				_bp = _bp +1;
				_buildpos = _ChosenBuilding buildingpos _bp;
			};
		_bp = 0;
		_bpan =0;

		//-----------Find out what building we're dealing with & put required House positions in _FinalBuildingPositionsArray & Clear _BPA as were done with it in this run-------------------------------------------

		_FinalBuildingPositionsArray = [];

		If ( _ChosenBuilding iskindof "land_house_C_10_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 9,_BPA select 14,_BPA select 15,_BPA select 16,_BPA select 17,_BPA select 18,_BPA select 19,_BPA select 20 ];
		};

		If ( _ChosenBuilding iskindof "land_house_C_3_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 3 , _BPA select 4,_BPA select 8,_BPA select 11,_BPA select 15,_BPA select 16,_BPA select 19,_BPA select 20,_BPA select 22,_BPA select 24,_BPA select 26 ];
		};
	
		If ( _ChosenBuilding iskindof "land_house_C_4_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 6 , _BPA select 10,_BPA select 11,_BPA select 14,_BPA select 5 ];
		};

		If ( _ChosenBuilding iskindof "land_house_C_11_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 2 , _BPA select 4,_BPA select 5 ];
		};

		If ( _ChosenBuilding iskindof "land_house_C_2_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 , _BPA select 2,_BPA select 9 ];
		};

		If ( _ChosenBuilding iskindof "land_house_C_12_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 , _BPA select 3,_BPA select 5,_BPA select 7,_BPA select 8,_BPA select 10,_BPA select 13,_BPA select 14 ];
		};

		If ( _ChosenBuilding iskindof "land_house_C_9_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 , _BPA select 2,_BPA select 3,_BPA select 6,_BPA select 7,_BPA select 8,_BPA select 9 ];
		};

		If ( _ChosenBuilding iskindof "land_house_C_1_EP1" or _ChosenBuilding iskindof "land_house_C_1_v2_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 , _BPA select 2 ];
		};

		If ( _ChosenBuilding iskindof "land_house_C_5_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 , _BPA select 1 , _BPA select 2 , _BPA select 3 , _BPA select 4 , _BPA select 6 , _BPA select 7 ];
		};

		If ( _ChosenBuilding iskindof "land_house_C_5_v1_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 , _BPA select 1 , _BPA select 3 , _BPA select 5 ];
		};

		If ( _ChosenBuilding iskindof "land_house_C_5_v2_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 , _BPA select 3 , _BPA select 6 , _BPA select 7 ];
		};

		If ( _ChosenBuilding iskindof "land_house_C_5_v3_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 1 , _BPA select 3 , _BPA select 5 ];
		};

		If ( _ChosenBuilding iskindof "land_house_L_1_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 ];
		};

		If ( _ChosenBuilding iskindof "land_house_L_3_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 3 , _BPA select 4 ];
		};

		If ( _ChosenBuilding iskindof "land_house_L_4_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 , _BPA select 1 , _BPA select 2 , _BPA select 3 , _BPA select 4 , _BPA select 5 ];
		};

		If ( _ChosenBuilding iskindof "land_house_L_6_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 1 , _BPA select 2 ];
		};

		If ( _ChosenBuilding iskindof "land_house_L_7_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 , _BPA select 6 ];
		};

		If ( _ChosenBuilding iskindof "land_house_L_8_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 5 , _BPA select 9,_BPA select 11,_BPA select 14,_BPA select 17 ];
		};

		If ( _ChosenBuilding iskindof "land_house_L_9_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 1 , _BPA select 2,_BPA select 3 ];
		};

		If ( _ChosenBuilding iskindof "land_house_K_1_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 , _BPA select 1 ];
		};

		If ( _ChosenBuilding iskindof "land_house_K_3_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 , _BPA select 4 , _BPA select 7 , _BPA select 8 ];
		};

		If ( _ChosenBuilding iskindof "land_house_K_5_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 , _BPA select 3 ];
		};

		If ( _ChosenBuilding iskindof "land_house_K_6_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 1 , _BPA select 4 , _BPA select 8 , _BPA select 11 ];
		};

		If ( _ChosenBuilding iskindof "land_house_K_7_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 , _BPA select 3 , _BPA select 4 , _BPA select 7 , _BPA select 8 , _BPA select 9 , _BPA select 10 , _BPA select 13 , _BPA select 14 ];
		};

		If ( _ChosenBuilding iskindof "land_house_K_8_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 0 , _BPA select 2 , _BPA select 3 , _BPA select 5 , _BPA select 6 , _BPA select 8 , _BPA select 9 , _BPA select 10 , _BPA select 12 , _BPA select 13 ];
		};

		If ( _ChosenBuilding iskindof "land_A_Minaret_Porto_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 2 , _BPA select 3 , _BPA select 4 , _BPA select 5 , _BPA select 6 , _BPA select 7 , _BPA select 8 , _BPA select 9 , _BPA select 10 , _BPA select 11 , _BPA select 12 , _BPA select 13 , _BPA select 14 ];
		};

		If ( _ChosenBuilding iskindof "land_A_Mosque_Big_Minaret_1_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 1 ];
		};

		If ( _ChosenBuilding iskindof "land_A_Mosque_Big_Minaret_2_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 2 , _BPA select 3 , _BPA select 4 ];
		};

		If ( _ChosenBuilding iskindof "land_A_Minaret_EP1" ) then {
			_FinalBuildingPositionsArray = [ _BPA select 5 ];
		};

		_BPA = [];

		//--------------Count number of positions in _FinalBuildingPositionsArray , Assign a random house position to _MoveTo & remove this position from the _FinalBuildingPositionsArray-----------------------------

		_BMNC = count _FinalBuildingPositionsArray;
		_MoveNo = 1;
		_BMN = 0;

			While { _MoveNo <= _BMNC && _IEDDetected == 0 } do {

				_MoveTo = _FinalBuildingPositionsArray select _BMN;

					If ( _MoveType == "Sw" ) then {
						_man setpos _MoveTo;
					};

					If ( _MoveType == "Mo" ) then {
						_man domove _MoveTo;
						_man setbehaviour "Safe";
					};

						Sleep 2;
						Waituntil { unitready _man or _IEDDetected == 1 };



							If ( _ChosenBuilding iskindof "land_house_C_10_EP1" ) then {
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};



							If ( _ChosenBuilding iskindof "land_house_C_3_EP1" ) then {
								If ( _BMN == 0 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "down";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "down";
										_IEDDetected = 1;
										_Stance = 1;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";

								};
								If ( _BMN == 0 or _BMN == 1 or _BMN == 4 or _BMN == 5 or _BMN == 6 or _BMN == 7 or _BMN == 8 or _BMN == 9 or _BMN == 10 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};



							If ( _ChosenBuilding iskindof "land_house_C_4_EP1" ) then {
								If ( _BMN == 2 or _BMN == 3 or _BMN == 4 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};



							If ( _ChosenBuilding iskindof "land_house_C_11_EP1" ) then {
								If ( _BMN == 0 or _BMN == 1 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};



							If ( _ChosenBuilding iskindof "land_house_C_2_EP1" ) then {
								If ( _BMN == 0 or _BMN == 1 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};



							If ( _ChosenBuilding iskindof "land_house_C_12_EP1" ) then {
								If ( _BMN == 6 or _BMN == 7 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "down";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "down";
										_IEDDetected = 1;
										_Stance = 1;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								If ( _BMN == 4 or _BMN == 5 or _BMN == 6 or _BMN == 7 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									//_man setdir _CDTI;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};



							If ( _ChosenBuilding iskindof "land_house_C_9_EP1" ) then {
								If ( _BMN == 3 or _BMN == 4 or _BMN == 5 or _BMN == 6 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									//_man setdir _CDTI;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_C_1_EP1" or _ChosenBuilding iskindof "land_house_C_1_v2_EP1" ) then {
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};


							If ( _ChosenBuilding iskindof "land_house_C_5_EP1" ) then {
								If ( _BMN == 0 or _BMN == 1 or _BMN == 2 or _BMN == 4 or _BMN == 5 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_C_5_v1_EP1" ) then {
								If ( _BMN == 0 or _BMN == 1 or _BMN == 3 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_C_5_v2_EP1" ) then {
								If ( _BMN == 1 or _BMN == 2 or _BMN == 3 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_C_5_v3_EP1" ) then {
								If ( _BMN == 0 or _BMN == 2 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_L_1_EP1" ) then {
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_L_3_EP1" ) then {
								If ( _BMN == 0 or _BMN == 1 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_L_4_EP1" ) then {
								If ( _BMN == 2 or _BMN == 3 or _BMN == 5 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "down";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "down";
										_IEDDetected = 1;
										_Stance = 1;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								If ( _BMN == 2 or _BMN == 3 or _BMN == 4 or _BMN == 5 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_L_6_EP1" ) then {
								If ( _BMN == 0 or _BMN == 1 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "down";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "down";
										_IEDDetected = 1;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								If ( _BMN == 0 or _BMN == 1 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_L_7_EP1" ) then {
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_L_8_EP1" ) then {
								If ( _BMN == 3 or _BMN == 4 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_L_9_EP1" ) then {
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_K_1_EP1" ) then {
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_K_3_EP1" ) then {
								If ( _BMN == 2 or _BMN == 3 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_K_5_EP1" or _ChosenBuilding iskindof "land_house_K_6_EP1" ) then {
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_K_7_EP1" ) then {
								If ( _BMN == 7 or _BMN == 8 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "down";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "down";
										_IEDDetected = 1;
										_Stance = 1;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								If ( _BMN == 3 or _BMN == 4 or _BMN == 5 or _BMN == 6 or _BMN == 7 or _BMN == 8 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_house_K_8_EP1" ) then {
								If ( _BMN == 3 or _BMN == 4 or _BMN == 5 or _BMN == 6 or _BMN == 7 or _BMN == 8 or _BMN == 9 ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
								};
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_A_Minaret_Porto_EP1" ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
									Sleep 1;
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};

							If ( _ChosenBuilding iskindof "land_A_Mosque_Big_Minaret_1_EP1" or _ChosenBuilding iskindof "land_A_Mosque_Big_Minaret_2_EP1" ) then {
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};


							If ( _ChosenBuilding iskindof "land_A_Minaret_EP1" ) then {
									_man setbehaviour "Aware";
									_man setunitpos "middle";
									Sleep 4;
									_IEDTarget hideobject False;
									_man dowatch _IEDTarget;
									Sleep _DT;
									If ( _man knowsabout _IEDTarget > _KV ) then {
										_man disableai "anim";
										_man setunitpos "middle";
										_IEDDetected = 1;
										_Stance = 2;
									};
									_IEDTarget hideobject True;
									_man setbehaviour "Safe";
									Sleep 1;
								_man setbehaviour "Aware";
								_man setunitpos "up";
								Sleep 3;
								_IEDTarget hideobject False;
								_man dowatch _IEDTarget;
								Sleep _DT;
								If ( _man knowsabout _IEDTarget > _KV ) then {
									_man disableai "anim";
									_IEDDetected = 1;
								};
								_IEDTarget hideobject True;
								//_man setbehaviour "Safe";
							};


			Sleep 2;
			_MoveNo = _MoveNo +1;
			_BMN = _BMN +1;
			};
	_MBA = _MBA -1;

	If ( _NFBA == 0 ) then { _MBA = 0; }; // Checks Number of failed building attempts & sets _MBA to 0 so houses stopped being checked

	};

	//-----------------------------No Building Options, so find an Object to hide by-----------------------------------------------------------------------------

	If ( _MBA == 0 or _NFBA == 0 && _MOA != 0 ) then {
		//-------Find Objects put in _ObjectArray then only pick the ones between 30m & 120m & put those in _RangeObjectArray in order of distance from _man--------------------------------------------------

		_ObjectArray = nearestobjects [_IEDPos, [],120];
		_OSS = 1;
		_RangeObjectArray = [];

		_BuildingArrayAll = [];

		_HIR = count nearestobjects [_IEDPos, ["house"],50]; //++++++++++++---Houses in range (50m) used to see if he's in a town---++++++++++++++++++++++++++++++++++++++++++++++++

		_MinDist = 40;
		_MaxDist = 120;

		If ( _HIR <= 2 ) then { 
			_MinDist = 40;
			_MaxDist = 120;
		};

		If ( _HIR >= 10 ) then { 
			_MinDist = 25;
			_MaxDist = 50;
		};


		{
		If ( _IEDPos distance _x >= _MinDist && _IEDPos distance _x <= _MaxDist ) then {
		_RangeObjectArray = _RangeObjectArray + [_x];
		};
		}
		Foreach _ObjectArray;

		IF ( Count _RangeObjectArray >= 1 ) then {

			//-------Randomly select 1 of the Objects, remove it from the array (_RangeObjectArray) & call it _ChosenObject----------------------------------------------------------------------------------------

			While { _MOA != 0 && _IEDDetected != 1 } do {

				_ROC = count _RangeObjectArray;

				_ChosenObject = _RangeObjectArray select (Floor(random _ROC));

				_RangeObjectArray = _RangeObjectArray - [_ChosenObject];

				while { _ChosenObject iskindof "house" or isonroad getpos _Chosenobject } do {
					_ROC = count _RangeObjectArray;

					_ChosenObject = _RangeObjectArray select (Floor(random _ROC));

					_RangeObjectArray = _RangeObjectArray - [_ChosenObject];
				};


				If ( _MoveType == "Sw" ) then {
					_man setposATL [(getpos _ChosenObject select 0),(getpos _ChosenObject select 1),0];
				};

				If ( _MoveType == "Mo" ) then {
					_man domove getpos _ChosenObject;
					_man setbehaviour "Safe";
				};

						Waituntil { unitready _man or _IEDDetected == 1 };
						"IED_Man" setMarkerPos getpos _man;
						_man setbehaviour "Aware";
						_man setunitpos "down";
						Sleep 4;
						_IEDTarget hideobject False;
						_man dowatch _IEDTarget;
						Sleep _DT;
						If ( _man knowsabout _IEDTarget > _KV ) then {
							_man disableai "anim";
							_man setunitpos "down";
							_IEDDetected = 1;
							_Stance = 1;
						};
						_IEDTarget hideobject True;
						_man setunitpos "middle";
						Sleep 4;
						_IEDTarget hideobject False;
						_man dowatch _IEDTarget;
						Sleep _DT;
						If ( _man knowsabout _IEDTarget > _KV ) then {
							_man disableai "anim";
							_man setunitpos "middle";
							_IEDDetected = 1;
							_Stance = 2;
						};
						_IEDTarget hideobject True;
						_man setunitpos "up";
						Sleep 4;
						_IEDTarget hideobject False;
						_man dowatch _IEDTarget;
						Sleep _DT;
						If ( _man knowsabout _IEDTarget > _KV ) then {
							_man disableai "anim";
							_IEDDetected = 1;
						};
						_IEDTarget hideobject True;
						//_man setbehaviour "Safe";

				_MOA = _MOA -1;
			};
		};
	};

	//----------------------------------No Building or Object options, so just find a random position within 30-100m----------------------------------------------------------------
	If ( _OSS == 1 ) then {				

			_HIR = count nearestobjects [_IEDPos, ["house"],50]; //++++++++++++---Houses in range (50m) used to see if he's in a town---++++++++++++++++++++++++++++++++++++++++++++++++

			If ( _HIR <= 2 ) then { 
				_MinDist = 60;
				_MaxDist = 120;
			};

			If ( _HIR >= 10 ) then { 
				_MinDist = 25;
				_MaxDist = 50;
			};

			While { _OMTC > 0 && _IEDDetected != 1} do {
					_Moveto = [( _IEDPos select 0) + ( -50 + (random(100))), ( _IEDPos select 1) + ( -50 + (random(100)))];

				while { _Moveto distance _IEDPos <= _MinDist && _Moveto distance _IEDPos >= _MaxDist && isonroad _Moveto } do {
					_Moveto = [( _IEDPos select 0) + ( -100 + (random(200))), ( _IEDPos select 1) + ( -100 + (random(200)))];
				};

				If ( _MoveType == "Sw" ) then {
					_man setpos _Moveto;
				};

				If ( _MoveType == "Mo" ) then {
					_man domove _MoveTo;
					_man setbehaviour "Safe";
				};

						Waituntil { unitready _man or _IEDDetected == 1 };
						"IED_Man" setMarkerPos getpos _man;
						_man setbehaviour "Aware";
						_man setunitpos "down";
						Sleep 4;
						_IEDTarget hideobject False;
						_man dowatch _IEDTarget;
						Sleep _DT;
						If ( _man knowsabout _IEDTarget > _KV ) then {
							_man disableai "anim";
							_man setunitpos "down";
							_IEDDetected = 1;
							_Stance = 1;
						};
						_IEDTarget hideobject True;
						_man setunitpos "middle";
						Sleep 4;
						_IEDTarget hideobject False;
						_man dowatch _IEDTarget;
						Sleep _DT;
						If ( _man knowsabout _IEDTarget > _KV ) then {
							_man disableai "anim";
							_man setunitpos "middle";
							_IEDDetected = 1;
							_Stance = 2;
						};
						_IEDTarget hideobject True;
						_man setunitpos "up";
						Sleep 4;
						_IEDTarget hideobject False;
						_man dowatch _IEDTarget;
						Sleep _DT;
						If ( _man knowsabout _IEDTarget > _KV ) then {
							_man disableai "anim";
							_IEDDetected = 1;
						};
						_IEDTarget hideobject True;

				_OMTC = _OMTC -1;

			};

	};

};

//#############################################---Create & Define Detonation & detection Triggers---##############################################################################################################

_IEDtriggerOuter = createTrigger["EmptyDetector", _iedpos];
_IEDtriggerOuter setTriggerActivation ["WEST", "PRESENT", true];
_IEDtriggerOuter setTriggerArea [30, 30, 0, false]; 
_IEDtriggerOuter setTriggerStatements ["this", "" ,""];

_IEDtriggerInner = createTrigger["EmptyDetector", _iedpos];
_IEDtriggerInner setTriggerActivation ["WEST", "PRESENT", true];
_IEDtriggerInner setTriggerArea [15, 15, 0, false]; 
_IEDtriggerInner setTriggerStatements ["this", "" ,""];

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

[_man] Spawn {

	WaitUntil { Player knowsabout (_this Select 0) >= 4 && CursorTarget == (_this Select 0) };
	Sleep (floor (random 5));
	(_this Select 0) setCaptive False;
	(_this Select 0) addrating -10000;
};

_man addweapon "ItemMap";

_man enableai "anim";
_man disableai "move";
deleteVehicle _IEDTarget;
Sleep 2;
_man setcombatmode "blue";
If ( _Stance == 1 ) then { _man setunitpos "down" ; };
If ( _Stance == 2 ) then { _man setunitpos "Middle" ; };
Sleep 2;
If ( _binoc == "bin" ) then { _man selectweapon "Binocular"; };


_IEDDeted = 0;

Waituntil {triggeractivated _IEDtriggerOuter};
		{
		While {_man knowsabout _x >=0.1 && _IEDDeted == 0 } do {
			Waituntil {triggeractivated _IEDtriggerinner};
			Sleep (floor (random 5));
			//_man action ["touchoff", _man];
                         "ARTY_R_227mm_HE" createVehicle _iedpos;
			_IEDDeted = 1;
                        deletevehicle _IED;
                        _man addmagazine "8Rnd_9x18_Makarov";
                        _man addweapon "Makarov";
                        _man addmagazine "8Rnd_9x18_Makarov";
                        _man addmagazine "8Rnd_9x18_Makarov";
                        _man addmagazine "8Rnd_9x18_Makarov";
                        _man addmagazine "8Rnd_9x18_Makarov";   
                        if ( _Gun == "noGun" ) then { Removeallweapons _man; }; 
                        };
		}
		Foreach list _IEDtriggerOuter;

Waituntil { _IEDDeted == 1 };
Sleep (floor (random 10));
_man addrating -10000;
_man setcaptive False;
_man enableai "move";
_man setunitpos "middle";
_man setcombatmode "Green";
_man setbehaviour "stealth";
_man dowatch objnull;


If ( _Relocate == "RUN" ) then {
        
        _ObjectArray2 = nearestobjects [_man, [],200];
	_RangeObjectArray2 = [];

	_MOM = 5;

	{
	If ( _man distance _x >= 80 && _man distance _x <= 200 ) then {
	_RangeObjectArray2 = _RangeObjectArray2 + [_x];
	};
	}
	Foreach _ObjectArray2;


	IF ( Count _RangeObjectArray2 >= 1 ) then {

		//-------Randomly select 1 of the Objects, remove it from the array (_RangeObjectArray) & call it _ChosenObject----------------------------------------------------------------------------------------

		While { _MOM > 0 } do {

			_ROC2 = count _RangeObjectArray2;

			_ChosenObject2 = _RangeObjectArray2 select (Floor(random _ROC2));

			_RangeObjectArray2 = _RangeObjectArray2 - [_ChosenObject2];

			_man domove getpos _chosenObject2;
				
			Sleep 3;

			Waituntil { unitready _man };
	
			Sleep (floor (random 60));

			_MOM = _MOM -1;
		};
	};
};