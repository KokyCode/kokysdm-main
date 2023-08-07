// -----------------------------------------------------------------------------
#define EVENT_NONE -1
#define EVENT_HEADSHOTSONLY 1
#define EVENT_GUNGAME 2
#define EVENT_ONEINTHECHAMBER 3
#define EVENT_TDM 4

#define EVENT_MAP_LVPD 1
#define EVENT_MAP_WESTERNTOWN 2
#define EVENT_HEADSHOT_TIMER 120
#define EVENT_WORLD 20392
// -----------------------------------------------------------------------------
forward EventStart();
forward HeadshotFinished();
forward RespawnEventPlayer(playerid);

// -----------------------------------------------------------------------------
new 
	//EventCreator,
	EventType,
	EventWeapon,
	bool:EventJoinable,
	EventMap,
	Lives[MAX_PLAYERS],
	Bullets[MAX_PLAYERS],
	EventHeadshots[MAX_PLAYERS],
	PlayerText3D:HeadshotLabel[MAX_PLAYERS][MAX_PLAYERS],
	EventDeath[MAX_PLAYERS],
	Team1Players,
	Team2Players,
	Team1Kills,
	Team2Kills,
	EventChoice = 0, // Event choice will be type of event, this is for maps.
	EventTimer = -1,
	EventTimers = -1,
	EventTime = -1,
	Iterator:EventPlayers<MAX_PLAYERS>; // Timeout timer or event start timer.

// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
new EventMaps[][] = {"LVPD", "Western Town"};

new EventMapsID[2] = {12, 0};

// -----------------------------------------------------------------------------
// EventTypes is just really for the names in the announcements...
new EventTypes[][] = {"Headshots Only", "Gun Game", "One in the Chamber", "Team Deathmatch"};

