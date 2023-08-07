// WARNING: Maybe some of this is scripted bad. :(
// 2 hours of sleep and pawn is not great.

#include <pp-hooks>

#define HOST_TEAM 1

#define DUEL_MAP_LVPD 0
#define DUEL_MAP_WESTERN 1
#define DUEL_MAP_DUST 2

// -----------------------------------------------------------------------------
enum
{
	DIALOG_DUEL_SETTINGS = 9000,
	DIALOG_DUEL_MAP,
	DIALOG_DUEL_TEAMMATES,
	DIALOG_DUEL_ENEMIES,
	DIALOG_DUEL_WEAPONS,
	DIALOG_DUEL_HEALTH,
	DIALOG_DUEL_ARMOUR,
};

// -----------------------------------------------------------------------------
new DuelMaps[][] =
{
	"LVPD",
	"Western Town",
	"Dust 2",
	"Stadium"	
};

// -----------------------------------------------------------------------------
enum E_WEAPON_INFO
{
	weapon_id,
	weapon_name[60]
};

// -----------------------------------------------------------------------------
new WeaponNames[][E_WEAPON_INFO] =
{
	{-1, "Fists"}, // fists
	{1, "Brass Knuckles"}, // 1
	{2, "Golf Club"}, // 2
	{3, "Night Stick"}, // 3
	{4, "Knife"}, // 4
	{5, "Baseball Bat"}, // 5
	{6, "Shovel"}, // 6
	{7, "Pool Cue"}, // 7
	{8, "Katana"}, // 8
	{9, "Chainsaw"}, // 9
	{10, "Purple Dildo"}, // 10
	{11, "Big White Vibrator"}, // 11
	{12, "Medium White Vibrator"}, // 12
	{13, "Small White Vibrator"}, // 13
	{14, "Flowers"}, // 14
	{15, "Cane"}, // 15
	{16, "Grenade"}, // 16
	{17, "Teargas"}, // 17
	{18, "Molotov"}, // 18
	{-1, ""},
	{-1, ""},
	{-1, ""},
	{22, "Colt 45"}, // 22
	{23, "Colt 45 (Silenced)"}, // 23
	{24, "Desert Eagle"}, // 24
	{25, "Normal Shotgun"}, // 25
	{26, "Sawnoff Shotgun"}, // 26
	{27, "Combat Shotgun"}, // 27
	{28, "Micro Uzi"}, // 28
	{29, "MP5"}, // 29
	{30, "AK47"}, // 30
	{31, "M4"}, // 31
	{32, "Tec9"}, // 32
	{33, "Country Rifle"}, // 33
	{34, "Sniper Rifle"}, // 34
	{35, "RPG Launcher"}, // 35
	{36, "HS Rocket Launcher"}, // 36
	{37, "Flamethrower"}, // 37
	{38, "Minigun"}, // 38
	{39, "Satchel Charge"}, // 39
	{40, "Detonator"}, // 40
	{41, "Spray Can"}, // 41
	{42, "Fire Extinguisher"} // 42
};

// -----------------------------------------------------------------------------
enum E_DUELSPAWNS
{
	Float:duel_x,
	Float:duel_y,
	Float:duel_z,
	Float:duel_angle,
	duel_interior
};

