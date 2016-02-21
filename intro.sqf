if(isDedicated) exitWith{};

if (hasInterface) then {

    ["Zona de Combate | Provincia de Kunar - Client Intro..."] call ALiVE_fnc_Dump;

    //Intro
    [] spawn {

		playMusic "ALiVE_Intro";

		waitUntil {!isNull player};

	    titleText ["ZONA DE COMBATE APRESENTA...", "BLACK IN",9999];
		0 fadesound 0;

		private ["_cam","_camx","_camy","_camz","_object","_name"];
		_start = time;

		sleep 10;

		_object = radio;
		_name = name player;
		_camx = getposATL _object select 0;
		_camy = getposATL _object select 1;
		_camz = getposATL _object select 2;

		_cam = "camera" CamCreate [_camx -500 ,_camy + 500,_camz+450];

		_cam CamSetTarget _object;
		_cam CameraEffect ["Internal","Back"];
		_cam CamCommit 0;

		_cam camsetpos [_camx -0 ,_camy + 0,_camz+3];

		titleText ["A   B A T A L H A   DA   P R O V I N C I A    D E    K U N A R", "BLACK IN",10];
		10 fadesound 0.9;
		_cam CamCommit 20;
		sleep 5;
		sleep 15;

		_cam CameraEffect ["Terminate","Back"];
		CamDestroy _cam;
		10 fadeMusic 0;

		sleep 1;

		_title = "<t size='1.2' color='#e5b348' shadow='1' shadowColor='#000000'>ZONA DE COMBATE</t>
		<img color='#ffffff' image='media\images\img_line_ca.paa' align='left' size='0.60' /><br/>";
        _text = format["%1<t>Bem Vindo %2. por favor preste atenção nas proximas mensagens e siga as regras para melhor estadia na Zona de Combate.</t>
		<br/><br/><img color='#ffffff' image='media\images\img_line_ca.paa' align='left' size='0.60' />",_title, _name];

        ["openSideTop",1.4] call ALIVE_fnc_displayMenu;
        ["setSideTopText",_text] call ALIVE_fnc_displayMenu;

        sleep 20;

		_title = "<t size='1.2' color='#e5b348' shadow='1' shadowColor='#000000'>ZONA DE COMBATE</t>
		<img color='#ffffff' image='media\images\img_line_ca.paa' align='left' size='0.60' /><br/>";
        _text = format["%1<t>Os equipamento são limitados com entrega restrita, a perda de veiculos e aeronaves podem afetar a todas as casas para cumprimento das tarefas.</t>
		<br/><br/><img color='#ffffff' image='media\images\img_line_ca.paa' align='left' size='0.60' />",_title];

        ["openSideTop",1.4] call ALIVE_fnc_displayMenu;
        ["setSideTopText",_text] call ALIVE_fnc_displayMenu;

        sleep 15;
		playMusic "";

        _title = "<t size='1.2' color='#e5b348' shadow='1' shadowColor='#000000'>ZONA DE COMBATE</t>
		<img color='#ffffff' image='media\images\img_line_ca.paa' align='left' size='0.60' /><br/>";
        _text = format["%1<t>Evite deixar equipamentos jogados no chão, lembrando aqui não é sua casa e sim um ambiente militar.</t>
		<br/><br/><img color='#ffffff' image='media\images\img_line_ca.paa' align='left' size='0.60' />",_title,(paramsArray select 6)];

        ["openSideTop",1.4] call ALIVE_fnc_displayMenu;
        ["setSideTopText",_text] call ALIVE_fnc_displayMenu;

        sleep 15;

        _title = "<t size='1.2' color='#e5b348' shadow='1' shadowColor='#000000'>ZONA DE COMBATE</t>
		<img color='#ffffff' image='media\images\img_line_ca.paa' align='left' size='0.60' /><br/>";
        _text = format["%1<t>Ao entrar em missão procure se comunicar com o lider da sua casa utilize os canais globais de comunicação, e evite seguir para a zona de conflito sem aviso prévio pois isso pode estragar a operação em andamento</t>
		<br/><br/><img color='#ffffff' image='media\images\img_line_ca.paa' align='left' size='0.60' />",_title];

        ["openSideTop",1.4] call ALIVE_fnc_displayMenu;
        ["setSideTopText",_text] call ALIVE_fnc_displayMenu;
    };

    waituntil {!isnull player};

};