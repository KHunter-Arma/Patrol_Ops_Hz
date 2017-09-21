// Written by EightySix

private["_timer"];

	_timer = 10;

	while {_timer > 0} do {

		122 cuttext [format["%1 seconds",_timer], "PLAIN Down"];

		_timer = _timer - 1;

		sleep 1;
	};

	122 cuttext ["", "PLAIN Down"];