// -----------------------------------------------------------------------------
new DuelSpawns[][E_DUELSPAWNS] =
{
	// Due to a limitation in pawn, this couldn't really be better.
	// x, y, z, a, i
	// 4 spawn points per team
	// 2 teams

	// LVPD
	{202.2579, 168.2919, 1003.0234, 272.0015, 3}, {202.1382, 167.1354, 1003.0234, 271.3992, 3}, {202.2310, 166.1053, 1003.0234, 261.6415, 3}, {202.4680, 170.2770, 1003.0234, 265.7077, 3}, // TEAM 1
	{285.3534, 179.6663, 1007.1794, 91.3103, 3}, {285.2330, 182.8759, 1007.1794, 90.8090, 3}, {285.2571, 185.1147, 1007.1719, 90.8090, 3}, {285.0357, 175.8403, 1007.1719, 90.8090, 3}, // TEAM 2 etc

	// Map 2
	{3909.7698, -1753.5515, 3.0156, 172.9651, 0}, {3912.6726, -1753.9268, 3.0156, 181.1536, 0}, {3916.0408, -1754.1757, 3.0156, 181.1536, 0}, {3919.0808, -1754.4692, 3.0156, 181.1536, 0},
	{3901.0884, -1937.9650, 3.0156, 359.1077, 0}, {3903.3848, -1937.6708, 3.0156, 359.1077, 0}, {3905.9302, -1937.0955, 3.0156, 359.1077, 0}, {3907.8469, -1937.3475, 3.0156, 359.1077, 0},

	// DUST2
	{2497.2566, 993.6450, 2013.2098, 267.2791, 0}, {2497.6018, 990.6785, 2012.9475, 270.3498, 0}, {2497.9692, 988.8679, 2012.5764, 270.3498, 0}, {2498.0876, 986.5953, 2011.9955, 270.3498, 0},
	{2578.6265, 966.9434, 2006.5864, 89.3251, 0}, {2578.3125, 969.3522, 2006.4844, 89.3251, 0}, {2577.9949, 972.4075, 2006.5038, 98.0985, 0}, {2577.7629, 973.7661, 2006.5078, 77.3347, 0},
	// etc

	{-1381.1824, 992.5015,1024.0203, 87.404, 15}, {-1381.0461, 988.7782, 1023.9629, 88.3193, 15}, {-1381.7694, 1001.1740, 1024.1660, 91.4306, 15}, {-1381.7407, 1006.6860, 1024.2654, 94.0251, 15},
	{-1436.6412, 992.1735, 1024.1239, 270.6254, 15}, {-1439.4220, 987.8715, 1024.0500, 270.3587, 15}, {-1439.2665, 997.3262, 1024.2117, 271.2603, 15}, {-1438.7191, 003.0560, 1024.3026, 271.0795, 15}
};

// -----------------------------------------------------------------------------
new
	DuelInvite[MAX_PLAYERS] = {-1, ...},
	DuelTimer[MAX_PLAYERS] = {-1, ...},
	DuelMap[MAX_PLAYERS] = {0, ...},
	DuelCountDown[MAX_PLAYERS] = {0, ...},
	InviteCooldown[MAX_PLAYERS] = {-1, ...},
	DuelTeam[MAX_PLAYERS][MAX_PLAYERS], 	// Team 1 is host's team, 2 is enemy.
													// 2D array because we need to check in the dialog too, and it will break if they're in a duel already.
	PlayersAccepted[MAX_PLAYERS] = {0, ...},
	AlliesCount[MAX_PLAYERS] = {0, ...},
	EnemyCount[MAX_PLAYERS] = {0, ...},
	Float:DuelArmour[MAX_PLAYERS] = {100.0, ...},
	Float:DuelHealth[MAX_PLAYERS] = {100.0, ...},

	Iterator:DuelPlayers[MAX_PLAYERS]<MAX_PLAYERS>,
	Iterator:DuelWeapons[MAX_PLAYERS]<43>; // 43 Because max weapons + 1 :D

// -----------------------------------------------------------------------------
forward DuelCountdownTimer(hostid);
forward DuelCooldown(hostid);

// -----------------------------------------------------------------------------
public DuelCountdownTimer(hostid)
{
	new duelindex = ActivityStateID[hostid];
	switch(DuelCountDown[duelindex])
	{
		case 1 .. 100:
		{
			foreach(new i : DuelPlayers[duelindex])
			{
				if(ActivityStateID[i] == duelindex)
				{
					GameTextForPlayer(i, sprintf("~r~~h~%d", DuelCountDown[duelindex]), 1000, 3);
					PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
					TogglePlayerControllable(i, false);
				}
			}
		}
		case 0:
		{
			KillTimer(DuelTimer[hostid]);
			DuelTimer[hostid] = -1;

			foreach(new i : DuelPlayers[duelindex])
			{
				if(ActivityStateID[i] == duelindex)
				{
					TogglePlayerControllable(i, true);
					GameTextForPlayer(i, "~r~~h~FIGHT!", 4000, 3);
					PlayerPlaySound(i, 3200, 0, 0, 0);
				}
			}
		}
	}
	DuelCountDown[duelindex] --;
	return 1;
}

// -----------------------------------------------------------------------------
public DuelCooldown(hostid)
{
	if(PlayersAccepted[hostid] < Iter_Count(DuelPlayers[hostid]))
	{
		foreach(new i : DuelPlayers[hostid])
		{
			SendClientMessage(i, -1, "{bf0000}DUEL: {FFFFFF}Duel has been cancelled. Duel invite limit reached.");
			DuelInvite[i] = -1;
		}

		ActivityState[hostid] = ACTIVITY_LOBBY;
		ActivityStateID[hostid] = -1;
		InviteCooldown[hostid] = -1;
	}
	return 1;
}

