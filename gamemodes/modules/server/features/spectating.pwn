//data
static pSpecLimit[MAX_PLAYERS];

//hooks
#include <pp-hooks>
hook public OnPlayerDeathFinished(playerid)
{
	foreach(new i: Player)
	{
		if(SpectatingPlayer[i] == playerid)
		{
			if(IsPlayerInAnyVehicle(playerid)) PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));
			else PlayerSpectatePlayer(i, playerid);
		}
	}
}

hook public OnPlayerDisconnect(playerid, reason)
{
	SpectatingPlayer[playerid] = -1;
	pSpecLimit[playerid] = 0;

	foreach(new i: Player)
	{
		if(SpectatingPlayer[i] == playerid)
		{
			SendClientMessage(i, -1, sprintf("{bf0000}Spectating: {808080}%s (%i) has disconnected, sending you to lobby.", GetName(playerid), playerid));
			StopSpectating(i);
		}
	}
}

hook public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_ONFOOT)
	{
		foreach(new i: Player)
		{
			if(SpectatingPlayer[i] == playerid)
			{
				PlayerSpectatePlayer(i, playerid);
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		new v = GetPlayerVehicleSeat(playerid);
		foreach(new i: Player)
		{
			if(SpectatingPlayer[i] == playerid)
			{
				PlayerSpectateVehicle(playerid, v);
			}
		}
	}
}

hook public OnPlayerUpdate(playerid)
{
	//scroll spectate system, lets players press their arrow keys to switch between players
	new keys, updown, leftright;
	GetPlayerKeys(playerid, keys, updown, leftright);
	if(SpectatingPlayer[playerid] != -1 && Account[playerid][Admin] != 0)
	{
		UpdateSpecTDs(playerid, SpectatingPlayer[playerid]);
		// if(keys & KEY_SPRINT)
		// {
		// 	PlayerSpectatePlayer(playerid, SpectatingPlayer[playerid]);
		// 	if(ActivityState[SpectatingPlayer[playerid]] == ACTIVITY_TDM)
		// 	{
		// 		CreateTDMMapping(playerid);
		// 	}
		// }


		//SendClientMessageToAll(COLOR_RED, sprintf("updown: %d leftright: %d", updown, leftright));
		if(leftright != 0)
		{
			if(GetTickCount()-pSpecLimit[playerid] > 666 || GetTickCount()-pSpecLimit[playerid] < 0)
			{
				pSpecLimit[playerid] = GetTickCount();
				new i = SpectatingPlayer[playerid];
				if(leftright == KEY_RIGHT) // Next
				{
					i++;
					if(i == MAX_PLAYERS) i = 0;
					while(!IsPlayerConnected(i) || SpectatingPlayer[i] != -1)
					{
						i++;
						if(i == MAX_PLAYERS) i = 0;
					}
				}
				else if(leftright == KEY_LEFT) // Prev
				{
					i--;
					if(i == -1) i = MAX_PLAYERS-1;
					while(!IsPlayerConnected(i) || SpectatingPlayer[i] != -1)
					{
						i--;
						if(i == -1) i = MAX_PLAYERS-1;
					}
				}
				SendClientMessage(playerid, -1, sprintf("{bf0000}Spectating: {808080}You are now spectating %s(%i). Player Mode: %s.", GetName(i), i, ReturnActivityDescription(ActivityState[i])));
				DestroySpecTDs(playerid);
				SpectatePlayer(playerid, i);
				CreateSpecTDs(playerid, i);
				UpdateSpecTDs(playerid, i);
				if(ActivityState[i] == ACTIVITY_TDM)
				{
					CreateTDMMapping(playerid);
				}
			}
		}
		else pSpecLimit[playerid] = 0; // If not holding, reset limit to allow tapping
	}
}

//commands
CMD<AD1>:spec(cmdid, playerid, params[])
{
	new target;
	if(sscanf( params, "u", target)) return SendClientMessage( playerid, -1, "USAGE: /spec(tate) [ID]");
	if(target == playerid) return SendClientMessage( playerid, -1, "{bf0000}Spectating: {808080}You cannot spectate yourself.");
	if(target == INVALID_PLAYER_ID) return SendClientMessage( playerid, -1, "{bf0000}Spectating: {808080}Player not found.");
	if(GetPlayerState(target) == PLAYER_STATE_WASTED) return SendClientMessage( playerid, -1, "{bf0000}Spectating: {808080}Player is respawning.");
	if(!IsPlayerInLobby(playerid)) HandleLobbyTransition(playerid);

	if(ActivityState[target] == ACTIVITY_TDM)
	{
		CreateTDMMapping(playerid);
	}
	DestroySpecTDs(playerid);
	SpectatePlayer(playerid, target);
	CreateSpecTDs(playerid, target);
	UpdateSpecTDs(playerid, target);
	SendClientMessage(playerid, -1, sprintf("{bf0000}(Spectate): {808080}You are now spectating %s(%i). Player Mode: %s.", GetName(target), target, ReturnActivityDescription(ActivityState[target])));
	return true;
}

CMD<AD1>:specoff(cmdid, playerid, params[])
{
	if(SpectatingPlayer[playerid] == -1) return SendClientMessage( playerid, -1, "{bf0000}Spectating: {808080}You are not spectating anyone.");
	DestroyAllPlayerObjects(playerid);
	SendClientMessage(playerid, -1, sprintf("{bf0000}Spectating: {808080}You are no longer spectating %s(%i).", GetName(SpectatingPlayer[playerid]), SpectatingPlayer[playerid]));
	StopSpectating(playerid);
	return true;
}

//functions
SpectatePlayer(playerid, target)
{
	SpectatingPlayer[playerid] = target;
	TogglePlayerSpectating(playerid, true);
	SetPlayerInterior(playerid, GetPlayerInterior(target));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(target));
	if(ActivityState[target] == ACTIVITY_ARENADM)
	{
		new arena = ActivityStateID[target];
		if(arena <= MAX_ARENAS)
		{
			if(strlen(ArenaInfo[arena][ArenaMapCallback])) CallLocalFunction(ArenaInfo[arena][ArenaMapCallback], "i", playerid);
		}
	}
	HideSessionStats(playerid);
	HideNetworkTDs(playerid);


	SetTimerEx("DelayedSpectate", 200, false, "ii", playerid, target);
	return true;
}

