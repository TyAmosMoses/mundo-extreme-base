/* Variables de jugadores */

#include "contains/server/SQL"

new
	LoginAttempts[MAX_PLAYERS],
	LoginObjects[MAX_PLAYERS][5];

#define MAX_DYNAMIC_TIMER (150)

new
	DynamicTimer[MAX_PLAYERS][MAX_DYNAMIC_TIMER];
	
new
	PlayerBar:ProgressLoading[MAX_PLAYERS] = {INVALID_PLAYER_BAR_ID, ...},
	bool:ViewLoadBar[MAX_PLAYERS];
	
new
	InformationShowing[MAX_PLAYERS];

enum playerData
{
	SQL_ID,
	NAME[MAX_PLAYER_NAME + 1],
	IP[18],
	CREATED,
	PASSWORD[64 + 1],
	SECURITY_QUESTION[128],
	SECURITY_ANSWER[64 + 1],
	EMAIL[64],
	REGISTER_TIMESTAMP[36],
	LASTLOGIN_TIMESTAMP[36],
	PlayerText:TEXT_DRAW[11],
	LOGGED,
	SCORE,
	EXPERIENCE,
	PLAYING_MINUTES,
	PLAYING_HOURS,
	MONEY,
	BANK_MONEY,
	SKIN,
	GENDER,
	BIRTHDATE[24],
  	ADMIN_LEVEL,
  	ADMIN_DUTY,
  	ADMIN_DUTY_TIME,
  	ADMIN_DISABLE,
	VIP_LEVEL,
	Float:POSITION[4],
	Float:HEALTH,
	Float:ARMOUR,
	WORLD,
	INTERIOR,
	ENTRANCE,
	HOUSE,
	BUSINESSES,
	INJURED,
	KILLED,
	Text3D:TAG,
 	FACTION,
	FACTION_ID,
	FACTION_RANK,
	DESCRIPTION[64 + 1],
	HIDE_TAG,
	SUGGESTION_SHOW,
	SUGGESTION_TIMER,
	BOX_SHOW,
	BOX_TIMER,
	INFO_SHOW,
	INFO_TIMER,
	JET_PACK,
	TRY_TIME,
	REPORT_TIME,
	DOUBT_TIME,
	IS_ENGINE,
	ENGINE_TIMER,
	IS_LIGHTS_CAR,
	LIGHTS_CAR_TIMER
};

new
	PlayerData[MAX_PLAYERS][playerData];

new
	PlayerText:TEXT_DRAW_ALL[MAX_PLAYERS][2],
	PlayerText:TEXT_DRAW_SPEEDO[MAX_PLAYERS][12],
	PlayerText:TEXT_DRAW_GAS[MAX_PLAYERS][5],
	PlayerText:TEXT_DRAW_NEEDLE[MAX_PLAYERS][4],
	PlayerText:TEXT_DRAW_NEEDLE_GAS[MAX_PLAYERS],
	SpeedoShowing[MAX_PLAYERS];
	