// -----------------------------------------------------------------------------
public EventStart()
{
	EventTimer = -1;
	EventTimers = -1;

	if(Iter_Count(EventPlayers) < 2)
	{
		SendClientMessageToAll(COLOR_LIGHTRED, "{31AEAA}Events: {FFFFFF}The event did not have enough players, event cancelled.");
		EndEvent();
		return 1;
	}

	EventJoinable = false;

	new arenaid = EventMapsID[EventMap];

	foreach(new i : EventPlayers) 
	{
		PlayerTextDrawHide(i, Account[i][TextDraw][1]);
		PlayerTextDrawHide(i, Account[i][TextDraw][0]);
		if(ActivityStateID[i] == EVENT_GUNGAME)
		{
			new rand = GetRandomSpawnForArena(arenaid);
			GivePlayerWeapon(i, Account[i][GunGameWeapon], 1000);
			SendClientMessage(i, COLOR_GRAY, "{31AEAA}Events: {FFFFFF}Event started, first to reach the last weapon wins.");
			SetPlayerHealth(i, 100.0);
			SetPlayerArmour(i, 0.0);
			Account[i][PreventDamage] = 0;
			EventDeath[i] = 0;
			SetPlayerFacingAngle(i, ArenaSpawns[rand][SpawnRot]);
			SetPlayerPosEx(i, ArenaSpawns[rand][SpawnX], ArenaSpawns[rand][SpawnY], ArenaSpawns[rand][SpawnZ], ArenaInfo[arenaid][ArenaInt], EVENT_WORLD);
		}
		else if(ActivityStateID[i] == EVENT_ONEINTHECHAMBER)
		{
			new rand = GetRandomSpawnForArena(arenaid);
			GivePlayerWeapon(i, 24, Bullets[i]);
			GivePlayerWeapon(i, 4, 1);
			SendClientMessage(i, COLOR_GRAY, "{31AEAA}Events: {FFFFFF}Event started, you have 3 lives remaining.");
			SetPlayerHealth(i, 25.0);
			SetPlayerArmour(i, 0.0);
			Account[i][PreventDamage] = 0;
			EventDeath[i] = 0;
			SetPlayerFacingAngle(i, ArenaSpawns[rand][SpawnRot]);
			SetPlayerPosEx(i, ArenaSpawns[rand][SpawnX], ArenaSpawns[rand][SpawnY], ArenaSpawns[rand][SpawnZ], ArenaInfo[arenaid][ArenaInt], EVENT_WORLD);
			Lives[i] = 3;
		}
		else if(ActivityStateID[i] == EVENT_HEADSHOTSONLY)
		{
			new rand = GetRandomSpawnForArena(arenaid);
			GivePlayerWeapon(i, EventWeapon, 1000);
			SetPlayerHealth(i, 2.0);
			SetPlayerArmour(i, 0.0);
			Account[i][PreventDamage] = 0;
			EventDeath[i] = 0;
			SendClientMessage(i, COLOR_LIGHTRED, "{31AEAA}Events: {FFFFFF}Event started, person with the most headshots in 2 minutes wins!");
			SetPlayerFacingAngle(i, ArenaSpawns[rand][SpawnRot]);
			SetPlayerPosEx(i, ArenaSpawns[rand][SpawnX], ArenaSpawns[rand][SpawnY], ArenaSpawns[rand][SpawnZ], ArenaInfo[arenaid][ArenaInt], EVENT_WORLD);
			PlayerTextDrawShow(i, Account[i][TextDraw][2]);
			PlayerTextDrawShow(i, Account[i][TextDraw][3]);
			PlayerTextDrawShow(i, Account[i][TextDraw][4]);
			PlayerTextDrawShow(i, Account[i][TextDraw][5]);
		}
		else if(ActivityStateID[i] == EVENT_TDM)
		{
			GivePlayerWeapon(i, 24, 999);
			GivePlayerWeapon(i, 25, 999);
			GivePlayerWeapon(i, 31, 999);
			GivePlayerWeapon(i, 34, 10);
			SendClientMessage(i, COLOR_GRAY, "{31AEAA}Events: {FFFFFF}Event started, first team to 25 kills wins!");
			SetPlayerHealth(i, 100);
			SetPlayerArmour(i, 100);
			Team1Kills = 0;
			Team2Kills = 0;
			Account[i][PreventDamage] = 0;
			EventDeath[i] = 0;
			if(Account[i][TDMTeam] == 1)
			{
				SetPlayerFacingAngle(i, 92.8600);
				SetPlayerPosEx(i, -973.5776, 1061.2117, 1345.6720, 10, 400);
			}
			else
			{
				SetPlayerFacingAngle(i, 272.5280);
				SetPlayerPosEx(i, -1131.6700 ,1057.8746, 1346.4155, 10, 400);
			}
		}
	}
	if(EventType == EVENT_HEADSHOTSONLY)
	{
		EventTimer = SetTimer("HeadshotFinished", 120000, false);
		EventTime = 120;
		foreach(new p : EventPlayers)
		{
			foreach(new j : EventPlayers)
			{
				if(p == j) continue;

				HeadshotLabel[p][j] = CreatePlayer3DTextLabel(p, "\n\nHeadshots: 0", GetPlayerColor(j), 0, 0, 0, 90, j, INVALID_VEHICLE_ID, 1);
			}
		}
	}
	return 1;
}

// -----------------------------------------------------------------------------
public HeadshotFinished()
{
	new winning_player = -1;
	new winning_headshots = 0;
	foreach(new i : EventPlayers)
	{
		if(EventHeadshots[i] > winning_headshots)
		{
			winning_player = i;
			winning_headshots = EventHeadshots[i];
		}
		PlayerTextDrawHide(i, Account[i][TextDraw][2]);
		PlayerTextDrawHide(i, Account[i][TextDraw][3]);
		PlayerTextDrawHide(i, Account[i][TextDraw][4]);
		PlayerTextDrawHide(i, Account[i][TextDraw][5]);

		foreach(new p : EventPlayers)
		{
			if(p == i) continue;

			DeletePlayer3DTextLabel(p, HeadshotLabel[p][i]);
		}
	}

	SendClientMessageToAll(-1, sprintf("{31AEAA}Events: {%06x}%s {FFFFFF}has won the headshot only event with %d headshots!", GetPlayerColor(winning_player) >>> 8, GetName(winning_player), winning_headshots));
	EndEvent();
	return 1;
}

// -----------------------------------------------------------------------------
public RespawnEventPlayer(playerid)
{
	ClearAnimations(playerid, 1);
	HandleEventSpawn(playerid);
	return 1;
}

