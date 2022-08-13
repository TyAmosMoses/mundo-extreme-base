/*
	Mundo Extreme: código comenzado por Benjes el 16/02/2020.
*/

#include <a_samp>

#define MAX_NPC (0)

#undef MAX_PLAYERS
#define MAX_PLAYERS (100)

#undef MAX_VEHICLES
#define MAX_VEHICLES (500)

#include <a_mysql>
#include <sscanf2>
#include <streamer>

#define YSI_NO_MODE_CACHE
#define YSI_NO_HEAP_MALLOC
#define YSI_NO_OPTIMISATION_MESSAGE
#define YSI_NO_VERSION_CHECK

#pragma warning disable 239, 203, 208
#define CGEN_MEMORY 60000

#include "YSI_Coding\y_timers"
#include "YSI_Server\y_flooding"

#include "contains/includes/PreviewModelDialog"
#include "contains/includes/Pawn.CMD"
#include "contains/includes/Dialog"
#include "contains/includes/Bars"
#include "contains/includes/Pause"
#include "contains/includes/KickBan"

#include "contains/server/Maps"
#include "contains/server/Utils"
#include "contains/server/PlayerData"
#include "contains/server/Colors"

#include "contains/systems/Cars"
#include "contains/systems/Machines"

AMX()
{
	new
		str[][] = {"Unarmed (Fist)", "Brass K"};

	#pragma unused str
}

/* Configuración */
#define PROJECT "Mundo Extreme"
#define SERVER_NAME ""PROJECT" | Tú eres el protagonista"
#define SERVER_WEB  "mundo-extreme.com"
#define SERVER_TYPE "Role Play"
#define SERVER_LANG "Español"
#define SERVER_MAP "S. A."
#define SERVER_RCON "#daresdar#"

#define SAMP_VERSION "0.3.7-R4"
#define SERVER_UPDATE "18/03/2020"
#define SERVER_VERSION "3.0.0"

/* Progr. */
#define RGBToHex(%0,%1,%2,%3) %0 << 24 | %1 << 16 | %2 << 8 | %3
#define DELAY (5)

/* Timer´s */
#define TIMER_REGISTER (0)
#define TIMER_DIALOG_REGISTER (1)

/* Definición de modelos */
#define MODEL_SELECTION_REGISTER (0)

/* Dialogos de ingreso, registro y errores de ambos */
#define FORMAT_LOGIN ""COL_CONTENT"Este personaje ya está registrado,\nse conectó "COL_SERVER"el %s"COL_CONTENT" por última vez.\
\n\n"COL_CONTENT_TWO"Tienes "COL_TOMATO"un total de %d intentos"COL_CONTENT_TWO" para ingresar la contraseña correctamente"COL_CONTENT"."

#define FORMAT_LOGIN_ERROR ""COL_CONTENT"Este personaje ya está registrado,\nse conectó "COL_SERVER"el %s"COL_CONTENT" por última vez.\
\n\n"COL_CONTENT_TWO"La contraseña errónea. Usaste "COL_TOMATO"%d de %d intentos."COL_CONTENT_TWO" Inténtalo nuevamente"COL_CONTENT"..."

#define FORMAT_REGISTER ""COL_CONTENT"Este personaje no está registrado. Regístralo "COL_SERVER"para comenzar a jugar"COL_CONTENT".\
\n\n"COL_CONTENT_TWO"Ingresa una contraseña "COL_TOMATO"no menor a %d caracteres "COL_CONTENT_TWO"ni "COL_TOMATO"mayor a %d caracteres"COL_CONTENT"."

#define FORMAT_REGISTER_ERROR ""COL_CONTENT"Este personaje no está registrado. Regístralo "COL_SERVER"para comenzar a jugar"COL_CONTENT".\
\n\n"COL_CONTENT_TWO"Hey. Leéme. Debe ser "COL_TOMATO"no menor a %d caracteres "COL_CONTENT_TWO"ni "COL_TOMATO"mayor a %d caracteres"COL_CONTENT"."

/* Registro e inicio de sesión */
#define THREAD_CHECK_ACCOUNT (1)
#define THREAD_CREATE_CHAR (2)
#define THREAD_LOGIN (3)
#define THREAD_SPAWN_CHARACTER (4)
#define THREAD_LOAD_CHARACTER (5)

#define MAX_LOGIN_ATTEMPTS (3)

#define MIN_PASSWORD_LENGTH (4)
#define MAX_PASSWORD_LENGTH (45)

#define MAX_SECURITY_QUESTION_SIZE (128)
#define MAX_SECURITY_ANSWER_SIZE (64)

/* Máximos generales */
#define MAX_ANNOUNCES (10)
#define MAX_REPORTS (10)
#define MAX_DOUBTS (10)

/* Generales */
#define SPAWN_X (1481.2567)
#define SPAWN_Y (-1749.2756)
#define SPAWN_Z (15.4453)
#define SPAWN_ANGLE (358.5142)

#define SPAWN_MONEY (150)
#define SPAWN_BANK_MONEY (5000)
#define LIC_DRIVING_PRICE (200)
#define SPAWN_LEVEL (1)
#define STATIC_DRAW (-1)

/* Mensajes */
#define SendSampMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_DEFAULT, ""%1)
	
#define SendServerMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_YELLOW, ""%1)

#define SendSyntaxMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_GREY, "Escribe "COL_PIEL""%1)

#define SendInfoMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_CYAN, ""%1)
	
#define SendErrorMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_GREY, ""%1)

#define SendAdminAction(%0,%1) \
	SendClientMessageEx(%0, COLOR_ADMIN_TWO, "— "%1)

#define SendWarningMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_TOMATO, ""%1)

static AnimationLibraries[][] =
{
	!"AIRPORT",    !"ATTRACTORS",   !"BAR",             !"BASEBALL",
	!"BD_FIRE",    !"BEACH",        !"BENCHPRESS",      !"BF_INJECTION",
	!"BIKED",      !"BIKEH",        !"BIKELEAP",        !"BIKES",
	!"BIKEV",      !"BIKE_DBZ",     !"BMX",             !"BOMBER",
	!"BOX",        !"BSKTBALL",     !"BUDDY",           !"BUS",
	!"CAMERA",     !"CAR",          !"CARRY",           !"CAR_CHAT",
	!"CASINO",     !"CHAINSAW",     !"CHOPPA",          !"CLOTHES",
	!"COACH",      !"COLT45",       !"COP_AMBIENT",     !"COP_DVBYZ",
	!"CRACK",      !"CRIB",         !"DAM_JUMP",        !"DANCING",
	!"DEALER",     !"DILDO",        !"DODGE",           !"DOZER",
	!"DRIVEBYS",   !"FAT",          !"FIGHT_B",      	!"FIGHT_C",
	!"FIGHT_D",    !"FIGHT_E",      !"FINALE",          !"FINALE2",
	!"FLAME",      !"FLOWERS",      !"FOOD",            !"FREEWEIGHTS",
	!"GANGS",      !"GHANDS",       !"GHETTO_DB",       !"GOGGLES",
	!"GRAFFITI",   !"GRAVEYARD",    !"GRENADE",         !"GYMNASIUM",
	!"HAIRCUTS",   !"HEIST9",       !"INT_HOUSE",       !"INT_OFFICE",
	!"INT_SHOP",   !"JST_BUISNESS", !"KART",            !"KISSING",
	!"KNIFE",      !"LAPDAN1",      !"LAPDAN2",         !"LAPDAN3",
	!"LOWRIDER",   !"MD_CHASE",     !"MD_END",          !"MEDIC",
	!"MISC",       !"MTB",          !"MUSCULAR",		!"NEVADA",
	!"ON_LOOKERS", !"OTB",          !"PARACHUTE",		!"PARK",
	!"PAULNMAC",   !"PED",          !"PLAYER_DVBYS",	!"PLAYIDLES",
	!"POLICE",     !"POOL",         !"POOR",            !"PYTHON",
	!"QUAD",       !"QUAD_DBZ",     !"RAPPING",      	!"RIFLE",
	!"RIOT",       !"ROB_BANK",     !"ROCKET",          !"RUSTLER",
	!"RYDER",      !"SCRATCHING",   !"SHAMAL",          !"SHOP",
	!"SHOTGUN",    !"SILENCED",     !"SKATE",           !"SMOKING",
	!"SNIPER",     !"SPRAYCAN",     !"STRIP",           !"SUNBATHE",
	!"SWAT",       !"SWEET",     	!"SWIM",    	    !"SWORD",
	!"TANK",       !"TATTOOS",      !"TEC",     	    !"TRAIN",
	!"TRUCK",      !"UZI",          !"VAN",             !"VENDING",
	!"VORTEX",     !"WAYFARER",     !"WEAPONS",      	!"WUZI",
	!"WOP",        !"GFUNK",        !"RUNNINGMAN"
};

new MasculineClothes[18] = {
	2, 4, 7, 15, 19,
    60, 20, 21, 46, 48,
    240, 66, 120, 124,
    128, 137, 180, 299
};

new FemenineClothes[18] = {
	9, 11, 12, 13, 40,
    41, 55, 56, 65, 93,
    141, 151, 157, 169,
    172, 190, 191, 192
};

new const SecurityQuestions[][128] =
{
	"¿Cuál es tu comida preferida?",
	"¿Cómo es el nombre de tu mascota?",
	"¿Qué palabra te define?",
 	"¿Cuál fue el primer deporte que practicaste?",
	"¿Cómo se llama el deporte que practicas?",
	"¿Cuál es el nombre de tu equipo de fútbol favorito?",
	"¿Cuál es el nombre de tu película favorita?",
	"¿Cuál es el nombre de tu serie favorita?",
	"¿Cuál es el nombre de la persona que besaste por primera vez?",
	"¿Cuál es el nombre de la marca de tu primer vehículo?",
	"¿Cómo se llama la empresa donde trabajas?"
};

enum announceData
{
	aExists,
	aType,
	aPlayer,
	aText[128 char],
	aTextResume[20 char]
};

new AnnounceData[MAX_ANNOUNCES][announceData]/*,
	AnnounceItem[MAX_PLAYERS][11]*/;

enum reportData
{
	rExists,
	rType,
	rPlayer,
	rText[128 char]
};

new ReportData[MAX_REPORTS][reportData];

enum doubtData
{
	dExists,
	dType,
	dPlayer,
	dText[128 char]
};

new DoubtData[MAX_DOUBTS][doubtData];

stock GetDurationEx(time)
{
	new
	    str[64];

    new
		minutes = time / 60,
		hours = time / 3600,
		days = time / 86400;

	if (time < 0 || time == gettime())
	{
	    format(str, sizeof(str), "...");
	    return str;
	}
 	else if (time == 1) format(str, sizeof(str), "%d segundo", time);
	else if (time >= 0 && time < 60) format(str, sizeof(str), "%d segundos", time);
	else if (time >= 60 && time < 3600) format(str, sizeof(str), (time >= 120) ? ("%d minutos") : ("%d minuto"), minutes);
	else if (time >= 3600 && time < 86400) format(str, sizeof(str), (time >= 7200) ? ("%d horas, %d minutos") : ("%d hora, %d minutos"), hours, (time - (3600 * hours)) / 60);
	else if (time >= 86400)
	{
		format(str, sizeof(str), (time >= 172800) ? ("%d días, %d horas, %d minutos") : ("%d día, %d horas, %d minutos"),
			days,
			(time - (86400 * days)) / 3600,
		 	(time - (3600 * hours)) / 60
		 );
 	}
	return str;
}

native WP_Hash(buffer[], len, const str[]);

Cancel_Showing(playerid)
{
	if (!IsViewCheckpoint(playerid)) DisablePlayerCheckpoint(playerid);

	if (!IsViewInformation(playerid)) HidePlayerInfo(playerid);
}

Show_Speedometer(playerid)
{
	/* Relojes */
	for (new speedo = 0; speedo < 2; speedo ++) PlayerTextDrawShow(playerid, TEXT_DRAW_ALL[playerid][speedo]);

	/* Números */
	for (new speedo = 0; speedo < 12; speedo ++) PlayerTextDrawShow(playerid, TEXT_DRAW_SPEEDO[playerid][speedo]);

	/* Gasolímetro */
	for (new speedo = 0; speedo < 5; speedo ++) PlayerTextDrawShow(playerid, TEXT_DRAW_GAS[playerid][speedo]);

	PlayerTextDrawShow(playerid, PlayerData[playerid][TEXT_DRAW][7]), // Velocidad
	PlayerTextDrawShow(playerid, PlayerData[playerid][TEXT_DRAW][8]), // Kilometraje
	PlayerTextDrawShow(playerid, PlayerData[playerid][TEXT_DRAW][9]); // Gasolina
	
    SpeedoShowing[playerid] = 1,
    Update_SpeedoColor(playerid);
}

Hide_Speedometer(playerid)
{
	/* Relojes */
	for (new speedo = 0; speedo < 2; speedo ++) PlayerTextDrawHide(playerid, TEXT_DRAW_ALL[playerid][speedo]);

	/* Números */
	for (new speedo = 0; speedo < 12; speedo ++) PlayerTextDrawHide(playerid, TEXT_DRAW_SPEEDO[playerid][speedo]);

	/* Gasolímetro */
	for (new speedo = 0; speedo < 5; speedo ++) PlayerTextDrawHide(playerid, TEXT_DRAW_GAS[playerid][speedo]);
	
 	PlayerTextDrawHide(playerid, PlayerData[playerid][TEXT_DRAW][7]), // Velocidad
	PlayerTextDrawHide(playerid, PlayerData[playerid][TEXT_DRAW][8]), // Kilometraje
	PlayerTextDrawHide(playerid, PlayerData[playerid][TEXT_DRAW][9]); // Gasolina
	
	SpeedoShowing[playerid] = 0,
	Needle0(playerid, false, "_", 0.0),
	NeedleGas(playerid, false, "_", 0.0);
}

Update_Speedometer(playerid)
{
	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
		if (IsSpeedoVehicle(GetPlayerVehicleID(playerid)))
		{
			new
   	   			str[64];

  			new
 				Float:speed = GetVehicleSpeedToSpeedo(playerid),
  				fuel = CoreVehicles[GetPlayerVehicleID(playerid)][vehFuel],
				km = CoreVehicles[GetPlayerVehicleID(playerid)][vehCoreKMS];

			if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				if (speed == 0) format(str, sizeof(str), "000 KM/H");
    			else if (speed > 0 && speed < 10) format(str, sizeof(str), "00%.0f KM/H", speed);
		    	else if (speed > 9 && speed < 100) format(str, sizeof(str), "0%.0f KM/H", speed);
				else if (speed >= 100) format(str, sizeof(str), "%.0f KM/H", speed);
			}

	  		PlayerTextDrawSetString(playerid, PlayerData[playerid][TEXT_DRAW][7], Desbug(str));

            /* Kilómetros */
			if (km < 10) format(str, sizeof(str), "00000000%d", km);
			else if (km > 9 && km < 100) format(str, sizeof(str), "0000000%d", km);
			else if (km > 99 && km < 1000) format(str, sizeof(str), "000000%d", km);
			else if (km > 999 && km < 10000) format(str, sizeof(str), "00000%d", km);
			else if (km > 9999 && km < 100000) format(str, sizeof(str), "0000%d", km);
			else if (km > 99999 && km < 1000000) format(str, sizeof(str), "000%d", km);
			else if (km > 999999 && km < 10000000) format(str, sizeof(str), "00%d", km);
			else if (km > 9999999 && km < 100000000) format(str, sizeof(str), "0%d", km);
			else format(str, sizeof(str), "%d", km);

			PlayerTextDrawSetString(playerid, PlayerData[playerid][TEXT_DRAW][8], Desbug(str));

			format(str, sizeof(str), "%d%c", fuel, '%');
			PlayerTextDrawSetString(playerid, PlayerData[playerid][TEXT_DRAW][9], str);
		}
	}
}

stock Update_SpeedoColor(playerid)
{
	if (SpeedoShowing[playerid] == 1)
	{
 	    new
	    	vehicle = GetPlayerVehicleID(playerid),
			carid = Car_GetID(vehicle);

        Needle0(playerid, false, "_", 0.0),
        NeedleGas(playerid, false, "_", 0.0);
        
		switch (GetLightStatus(vehicle))
		{
			case false:
			{
			    /* Relojes */
				for (new speedo = 0; speedo < 2; speedo ++)
				{
			  		if (CarData[carid][carCOLOR_1] == 205) // Si es un azúl muy oscuro, convertirlo en un azúl más claro
		  			{
					  	PlayerTextDrawColor(playerid, TEXT_DRAW_ALL[playerid][speedo], ColorToHex_LightsOff[79]);
				  	}
					else if (CarData[carid][carCOLOR_1] == 133 || CarData[carid][carCOLOR_1] == 215)
					{
						PlayerTextDrawColor(playerid, TEXT_DRAW_ALL[playerid][speedo], ColorToHex_LightsOff[0]);
					}
					else PlayerTextDrawColor(playerid, TEXT_DRAW_ALL[playerid][speedo], ColorToHex_LightsOff[CarData[carid][carCOLOR_1]]); // Color original

				    PlayerTextDrawHide(playerid, PlayerText:TEXT_DRAW_ALL[playerid][speedo]),
					PlayerTextDrawShow(playerid, PlayerText:TEXT_DRAW_ALL[playerid][speedo]);
				}
				
				/* Números */
				for (new speedo = 0; speedo < 12; speedo ++)
				{
					PlayerTextDrawColor(playerid, TEXT_DRAW_SPEEDO[playerid][speedo], COLOR_TEXTDRAW);
					
	    			PlayerTextDrawHide(playerid, PlayerText:TEXT_DRAW_SPEEDO[playerid][speedo]),
					PlayerTextDrawShow(playerid, PlayerText:TEXT_DRAW_SPEEDO[playerid][speedo]);
				}

				/* Gasolímetro */
				for (new speedo = 0; speedo < 5; speedo ++)
				{
					PlayerTextDrawColor(playerid, TEXT_DRAW_GAS[playerid][speedo], COLOR_TEXTDRAW);
					
  					PlayerTextDrawHide(playerid, PlayerText:TEXT_DRAW_GAS[playerid][speedo]),
					PlayerTextDrawShow(playerid, PlayerText:TEXT_DRAW_GAS[playerid][speedo]);
				}

				/* Estadísticas en texto */
				for (new speedo = 7; speedo < 10; speedo ++)
				{
					PlayerTextDrawColor(playerid, PlayerData[playerid][TEXT_DRAW][speedo], COLOR_TEXTDRAW);

  					PlayerTextDrawHide(playerid, PlayerData[playerid][TEXT_DRAW][speedo]),
					PlayerTextDrawShow(playerid, PlayerData[playerid][TEXT_DRAW][speedo]);
				}
			}
			case true:
			{
			    // Relojes
   				for (new speedo = 0; speedo < 2; speedo ++)
				{
			  		if (CarData[carid][carCOLOR_1] == 205)
		  			{
					  	PlayerTextDrawColor(playerid, TEXT_DRAW_ALL[playerid][speedo], ColorToHex_LightsOn[79]);
				  	}
					else if (CarData[carid][carCOLOR_1] == 133 || CarData[carid][carCOLOR_1] == 215)
					{
						PlayerTextDrawColor(playerid, TEXT_DRAW_ALL[playerid][speedo], ColorToHex_LightsOn[0]);
					}
					else PlayerTextDrawColor(playerid, TEXT_DRAW_ALL[playerid][speedo], ColorToHex_LightsOn[CarData[carid][carCOLOR_1]]); // Color original

				    PlayerTextDrawHide(playerid, PlayerText:TEXT_DRAW_ALL[playerid][speedo]),
					PlayerTextDrawShow(playerid, PlayerText:TEXT_DRAW_ALL[playerid][speedo]);
				}
				
				/* Números */
				for (new speedo = 0; speedo < 12; speedo ++)
				{
					PlayerTextDrawColor(playerid, TEXT_DRAW_SPEEDO[playerid][speedo], COLOR_WHITE);

	    			PlayerTextDrawHide(playerid, PlayerText:TEXT_DRAW_SPEEDO[playerid][speedo]),
					PlayerTextDrawShow(playerid, PlayerText:TEXT_DRAW_SPEEDO[playerid][speedo]);
				}

				/* Gasolímetro */
				for (new speedo = 0; speedo < 5; speedo ++)
				{
					PlayerTextDrawColor(playerid, TEXT_DRAW_GAS[playerid][speedo], COLOR_WHITE);

  					PlayerTextDrawHide(playerid, PlayerText:TEXT_DRAW_GAS[playerid][speedo]),
					PlayerTextDrawShow(playerid, PlayerText:TEXT_DRAW_GAS[playerid][speedo]);
				}

				/* Estadísticas en texto */
				for (new speedo = 7; speedo < 10; speedo ++)
				{
					PlayerTextDrawColor(playerid, PlayerData[playerid][TEXT_DRAW][speedo], COLOR_WHITE);

  					PlayerTextDrawHide(playerid, PlayerData[playerid][TEXT_DRAW][speedo]),
					PlayerTextDrawShow(playerid, PlayerData[playerid][TEXT_DRAW][speedo]);
				}
			}
		}
	}
	return true;
}

stock SetVehicleColor(vehicleid, color1, color2)
{
    new
		id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carCOLOR_1] = color1;
	    CarData[id][carCOLOR_2] = color2;

	    Car_Save(id);
	}

    foreach (new i : Player) // Actualiza el color del velocímetro
	{
  		if (IsSpeedoVehicle(vehicleid) && (SQL_IsLogged(i) && GetPlayerVehicleID(i) == vehicleid))
  		{
  		    Update_SpeedoColor(i);
    	}
   	}

	return ChangeVehicleColor(vehicleid, color1, color2);
}

stock IsViewCheckpoint(playerid)
{
	static
		id = -1;

    if ((id = Machine_Nearest(playerid)) != -1) return id + 1;

	return false;
}

stock IsViewInformation(playerid)
{
	static
		id = -1;

	if ((id = Car_Nearest(playerid)) != -1 && GetVehicleKeys(playerid, id) && CarData[id][carLOCKED]) return id + 1;
	return false;
}

GiveMoney(playerid, amount)
{
	PlayerData[playerid][MONEY] += amount;
	GivePlayerMoney(playerid, amount);
	return true;
}

stock Buy(playerid, amount, inbank = 0, sound = 1)
{
    if (SQL_IsLogged(playerid))
	{
 		new
			str[20 + 1];

 		if (inbank != 1) GiveMoney(playerid, -amount);
		else if (inbank != 0)
		{
		    SendInfoMessage(playerid, "Se descontaron "COL_WHITE"%s"COL_CYAN" de tu cuenta bancaria.", FormatNumber(amount)),
	 		PlayerData[playerid][BANK_MONEY] -= amount;
		}

		format(str, sizeof(str), "~r~-%s", FormatNumber(amount));
  		GameTextForPlayer(playerid, Desbug(str), SECONDS(1), 1);

        if (sound != 0) 
        	PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
    }
    return true;
}

stock Gain(playerid, amount, inbank = 0, sound = 1)
{
    if (SQL_IsLogged(playerid))
	{
	    new
			str[20 + 1];

		if (inbank != 1) GiveMoney(playerid, amount);
		else if (inbank != 0)
		{
		    SendInfoMessage(playerid, "Se agregaron "COL_WHITE"%s"COL_CYAN" a tu cuenta bancaria.", FormatNumber(amount)),
	 		PlayerData[playerid][BANK_MONEY] += amount;
		}

		format(str, sizeof(str), "~g~+%s", FormatNumber(amount));
  		GameTextForPlayer(playerid, Desbug(str), SECONDS(1), 1);

        if (sound != 0) 
        	PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
    }
    return true;
}

