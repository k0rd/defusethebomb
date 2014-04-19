private ["_bomb", "_time"];
_bomb = _this select 0;
_time = _this select 1;
CODE=[(floor(random 9)),(floor(random 9)),(floor(random 9)),(floor(random 9))];
publicVariable "CODE";
WIRE = ["BLUE", "WHITE", "YELLOW", "GREEN"] call bis_fnc_selectRandom;
publicVariable "WIRE";
DEFUSED = false;
ARMED = false;
BOMBFINISHED=false;
EXPL=false;
publicVariable "DEFUSED"; publicVariable "ARMED"; publicVariable "BOMBFINISHED"; publicVariable "EXPL";
while {_time > 0 && !(DEFUSED) && (alive _bomb)} do {
	_time = _time - 1;  
	cutText [format["Bomb Detonation: \n %1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring],"PLAIN DOWN"];
	BombTimer=_time;
	publicVariable "BombTimer";
// pulse these out for JIP
	publicVariable "CODE";
	publicVariable "WIRE";
		if (_time < 1) then {
		_boom=createVehicle["HelicopterExploBig", position _bomb, [], 0, "NONE"];
		EXPL=true;
		};
	if (ARMED) then {
		_time = 5; 
		CODE=["X"];
		WIRE=["X"];
		ARMED = false
	};	
	sleep 1;
};
CODE=[];WIRE=[];
publicVariable "CODE";publicVariable "WIRE";
deleteVehicle _bomb;
sleep 1;
BOMBFINISHED=true;
