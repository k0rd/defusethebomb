_position=getmarkerpos "mission";
_me = _this select 0;


_moveA = [_position, 0, 600, 3, 0, 1000, 0, [], random 360] call BIS_fnc_findSafePos;
_moveB = [_position, 0, 600, 3, 0, 1000, 0, [], random 360] call BIS_fnc_findSafePos;
_moveC = [_position, 0, 600, 3, 0, 1000, 0, [], random 360] call BIS_fnc_findSafePos;
_wpA = group _me addWaypoint [_moveA,20];
_wpB = group _me addWaypoint [_moveB,20];
_wpC = group _me addWaypoint [_moveC,20];
_wpA setWaypointSpeed "FULL";
_wpA setWaypointCombatMode "RED";
_wpA setWaypointType "SAD";
_wpB setWayPointType "SAD";
_wpC setWayPointType "CYCLE";