stock ModifyVehicleSpeed(vehicleid, mph)
{
	new
		Float:Vx,
		Float:Vy,
		Float:Vz,
		Float:DV,
		Float:multiple;

	GetVehicleVelocity(vehicleid, Vx, Vy, Vz), DV = floatsqroot(Vx * Vx + Vy * Vy + Vz * Vz);

	if (DV > 0)
	{
		multiple = ((mph + DV * 100) / (DV * 100));
		return SetVehicleVelocity(vehicleid, Vx * multiple, Vy * multiple, Vz * multiple);
	}
	return false;
}

stock ShowPlayerSuggestion(playerid, const string[], time = SECONDS(5))
{
	if (PlayerData[playerid][SUGGESTION_SHOW])
	{
	    PlayerTextDrawHide(playerid, PlayerData[playerid][TEXT_DRAW][2]),
	    KillTimer(PlayerData[playerid][SUGGESTION_TIMER]);
	}

	PlayerTextDrawSetString(playerid, PlayerData[playerid][TEXT_DRAW][2], Desbug(string)),
	PlayerTextDrawShow(playerid, PlayerData[playerid][TEXT_DRAW][2]);

	PlayerData[playerid][SUGGESTION_SHOW] = true;
	return PlayerData[playerid][SUGGESTION_TIMER] = SetTimerEx("HidePlayerSuggestion", time, false, "d", playerid);
}

stock ShowPlayerBox(playerid, const string[], time = SECONDS(5), admin_message = 0)
{
	if (PlayerData[playerid][BOX_SHOW])
	{
	    PlayerTextDrawBoxColor(playerid, PlayerData[playerid][TEXT_DRAW][6], COLOR_WHITE),
	    PlayerTextDrawHide(playerid, PlayerData[playerid][TEXT_DRAW][6]),
	    KillTimer(PlayerData[playerid][BOX_TIMER]);
	}

	if (admin_message) // Si es para un administrador
	{
	    if (admin_message == 1) PlayerTextDrawBoxColor(playerid, PlayerData[playerid][TEXT_DRAW][6], COLOR_DOUBTS_TWO);
	    else if (admin_message == 2) PlayerTextDrawBoxColor(playerid, PlayerData[playerid][TEXT_DRAW][6], COLOR_REPORTS_TWO);
	}

	PlayerTextDrawSetString(playerid, PlayerData[playerid][TEXT_DRAW][6], Desbug(string)),
	PlayerTextDrawShow(playerid, PlayerData[playerid][TEXT_DRAW][6]);

	PlayerData[playerid][BOX_SHOW] = true;
	return PlayerData[playerid][BOX_TIMER] = SetTimerEx("HidePlayerBox", time, false, "d", playerid);
}

stock ShowPlayerInfo(playerid, const string[], time = SECONDS(5), information = 0)
{
	InformationShowing[playerid] = information;

	if (PlayerData[playerid][INFO_SHOW])
	{
	    PlayerTextDrawHide(playerid, PlayerData[playerid][TEXT_DRAW][4]);
	    KillTimer(PlayerData[playerid][INFO_TIMER]);
	}

	PlayerTextDrawSetString(playerid, PlayerData[playerid][TEXT_DRAW][4], Desbug(string));
	PlayerTextDrawShow(playerid, PlayerData[playerid][TEXT_DRAW][4]);

	PlayerData[playerid][INFO_SHOW] = true;

	if (time != STATIC_DRAW)
	{
		PlayerData[playerid][INFO_TIMER] = SetTimerEx("HidePlayerInfo", time, false, "d", playerid);
	}
	return true;
}

stock PlayerPlaySoundEx(playerid, sound)
{
	static
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);

    foreach (new i : Player)
	{
		if (SQL_IsLogged(i) && IsPlayerInRangeOfPoint(i, 20.0, x, y, z))
		{
		    PlayerPlaySound(i, sound, x, y, z);
		}
	}
	return true;
}

stock IsValidEmail (const email[])
{
	new
		Name@Dominio = -1,
		Point0 = -1,
		Point1 = -1,
		Leght = strlen (email);

	if (Leght < 8 || Leght > 34) return false;

	for (new i; i < Leght; i++)
	{
	    switch (email[i])
	    {
	        case '@':
	        {
		        if (Name@Dominio != -1)
		            return false;

				if (i < 2 || i > 30)
				    return false;

				Name@Dominio = i;
			}
			case '.':
			{
			    if (Name@Dominio != -1)
			    {
				    if (Name@Dominio + 3 > i || i < 10)
				        return false;

					if (Point0 == -1) Point0 = i;
					else
					{
					    if (Point1 != -1)
	        				return false;

						Point1 = i;
					}
				}
			}
			case '0' .. '9', 'a' .. 'z', 'A' .. 'Z', '_', '+', '-':
			{
		        if (Name@Dominio == -1)
				{
				    if (i > 20) return false;
				}
			}
			default:
			{
			    return false;
			}
	    }
	}

	if (Name@Dominio == -1 || Point0 == -1)
	    return false;

	return true;
}

stock static Load_Animations(playerid)
{
	for (new i = 0; i < sizeof (AnimationLibraries); i ++)
 	{
  		ApplyAnimation(playerid, AnimationLibraries[i], "null", 0.0, 0, 0, 0, 0, 0);
    }
}

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}

stock SendClientMessageToAllEx(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.pri args
		#emit ADD.C 4
		#emit PUSH.pri
		#emit SYSREQ.C format

        #emit LCTRL 5
		#emit SCTRL 4

	    foreach (new i : Player)
		{
			if (SQL_IsLogged(i) && PlayerData[i][CREATED])
			{
				SendClientMessage(i, color, string);
			}
		}
		return true;
	}
	return SendClientMessageToAll(color, str);
}

stock SendNearbyMessage(playerid, Float:radius, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 16)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 16); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit SUB
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

	    foreach (new i : Player)
		{
			if (IsPlayerNearPlayer(i, playerid, radius) && SQL_IsLogged(i))
			{
  				SendClientMessage(i, color, string);
			}
		}
		return true;
	}
	
    foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius) && SQL_IsLogged(i))
		{
			SendClientMessage(i, color, str);
		}
	}
	return true;
}

stock SendOwnerAlert(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

	    foreach (new i : Player)
		{
			if (PlayerData[i][ADMIN_LEVEL] >= 9 && SQL_IsLogged(i))
			{
  				SendClientMessage(i, color, string);
			}
		}
		return true;
	}
	
    foreach (new i : Player)
	{
		if (PlayerData[i][ADMIN_LEVEL] >= 9 && SQL_IsLogged(i))
		{
   			SendClientMessage(i, color, str);
		}
	}
	return true;
}

stock SendAdminAlert(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

	    foreach (new i : Player)
		{
			if (PlayerData[i][ADMIN_LEVEL] >= 1 && !PlayerData[i][ADMIN_DISABLE] && SQL_IsLogged(i))
			{
  				SendSplitMessage(i, color, string);
			}
		}
		return true;
	}
	
    foreach (new i : Player)
	{
		if (PlayerData[i][ADMIN_LEVEL] >= 1 && !PlayerData[i][ADMIN_DISABLE] && SQL_IsLogged(i))
		{
			SendSplitMessage(i, color, str);
		}
	}
	return true;
}

SendSplitMessage(playerid, color, const text[])
{
	#define LENGHT (348)

	if (strlen(text) > LENGHT)
	{
		new
			FirstString[LENGHT * 3],
			SecondString[LENGHT * 3];

		strmid(FirstString, text, 0, LENGHT);
		strmid(SecondString, text, LENGHT - 1, LENGHT * 2);

		format(FirstString, LENGHT, "%s", FirstString);
		format(SecondString, LENGHT, "... %s", SecondString);

		SendClientMessage(playerid, color, FirstString);
		SendClientMessage(playerid, color, SecondString);
	}
	else SendClientMessage(playerid, color, text);

	#undef LENGHT

	return true;
}

stock SendClientMessageEx(playerid, color, const text[], {Float, _}:...)
{
	static
	    args,
	    str[144];

	if ((args = numargs()) == 3)
	{
	    SendClientMessage(playerid, color, text);
	}
	else
	{
		while (--args >= 3)
		{
			#emit LCTRL 5
			#emit LOAD.alt args
			#emit SHL.C.alt 2
			#emit ADD.C 12
			#emit ADD
			#emit LOAD.I
			#emit PUSH.pri
		}
		
		#emit PUSH.S text
		#emit PUSH.C 144
		#emit PUSH.C str
		#emit PUSH.S 8
		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		SendClientMessage(playerid, color, str);

		#emit RETN
	}
	return true;
}

stock Log_Write(const path[], const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    File:file,
	    string[1024];
	    
	if ((start = strfind(path, "/")) != -1)
	{
	    strmid(string, path, 0, start + 1);

	    if (!fexist(string))
     		return printf("[error] La carpeta %s no existe.", string);
	}
	
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	file = fopen(path, io_append);

	if (!file)
	    return false;

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		
		#emit PUSH.S str
		#emit PUSH.C 1024
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		fwrite(file, string);
		fwrite(file, "\r\n");
		fclose(file);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	
	fwrite(file, str);
	fwrite(file, "\r\n");
	fclose(file);

	return true;
}

SQL_Connect()
{
    new
		File:file_handle = fopen("SQL.txt", io_read),
		buf[20 * 4 + 1],
		mysql_host[32],
		mysql_user[10],
		mysql_database[32],
		mysql_password[64];

    if (!fexist("SQL.txt")) print("Debes crear SQL.txt en scriptfiles.");
    else
    {
        fread(file_handle, buf);
        
        sscanf(buf, "p<,>s[20]s[20]s[20]s[20]", mysql_host, mysql_user, mysql_database, mysql_password);
        
        fclose(file_handle);

        printf("\n\n\t=============================\n\
			\t Conexión:\t%s\n\
			\t Usuario:\t%s\n\
			\t Base de datos:\t%s\n\
			\t Contraseña:\t%s\n\
			\t=============================\n\n",
			mysql_host,
			mysql_user,
			mysql_database,
			mysql_password);
    }

	SQL_CONNECTION = mysql_connect(mysql_host, mysql_user, mysql_database, mysql_password);
	
	if (mysql_errno(SQL_CONNECTION) != 0) DataConnect = 0;
	else DataConnect = 1;
}

main()
{
	if (DataConnect == 1) printf("\tConexión establecida. "PROJECT" %s.\n", SERVER_VERSION);
	else if (DataConnect == 0) print("\tNo se pudo establecer conexión.\n");
}

timer Update_Points[500]()
{
    foreach (new playerid : Player)
    {
		if (!IsPlayerPaused(playerid))
		{
		    /* Información en pantalla: checkpoints */
			if (PlayerData[playerid][KILLED] != 1)
		 	{
				static
					id = -1;
					
				if ((id = Machine_Nearest(playerid)) != -1)
				{
				    SetPlayerCheckpoint(playerid, vendingMachineData[id][VENDING_MACHINE_FRONT_X], vendingMachineData[id][VENDING_MACHINE_FRONT_Y],
						vendingMachineData[id][VENDING_MACHINE_Z], 1.0);
				}
				else Cancel_Showing(playerid);
			}
		}
	}
	return true;
}

timer Update_Info[500]()
{
    foreach (new playerid : Player)
    {
		/* Dinero */
		if (GetPlayerMoney(playerid) != PlayerData[playerid][MONEY])
			ResetPlayerMoney(playerid), GivePlayerMoney(playerid, PlayerData[playerid][MONEY]);
				
		if (!IsPlayerPaused(playerid))
		{
		    /* Información en pantalla: textdraws y checkpoints */
			if (PlayerData[playerid][KILLED] != 1)
		 	{
				static
					id = -1;
					
				if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
				{

				}
				else
				{
					if ((id = Car_Nearest(playerid)) != -1 && GetVehicleKeys(playerid, id) && CarData[id][carLOCKED])
					{
						if (GetVehicleVirtualWorld(CarData[id][carVEHICLE]) == GetPlayerVirtualWorld(playerid) && !Dialog_Opened(playerid))
						{
							ShowPlayerInfo(playerid, "Pulsa ESPACIO + ~k~~GROUP_CONTROL_BWD~ para destrabar.", STATIC_DRAW, true);
						}
					}
				    else Cancel_Showing(playerid);
				}
			}
		}
	}
	return true;
}

timer Update_Second[SECONDS(1)]()
{
    foreach (new playerid : Player)
    {
		if (!IsPlayerPaused(playerid))
		{
		    if (PlayerData[playerid][ADMIN_DUTY]) PlayerData[playerid][ADMIN_DUTY_TIME] ++;
		}
	}
	
 	for (new i = 0; i != MAX_TOLLS; i++)
	{
		if (TollData[i][tollOpenTime] < 1) continue;

		TollData[i][tollOpenTime] --;
		
		if (TollData[i][tollOpenTime] == 1) Toll_CloseToll(i);
	}
	return true;
}

public OnVehicleDeath(vehicleid)
{
 	CarData[Car_GetID(vehicleid)][carDAMAGE] = 300;
	Car_Save(Car_GetID(vehicleid));

	RespawnVehicle(vehicleid);
	return true;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    CurrentCarSave(playerid);
	return true;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if (IsPlayerNPC(playerid))
	    return true;

	if (oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER) // Cuando se baja de un vehículo
	{
 	    if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
	        return RemoveFromVehicle(playerid);

		Hide_Speedometer(playerid);
	}

	if ((newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)) // Cuando se sube a un vehículo
	{
 		new
	    	vehicleid = GetPlayerVehicleID(playerid);
	    	
	    if (IsSpeedoVehicle(vehicleid) && IsEngineVehicle(vehicleid) && GetEngineStatus(vehicleid))
	    {
			Show_Speedometer(playerid);
		}
 	}
 	return true;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	/* Cerradura de vehículos */
	if (PRESSED(KEY_SPRINT | KEY_CTRL_BACK) || PRESSED(KEY_HANDBRAKE | KEY_CROUCH))
 	{
 		static
 			id = -1;

		if ((id = Car_Nearest(playerid)) != -1 && GetVehicleVirtualWorld(CarData[id][carVEHICLE]) == GetPlayerVirtualWorld(playerid))
		{
			static
				engine,
				lights,
				alarm,
				doors,
				bonnet,
				boot,
				objective;

			new
				v[64],
				b[64];

			GetVehicleParamsEx(CarData[id][carVEHICLE], engine, lights, alarm, doors, bonnet, boot, objective);

			if (GetVehicleKeys(playerid, id))
			{
				if (!CarData[id][carLOCKED])
				{
					if (PlayerData[playerid][IS_LIGHTS_CAR] == 0) SetTimerEx("CarLights", 125, false, "ii", playerid, CarData[id][carVEHICLE]);

					if (!IsABike(CarData[id][carVEHICLE]))
					{
						format(v, sizeof(v), "~w~%s trabado.", ReturnVehicleName(CarData[id][carVEHICLE], 2));
						format(b, sizeof(b), "* trabó las puertas del %s. *", ReturnVehicleName(CarData[id][carVEHICLE], 1));

						SetPlayerChatBubble(playerid, b, COLOR_PURPLE, TAG_DISTANCE, SECONDS(3));
					}
					else
					{
						format(v, sizeof(v), "~w~%s con seguro.", ReturnVehicleName(CarData[id][carVEHICLE], 2));
						format(b, sizeof(b), "* aseguró su %s. *", ReturnVehicleName(CarData[id][carVEHICLE], 1));

						SetPlayerChatBubble(playerid, b, COLOR_PURPLE, TAG_DISTANCE, SECONDS(3));
					}

					HidePlayerInfo(playerid),
					GameTextForPlayer(playerid, Desbug(v), SECONDS(1), 3);

					CarData[id][carLOCKED] = true,
					CarData[id][carTIME_FADING] = 0,
					Car_Save(id);

					SetVehicleParamsEx(CarData[id][carVEHICLE], engine, lights, alarm, 1, bonnet, boot, objective);

					return true;
				}
				else if (CarData[id][carLOCKED])
				{
					if (PlayerData[playerid][IS_LIGHTS_CAR] == 0) SetTimerEx("CarLights", 125, false, "ii", playerid, CarData[id][carVEHICLE]);

					if (!IsABike(CarData[id][carVEHICLE]))
					{
						format(v, sizeof(v), "~w~%s destrabado.", ReturnVehicleName(CarData[id][carVEHICLE], 2));
						format(b, sizeof(b), "* destrabó las puertas del %s. *", ReturnVehicleName(CarData[id][carVEHICLE], 1));

						SetPlayerChatBubble(playerid, b, COLOR_PURPLE, TAG_DISTANCE, SECONDS(3));
					}
					else
					{
						format(v, sizeof(v), "~w~%s sin seguro.", ReturnVehicleName(CarData[id][carVEHICLE], 2));
						format(b, sizeof(b), "* le sacó el seguro a su %s. *", ReturnVehicleName(CarData[id][carVEHICLE], 1));

						SetPlayerChatBubble(playerid, b, COLOR_PURPLE, TAG_DISTANCE, SECONDS(3));
					}

					HidePlayerInfo(playerid),
					GameTextForPlayer(playerid, Desbug(v), SECONDS(1), 3);

					CarData[id][carLOCKED] = false,
					CarData[id][carTIME_FADING] = 0,
					Car_Save(id);

					SetVehicleParamsEx(CarData[id][carVEHICLE], engine, lights, alarm, 0, bonnet, boot, objective);
					return true;
				}
			}
		}
	}
	return true;
}

public OnGameModeInit()
{
	SQL_Connect(),
    AMX();

    SetMaxConnections(3, e_FLOOD_ACTION_BAN);
    
    /* Timer´s generales */
    repeat Update_Points();
    repeat Update_Info();
    repeat Update_Second();
    
 	/* Configuración de SA:MP */
    ManualVehicleEngineAndLights();
	DisableInteriorEnterExits();
	
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
	EnableVehicleFriendlyFire();
	
	EnableStuntBonusForAll(false);
	AllowInteriorWeapons(true);

	ShowNameTags(true);
	SetNameTagDrawDistance(TAG_DISTANCE);

	/* General */
	SetGameModeText(SERVER_TYPE);
	SendRconCommand("hostname "SERVER_NAME"");
	SendRconCommand("mapname "SERVER_MAP"");
	SendRconCommand("language "SERVER_LANG"");
	SendRconCommand("weburl "SERVER_WEB"");
	SendRconCommand("rcon_password "SERVER_RCON"");
	SendRconCommand("gravity 0.010");
	
	/* Límites */
	SendRconCommand("messageholelimit 3500");
	SendRconCommand("ackslimit 4500");
	SendRconCommand("messageslimit 1500");
	SendRconCommand("minconnectiontime 0");
	SendRconCommand("connseedtime 250000");
	SendRconCommand("playertimeout 8500");
	
	/* RakNet */
	SendRconCommand("conncookies 0");
	SendRconCommand("cookielogging 0");
    SendRconCommand("sleep 5");

	/* Streamer */
	SendRconCommand("stream_distance 300.0");
	SendRconCommand("stream_rate 1000");
	Streamer_TickRate(75);

 	if (mysql_errno(SQL_CONNECTION) != 0) 
 		return SendRconCommand("password 1"SERVER_VERSION"");
 	
 	mysql_tquery(SQL_CONNECTION, "SELECT * FROM `cars`", "Car_Load", "");
 	
 	Maps_Create();
	return true;
}

public OnGameModeExit()
{
	foreach (new playerid : Player)
	{
	    if (IsPlayerConnected(playerid)) 
	    	TerminateConnection(playerid);
	}
	
	mysql_close(SQL_CONNECTION);
	
	stop Update_Points();
	stop Update_Info();
	stop Update_Second();
	return true;
}

Check_Account(playerid)
{
	new
	    query[128];

    format(query, sizeof(query), "SELECT `LASTLOGIN_TIMESTAMP` FROM `accounts` WHERE `NAME` = '%s'", PlayerName(playerid));
	mysql_tquery(SQL_CONNECTION, query, "OnQueryFinished", "dd", playerid, THREAD_CHECK_ACCOUNT);
}

Attempt_Login(playerid, const password[])
{
	new
		query[300],
		buffer[129];

	WP_Hash(buffer, sizeof(buffer), password);

	format(query, sizeof(query), "SELECT `SQL_ID` FROM `accounts` WHERE `NAME` = '%s' AND `PASSWORD` = '%s'", PlayerName(playerid), buffer);
    mysql_tquery(SQL_CONNECTION, query, "OnQueryFinished", "dd", playerid, THREAD_LOGIN);
}

Reset_Email(playerid)
{
	static
		query[161];

	format(query, sizeof(query), "UPDATE `accounts` SET `EMAIL` = '...' WHERE `NAME` = '%s'", PlayerData[playerid][NAME]);
	mysql_tquery(SQL_CONNECTION, query);

	Dialog_Show(playerid, CreateEmail, DIALOG_STYLE_INPUT, ""COL_TITLE"Regístrate (2/4)",
		""COL_CONTENT"Ingresa una dirección de correo electrónico.\n\n\
 		"COL_CONTENT_TWO"La dirección debe ser "COL_TOMATO"nombre@dominio.tipo"COL_CONTENT".", "Siguiente", "");
}

SendPlayerToPlayer(playerid, targetid)
{
	static
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(targetid, x, y, z);

	if (IsPlayerInAnyVehicle(playerid))
	{
	    SetVehiclePos(GetPlayerVehicleID(playerid), x, y + 2, z);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(targetid));
	}
	else
		SetPlayerPos(playerid, x + 1, y, z);

	SetPlayerInterior(playerid, GetPlayerInterior(targetid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));

	PlayerData[playerid][HOUSE] = PlayerData[targetid][HOUSE];
	PlayerData[playerid][BUSINESSES] = PlayerData[targetid][BUSINESSES];
	PlayerData[playerid][ENTRANCE] = PlayerData[targetid][ENTRANCE];
}

stock SetDefaultSpawn(playerid)
{
	SetPlayerPos(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z),
	SetPlayerFacingAngle(playerid, SPAWN_ANGLE);

	SetPlayerInterior(playerid, 0),
	SetPlayerVirtualWorld(playerid, 0),
	TogglePlayerControllable(playerid, true);
	return true;
}

Dialog:RegisterScreen(playerid, response, listitem, inputtext[])
{
	if (!response) Kick(playerid);
	else if (strlen(inputtext) < MIN_PASSWORD_LENGTH || isnull(inputtext) || strlen(inputtext) > MAX_PASSWORD_LENGTH)
	{
 		new
		 	content[256],
 		    title[64];
 		    
		format(content, sizeof(content), FORMAT_REGISTER_ERROR, MIN_PASSWORD_LENGTH, MAX_PASSWORD_LENGTH);
		format(title, sizeof(title), ""COL_TITLE"Oops. Hola, %s. Regístrate (1/4)", PlayerName(playerid));
		
   		Dialog_Show(playerid, RegisterScreen, DIALOG_STYLE_INPUT, title, content, "Registrar", "");
	}
	else
	{
	 	new buffer[129];
		WP_Hash(buffer, sizeof(buffer), inputtext);

		static
			query[512];

		format(query, sizeof(query), "INSERT INTO `accounts` (`NAME`, `PASSWORD`, `REGISTER_TIMESTAMP`, `LASTLOGIN_TIMESTAMP`) VALUES('%s', '%s', '%s', '%s')",
			PlayerName(playerid),
			buffer,
			ReturnDate(),
			ReturnDate()
		);

		mysql_tquery(SQL_CONNECTION, query, "OnQueryFinished", "dd", playerid, THREAD_CREATE_CHAR);
	}
	return true;
}

Dialog:CreateEmail(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		if (!IsValidEmail(inputtext))
		{
  	    	Dialog_Show(playerid, CreateEmail, DIALOG_STYLE_INPUT, ""COL_TITLE"Oops. Regístrate (2/4)", ""COL_CONTENT"La dirección que ingresaste no es válida.\n\n\
				"COL_CONTENT_TWO"La dirección debe ser "COL_TOMATO"nombre@dominio.tipo"COL_CONTENT_TWO". Inténtalo nuevamente"COL_CONTENT"...", "Siguiente", "");
				
			return true;
		}

		static
			query[128];
			
		format(query, sizeof(query), "SELECT `NAME` FROM `accounts` WHERE `EMAIL` = '%s'", inputtext);
		mysql_tquery(SQL_CONNECTION, query, "OnEmailCheck", "ds", playerid, inputtext);
	}
	else Kick(playerid);
	return true;
}