Save_Character(playerid)
{
	if (!PlayerData[playerid][LOGGED])
		return false;

	static
	    query_0[512 + 23],
	    query_1[512],
		name[MAX_PLAYER_NAME];

	GetPlayerName(playerid, name, MAX_PLAYER_NAME);

	if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
	{
	    PlayerData[playerid][INTERIOR] = GetPlayerInterior(playerid);
	    PlayerData[playerid][WORLD] = GetPlayerVirtualWorld(playerid);

	    GetPlayerPos(playerid, PlayerData[playerid][POSITION][0], PlayerData[playerid][POSITION][1], PlayerData[playerid][POSITION][2]);
	    GetPlayerFacingAngle(playerid, PlayerData[playerid][POSITION][3]);

	    GetPlayerHealth(playerid, PlayerData[playerid][HEALTH]);
	    GetPlayerArmour(playerid, PlayerData[playerid][ARMOUR]);

	    if (!PlayerData[playerid][KILLED] && PlayerData[playerid][HEALTH] == 0.0)
		{
	        PlayerData[playerid][HEALTH] = 100.0;
		}
	}

	format(query_0, sizeof(query_0), "UPDATE `accounts` SET `NAME` = '%s', `CREATED` = '%d', \
		`SECURITY_QUESTION` = '%s', `SECURITY_ANSWER` = '%s', `SCORE` = '%d', `EXPERIENCE` = '%d', `PLAYING_MINUTES` = '%d', \
		`PLAYING_HOURS` = '%d', `MONEY` = '%d', `BANK_MONEY` = '%d', `SKIN` = '%d', `GENDER` = '%d', `BIRTHDATE` = '%s', `ADMIN_LEVEL` = '%d' WHERE `SQL_ID` = '%d'",
		name,
        PlayerData[playerid][CREATED],
        Return_Escaped(PlayerData[playerid][SECURITY_QUESTION]),
        Return_Escaped(PlayerData[playerid][SECURITY_ANSWER]),
        PlayerData[playerid][SCORE],
        PlayerData[playerid][EXPERIENCE],
        PlayerData[playerid][PLAYING_MINUTES],
        PlayerData[playerid][PLAYING_HOURS],
        PlayerData[playerid][MONEY],
        PlayerData[playerid][BANK_MONEY],
        PlayerData[playerid][SKIN],
        PlayerData[playerid][GENDER],
        Return_Escaped(PlayerData[playerid][BIRTHDATE]),
        PlayerData[playerid][ADMIN_LEVEL],
        PlayerData[playerid][SQL_ID]
	);

	mysql_tquery(SQL_CONNECTION, query_0);

    format(query_1, sizeof(query_1),
		"UPDATE `accounts` SET `ADMIN_DUTY_TIME` = '%d', `VIP_LEVEL` = '%d', `POSITION_X` = '%.4f', `POSITION_Y` = '%.4f', `POSITION_Z` = '%.4f', `POSITION_ANGLE` = '%.4f', \
		`HEALTH` = '%.4f', `ARMOUR` = '%.4f', `WORLD` = '%d', `INTERIOR` = '%d', `ENTRANCE` = '%d', `HOUSE` = '%d', `BUSINESSES` = '%d', `INJURED` = '%d', `KILLED` = '%d', \
	 	`FACTION` = '%d', `FACTION_ID` = '%d', `FACTION_RANK` = '%d', `DESCRIPTION` = '%s' WHERE `SQL_ID` = '%d'",
    	PlayerData[playerid][ADMIN_DUTY_TIME],
		PlayerData[playerid][VIP_LEVEL],
		PlayerData[playerid][POSITION][0],
		PlayerData[playerid][POSITION][1],
		PlayerData[playerid][POSITION][2],
		PlayerData[playerid][POSITION][3],
		PlayerData[playerid][HEALTH],
		PlayerData[playerid][ARMOUR],
		PlayerData[playerid][WORLD],
		PlayerData[playerid][INTERIOR],
		PlayerData[playerid][ENTRANCE],
		PlayerData[playerid][HOUSE],
		PlayerData[playerid][BUSINESSES],
		PlayerData[playerid][INJURED],
		PlayerData[playerid][KILLED],
		PlayerData[playerid][FACTION],
		PlayerData[playerid][FACTION_ID],
		PlayerData[playerid][FACTION_RANK],
		Return_Escaped(PlayerData[playerid][DESCRIPTION]),
        PlayerData[playerid][SQL_ID]
	);

	mysql_tquery(SQL_CONNECTION, query_1);
	return true;
}

