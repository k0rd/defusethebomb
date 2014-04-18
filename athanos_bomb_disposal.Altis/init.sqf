//	Initialize time of day, chosen in the mission parameters.
_t = (paramsarray select 0);
if (isserver) then {
	setDate [2035, 7, 6, _t, 0];
};

	"BombTimer" addPublicVariableEventHandler
	{
		private ["_BHint"];
		_Btime = _this select 1;
		cutText[format["Bomb Detonation: \n %1", [((_Btime)/60)+.01,"HH:MM"] call BIS_fnc_timetostring],"PLAIN DOWN"];
//		publicVariable "CODE";
//		publicVariable "WIRE";
	};
	
//	Initialize some misc stuff.
_side = createCenter east;
_side = createCenter west;
_side = createCenter civilian;
_side = createCenter resistance;



makeFcase={
_scID= _this select 0;
_case=objectFromNetID _scID;
_case addAction["<t color='#ff0011'>Search Briefcase</t>","bomb\keypad_defuse\fakecase.sqf"];
};

makecase={
_scID= _this select 0;
_case=objectFromNetID _scID;
_case  addAction [("<t color='#ff0011'>" + ("Search Briefcase") + "</t>"),"bomb\keypad_defuse\searchAction.sqf","",1,true,true,"","(_target distance _this) < 3"];
};

makebomb={
_bID= _this select 0;
_bomber=objectFromNetID _bID;
_bomber addAction [("<t color='#E61616'>" + ("Access Bomb Keypad") + "</t>"),"bomb\keypad_defuse\defuseAction.sqf","",1,true,true,"","(_target distance _this) < 5"];
};

WIRE=[];
CODEINPUT = [];
CODE=[];


//	Initialize briefing.
[
	[
		"Mission",
		[
			"Find the code, then find the bomb and disarm it. Optionally engage hostiles."
		]
	],
	[
		"Rules",
		[
			""
		]
	],
	[
		"Info",
		[
			""
		]
	],
	[
		"Credits",
		[
			""
		]
	]
]
call {
	if (not isdedicated) then {
		private "_briefing";
		_briefing = _this;
		waituntil {not isnull player};
		for "_i" from ((count _briefing) - 1) to 0 step -1 do {
			for [{_k = (count (_briefing select _i select 1)) - 1},{_k >= 0},{_k = _k - 1}] do {
				player createDiaryRecord ["Diary", [_briefing select _i select 0,_briefing select _i select 1 select _k]];
			};
		};
	};
};

if ((!isServer) && (player != player)) then
{
  waitUntil {player == player};
};
finishMissionInit;

// Start side missions
_handle= [] execVM "go.sqf";

//	The following code is executed after the briefing screen.
sleep 0.5;

//	Client-side scripts.
if (!isdedicated) then {
	
	//	Disable AI radio chatter.
	player setVariable ["BIS_noCoreConversations", true];
};