Dialog:ConfirmEmail(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new
			list[2 + (sizeof(SecurityQuestions) * MAX_SECURITY_QUESTION_SIZE)];

        strcat(list, "Escoge una pregunta de seguridad\n");
        
		for (new i; i < sizeof(SecurityQuestions); i++)
		{
		    strcat(list, SecurityQuestions[i]);
		    strcat(list, "\n");
		}
		
		Dialog_Show(playerid, SelectQuestion, DIALOG_STYLE_TABLIST_HEADERS, ""COL_TITLE"Regístrate (3/4)", list, "Siguiente", "Atrás");
	}
	else Reset_Email(playerid);
	return true;
}

Dialog:SelectQuestion(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    SQL_Update_String("accounts", PlayerName(playerid), "SECURITY_QUESTION", SecurityQuestions[listitem]),
		format(PlayerData[playerid][SECURITY_QUESTION], MAX_SECURITY_QUESTION_SIZE, SecurityQuestions[listitem]);
        
		new string[310];
		format(string, sizeof(string),  ""COL_CONTENT"Escogiste \""COL_TOMATO"%s"COL_CONTENT"\",\n\
			"COL_CONTENT"esta respuesta de seguridad te servirá para recuperar la contraseña en caso de que se te olvide.\n\n\
			"COL_CONTENT_TWO"Contesta la pregunta aquí. No le des importancia a las mayúsculas y minúsculas"COL_CONTENT".",
			SecurityQuestions[listitem]
		);
		
		Dialog_Show(playerid, InsertAnswer, DIALOG_STYLE_INPUT, ""COL_TITLE"Regístrate (4/4)", string, "Siguiente", "Atrás");
	}
	else Reset_Email(playerid);
	return true;
}

Dialog:InsertAnswer(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	 	if (strlen(inputtext) < MIN_PASSWORD_LENGTH || inputtext[0] == ' ' || strlen(inputtext) > MAX_SECURITY_ANSWER_SIZE)
		{
	  		new string[310];
			format(string, sizeof(string),  ""COL_CONTENT"Escogiste \""COL_TOMATO"%s"COL_CONTENT"\",\n\
				"COL_CONTENT"esta respuesta de seguridad te servirá para recuperar la contraseña en caso de que se te olvide.\n\n\
				"COL_CONTENT_TWO"La respuesta debe ser "COL_TOMATO"mayor a %d caracteres"COL_CONTENT_TWO" y "COL_TOMATO"menor a %d caracteres"COL_CONTENT".",
				PlayerData[playerid][SECURITY_QUESTION],
				MIN_PASSWORD_LENGTH,
				MAX_PASSWORD_LENGTH
			);
			
			Dialog_Show(playerid, InsertAnswer, DIALOG_STYLE_INPUT, ""COL_TITLE"Oops. Regístrate (4/4)", string, "Terminar", "Atrás");
			return true;
		}
		else
		{
		  	for (new i, j = strlen(inputtext); i < j; i++)
			{
		        inputtext[i] = tolower(inputtext[i]);
			}
			
			SQL_Update_String("accounts", PlayerName(playerid), "SECURITY_ANSWER", inputtext),
		    format(PlayerData[playerid][SECURITY_ANSWER], MAX_SECURITY_ANSWER_SIZE, inputtext);
		    
      		new content[485];
			format(content, sizeof(content), ""COL_CONTENT"Listo. Has terminado de configurar tu cuenta y está lista,\n\
				lo siguiente es modelar las características de "COL_SERVER"%s"COL_CONTENT".\n\
				\n"COL_CONTENT_TWO"Si hay algo que sientas que tienes modificar, pulsa "COL_TOMATO"atrás"COL_CONTENT_TWO". De lo contrario, empecemos"COL_CONTENT"...",
				PlayerName(playerid)
			);

			Dialog_Show(playerid, FinishRegister, DIALOG_STYLE_MSGBOX, ""COL_TITLE"Tu cuenta ya está lista", content, "Empezar", "Atrás");
		}
	}
	else
	{
	 	static
			query[161];

		format(query, sizeof(query), "UPDATE `accounts` SET `SECURITY_ANSWER` = '...' WHERE `NAME` = '%s'", PlayerData[playerid][NAME]);
		mysql_tquery(SQL_CONNECTION, query);
		
 		new
			list[2 + (sizeof(SecurityQuestions) * MAX_SECURITY_QUESTION_SIZE)];

        strcat(list, "Escoge una pregunta de seguridad\n");
        
		for (new i; i < sizeof(SecurityQuestions); i++)
		{
		    strcat(list, SecurityQuestions[i]);
		    strcat(list, "\n");
		}

		Dialog_Show(playerid, SelectQuestion, DIALOG_STYLE_TABLIST_HEADERS, ""COL_TITLE"Regístrate (3/4)", list, "Siguiente", "Atrás");
	}
	return true;
}

Dialog:FinishRegister(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	  	SetTimerEx("FadeOut", DELAY, false, "idi", playerid, 0, 0),
		DynamicTimer[playerid][TIMER_REGISTER] = SetTimerEx("StepRegister", SECONDS(3), false, "i", playerid);
	}
	else
	{
 	 	static
			query[161];

		format(query, sizeof(query), "UPDATE `accounts` SET `SECURITY_ANSWER` = '...' WHERE `NAME` = '%s'", PlayerData[playerid][NAME]);
		mysql_tquery(SQL_CONNECTION, query);

		new string[310];
		format(string, sizeof(string),  ""COL_CONTENT"Escogiste \""COL_TOMATO"%s"COL_CONTENT"\",\n\
			"COL_CONTENT"esta respuesta de seguridad te servirá para recuperar la contraseña en caso de que se te olvide.\n\n\
			"COL_CONTENT_TWO"Contesta la pregunta aquí. No le des importancia a las mayúsculas o minúsculas"COL_CONTENT".",
			PlayerData[playerid][SECURITY_QUESTION]
		);

		Dialog_Show(playerid, InsertAnswer, DIALOG_STYLE_INPUT, ""COL_TITLE"Regístrate (4/4)", string, "Siguiente", "Atrás");
	}
	return true;
}

Dialog:Gender(playerid, response, listitem, inputtext[])
{
	if (response) PlayerData[playerid][GENDER] = 1;
	else if (!response) PlayerData[playerid][GENDER] = 2;

	Dialog_Show(playerid, DateBirth, DIALOG_STYLE_INPUT, ""COL_TITLE"Configuración (2/3)",
		""COL_CONTENT"Escoge una fecha de nacimiento para tu personaje.\n\n\
		"COL_CONTENT_TWO"Debes usar el formato "COL_TOMATO"20/09/2000"COL_CONTENT".", "Siguiente", "Atrás");

	return true;
}

Dialog:DateBirth(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new
			iDay,
			iMonth,
			iYear;

	    static const MonthDays[] =
		{
			31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
		};

	    if (sscanf(inputtext, "p</>ddd", iDay, iMonth, iYear))
		{
			Dialog_Show(playerid, DateBirth, DIALOG_STYLE_INPUT, ""COL_TITLE"Configuración (2/3)",
				""COL_CONTENT"Escoge una fecha de nacimiento para tu personaje.\n\n\
				"COL_CONTENT_TWO"El formato que usaste está mal. Debe ser, por ejemplo "COL_TOMATO"20/09/2000"COL_CONTENT".", "Siguiente", "Atrás");
            return true;
		}
		else if (iYear < 1900 || iYear > 2005)
		{
			Dialog_Show(playerid, DateBirth, DIALOG_STYLE_INPUT, ""COL_TITLE"Configuración (2/3)",
				""COL_CONTENT"Escoge una fecha de nacimiento para tu personaje.\n\n\
				"COL_CONTENT_TWO"El formato está mal. El año "COL_TOMATO"debe ser desde 1900 hasta 2005"COL_CONTENT".", "Siguiente", "Atrás");
            return true;
		}
		else if (iMonth < 1 || iMonth > 12)
		{
			Dialog_Show(playerid, DateBirth, DIALOG_STYLE_INPUT, ""COL_TITLE"Configuración (2/3)",
				""COL_CONTENT"Escoge una fecha de nacimiento para tu personaje.\n\n\
				"COL_CONTENT_TWO"El formato está mal. El mes "COL_TOMATO"debe ser desde 1 hasta 12"COL_CONTENT".", "Siguiente", "Atrás");
            return true;
		}
		else if (iDay < 1 || iDay > MonthDays[iMonth - 1])
		{
  			Dialog_Show(playerid, DateBirth, DIALOG_STYLE_INPUT, ""COL_TITLE"Configuración (2/3)",
				""COL_CONTENT"Escoge una fecha de nacimiento para tu personaje.\n\n\
				"COL_CONTENT_TWO"Algunos meses (como ese) "COL_TOMATO"no tienen tantos días"COL_CONTENT_TWO". Vamos otra vez:", "Siguiente", "Atrás");
			return true;
		}

		format(PlayerData[playerid][BIRTHDATE], 24, inputtext);
		
	  	new
		    dialog[127];

		if (PlayerData[playerid][GENDER] == 1)
		{
			for (new i = 0, j = sizeof(MasculineClothes); i < j; i++)
			{
				format(dialog, sizeof(dialog), "%s%i\n\n", dialog, MasculineClothes[i]);
			}
		}
		else
		{
	 		for (new i = 0, j = sizeof(FemenineClothes); i < j; i++)
			{
				format(dialog, sizeof(dialog), "%s%i\n\n", dialog, FemenineClothes[i]);
			}
		}

	    ShowPlayerDialog(playerid, MODEL_SELECTION_REGISTER, DIALOG_STYLE_PREVIEW_MODEL, Desbug("Configuración (3/3)"), dialog, "Terminar", Desbug("Atrás"));
	}
	else
	{
	    Dialog_Show(playerid, Gender, DIALOG_STYLE_MSGBOX, ""COL_TITLE"Configuración (1/3)", ""COL_CONTENT"¿A qué género pertenece tu personaje?", "Masculino", "Femenino");
	}
	
	return true;
}

Dialog:LoginScreen(playerid, response, listitem, inputtext[])
{
	if (!response) Kick(playerid);
	else if (isnull(inputtext))
	{
	    new
			content[256],
			title[64];

	    format(content, sizeof(content), FORMAT_LOGIN_ERROR, PlayerData[playerid][LASTLOGIN_TIMESTAMP], LoginAttempts[playerid], MAX_LOGIN_ATTEMPTS);
	    format(title, sizeof(title), ""COL_TITLE"Oops. Hola, %s", PlayerName(playerid));

		Dialog_Show(playerid, LoginScreen, DIALOG_STYLE_PASSWORD, title, content, "Ingresar", "");
	}
	else Attempt_Login(playerid, inputtext);
	return true;
}

AdminOnlineCheck()
{
	new
		count;

    foreach (new i : Player)
	{
 		if (SQL_IsLogged(i))
		{
			if (PlayerData[i][ADMIN_LEVEL] >= 1)
			{
				count++;
			}
		}
	}
	return count;
}

stock Load_Objects(playerid)
{
	TogglePlayerControllable(playerid, false);
	    
	ViewLoadBar[playerid] = true;
	
	SetPlayerProgressBarValue(playerid, ProgressLoading[playerid], 0.0);
	UpdatePlayerProgressBar(playerid, ProgressLoading[playerid]);
	ShowPlayerProgressBar(playerid, ProgressLoading[playerid]);
	
	PlayerTextDrawShow(playerid, PlayerData[playerid][TEXT_DRAW][5]);
	
	return LoadingLooping(playerid);
}

stock UnLoad_Objects(playerid)
{
	TogglePlayerControllable(playerid, true);

	ViewLoadBar[playerid] = false;
	
	SetPlayerProgressBarValue(playerid, ProgressLoading[playerid], 0.0);
	UpdatePlayerProgressBar(playerid, ProgressLoading[playerid]);
 	HidePlayerProgressBar(playerid, ProgressLoading[playerid]);
 	
	return PlayerTextDrawHide(playerid, PlayerData[playerid][TEXT_DRAW][5]);
}

forward LoadingLooping(playerid);
public LoadingLooping(playerid)
{
    if (!ViewLoadBar[playerid]) return false;
    else
    {
		if (GetPlayerProgressBarValue(playerid, ProgressLoading[playerid]) < 100)
		{
		    SetTimerEx("LoadingLooping", SECONDS(1), false, "d", playerid);

	   		SetPlayerProgressBarValue(playerid, ProgressLoading[playerid], GetPlayerProgressBarValue(playerid, ProgressLoading[playerid]) + 20.0);
			UpdatePlayerProgressBar(playerid, ProgressLoading[playerid]);
		}
		else if (GetPlayerProgressBarValue(playerid, ProgressLoading[playerid]) == 100) UnLoad_Objects(playerid);
	}
	return true;
}

forward CarLights(playerid, vehicleid);
public CarLights(playerid, vehicleid)
{
    if (IsPlayerInAnyVehicle(playerid)) return false;
    else
    {
        PlayerData[playerid][IS_LIGHTS_CAR] = true;

		switch (GetLightStatus(vehicleid))
		{
	   		case true:
			{
				SetLightStatus(vehicleid, false);

				PlayerData[playerid][LIGHTS_CAR_TIMER] = SetTimerEx("@_CarOffLightsEx", 125, false, "ii", playerid, vehicleid);
			}
			case false:
			{
				SetLightStatus(vehicleid, true);

				PlayerData[playerid][LIGHTS_CAR_TIMER] = SetTimerEx("@CarOffLightsEx", 125, false, "ii", playerid, vehicleid);
			}
		}
	}
	return false;
}

forward @_CarOffLightsEx(playerid, vehicleid);
public @_CarOffLightsEx(playerid, vehicleid)
{
	PlayerData[playerid][IS_LIGHTS_CAR] = false;
 	KillTimer(PlayerData[playerid][LIGHTS_CAR_TIMER]);

	return SetLightStatus(vehicleid, true);
}

forward @CarOffLightsEx(playerid, vehicleid);
public @CarOffLightsEx(playerid, vehicleid)
{
	PlayerData[playerid][IS_LIGHTS_CAR] = false;
 	KillTimer(PlayerData[playerid][LIGHTS_CAR_TIMER]);

	return SetLightStatus(vehicleid, false);
}

forward NeedleGas(playerid, bool:create, string[], Float:value);
public NeedleGas(playerid, bool:create, string[], Float:value)
{
    if (create)
    {
		if (value >= 100.0) value = 100.0;
		if (value <= 0.0) value = 0.0;

		new
			Float:coordinates[2];
			
		coordinates[0] = floatadd(floatmul(floatcos(floatmul(floatmul(floatadd(value, -20.0), 1.8), 0.818), degrees), -20.0), 460.0);
		coordinates[1] = floatadd(floatmul(floatsin(floatmul(floatmul(floatadd(value, -20.0), 1.8), 0.818), degrees), -20.0), 427.0);
		
		PlayerTextDrawDestroy(playerid, TEXT_DRAW_NEEDLE_GAS[playerid]);
		
		TEXT_DRAW_NEEDLE_GAS[playerid] = CreatePlayerTextDraw(playerid, coordinates[0], coordinates[1], "ld_none:shoot");

		switch (GetLightStatus(GetPlayerVehicleID(playerid)))
		{
			case false:
			{
				PlayerTextDrawBackgroundColor(playerid, TEXT_DRAW_NEEDLE_GAS[playerid], COLOR_TRANSPARENCE);
				PlayerTextDrawColor(playerid, TEXT_DRAW_NEEDLE_GAS[playerid], COLOR_TEXTDRAW);
			}
			case true:
			{
   				PlayerTextDrawBackgroundColor(playerid, TEXT_DRAW_NEEDLE_GAS[playerid], COLOR_TRANSPARENCE);
				PlayerTextDrawColor(playerid, TEXT_DRAW_NEEDLE_GAS[playerid], COLOR_WHITE);
			}
		}
		
  		PlayerTextDrawFont(playerid, TEXT_DRAW_NEEDLE_GAS[playerid], 4);
		PlayerTextDrawLetterSize(playerid, TEXT_DRAW_NEEDLE_GAS[playerid], 0.500000, 1.000000);
		PlayerTextDrawSetOutline(playerid, TEXT_DRAW_NEEDLE_GAS[playerid], 0);
		PlayerTextDrawSetProportional(playerid, TEXT_DRAW_NEEDLE_GAS[playerid], 1);
		PlayerTextDrawSetShadow(playerid, TEXT_DRAW_NEEDLE_GAS[playerid], 1);
		PlayerTextDrawTextSize(playerid, TEXT_DRAW_NEEDLE_GAS[playerid], 4.000000, 4.000000);

        PlayerTextDrawShow(playerid, TEXT_DRAW_NEEDLE_GAS[playerid]);
    }
	else PlayerTextDrawDestroy(playerid, TEXT_DRAW_NEEDLE_GAS[playerid]);
    return true;
}

forward Needle0(playerid, bool:create, string[], Float:value);
public Needle0(playerid, bool:create, string[], Float:value)
{
    if (create)
    {
		if (value > 220.0) value = 220.0;
  		if (value < 0) value = 0.0;

		new
			Float:coordinates[2];

		coordinates[0] = floatadd(floatmul(floatcos(floatmul(value, 0.818), degrees), -60.0), 554.0);
		coordinates[1] = floatadd(floatmul(floatsin(floatmul(value, 0.818), degrees), -60.0), 438.0);

        PlayerTextDrawDestroy(playerid, TEXT_DRAW_NEEDLE[playerid][0]);
		
		TEXT_DRAW_NEEDLE[playerid][0] = CreatePlayerTextDraw(playerid, coordinates[0], coordinates[1], "ld_none:shoot");
		
  		switch (GetLightStatus(GetPlayerVehicleID(playerid)))
		{
			case false:
			{
				PlayerTextDrawBackgroundColor(playerid, TEXT_DRAW_NEEDLE[playerid][0], COLOR_TRANSPARENCE);
				PlayerTextDrawColor(playerid, TEXT_DRAW_NEEDLE[playerid][0], COLOR_TEXTDRAW);
			}
			case true:
			{
   				PlayerTextDrawBackgroundColor(playerid, TEXT_DRAW_NEEDLE[playerid][0], COLOR_TRANSPARENCE);
				PlayerTextDrawColor(playerid, TEXT_DRAW_NEEDLE[playerid][0], COLOR_WHITE);
			}
		}
		
		PlayerTextDrawFont(playerid, TEXT_DRAW_NEEDLE[playerid][0], 4);
		PlayerTextDrawLetterSize(playerid, TEXT_DRAW_NEEDLE[playerid][0], 0.500000, 1.000000);
		PlayerTextDrawSetOutline(playerid, TEXT_DRAW_NEEDLE[playerid][0], 0);
		PlayerTextDrawSetProportional(playerid, TEXT_DRAW_NEEDLE[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, TEXT_DRAW_NEEDLE[playerid][0], 1);
		PlayerTextDrawTextSize(playerid, TEXT_DRAW_NEEDLE[playerid][0], 4.000000, 4.000000);

        PlayerTextDrawShow(playerid, TEXT_DRAW_NEEDLE[playerid][0]);
    }
    else PlayerTextDrawDestroy(playerid, TEXT_DRAW_NEEDLE[playerid][0]);

    Needle1(playerid, create, string, value);
    return true;
}

forward Needle1(playerid, bool:create, string[], Float:value);
public Needle1(playerid, bool:create, string[], Float:value)
{
    if (create)
    {
		if (value > 220.0) value = 220.0;
  		if (value < 0) value = 0.0;

		new
			Float:coordinates[2];

		coordinates[0] = floatadd(floatmul(floatcos(floatmul(value, 0.818), degrees), -55.0), 554.0);
		coordinates[1] = floatadd(floatmul(floatsin(floatmul(value, 0.818), degrees), -55.0), 438.0);

        PlayerTextDrawDestroy(playerid, TEXT_DRAW_NEEDLE[playerid][1]);
        
		TEXT_DRAW_NEEDLE[playerid][1] = CreatePlayerTextDraw(playerid, coordinates[0], coordinates[1], "ld_none:shoot");
		
		switch (GetLightStatus(GetPlayerVehicleID(playerid)))
		{
			case false:
			{
				PlayerTextDrawBackgroundColor(playerid, TEXT_DRAW_NEEDLE[playerid][1], COLOR_TRANSPARENCE);
				PlayerTextDrawColor(playerid, TEXT_DRAW_NEEDLE[playerid][1], COLOR_TEXTDRAW);
			}
			case true:
			{
   				PlayerTextDrawBackgroundColor(playerid, TEXT_DRAW_NEEDLE[playerid][1], COLOR_TRANSPARENCE);
				PlayerTextDrawColor(playerid, TEXT_DRAW_NEEDLE[playerid][1], COLOR_WHITE);
			}
		}
		
		PlayerTextDrawFont(playerid, TEXT_DRAW_NEEDLE[playerid][1], 4);
		PlayerTextDrawLetterSize(playerid, TEXT_DRAW_NEEDLE[playerid][1], 0.500000, 1.000000);
		PlayerTextDrawSetOutline(playerid, TEXT_DRAW_NEEDLE[playerid][1], 0);
		PlayerTextDrawSetProportional(playerid, TEXT_DRAW_NEEDLE[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid,TEXT_DRAW_NEEDLE[playerid][1], 1);
		PlayerTextDrawTextSize(playerid, TEXT_DRAW_NEEDLE[playerid][1], 4.000000, 4.000000);

        PlayerTextDrawShow(playerid, TEXT_DRAW_NEEDLE[playerid][1]);
    }
    else PlayerTextDrawDestroy(playerid, TEXT_DRAW_NEEDLE[playerid][1]);

    Needle3(playerid, create, string, value);
    return true;
}

forward Needle3(playerid, bool:create, string[], Float:value);
public Needle3(playerid, bool:create, string[], Float:value)
{
    if (create)
    {
		if (value > 220.0) value = 220.0;
  		if (value < 0) value = 0.0;

		new
			Float:coordinates[2];

		coordinates[0] = floatadd(floatmul(floatcos(floatmul(value, 0.818),degrees), -50.0), 554.0);
		coordinates[1] = floatadd(floatmul(floatsin(floatmul(value, 0.818),degrees), -50.0), 438.0);

        PlayerTextDrawDestroy(playerid, TEXT_DRAW_NEEDLE[playerid][2]);
        
		TEXT_DRAW_NEEDLE[playerid][2] = CreatePlayerTextDraw(playerid, coordinates[0], coordinates[1], "ld_none:shoot");
		
		switch (GetLightStatus(GetPlayerVehicleID(playerid)))
		{
			case false:
			{
				PlayerTextDrawBackgroundColor(playerid, TEXT_DRAW_NEEDLE[playerid][2], COLOR_TRANSPARENCE);
				PlayerTextDrawColor(playerid, TEXT_DRAW_NEEDLE[playerid][2], COLOR_TEXTDRAW);
			}
			case true:
			{
   				PlayerTextDrawBackgroundColor(playerid, TEXT_DRAW_NEEDLE[playerid][2], COLOR_TRANSPARENCE);
				PlayerTextDrawColor(playerid, TEXT_DRAW_NEEDLE[playerid][2], COLOR_WHITE);
			}
		}
		
		PlayerTextDrawFont(playerid, TEXT_DRAW_NEEDLE[playerid][2], 4);
		PlayerTextDrawLetterSize(playerid, TEXT_DRAW_NEEDLE[playerid][2], 0.500000, 1.000000);
		PlayerTextDrawSetOutline(playerid, TEXT_DRAW_NEEDLE[playerid][2], 0);
		PlayerTextDrawSetProportional(playerid, TEXT_DRAW_NEEDLE[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, TEXT_DRAW_NEEDLE[playerid][2], 1);
		PlayerTextDrawTextSize(playerid, TEXT_DRAW_NEEDLE[playerid][2], 4.000000, 4.000000);

        PlayerTextDrawShow(playerid, TEXT_DRAW_NEEDLE[playerid][2]);
    }
    else PlayerTextDrawDestroy(playerid, TEXT_DRAW_NEEDLE[playerid][2]);
    return true;
}

forward HidePlayerSuggestion(playerid);
public HidePlayerSuggestion(playerid)
{
	if (!PlayerData[playerid][SUGGESTION_SHOW])
	    return false;

	PlayerData[playerid][SUGGESTION_SHOW] = false;
	return PlayerTextDrawHide(playerid, PlayerData[playerid][TEXT_DRAW][2]);
}

forward HidePlayerBox(playerid);
public HidePlayerBox(playerid)
{
	if (!PlayerData[playerid][BOX_SHOW])
	    return false;

	PlayerData[playerid][BOX_SHOW] = false;
	return PlayerTextDrawHide(playerid, PlayerData[playerid][TEXT_DRAW][6]);
}

forward HidePlayerInfo(playerid);
public HidePlayerInfo(playerid)
{
	if (!PlayerData[playerid][INFO_SHOW])
	    return false;

	PlayerData[playerid][INFO_SHOW] = false,
	InformationShowing[playerid] = 0;

	return PlayerTextDrawHide(playerid, PlayerData[playerid][TEXT_DRAW][4]);
}

forward SpawnTimer(playerid);
public SpawnTimer(playerid)
{
	new
		query[160];

	format(query, sizeof(query), "SELECT * FROM `accounts` WHERE `NAME` = '%s' LIMIT 1", PlayerName(playerid));
	mysql_tquery(SQL_CONNECTION, query, "OnQueryFinished", "dd", playerid, THREAD_LOAD_CHARACTER);
	return true;
}

forward SpawnFadeIn(playerid);
public SpawnFadeIn(playerid)
{
    SetTimerEx("FadeIn", DELAY, false, "idi", playerid, 255, 0);
    
	new message[128];
	if (PlayerData[playerid][GENDER] == 1) format(message, sizeof(message), "~w~Bienvenido ~n~~y~   %s", PlayerName(playerid));
	else format(message, sizeof(message), "~w~Bienvenida ~n~~y~   %s", PlayerName(playerid));
	GameTextForPlayer(playerid, message, SECONDS(5), 1);

    return PlayerTextDrawShow(playerid, PlayerData[playerid][TEXT_DRAW][1]);
}

forward StopChatting(playerid);
public StopChatting(playerid)
{
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);
}

forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	new Float:posx, Float:posy, Float:posz;
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;

	GetPlayerPos(playerid, oldposx, oldposy, oldposz);

    foreach (new i : Player)
	{
		if (SQL_IsLogged(i) && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)))
		{
			GetPlayerPos(i, posx, posy, posz);

			tempposx = (oldposx -posx);
			tempposy = (oldposy -posy);
			tempposz = (oldposz -posz);

			if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
			{
				SendClientMessage(i, col1, string);
			}
			else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
			{
				SendClientMessage(i, col2, string);
			}
			else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
			{
				SendClientMessage(i, col3, string);
			}
			else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
			{
				SendClientMessage(i, col4, string);
			}
			else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
			{
				SendClientMessage(i, col5, string);
			}
		}
	}
	return true;
}

