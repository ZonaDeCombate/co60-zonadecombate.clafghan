// Intro
[] call compileFinal preprocessfilelinenumbers "scripts\intro.sqf";

//-----Logistica R3F --------//
execVM "r3f_log\init.sqf";

//----Script de Reboque-----

execVM "reboque.sqf";

//--- Disable Saving
enableSaving [false, false];


//---------------------- BI SQUAD
// Sistema de gerenciamento de squads da Bohemia.
["Initialize"] call BIS_fnc_dynamicGroups;

// Iniciando sistema de animações
call compile preprocessFileLineNumbers "shoteranimation\init.sqf";

// Sistema de relay de rádio
[300] spawn zc_fnc_radioRelay;

//HandlessClient Inicialização
if (!hasInterface && !isDedicated) then {
  headlessClients = [];
  headlessClients pushBack player;
  publicVariable "headlessClients";
  isHC = true;
};

execVM "briefing.sqf";

//TODO: Não tá funcionando direito. Rever.
/*if (! isDedicated) then
{

  zc_fnc_setRating = {
    _setRating = _this select 0;
    _unit = _this select 1;
    _getRating = rating _unit;
    _addVal = _setRating - _getRating;
    _unit addRating _addVal;
  };

  waituntil {
    _score = rating player;

    if (_score < 0) then {
      [0,player] call zc_fnc_setRating;
      hint parseText format["<t color='#ffff00'>Atenção %1: </t><br/>*** Evite ferir aliados e civis. ***",name player];
    };
    sleep 0.4;
    false
  };
};*/


waituntil {(player getvariable ["alive_sys_player_playerloaded",false])};