// -----------------------------------------------------------------------------
GetWeaponSlot(weaponid)
{
	new slot = 0;
	switch(weaponid)
	{
		case 0,1: slot = 0;
		case 2..9: slot = 1;
		case 10..15: slot = 10;
		case 16..18, 39: slot = 8;
		case 22..24: slot = 2;
		case 25..27: slot = 3;
		case 28, 29, 32: slot = 4;
		case 30, 31: slot = 5;
		case 33, 34: slot = 6;
		case 35..38: slot = 7;
		case 40: slot = 12;
		case 41..43: slot = 9;
		case 44..46: slot = 11;
	}
	return slot;
}

// -----------------------------------------------------------------------------
GivePlayerDuelWeapons(playerid)
{
	new duelhost = ActivityStateID[playerid];
	if(duelhost == -1) return 0;
	ResetPlayerWeaponsEx(playerid);
	foreach(new i: DuelWeapons[duelhost])
	{
		GivePlayerWeapon(playerid, i, 9999);
	}
	return 1;
}

// -----------------------------------------------------------------------------
EndDuel(playerid, bool:cancelled)
{
	new duelhost = ActivityStateID[playerid];

	if(duelhost == -1)
		return 0;

	if(duelhost == playerid && PlayersAccepted[playerid] < Iter_Count(DuelPlayers[playerid]))
	{
		foreach(new i : DuelPlayers[playerid])
		{
			SendClientMessage(i, -1, sprintf("{bf0000}DUEL: {FFFFFF}Duel has been cancelled, the host, {%06x}%s {FFFFFF}has cancelled the invite.", GetPlayerColor(playerid) >>> 8, GetName(playerid)));
			DuelInvite[i] = -1;
		}
		DuelInvite[playerid] = -1;
		ActivityState[playerid] = ACTIVITY_LOBBY;
		ActivityStateID[playerid] = -1;

		if(DuelTimer[playerid] != -1)
		{
			KillTimer(DuelTimer[playerid]);
			DuelTimer[playerid] = -1;
		}
		ClearDuelVariables(playerid);
		return 1;
	}

	foreach(new i : DuelPlayers[duelhost])
	{
		TogglePlayerControllable(i, true);
		ActivityState[i] = ACTIVITY_LOBBY;
		ActivityStateID[i] = -1;
		PlayersAccepted[duelhost] = 0;
		DuelInvite[i] = -1;
		ResetPlayerWeaponsEx(i);

		if(cancelled) GameTextForPlayer(i, "~r~Duel Cancelled!", 2500, 3);
		else GameTextForPlayer(i, "~r~Duel Finished!", 2500, 3);

		if(DuelTimer[i] != -1)
		{
			KillTimer(DuelTimer[i]);
			DuelTimer[i] = -1;
		}
		SpawnPlayer(i);
		SendPlayerToLobby(i);
	}
	return 1;
}

// -----------------------------------------------------------------------------
InitDuel(playerid)
{
	new team_1 = 0;
	new team_2 = 0;

	// This is a bit of dirty code.
	// 'id' is really just a formula to get the correct spawns from the array.
	// (DuelMap[playerid] * amount_of_spawns) + (id in team (+ amount of spawns for team 2))

	new world_id = -(9000 + (AlliesCount[playerid] * EnemyCount[playerid] + playerid));

	foreach(new i : DuelPlayers[playerid])
	{
		ActivityState[i] = ACTIVITY_DUEL;
		ActivityStateID[i] = playerid;

		switch(DuelMap[playerid])
		{
			case DUEL_MAP_WESTERN:
			{
				CreateWesternTown(i);
			}
			case DUEL_MAP_DUST:
			{
				CreateDust2(i);
			}
		}
		if(DuelTeam[playerid][i] == HOST_TEAM)
		{
			new id = (DuelMap[playerid] * 8) + team_1;
			SetPlayerPos(i, DuelSpawns[id][duel_x], DuelSpawns[id][duel_y], DuelSpawns[id][duel_z]);
			SetPlayerFacingAngle(i, DuelSpawns[id][duel_angle]);
			SetPlayerInterior(i, DuelSpawns[id][duel_interior]);
			team_1++;
		}
		else
		{
			new id = (DuelMap[playerid] * 8) + (team_2 + 4);
			SetPlayerPos(i, DuelSpawns[id][duel_x], DuelSpawns[id][duel_y], DuelSpawns[id][duel_z]);
			SetPlayerFacingAngle(i, DuelSpawns[id][duel_angle]);
			SetPlayerInterior(i, DuelSpawns[id][duel_interior]);
			team_2++;
		}
		GivePlayerDuelWeapons(i);
		SetPlayerHealth(i, DuelHealth[playerid]);
		SetPlayerArmour(i, DuelArmour[playerid]);
		SetPlayerVirtualWorld(i, world_id);
		TogglePlayerControllable(i, false);
	}

	DuelCountDown[playerid] = 5;
	if(DuelTimer[playerid] != -1)
		KillTimer(DuelTimer[playerid]);

	DuelTimer[playerid] = SetTimerEx("DuelCountdownTimer", 1000, true, "i", playerid);
	return 1;
}