forward FadeOut(playerid, A, T);
public FadeOut(playerid, A, T)
{
	PlayerTextDrawBoxColor(playerid, PlayerData[playerid][TEXT_DRAW][T], RGBToHex(0, 0, 0, A));
    PlayerTextDrawShow(playerid, PlayerData[playerid][TEXT_DRAW][T]);

  	if (A < 255) SetTimerEx("FadeOut", DELAY, false, "idi", playerid, A + 1, T);
}

forward FadeIn(playerid, A, T);
public FadeIn(playerid, A, T)
{
	PlayerTextDrawBoxColor(playerid, PlayerData[playerid][TEXT_DRAW][T], RGBToHex(0, 0, 0, A));
    PlayerTextDrawShow(playerid, PlayerData[playerid][TEXT_DRAW][T]);

  	if (A) SetTimerEx("FadeIn", DELAY, false, "idi", playerid, A - 1, T);
	else PlayerTextDrawHide(playerid, PlayerData[playerid][TEXT_DRAW][T]);
}

forward StepRegister(playerid);
public StepRegister(playerid)
{
	if (DynamicTimer[playerid][TIMER_REGISTER] != -1)
 	{
 		KillTimer(DynamicTimer[playerid][TIMER_REGISTER]);
		DynamicTimer[playerid][TIMER_REGISTER] = -1;
	}

	DestroyPlayerObject(playerid, LoginObjects[playerid][0]);
	DestroyPlayerObject(playerid, LoginObjects[playerid][1]);
	DestroyPlayerObject(playerid, LoginObjects[playerid][2]);
	DestroyPlayerObject(playerid, LoginObjects[playerid][3]);
	DestroyPlayerObject(playerid, LoginObjects[playerid][4]);

	InterpolateCameraPos(playerid, 1498.960449, -1730.459350, 26.481468, 1483.004028, -1718.053466, 21.361801, MINUTES(1));
	InterpolateCameraLookAt(playerid, 1495.949096, -1734.247314, 27.739976, 1482.951049, -1723.013061, 21.994274, MINUTES(1));

	SetTimerEx("FadeIn", DELAY, false, "idid", playerid, 255, 0);
	
	DynamicTimer[playerid][TIMER_DIALOG_REGISTER] = SetTimerEx("DialogRegister", SECONDS(2), false, "i", playerid);
	return true;
}

forward DialogRegister(playerid);
public DialogRegister(playerid)
{
	if (DynamicTimer[playerid][TIMER_DIALOG_REGISTER] != -1)
 	{
 		KillTimer(DynamicTimer[playerid][TIMER_DIALOG_REGISTER + 1]);
		DynamicTimer[playerid][TIMER_DIALOG_REGISTER] = -1;
	}

	Dialog_Show(playerid, Gender, DIALOG_STYLE_MSGBOX, ""COL_TITLE"Configuración (1/3)", ""COL_CONTENT"¿A qué género pertenece tu personaje?", "Masculino", "Femenino");
	return true;
}

forward ClearChat(playerid, lines);
public ClearChat(playerid, lines)
{
	if (IsPlayerConnected(playerid))
	{
		for (new i = 0; i < lines; i ++)
		{
			SendClientMessage(playerid, COLOR_WHITE, "");
		}
	}
	return true;
}

forward OnEmailCheck(extraid, email[]);
public OnEmailCheck(extraid, email[])
{
	if (!IsPlayerConnected(extraid))
	    return false;

	static
	    rows,
	    fields,
		query[161];

	cache_get_data(rows, fields, SQL_CONNECTION);

	new
		content[249],
 		title[64];

	if (rows)
	{
	    Dialog_Show(extraid, ConfirmEmail, DIALOG_STYLE_INPUT,
			""COL_TITLE"Oops. Regístrate (2/4)", ""COL_CONTENT"La dirección \""COL_TOMATO"%s"COL_CONTENT"\" ya está siendo usada por otra cuenta.\n\n\
			"COL_CONTENT_TWO"La dirección debe ser "COL_TOMATO"nombre@dominio.tipo"COL_CONTENT_TWO". Inténtalo nuevamente"COL_CONTENT"...", "Siguiente", "", email);
	}
	else
	{
		format(content, sizeof(content), ""COL_CONTENT"¿Es \""COL_TOMATO"%s"COL_CONTENT"\" la dirección que estará asociada con tu cuenta?", email);
		format(title, sizeof(title), ""COL_TITLE"Regístrate (2/4)", PlayerName(extraid));

  		Dialog_Show(extraid, ConfirmEmail, DIALOG_STYLE_MSGBOX, title, content, "Sí", "No");

		format(query, sizeof(query), "UPDATE `accounts` SET `EMAIL` = '%s' WHERE `NAME` = '%s'", email, PlayerName(extraid));
		mysql_tquery(SQL_CONNECTION, query);
		
		format(PlayerData[extraid][EMAIL], 64, email);
	}
	return true;
}

public OnQueryError(errorid, error[], callback[], query[], connectionHandle)
{
	switch (errorid)
	{
	    case 2003:
		{
			print("\n\t*** No se puede establecer conexión con la base de datos.\n");
		}
 	}

 	printf("\n\t*** #%d, error: %s, callback: %s & query: %s.\n", errorid, error, callback, query);
	return true;
}

forward OnQueryFinished(extraid, threadid);
public OnQueryFinished(extraid, threadid)
{
	if (!IsPlayerConnected(extraid))
  	  return false;

	new
	    rows,
	    fields;

	switch (threadid)
	{
		case THREAD_CHECK_ACCOUNT:
		{
		    cache_get_data(rows, fields, SQL_CONNECTION);

			new
				ip[18],
				update[128];
			
			GetPlayerIp(extraid, ip, sizeof ip);
			
			format(update, sizeof(update), "UPDATE `accounts` SET `IP` = '%s' WHERE `NAME` = '%s'",
				ip,
				PlayerName(extraid)
			);

			mysql_tquery(SQL_CONNECTION, update);
			
		    if (rows)
			{
			    new
			        loginDate[36];
			        
			    cache_get_row(0, 0, loginDate, SQL_CONNECTION);
				format(PlayerData[extraid][LASTLOGIN_TIMESTAMP], 36, loginDate);

			    new
					content[256],
					title[64];

			    format(content, sizeof(content), FORMAT_LOGIN, PlayerData[extraid][LASTLOGIN_TIMESTAMP], MAX_LOGIN_ATTEMPTS);
			    format(title, sizeof(title), ""COL_TITLE"Hola, %s. Ingresa", PlayerName(extraid));

		        Dialog_Show(extraid, LoginScreen, DIALOG_STYLE_PASSWORD, title, content, "Ingresar", "");
			}
			else
			{
				/* Chequear nombre inválido acá */

			    new
					content[256],
					title[64];

			    format(content, sizeof(content), FORMAT_REGISTER, MIN_PASSWORD_LENGTH, MAX_PASSWORD_LENGTH);
			    format(title, sizeof(title), ""COL_TITLE"Hola, %s. Regístrate (1/4)", PlayerName(extraid));

    			Dialog_Show(extraid, RegisterScreen, DIALOG_STYLE_INPUT, title, content, "Registrar", "");
			}
    	}
	    case THREAD_CREATE_CHAR:
	    {
	        GetPlayerIp(extraid, PlayerData[extraid][IP], 18);

	        PlayerData[extraid][SQL_ID] = cache_insert_id(SQL_CONNECTION),
	        PlayerData[extraid][LOGGED] = 1;
	        
			new
			    query[128];
			    
			format(query, sizeof(query), "SELECT `CREATED` FROM `accounts` WHERE `NAME` = '%s' LIMIT 1", PlayerData[extraid][NAME]);
			mysql_tquery(SQL_CONNECTION, query, "OnQueryFinished", "dd", extraid, THREAD_SPAWN_CHARACTER);

			Save_Character(extraid);

			PlayerData[extraid][SQL_ID] = -1,
			PlayerData[extraid][LOGGED] = 0;
	    }
    	case THREAD_LOGIN:
     	{
	      	new
	  			ip[18];

			GetPlayerIp(extraid, ip, sizeof ip),
    	    cache_get_data(rows, fields, SQL_CONNECTION);

    	    if (!rows)
    	    {
				if (++LoginAttempts[extraid] == MAX_LOGIN_ATTEMPTS)
    	        {
    	            SendWarningMessage(extraid, "Fuiste expulsado por introducir erróneamente "COL_WHITE"%d veces"COL_TOMATO" la contraseña.", MAX_LOGIN_ATTEMPTS);
    	            
					Log_Write("logs/kicks.txt", "<%s> %s fue expulsado por introducir incorrectamente la clave. IP: %s.",
						ReturnDate(),
						PlayerName(extraid),
						ip
					);
					
					return Kick(extraid);
				}
				else
				{
	    			new
						content[256],
						title[64];

				    format(content, sizeof(content), FORMAT_LOGIN_ERROR, PlayerData[extraid][LASTLOGIN_TIMESTAMP], LoginAttempts[extraid], MAX_LOGIN_ATTEMPTS);
				    format(title, sizeof(title), ""COL_TITLE"Oops. Hola, %s", PlayerName(extraid));
				    
					Dialog_Show(extraid, LoginScreen, DIALOG_STYLE_PASSWORD, title, content, "Ingresar", "");
					
					Log_Write("logs/connections.txt", "<%s> %s introducio incorrectamente la clave. IP: %s.",
						ReturnDate(),
						PlayerName(extraid),
						ip
					);
				}
			}
			else
			{
   				new
					query[128];

				format(query, sizeof(query), "SELECT * FROM `accounts` WHERE `NAME` = '%s' LIMIT 1", PlayerName(extraid));
				mysql_tquery(SQL_CONNECTION, query, "OnQueryFinished", "dd", extraid, THREAD_SPAWN_CHARACTER);

    			format(query, sizeof(query), "UPDATE `accounts` SET `LASTLOGIN_TIMESTAMP` = '%s' WHERE `NAME` = '%s'",
					ReturnDate(),
					PlayerName(extraid)
				);

				mysql_tquery(SQL_CONNECTION, query);
				
				Log_Write("logs/connections.txt", "<%s> %s (%s) ingreso correctamente desde la IP: %s.",
					ReturnDate(),
					PlayerName(extraid),
					PlayerData[extraid][NAME],
					ip
				);
			}
		}
		case THREAD_SPAWN_CHARACTER:
		{
   			new
  				created;

		    created = cache_get_field_int(0, "CREATED");

            if (created)
			{
				SetTimerEx("FadeOut", DELAY, false, "idi", extraid, 0, 0),
				SetTimerEx("SpawnTimer", SECONDS(2), false, "i", extraid);
			}
			else if (!created) SpawnTimer(extraid);
		}
		case THREAD_LOAD_CHARACTER:
		{
		    cache_get_data(rows, fields, SQL_CONNECTION);

			if (!rows) return false;

            Load_Animations(extraid);
            
			PlayerData[extraid][SQL_ID] = cache_get_field_int(0, "SQL_ID");
   			PlayerData[extraid][CREATED] = cache_get_field_int(0, "CREATED");

			PlayerData[extraid][LOGGED] = 1;

			PlayerData[extraid][SCORE] = cache_get_field_int(0, "SCORE");
			PlayerData[extraid][EXPERIENCE] = cache_get_field_int(0, "EXPERIENCE");
			PlayerData[extraid][PLAYING_MINUTES] = cache_get_field_int(0, "PLAYING_MINUTES");
			PlayerData[extraid][PLAYING_HOURS] = cache_get_field_int(0, "PLAYING_HOURS");
			PlayerData[extraid][MONEY] = cache_get_field_int(0, "MONEY");
			PlayerData[extraid][BANK_MONEY] = cache_get_field_int(0, "BANK_MONEY");
			PlayerData[extraid][SKIN] = cache_get_field_int(0, "SKIN");
   			PlayerData[extraid][GENDER] = cache_get_field_int(0, "GENDER");
   			
      		cache_get_field_content(0, "BIRTHDATE", PlayerData[extraid][BIRTHDATE], SQL_CONNECTION, 24);
      		
        	PlayerData[extraid][ADMIN_LEVEL] = cache_get_field_int(0, "ADMIN_LEVEL");
        	PlayerData[extraid][ADMIN_DUTY_TIME] = cache_get_field_int(0, "ADMIN_DUTY_TIME");
         	PlayerData[extraid][VIP_LEVEL] = cache_get_field_int(0, "VIP_LEVEL");
        	PlayerData[extraid][POSITION][0] = cache_get_field_float(0, "POSITION_X");
	        PlayerData[extraid][POSITION][1] = cache_get_field_float(0, "POSITION_Y");
	        PlayerData[extraid][POSITION][2] = cache_get_field_float(0, "POSITION_Z");
	        PlayerData[extraid][POSITION][3] = cache_get_field_float(0, "POSITION_ANGLE");
	        PlayerData[extraid][HEALTH] = cache_get_field_float(0, "HEALTH");
	        PlayerData[extraid][ARMOUR] = cache_get_field_float(0, "ARMOUR");
	        PlayerData[extraid][WORLD] = cache_get_field_int(0, "WORLD");
	        PlayerData[extraid][INTERIOR] = cache_get_field_int(0, "INTERIOR");
	        PlayerData[extraid][ENTRANCE] = cache_get_field_int(0, "ENTRANCE");
	        PlayerData[extraid][HOUSE] = cache_get_field_int(0, "HOUSE");
	        PlayerData[extraid][BUSINESSES] = cache_get_field_int(0, "BUSINESSES");
	        PlayerData[extraid][INJURED] = cache_get_field_int(0, "INJURED");
	        PlayerData[extraid][KILLED] = cache_get_field_int(0, "KILLED");
	        PlayerData[extraid][FACTION] = cache_get_field_int(0, "FACTION");
	        PlayerData[extraid][FACTION_ID] = cache_get_field_int(0, "FACTION_RANK");
			        
	        cache_get_field_content(0, "DESCRIPTION", PlayerData[extraid][DESCRIPTION], SQL_CONNECTION, 64);
			        
		    if (!PlayerData[extraid][CREATED]) Reset_Email(extraid);
   			else
   			{
   				DestroyPlayerObject(extraid, LoginObjects[extraid][0]);
			  	DestroyPlayerObject(extraid, LoginObjects[extraid][1]);
			  	DestroyPlayerObject(extraid, LoginObjects[extraid][2]);
			  	DestroyPlayerObject(extraid, LoginObjects[extraid][3]);
			  	DestroyPlayerObject(extraid, LoginObjects[extraid][4]);
			  	
				SetSpawnInfo(extraid, 1, PlayerData[extraid][SKIN], PlayerData[extraid][POSITION][0], PlayerData[extraid][POSITION][1],
					PlayerData[extraid][POSITION][2], PlayerData[extraid][POSITION][3], -1, -1, -1, -1, -1, -1);
					
				TogglePlayerSpectating(extraid, false);
				
				SetTimerEx("SpawnFadeIn", SECONDS(2), false, "i", extraid);
				
				Load_Objects(extraid);
				
 				new
					levels[21];

	            switch (PlayerData[extraid][ADMIN_LEVEL])
	            {
	                case 1: if (PlayerData[extraid][GENDER] == 1) levels = "El moderador 1"; else levels = "La moderadora 1";
	                case 2: if (PlayerData[extraid][GENDER] == 1) levels = "El moderador 2"; else levels = "La moderadora 2";
	                case 3: if (PlayerData[extraid][GENDER] == 1) levels = "El moderador 3"; else levels = "La moderadora 3";
	                case 4: if (PlayerData[extraid][GENDER] == 1) levels = "El administrador 4"; else levels = "La administradora 4";
	                case 5: if (PlayerData[extraid][GENDER] == 1) levels = "El administrador 5"; else levels = "La administradora 5";
	                case 6: if (PlayerData[extraid][GENDER] == 1) levels = "El administrador 6"; else levels = "La administradora 6";
	                case 7: if (PlayerData[extraid][GENDER] == 1) levels = "El gerente 1337"; else levels = "La gerenta 1337";
	                case 8: if (PlayerData[extraid][GENDER] == 1) levels = "El gerente 1338"; else levels = "La gerenta 1338";
	                case 9: if (PlayerData[extraid][GENDER] == 1) levels = "El propietario 1339"; else levels = "La propietaria 1339";
	                case 10: if (PlayerData[extraid][GENDER] == 1) levels = "El desarrollador"; else levels = "La desarrolladora";
	            }

   				SendAdminAlert(COLOR_ADMIN_TWO, "(( %s \"%s\" (%d) se conectó [%s administrando] ))",
			   		levels,
				   	PlayerName(extraid),
				   	extraid,
				   	GetDurationEx(PlayerData[extraid][ADMIN_DUTY_TIME])
	   			);
			}
		}
	}
	return true;
}

