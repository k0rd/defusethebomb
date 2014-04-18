private ["_bomb", "_time"];
_bomb = _this select 0;
_time = _this select 1;

while {_time > 0 && !(DEFUSED) && (alive _bomb)} do {
	_time = _time - 1;  
	cutText [format["Bomb Detonation: \n %1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring],"PLAIN DOWN"];
	BombTimer=_time;
	publicVariable "BombTimer";
	
	if (_time < 1) then {

// we need to be able to make different explosions - the following is for the demo mission, requires expl1 expl2 and expl3 to be scripted explosive type	
expl1 setdamage 1;
expl2 setdamage 1;
expl3 setdamage 1;
//		_blast = createVehicle ["HelicopterExploBig", position _bomb, [], 0, "NONE"];
//		{
//			_x setDamage 1;
//		} forEach (position _bomb nearObjects 50);
		EXPL=true;
	};
	if (ARMED) then {
		_time = 5; 
		ARMED = false
	};
	
	sleep 1;
};
CODE=[];
publicVariable "CODE";
deleteVehicle _bomb;
deleteVehicle expl1;
deleteVehicle expl2;
deleteVehicle expl3;
sleep 1;
BombTimer="";
BOMBFINISHED=true;