// -----------------------------------------------------------------------------
GetDuelTeamMates(hostid, const ret[], len = sizeof(ret))
{
	foreach(new i : DuelPlayers[hostid])
	{
		if(DuelTeam[hostid][i] == HOST_TEAM)
		{
			if(!strlen(ret))  strcat(ret, sprintf("%s", GetName(i)), len);
			else strcat(ret, sprintf(", %s", GetName(i)), len);
		}
	}
	return 1;
}

// -----------------------------------------------------------------------------
GetDuelEnemies(hostid, const ret[], len = sizeof(ret))
{
	foreach(new i : DuelPlayers[hostid])
	{
		if(DuelTeam[hostid][i] != HOST_TEAM)
		{
			if(!strlen(ret)) strcat(ret, sprintf("%s", GetName(i)), len);
			else strcat(ret, sprintf(", %s", GetName(i)), len);
		}
	}
	return 1;
}

// -----------------------------------------------------------------------------
GetDuelWeapons(hostid, const ret[], len = sizeof(ret))
{
	foreach(new i : DuelWeapons[hostid])
	{
		if(!strlen(ret)) strcat(ret, sprintf("%s", WeaponNames[i][weapon_name]), len);
		else strcat(ret, sprintf(", %s", WeaponNames[i][weapon_name]), len);
	}
	return 1;
}

// -----------------------------------------------------------------------------
ShowDuelSettingsDialog(playerid)
{
	new
		team_mates[104],
		enemies[104],
		weapons[229];

	GetDuelTeamMates(playerid, team_mates);
	GetDuelEnemies(playerid, enemies);
	GetDuelWeapons(playerid, weapons);

	ShowPlayerDialog(playerid, DIALOG_DUEL_SETTINGS, DIALOG_STYLE_TABLIST, "Duel - Settings", sprintf("Map:\t%s\nTeammates:\t%s\nEnemies:\t%s\nWeapons:\t%s\nHealth:\t%.0f\nArmour:\t%.0f\nSend invites", DuelMaps[DuelMap[playerid]], team_mates, enemies, weapons, DuelHealth[playerid], DuelArmour[playerid]), "Select", "Cancel");
	return 1;
}

// -----------------------------------------------------------------------------
ShowWeaponSelectionDialog(playerid)
{
	new weapon_str[530];
	for(new i = 0; i < sizeof(WeaponNames); i++)
	{
		if(WeaponNames[i][weapon_id] != -1)
		{
			if(Iter_Contains(DuelWeapons[playerid], WeaponNames[i][weapon_id])) strcat(weapon_str, sprintf("{00FF00}%s{FFFFFF}\n", WeaponNames[i][weapon_name]));
			else strcat(weapon_str, sprintf("%s\n", WeaponNames[i][weapon_name]));
		}
	}
	ShowPlayerDialog(playerid, DIALOG_DUEL_WEAPONS, DIALOG_STYLE_LIST, "Duel - Weapon Selection", weapon_str, "Select", "Back");
	return 1;
}

// -----------------------------------------------------------------------------
ClearDuelVariables(playerid)
{
	Iter_Clear(DuelPlayers[playerid]);
	Iter_Clear(DuelWeapons[playerid]);
	Iter_Add(DuelPlayers[playerid], playerid);
	Iter_Add(DuelWeapons[playerid], WEAPON_DEAGLE);
	DuelTeam[playerid][playerid] = HOST_TEAM;

}