Create_Draws(playerid)
{
  	PlayerData[playerid][TEXT_DRAW][0] = CreatePlayerTextDraw(playerid, 644.000000, 1.000000, "_"); // Pantalla
	PlayerTextDrawFont(playerid, PlayerData[playerid][TEXT_DRAW][0], 1);
	PlayerTextDrawLetterSize(playerid, PlayerData[playerid][TEXT_DRAW][0], 0.530000, 51.000000);
	PlayerTextDrawSetProportional(playerid, PlayerData[playerid][TEXT_DRAW][0], 1);
	PlayerTextDrawSetShadow(playerid, PlayerData[playerid][TEXT_DRAW][0], 1);
	PlayerTextDrawUseBox(playerid, PlayerData[playerid][TEXT_DRAW][0], 1);
	PlayerTextDrawBoxColor(playerid, PlayerData[playerid][TEXT_DRAW][0], COLOR_TRANSPARENCE);
	PlayerTextDrawTextSize(playerid, PlayerData[playerid][TEXT_DRAW][0], -6.000000, 30.000000);
	PlayerTextDrawSetSelectable(playerid, PlayerData[playerid][TEXT_DRAW][0], 0);
	
 	PlayerData[playerid][TEXT_DRAW][1] = CreatePlayerTextDraw(playerid, 553.000000, 2.000000, "mundo-extreme.com"); // mundo-extreme.com
	PlayerTextDrawAlignment(playerid, PlayerData[playerid][TEXT_DRAW][1], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerData[playerid][TEXT_DRAW][1], 255);
	PlayerTextDrawFont(playerid, PlayerData[playerid][TEXT_DRAW][1], 0);
	PlayerTextDrawLetterSize(playerid, PlayerData[playerid][TEXT_DRAW][1], 0.569999, 2.099999);
	PlayerTextDrawColor(playerid, PlayerData[playerid][TEXT_DRAW][1], 0x789FCBFF);
	PlayerTextDrawSetOutline(playerid, PlayerData[playerid][TEXT_DRAW][1], 0);
	PlayerTextDrawSetProportional(playerid, PlayerData[playerid][TEXT_DRAW][1], 1);
	PlayerTextDrawSetShadow(playerid, PlayerData[playerid][TEXT_DRAW][1], 0);
	PlayerTextDrawSetSelectable(playerid, PlayerData[playerid][TEXT_DRAW][1], 0);

	PlayerData[playerid][TEXT_DRAW][2] = CreatePlayerTextDraw(playerid, 553.000000, 134.000000, "_"); // Cuadro para mensajes: ShowPlayerSuggestion
	PlayerTextDrawAlignment(playerid, PlayerData[playerid][TEXT_DRAW][2], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerData[playerid][TEXT_DRAW][2], 255);
	PlayerTextDrawFont(playerid, PlayerData[playerid][TEXT_DRAW][2], 1);
	PlayerTextDrawLetterSize(playerid, PlayerData[playerid][TEXT_DRAW][2], 0.250000, 1.899999);
	PlayerTextDrawColor(playerid, PlayerData[playerid][TEXT_DRAW][2], -35);
	PlayerTextDrawSetOutline(playerid, PlayerData[playerid][TEXT_DRAW][2], 0);
	PlayerTextDrawSetProportional(playerid, PlayerData[playerid][TEXT_DRAW][2], 1);
	PlayerTextDrawSetShadow(playerid, PlayerData[playerid][TEXT_DRAW][2], 0);
	PlayerTextDrawUseBox(playerid, PlayerData[playerid][TEXT_DRAW][2], 1);
	PlayerTextDrawBoxColor(playerid, PlayerData[playerid][TEXT_DRAW][2], 187);
	PlayerTextDrawTextSize(playerid, PlayerData[playerid][TEXT_DRAW][2], 0.000000, 100.000000);
	PlayerTextDrawSetSelectable(playerid, PlayerData[playerid][TEXT_DRAW][2], 0);

	PlayerData[playerid][TEXT_DRAW][3] = CreatePlayerTextDraw(playerid, 554.000000, 101.000000, "_"); // Dinero del banco
	PlayerTextDrawAlignment(playerid, PlayerData[playerid][TEXT_DRAW][3], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerData[playerid][TEXT_DRAW][3], 255);
	PlayerTextDrawFont(playerid, PlayerData[playerid][TEXT_DRAW][3], 3);
	PlayerTextDrawLetterSize(playerid, PlayerData[playerid][TEXT_DRAW][3], 0.489999, 2.100000);
	PlayerTextDrawColor(playerid, PlayerData[playerid][TEXT_DRAW][3], COLOR_WHITE);
	PlayerTextDrawSetOutline(playerid, PlayerData[playerid][TEXT_DRAW][3], 1);
	PlayerTextDrawSetProportional(playerid, PlayerData[playerid][TEXT_DRAW][3], 0);
	PlayerTextDrawSetSelectable(playerid, PlayerData[playerid][TEXT_DRAW][3], 0);
			
	PlayerData[playerid][TEXT_DRAW][4] = CreatePlayerTextDraw(playerid, 320.000000, 385.000000, "_"); // Mensajes de información: ShowPlayerInfo
	PlayerTextDrawAlignment(playerid, PlayerData[playerid][TEXT_DRAW][4], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerData[playerid][TEXT_DRAW][4], 16);
	PlayerTextDrawFont(playerid, PlayerData[playerid][TEXT_DRAW][4], 1);
	PlayerTextDrawLetterSize(playerid, PlayerData[playerid][TEXT_DRAW][4], 0.250000, 2.000000);
	PlayerTextDrawColor(playerid, PlayerData[playerid][TEXT_DRAW][4], COLOR_WHITE);
	PlayerTextDrawSetOutline(playerid, PlayerData[playerid][TEXT_DRAW][4], 0);
	PlayerTextDrawSetProportional(playerid, PlayerData[playerid][TEXT_DRAW][4], 1);
	PlayerTextDrawSetShadow(playerid, PlayerData[playerid][TEXT_DRAW][4], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerData[playerid][TEXT_DRAW][4], 0);
	
	PlayerData[playerid][TEXT_DRAW][5] = CreatePlayerTextDraw(playerid, 319.000000, 247.000000, "Cargando");
	PlayerTextDrawAlignment(playerid, PlayerData[playerid][TEXT_DRAW][5], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerData[playerid][TEXT_DRAW][5], 255);
	PlayerTextDrawFont(playerid, PlayerData[playerid][TEXT_DRAW][5], 3);
	PlayerTextDrawLetterSize(playerid, PlayerData[playerid][TEXT_DRAW][5], 0.679998, 2.499999);
	PlayerTextDrawColor(playerid, PlayerData[playerid][TEXT_DRAW][5], COLOR_WHITE);
	PlayerTextDrawSetOutline(playerid, PlayerData[playerid][TEXT_DRAW][5], 1);
	PlayerTextDrawSetProportional(playerid, PlayerData[playerid][TEXT_DRAW][5], 1);
	PlayerTextDrawSetShadow(playerid, PlayerData[playerid][TEXT_DRAW][5], 0);
	PlayerTextDrawSetSelectable(playerid, PlayerData[playerid][TEXT_DRAW][5], 0);
	
	if (ProgressLoading[playerid] == INVALID_PLAYER_BAR_ID) ProgressLoading[playerid] = CreatePlayerProgressBar(playerid, 261.00, 279.00, 116.50, 5.19, 0x789FCBFF);

 	PlayerData[playerid][TEXT_DRAW][6] = CreatePlayerTextDraw(playerid, 553.000000, 200.000000, "_"); // Cuadro para mensajes: ShowPlayerBox
	PlayerTextDrawAlignment(playerid, PlayerData[playerid][TEXT_DRAW][6], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerData[playerid][TEXT_DRAW][6], COLOR_TRANSPARENCE);
	PlayerTextDrawFont(playerid, PlayerData[playerid][TEXT_DRAW][6], 1);
	PlayerTextDrawLetterSize(playerid, PlayerData[playerid][TEXT_DRAW][6], 0.250000, 1.899999);
	PlayerTextDrawColor(playerid, PlayerData[playerid][TEXT_DRAW][6], COLOR_WHITE);
	PlayerTextDrawSetOutline(playerid, PlayerData[playerid][TEXT_DRAW][6], 0);
	PlayerTextDrawSetProportional(playerid, PlayerData[playerid][TEXT_DRAW][6], 1);
	PlayerTextDrawSetShadow(playerid, PlayerData[playerid][TEXT_DRAW][6], 0);
	PlayerTextDrawUseBox(playerid, PlayerData[playerid][TEXT_DRAW][6], 1);
	PlayerTextDrawBoxColor(playerid, PlayerData[playerid][TEXT_DRAW][6], -1);
	PlayerTextDrawTextSize(playerid, PlayerData[playerid][TEXT_DRAW][6], 0.000000, 100.000000);
	PlayerTextDrawSetSelectable(playerid, PlayerData[playerid][TEXT_DRAW][6], 0);

	/* Velocímetro */
	TEXT_DRAW_ALL[playerid][0] = CreatePlayerTextDraw(playerid, 427.000000, 394.000000, "ld_pool:ball"); // Círculo #1
	PlayerTextDrawBackgroundColor(playerid, TEXT_DRAW_ALL[playerid][0], COLOR_TRANSPARENCE);
	PlayerTextDrawFont(playerid, TEXT_DRAW_ALL[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, TEXT_DRAW_ALL[playerid][0], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, TEXT_DRAW_ALL[playerid][0], COLOR_TEXTDRAW);
	PlayerTextDrawSetOutline(playerid, TEXT_DRAW_ALL[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, TEXT_DRAW_ALL[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TEXT_DRAW_ALL[playerid][0], 1);
	PlayerTextDrawUseBox(playerid, TEXT_DRAW_ALL[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TEXT_DRAW_ALL[playerid][0], 255);
	PlayerTextDrawTextSize(playerid, TEXT_DRAW_ALL[playerid][0], 71.000000, 70.000000);

	TEXT_DRAW_ALL[playerid][1] = CreatePlayerTextDraw(playerid, 477.000000, 358.000000, "ld_pool:ball"); // Círculo #2
	PlayerTextDrawBackgroundColor(playerid, TEXT_DRAW_ALL[playerid][1], COLOR_TRANSPARENCE);
	PlayerTextDrawFont(playerid, TEXT_DRAW_ALL[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, TEXT_DRAW_ALL[playerid][1], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, TEXT_DRAW_ALL[playerid][1], COLOR_TEXTDRAW);
	PlayerTextDrawSetOutline(playerid, TEXT_DRAW_ALL[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, TEXT_DRAW_ALL[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TEXT_DRAW_ALL[playerid][1], 1);
	PlayerTextDrawUseBox(playerid, TEXT_DRAW_ALL[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, TEXT_DRAW_ALL[playerid][1], 255);
	PlayerTextDrawTextSize(playerid, TEXT_DRAW_ALL[playerid][1], 168.000000, 169.000000);

    for (new i = 0, speedo; i <= 220 && speedo <= 12; i += 20) // Números #1
    {
        new
			Float:coordinates[2],
			speedoText[10],
			value;

        value = i;

		coordinates[0] = floatadd(floatmul(floatcos(floatmul(float(value), 0.818), degrees), -71.0), 554.0);
		coordinates[1] = floatadd(floatmul(floatsin(floatmul(float(value), 0.818), degrees), -71.0), 438.0);

		format(speedoText, 9, "%d", i);

		TEXT_DRAW_SPEEDO[playerid][speedo] = CreatePlayerTextDraw(playerid, coordinates[0], coordinates[1], speedoText);
		PlayerTextDrawBackgroundColor(playerid, TEXT_DRAW_SPEEDO[playerid][speedo], COLOR_TRANSPARENCE);
		PlayerTextDrawFont(playerid, TEXT_DRAW_SPEEDO[playerid][speedo], 1);
		PlayerTextDrawLetterSize(playerid, TEXT_DRAW_SPEEDO[playerid][speedo], 0.200000, 0.799997);
		PlayerTextDrawColor(playerid, TEXT_DRAW_SPEEDO[playerid][speedo], COLOR_TEXTDRAW);
		PlayerTextDrawSetOutline(playerid, TEXT_DRAW_SPEEDO[playerid][speedo], 0);
		PlayerTextDrawSetProportional(playerid, TEXT_DRAW_SPEEDO[playerid][speedo], 1);
		PlayerTextDrawSetShadow(playerid, TEXT_DRAW_SPEEDO[playerid][speedo], 1);
		PlayerTextDrawSetSelectable(playerid, TEXT_DRAW_SPEEDO[playerid][speedo], 0);

        speedo ++;
    }

    for (new i = 0, speedo; i <= 100 && speedo < 5; i += 25) // Números #2
    {
        new
			Float:coordinates[2],
			speedoText[10],
			value;

        value = i;

		coordinates[0] = floatadd(floatmul(floatcos(floatmul(floatmul(floatadd(float(value), -20.0), 1.8), 0.818), degrees), -29.0), 460.0);
		coordinates[1] = floatadd(floatmul(floatsin(floatmul(floatmul(floatadd(float(value), -20.0), 1.8), 0.818), degrees), -29.0), 427.0);

		format(speedoText, 9, "%d", i);

		TEXT_DRAW_GAS[playerid][speedo] = CreatePlayerTextDraw(playerid, coordinates[0], coordinates[1], speedoText);
		PlayerTextDrawBackgroundColor(playerid, TEXT_DRAW_GAS[playerid][speedo], COLOR_TRANSPARENCE);
		PlayerTextDrawFont(playerid, TEXT_DRAW_GAS[playerid][speedo], 1);
		PlayerTextDrawLetterSize(playerid, TEXT_DRAW_GAS[playerid][speedo], 0.200000, 0.799997);
		PlayerTextDrawColor(playerid, TEXT_DRAW_GAS[playerid][speedo], COLOR_TEXTDRAW);
		PlayerTextDrawSetOutline(playerid, TEXT_DRAW_GAS[playerid][speedo], 0);
		PlayerTextDrawSetProportional(playerid, TEXT_DRAW_GAS[playerid][speedo], 1);
		PlayerTextDrawSetShadow(playerid, TEXT_DRAW_GAS[playerid][speedo], 1);

        speedo ++;
    }

	PlayerData[playerid][TEXT_DRAW][7] = CreatePlayerTextDraw(playerid, 559.000000, 410.000000, "_"); // Velocidad
	PlayerTextDrawAlignment(playerid, PlayerData[playerid][TEXT_DRAW][7], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerData[playerid][TEXT_DRAW][7], COLOR_TRANSPARENCE);
	PlayerTextDrawFont(playerid, PlayerData[playerid][TEXT_DRAW][7], 3);
	PlayerTextDrawLetterSize(playerid, PlayerData[playerid][TEXT_DRAW][7], 0.259999, 1.500000);
	PlayerTextDrawColor(playerid, PlayerData[playerid][TEXT_DRAW][7], COLOR_TEXTDRAW);
	PlayerTextDrawSetOutline(playerid, PlayerData[playerid][TEXT_DRAW][7], 0);
	PlayerTextDrawSetProportional(playerid, PlayerData[playerid][TEXT_DRAW][7], 1);
	PlayerTextDrawSetShadow(playerid, PlayerData[playerid][TEXT_DRAW][7], 0);
	PlayerTextDrawSetSelectable(playerid, PlayerData[playerid][TEXT_DRAW][7], 0);

	PlayerData[playerid][TEXT_DRAW][8] = CreatePlayerTextDraw(playerid, 559.000000, 425.000000, "_"); // Kilometraje
	PlayerTextDrawAlignment(playerid, PlayerData[playerid][TEXT_DRAW][8], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerData[playerid][TEXT_DRAW][8], COLOR_TRANSPARENCE);
	PlayerTextDrawFont(playerid, PlayerData[playerid][TEXT_DRAW][8], 3);
	PlayerTextDrawLetterSize(playerid, PlayerData[playerid][TEXT_DRAW][8], 0.259999, 1.500000);
	PlayerTextDrawColor(playerid, PlayerData[playerid][TEXT_DRAW][8], COLOR_TEXTDRAW);
	PlayerTextDrawSetOutline(playerid, PlayerData[playerid][TEXT_DRAW][8], 0);
	PlayerTextDrawSetProportional(playerid, PlayerData[playerid][TEXT_DRAW][8], 1);
	PlayerTextDrawSetShadow(playerid, PlayerData[playerid][TEXT_DRAW][8], 0);
	PlayerTextDrawSetSelectable(playerid, PlayerData[playerid][TEXT_DRAW][8], 0);

	PlayerData[playerid][TEXT_DRAW][9] = CreatePlayerTextDraw(playerid, 462.000000, 423.000000, "_"); // Gasolina
	PlayerTextDrawAlignment(playerid, PlayerData[playerid][TEXT_DRAW][9], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerData[playerid][TEXT_DRAW][9], COLOR_TRANSPARENCE);
	PlayerTextDrawFont(playerid, PlayerData[playerid][TEXT_DRAW][9], 3);
	PlayerTextDrawLetterSize(playerid, PlayerData[playerid][TEXT_DRAW][9], 0.209998, 1.099999);
	PlayerTextDrawColor(playerid, PlayerData[playerid][TEXT_DRAW][9], COLOR_TEXTDRAW);
	PlayerTextDrawSetOutline(playerid, PlayerData[playerid][TEXT_DRAW][9], 0);
	PlayerTextDrawSetProportional(playerid, PlayerData[playerid][TEXT_DRAW][9], 1);
	PlayerTextDrawSetShadow(playerid, PlayerData[playerid][TEXT_DRAW][9], 0);
	PlayerTextDrawSetSelectable(playerid, PlayerData[playerid][TEXT_DRAW][9], 0);

	PlayerData[playerid][TEXT_DRAW][10] = CreatePlayerTextDraw(playerid, 584.000000, 388.000000, "_"); // Advertencia
	PlayerTextDrawAlignment(playerid, PlayerData[playerid][TEXT_DRAW][10], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerData[playerid][TEXT_DRAW][10], COLOR_BLACK);
	PlayerTextDrawFont(playerid, PlayerData[playerid][TEXT_DRAW][10], 2);
	PlayerTextDrawLetterSize(playerid, PlayerData[playerid][TEXT_DRAW][10], 0.309998, 2.200000);
	PlayerTextDrawColor(playerid, PlayerData[playerid][TEXT_DRAW][10], COLOR_LIGHTRED);
	PlayerTextDrawSetOutline(playerid, PlayerData[playerid][TEXT_DRAW][10], 1);
	PlayerTextDrawSetProportional(playerid, PlayerData[playerid][TEXT_DRAW][10], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerData[playerid][TEXT_DRAW][10], 0);

	/* Fin del velocímetro */
}

public OnPlayerConnect(playerid)
{
    SetPlayerColor(playerid, COLOR_BLACK),
    EnablePlayerCameraTarget(playerid, 1);
    
    if (SQL_CONNECTION == 0) return false;
    
	new name[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);

    format(PlayerData[playerid][NAME], MAX_PLAYER_NAME + 1, name);
	
 	Data_Reset(playerid),
	Maps_Remove(playerid);
	return true;
}

public OnPlayerUpdate(playerid)
{
	if (SQL_IsLogged(playerid))
	{
	    /* Anticheat´s */
 		if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK && !PlayerData[playerid][JET_PACK])
		{
	    	SendAdminAlert(COLOR_ADMIN, "\"%s\" fue expulsado por hacer aparecer un jetpack con cheats.", PlayerName(playerid));
	    	Log_Write("logs/cheats.txt", "[%s] \"%s\" fue expulsado por hacer aparecer un jetpack con cheats.", ReturnDate(), PlayerName(playerid));
	    	
	    	Kick(playerid);
		}
		
 	   	/* Bicicleta y vehículo dañado */
   		if (IsPlayerInAnyVehicle(playerid) && (GetVehicleModel(GetPlayerVehicleID(playerid)) == 481
			|| GetVehicleModel(GetPlayerVehicleID(playerid)) == 509 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 510))
		{
			new
				Float:velocidad[3];

			GetVehicleVelocity(GetPlayerVehicleID(playerid), velocidad[0], velocidad[1], velocidad[2]);

			if (floatcmp(velocidad[2], 0.01) == 1)
			{
				SetVehicleVelocity(GetPlayerVehicleID(playerid), velocidad[0], velocidad[1], 0.0);
			}
		}
		else if (IsPlayerInAnyVehicle(playerid) && ReturnVehicleHealth(GetPlayerVehicleID(playerid)) <= 300)
		{
	 		if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
			    new
					a,
					b,
					c;

				GetPlayerKeys(playerid, a, b ,c);

			    if (a == 8 && GetVehicleSpeedToKM(playerid) >= 30)
			    {
			        new
						newspeed = GetVehicleSpeedToKM(GetPlayerVehicleID(playerid)) -30;

			    	ModifyVehicleSpeed(GetPlayerVehicleID(playerid), -newspeed);
			    }
			}
		}
		
		/* Colores */
		if (PlayerData[playerid][ADMIN_DUTY])
		{
	  		switch (PlayerData[playerid][ADMIN_LEVEL])
	  		{
	    		case 1..3: SetPlayerColor(playerid, 0xF93A2FFF);
	        	case 4..6: SetPlayerColor(playerid, 0x008E44FF);
	           	case 7..9: SetPlayerColor(playerid, 0xF8C300FF);
	           	case 10: SetPlayerColor(playerid, COLOR_DEFAULT);
   			}
		}
		
		/* Velocímetro */
   		if (IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
	 	{
	 	    if (SpeedoShowing[playerid] == 1)
			{
		       	new
					Float:speed;

 				speed = GetVehicleSpeedToSpeedo(playerid);

				Needle0(playerid, true, "_", speed), // Aguja velocímetro
				NeedleGas(playerid, true, "_", CoreVehicles[GetPlayerVehicleID(playerid)][vehFuel]); // Aguja gasolímetro

				Update_Speedometer(playerid); // Texto
			}
   		}
	}
	return true;
}

stock TerminateConnection(playerid)
{
    Save_Character(playerid),
    Data_Reset(playerid);
	return true;
}

/*Announce_GetCount(playerid)
{
	new count;

    for (new i = 0; i != MAX_ANNOUNCES; i ++)
	{
	    if (AnnounceData[i][aExists] && AnnounceData[i][aPlayer] == playerid)
	    {
	        count++;
		}
	}
	return count;
}*/

Announce_Clear(playerid)
{
    for (new i = 0; i != MAX_ANNOUNCES; i ++)
	{
	    if (AnnounceData[i][aExists] && AnnounceData[i][aPlayer] == playerid)
	    {
	        Announce_Remove(i);
		}
	}
	return true;
}

/*Announce_Add(playerid, const text[], type = 1)
{
	for (new i = 0; i != MAX_ANNOUNCES; i ++)
	{
	    if (!AnnounceData[i][aExists])
	    {
	        AnnounceData[i][aExists] = gettime();
	        AnnounceData[i][aType] = type;
	        AnnounceData[i][aPlayer] = playerid;

	        strpack(AnnounceData[i][aText], text, 128 char);
	        strpack(AnnounceData[i][aTextResume], text, 20 char);
			return i;
		}
	}
	return INVALID;
}*/

Announce_Remove(adid)
{
	if (adid != -1 && AnnounceData[adid][aExists])
	{
	    AnnounceData[adid][aExists] = false;
	    AnnounceData[adid][aPlayer] = INVALID_PLAYER_ID;
	}
	return true;
}

Doubt_GetCount(playerid)
{
	new count;

    for (new i = 0; i != MAX_DOUBTS; i ++)
	{
	    if (DoubtData[i][dExists] && DoubtData[i][dPlayer] == playerid)
	    {
	        count++;
		}
	}
	return count;
}

Doubt_Clear(playerid)
{
    for (new i = 0; i != MAX_DOUBTS; i ++)
	{
	    if (DoubtData[i][dExists] && DoubtData[i][dPlayer] == playerid)
	    {
	        Doubt_Remove(i);
		}
	}
	return true;
}

Doubt_Add(playerid, const text[], type = 1)
{
	for (new i = 0; i != MAX_DOUBTS; i ++)
	{
	    if (!DoubtData[i][dExists])
	    {
	        DoubtData[i][dExists] = true;
	        DoubtData[i][dType] = type;
	        DoubtData[i][dPlayer] = playerid;

	        strpack(DoubtData[i][dText], text, 128 char);
			return i;
		}
	}
	return INVALID;
}

Doubt_Remove(doubtid)
{
	if (doubtid != -1 && DoubtData[doubtid][dExists])
	{
	    DoubtData[doubtid][dExists] = false;
	    DoubtData[doubtid][dPlayer] = INVALID_PLAYER_ID;
	}
	return true;
}

Report_GetCount(playerid)
{
	new count;

    for (new i = 0; i != MAX_REPORTS; i ++)
	{
	    if (ReportData[i][rExists] && ReportData[i][rPlayer] == playerid)
	    {
	        count++;
		}
	}
	return count;
}

Report_Clear(playerid)
{
    for (new i = 0; i != MAX_REPORTS; i ++)
	{
	    if (ReportData[i][rExists] && ReportData[i][rPlayer] == playerid)
	    {
	        Report_Remove(i);
		}
	}
	return true;
}

Report_Add(playerid, const text[], type = 1)
{
	for (new i = 0; i != MAX_REPORTS; i ++)
	{
	    if (!ReportData[i][rExists])
	    {
	        ReportData[i][rExists] = true;
	        ReportData[i][rType] = type;
	        ReportData[i][rPlayer] = playerid;

	        strpack(ReportData[i][rText], text, 128 char);
			return i;
		}
	}
	return INVALID;
}

Report_Remove(reportid)
{
	if (reportid != -1 && ReportData[reportid][rExists])
	{
	    ReportData[reportid][rExists] = false;
	    ReportData[reportid][rPlayer] = INVALID_PLAYER_ID;
	}
	return true;
}

ReturnDate()
{
	static
	    date[36];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	format(date, sizeof(date), "%02d/%02d/%d, %02d:%02d", date[0], date[1], date[2], date[3], date[4]);
	return date;
}

public OnPlayerDisconnect(playerid, reason)
{
	TerminateConnection(playerid);
	return true;
}

Show_Camera_Login(playerid)
{
	TogglePlayerSpectating(playerid, true);

	InterpolateCameraPos(playerid, 2106.863281, 1345.609130, 24.867664, 2099.735107, 1294.246704, 38.859367, MINUTES(2));
	InterpolateCameraLookAt(playerid, 2111.592773, 1344.000000, 25.076978, 2104.667968, 1294.227783, 38.042530, MINUTES(2));
	
	ClearChat(playerid, 20),
 	PlayerPlaySound(playerid, 1187, 0.0, 0.0, 0.0);
}

public OnPlayerRequestClass(playerid, classid)
{
    SetPlayerColor(playerid, COLOR_BLACK),
	SetSpawnInfo(playerid, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

 	new
 		version[16];

    GetPlayerVersion(playerid, version, sizeof(version));

    if (strfind(version, SAMP_VERSION, true) != -1)
    {
    	Check_Account(playerid),
    	Show_Camera_Login(playerid),
		Create_Draws(playerid);
		
		LoginObjects[playerid][0] = CreatePlayerObject(playerid, 18750, 2290.11914062, 1284.30798340, 49.39973450, 51.74517822, 0.00000000, 270.25451660, 1000.000);
		LoginObjects[playerid][1] = CreatePlayerObject(playerid, 18648, 2177.55078125, 1287.70605469, 35.06026077, 0.00000000, 0.00000000, 267.99499512, 1000.000);
		LoginObjects[playerid][2] = CreatePlayerObject(playerid, 18648, 2177.55859375, 1283.69726562, 35.06026077, 0.00000000, 0.00000000, 267.99499512, 1000.000);
		LoginObjects[playerid][3] = CreatePlayerObject(playerid, 18672, 2136.67407227, 1274.18811035, 57.38270569, 0.00000000, 356.00000000, 6.00000000, 1000.000);
		LoginObjects[playerid][4] = CreatePlayerObject(playerid, 18672, 2135.63354492, 1289.08972168, 57.63270569, 0.00000000, 352.00000000, 183.99487305, 1000.000);
	}
 	else
	{
		SendSampMessage(playerid, "Debes tener la versión "COL_WHITE"%s"COL_DEFAULT" para jugar. Descárgala en "COL_WHITE"sa-mp.com"COL_DEFAULT" e ingresa nuevamente.", SAMP_VERSION);
	}
 	return true;
}

public OnPlayerRequestSpawn(playerid)
{
	if (!GetPVarInt(playerid, "Spawned")) return false;
	return true;
}

public OnPlayerSpawn(playerid)
{
    if (!GetPVarInt(playerid, "Spawned")) SetPVarInt(playerid, "Spawned", 1);
    
    PlayerPlaySound(playerid, 1184, 0.0, 0.0, 0.0),
	StopAudioStreamForPlayer(playerid);

 	Streamer_ToggleIdleUpdate(playerid, true),
 	SetPlayerColor(playerid, COLOR_WHITE);
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if (dialogid == MODEL_SELECTION_REGISTER)
	{
        if (response)
		{
		    PlayerData[playerid][LOGGED] = 1,
		    PlayerData[playerid][CREATED] = 1,
		    PlayerData[playerid][SKIN] = MasculineClothes[listitem];
		    
			Save_Character(playerid);
		    
		  	PlayerPlaySound(playerid, 1098, 0.0, 0.0, 0.0),
			StopAudioStreamForPlayer(playerid);
            
       	    SetSpawnInfo(playerid, 1, PlayerData[playerid][SKIN], SPAWN_X, SPAWN_Y, SPAWN_Z, 1.0, -1, -1, -1, -1, -1, -1),
            SetPlayerFacingAngle(playerid, SPAWN_ANGLE);
            
			new viewip[16];
			GetPlayerIp(playerid, viewip, sizeof viewip);

			SendAdminAlert(COLOR_ADMIN, "Es la primera vez de \"%s\" [%s] en el servidor (¿/espiar %d?).", PlayerName(playerid), viewip, playerid);
			
			TogglePlayerSpectating(playerid, false);
			
			new message[128];
			if (PlayerData[playerid][GENDER] == 1) format(message, sizeof(message), "~w~Bienvenido ~n~~y~   %s", PlayerName(playerid));
			else format(message, sizeof(message), "~w~Bienvenida ~n~~y~   %s", PlayerName(playerid));
			GameTextForPlayer(playerid, message, SECONDS(5), 1);
			
			PlayerTextDrawShow(playerid, PlayerData[playerid][TEXT_DRAW][1]);
        }
        else
		{
		  	Dialog_Show(playerid, DateBirth, DIALOG_STYLE_INPUT, ""COL_TITLE"Configuración (2/3)",
				""COL_CONTENT"Escoge una fecha de nacimiento para tu personaje.\n\n\
				"COL_CONTENT_TWO"Debes usar el formato "COL_TOMATO"20/09/2000"COL_CONTENT".", "Siguiente", "Atrás");
		}
    }
    return true;
}

public OnPlayerText(playerid, text[])
{
	if (!PlayerData[playerid][LOGGED])
	{
		SendErrorMessage(playerid, "Todavía no ingresaste. No puedes hablar.");
		return false;
	}
	else
	{
	    new
			string[128],
			anim = GetPlayerAnimationIndex(playerid);

		if (GetPlayerDrunkLevel(playerid) > 2000)
		{
			if (strlen(text) > 60)
			{
				format(string, sizeof(string), "%s [ebrio] dice: %.60s ...", PlayerName(playerid), text);
				ProxDetector(19.1, playerid, string, COLOR_CHAT_0, COLOR_CHAT_1, COLOR_CHAT_2, COLOR_CHAT_3, COLOR_CHAT_4);

				format(string, sizeof(string), "... %s", text[60]);
				ProxDetector(19.1, playerid, string, COLOR_CHAT_0, COLOR_CHAT_1, COLOR_CHAT_2, COLOR_CHAT_3, COLOR_CHAT_4);
			}
			else
			{
				format(string, sizeof(string), "%s [ebrio] dice: %s", PlayerName(playerid), text);
				ProxDetector(19.1, playerid, string, COLOR_CHAT_0, COLOR_CHAT_1, COLOR_CHAT_2, COLOR_CHAT_3, COLOR_CHAT_4);
				
				SetPlayerChatBubble(playerid, text, COLOR_LIGHTRED, TAG_DISTANCE, strlen(text) * 100);
			}
		}
		else
		{
			if (strlen(text) > 60)
			{
				format(string, sizeof(string), "%s dice: %.60s ...", PlayerName(playerid), text);
				ProxDetector(18.5, playerid, string, COLOR_CHAT_0, COLOR_CHAT_1, COLOR_CHAT_2, COLOR_CHAT_3, COLOR_CHAT_4);

				format(string, sizeof(string), "... %s", text[60]);
				ProxDetector(18.5, playerid, string, COLOR_CHAT_0, COLOR_CHAT_1, COLOR_CHAT_2, COLOR_CHAT_3, COLOR_CHAT_4);
			}
			else
			{
				format(string, sizeof(string), "%s dice: %s", PlayerName(playerid), text);
				ProxDetector(18.5, playerid, string, COLOR_CHAT_0, COLOR_CHAT_1, COLOR_CHAT_2, COLOR_CHAT_3, COLOR_CHAT_4);
				
				SetPlayerChatBubble(playerid, text, COLOR_LIGHTRED, TAG_DISTANCE, strlen(text) * 100);
			}
		}

		if (!IsPlayerInAnyVehicle(playerid) && (anim != 1538 || anim != 1539 || anim != 1540 || anim != 1541 || anim != 1542))
		{
		    ApplyAnimation(playerid, "PED", "IDLE_chat", 4.1, 7, 5, 1, strlen(text) * 100, 1);
	     	SetTimerEx("StopChatting", strlen(text) * 100, false, "d", playerid);
		}
	}
 	return false;
}

/* Comandos */
public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if (result == -1)
    {
		SendErrorMessage(playerid, "Oops. El comando /%s no existe. Prueba con "COL_WHITE"/ayuda"COL_GREY".", cmd);
        return false;
    }
    return true;
}

// Usuarios
cmd:ayuda(playerid, params[])
{
	if (sscanf(params, "s[32]", params) || !strcmp(params, "42", true))
	{
		SendSyntaxMessage(playerid, "/ayuda [general, chat, trabajo, facción, vehículo, casa, negocio y otro]"COL_GREY".");
	 	SendInfoMessage(playerid, "Para más ayuda échale un vistazo a "COL_WHITE"%s"COL_CYAN". También puedes usar /duda.", SERVER_WEB);
	}
	else if (!strcmp(params, "general", true))
	{

	}
	else if (!strcmp(params, "chat", true))
 	{

	}
	else if (!strcmp(params, "trabajo", true))
 	{

	}
	else if (!strcmp(params, "facción", true) || !strcmp(params, "faccion", true))
 	{

	}
	else if (!strcmp(params, "vehículo", true) || !strcmp(params, "vehiculo", true))
 	{

	}
	else if (!strcmp(params, "casa", true))
 	{

	}
	else if (!strcmp(params, "negocio", true))
 	{

	}
	else if (!strcmp(params, "otro", true))
 	{

	}
	else SendSyntaxMessage(playerid, "/ayuda [general, chat, trabajo, facción, vehículo, casa, negocio y otro]"COL_GREY".");
	return true;
}

cmd:motor(playerid, params[])
{
	new
	    vehicleid = GetPlayerVehicleID(playerid),
	    id = Car_GetID(vehicleid);

	if (!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "Tienes que estar dentro de un vehículo para usar este comando.");

	if (!IsEngineVehicle(vehicleid))
		return SendErrorMessage(playerid, "No estás dentro de ningún vehículo con motor.");

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "No eres el conductor.");

	if (CarData[id][carCEPO] != 0)
	    return SendErrorMessage(playerid, "Este vehículo tiene un cepo policial.");

	if (CarData[id][carSALE] != 0)
	    return SendErrorMessage(playerid, "Este vehículo está en venta. No hay llaves a la vista.");
	
	switch (GetEngineStatus(vehicleid))
	{
		case false:
		{
			EngineOn(vehicleid, playerid);
		}
		case true:
		{
			EngineOff(vehicleid, playerid);
		}
	}
	return true;
}

cmd:luces(playerid, params[])
{
	new
	    vehicleid = GetPlayerVehicleID(playerid),
 		message[64];
 		
	switch (GetLightStatus(vehicleid))
	{
		case false:
		{
			format(message, sizeof(message), "* encendió las luces del vehículo. *");
 			SetPlayerChatBubble(playerid, message, COLOR_PURPLE, TAG_DISTANCE, SECONDS(3));

			SetLightStatus(vehicleid, true),
			CarData[Car_GetID(GetPlayerVehicleID(playerid))][carLIGHTS_STATUS] = 1;
			
			GameTextForPlayer(playerid, Desbug("~w~Luces encendidas."), 750, 3);
			
		    foreach (new i : Player)
			{
		  		if (IsSpeedoVehicle(vehicleid) && (SQL_IsLogged(i) && GetPlayerVehicleID(i) == vehicleid))
		  		{
		  		    Update_SpeedoColor(i);
		    	}
		   	}
		}
		case true:
		{
  			format(message, sizeof(message), "* apagó las luces del vehículo. *");
 			SetPlayerChatBubble(playerid, message, COLOR_PURPLE, TAG_DISTANCE, SECONDS(3));

			SetLightStatus(vehicleid, false),
			CarData[Car_GetID(GetPlayerVehicleID(playerid))][carLIGHTS_STATUS] = 0;
			
			GameTextForPlayer(playerid, Desbug("~w~Luces apagadas."), 750, 3);
			
		    foreach (new i : Player)
			{
		  		if (IsSpeedoVehicle(vehicleid) && (SQL_IsLogged(i) && GetPlayerVehicleID(i) == vehicleid))
		  		{
		  		    Update_SpeedoColor(i);
		    	}
		   	}
		}
	}
	return true;
}

cmd:dar(playerid, params[])
{
	new
		item[32],
		user[32],
		id = Car_GetID(GetPlayerVehicleID(playerid));
		
    if (sscanf(params, "s[32]uS()[64]", item, params[0], user)) return SendSyntaxMessage(playerid, "/dar copia [id/nombre]"COL_GREY".");
    else if (params[0] == playerid) SendErrorMessage(playerid, "No puedes usar este comando contigo mismo.");
	else if (!strcmp(item, "copia", true))
	{
	    if (!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "No estás en el vehículo que vas a compartir.");
	    else if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Debes estar sentado en el asiento del conductor.");
		else if (CarData[id][carIMPOUNDED] != -1) return SendErrorMessage(playerid, "El vehículo está embargado, no puedes usarlo.");
		else
		{
			if ((id = Car_Inside(playerid)) != -1 && Car_IsOwner(playerid, id))
			{
	 			SendInfoMessage(playerid, "Le has dado la llave de tu %s (%s) a \"%s\".", ReturnVehicleModelName(CarData[id][carMODEL]), CarData[id][carPLATE], PlayerName(params[0])),
				SendInfoMessage(params[0], "\"%s\" te dio una copia de llave de su %s.", PlayerName(playerid), ReturnVehicleModelName(CarData[id][carMODEL]));

	   			CarData[id][carTAKEN] = PlayerData[params[0]][SQL_ID];
	   			format(CarData[id][carTAKEN_NAME], 24, "%s", PlayerName(params[0]));
			}
			else SendErrorMessage(playerid, "No eres dueño de éste vehículo.");
		}
	}
	return true;
}

cmd:peaje(playerid, params[])
{
	static
		id = -1;

	for (new i; i != MAX_TOLLS; i++)
	{
	    if (0 == IsPlayerInRangeOfPoint(playerid, TOLL_OPEN_DISTANCE, TollGatePosition[i][0], TollGatePosition[i][1], TollGatePosition[i][2]))
	        continue;

		id = i;
		break;
	}

	if (id == -1) return true;
    else if (TollData[id][tollOpenTime] > 0) return SendErrorMessage(playerid, "La barrera todavía está abierta. Se cerrará en %d segundos.", TollData[id][tollOpenTime]);
	else if (TollData[id][tollLocked]) return SendErrorMessage(playerid, "Este peaje fue cerrado. Fue una orden del departamento policial.");
	else if (GetPlayerMoney(playerid) < TOLL_COST) return SendErrorMessage(playerid, "Debes tener %s para pagar el peaje.", FormatNumber(TOLL_COST));

	SetPlayerChatBubble(playerid, "* pagó el peaje *", COLOR_PURPLE, TAG_DISTANCE, SECONDS(3)),
	Buy(playerid, TOLL_COST);
	
	Toll_OpenToll(id);
	return 1;
}

cmd:duda(playerid, params[])
{
	if (PlayerData[playerid][DOUBT_TIME] >= gettime())
	{
		return SendErrorMessage(playerid, "Debes esperar %s para preguntar otra vez.", GetDurationEx(PlayerData[playerid][DOUBT_TIME] - gettime()));
	}
	else if (AdminOnlineCheck() == 0) return SendErrorMessage(playerid, "No hay administradores conectados. Intenta más tarde.");
	else if (Doubt_GetCount(playerid) == 1) return SendErrorMessage(playerid, "Ya hiciste una pregunta. Espera a que te la respondan.");
	
	static
		doubtid = -1;

	if (isnull(params)) return SendSyntaxMessage(playerid, "/duda [pregunta] (puedes argumentar)"COL_GREY".");
	else if ((doubtid = Doubt_Add(playerid, params)) != -1)
	{
	    if (AdminOnlineCheck() > 1)
	    {
			if (strlen(params) > 60)
			{
			    SendInfoMessage(playerid, "Duda enviada a %d administradores: \"%.60s ...", AdminOnlineCheck(), params);
			    SendInfoMessage(playerid, "... %s\".", params[60]);
			}
			else SendInfoMessage(playerid, "Duda enviada a %d administradores: \"%s\".", AdminOnlineCheck(), params);
		}
  	    else if (AdminOnlineCheck())
	    {
			if (strlen(params) > 60)
			{
			    SendInfoMessage(playerid, "Duda enviada a un administrador: \"%.60s ...", params);
                SendInfoMessage(playerid, "... %s\".", params[60]);
			}
			else SendInfoMessage(playerid, "Duda enviada a un administrador: \"%s\".", params);
		}

		new message[128];
        format(message, sizeof(message), "Tu pregunta está en la posición #%d. Espera a que sea respondida.", doubtid + 1);
        ShowPlayerSuggestion(playerid, message, SECONDS(10));

	    foreach (new i : Player)
		{
			if (PlayerData[i][ADMIN_LEVEL] > 0 && SQL_IsLogged(i))
			{
				if (strlen(params) > 60)
				{
  					SendClientMessageEx(i, COLOR_DOUBTS, "(( {838282}[/ad %d ó /rd %d]"COL_DOUBTS" %s (%d) pregunta: \"%.60s ...", doubtid, doubtid, PlayerName(playerid), playerid, params);
	    			SendClientMessageEx(i, COLOR_DOUBTS, "... %s\". ))", params[60]);
				}
				else
				{
  					SendClientMessageEx(i, COLOR_DOUBTS, "(( {838282}[/ad %d ó /rd %d]"COL_DOUBTS" %s (%d) pregunta: \"%s\". ))", doubtid, doubtid, PlayerName(playerid), playerid, params);
				}
				
			 	ShowPlayerBox(playerid, "Una nueva pregunta se sumó a la lista de /dudas pendientes.", SECONDS(10), 1);
			}
		}

		PlayerData[playerid][DOUBT_TIME] = gettime() + 15;
	}
	else SendErrorMessage(playerid, "La lista de dudas está llena, espera.");
	return true;
}

cmd:reportar(playerid, params[])
{
	if (PlayerData[playerid][REPORT_TIME] >= gettime())
	{
		return SendErrorMessage(playerid, "Debes esperar %d para reportar otra vez.", GetDurationEx(PlayerData[playerid][REPORT_TIME] - gettime()));
	}
	else if (AdminOnlineCheck() == 0) return SendErrorMessage(playerid, "No hay administradores conectados. Intenta más tarde.");
	else if (Report_GetCount(playerid) == 1) return SendErrorMessage(playerid, "Ya tienes un reporte pendiente. Espera a que te lo respondan.");
	
	static
		reportid = -1;

	if (isnull(params)) return SendSyntaxMessage(playerid, "/reportar [texto] (expláyate)"COL_GREY".");
	else if ((reportid = Report_Add(playerid, params)) != -1)
	{
	    ConvertText(params, 2);

	    if (AdminOnlineCheck() > 1)
	    {
  			if (strlen(params) > 60)
			{
			    SendInfoMessage(playerid, "Reporte enviado a %s administrador: \"%.60s ...", AdminOnlineCheck(), params);
                SendInfoMessage(playerid, "... %s\".", params[60]);
			}
			else SendInfoMessage(playerid, "Reporte enviado a %d administradores: \"%s\".", AdminOnlineCheck(), params);
		}
  	    else if (AdminOnlineCheck())
	    {
  			if (strlen(params) > 60)
			{
   				SendInfoMessage(playerid, "Reporte enviado a un administrador: \"%.60s ...", params);
                SendInfoMessage(playerid, "... %s\".", params[60]);
			}
			else SendInfoMessage(playerid, "Reporte enviado a un administrador: \"%s\".", params);
		}

		new message[128];
        format(message, sizeof(message), "Tu reporte está en la posición #%d. Espera a que sea atendido.", reportid + 1);
        ShowPlayerSuggestion(playerid, message, SECONDS(10));

	    foreach (new i : Player)
		{
			if (PlayerData[i][ADMIN_LEVEL] > 0 && SQL_IsLogged(i))
			{
				if (strlen(params) > 60)
				{
  					SendClientMessageEx(i, COLOR_REPORTS, "(( {838282}[/ar %d ó /rr %d]"COL_REPORTS" %s (%d) reporta: \"%.60s ...", reportid, reportid, PlayerName(playerid), playerid, params);
	    			SendClientMessageEx(i, COLOR_REPORTS, "... %s\". ))", params[60]);
				}
				else
				{
  					SendClientMessageEx(i, COLOR_REPORTS, "(( {838282}[/ar %d ó /rr %d]"COL_REPORTS" %s (%d) reporta: \"%s\". ))", reportid, reportid, PlayerName(playerid), playerid, params);
				}
			}
			
	 		ShowPlayerBox(playerid, "Un nuevo reporte se sumó a la lista de /reportes pendientes.", SECONDS(10), 2);
		}
		
		PlayerData[playerid][REPORT_TIME] = gettime() + 15;
	}
	else SendErrorMessage(playerid, "La lista de reportes está llena, espera.");
	return true;
}

cmd:hora(playerid, params[])
{
	static
	    string[128],
		month[12],
		date[6];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	switch (date[1])
	{
	    case 1: month = "Enero";
	    case 2: month = "Febrero";
	    case 3: month = "Marzo";
	    case 4: month = "Abril";
	    case 5: month = "Mayo";
	    case 6: month = "Junio";
	    case 7: month = "Julio";
	    case 8: month = "Agosto";
	    case 9: month = "Septiembre";
	    case 10: month = "Octubre";
	    case 11: month = "Noviembre";
	    case 12: month = "Diciembre";
	}

	format(string, sizeof(string), "~y~%s %02d %d~n~~w~%02d:%02d:%02d", month, date[0], date[2], date[3], date[4], date[5]);
	GameTextForPlayer(playerid, string, SECONDS(5), 1);
	
  	SetPlayerChatBubble(playerid, "* observó la hora en su reloj *", COLOR_PURPLE, TAG_DISTANCE, SECONDS(3));
    ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_watch", 4.1, 0, 0, 0, 0, 0);
	return true;
}

cmd:intentar(playerid, params[])
{
    if (PlayerData[playerid][TRY_TIME] >= gettime())
		return SendErrorMessage(playerid, "Debes esperar %s para intentar otra vez.", GetDurationEx(PlayerData[playerid][TRY_TIME] - gettime()));

	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/intentar [acción]"COL_GREY".");
	
	new
		rand = random(2);
		
	if (rand == 0)
	{
		if (strlen(params) > 60)
		{
		    SendNearbyMessage(playerid, 30.0, COLOR_GREEN_TWO, "* ¡%s intenta %.60s ...", PlayerName(playerid), params);
		    SendNearbyMessage(playerid, 30.0, COLOR_GREEN_TWO, "... %s y consigue hacerlo!", params[60]);
		}
		else
		{
		    SendNearbyMessage(playerid, 30.0, COLOR_GREEN_TWO, "* ¡%s intenta %s y consigue hacerlo!", PlayerName(playerid), params);
		}
	}
	else if (rand == 1)
	{
		if (strlen(params) > 60)
		{
		    SendNearbyMessage(playerid, 30.0, COLOR_GREEN_TWO, "%s intentó %.60s ...", PlayerName(playerid), params);
		    SendNearbyMessage(playerid, 30.0, COLOR_GREEN_TWO, "... %s pero no consiguió hacerlo.", params[60]);
		}
		else
		{
		    SendNearbyMessage(playerid, 30.0, COLOR_GREEN_TWO, "%s intentó %s pero no consiguió hacerlo.", PlayerName(playerid), params);
		}
	}
	
	PlayerData[playerid][TRY_TIME] = gettime() + 30;
	return true;
}

cmd:me(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/me [acción]"COL_GREY".");

	if (strlen(params) > 60)
	{
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "%s %.60s ...", PlayerName(playerid), params);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "... %s", params[60]);
	}
	else
	{
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "%s %s", PlayerName(playerid), params);
	}
	
	new string[128];
	format(string, sizeof(string), "* %s *", params);
 	SetPlayerChatBubble(playerid, string, COLOR_PURPLE, TAG_DISTANCE, SECONDS(3));
	return true;
}

cmd:do(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/do [entorno]"COL_GREY".");

	if (strlen(params) > 60)
	{
	    SendNearbyMessage(playerid, 40.0, COLOR_DO, "%.60s ...", params);
	    SendNearbyMessage(playerid, 40.0, COLOR_DO, "... %s (( %s ))", params[60], PlayerName(playerid));
	}
	else
	{
	    SendNearbyMessage(playerid, 40.0, COLOR_DO, "%s (( %s ))", params, PlayerName(playerid));
	}
	return true;
}

alias:s("low");
cmd:s(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/s(usurro) [texto]"COL_GREY".");

	if (strlen(params) > 60)
	{
	    SendNearbyMessage(playerid, 3.0, COLOR_CHAT_1, "%s susurra: %.60s ...", PlayerName(playerid), params);
	    SendNearbyMessage(playerid, 3.0, COLOR_CHAT_1, "... %s", params[60]);
	}
	else
	{
	    SendNearbyMessage(playerid, 3.0, COLOR_CHAT_1, "%s susurra: %s", PlayerName(playerid), params);
	}
	return true;
}

alias:g("gritar");
cmd:g(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/g(ritar) [texto]"COL_GREY".");

	if (strlen(params) > 60)
	{
	    SendNearbyMessage(playerid, 35.0, 0xEFEFEF99, "%s grita: ¡%.60s ...", PlayerName(playerid), params);
	    SendNearbyMessage(playerid, 35.0, 0xEFEFEF99, "... %s!", params[60]);
	}
	else
	{
	    SendNearbyMessage(playerid, 35.0, 0xEFEFEF99, "%s grita: ¡%s!", PlayerName(playerid), params);
	}
	return true;
}

cmd:b(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/b [chat OOC local]"COL_GREY".");

	if (strlen(params) > 60)
	{
	    SendNearbyMessage(playerid, 21.0, COLOR_CHAT_0, "(( {838282}[OOC] "COL_CHAT_0"%s (%d): %.60s ...", PlayerName(playerid), playerid, params);
	    SendNearbyMessage(playerid, 21.0, COLOR_CHAT_0, "... %s ))", params[60]);
	}
	else SendNearbyMessage(playerid, 21.0, COLOR_CHAT_0, "(( {838282}[OOC] "COL_CHAT_0"%s (%d): %s ))", PlayerName(playerid), playerid, params);
	return true;
}

cmd:admins(playerid, params[]) return callcmd::staff(playerid, params);
cmd:staff(playerid, params[])
{
	new
		title[128],
		text[128],
		dialog[850] = "#\tNombre\tPuesto administrativo\n",
		count = 0;

	format(title, sizeof(title), ""COL_TITLE"Hay %d administrador(es) activo(s)", AdminOnlineCheck());

	foreach (new i : Player)
	{
		if (SQL_IsLogged(i) && PlayerData[i][ADMIN_LEVEL] >= 1)
		{
  			new
				levels[20];

            switch (PlayerData[i][ADMIN_LEVEL])
            {
	            case 1: if (PlayerData[i][GENDER] == 1) levels = "Moderador 1"; else levels = "Moderadora 1";
	            case 2: if (PlayerData[i][GENDER] == 1) levels = "Moderador 2"; else levels = "Moderadora 2";
	            case 3: if (PlayerData[i][GENDER] == 1) levels = "Moderador 3"; else levels = "Moderadora 3";
	            case 4: if (PlayerData[i][GENDER] == 1) levels = "Administrador 4"; else levels = "Administradora 4";
	            case 5: if (PlayerData[i][GENDER] == 1) levels = "Administrador 5"; else levels = "Administradora 5";
	            case 6: if (PlayerData[i][GENDER] == 1) levels = "Administrador 6"; else levels = "Administradora 6";
	            case 7: if (PlayerData[i][GENDER] == 1) levels = "Gerente 1337"; else levels = "Gerenta 1337";
	            case 8: if (PlayerData[i][GENDER] == 1) levels = "Gerente 1338"; else levels = "Gerenta 1338";
	            case 9: if (PlayerData[i][GENDER] == 1) levels = "Propietario 1339"; else levels = "Propietaria 1339";
	            case 10: if (PlayerData[i][GENDER] == 1) levels = "Desarrollador"; else levels = "Desarrolladora";
            }

            format(text, sizeof(text), "%d\t{%06x}%s"COL_WHITE"\t%s\n", i, GetPlayerColor(i) >>> 8, PlayerName(i), levels);
			strcat(dialog, text);

			count ++;
		}
	}

	if (count != 0) Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, title, dialog, "—", "");
	else SendErrorMessage(playerid, "No hay administradores conectados.");
	
	return true;
}

// Administrativos
cmd:dudas(playerid, params[])
{
    if (PlayerData[playerid][ADMIN_LEVEL] < 1)
	    return INVALID;

	new
		count,
		text[128];

	for (new i = 0; i != MAX_DOUBTS; i ++)
	{
	    if (!DoubtData[i][dExists])
			continue;

		strunpack(text, DoubtData[i][dText]);

		if (strlen(text) > 60)
		{
		    SendClientMessageEx(playerid, COLOR_DOUBTS, "— [/ad %d ó /rd %d] %s (%d) pregunta: \"%.60s", i, i, PlayerName(DoubtData[i][dPlayer]), DoubtData[i][dPlayer], text);
			SendClientMessageEx(playerid, COLOR_DOUBTS, "... %s\".", text[60]);
		}
		else
		{
  			SendClientMessageEx(playerid, COLOR_DOUBTS, "— [/ad %d ó /rd %d] %s (%d) pregunta: \"%s\".", i, i, PlayerName(DoubtData[i][dPlayer]), DoubtData[i][dPlayer], text);
		}

		count++;
	}

	if (!count) return SendErrorMessage(playerid, "No hay dudas pendientes. ¡Estamos al día!");
	return true;
}

cmd:reportes(playerid, params[])
{
    if (PlayerData[playerid][ADMIN_LEVEL] < 2)
	    return INVALID;

	new
		count,
		text[128];

	for (new i = 0; i != MAX_REPORTS; i ++)
	{
	    if (!ReportData[i][rExists])
			continue;

		strunpack(text, ReportData[i][rText]);

  		if (strlen(text) > 60)
		{
		    SendClientMessageEx(playerid, COLOR_REPORTS, "— [/ar %d ó /rr %d] %s (%d) reporta: \"%.60s", i, i, PlayerName(ReportData[i][rPlayer]), ReportData[i][rPlayer], text);
			SendClientMessageEx(playerid, COLOR_REPORTS, "... %s\".", text[60]);
		}
		else
		{
  			SendClientMessageEx(playerid, COLOR_REPORTS, "— [/ar %d ó /rr %d] %s (%d) reporta: \"%s\".", i, i, PlayerName(ReportData[i][rPlayer]), ReportData[i][rPlayer], text);
		}

		count++;
	}

	if (!count) return SendErrorMessage(playerid, "No hay reportes pendientes. ¡Estamos al día!");
	return true;
}

alias:areporte("ar");
cmd:areporte(playerid, params[])
{
    if (PlayerData[playerid][ADMIN_LEVEL] < 2)
	    return INVALID;

	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/ar [id del reporte] (/reportes)"COL_GREY".");

	new
		reportid = strval(params);

	if ((reportid < 0 || reportid >= MAX_REPORTS) || !ReportData[reportid][rExists])
	    return SendErrorMessage(playerid, "Desde el 0 hasta el %d.", MAX_REPORTS);

	SendInfoMessage(ReportData[reportid][rPlayer], "\"%s\" está revisando tu reporte.", PlayerName(playerid));
	SendAdminAlert(COLOR_ADMIN, "\"%s\" está revisando el reporte de \"%s\".", PlayerName(playerid), PlayerName(ReportData[reportid][rPlayer]));

	Report_Remove(reportid);
	return true;
}

alias:rreporte("rr");
cmd:rreporte(playerid, params[])
{
    if (PlayerData[playerid][ADMIN_LEVEL] < 2)
	    return INVALID;

	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/rr [id del reporte] (/reportes)"COL_GREY".");

	new
		reportid = strval(params);

	if ((reportid < 0 || reportid >= MAX_REPORTS) || !ReportData[reportid][rExists])
	    return SendErrorMessage(playerid, "Desde el 0 hasta el %d.", MAX_REPORTS);

	SendInfoMessage(ReportData[reportid][rPlayer], "\"%s\" marcó tu reporte como inválido.", PlayerName(playerid));
	SendAdminAlert(COLOR_ADMIN, "\"%s\" marcó el reporte de \"%s\" como inválido.", PlayerName(playerid), PlayerName(ReportData[reportid][rPlayer]));

    Report_Remove(reportid);
	return true;
}

alias:aduda("ad");
cmd:aduda(playerid, params[])
{
    if (PlayerData[playerid][ADMIN_LEVEL] < 1)
	    return INVALID;

	new
		doubtid = strval(params),
		reply[128];

    if (sscanf(params, "us[128]", doubtid, reply)) return SendSyntaxMessage(playerid, "/aduda [id de la duda] [respuesta]"COL_GREY".");

	if ((doubtid < 0 || doubtid >= MAX_DOUBTS) || !DoubtData[doubtid][dExists])
	    return SendErrorMessage(playerid, "Desde el 0 hasta el %d.", MAX_DOUBTS);

	SendAdminAlert(COLOR_ADMIN, "\"%s\" respondió a la duda de \"%s\".", PlayerName(playerid), PlayerName(DoubtData[doubtid][dPlayer]));

	if (strlen(reply) > 60)
	{
 	    SendOwnerAlert(COLOR_ADMIN, "[1339's] La respuesta: \"%.60s ...", reply);
	    SendOwnerAlert(COLOR_ADMIN, "... %s\".", reply[60]);

	    SendInfoMessage(DoubtData[doubtid][dPlayer], "\"%s\" respondió a tu pregunta: \"%.60s", PlayerName(playerid), reply);
	    SendInfoMessage(DoubtData[doubtid][dPlayer], "... %s\".", reply[60]);
	}
	else
	{
	    SendOwnerAlert(COLOR_ADMIN, "[1339's] La respuesta: \"%s\".", reply);

	    SendInfoMessage(DoubtData[doubtid][dPlayer], "\"%s\" respondió a tu pregunta: \"%s\".", PlayerName(playerid), reply);
	}

	Doubt_Remove(doubtid);
	return true;
}

alias:rduda("rd");
cmd:rduda(playerid, params[])
{
    if (PlayerData[playerid][ADMIN_LEVEL] < 1)
	    return INVALID;

	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/rduda [id de la duda] (/dudas).");

	new
		doubtid = strval(params);

	if ((doubtid < 0 || doubtid >= MAX_DOUBTS) || !DoubtData[doubtid][dExists])
	    return SendErrorMessage(playerid, "Desde el 0 hasta el %d.", MAX_DOUBTS);

	SendInfoMessage(DoubtData[doubtid][dPlayer], "\"%s\" marcó tu pregunta como inválida.", PlayerName(playerid));
	SendAdminAlert(COLOR_ADMIN, "\"%s\" marcó la pregunta de \"%s\" como inválida.", PlayerName(playerid), PlayerName(DoubtData[doubtid][dPlayer]));

    Doubt_Remove(doubtid);
	return true;
}

alias:darcar("givecar");
cmd:darcar(playerid, params[])
{
	static
		userid,
	    model[32];

    if (PlayerData[playerid][ADMIN_LEVEL] < 9)
	    return INVALID;

	if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
 		return SendErrorMessage(playerid, "No puedes crear vehículos en interiores o mundos.");

	if (sscanf(params, "us[32]", userid, model))
	    return SendSyntaxMessage(playerid, "/darcar [id/nombre] [modelo/nombre]"COL_GREY".");

	if (Car_GetCount(userid) >= MAX_OWNABLE_CARS)
		return SendErrorMessage(playerid, "Ese jugador alcanzó el máximo de vehículos.");

    if ((model[0] = GetVehicleModelByName(model)) == 0)
	    return SendErrorMessage(playerid, "Modelo inválido.");

	static
	    Float:x,
		Float:y,
		Float:z,
		Float:angle,
		id = -1;

    GetPlayerPos(userid, x, y, z);
	GetPlayerFacingAngle(userid, angle);

	id = Car_Create(PlayerData[userid][SQL_ID], model[0], x, y + 2, z + 1, angle, 255, 255, -1);

	if (id == -1)
	    return SendErrorMessage(playerid, "Se ha llegado al límite de vehículos dinámicos.");

    SendAdminAlert(COLOR_ADMIN, "\"%s\" creó un vehículo para \"%s\".", PlayerName(playerid), PlayerName(userid));
	return true;
}

alias:borrarcar("cardelete");
cmd:borrarcar(playerid, params[])
{
	static
	    id = 0;

    if (PlayerData[playerid][ADMIN_LEVEL] < 5)
	    return INVALID;

	if (sscanf(params, "d", id))
 	{
	 	if (IsPlayerInAnyVehicle(playerid))
		 	id = GetPlayerVehicleID(playerid);

		else return SendSyntaxMessage(playerid, "/borrarcar [id/nombre]"COL_GREY".");
	}
	
	if (!IsValidVehicle(id) || Car_GetID(id) == -1)
	    return SendErrorMessage(playerid, "El vehículo no existe.");

	Car_Delete(Car_GetID(id));

	SendAdminAlert(COLOR_ADMIN, "\"%s\" borró el vehículo #%d.", PlayerName(playerid), id);
	return true;
}

cmd:colorcar(playerid, params[])
{
	static
	    color1,
	    color2;

    if (PlayerData[playerid][ADMIN_LEVEL] < 4)
	    return INVALID;

	if (!IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "No estás en un vehículo.");

	if (sscanf(params, "dd", color1, color2))
	    return SendSyntaxMessage(playerid, "/colorcar [color 1] [color 2]"COL_GREY".");

	if (color1 < 0 || color1 > 255)
	    return SendErrorMessage(playerid, "De 0 hasta 255.");

    if (color2 < 0 || color2 > 255)
	    return SendErrorMessage(playerid, "De 0 hasta 255.");

	SetVehicleColor(GetPlayerVehicleID(playerid), color1, color2);
	SendAdminAlert(COLOR_ADMIN, "\"%s\" ajustó los colores de su vehículo (#%d y #%d).", PlayerName(playerid), color1, color2);
	return true;
}

cmd:enviarcar(playerid, params[])
{
	static
	    carid,
	    userid;

   	if (PlayerData[playerid][ADMIN_LEVEL] < 3)
	    return INVALID;

	if (sscanf(params, "du", carid, userid))
	    return SendSyntaxMessage(playerid, "/enviarcar [id del vehículo] [id/nombre]"COL_GREY".");

    if (IsPlayerNPC(userid))
	    return true;

	if (carid < 1 || carid > MAX_VEHICLES || !IsValidVehicle(carid))
		return SendErrorMessage(playerid, "El vehículo no existe.");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "El jugador no está conectado.");

	new
		Float:positionX,
		Float:positionY,
		Float:positionZ;

	GetPlayerPos(userid, positionX, positionY, positionZ),
	SetVehiclePos(carid, positionX, positionY + 4, positionZ);

	SendAdminAlert(COLOR_LIGHTRED, "\"%s\" llevó el vehículo #%d hasta la posición de \"%s\".", PlayerName(playerid), carid, PlayerName(userid)),
    SendAdminAction(userid, "\"%s\" teletransportó el vehículo #%d hacia ti.", PlayerName(playerid), carid);
	return true;
}

cmd:entercar(playerid, params[])
{
	new
		vehicleid,
		seatid;

    if (PlayerData[playerid][ADMIN_LEVEL] < 3)
	    return INVALID;

	if (sscanf(params, "d", vehicleid))
	    return SendSyntaxMessage(playerid, "/entercar [id/nombre]"COL_GREY".");

	if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "El vehículo no existe.");

	seatid = GetAvailableSeat(vehicleid, 0);

	if (seatid == -1)
	    return SendErrorMessage(playerid, "No quedan asientos libres en ese vehículo.");

	PutPlayerInVehicle(playerid, vehicleid, seatid);
	return true;
}

