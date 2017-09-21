// Written by BON_IF
// Adapted by EightySix

private["_pos"];
_pos = _this;

	_return = switch (toupper(typename _pos)) do {
		case "OBJECT": { position _pos };
		case "LOCATION": { position _pos };
		case "STRING": { getMarkerPos _pos };
		case "ARRAY": { _pos };
		default { _pos };
	};

_return