// -----------------------------------------------------------------------------
hook public OnPlayerConnect(playerid)
{
	if(ActivityState[playerid] == ACTIVITY_DUEL) EndDuel(playerid, true);
	if(DuelTimer[playerid] != -1) KillTimer(DuelTimer[playerid]);

	DuelTimer[playerid] = -1;
	ActivityState[playerid] = ACTIVITY_LOBBY;
	ActivityStateID[playerid] = -1;
	PlayersAccepted[playerid] = 0;

	DuelInvite[playerid] = -1;

	Iter_Clear(DuelPlayers[playerid]);
	Iter_Clear(DuelWeapons[playerid]);

	Iter_Add(DuelPlayers[playerid], playerid);
	Iter_Add(DuelWeapons[playerid], WEAPON_DEAGLE);

	DuelTeam[playerid][playerid] = HOST_TEAM;
}
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
hook public OnPlayerDisconnect(playerid, reason)
{
	if(ActivityState[playerid] == ACTIVITY_DUEL) EndDuel(playerid, true);

	new id = DuelInvite[playerid];
	if(id != -1)
	{
		foreach(new i : DuelPlayers[id])
		{
			SendClientMessage(i, -1, sprintf("{bf0000}DUEL: {%06x}%s {FFFFFF}has left the server. Duel cancelled.", GetPlayerColor(playerid) >>> 8, GetName(i)));
			DuelInvite[i] = -1;
		}
		ClearDuelVariables(id);
	}
}

