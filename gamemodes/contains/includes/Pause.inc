/* Sistema de detección de pausa por Benjes */

#if !defined PAUSE_LIMIT
    #define  PAUSE_LIMIT (3)
#endif

#include <YSI_Coding\y_hooks>

new static lastPlayerUpdate[MAX_PLAYERS];
new static bool:isPlayerPaused[MAX_PLAYERS];
new static playerTimer[MAX_PLAYERS];

stock bool:IsPlayerPaused(playerid)
{
    return IsPlayerConnected(playerid) && isPlayerPaused[playerid];
}

hook OnPlayerConnect(playerid)
{
    lastPlayerUpdate[playerid] = gettime();

    playerTimer[playerid] = SetTimerEx("CheckPlayerPause", 1000, 1, "i", playerid);
}

hook OnPlayerDisconnect(playerid, reason)
{
    KillTimer(playerTimer[playerid]);
}

hook OnPlayerUpdate(playerid)
{
    if (IsPlayerPaused(playerid))
    {
        isPlayerPaused[playerid] = false;

        CallLocalFunction("OnPlayerResume", "ii", playerid, gettime() - lastPlayerUpdate[playerid]);
    }

    lastPlayerUpdate[playerid] = gettime();
}

forward CheckPlayerPause(playerid);
public  CheckPlayerPause(playerid)
{
    new _state = GetPlayerState(playerid);
    new bool:_updates = (
        _state != PLAYER_STATE_NONE &&
        _state != PLAYER_STATE_SPECTATING
    );

    new lastUpdateDifference = gettime() - lastPlayerUpdate[playerid];

    if (lastUpdateDifference > PAUSE_LIMIT && !IsPlayerPaused(playerid) && _updates)
    {
        isPlayerPaused[playerid] = true;

        CallLocalFunction("OnPlayerPause", "i", playerid);
    }
}