// -----------------------------------------------------------------------------
EndEvent()
{
	EventType = 0;
	EventWeapon = 0;
	EventJoinable = false;
	EventMap = 0;
	Team1Players = 0;
	Team2Players = 0;
	Team1Kills = 0;
	Team2Kills = 0;

	if(EventTimer != -1)
	{
		KillTimer(EventTimer);
		EventTimer = -1;
	}

	foreach(new i : EventPlayers)
	{
		if(ActivityState[i] == ACTIVITY_EVENT)
		{
			EventHeadshots[i] = 0;
			Lives[i] = 0;
			Bullets[i] = 0;
			Account[i][GunGameWeapon] = 0;
			SendPlayerToLobby(i);
			PlayerTextDrawHide(i, Account[i][TextDraw][1]);
			PlayerTextDrawHide(i, Account[i][TextDraw][0]);
		}
		Iter_SafeRemove(EventPlayers, i, i);
	}
	Iter_Clear(EventPlayers);
	return 1;
}

// -----------------------------------------------------------------------------
StartEvent()
{
	EventTimer = SetTimer("EventStart", 60000, false);
	EventJoinable = true;
	EventTimers = 60;
	return 1;
}

// -----------------------------------------------------------------------------
JoinEvent(playerid)
{
	if(EventMap == 1)
		CreateWesternTown(playerid);

	if(Iter_Count(EventPlayers) == 0) switch(EventChoice)
	{
		case 0: SendClientMessageToAll(COLOR_LIGHTRED, sprintf("{31AEAA}Events: {FFFFFF}%s has started a headshots only event! (/joinevent).", AdminName(playerid)));
		case 1, 2: SendClientMessageToAll(COLOR_LIGHTRED, sprintf("{31AEAA}Events: {FFFFFF}%s has started a %s event on the map %s! (/joinevent)", AdminName(playerid), EventTypes[EventType-1], EventMaps[EventMap]));
		case 3: SendClientMessageToAll(COLOR_LIGHTRED, sprintf("{31AEAA}Events: {FFFFFF}%s has started a TDM event! (/joinevent).", AdminName(playerid)));
	}
	else SendClientMessageToAll(COLOR_LIGHTRED, sprintf("{31AEAA}Events: {FFFFFF}%s has joined the event! (/joinevent)", GetName(playerid)));

	ActivityState[playerid] = ACTIVITY_EVENT;
	Account[playerid][PreventDamage] = 1;
	
	switch(EventType) 
	{
		case EVENT_HEADSHOTSONLY: 
		{
			SetPlayerPosEx(playerid, 964.106994,-53.205497,1001.124572, 3, 400);
			//SetPlayerHealth(playerid, 5.0);
			ActivityStateID[playerid] = EVENT_HEADSHOTSONLY;
			ResetPlayerWeapons(playerid);
		}

		case EVENT_GUNGAME: 
		{	
			ActivityStateID[playerid] = EVENT_GUNGAME;
			Account[playerid][GunGameWeapon] = 22;
			Account[playerid][GunGameIndex] = 0;
			SetPlayerPosEx(playerid, 964.106994,-53.205497,1001.124572, 3, 400);
			ResetPlayerWeapons(playerid);
		}

		case EVENT_ONEINTHECHAMBER: 
		{
			ActivityStateID[playerid] = EVENT_ONEINTHECHAMBER;
			Bullets[playerid] = 1;
			Lives[playerid] = 3;
			SetPlayerPosEx(playerid, 964.106994,-53.205497,1001.124572, 3, 400);
			ResetPlayerWeapons(playerid);
		}

		case EVENT_TDM:  
		{
			ActivityStateID[playerid] = EVENT_TDM;
			SetPlayerPosEx(playerid, 964.106994,-53.205497,1001.124572, 3, 400);
			SetPlayerHealth(playerid, 100);
			if(Iter_Count(EventPlayers) % 2 != 0)
			{
				Account[playerid][TDMTeam] = 1;
				Team1Players++;
				SetPlayerColor(playerid, 0x0000FF91); // team blue
			}
			else
			{
				Account[playerid][TDMTeam] = 2;
				Team2Players++;
				SetPlayerColor(playerid, 0xFF000091); // team red
			}
		}
	}
	SetPlayerVirtualWorld(playerid, EVENT_WORLD);
	Iter_Add(EventPlayers, playerid);
	return 1;
}