alias:respawncar("rtcar");
cmd:respawncar(playerid, params[])
{
	new
		vehicleid;

    if (PlayerData[playerid][ADMIN_LEVEL] < 2)
	    return INVALID;

	if (sscanf(params, "d", vehicleid))
	    return SendSyntaxMessage(playerid, "/respawncar [id/nombre]"COL_GREY".");

	if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "El vehículo no existe.");

	RespawnVehicle(vehicleid),
	SendAdminAlert(COLOR_ADMIN, "\"%s\" re-posicionó el vehículo #%d.", PlayerName(playerid), vehicleid);
	return true;
}

alias:respawncars("rtcars");
cmd:respawncars(playerid, params[])
{
    if (PlayerData[playerid][ADMIN_LEVEL] < 5)
	    return INVALID;

	new
		count;

	for (new i = 1; i != MAX_VEHICLES; i ++)
	{
	    if (IsValidVehicle(i) && (GetVehicleDriver(i) == INVALID_PLAYER_ID))
	    {
			RespawnVehicle(i),
			count++;
		}
	}
	
	if (!count)
	    return SendErrorMessage(playerid, "No hay vehículos para posicionar.");

    SendAdminAlert(COLOR_ADMIN, "\"%s\" re-posicionó %d vehículos.", PlayerName(playerid), count);
	return true;
}

