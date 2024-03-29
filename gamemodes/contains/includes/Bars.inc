#if !defined MAX_PLAYER_BARS
	#define MAX_PLAYER_BARS (5)
#endif

#define INVALID_PLAYER_BAR_VALUE	(Float:0xFFFFFFFF)
#define INVALID_PLAYER_BAR_ID		(PlayerBar:-1)
#define pb_percent(%1,%2,%3,%4)	((%1 - 6.0) + ((((%1 + 6.0 + %2 - 2.0) - %1) / %3) * %4))

forward PlayerBar:CreatePlayerProgressBar(playerid, Float:x, Float:y, Float:width=55.5, Float:height=3.2, color, Float:max=100.0);
forward Float:GetPlayerProgressBarValue(playerid, PlayerBar:barid);
forward Progress_OnGameModeInit();
forward Progress_OnPlayerDisconnect(playerid, reason);

enum E_BAR_DATA
{
	Float:pbar_x,
	Float:pbar_y,
	Float:pbar_w,
	Float:pbar_h,
	Float:pbar_m,
	Float:pbar_v,
	pbar_colour,
	bool:pbar_valid
}

enum E_BAR_TEXT_DRAW
{
	PlayerText:pbar_textdraw1,
	PlayerText:pbar_textdraw2,
	PlayerText:pbar_textdraw3,
}

static
	PlayerBars[MAX_PLAYERS][MAX_PLAYER_BARS][E_BAR_DATA],
	PlayerBarText[MAX_PLAYERS][MAX_PLAYER_BARS][E_BAR_TEXT_DRAW],
	bool: ProgressBar_hOPD = false;

stock PlayerBar:CreatePlayerProgressBar(playerid, Float:x, Float:y, Float:width=55.5, Float:height=3.2, color, Float:max=100.0)
{
	new
		barid;

	for (barid = 0; barid < MAX_PLAYER_BARS; ++barid)
		if (!PlayerBars[playerid][barid][pbar_valid]) break;

	if (PlayerBars[playerid][barid][pbar_valid] || barid == MAX_PLAYER_BARS)
		return INVALID_PLAYER_BAR_ID;
		
	if (barid >= MAX_PLAYER_BARS)
	    return INVALID_PLAYER_BAR_ID;

	new
		PlayerText:in_t = PlayerBarText[playerid][barid][pbar_textdraw1] = CreatePlayerTextDraw(playerid, x, y, "_");
		
	PlayerTextDrawUseBox		(playerid, in_t, 1);
	PlayerTextDrawTextSize		(playerid, in_t, x + width, 0.0);
	PlayerTextDrawLetterSize	(playerid, in_t, 1.0, height / 10);
	PlayerTextDrawBoxColor		(playerid, in_t, 0x00000033);

	in_t = PlayerBarText[playerid][barid][pbar_textdraw2] = CreatePlayerTextDraw(playerid, x + 1.2, y + 2.15, "_");
	PlayerTextDrawUseBox		(playerid, in_t, 1);
	PlayerTextDrawTextSize		(playerid, in_t, x + width - 2.0, 0.0);
	PlayerTextDrawLetterSize	(playerid, in_t, 1.0, height / 10 - 0.35);
	PlayerTextDrawBoxColor		(playerid, in_t, (color & 0xFFFFFF33) | (0x66 & ((color & 0x00000033) / 2)));

	in_t = PlayerBarText[playerid][barid][pbar_textdraw3] = CreatePlayerTextDraw(playerid, x + 1.2, y + 2.15, "_");
	PlayerTextDrawTextSize		(playerid, in_t, pb_percent(x, width, max, 1.0), 0.0);
	PlayerTextDrawLetterSize	(playerid, in_t, 1.0, height / 10 - 0.35);
	PlayerTextDrawBoxColor		(playerid, in_t, color);

	PlayerBars[playerid][barid][pbar_x] = x;
	PlayerBars[playerid][barid][pbar_y] = y;
	PlayerBars[playerid][barid][pbar_w] = width;
	PlayerBars[playerid][barid][pbar_h] = height;
	PlayerBars[playerid][barid][pbar_m] = max;
	PlayerBars[playerid][barid][pbar_colour] = color;
	PlayerBars[playerid][barid][pbar_valid] = true;
	return PlayerBar:barid;
}

stock DestroyPlayerProgressBar(playerid, PlayerBar:barid)
{
	if (barid != INVALID_PLAYER_BAR_ID && PlayerBar:-1 < barid < PlayerBar:MAX_PLAYER_BARS)
	{
		if (!PlayerBars[playerid][_:barid][pbar_valid])
			return false;

		PlayerTextDrawDestroy(playerid, PlayerBarText[playerid][_:barid][pbar_textdraw1]);
		PlayerTextDrawDestroy(playerid, PlayerBarText[playerid][_:barid][pbar_textdraw2]);
		PlayerTextDrawDestroy(playerid, PlayerBarText[playerid][_:barid][pbar_textdraw3]);

		PlayerBars[playerid][_:barid][pbar_x] = 0.0;
		PlayerBars[playerid][_:barid][pbar_y] = 0.0;
		PlayerBars[playerid][_:barid][pbar_w] = 0.0;
		PlayerBars[playerid][_:barid][pbar_h] = 0.0;
		PlayerBars[playerid][_:barid][pbar_m] = 0.0;
		PlayerBars[playerid][_:barid][pbar_v] = 0.0;
		PlayerBars[playerid][_:barid][pbar_colour] = 0;
		PlayerBars[playerid][_:barid][pbar_valid] = false;
		return true;
	}
	return false;
}