// -----------------------------------------------------------------------------
GunGameWeaponUpgrade(playerid)
{
	new guns[] = {22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 33, 34, 35, 38};

	++Account[playerid][GunGameIndex];
	Account[playerid][GunGameWeapon] = guns[Account[playerid][GunGameIndex]];

	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, Account[playerid][GunGameWeapon], 1000);

	if(Account[playerid][GunGameWeapon] == 38)
	{
		Account[playerid][GunGameWeapon] = 0;
		ResetPlayerWeapons(playerid);
		SendClientMessageToAll(COLOR_LIGHTRED, sprintf("{31AEAA}Events: {FFFFFF}%s has won the Gun Game event, he reached the final weapon.", GetName(playerid)));
		GivePlayerMoneyEx(playerid, 3000);
		Account[playerid][EventsWon]++;
		EndEvent();
		return 1;
	}

	SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("{31AEAA}Events: {FFFFFF}Your weapon is now level %d.", Account[playerid][GunGameIndex]+1));

	return 1;
}

// -----------------------------------------------------------------------------
HandleEventDeath(playerid, killerid, weaponid)
{
	if(killerid == INVALID_PLAYER_ID)
		return 1;

	if(ActivityState[playerid] != ACTIVITY_EVENT)
		return 1;

	if(ActivityState[killerid] != ACTIVITY_EVENT)
		return 1;

	if(ActivityStateID[playerid] != ActivityStateID[killerid])
		return 1;

	if(ActivityStateID[killerid] == EVENT_GUNGAME && ActivityStateID[playerid] == EVENT_GUNGAME)
	{
		GunGameWeaponUpgrade(killerid);
		GameTextForPlayer(killerid, "~b~UPGRADED WEAPON!", 1200, 3);
	}
	else if(ActivityStateID[killerid] == EVENT_TDM && ActivityStateID[playerid] == EVENT_TDM && Account[killerid][TDMTeam] != Account[playerid][TDMTeam])
	{
		if(Account[killerid][TDMTeam] == 1)
		{
			Team1Kills++;

			if(Team1Kills >= 25)
			{
				SendClientMessageToAll(COLOR_LIGHTRED, "{31AEAA}Events: {FFFFFF}Blue Midgets won the event.");
				EndEvent();
			}
		}
		else if(Account[killerid][TDMTeam] == 2) 
		{
			Team2Kills++;
			
			if(Team2Kills >= 25)
			{
				SendClientMessageToAll(COLOR_LIGHTRED, "{31AEAA}Events: {FFFFFF}Red Midgets won the event.");
				EndEvent();
			}
		}

	}
	else if(ActivityStateID[killerid] == EVENT_ONEINTHECHAMBER && ActivityStateID[playerid] == EVENT_ONEINTHECHAMBER)
	{
		new weapon = GetPlayerWeapon(killerid);

		Lives[playerid]--;
		if(weapon == 24)
		{
			Bullets[playerid] = 1;
		}
		else if(weapon == 4)
		{
			Bullets[killerid]++;
		}
		GivePlayerWeapon(killerid, 24, Bullets[killerid]);

		if(Lives[playerid] < 1)
		{
			foreach(new i : EventPlayers)
			{
				if(i == playerid)
				{
					Iter_SafeRemove(EventPlayers, i, i);
					break;
				}
			}
			SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Events: {FFFFFF}You lost the event, thanks for playing.");
			Bullets[playerid] = 0;
			SendPlayerToLobby(playerid);
			if(Iter_Count(EventPlayers) < 2)
			{
				SendClientMessageToAll(COLOR_LIGHTRED, sprintf("{31AEAA}Events: {FFFFFF}%s has won the One in the Chamber event with %d life(s) remaining!", GetName(killerid), Lives[killerid]));
				EndEvent();
			}
		}
	}
	else if(ActivityStateID[killerid] == EVENT_HEADSHOTSONLY)
	{
		EventHeadshots[killerid]++;
		PlayerTextDrawSetString(killerid, Account[killerid][TextDraw][5], sprintf("%d", EventHeadshots[killerid]));
	}
	foreach(new i: Player)
	{
		if(ActivityState[i] == ACTIVITY_EVENT || Account[i][Admin] >= 1)
		{
			SendDeathMessageToPlayer(i, killerid, playerid, weaponid);
			
			DeletePlayer3DTextLabel(i, HeadshotLabel[i][killerid]);

			HeadshotLabel[i][killerid] = CreatePlayer3DTextLabel(i, sprintf("\n\nHeadshots: %d", EventHeadshots[killerid]), GetPlayerColor(killerid), 0, 0, 0, 90, killerid, INVALID_VEHICLE_ID, 1);
		}
	}
	ShowHitMarker(killerid);
	return 1;
}

