_debug=0;

if (isserver) then {
CODEINPUT = [];
CODE=[(floor(random 9)),(floor(random 9)),(floor(random 9)),(floor(random 9))];
publicVariable "CODE";
WIRE = ["BLUE", "WHITE", "YELLOW", "GREEN"] call bis_fnc_selectRandom;
publicVariable "WIRE";
DEFUSED = false;
ARMED = false;
BOMBFINISHED=false;
EXPL=false;
publicVariable "DEFUSED"; publicVariable "ARMED"; publicVariable "BOMBFINISHED"; publicVariable "EXPL";
_civtype=["C_man_p_fugitive_F" , "C_man_p_fugitive_F_afro" , "C_man_p_fugitive_F_euro", "C_man_p_fugitive_F_asia" , "C_Nikos" , "C_Orestes"] call BIS_fnc_selectRandom;
_allb = (getmarkerpos "mission") nearobjects ["House" , 300];
_alle=[];
{_test=_x buildingpos 0;
if ( ( _test select 0) != 0 ) then{
_alle=_alle + [ _x ];
}}foreach _allb;
_cnt = 0;
_posarray = [];
_s1=_alle call BIS_fnc_SelectRandom;
_s2=_alle call BIS_fnc_SelectRandom;
_s3=_alle call BIS_fnc_SelectRandom;
_b=_alle call BIS_fnc_SelectRandom;
while {format ["%1", _s1 buildingpos _cnt] != "[0,0,0]" } do {
	_pos = _s1 buildingpos _cnt;        //select building position _cnt
    _posarray = _posarray + [_pos];        //add the position to the list
    _cnt = _cnt + 1;        //increment counter
    sleep 0.01;
    };
_s1pos=_posarray call BIS_fnc_SelectRandom;
_cnt=0;_posarray = [];
while {format ["%1", _s2 buildingpos _cnt] != "[0,0,0]" } do {
	_pos = _s2 buildingpos _cnt;        //select building position _cnt
    _posarray = _posarray + [_pos];        //add the position to the list
    _cnt = _cnt + 1;        //increment counter
    sleep 0.01;
    };
_s2pos=_posarray call BIS_fnc_SelectRandom;
_cnt=0;_posarray = [];
while {format ["%1", _s3 buildingpos _cnt] != "[0,0,0]" } do {
	_pos = _s3 buildingpos _cnt;        //select building position _cnt
    _posarray = _posarray + [_pos];        //add the position to the list
    _cnt = _cnt + 1;        //increment counter
    sleep 0.01;
    };
_s3pos=_posarray call BIS_fnc_SelectRandom;
_cnt=0;_posarray = [];
while {format ["%1", _b buildingpos _cnt] != "[0,0,0]" } do {
	_pos = _b buildingpos _cnt;        //select building position _cnt
    _posarray = _posarray + [_pos];        //add the position to the list
    _cnt = _cnt + 1;        //increment counter
    sleep 0.01;
    };
_bpos=_posarray call BIS_fnc_SelectRandom;
_cnt=0;_posarray = [];

xoxObj = createVehicle ["Land_Suitcase_F", _s1pos, [], 0, "NONE"];
waitUntil {alive xoxObj};
xoxObj setPosATL _s1pos;
_netID= netID xoxObj;
[[_netID], "makecase", true, true] spawn BIS_fnc_MP;
xoxObjB = createVehicle ["Land_Suitcase_F", _s2pos, [], 0, "NONE"];
waitUntil {alive xoxObjB};
xoxObjB setPosATL _s2pos;
_netID= netID xoxObjB;
[[_netID], "makeFcase", true, true] spawn BIS_fnc_MP;
xoxObjC = createVehicle ["Land_Suitcase_F", _s3pos, [], 0, "NONE"];
waitUntil {alive xoxObjC};
xoxObjC setPosATL _s3pos;
_netID= netID xoxObjC;
[[_netID], "makeFcase", true, true] spawn BIS_fnc_MP;


civObj = createVehicle [_civtype, _bpos, [], 0, "NONE"];
waitUntil {alive civObj};
civObj setPosATL _bpos;
expl1 = "DemoCharge_Remote_Ammo_scripted" createVehicle position civObj;
expl1 attachTo [civObj, [-0.1,0.1,0.15],"Pelvis"];
expl1 setVectorDirAndUp [[0.5,0.5,0],[-0.5,0.5,0]];
expl2 = "DemoCharge_Remote_Ammo_scripted" createVehicle position civObj;
expl2 attachTo [civObj, [0,0.15,0.15],"Pelvis"];
expl2 setVectorDirAndUp [[1,0,0],[0,1,0]];
expl3 = "DemoCharge_Remote_Ammo_scripted" createVehicle position civObj;
expl3 attachTo [civObj, [0.1,0.1,0.15],"Pelvis"];
expl3 setVectorDirAndUp [[0.5,-0.5,0],[0.5,0.5,0]]; 
_netID= netID civObj;
[[_netID], "makebomb", true, true] spawn BIS_fnc_MP;
	
	civObj switchMove "AmovPercMstpSnonWnonDnon_Ease";
	civObj disableAI "AUTOTARGET";
	[civObj, (60 * 30)] execVM "bomb\keypad_defuse\bombTimer.sqf";
	if (_debug > 0 ) then {
	_mrA=createMarker ["goodcase",_s1pos];
	_mrA setMarkerShape "ICON";
	_mrA setMarkerType "o_unknown";
	_mrA setMarkerText  "good case";
	_mrA setMarkerColor "ColorBlue";
	_mrA setMarkerAlpha 0.7;
	_mrA setMarkerPos _s1pos;

	_mrA=createMarker ["bada",_s2pos];
	_mrA setMarkerShape "ICON";
	_mrA setMarkerType "o_unknown";
	_mrA setMarkerText  "bad case a";
	_mrA setMarkerColor "ColorBlue";
	_mrA setMarkerAlpha 0.7;
	_mrA setMarkerPos _s2pos;

	_mrA=createMarker ["badb",_s3pos];
	_mrA setMarkerShape "ICON";
	_mrA setMarkerType "o_unknown";
	_mrA setMarkerText  "bad case b";
	_mrA setMarkerColor "ColorBlue";
	_mrA setMarkerAlpha 0.7;
	_mrA setMarkerPos _s3pos;

	_mrA=createMarker ["bomb",_bpos];
	_mrA setMarkerShape "ICON";
	_mrA setMarkerType "o_unknown";
	_mrA setMarkerText  "the bomb";
	_mrA setMarkerColor "ColorBlue";
	_mrA setMarkerAlpha 0.7;
	_mrA setMarkerPos _bpos;
	
	};
	_mrA=createMarker ["area",getmarkerpos "mission"];
	_mrA setMarkerShape "ELLIPSE";
	_mrA setMarkerType "o_unknown";
	_mrA setMarkerColor "ColorRed";
	_mrA setMarkerAlpha 0.5;
	_mrA setMarkerPos getmarkerpos "mission";
	_mrA setMarkerBrush "FDiagonal";
	_mrA setMarkerSize [300, 300];
	
	
	waitUntil {sleep 0.5 ; (!alive civObj || DEFUSED) };
	if ((EXPL) && !(DEFUSED)) then {
//destroyed
	
	sleep 10;
	"End2" call BIS_fnc_endMission;
	};
	if (!(EXPL) && !(alive civObj)&& !(DEFUSED)) then {
//civ dead
		expl1 setdamage 1;
		expl2 setdamage 1;
		expl3 setdamage 1;
		EXPL=true;
		sleep 10;
		"End2" call BIS_fnc_endMission;
	};
	
	if (DEFUSED) then {
//mission win
sleep 10;
"End1" call BIS_fnc_endMission;
	};
	
};