// -----------------------------------------------------------------------------
hook public OnDialogResponse(playerid, dialogid, response, listitem, const inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_DUEL_SETTINGS:
		{
			if(!response)
			{
				ClearDuelVariables(playerid);
				return SendClientMessage(playerid, -1, "{bf0000}DUEL: {FFFFFF}Duel settings cancelled.");
			}

			switch(listitem)
			{
				case 0:
				{
					new str[sizeof(DuelMaps) * 30];
					for(new i = 0; i < sizeof(DuelMaps); i++)
					{
						strcat(str, sprintf("%s\n", DuelMaps[i]));
					}
					return ShowPlayerDialog(playerid, DIALOG_DUEL_MAP, DIALOG_STYLE_LIST, "Duel - Map choosing", str, "Select", "Cancel");
				}
				case 1:
				{
					return ShowPlayerDialog(playerid, DIALOG_DUEL_TEAMMATES, DIALOG_STYLE_INPUT, "Duel - Teammate choosing", "Please type in the name/ID of the player(s) you want to add as a team mate.\nExample: 10 Koky 4", "Input", "Cancel");
				}
				case 2:
				{
					return ShowPlayerDialog(playerid, DIALOG_DUEL_ENEMIES, DIALOG_STYLE_INPUT, "Duel - Enemy choosing", "Please type in the name/ID of the player(s) you want to add as a enemy.\nExample: 10 Koky 4", "Input", "Cancel");
				}
				case 3:
				{
					return ShowWeaponSelectionDialog(playerid);
				}
				case 4:
				{
					return ShowPlayerDialog(playerid, DIALOG_DUEL_HEALTH, DIALOG_STYLE_INPUT, "Duel - Health", "Please type in the amount of health you want.\nThis CANNOT go under 35.", "Input", "Cancel");
				}
				case 5:
				{
					return ShowPlayerDialog(playerid, DIALOG_DUEL_ARMOUR, DIALOG_STYLE_INPUT, "Duel - Armour", "Please type in the amount of armour you want.", "Input", "Cancel");
				}
				case 6:
				{
					SendDuel(playerid);
				}
			}
		}
		case DIALOG_DUEL_MAP:
		{
			if(!response)
				return ShowDuelSettingsDialog(playerid);

			DuelMap[playerid] = listitem;
			SendClientMessage(playerid, -1, sprintf("{bf0000}DUEL: {FFFFFF}You picked the duel map \"%s\"!", DuelMaps[DuelMap[playerid]]));
			return ShowDuelSettingsDialog(playerid);
		}
		case DIALOG_DUEL_TEAMMATES:
		{
			if(!response)
				return ShowDuelSettingsDialog(playerid);

			new team_id[3];
			sscanf(inputtext, "U(-1)U(-1)U(-1)", team_id[0], team_id[1], team_id[2]);
			if(!IsPlayerConnected(team_id[0]) && team_id[0] != -1)
			{
				ShowDuelSettingsDialog(playerid);
				return SendClientMessage(playerid, -1, "{bf0000}DUEL: {FFFFFF}Player 1 is not connected.");
			}
			else if(!IsPlayerConnected(team_id[1]) && team_id[1] != -1)
			{
				ShowDuelSettingsDialog(playerid);
				return SendClientMessage(playerid, -1, "{bf0000}DUEL: {FFFFFF}Player 2 is not connected.");
			}
			else if(!IsPlayerConnected(team_id[2]) && team_id[2] != -1)
			{
				ShowDuelSettingsDialog(playerid);
				return SendClientMessage(playerid, -1, "{bf0000}DUEL: {FFFFFF}Player 3 is not connected.");
			}
			foreach(new i : DuelPlayers[playerid])
			{
				if(DuelTeam[playerid][i] == HOST_TEAM && (i != team_id[0] || i != team_id[1] || i != team_id[2]) && i != playerid)
				{
					Iter_SafeRemove(DuelPlayers[playerid], i, i);
				}
			}

			for(new i = 0; i < sizeof(team_id); i++)
			{
				if(team_id[i] != -1)
				{
					Iter_Add(DuelPlayers[playerid], team_id[i]);
					DuelTeam[playerid][team_id[i]] = HOST_TEAM;
				}
			}
			return ShowDuelSettingsDialog(playerid);

		}
		case DIALOG_DUEL_ENEMIES:
		{
			if(!response)
				return ShowDuelSettingsDialog(playerid);

			new team_id[4];
			sscanf(inputtext, "uU(-1)U(-1)U(-1)", team_id[0], team_id[1], team_id[2], team_id[3]);
			if(!IsPlayerConnected(team_id[0]))
			{
				ShowDuelSettingsDialog(playerid);
				return SendClientMessage(playerid, -1, "{bf0000}DUEL: {FFFFFF}Player 1 is not connected.");
			}
			else if(!IsPlayerConnected(team_id[1]) && team_id[1] != -1)
			{
				ShowDuelSettingsDialog(playerid);
				return SendClientMessage(playerid, -1, "{bf0000}DUEL: {FFFFFF}Player 2 is not connected.");
			}
			else if(!IsPlayerConnected(team_id[2]) && team_id[2] != -1)
			{
				ShowDuelSettingsDialog(playerid);
				return SendClientMessage(playerid, -1, "{bf0000}DUEL: {FFFFFF}Player 3 is not connected.");
			}
			else if(!IsPlayerConnected(team_id[3]) && team_id[3] != -1)
			{
				ShowDuelSettingsDialog(playerid);
				return SendClientMessage(playerid, -1, "{bf0000}DUEL: {FFFFFF}Player 4 is not connected.");
			}
			else if(playerid == team_id[0] || playerid == team_id[1] || playerid == team_id[2] || playerid == team_id[3])
			{
				ShowDuelSettingsDialog(playerid);
				return SendClientMessage(playerid, -1, "{bf0000}DUEL: {FFFFFF}You cannot be an enemy.");
			}
			foreach(new i : DuelPlayers[playerid])
			{
				if(DuelTeam[playerid][i] != HOST_TEAM && (i != team_id[0] || i != team_id[1] || i != team_id[2] || i != team_id[3]))
				{
					Iter_SafeRemove(DuelPlayers[playerid], i, i);
				}
			}

			for(new i = 0; i < sizeof(team_id); i++)
			{
				if(team_id[i] != -1)
				{
					Iter_Add(DuelPlayers[playerid], team_id[i]);
					DuelTeam[playerid][team_id[i]] = 2;
				}
			}

			return ShowDuelSettingsDialog(playerid);
		}
		case DIALOG_DUEL_WEAPONS:
		{
			if(!response)
				return ShowDuelSettingsDialog(playerid);

			// Hacky way to solve the stuff with -1 weapon ids.
			listitem++;
			if(listitem >= 17)
				listitem += 3;

			// Iterator contains the weapon id already? Remove it.
			if(Iter_Contains(DuelWeapons[playerid], WeaponNames[listitem][weapon_id]))
			{
				Iter_Remove(DuelWeapons[playerid], WeaponNames[listitem][weapon_id]);
				return ShowWeaponSelectionDialog(playerid);
			}

			// Iterator contains a weapon already in the new weapon's slot? Remove it.
			foreach(new i : DuelWeapons[playerid])
			{
				if(GetWeaponSlot(i) == GetWeaponSlot(WeaponNames[listitem][weapon_id]))
				{
					Iter_SafeRemove(DuelWeapons[playerid], i, i);
				}
			}
			// Add the weapon back.
			Iter_Add(DuelWeapons[playerid], WeaponNames[listitem][weapon_id]);
			return ShowWeaponSelectionDialog(playerid);
		}
		case DIALOG_DUEL_HEALTH:
		{
			if(!response)
				return ShowDuelSettingsDialog(playerid);

			new Float:duel_health;
			if(sscanf(inputtext, "f", duel_health))
			{
				return ShowPlayerDialog(playerid, DIALOG_DUEL_HEALTH, DIALOG_STYLE_INPUT, "Duel - Health", "Please type in the amount of health you want.\nThis CANNOT go under 35.", "Input", "Cancel");
			}

			else if(duel_health < 35)
			{
				return ShowPlayerDialog(playerid, DIALOG_DUEL_HEALTH, DIALOG_STYLE_INPUT, "Duel - Health", "Please type in the amount of health you want.\nThis CANNOT go under 35.", "Input", "Cancel");
			}

			DuelHealth[playerid] = duel_health;
			return ShowDuelSettingsDialog(playerid);
		}
		case DIALOG_DUEL_ARMOUR:
		{
			if(!response)
				return ShowDuelSettingsDialog(playerid);

			if(sscanf(inputtext, "f", DuelArmour[playerid]))
			{
				return ShowPlayerDialog(playerid, DIALOG_DUEL_HEALTH, DIALOG_STYLE_INPUT, "Duel - Armour", "Please type in the amount of armour you want.", "Input", "Cancel");
			}

			if(DuelArmour[playerid] < 0.0)
				DuelArmour[playerid] = 0.0;

			return ShowDuelSettingsDialog(playerid);
		}
	}
	return 0;
}