// -----------------------------------------------------------------------------
ExitEvent(playerid, bool:ended = false)
{
	if(Iter_Count(EventPlayers) < 2 && ended == false)
	{
		EndEvent();
		SendClientMessageToAll(-1, sprintf("{31AEAA}Events: {FFFFFF}The current event has now ended, %s left the event.", GetName(playerid)));
	}

	EventHeadshots[playerid] = 0;
	Lives[playerid] = 0;
	Bullets[playerid] = 0;
	Account[playerid][GunGameWeapon] = 0;
	EventDeath[playerid] = 0;
	//SendPlayerToLobby(playerid);
	foreach(new i : EventPlayers)
	{
		if(playerid == i)
		{
			Iter_SafeRemove(EventPlayers, i, i);
			break;
		}
	}
	return 1;
}

// -----------------------------------------------------------------------------
HandleEventSpawn(playerid)
{
	if(ActivityStateID[playerid] == EVENT_NONE)
	{
		SendPlayerToLobby(playerid);
		return 1;
	}

	new arenaid = EventMapsID[EventMap];
	new rand = GetRandomSpawnForArena(arenaid);
	
	switch(ActivityStateID[playerid])
	{
		case EVENT_HEADSHOTSONLY: 
		{

			GivePlayerWeapon(playerid, EventWeapon, 1000);
			SetPlayerHealth(playerid, 2.0);
			SetPlayerArmour(playerid, 0.0);
			Account[playerid][PreventDamage] = 0;
			SetPlayerPosEx(playerid, ArenaSpawns[rand][SpawnX], ArenaSpawns[rand][SpawnY], ArenaSpawns[rand][SpawnZ], ArenaInfo[arenaid][ArenaInt], EVENT_WORLD);
		}

		case EVENT_GUNGAME:
		{
			GivePlayerWeapon(playerid, Account[playerid][GunGameWeapon], 1000);
			SetPlayerHealth(playerid, 100.0);
			SetPlayerArmour(playerid, 0.0);
			Account[playerid][PreventDamage] = 0;
			SetPlayerFacingAngle(playerid, ArenaSpawns[rand][SpawnRot]);
			SetPlayerPosEx(playerid, ArenaSpawns[rand][SpawnX], ArenaSpawns[rand][SpawnY], ArenaSpawns[rand][SpawnZ], ArenaInfo[arenaid][ArenaInt], EVENT_WORLD);
		}

		case EVENT_ONEINTHECHAMBER:
		{
			GivePlayerWeapon(playerid, 24, Bullets[playerid]);
			GivePlayerWeapon(playerid, 4, 1);
			SetPlayerHealth(playerid, 25.0);
			SetPlayerArmour(playerid, 0.0);
			Account[playerid][PreventDamage] = 0;
			SetPlayerFacingAngle(playerid, ArenaSpawns[rand][SpawnRot]);
			SetPlayerPosEx(playerid, ArenaSpawns[rand][SpawnX], ArenaSpawns[rand][SpawnY], ArenaSpawns[rand][SpawnZ], ArenaInfo[arenaid][ArenaInt], EVENT_WORLD);
		}

		case EVENT_TDM:
		{
			GivePlayerWeapon(playerid, 24, 999);
			GivePlayerWeapon(playerid, 25, 999);
			GivePlayerWeapon(playerid, 31, 999);
			GivePlayerWeapon(playerid, 34, 10);
			SetPlayerHealth(playerid, 100);
			SetPlayerArmour(playerid, 100);
			Account[playerid][PreventDamage] = 0;
			if(Account[playerid][TDMTeam] == 1)
			{
				SetPlayerFacingAngle(playerid, 92.8600);
				SetPlayerPosEx(playerid, -973.5776, 1061.2117, 1345.6720, 10, 400);
			}
			else if(Account[playerid][TDMTeam] == 2)
			{
				SetPlayerFacingAngle(playerid, 272.5280);
				SetPlayerPosEx(playerid, -1131.6700 ,1057.8746, 1346.4155, 10, 400);
			}
		}
	}	
	EventDeath[playerid] = 0;
	return 1;
}

