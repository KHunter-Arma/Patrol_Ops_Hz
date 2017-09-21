// Written by BON_IF
// Adapted by EightySix

_objects = _this;

{
	_x addEventHandler ["HandleDamage", {
		_damage = _this select 2;
		_projectile = _this select 4;
		
		if(_projectile == "PipeBomb" || _projectile == "ACE_PipebombExplosion" || _projectile == "ACE_C4Explosion" || _projectile iskindof "Bo_FAB_250" || _projectile iskindof "Bo_GBU12_LGB" || _projectile iskindof "M_Hellfire_AT" || _projectile iskindof "M_Maverick_AT") then { 1 } else { 0 };
	}];

} foreach _objects;