StopSpectating(playerid)
{
	SpectatingPlayer[playerid] = -1;
	TogglePlayerSpectating(playerid, false);
	SendPlayerToLobby(playerid);
	DestroySpecTDs(playerid);
	if(HudShow[playerid] == false)
	{
		HideSessionStats(playerid);
		HideNetworkTDs(playerid);
	}
	WallHack[playerid] = false;
	return true;
}

forward DelayedSpectate(playerid, target);
public DelayedSpectate(playerid, target)
{
	if(IsPlayerInAnyVehicle(target)) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(target));
	else PlayerSpectatePlayer(playerid, target);
}

new PlayerText:SpecPlayerFPSTD[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
new PlayerText:SpecPlayerPingTD[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
new PlayerText:SpecPlayerPLTD[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
new PlayerText:SpecPlayerNameTD[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
new PlayerText:SpecPlayerIPTD[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
new PlayerText:SpecPlayerIDTD[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
new PlayerText:SpecPlayerHITPCTD[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};


DestroySpecTDs(playerid)
{
	PlayerTextDrawDestroy(playerid, SpecPlayerFPSTD[playerid]);
	PlayerTextDrawDestroy(playerid, SpecPlayerPingTD[playerid]);
	PlayerTextDrawDestroy(playerid, SpecPlayerPLTD[playerid]);
	PlayerTextDrawDestroy(playerid, SpecPlayerNameTD[playerid]);
	PlayerTextDrawDestroy(playerid, SpecPlayerIPTD[playerid]);
	PlayerTextDrawDestroy(playerid, SpecPlayerIDTD[playerid]);
	PlayerTextDrawDestroy(playerid, SpecPlayerHITPCTD[playerid]);
}

CreateSpecTDs(playerid, targetid)
{
	SpecPlayerNameTD[playerid] = CreatePlayerTextDraw(playerid, 547.000000, 16.000000, sprintf("%s", pName[targetid]));
	PlayerTextDrawBackgroundColor(playerid, SpecPlayerNameTD[playerid], 255);
	PlayerTextDrawFont(playerid, SpecPlayerNameTD[playerid], 2);
	PlayerTextDrawLetterSize(playerid, SpecPlayerNameTD[playerid], 0.200000, 1.000000);
	PlayerTextDrawColor(playerid, SpecPlayerNameTD[playerid], -16776961);
	PlayerTextDrawSetOutline(playerid, SpecPlayerNameTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SpecPlayerNameTD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SpecPlayerNameTD[playerid], 0);

	new Player_IP[16];	GetPlayerIp(targetid, Player_IP, 16);
	SpecPlayerIPTD[playerid] = CreatePlayerTextDraw(playerid, 547.000000, 25.000000, sprintf("IP:~W~ %s", Player_IP));
	PlayerTextDrawBackgroundColor(playerid, SpecPlayerIPTD[playerid], 255);
	PlayerTextDrawFont(playerid, SpecPlayerIPTD[playerid], 1);
	PlayerTextDrawLetterSize(playerid, SpecPlayerIPTD[playerid], 0.200000, 1.000000);
	PlayerTextDrawColor(playerid, SpecPlayerIPTD[playerid], -1397969665);
	PlayerTextDrawSetOutline(playerid, SpecPlayerIPTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SpecPlayerIPTD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SpecPlayerIPTD[playerid], 0);

	SpecPlayerFPSTD[playerid] = CreatePlayerTextDraw(playerid, 547.000000, 34.000000, sprintf("FPS:~W~ %i", pFPS[targetid]));
	PlayerTextDrawBackgroundColor(playerid, SpecPlayerFPSTD[playerid], 255);
	PlayerTextDrawFont(playerid, SpecPlayerFPSTD[playerid], 1);
	PlayerTextDrawLetterSize(playerid, SpecPlayerFPSTD[playerid], 0.200000, 1.000000);
	PlayerTextDrawColor(playerid, SpecPlayerFPSTD[playerid], -1397969665);
	PlayerTextDrawSetOutline(playerid, SpecPlayerFPSTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SpecPlayerFPSTD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SpecPlayerFPSTD[playerid], 0);

	SpecPlayerPingTD[playerid] = CreatePlayerTextDraw(playerid, 547.000000, 43.000000, sprintf("PING:~W~ %i", GetPlayerPing(targetid)));
	PlayerTextDrawBackgroundColor(playerid, SpecPlayerPingTD[playerid], 255);
	PlayerTextDrawFont(playerid, SpecPlayerPingTD[playerid], 1);
	PlayerTextDrawLetterSize(playerid, SpecPlayerPingTD[playerid], 0.200000, 1.000000);
	PlayerTextDrawColor(playerid, SpecPlayerPingTD[playerid], -1397969665);
	PlayerTextDrawSetOutline(playerid, SpecPlayerPingTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SpecPlayerPingTD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SpecPlayerPingTD[playerid], 0);

	SpecPlayerPLTD[playerid] = CreatePlayerTextDraw(playerid, 547.000000, 52.000000, sprintf("P/L:~W~ %.2f%", NetStats_PacketLossPercent(targetid)));
	PlayerTextDrawBackgroundColor(playerid, SpecPlayerPLTD[playerid], 255);
	PlayerTextDrawFont(playerid, SpecPlayerPLTD[playerid], 1);
	PlayerTextDrawLetterSize(playerid, SpecPlayerPLTD[playerid], 0.200000, 1.000000);
	PlayerTextDrawColor(playerid, SpecPlayerPLTD[playerid], -1397969665);
	PlayerTextDrawSetOutline(playerid, SpecPlayerPLTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SpecPlayerPLTD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SpecPlayerPLTD[playerid], 0);

	new allshots, hitshots, max_cont_shots, out_of_range_warns, random_aim_warns, proaim_tele_warns;
	BustAim::GetPlayerProfile(targetid, allshots, hitshots, max_cont_shots, out_of_range_warns, random_aim_warns, proaim_tele_warns);
	SpecPlayerHITPCTD[playerid] = CreatePlayerTextDraw(playerid, 547.000000, 61.000000, sprintf("HIT%:~W~ %.2f%%", ((hitshots*100.0) / allshots)));
	PlayerTextDrawBackgroundColor(playerid, SpecPlayerHITPCTD[playerid], 255);
	PlayerTextDrawFont(playerid, SpecPlayerHITPCTD[playerid], 1);
	PlayerTextDrawLetterSize(playerid, SpecPlayerHITPCTD[playerid], 0.200000, 1.000000);
	PlayerTextDrawColor(playerid, SpecPlayerHITPCTD[playerid], -1397969665);
	PlayerTextDrawSetOutline(playerid, SpecPlayerHITPCTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SpecPlayerHITPCTD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SpecPlayerHITPCTD[playerid], 0);

	SpecPlayerIDTD[playerid] = CreatePlayerTextDraw(playerid, 547.000000, 70.000000, sprintf("ID:~W~ %i", targetid));
	PlayerTextDrawBackgroundColor(playerid, SpecPlayerIDTD[playerid], 255);
	PlayerTextDrawFont(playerid, SpecPlayerIDTD[playerid], 1);
	PlayerTextDrawLetterSize(playerid, SpecPlayerIDTD[playerid], 0.200000, 1.000000);
	PlayerTextDrawColor(playerid, SpecPlayerIDTD[playerid], -1397969665);
	PlayerTextDrawSetOutline(playerid, SpecPlayerIDTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SpecPlayerIDTD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SpecPlayerIDTD[playerid], 0);
	

	PlayerTextDrawShow(playerid, SpecPlayerFPSTD[playerid]);
	PlayerTextDrawShow(playerid, SpecPlayerPingTD[playerid]);
	PlayerTextDrawShow(playerid, SpecPlayerPLTD[playerid]);
	PlayerTextDrawShow(playerid, SpecPlayerIPTD[playerid]);
	PlayerTextDrawShow(playerid, SpecPlayerNameTD[playerid]);
	PlayerTextDrawShow(playerid, SpecPlayerIDTD[playerid]);
	PlayerTextDrawShow(playerid, SpecPlayerHITPCTD[playerid]);
	return true;
}

UpdateSpecTDs(playerid, targetid)
{
    PlayerTextDrawSetString(playerid, SpecPlayerFPSTD[playerid], sprintf("FPS:~W~ %i", pFPS[targetid]));
    PlayerTextDrawSetString(playerid, SpecPlayerPingTD[playerid], sprintf("PING:~W~ %i", GetPlayerPing(targetid)));
	PlayerTextDrawSetString(playerid, SpecPlayerPLTD[playerid], sprintf("P/L:~W~ %.2f%", NetStats_PacketLossPercent(targetid)));
	new allshots, hitshots, max_cont_shots, out_of_range_warns, random_aim_warns, proaim_tele_warns;
	BustAim::GetPlayerProfile(targetid, allshots, hitshots, max_cont_shots, out_of_range_warns, random_aim_warns, proaim_tele_warns);
	PlayerTextDrawSetString(playerid, SpecPlayerHITPCTD[playerid], sprintf("HIT%:~W~ %.2f%%", ((hitshots*100.0) / allshots)));
    return true;
}