// -----------------------------------------------------------------------------
#include <pp-hooks>
hook public OnPlayerDisconnect(playerid, reason)
{
	if(ActivityState[playerid] == ACTIVITY_EVENT) ExitEvent(playerid);
}

// -----------------------------------------------------------------------------
Dialog:EventWeapons(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	EventType = EVENT_HEADSHOTSONLY;
	EventMap = 0;

	Account[playerid][PlayerEvents]--;
	Account[playerid][EventsStarted]++;

	new weapons[] = {33, 24, 22};
	EventWeapon = weapons[listitem];

	StartEvent();
	JoinEvent(playerid);
	return 1;
}

// -----------------------------------------------------------------------------
Dialog:EventMaps(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	EventType = EventChoice+1;
	EventMap = listitem;
	Account[playerid][PlayerEvents]--;
	Account[playerid][EventsStarted]++;
	StartEvent();
	JoinEvent(playerid);
	return 1;
}

// -----------------------------------------------------------------------------
Dialog:EVENTS(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	EventChoice = listitem;
	switch(listitem)
	{
		case 0:
		{
			Dialog_Show(playerid, EventWeapons, DIALOG_STYLE_LIST, "Headshot Only Event", "Country Rifle\nDesert Eagle\nColt.45", "Select", "Cancel");
		}

		case 1, 2:
		{
			new str[150];
			for(new i = 0; i < sizeof(EventMaps); i++)
			{
				strcat(str, sprintf("%s\n", EventMaps[i]));
			}

			Dialog_Show(playerid, EventMaps, DIALOG_STYLE_LIST, "Event - Map Selection", str, "Select", "Cancel");
		}

		case 3:
		{
			EventType = EVENT_TDM;
			Account[playerid][PlayerEvents]--;
			Account[playerid][EventsStarted]++;
			StartEvent();
			JoinEvent(playerid);
		}
	}
	return 1;
}

// -----------------------------------------------------------------------------
CMD:startevent(cmdid, playerid, params[])
{
	if(ActivityState[playerid] != ACTIVITY_LOBBY) return SendClientMessage(playerid, -1, "{bf0000}Notice: {FFFFFF} You must be in the lobby to use this command.");

	if(EventType != 0)
		return SendClientMessage(playerid, -1, "{31AEAA}Events: {FFFFFF}Event in progress, unable to start another!");

	if(Account[playerid][PlayerEvents] > 0)
	{
		Dialog_Show(playerid, EVENTS, DIALOG_STYLE_LIST, "Event Types", "Headshot Only\nGun Game\nOne in the Chamber\nTeam Deathmatch\n", "Select", "Cancel");
	}
	else SendClientMessage(playerid, COLOR_GRAY, "{bf0000}Notice: {FFFFFF}You don't have any events, you can win some in our crates!");

	return 1;
}

// -----------------------------------------------------------------------------
CMD:joinevent(cmdid, playerid, params[])
{
	if(!IsPlayerInLobby(playerid))
		return SendClientMessage(playerid, -1, "{bf0000}Notice: {FFFFFF}You must be in the lobby to use this command.");

	if(ActivityState[playerid] == ACTIVITY_EVENT)
		return SendClientMessage(playerid, -1, "{31AEAA}Events: Yes, let's join the event again when you're already in it.");
	
	if(EventType == 0)
		return SendClientMessage(playerid, -1, "{31AEAA}Events: {FFFFFF}There is no event in progress. You can start one with /startevent.");
	
	if(EventJoinable == false)
		return SendClientMessage(playerid, -1, "{31AEAA}Events: {FFFFFF}Event in progress, unable to join!");
	
	JoinEvent(playerid);
	return 1;
}

// -----------------------------------------------------------------------------
CMD<AD3>:endevent(cmdid, playerid, params[])
{
	if(EventType == 0)
		return SendClientMessage(playerid, -1, "{31AEAA}Events: {FFFFFF}There is no event in progress.");

	EndEvent();
	SendClientMessageToAll(-1, sprintf("{31AEAA}Events: {FFFFFF}%s has forcefully ended the event.", AdminName(playerid)));
	return 1;
}