// -----------------------------------------------------------------------------
// COMMANDS!
CMD:duel(cmdid, playerid, params[])
{
	if(IsPlayerInLobby(playerid))
	{
		if(ActivityState[playerid] == ACTIVITY_DUEL || ActivityState[playerid] == ACTIVITY_DUEL_PREP)
			return SendClientMessage(playerid, -1, "{bf0000}DUEL: {FFFFFF}You are currently in a duel. Do \"/leaveduel\" to leave the duel before you use this command.");

		// Accepted the duel.
		if(!strcmp(params, "accept", false) && DuelInvite[playerid] != -1 && ActivityState[playerid] == ACTIVITY_LOBBY)
		{
			new id = DuelInvite[playerid];

			SendClientMessage(id, -1, sprintf("{bf0000}DUEL: {%06x}%s {FFFFFF}has accepted your duel request.", GetPlayerColor(playerid) >>> 8, GetName(playerid)));

			foreach(new i : DuelPlayers[id])
			{
				SendClientMessage(i, -1, sprintf("{bf0000}DUEL: {%06x}%s {FFFFFF}has accepted their duel invite.", GetPlayerColor(playerid) >>> 8, GetName(playerid)));
			}

			PlayersAccepted[id]++;
			ActivityState[playerid] = ACTIVITY_DUEL_PREP;
			ActivityStateID[playerid] = id;

			if(PlayersAccepted[id] >= Iter_Count(DuelPlayers[id]))
			{
				foreach(new i : DuelPlayers[id])
				{
					SendClientMessage(i, -1, "{bf0000}DUEL: {FFFFFF}Everyone has accepted. The duel will start in 5 seconds!");
				}
				InitDuel(id);
				if(InviteCooldown[id] != -1)
				   KillTimer(InviteCooldown[id]);
			}
			return 1;
		}

		// Denied the duel.
		if(!strcmp(params, "deny", false) && DuelInvite[playerid] != -1 && ActivityState[playerid] == ACTIVITY_LOBBY)
		{
			new id = DuelInvite[playerid];
			foreach(new i : DuelPlayers[id])
			{
				SendClientMessage(i, -1, sprintf("{bf0000}DUEL: {%06x}%s {FFFFFF}has cancelled their duel invite. Duel is cancelled.", GetPlayerColor(playerid) >>> 8, GetName(playerid)));
				DuelInvite[i] = -1;
			}

			ClearDuelVariables(id);

			ActivityState[id] = ACTIVITY_LOBBY;
			ActivityStateID[id] = -1;

			if(InviteCooldown[id] != -1)
				KillTimer(InviteCooldown[id]);

			return SendClientMessage(id, -1, sprintf("{bf0000}DUEL: {%06x}%s {FFFFFF}has denied your duel request.", GetPlayerColor(playerid) >>> 8, GetName(playerid)));
		}

		ShowDuelSettingsDialog(playerid);
	}
	else return SendClientMessage(playerid, -1, "{bf0000}Notice: {FFFFFF}You must be in the lobby in order to use this command!");
	return 1;
}

