/*
ADV_fnc_radioRelay - by Belbo (QA and approved by Nyaan)
Modified for Zona de Combate by Toaster


*/

params [["_minHeight", 0, [0]]];

minheightvar = _minHeight;


// Para aqui se o cara não tem o mod TFAR
if !(isClass (configFile >> "CfgPatches" >> "task_force_radio")) exitWith {};



// Cria as ações do ACE no OBJETO (Data Terminal)
_ace_relayActionON = [
    "relayActionOn",
    ("<t color=""#00FF00"">" + ("ATIVAR REPETIDOR DE RÁDIO") + "</t>"),
    "",
      {

        [_this select 0,3] call BIS_fnc_dataTerminalAnimate;
        (_this select 0) setVariable ["isRelayActive",true,true];
        systemChat "Repetidor de rádio ligado.";

        _marker = createMarker [format["marker_%1", (_this select 0)], getPos (_this select 0)];
        _marker setMarkerShape "ICON";
        _marker setMarkerType "mil_triangle";
        _marker setMarkerColor "ColorGreen";
        _marker setMarkerText "Repetidor de Rádio: Ligado";


      },
    { (!((_this select 0) getVariable ["isRelayActive",false]) && damage (_this select 0) < 0.6) && (getTerrainHeightASL (getPos (_this select 0)) > minheightvar)}
] call ace_interact_menu_fnc_createAction;

_ace_relayActionOFF = [
    "relayActionOff",
    ("<t color=""#FF0000"">" + ("DESATIVAR REPETIDOR DE RÁDIO") + "</t>"),
    "",
    {
      deleteMarker format["marker_%1", (_this select 0)];
      [_this select 0,0] call BIS_fnc_dataTerminalAnimate;
      (_this select 0) setVariable ["isRelayActive",false,true];
      systemChat "Repetidor de rádio desligado."

      },
    { ((_this select 0) getVariable ["isRelayActive",false]) && damage (_this select 0) < 0.6 }
] call ace_interact_menu_fnc_createAction;



_ace_relayActionDisabled = [
    "relayActionDisabled",
    ("<t color=""#FF0000"">" + ("#ERR 34BA2: ALTURA INVÁLIDA") + "</t>"),
    "",
    {
      systemChat format ["Devido a problemas na triangulação do sinal, uma altura de %1m é necessária para utilização deste equipamento.", minheightvar];

      },
    { getTerrainHeightASL (getPos (_this select 0)) < minheightvar }
] call ace_interact_menu_fnc_createAction;






[_ace_relayActionON,_ace_relayActionOFF, _ace_relayActionDisabled] spawn {
    _ace_relayActionON = _this select 0;
    _ace_relayActionOFF = _this select 1;
    _ace_relayActionDisabled = _this select 2;

    // Verifica de 5 em 5 segundos se existe terminal a ser iniciado.
    while { true } do {
      // Seleciona todos os terminais do mapa
      allDataTerminals = allMissionObjects "Land_DataTerminal_01_F";
      {
        // Se o terminal não foi configurado, inicia configuração
        if(isNil { _x getVariable "isTerminalInitialized" }) then {

          // Deixa o terminal vermelho enquanto ainda não inicializa
          [_x,"red","red","green"] call BIS_fnc_DataTerminalColor;

          // Adiciona as ações do ACE no terminal
          [_x , 0, [],_ace_relayActionON] call ace_interact_menu_fnc_addActionToObject;
          [_x , 0, [],_ace_relayActionOFF] call ace_interact_menu_fnc_addActionToObject;
          [_x , 0, [],_ace_relayActionDisabled] call ace_interact_menu_fnc_addActionToObject;

          // Avisa que este terminal já foi configurado
          _x setVariable ["isTerminalInitialized", true];



        };
      } forEach allDataTerminals;
      // Tempo de espera para iniciar check de terminais. Aumentar caso de zica de performance.
      sleep 1;
    };
};

if (isServer) then {

    [_minHeight] spawn {

        while { true } do {
            {
              _relay = _x;
              _minHeight = _this select 0;
              while {alive _relay} do {
                  waitUntil { sleep 1; damage _relay > 0.6 || !alive _relay || getTerrainHeightASL (getPos _relay) < _minHeight};
                  _relay setVariable ["isRelayActive",false,true];
                  waitUntil { sleep 1; damage _relay < 0.4 || !alive _relay };
              };
            } forEach allDataTerminals;
        sleep 1;
        };

    };

    if !( missionNamespace getVariable ["isRelayScriptExecutedOnServer",false] ) then {


        missionNamespace setVariable ["isRelayScriptExecutedOnServer",true,true];

        while {true} do {

            allDataTerminals = allMissionObjects "Land_DataTerminal_01_F";

            if ({_x getVariable ["isRelayActive",true]} count allDataTerminals > 0) then {
              {
                  _x setVariable ["tf_receivingDistanceMultiplicator", 0.333, true];
                  _x setVariable ["tf_sendingDistanceMultiplicator", ((({_x getVariable ["isRelayActive",false]} count allDataTerminals) / 4) + 1), true];
              } forEach allPlayers;
            } else {
              {
                  _x setVariable ["tf_receivingDistanceMultiplicator", 1, true];
                  _x setVariable ["tf_sendingDistanceMultiplicator", 1, true];
              } forEach allPlayers;
            };
            sleep 1;

        };

    };
};
