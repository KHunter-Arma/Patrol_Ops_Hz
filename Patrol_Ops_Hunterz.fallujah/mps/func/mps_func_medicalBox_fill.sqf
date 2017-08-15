
_numSupplies = 50;
_refreshTime = 360; // refill every 5 minutes

while {true} do
{
	clearWeaponCargo _this;
	clearMagazineCargo _this;

	_this addMagazineCargo ["ACE_Bandage", _numSupplies];
	_this addMagazineCargo ["ACE_Bodybag", _numSupplies];
	_this addMagazineCargo ["ACE_Epinephrine", _numSupplies];
	_this addMagazineCargo ["ACE_IV", _numSupplies];
	_this addMagazineCargo ["ACE_LargeBandage", _numSupplies];
	_this addMagazineCargo ["ACE_Medkit", _numSupplies];
	_this addMagazineCargo ["ACE_Morphine", _numSupplies];
	_this addMagazineCargo ["ACE_Plasma", _numSupplies];
	_this addMagazineCargo ["ACE_Splint", _numSupplies];
	_this addMagazineCargo ["ACE_Tourniquet", _numSupplies];

	sleep _refreshTime;
};