CMD:reduel(cmdid, playerid, params[])
{
	SendDuel(playerid);
	return 1;
}

CMD:ad(cmdid, playerid, params[])
{
	return EmulateCommand(playerid, "/duel accept");
}

CMD:dd(cmdid, playerid, params[])
{
	return EmulateCommand(playerid, "/duel deny");
}

// -----------------------------------------------------------------------------
InitDuelArenas()
{
	Iter_Init(DuelPlayers);
	Iter_Init(DuelWeapons);
	return 1;
}

SendDuel(playerid)
{
	new
		team_mates[120],
		enemies[120],
		weapons[229]; // Might need to adjust these.
	GetDuelTeamMates(playerid, team_mates);
	GetDuelEnemies(playerid, enemies);
	GetDuelWeapons(playerid, weapons);

	AlliesCount[playerid] = 0;
	EnemyCount[playerid] = 0;

	foreach(new i : DuelPlayers[playerid])
	{
		new id = DuelInvite[playerid];
		if((id != -1 && id != playerid) || (ActivityState[playerid] == ACTIVITY_DUEL || ActivityState[playerid] == ACTIVITY_DUEL_PREP))
		{
			return SendClientMessage(playerid, -1, sprintf("{bf0000}DUEL: {%06x}%s {FFFFFF}is already invited to another duel or is in one.", GetPlayerColor(playerid) >>> 8, GetName(i)));
		}

		if(DuelTeam[playerid][i] == HOST_TEAM)
		{
			AlliesCount[playerid]++;
		}
		else
		{
			EnemyCount[playerid]++;
		}
	}

	if(EnemyCount[playerid] < 1)
	{
		SendClientMessage(playerid, -1, "{bf0000}DUEL: {FFFFFF}You must have at least 1 enemy selected for a duel.");
		return ShowDuelSettingsDialog(playerid);
	}

	foreach(new i : DuelPlayers[playerid])
	{
		if(i != playerid)
		{
			DuelInvite[i] = playerid;
			SendClientMessage(i, COLOR_LIGHTRED, "==== [DUEL INVITE] ====");
			SendClientMessage(i, COLOR_LIGHTRED, sprintf("{%06x}%s {FFFFFF}has invited you to a duel. ({31AEAA}%i {FFFFFF}v {31AEAA}%i)", GetPlayerColor(playerid) >>> 8, GetName(playerid), AlliesCount[playerid], EnemyCount[playerid]));
			SendClientMessage(i, COLOR_LIGHTRED, sprintf("Map: {F07D00}%s", DuelMaps[DuelMap[playerid]]));
			SendClientMessage(i, COLOR_LIGHTRED, sprintf("Team 1: {8df000}%s", team_mates));
			SendClientMessage(i, COLOR_LIGHTRED, sprintf("Team 2: {f03000}%s", enemies));
			SendClientMessage(i, COLOR_LIGHTRED, sprintf("Weapons: {F07D00}%s", weapons));
			SendClientMessage(i, COLOR_LIGHTRED, sprintf("Armour: {F07D00}%0.1f | Health: %.1f", DuelArmour[playerid], DuelHealth[playerid]));
			SendClientMessage(i, COLOR_LIGHTRED, "Type \"/duel accept\" or \"/duel deny\" to accept/deny the invite.");
			SendClientMessage(i, COLOR_LIGHTRED, "Alternatively you can type /ad or /dd.");
		}
	}
	SendClientMessage(playerid, -1, "{bf0000}DUEL: {FFFFFF}You have sent the duel request.");

	PlayersAccepted[playerid]++;
	ActivityState[playerid] = ACTIVITY_DUEL_PREP;

	if(InviteCooldown[playerid] != -1)
		KillTimer(InviteCooldown[playerid]);

	InviteCooldown[playerid] = SetTimerEx("DuelCooldown", 60000, false, "i", playerid);
	return 1;
}