alias:gascar("adargas");
cmd:gascar(playerid, params[])
{
	static
	    id = 0,
		amount;

    if (PlayerData[playerid][ADMIN_LEVEL] < 4)
	    return INVALID;

	if (sscanf(params, "dd", id, amount))
 	{
	 	if (IsPlayerInAnyVehicle(playerid))
		{
		    id = GetPlayerVehicleID(playerid);

		    if (sscanf(params, "d", amount))
		        return SendSyntaxMessage(playerid, "/gascar [cantidad]"COL_GREY".");

			if (amount < 0)
			    return SendErrorMessage(playerid, "La cantidad no puede ser inferior a 0.");

			CoreVehicles[id][vehFuel] = amount;
			
			SendAdminAlert(COLOR_ADMIN, "\"%s\" le dio un %d porciento de gasolina al vehículo #%d.", PlayerName(playerid), amount, id);
			return true;
		}
		else return SendSyntaxMessage(playerid, "/gascar [id] [cantidad]"COL_GREY".");
	}
	
	if (!IsValidVehicle(id))
	    return SendErrorMessage(playerid, "El vehículo no existe.");

	if (amount < 0)
 		return SendErrorMessage(playerid, "La cantidad no puede ser inferior a 0.");

	CoreVehicles[id][vehFuel] = amount;
	SendAdminAlert(COLOR_ADMIN, "\"%s\" le dio un %d porciento de gasolina al vehículo #%d.", PlayerName(playerid), amount, id);
	return true;
}

alias:repararcar("fixveh");
cmd:repararcar(playerid, params[])
{
    new
		vehicleid = GetPlayerVehicleID(playerid);

	if (PlayerData[playerid][ADMIN_LEVEL] < 5)
	    return INVALID;

	if (vehicleid > 0 && isnull(params))
	{
		RepairVehicle(vehicleid);
		SendOwnerAlert(COLOR_ADMIN, "[1339's] \"%s\" reparó su vehículo.", PlayerName(playerid));
	}
	else
	{
		if (sscanf(params, "d", vehicleid))
	    	return SendSyntaxMessage(playerid, "/repararcar [id/nombre]"COL_GREY".");

		else if (!IsValidVehicle(vehicleid))
	    	return SendErrorMessage(playerid, "El vehículo no existe.");

		RepairVehicle(vehicleid);
    	SendOwnerAlert(COLOR_ADMIN, "[1339's] \"%s\" reparó el vehículo #%d.", PlayerName(playerid), vehicleid);
	}
	return true;
}

alias:traercar("getcar", "traerveh");
cmd:traercar(playerid, params[])
{
	new
		vehicleid;

    if (PlayerData[playerid][ADMIN_LEVEL] < 2)
	    return INVALID;

	if (sscanf(params, "d", vehicleid))
	    return SendSyntaxMessage(playerid, "/traercar [id/nombre]"COL_GREY".");

	if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "El vehículo no existe.");

	static
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);
	SetVehiclePos(vehicleid, x + 2, y - 2, z);

 	SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
	
	SendAdminAlert(COLOR_ADMIN, "\"%s\" llevó el vehículo #%d hacia su posición.", PlayerName(playerid), vehicleid);
	return true;
}

cmd:jp(playerid, params[])
{
	new
		userid;

	if (PlayerData[playerid][ADMIN_LEVEL] < 9)
	    return INVALID;

	if (sscanf(params, "u", userid))
 	{
 	    PlayerData[playerid][JET_PACK] = 1,
	 	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	}
	else if (PlayerData[userid][ADMIN_LEVEL] == 0)
	{
	    SendErrorMessage(playerid, "Ese jugador no es administrador; no puedes darle un jetpack.");
	}
	else
	{
		PlayerData[userid][JET_PACK] = 1,
		SetPlayerSpecialAction(userid, SPECIAL_ACTION_USEJETPACK);
		
		SendAdminAlert(COLOR_ADMIN, "\"%s\" le dio un jetpack a \"%s\"", PlayerName(playerid), PlayerName(userid));
	}
	return true;
}

cmd:a(playerid, params[])
{
    if (PlayerData[playerid][ADMIN_LEVEL] < 1) return INVALID;
    else
    {
    	if (isnull(params))
	    	return SendSyntaxMessage(playerid, "/a [texto]"COL_GREY".");
    
		new
			levels[20];

		switch (PlayerData[playerid][ADMIN_LEVEL])
  		{
    		case 1: if (PlayerData[playerid][GENDER] == 1) levels = "1 Moderador"; else levels = "1 Moderadora ";
      		case 2: if (PlayerData[playerid][GENDER] == 1) levels = "2 Moderador"; else levels = "2 Moderadora";
        	case 3: if (PlayerData[playerid][GENDER] == 1) levels = "3 Moderador"; else levels = "3 Moderadora";
         	case 4: if (PlayerData[playerid][GENDER] == 1) levels = "4 Administrador"; else levels = "4 Administradora";
          	case 5: if (PlayerData[playerid][GENDER] == 1) levels = "5 Administrador"; else levels = "5 Administradora";
           	case 6: if (PlayerData[playerid][GENDER] == 1) levels = "6 Administrador"; else levels = "6 Administradora";
           	case 7: if (PlayerData[playerid][GENDER] == 1) levels = "1337 Gerente"; else levels = "1337 Gerenta";
            case 8: if (PlayerData[playerid][GENDER] == 1) levels = "1338 Gerente"; else levels = "1338 Gerenta";
            case 9: if (PlayerData[playerid][GENDER] == 1) levels = "1339 Propietario"; else levels = "1339 Propietaria";
            case 10: if (PlayerData[playerid][GENDER] == 1) levels = "Desarrollador"; else levels = "Desarrolladora";
      	}
      	
	 	if (strlen(params) > 60)
		{
			SendAdminAlert(COLOR_ORANGE, "* %s %s (%d): %.60s ...", levels, PlayerName(playerid), playerid, params[0]);
 			SendAdminAlert(COLOR_ORANGE, "... %s", params[60]);
		}
		else SendAdminAlert(COLOR_ORANGE, "* %s %s (%d): %s", levels, PlayerName(playerid), playerid, params[0]);
	}

	Log_Write("logs/admin_chat.txt", "<%s> [/a] %s: \"%s\".",
		ReturnDate(),
		PlayerName(playerid),
		params[0]
	);
	return true;
}

alias:turno("adminduty");
cmd:turno(playerid, params[])
{
	if (PlayerData[playerid][ADMIN_LEVEL] < 1)
	    return INVALID;

	if (!PlayerData[playerid][ADMIN_DUTY])
	{
		SendClientMessageToAllEx(COLOR_PIEL, "(( {838282}[OOC]"COL_PIEL" \"%s\" está de turno administrativo. Puedes usar /soporte. ))", PlayerName(playerid));
		
		PlayerData[playerid][ADMIN_DUTY] = 1;
	}
	else
	{
	    SendClientMessageToAllEx(COLOR_PIEL, "(( {838282}[OOC]"COL_PIEL" \"%s\" ya no está de turno administrativo. ))", PlayerName(playerid));
			
		PlayerData[playerid][ADMIN_DUTY] = 0,
		SetPlayerColor(playerid, COLOR_WHITE);
	}
	return true;
}

alias:ir("goto");
cmd:gotols(playerid, params[]) return callcmd::ir(playerid, "ls");
cmd:gotosf(playerid, params[]) return callcmd::ir(playerid, "sf");
cmd:gotolv(playerid, params[]) return callcmd::ir(playerid, "lv");
cmd:ir(playerid, params[])
{
	static
	    id,
	    type[24],
		string[128];

	if (PlayerData[playerid][ADMIN_LEVEL] < 1)
		return INVALID;

	if (sscanf(params, "u", id)) SendSyntaxMessage(playerid, "/ir [id, spawn, ls, sf y lv]"COL_GREY".");
    else if (id == INVALID_PLAYER_ID)
	{
	    if (sscanf(params, "s[24]S()[128]", type, string)) SendSyntaxMessage(playerid, "/ir [id, spawn, ls, sf y lv]"COL_GREY".");
	    else if (!strcmp(type, "spawn", true)) SetDefaultSpawn(playerid);
	    else if (!strcmp(type, "ls", true))
		{
		  	SetPlayerPos(playerid, 1549.0, -1675.4, 14.7);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
		}
  	    else if (!strcmp(type, "sf", true))
		{
		  	SetPlayerPos(playerid, -1417.0, -295.8, 14.1);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
		}
  	    else if (!strcmp(type, "lv", true))
		{
		  	SetPlayerPos(playerid, 1699.2, 1435.1, 10.7);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
		}
	}
	else
	{
	 	if (!IsConnected(id)) return SendErrorMessage(playerid, "El jugador todavía no ingresó.");

		SendPlayerToPlayer(playerid, id);
	}
	return true;
}

