INSTRUCTIONS TO USE THIS SCRIPT FOR A MULTIPLAYER MISSION

1) place the contents of the "bomb" subdirectory to your mission directory

2) place the following lines in description.ext in your mission directory:
	#include "bomb\defines.hpp"
	#include "bomb\keypad_defuse\explosivePad.hpp"

3) place the following line in init.sqf to run the timer for all the players
	[] execVM "bomb\timer.sqf";

4) add the following code to the object that you want to blow up (explosives will be added to the objecct):
	nul=[this, 300] execVM "bomb\keypad_defuse\bombTimer.sqf"; nul=addAction [("<t color='#E61616'>" + ("Access Bomb Keypad") + "</t>"),"bomb\keypad_defuse\defuseAction.sqf","",1,true,true,"","(_target distance _this) < 5"];

	where 300 is the bomb timer duration (in seconds)
	
	the state of the bomb is passed to the clients by public variables. 
	
5) add the following to objects you want to search to find the code
	 nul=this addAction [("<t color='#ff0011'>" + ("Search Briefcase") + "</t>"),"bomb\keypad_defuse\searchAction.sqf","",1,true,true,"","(_target distance _this) < 3"];
	 
6) add any dummy cases (optional) like this:
	nul=this  addAction["<t color='#ff0011'>Search Briefcase</t>","bomb\keypad_defuse\fakecase.sqf"];
	
7) if you are not using the editor for steps 5 and 6, additional steps are required. please see the example athanos_bomb_disposal.Altis for guidance.

-k0rd
