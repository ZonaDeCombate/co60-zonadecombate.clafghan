#include "SHK_Fastrope.sqf"

// Check de piloto
_null = [] execVM "Scripts\pilotCheck.sqf";

//-- Add insurgency menu
execVM "Scripts\addInsurgencyMenu.sqf";

//-- Create locations for ALiVE custom objectives
//execVM "Scripts\createLocations.sqf";

// TODO: Rever, está usando todos os falantes do mapa.
// Falantes na Base
/*while {true} do {
    [] execVM "Scripts\loudspeakers.sqf";
    sleep 16470;
};*/

//-- Sistema de SQUAD da BI
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