cmd:makeadmin(playerid, params[])
{
	if (PlayerData[playerid][ADMIN_LEVEL] < 7)
 		return INVALID;
 		
	static
		userid,
	    level;

	if (sscanf(params, "ud", userid, level))
		return SendSyntaxMessage(playerid, "/makeadmin [id/nombre] [0-10]"COL_GREY".");

	if (level < 0 || level > 10)
	    return SendErrorMessage(playerid, "Nivel incorrecto. El rango es desde el 0 hasta el 10.");

	if (!IsPlayerAdmin(playerid))
	{
 		SendAdminAlert(COLOR_ADMIN, "\"%s\" falló al usar /makeadmin %d %d con \"%s\".", PlayerName(playerid), userid, level, PlayerName(userid));

		Log_Write("logs/admin_general.txt", "<%s> %s fallo al usar /makeadmin con %s.",
			ReturnDate(),
			PlayerName(playerid),
			PlayerName(userid)
		);
		return true;
	}
	
	SQL_Update_Int("accounts", PlayerName(userid), "ADMIN_LEVEL", level),
 	PlayerData[userid][ADMIN_LEVEL] = level;

	SendAdminAlert(COLOR_ADMIN, "\"%s\" ajustó el nivel administrativo de \"%s\". Ahora es %d.", PlayerName(playerid), PlayerName(userid), level);
	SendAdminAction(userid, "\"%s\" ajustó tu nivel administrativo. Ahora es %d.", PlayerName(playerid), level);
	return true;
}

alias:givemoney("adardinero");
cmd:givemoney(playerid, params[])
{
	if (PlayerData[playerid][ADMIN_LEVEL] < 9)
 		return SendErrorMessage(playerid, "No tienes rango suficiente. Debes ser 1339 o mayor.");
 		
	static
		userid,
	    amount;

	if (sscanf(params, "ud", userid, amount))
		return SendSyntaxMessage(playerid, "/givemoney [id/nombre] [cantidad]"COL_GREY".");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "El jugador no está conectado.");

	SQL_Update_Int("accounts", PlayerName(userid), "MONEY", amount),
	PlayerData[userid][MONEY] += amount;
	
	SendAdminAlert(COLOR_ADMIN, "\"%s\" ha dado %s dólares a \"%s\".", PlayerName(playerid), FormatNumber(amount), PlayerName(userid));
	SendAdminAction(userid, "\"%s\" te dió %s.", PlayerName(playerid), FormatNumber(amount));
	return true;
}

alias:variable("var", "setstat");
cmd:variable(playerid, params[])
{
	if (!IsPlayerAdmin(playerid) && PlayerData[playerid][ADMIN_LEVEL] < 7)
	    return INVALID;

	static
	    userid,
	    type[16],
	    amount[32];

	if (sscanf(params, "us[16]S()[32]", userid, type, amount))
 	{
	 	SendSyntaxMessage(playerid, "/variable [id/nombre] [admin, género, nacimiento, dinero, banco, nivel, ...");
	 	SendClientMessage(playerid, COLOR_PIEL, "... experiencia, minutos, horas]"COL_GREY".");
		return true;
	}
	else if (userid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "El jugador no está conectado.");
	else if (!strcmp(type, "admin", true))
	{
 	    if (isnull(amount) || strval(amount) < 0 || strval(amount) > 10)
	        return SendSyntaxMessage(playerid, "/variable [id/nombre] [admin] [0-10]"COL_GREY".");
	        
 		if (!IsPlayerAdmin(playerid))
 		{
 		    SendAdminAlert(COLOR_ADMIN, "\"%s\" falló al usar /variable %d admin %d con \"%s\".", PlayerName(playerid), userid, amount, PlayerName(userid));
 		    
     		Log_Write("logs/admin_general.txt", "<%s> %s fallo al usar /variable admin con %s.",
				ReturnDate(),
				PlayerName(playerid),
				PlayerName(userid)
			);
			return true;
		}
		
        SQL_Update_Int("accounts", PlayerName(userid), "ADMIN_LEVEL", strval(amount)),
        PlayerData[userid][ADMIN_LEVEL] = strval(amount);

	 	SendAdminAlert(COLOR_ADMIN, "\"%s\" ajustó el nivel administrativo de \"%s\".", PlayerName(playerid), PlayerName(userid));
		SendAdminAction(userid, "\"%s\" ajustó tu nivel administrativo. Ahora es %s.", PlayerName(playerid), FormatNumber(strval(amount), ""));
	}
	else if (!strcmp(type, "genero", true) || !strcmp(type, "género", true))
	{
	    if (isnull(amount) || strval(amount) < 1 || strval(amount) > 2)
	        return SendSyntaxMessage(playerid, "/variable [id/nombre] [género] (1: masculino y 2: femenino).");

        SQL_Update_Int("accounts", PlayerName(userid), "GENDER", strval(amount)),
		PlayerData[userid][GENDER] = strval(amount);

		if (PlayerData[userid][GENDER] == 1)
		{
			SendAdminAlert(COLOR_ADMIN, "\"%s\" le ajustó el género a \"%s\". Ahora es masculino.", PlayerName(playerid), PlayerName(userid));
        	SendAdminAction(userid, "\"%s\" ajustó tu género a masculino.", PlayerName(playerid));
        }
		else if (PlayerData[userid][GENDER] == 2)
		{
			SendAdminAlert(COLOR_ADMIN, "\"%s\" le ajustó el género a \"%s\". Ahora es femenino.", PlayerName(playerid), PlayerName(userid));
        	SendAdminAction(userid, "\"%s\" ajustó tu género a femenino.", PlayerName(playerid));
   		}
	}
 	else if (!strcmp(type, "nacimiento", true))
	{
	    if (isnull(amount) || strlen(amount) > 24)
	        return SendSyntaxMessage(playerid, "/variable [id/nombre] [nacimiento] [ejemplo: 20/09/2000]"COL_GREY".");

        SQL_Update_String("accounts", PlayerName(userid), "BIRTHDATE", amount),
		format(PlayerData[userid][BIRTHDATE], 24, amount);
		
		SendAdminAlert(COLOR_ADMIN, "\"%s\" ha seteado fecha de nacimiento a \"%s\" (%s).", PlayerName(playerid), PlayerName(userid), amount);
        SendAdminAction(userid, "%s ajustó tu fecha de nacimiento. Ahora es %s.", PlayerName(playerid), amount);
	}
 	else if (!strcmp(type, "dinero", true))
	{
		if (PlayerData[playerid][ADMIN_LEVEL] < 9)
		    return SendErrorMessage(playerid, "No tienes rango suficiente. Debes ser 1339 o mayor.");
		    
	    if (isnull(amount))
	        return SendSyntaxMessage(playerid, "/variable [id/nombre] [dinero] [cantidad]"COL_GREY".");

        SQL_Update_Int("accounts", PlayerName(userid), "MONEY", strval(amount)),
		PlayerData[userid][MONEY] = strval(amount);
		
		SendAdminAlert(COLOR_ADMIN, "\"%s\" ajustó la cantidad de dinero que lleva \"%s\". Ahora tiene %s.", PlayerName(playerid), PlayerName(userid), FormatNumber(strval(amount)));
        SendAdminAction(userid, "%s ajustó el dinero que llevas. Ahora tienes %s.", PlayerName(playerid), FormatNumber(strval(amount)));
        
		Log_Write("logs/admin_money.txt", "<%s> %s ajusto el dinero en mano de %s a %s.",
			ReturnDate(),
			PlayerName(playerid),
			PlayerName(userid),
			FormatNumber(strval(amount))
		);
	}
	else if (!strcmp(type, "banco", true))
	{
 		if (PlayerData[playerid][ADMIN_LEVEL] < 9)
		    return SendErrorMessage(playerid, "No tienes rango suficiente. Debes ser 1339 o mayor.");
		    
	    if (isnull(amount))
	        return SendSyntaxMessage(playerid, "/variable [id/nombre] [banco] [cantidad]"COL_GREY".");

        SQL_Update_Int("accounts", PlayerName(userid), "BANK_MONEY", strval(amount)),
		PlayerData[userid][BANK_MONEY] = strval(amount);
		
		SendAdminAlert(COLOR_ADMIN, "\"%s\" ajustó el dinero en banco de \"%s\". Ahora tiene %s.", PlayerName(playerid), PlayerName(userid), FormatNumber(strval(amount)));
        SendAdminAction(userid, "%s ajustó tu dinero en banco. Ahora tienes %s.", PlayerName(playerid), FormatNumber(strval(amount)));
        
		Log_Write("logs/admin_money.txt", "<%s> %s ajusto el dinero en el banco de %s a %s.",
			ReturnDate(),
			PlayerName(playerid),
			PlayerName(userid),
			FormatNumber(strval(amount))
		);
	}
  	else if (!strcmp(type, "nivel", true))
	{
	    if (isnull(amount))
	        return SendSyntaxMessage(playerid, "/variable [id/nombre] [nivel] [cantidad]"COL_GREY".");

        SQL_Update_Int("accounts", PlayerName(userid), "SCORE", strval(amount)),
		PlayerData[userid][SCORE] = strval(amount);
		
		SendAdminAlert(COLOR_ADMIN, "\"%s\" ajustó el nivel de \"%s\". Ahora es %s.", PlayerName(playerid), PlayerName(userid), FormatNumber(strval(amount), ""));
        SendAdminAction(userid, "%s ajustó tu nivel. Ahora eres %s.", PlayerName(playerid), FormatNumber(strval(amount), ""));
        
  		Log_Write("logs/admin_general.txt", "<%s> %s ajusto el nivel de %s a %s.",
			ReturnDate(),
			PlayerName(playerid),
			PlayerName(userid),
			FormatNumber(strval(amount))
		);
	}
 	else if (!strcmp(type, "experiencia", true))
	{
	    if (isnull(amount))
	        return SendSyntaxMessage(playerid, "/variable [id/nombre] [experiencia] [cantidad]"COL_GREY".");

        SQL_Update_Int("accounts", PlayerName(userid), "EXPERIENCE", strval(amount)),
		PlayerData[userid][EXPERIENCE] = strval(amount);
		
		SendAdminAlert(COLOR_ADMIN, "\"%s\" ajustó los puntos de experiencia de \"%s\". Ahora tiene %s.", PlayerName(playerid), PlayerName(userid), FormatNumber(strval(amount), ""));
        SendAdminAction(userid, "%s ajustó tus puntos de experiencia. Ahora tienes %s.", PlayerName(playerid), FormatNumber(strval(amount), ""));
        
		Log_Write("logs/admin_general.txt", "<%s> %s ajusto la experiencia de %s a %s.",
			ReturnDate(),
			PlayerName(playerid),
			PlayerName(userid),
			FormatNumber(strval(amount))
		);
	}
   	else if (!strcmp(type, "minutos", true))
	{
	    if (isnull(amount))
	        return SendSyntaxMessage(playerid, "/variable [id/nombre] [minutos] [cantidad]"COL_GREY".");

        SQL_Update_Int("accounts", PlayerName(userid), "PLAYING_MINUTES", strval(amount)),
		PlayerData[userid][PLAYING_MINUTES] = strval(amount);

		SendAdminAlert(COLOR_ADMIN, "\"%s\" ajustó los minutos jugados de \"%s\". Ahora son %s.", PlayerName(playerid), PlayerName(userid), FormatNumber(strval(amount), ""));
        SendAdminAction(userid, "%s ajustó los minutos jugados. Ahora son %s.", PlayerName(playerid), FormatNumber(strval(amount), ""));
        
		Log_Write("logs/admin_general.txt", "<%s> %s ajusto los minutos de %s a %s.",
			ReturnDate(),
			PlayerName(playerid),
			PlayerName(userid),
			FormatNumber(strval(amount))
		);
	}
 	else if (!strcmp(type, "horas", true))
	{
	    if (isnull(amount))
	        return SendSyntaxMessage(playerid, "/variable [id/nombre] [horas] [cantidad]"COL_GREY".");

        SQL_Update_Int("accounts", PlayerName(userid), "PLAYING_HOURS", strval(amount)),
		PlayerData[userid][PLAYING_HOURS] = strval(amount);
		
		SendAdminAlert(COLOR_ADMIN, "\"%s\" ajustó el total de horas jugadas de \"%s\". Ahora son %s.", PlayerName(playerid), PlayerName(userid), FormatNumber(strval(amount), ""));
        SendAdminAction(userid, "%s ajustó el total de tus horas jugadas. Ahora son %s.", PlayerName(playerid), FormatNumber(strval(amount), ""));
        
		Log_Write("logs/admin_general.txt", "<%s> %s ajusto las horas de %s a %s.",
			ReturnDate(),
			PlayerName(playerid),
			PlayerName(userid),
			FormatNumber(strval(amount))
		);
	}
	return true;
}

alias:explotar("explode");
cmd:explotar(playerid, params[])
{
	static
	    userid;

    if (PlayerData[playerid][ADMIN_LEVEL] < 2)
	    return INVALID;

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/explotar [id/nombre]"COL_GREY".");

    if (IsPlayerNPC(userid))
	    return true;

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "El jugador no está conectado.");

    new
		Float:boomx,
		Float:boomy,
		Float:boomz;
		
    if (PlayerData[userid][ADMIN_LEVEL] > PlayerData[playerid][ADMIN_LEVEL])
    {
    	SetPlayerHealth(playerid, 1.0);
		GetPlayerPos(playerid, boomx, boomy, boomz);

		CreateExplosion(boomx, boomy , boomz, 7, 10);
		CreateExplosion(boomx, boomy , boomz, 6, 10);
	
        SendAdminAlert(COLOR_ADMIN, "\"%s\" auto-explotó por intentar explotar a \"%s\".", PlayerName(playerid), PlayerName(userid));
	    return true;
    }
    
	SetPlayerHealth(userid, 1.0);
	GetPlayerPos(userid, boomx, boomy, boomz);
	
	CreateExplosion(boomx, boomy , boomz, 7, 10);
	CreateExplosion(boomx, boomy , boomz, 6, 10);
	
	SendAdminAlert(COLOR_ADMIN, "\"%s\" hizo explotar a \"%s\".", PlayerName(playerid), PlayerName(userid));
	return true;
}

cmd:slap(playerid, params[])
{
	static
	    userid;

    if (PlayerData[playerid][ADMIN_LEVEL] < 2)
	    return INVALID;

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/slap [id/nombre]"COL_GREY".");

    if (IsPlayerNPC(userid))
	    return true;

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "El jugador no está conectado.");

    if (PlayerData[userid][ADMIN_LEVEL] > PlayerData[playerid][ADMIN_LEVEL])
	    return true;

	static
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(userid, x, y, z);
	SetPlayerPos(userid, x, y, z + 5);

	PlayerPlaySound(userid, 1130, 0.0, 0.0, 0.0);
	SendAdminAlert(COLOR_ADMIN, "\"%s\" golpeó a \"%s\".", PlayerName(playerid), PlayerName(userid));
	return true;
}

cmd:kick(playerid, params[])
{
	static
	    userid,
	    reason[128];

    if (PlayerData[playerid][ADMIN_LEVEL] < 1)
	    return INVALID;

	if (sscanf(params, "us[128]", userid, reason))
	    return SendSyntaxMessage(playerid, "/kick [id/nombre] [razón]"COL_GREY".");

    if (IsPlayerNPC(userid))
	    return true;

	if (userid == INVALID_PLAYER_ID || (IsPlayerConnected(userid)))
	    return SendErrorMessage(playerid, "El jugador no está conectado.");

    if (PlayerData[userid][ADMIN_LEVEL] > PlayerData[playerid][ADMIN_LEVEL])
	    return true;
	    
	SendAdminAlert(COLOR_ADMIN, "\"%s\" ha sido expulsado por \"%s\", razón: %s.", PlayerName(userid), PlayerName(playerid), reason),
	Kick(userid);
	return true;
}

cmd:name(playerid, params[])
{
	static
	    userid;

    if (PlayerData[playerid][ADMIN_LEVEL] < 1)
	    return INVALID;

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/name [id/nombre]"COL_GREY".");

    if (IsPlayerNPC(userid))
	    return true;

	if (userid == INVALID_PLAYER_ID || (IsPlayerConnected(userid)))
	    return SendErrorMessage(playerid, "El jugador no está conectado.");

    if (PlayerData[userid][ADMIN_LEVEL] > PlayerData[playerid][ADMIN_LEVEL])
	    return true;

	SendAdminAlert(COLOR_ADMIN, "\"%s\" ha sido expulsado desde /name por \"%s\", razón: Nombre irreal.", PlayerName(userid), PlayerName(playerid));
	
 	SendClientMessage(userid, COLOR_TOMATO, "Has sido expulsado por poseer un "COL_WHITE"nombre irreal"COL_TOMATO".");
	SendClientMessage(userid, COLOR_WHITE, "1. Tu nombre debe cumplir con el formato "COL_TOMATO"Nombre_Apellido"COL_WHITE".");
	SendClientMessage(userid, COLOR_WHITE, "2. Tanto el nombre como el apellido "COL_TOMATO"deben ser reales, no ficticios"COL_WHITE".");
	SendClientMessage(userid, COLOR_WHITE, "3. No se permite utilizar apodo, pseudónimo, seudónimo o sobrenombre.");
    SendClientMessage(userid, COLOR_TOMATO, "Sabiendo esto; vuelve a ingresar con el formato exigido. ¡Gracias!");
    
	Kick(userid);
	return true;
}

cmd:congelar(playerid, params[])
{
	static
	    userid;

    if (PlayerData[playerid][ADMIN_LEVEL] < 2)
	    return INVALID;

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/congelar [id/nombre]"COL_GREY".");

    if (IsPlayerNPC(userid))
	    return true;

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "El jugador no está conectado.");

    if (PlayerData[userid][ADMIN_LEVEL] > PlayerData[playerid][ADMIN_LEVEL])
	    return true;

	TogglePlayerControllable(playerid, false);
	
	SendAdminAlert(COLOR_ADMIN, "\"%s\" congeló a \"%s\".", PlayerName(playerid), PlayerName(userid));
	SendAdminAction(userid, "%s te congeló.", PlayerName(playerid));
	return true;
}

cmd:descongelar(playerid, params[])
{
	static
	    userid;

    if (PlayerData[playerid][ADMIN_LEVEL] < 2)
	    return INVALID;

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/descongelar [id/nombre]"COL_GREY".");

    if (IsPlayerNPC(userid))
	    return true;

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "El jugador no está conectado.");

	TogglePlayerControllable(playerid, true);
	
 	SendAdminAlert(COLOR_ADMIN, "\"%s\" descongeló a \"%s\".", PlayerName(playerid), PlayerName(userid));
 	SendAdminAction(userid, "%s te descongeló.", PlayerName(playerid));
	return true;
}

cmd:spawn(playerid, params[])
{
	static
	    userid;

    if (PlayerData[playerid][ADMIN_LEVEL] < 2)
	    return INVALID;

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/spawn [id/nombre]"COL_GREY".");

    if (IsPlayerNPC(userid))
	    return true;

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "El jugador no está conectado.");

	if (!IsConnected(userid))
	    return SendErrorMessage(playerid, "No esta spawneado.");

    SetDefaultSpawn(userid);

 	SendAdminAlert(COLOR_ADMIN, "\"%s\" envió al spawn a \"%s\".", PlayerName(playerid), PlayerName(userid));
	SendAdminAction(userid, "%s te envió al spawn.", PlayerName(playerid));
	return true;
}

cmd:setskin(playerid, params[])
{
	static
	    userid,
		skinid;

    if (PlayerData[playerid][ADMIN_LEVEL] < 2)
	    return INVALID;

	if (sscanf(params, "ud", userid, skinid))
	    return SendSyntaxMessage(playerid, "/setskin [id/nombre] [skin]"COL_GREY".");

    if (IsPlayerNPC(userid))
	    return true;

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "El jugador no está conectado.");

	if (skinid < 0 || skinid > 311)
	    return SendErrorMessage(playerid, "Desde 0 hasta 311.");

	SetPlayerSkin(userid, skinid);
	
	SQL_Update_Int("accounts", PlayerName(userid), "SKIN", skinid),
	PlayerData[userid][SKIN] = skinid;

 	SendAdminAlert(COLOR_ADMIN, "\"%s\" cambió el skin de \"%s\". Ahora es %d.", PlayerName(playerid), PlayerName(userid), skinid);
	SendAdminAction(userid, "%s cambió tu skin. Ahora tienes el %d.", PlayerName(playerid), skinid);
	return true;
}

alias:traer("get");
cmd:traer(playerid, params[])
{
	static
	    userid;

	if (PlayerData[playerid][ADMIN_LEVEL] < 2)
	    return INVALID;

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/traer [id/nombre]"COL_GREY".");

    if (IsPlayerNPC(userid))
	    return true;

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "El jugador no está conectado.");

	if (!IsConnected(userid))
		return SendErrorMessage(playerid, "Ese jugador todavía está ingresando...");

	SendPlayerToPlayer(userid, playerid);
	
	SendAdminAction(playerid, "Has traido a \"%s\" hacia ti.", PlayerName(userid));
	SendClientMessageEx(userid, COLOR_TOMATO, "%s te llevó hacia su posición.", PlayerName(playerid));
	return true;
}

cmd:setinterior(playerid, params[])
{
	static
		userid,
	    interior;

	if (PlayerData[playerid][ADMIN_LEVEL] < 2)
	    return INVALID;

	if (sscanf(params, "ud", userid, interior))
		return SendSyntaxMessage(playerid, "/setinterior [id/nombre] [interior]"COL_GREY".");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "El jugador no está conectado.");

	SetPlayerInterior(userid, interior);
	
	SQL_Update_Int("accounts", PlayerName(userid), "INTERIOR", interior),
	PlayerData[userid][INTERIOR] = interior;
	
    SendAdminAlert(COLOR_ADMIN, "\"%s\" cambió el interior de \"%s\" a %d.", PlayerName(playerid), PlayerName(userid), interior);
    SendAdminAction(userid, "%s cambió tu interior. Ahora es %d.", PlayerName(playerid), interior);
	return true;
}

cmd:setvw(playerid, params[])
{
	static
		userid,
	    world;

	if (PlayerData[playerid][ADMIN_LEVEL] < 1)
	    return INVALID;

	if (sscanf(params, "ud", userid, world))
		return SendSyntaxMessage(playerid, "/setvw [id/nombre] [world]"COL_GREY".");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "El jugador no está conectado.");

	SetPlayerVirtualWorld(userid, world);
	
	SQL_Update_Int("accounts", PlayerName(userid), "WORLD", world),
	PlayerData[userid][WORLD] = world;
	
    SendAdminAlert(COLOR_ADMIN, "\"%s\" cambió el mundo virtual de \"%s\" a %d.", PlayerName(playerid), PlayerName(userid), world);
    SendAdminAction(userid, "%s cambió tu mundo virtual. Ahora es %d.", PlayerName(playerid), world);
	return true;
}

alias:mandara("gotoa");
cmd:mandara(playerid, params[])
{
	static
	    userid,
	    targetid;

    if (PlayerData[playerid][ADMIN_LEVEL] < 2)
	    return INVALID;

	if (sscanf(params, "uu", userid, targetid))
	    return SendSyntaxMessage(playerid, "/mandara [id/nombre] [id/nombre]"COL_GREY".");

    if (IsPlayerNPC(userid))
	    return true;

	if (userid == INVALID_PLAYER_ID || targetid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Uno de ellos no esta conectado.");

	SendPlayerToPlayer(userid, targetid);

	SendAdminAlert(COLOR_ADMIN, "\"%s\" llevó a \"%s\" hasta \"%s\".", PlayerName(playerid), PlayerName(userid), PlayerName(targetid));
    SendAdminAction(userid, "%s te llevó hacia %s.", PlayerName(playerid), PlayerName(targetid));
	return true;
}
