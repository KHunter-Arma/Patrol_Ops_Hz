quake = {

		for "_i" from 0 to 140 do {
			_vx = vectorup _this select 0;
			_vy = vectorup _this select 1;
			_vz = vectorup _this select 2;
			_coef = 0.03 - (0.0001 * _i);
			_this setvectorup [
				_vx+(-_coef+random (2*_coef)),
				_vy+(-_coef+random (2*_coef)),
				_vz+(-_coef+random (2*_coef))
			];
			sleep (0.01 + random 0.01);
		};

};


wind = {
	while {windv} do {
	setwind [0.201112,0.204166,true];
		_ran = ceil random 2;
		playsound format ["wind_%1",_ran];
		_pos = position player;

		//--- Dust
			setwind [0.201112*2,0.204166*2,false];
		_velocity = [random 10,random 10,-1];
		_color = [1.0, 0.9, 0.8];
		_alpha = 0.02 + random 0.02;
		_ps = "#particlesource" createVehicleLocal _pos;  
		_ps setParticleParams [["\Ca\Data\ParticleEffects\Universal\universal.p3d", 16, 12, 8], "", "Billboard", 1, 3, [0, 0, -6], _velocity, 1, 1.275, 1, 0, [9], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _pos];
		_ps setParticleRandom [3, [30, 30, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
		_ps setParticleCircle [0.1, [0, 0, 0]];
		_ps setDropInterval 0.01;

		sleep (random 1);
		_delay = 1 + random 5;
		sleep _delay;
		deletevehicle _ps;
	};
};


envi = {

if (viewdistance < 3500) then {setviewdistance 5000};
"colorCorrections" ppEffectAdjust [2, 30, 0, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]];
"colorCorrections" ppEffectCommit 0;
//"colorCorrections" ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]];
"colorCorrections" ppEffectAdjust [1, 0.8, -0.001, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]];  
"colorCorrections" ppEffectCommit 3;
"colorCorrections" ppEffectEnable true;
"filmGrain" ppEffectEnable true; 
"filmGrain" ppEffectAdjust [0.02, 1, 1, 0.1, 1, false];
"filmGrain" ppEffectCommit 5;
};

ash = {
	_pos = position player;
	_parray = [
	/* 00 */		["\Ca\Data\ParticleEffects\Universal\Universal", 16, 12, 8, 1],//"\Ca\Data\cl_water",
	/* 01 */		"",
	/* 02 */		"Billboard",
	/* 03 */		1,
	/* 04 */		4,
	/* 05 */		[0,0,0],
	/* 06 */		[0,0,0],
	/* 07 */		1,
	/* 08 */		0.000001,
	/* 09 */		0,
	/* 10 */		1.4,
	/* 11 */		[0.05,0.05],
	/* 12 */		[[0.1,0.1,0.1,1]],
	/* 13 */		[0,1],
	/* 14 */		0.2,
	/* 15 */		1.2,
	/* 16 */		"",
	/* 17 */		"",
	/* 18 */		vehicle player
	];
	snow = "#particlesource" createVehicleLocal _pos;  
	snow setParticleParams _parray;
	snow setParticleRandom [0, [10, 10, 7], [0, 0, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
	snow setParticleCircle [0.0, [0, 0, 0]];
	snow setDropInterval 0.04;
        snow attachto [player, [0,5,3]];

};