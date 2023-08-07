new bool:ACTimeout[MAX_PLAYERS char];
new ACTimer[MAX_PLAYERS];

PauseAnticheatForPlayer(playerid)
{
	ACTimeout{playerid} = true;
	ACTimer[playerid] = SetTimerEx("OnAnticheatPauseEnd", 5000, false, "i", playerid);
	return true;
}
IsAnticheatPaused(playerid)
{
	if(ACTimeout{playerid}) return true;
	return false;
}

forward OnAnticheatPauseEnd(playerid);
public OnAnticheatPauseEnd(playerid)
{
	ACTimeout{playerid} = false;
	ACTimer[playerid] = 0;
	return true;
}

#include "modules/server/anticheat/weapon.pwn"
#include "modules/server/anticheat/cslide.pwn"
#include "modules/server/anticheat/nostun.pwn"
#include "modules/server/anticheat/aimbot.pwn"
#include "modules/server/anticheat/aimbotcheck.pwn"
//#include "modules/server/anticheat/anticbug.pwn"