stock ShowPlayerProgressBar(playerid, PlayerBar:barid)
{
	if (IsPlayerConnected(playerid) && barid != INVALID_PLAYER_BAR_ID && PlayerBar:-1 < barid < PlayerBar:MAX_PLAYER_BARS)
	{
		if (!PlayerBars[playerid][_:barid][pbar_valid])
			return false;

		PlayerTextDrawShow(playerid, PlayerBarText[playerid][_:barid][pbar_textdraw1]);
		PlayerTextDrawShow(playerid, PlayerBarText[playerid][_:barid][pbar_textdraw2]);
		PlayerTextDrawShow(playerid, PlayerBarText[playerid][_:barid][pbar_textdraw3]);
		return true;
	}
	return false;
}

stock HidePlayerProgressBar(playerid, PlayerBar:barid)
{
	if (IsPlayerConnected(playerid) && barid != INVALID_PLAYER_BAR_ID && PlayerBar:-1 < barid < PlayerBar:MAX_PLAYER_BARS)
	{
		if (!PlayerBars[playerid][_:barid][pbar_valid])
			return false;

		PlayerTextDrawHide(playerid, PlayerBarText[playerid][_:barid][pbar_textdraw1]);
		PlayerTextDrawHide(playerid, PlayerBarText[playerid][_:barid][pbar_textdraw2]);
		PlayerTextDrawHide(playerid, PlayerBarText[playerid][_:barid][pbar_textdraw3]);
		return true;
	}
	return false;
}

stock SetPlayerProgressBarValue(playerid, PlayerBar:barid, Float:value)
{
	if (barid == INVALID_PLAYER_BAR_ID || PlayerBar:MAX_PLAYER_BARS < barid < PlayerBar:-1)
		return false;

	if (PlayerBars[playerid][_:barid][pbar_valid])
	{
		value =
			(value < 0.0) ? (0.0) : (value > PlayerBars[playerid][_:barid][pbar_m]) ? (PlayerBars[playerid][_:barid][pbar_m]) : (value);

		PlayerTextDrawUseBox(playerid, PlayerBarText[playerid][_:barid][pbar_textdraw3], value > 0.0);

        PlayerBars[playerid][_:barid][pbar_v] = value;

		PlayerTextDrawTextSize(playerid, PlayerBarText[playerid][_:barid][pbar_textdraw3],
			pb_percent(PlayerBars[playerid][_:barid][pbar_x], PlayerBars[playerid][_:barid][pbar_w], PlayerBars[playerid][_:barid][pbar_m], value), 0.0);

		return true;
	}
	return false;
}

stock Float:GetPlayerProgressBarValue(playerid, PlayerBar:barid)
{
	if (barid == INVALID_PLAYER_BAR_ID || PlayerBar:MAX_PLAYER_BARS < barid < PlayerBar:-1)
		return INVALID_PLAYER_BAR_VALUE;

	if (PlayerBars[playerid][_:barid][pbar_valid])
		return PlayerBars[playerid][_:barid][pbar_v];

	return INVALID_PLAYER_BAR_VALUE;
}

stock SetPlayerProgressBarMaxValue(playerid, PlayerBar:barid, Float:max)
{
	if (barid == INVALID_PLAYER_BAR_ID || PlayerBar:MAX_PLAYER_BARS < barid < PlayerBar:-1)
		return false;

	if (PlayerBars[playerid][_:barid][pbar_valid])
	{
		PlayerBars[playerid][_:barid][pbar_m] = max;
		SetPlayerProgressBarValue(playerid, barid, PlayerBars[playerid][_:barid][pbar_v]);
		return true;
	}
	return false;
}

stock SetPlayerProgressBarColor(playerid, PlayerBar:barid, color)
{
	if (barid == INVALID_PLAYER_BAR_ID || PlayerBar:MAX_PLAYER_BARS < barid < PlayerBar:-1)
		return false;

	if (PlayerBars[playerid][_:barid][pbar_valid])
	{
		PlayerBars[playerid][_:barid][pbar_colour] = color;
		PlayerTextDrawBoxColor(playerid, PlayerBarText[playerid][_:barid][pbar_textdraw1], 0x000000EE);

		PlayerTextDrawBoxColor(playerid, PlayerBarText[playerid][_:barid][pbar_textdraw2],
			(color & 0xFFFFFF33) | (0x66 & ((color & 0x000000FF) / 2)));

		PlayerTextDrawBoxColor(playerid, PlayerBarText[playerid][_:barid][pbar_textdraw3], color);
		return true;
	}
	return false;
}

stock UpdatePlayerProgressBar(playerid, PlayerBar:barid)
{
	return ShowPlayerProgressBar(playerid, barid);
}

public OnGameModeInit()
{
    ProgressBar_hOPD = funcidx("Progress_OnPlayerDisconnect") != -1;
    
    return (funcidx("Progress_OnGameModeInit")) ? CallLocalFunction("Progress_OnGameModeInit","") : (1);
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit Progress_OnGameModeInit

public OnPlayerDisconnect(playerid, reason)
{
	new
		i,
		bar_Index = 0;
		
	for (i = 0; i < MAX_PLAYER_BARS; i++)
	{
		for (bar_Index = 0; E_BAR_DATA: bar_Index < E_BAR_DATA; bar_Index++)
	    	PlayerBars[playerid][i][E_BAR_DATA: bar_Index] = 0;

		for (bar_Index = 0; E_BAR_TEXT_DRAW: bar_Index < E_BAR_TEXT_DRAW; bar_Index++)
	    	PlayerBarText[playerid][i][E_BAR_TEXT_DRAW: bar_Index] = _:0;

	}
	return (ProgressBar_hOPD) ? CallLocalFunction("Progress_OnPlayerDisconnect", "ii", playerid, reason) : (1);
}

#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect Progress_OnPlayerDisconnect
