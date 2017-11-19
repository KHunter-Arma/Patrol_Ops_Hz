

private ["_array"];
_array = _this;
_permutarray = [];

for "_i" from 1 to (count _array) do {
	_j = (count _array - 1) min (round random (count _array));
	_element = _array select _j;
	_permutarray = _permutarray + [_element];
	_array = _array - [_element];
};

_permutarray