Data_Reset(playerid)
{
    ViewLoadBar[playerid] = false,
    InformationShowing[playerid] = 0;
    
    for (new timer = 0; timer < MAX_DYNAMIC_TIMER; timer ++)
    {
		if (DynamicTimer[playerid][timer] != -1)
 		{
			KillTimer(DynamicTimer[playerid][timer]);
			DynamicTimer[playerid][timer] = -1;
		}
	}
	
	/* TextDraw´s: Generales */
	for (new i = 0; i < 10; i ++) PlayerTextDrawHide(playerid, PlayerData[playerid][TEXT_DRAW][i]), PlayerData[playerid][TEXT_DRAW][i] = PlayerText:INVALID_TEXT_DRAW;

  	if (ProgressLoading[playerid] != INVALID_PLAYER_BAR_ID)
	{
    	DestroyPlayerProgressBar(playerid, ProgressLoading[playerid]);
    	ProgressLoading[playerid] = INVALID_PLAYER_BAR_ID;
	}

	/* TextDraw´s: Velocímetro */
	for (new i = 0; i < 2; i ++) PlayerTextDrawHide(playerid, TEXT_DRAW_ALL[playerid][i]), TEXT_DRAW_ALL[playerid][i] = PlayerText:INVALID_TEXT_DRAW; // Círculos

	for (new i = 0; i < 12; i ++) PlayerTextDrawHide(playerid, TEXT_DRAW_SPEEDO[playerid][i]), TEXT_DRAW_SPEEDO[playerid][i] = PlayerText:INVALID_TEXT_DRAW; // Speedo

	for (new i = 0; i < 5; i ++) PlayerTextDrawHide(playerid, TEXT_DRAW_GAS[playerid][i]), TEXT_DRAW_GAS[playerid][i] = PlayerText:INVALID_TEXT_DRAW; // Gas

	for (new i = 0; i < 4; i ++) PlayerTextDrawHide(playerid, TEXT_DRAW_NEEDLE[playerid][i]), TEXT_DRAW_NEEDLE[playerid][i] = PlayerText:INVALID_TEXT_DRAW; // Aguja velocímetro
	
	PlayerTextDrawHide(playerid, TEXT_DRAW_NEEDLE_GAS[playerid]), TEXT_DRAW_NEEDLE_GAS[playerid] = PlayerText:INVALID_TEXT_DRAW; // Aguja gasolímetro
	
    LoginAttempts[playerid] = 0;

	PlayerData[playerid][SQL_ID] = -1,
	PlayerData[playerid][CREATED] = 0,
	PlayerData[playerid][PASSWORD][0] = 0,
	PlayerData[playerid][SECURITY_QUESTION][0] = 0,
	PlayerData[playerid][SECURITY_ANSWER][0] = 0,
	PlayerData[playerid][EMAIL][0] = 0,
	PlayerData[playerid][LOGGED] = 0,
	PlayerData[playerid][SCORE] = 0,
	PlayerData[playerid][EXPERIENCE] = 0,
	PlayerData[playerid][PLAYING_MINUTES] = 0,
	PlayerData[playerid][PLAYING_HOURS] = 0,
	PlayerData[playerid][MONEY] = 0,
	PlayerData[playerid][BANK_MONEY] = 0,
	PlayerData[playerid][SKIN] = 0,
	PlayerData[playerid][GENDER] = 0,
	PlayerData[playerid][BIRTHDATE][0] = 0,
	PlayerData[playerid][ADMIN_LEVEL] = 0,
	PlayerData[playerid][ADMIN_DUTY] = 0,
	PlayerData[playerid][ADMIN_DUTY_TIME] = 0,
    PlayerData[playerid][ADMIN_DISABLE] = 0,
	PlayerData[playerid][VIP_LEVEL] = 0,
	PlayerData[playerid][WORLD] = 0,
	PlayerData[playerid][INTERIOR] = 0,
	PlayerData[playerid][ENTRANCE] = INVALID,
	PlayerData[playerid][HOUSE] = INVALID,
	PlayerData[playerid][BUSINESSES] = INVALID,
	PlayerData[playerid][INJURED] = 0,
	PlayerData[playerid][KILLED] = 0,

	ResetNameTag(playerid);

	PlayerData[playerid][FACTION] = INVALID,
	PlayerData[playerid][FACTION_ID] = INVALID,
	PlayerData[playerid][FACTION_RANK] = INVALID,
	PlayerData[playerid][DESCRIPTION][0] = 0;
    PlayerData[playerid][JET_PACK] = 0;
    PlayerData[playerid][TRY_TIME] = 0;
    PlayerData[playerid][REPORT_TIME] = 0;
    PlayerData[playerid][DOUBT_TIME] = 0;

	ResetTimers(playerid),
	Announce_Clear(playerid),
	Doubt_Clear(playerid),
	Report_Clear(playerid);

	SpeedoShowing[playerid] = 0;
}

ResetNameTag(playerid)
{
    foreach (new i : Player)
	{
		ShowPlayerNameTagForPlayer(i, playerid, 1);
	}

	if (IsValidDynamic3DTextLabel(PlayerData[playerid][TAG]))
	    DestroyDynamic3DTextLabel(PlayerData[playerid][TAG]);

    PlayerData[playerid][HIDE_TAG] = 0,
    PlayerData[playerid][TAG] = Text3D:INVALID_3DTEXT_ID;
    return true;
}

ResetTimers(playerid)
{
 	if (PlayerData[playerid][IS_ENGINE])
 	{
 	    PlayerData[playerid][IS_ENGINE] = 0,
	    KillTimer(PlayerData[playerid][ENGINE_TIMER]);
	}
    return true;
}

PlayerName(playerid)
{
	new
	    name[MAX_PLAYER_NAME + 1];

	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

stock SQL_IsLogged(playerid)
{
	return (PlayerData[playerid][LOGGED]);
}

stock IsConnected(playerid)
{
	if (playerid < 0 || playerid >= MAX_PLAYERS)
	    return false;

	return (!PlayerData[playerid][KILLED]) && (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING
		&& GetPlayerState(playerid) != PLAYER_STATE_NONE && GetPlayerState(playerid) != PLAYER_STATE_WASTED);
}
