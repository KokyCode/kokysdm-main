#define TEAM_GROVE 0
#define TEAM_BALLAS 1
#define TEAM_HOBOS 2
#define TEAM_LARAZA 3
#define TEAM_DONATORS 4
#define TEAM_STAFF 5
#define MAX_TEAMS 6

#define TDM_TURFPOS 1900.000183, -1825.5, 1959.000183, -1749.50000

#define WORLD_TDM 1025

forward SendPlayerToTDM(playerid, team);
forward RemoveFromTDM(playerid, team);
forward CapturingTurf(playerid, team);
forward AllowTurfCapture();
forward SpawnProtection(playerid);

new Iterator:TDMPlayers[MAX_TEAMS]<MAX_PLAYERS>;

new SpawnProtTimer[MAX_PLAYERS];

new inAmmunation[MAX_PLAYERS];

new igsturf;
new cancapture[MAX_PLAYERS];
new turfholder;
new capturecooldown;
new capturingturf[MAX_PLAYERS];
new capturingtimer[MAX_PLAYERS];
new beingcaptured;
new allowcapture;
new teamfull;

new tdmVehicles[32];

new tdmskins[][] =
{
	{106, 107},
	{102, 104},
	{134, 137},
	{108, 109},
	{20107, 20108},
	{20067, 20067}
};
new tdmcolors[] =
{
	0x3bce0eFF, //grove color
	0xac1bd2FF, //ballas color
	0xc2a36cFF, //hobo color
	0xffe700FF, //la raza color
	0xEB8686FF,	//donators color
	0x403F3FFF //staff color
};
new Float:tdmspawns[][] =
{
	{2304.4272, -1649.5432, 14.5653, 178.6283},
	{2138.6067, -1416.2043, 23.9882, 85.9196},
	{1714.9377, -1868.8563, 13.5666, 357.0203},
	{1883.1350, -2016.8785, 13.5469, 176.1087},
	{1879.2692, -1654.9495, 396.9682, 26.6051},
	{1478.6833, -1748.8501, 15.4453, 358.9349}
};
new ammudata[][] =
{
	{WEAPON_SNIPER, 10, -10000},
	{WEAPON_GRENADE, 1, -10000},
	{WEAPON_MOLTOV, 1, -10000},
	{WEAPON_M4, 100, -25000}
};

#include <pp-hooks>
hook public OnPlayerDisconnect(playerid, reason)
{
	if(ActivityState[playerid] == ACTIVITY_TDM)
	{
		if(GetPlayerTeam(playerid) < 100)
		{
			RemoveFromTDM(playerid, ActivityStateID[playerid]);
		}
		if(GetPlayerTeam(playerid) > 100)
		{
			cancapture[playerid] = 0;
			inAmmunation[playerid] = 0;

			SetPlayerTeam(playerid, NO_TEAM);
			GangZoneHideForPlayer(playerid, igsturf);
			DisablePlayerCheckpoint(playerid);
			RemovePlayerMapIcon(playerid, 1);

			SendPlayerToLobby(playerid);
		}
	}
}

InitTDM()
{
	Iter_Init(TDMPlayers);

	turfholder = -1;
	capturecooldown = 0;
	allowcapture = 1;
	beingcaptured = -1;
	teamfull = -1;

	igsturf = GangZoneCreate(TDM_TURFPOS);

	tdmVehicles[0] = CreateVehicleEx(560, 1739.1038, -1859.4188, 13.1980, 269.5023, 102, 102, 30, "{c2a36c}HOBO 0"); // hoboveh1
	tdmVehicles[1] = CreateVehicleEx(560, 1750.1447, -1859.6354, 13.1986, 270.6633, 102, 102, 30, "{c2a36c}HOBO 1"); // hoboveh2
	tdmVehicles[2] = CreateVehicleEx(522, 1728.6588, -1857.1234, 12.9762, 268.4332, 102, 102, 30, "{c2a36c}HOBO 2"); // hoboveh3
	tdmVehicles[3] = CreateVehicleEx(522, 1728.1938, -1852.6338, 12.9705, 266.6943, 102, 102, 30, "{c2a36c}HOBO 3"); // hoboveh4
	tdmVehicles[4] = CreateVehicleEx(422, 1761.1118, -1854.8752, 13.4023, 270.6712, 102, 102, 30, "{c2a36c}HOBO 4"); // hoboveh5
	tdmVehicles[5] = CreateVehicleEx(487, 1759.4092, -1836.8032, 13.7505, 276.2609, 102, 102, 30, "{c2a36c}HOBO 5"); // hoboveh6

	tdmVehicles[6] = CreateVehicleEx(560, 1877.9275, -2021.8860, 13.1674, 179.8829, 194, 1, 30, "{ffe700}LA RAZA 0"); // locotoesveh1
	tdmVehicles[7] = CreateVehicleEx(560, 1887.9025, -2028.5708, 13.1677, 179.0292, 194, 1, 30, "{ffe700}LA RAZA 1"); // locotoesveh2
	tdmVehicles[8] = CreateVehicleEx(487, 1883.5277, -2033.9568, 13.6556, 177.4556, 194, 1, 30, "{ffe700}LA RAZA 2"); // locotoesveh3
	tdmVehicles[9] = CreateVehicleEx(522, 1881.2020, -2008.6865, 13.1201, 1.5313, 194, 1, 30, "{ffe700}LA RAZA 3"); // locotoesveh4
	tdmVehicles[10] = CreateVehicleEx(522, 1884.8480, -2008.5251, 13.1174, 354.4152, 194, 1, 30, "{ffe700}LA RAZA 4"); // locotoesveh5
	tdmVehicles[11] = CreateVehicleEx(422, 1897.8478, -2048.9944, 13.3768, 270.9300, 194, 1, 30, "{ffe700}LA RAZA 5"); // locotoesveh6

	tdmVehicles[12] = CreateVehicleEx(422, 2282.3079, -1663.7507, 15.0281, 92.1032, 86, 86, 30, "{3bce0e}GROVE 0"); // groveveh1
	tdmVehicles[13] = CreateVehicleEx(560, 2292.3096, -1656.0493, 14.4923, 92.6113, 86, 86, 30, "{3bce0e}GROVE 1"); // groveveh2
	tdmVehicles[14] = CreateVehicleEx(560, 2287.3003, -1661.5609, 14.6011, 89.4993, 86, 86, 30, "{3bce0e}GROVE 2"); // groveveh2
	tdmVehicles[15] = CreateVehicleEx(487, 2288.8083, -1672.6659, 14.9333, 174.9590, 86, 86, 30, "{3bce0e}GROVE 3"); // groveveh4
	tdmVehicles[16] = CreateVehicleEx(522, 2312.7388, -1656.0612, 13.7543, 96.9187, 86, 86, 30, "{3bce0e}GROVE 4"); // groveveh5
	tdmVehicles[17] = CreateVehicleEx(522, 2310.6016, -1659.7665, 13.8324, 105.1833, 86, 86, 30, "{3bce0e}GROVE 5"); // groveveh6

	tdmVehicles[18] = CreateVehicleEx(522, 2122.1187, -1424.7202, 23.4041, 124.9077, 136, 136, 30, "{ac1bd2}BALLAS 0"); // ballasveh1
	tdmVehicles[19] = CreateVehicleEx(522, 2123.1455, -1420.8979, 23.3960, 127.9967, 136, 136, 30, "{ac1bd2}BALLAS 1"); // ballasveh2
	tdmVehicles[20] = CreateVehicleEx(487, 2113.6555, -1418.0839, 24.0193, 181.7752, 136, 136, 30, "{ac1bd2}BALLAS 2"); // ballasveh3
	tdmVehicles[21] = CreateVehicleEx(560, 2134.3689, -1424.7817, 23.6067, 178.1146, 136, 136, 30, "{ac1bd2}BALLAS 3"); // ballasveh4
	tdmVehicles[22] = CreateVehicleEx(560, 2127.7725, -1440.6964, 23.6142, 182.5467, 136, 136, 30, "{ac1bd2}BALLAS 4"); // ballasveh5
	tdmVehicles[23] = CreateVehicleEx(422, 2141.0320, -1428.8359, 24.4048, 92.4243, 136, 136, 30, "{ac1bd2}BALLAS 5"); // ballasveh6

	tdmVehicles[24] = CreateVehicleEx(560, 1513.1715, -1729.7783, 13.0879, 269.4126, 0, 0, 30, "{403F3F}STAFF 0"); // staffveh1
	tdmVehicles[25] = CreateVehicleEx(560, 1513.2729, -1735.0691, 13.0879, 267.9047, 0, 0, 30, "{403F3F}STAFF 1"); // staffveh2
	tdmVehicles[26] = CreateVehicleEx(487, 1474.4867, -1707.7325, 14.2454, 182.7746, 0, 0, 30, "{403F3F}STAFF 2"); // staffveh3
	tdmVehicles[27] = CreateVehicleEx(522, 1499.7643, -1729.5295, 12.9416, 268.6845, 0, 0, 30, "{403F3F}STAFF 3"); // staffveh4
	tdmVehicles[28] = CreateVehicleEx(522, 1501.4570, -1734.4968, 12.9435, 266.8923, 0, 0, 30, "{403F3F}STAFF 4"); // staffveh5
	tdmVehicles[29] = CreateVehicleEx(522, 1490.7515, -1734.5313, 12.9545, 268.6573, 0, 0, 30, "{403F3F}STAFF 5"); // staffveh6
	tdmVehicles[30] = CreateVehicleEx(522, 1491.0095, -1730.4106, 12.9445, 271.0119, 0, 0, 30, "{403F3F}STAFF 6"); // staffveh6
	tdmVehicles[31] = CreateVehicleEx(406, 1468.4607, -1732.6714, 14.9034, 270.4676, 0, 0, 30, "{403F3F}STAFF 7"); // staffveh6

	SetTimer("LimitTeams", 5000, true);

	for(new i; i < sizeof(tdmVehicles); i++)
	{
		SetVehicleVirtualWorld(i, WORLD_TDM);
	}

	return true;
}

hook public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (ActivityState[playerid] == ACTIVITY_TDM)
	{
		if(PRESSED(KEY_SECONDARY_ATTACK))
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, 1367.9875, -1279.7437, 13.5469))
			{
				inAmmunation[playerid] = 1;
				SetPlayerPosEx(playerid, 286.148986, -40.644397, 1001.515625, 1, WORLD_TDM);
				SendClientMessage(playerid, COLOR_LIGHTRED, "Ammunation: Welcome to ammunation, use /buy to purchase ammunation.");
			}
			if(IsPlayerInRangeOfPoint(playerid, 5.0, 286.148986, -40.644397, 1001.515625))
			{
				inAmmunation[playerid] = 0;
				SetPlayerPosEx(playerid, 1367.9875, -1279.7437, 13.5469, 0, WORLD_TDM);
			}
		}
	}
	return false;
}
hook public OnPlayerEnterCheckpoint(playerid)
{
	if(ActivityState[playerid] == ACTIVITY_TDM && cancapture[playerid])
	{
		if(turfholder == ActivityStateID[playerid]) return SendClientMessage(playerid, COLOR_LIGHTRED, "{49FF00}TURF: Your team already holds this turf!");
		if(capturecooldown != 0) return SendClientMessage(playerid, COLOR_LIGHTRED, "{49FF00}TURF: The turf was recently captured, please wait for the next capture availability.");
		if(capturingturf[playerid] == 1) return SendClientMessage(playerid, COLOR_LIGHTRED, "{49FF00}TURF: You are already capturing this turf!");
		if(beingcaptured != -1) return SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("{49FF00}TURF: %s is capturing the turf! Kill him to capture it!", GetName(beingcaptured)));
		if(allowcapture == 0) return SendClientMessage(playerid, COLOR_LIGHTRED, "TURF: The turf cannot be captured at this time!");
		if(IsPlayerInVehicle(playerid, GetPlayerVehicleID(playerid))) return SendClientMessage(playerid, COLOR_LIGHTRED, "{49FF00}TURF: You cannot be in a vehicle while capturing the turf!");
		SendTDMMessage(COLOR_LIGHTRED, sprintf("{49FF00}TURF: %s is capturing the turf! Kill him to stop the capture.", GetName(playerid)));
		capturingturf[playerid] = 1;
		capturingtimer[playerid] = SetTimerEx("CapturingTurf", 45000, false, "ii", playerid, ActivityStateID[playerid]);
		GangZoneFlashForTDM(GetPlayerColor(playerid));
		beingcaptured = playerid;
		return true;
	}
	return false;
}
hook public OnPlayerUpdate(playerid)
{
	if(ActivityState[playerid] == ACTIVITY_TDM && capturingturf[playerid] == 1)
	{
		if(!IsPlayerInArea(playerid, TDM_TURFPOS))
		{
			SendTDMMessage(COLOR_LIGHTRED, sprintf("{49FF00}TURF: %s has left the turf while capturing. The turf is now available for capture!", GetName(playerid)));
			KillTimer(capturingtimer[playerid]);
			capturingturf[playerid] = 0;
			beingcaptured = -1;
			GangZoneStopFlashForAll(igsturf);
		}
	}
}
hook public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(ActivityState[playerid] == ACTIVITY_TDM)
	{
		if(capturingturf[playerid] == 1)
		{
			SendTDMMessage(COLOR_LIGHTRED, sprintf("{49FF00}TURF: %s has entered a vehicle while capturing the turf. The turf is now available for capture!", GetName(playerid)));
			KillTimer(capturingtimer[playerid]);
			capturingturf[playerid] = 0;
			beingcaptured = -1;
			GangZoneStopFlashForAll(igsturf);
		}
		if(!ispassenger)
		{
			if(GetVehicleDriver(vehicleid) != -1 && ActivityStateID[playerid] == ActivityStateID[GetVehicleDriver(vehicleid)])
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				SetPlayerPos(playerid, x, y, z + 2.0);

				ClearAnimations(playerid, 1);
				GameTextForPlayer(playerid, "~r~Don't jack your Team vehicle", 3000, 3);
			}
		}
	}
}

OfficialClanSelection(playerid)
{
	new clan = Account[playerid][ClanID], Float:xspawn, Float:yspawn, Float:zspawn, Float:angle, skin, isofficial;

	await mysql_aquery_s(SQL_CONNECTION, str_format("SELECT * FROM clans WHERE id = %d", clan));
	if(!cache_num_rows()) return false;

	cache_get_value_name_float(0, "x", xspawn);
	cache_get_value_name_float(0, "y", yspawn);
	cache_get_value_name_float(0, "z", zspawn);
	cache_get_value_name_float(0, "angle", angle);
	cache_get_value_int(0, "skin", skin);
	cache_get_value_int(0, "official", isofficial);

	if(isofficial == 0)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "ERROR: {FFFFFF}Your clan is not official. Create a thread on the forums and post frequently.");

	if(xspawn == 0 && yspawn == 0 && zspawn == 0)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "Notice: Your clan spawn has not been set, please contact the Clan Managment team.");
		return false;
	}

	if(xspawn != 0 && yspawn != 0 && zspawn != 0)
	{
		SetPlayerTeam(playerid, Account[playerid][ClanID] + 100);
		ActivityState[playerid] = ACTIVITY_TDM;
		ActivityStateID[playerid] = Account[playerid][ClanID] + 100;
		CreateTDMMapping(playerid);
		SendClientMessage(playerid, COLOR_LIGHTRED, "Use /c [text] to speak with your clanmates.");

		ResetPlayerWeapons(playerid);
		GiveTDMAmmunation(playerid);
		Account[playerid][CopChaseDead] = 1;
		SpawnProtTimer[playerid] = SetTimerEx("SpawnProtection", 8000, false, "i", playerid);
		
		SetPlayerColor(playerid, Clans[Account[playerid][ClanID]][clancolor]);
		SetPlayerPosEx(playerid, xspawn, yspawn, zspawn, 0, WORLD_TDM);
		SetPlayerFacingAngle(playerid, angle);
		SetCameraBehindPlayer(playerid);
		if(clanskins[playerid] == -1) SetPlayerSkinEx(playerid, skin);
		else if(clanskins[playerid] == 1) SetPlayerSkinEx(playerid, Clans[Account[playerid][ClanID]][skin1]);
		else if(clanskins[playerid] == 2) SetPlayerSkinEx(playerid, Clans[Account[playerid][ClanID]][skin2]);
		else if(clanskins[playerid] == 3) SetPlayerSkinEx(playerid, Clans[Account[playerid][ClanID]][skin3]);
		SetPlayerCheckpoint(playerid, 1929.8989, -1776.3195, 13.5469, 2);
		SetPlayerMapIcon(playerid, 1, 1367.9875, -1279.7437, 13.5469, 6, 0, MAPICON_GLOBAL_CHECKPOINT);
		GangZoneShowForPlayer(playerid, igsturf, 0xFF0000FF);
		cancapture[playerid] = 1;
	}
	return true;
}
ShowTeamSelectionDialog(playerid)
{
	yield 1;

	new str[300];
	strcat(str, sprintf("{3bce0e}Grove\t\t{dddf33} %i Members\n", Iter_Count(TDMPlayers[TEAM_GROVE])));
	strcat(str, sprintf("{ac1bd2}Ballas\t\t{dddf33} %i Members\n", Iter_Count(TDMPlayers[TEAM_BALLAS])));
	strcat(str, sprintf("{c2a36c}Hobos\t\t{dddf33} %i Members\n", Iter_Count(TDMPlayers[TEAM_HOBOS])));
	strcat(str, sprintf("{ffe700}La Raza\t{dddf33} %i Members\n", Iter_Count(TDMPlayers[TEAM_LARAZA])));
	strcat(str, sprintf("{EB8686}Donators\t{dddf33} %i Members\n", Iter_Count(TDMPlayers[TEAM_DONATORS])));
	if(Account[playerid][Admin] > 0)
	{
		strcat(str, sprintf("{EAC9BE}Staff Team\t{dddf33} %i Members\n", Iter_Count(TDMPlayers[TEAM_STAFF])));
	}
	if(Account[playerid][ClanID] > 0)
	{
		strcat(str, sprintf("{EAC9BE}%s", Account[playerid][ClanName]));
	}

	new response[e_DIALOG_RESPONSE_INFO];
	AwaitAsyncDialog(playerid, response, DIALOG_STYLE_LIST, "Select A Team", str, "Select", "Cancel");

	if(!response[E_DIALOG_RESPONSE_Response]) return true;

	new teamchoice = response[E_DIALOG_RESPONSE_Listitem];
	if(teamchoice == 4 && Account[playerid][Donator] < 3) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERROR: {FFFFFF}This is for Gold or Diamond donators only! (/donate)");
	if(teamchoice == teamfull) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERROR: {FFFFFF}This team is currently full, please select another team.");
	if(teamchoice < 5)
	{
		SetPlayerTeam(playerid, teamchoice + 1);
		ActivityState[playerid] = ACTIVITY_TDM;
		ActivityStateID[playerid] = teamchoice;
		SendPlayerToTDM(playerid, ActivityStateID[playerid]);
		CreateTDMMapping(playerid);
		SendClientMessage(playerid, COLOR_LIGHTRED, "{9f9f9f}Use /g [text] to speak with your teammates.");
	}
	if(teamchoice == 5 && Account[playerid][Admin] > 0)
	{
		SetPlayerTeam(playerid, teamchoice + 1);
		ActivityState[playerid] = ACTIVITY_TDM;
		ActivityStateID[playerid] = teamchoice;
		SendPlayerToTDM(playerid, ActivityStateID[playerid]);
		CreateTDMMapping(playerid);
		SendClientMessage(playerid, COLOR_LIGHTRED, "{9f9f9f}Use /g [text] to speak with your teammates.");
	}
	if(teamchoice == 6 && Account[playerid][Admin] > 0)
	{
		OfficialClanSelection(playerid);
	}
	if(teamchoice == 5 && Account[playerid][Admin] == 0)
	{
		OfficialClanSelection(playerid);
	}
	return true;
}

IsPlayerInArea(playerid, Float:MinX, Float:MinY, Float:MaxX, Float:MaxY)
{
	new Float:X, Float:Y, Float:Z;

	GetPlayerPos(playerid, X, Y, Z);
	if(X >= MinX && X <= MaxX && Y >= MinY && Y <= MaxY)
	{
		return 1;
	}
	return 0;
}
GetVehicleDriver(vehicleid)
{
    foreach(new i: Player)
    {
        if(GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid) return i;
    }
    return -1;
}
SendTDMMessage(color, const str[])
{
	foreach(new i: Player)
	{
		if(ActivityState[i] == ACTIVITY_TDM)
		{
			SendClientMessage(i, color, str);
		}
	}
	return true;
}
DrivebyCheck(playerid)
{
	if(GetPlayerCameraMode(playerid) == 55)
    {
        if(GetVehicleDriver(GetPlayerVehicleID(playerid)) == -1)
    	{
    	    RemovePlayerFromVehicle(playerid);
    	    GameTextForPlayer(playerid, "~R~Don't driveby without a driver!", 1200, 6);
    	}
   	}
   	return true;
}
public SpawnProtection(playerid)
{
	Account[playerid][CopChaseDead] = 0;
	SendClientMessage(playerid, 0xbf0000FF, "SPAWN PROTECTION: {FFFFFF}Your spawn protection has been disabled.");

	Account[playerid][CopChaseDead] = 0;

	return true;
}
public CapturingTurf(playerid, team)
{
	turfholder = team;
	SendTDMMessage(COLOR_LIGHTRED, sprintf("{49FF00}TURF: %s has captured the turf for their team! It will be available for capture in 20 minutes.", GetName(playerid)));
	GangZoneStopFlashForAll(igsturf);
	GangZoneCapturedTDM(GetPlayerColor(playerid));
	SetTimer("AllowTurfCapture", 900000, false);
	allowcapture = 0;
	beingcaptured = -1;
	capturingturf[playerid] = 0;
	return true;
}
GangZoneFlashForTDM(color)
{
	foreach(new i: Player)
	{
		if(ActivityState[i] == ACTIVITY_TDM)
		{
			GangZoneFlashForPlayer(i, igsturf, color);
		}
	}
	return true;
}
GangZoneCapturedTDM(color)
{
	foreach(new i: Player)
	{
		if(ActivityState[i] == ACTIVITY_TDM)
		{
			GangZoneHideForPlayer(i, igsturf);
			GangZoneShowForPlayer(i, igsturf, color);
		}
	}
	return true;
}
public AllowTurfCapture()
{
	capturecooldown = 0;
	SendTDMMessage(COLOR_LIGHTRED, "{49FF00}TURF: The turf is now available for capture! Go grab it for your team.");
	beingcaptured = -1;
	allowcapture = 1;
	turfholder = -1;
	return true;
}
public RemoveFromTDM(playerid, team)
{
	DestroyAllPlayerObjects(playerid);
	Iter_Remove(TDMPlayers[team], playerid);
	if(capturingturf[playerid] == 1)
	{
		KillTimer(capturingtimer[playerid]);
		capturingturf[playerid] = 0;
		beingcaptured = -1;
		SendTDMMessage(COLOR_LIGHTRED, sprintf("{49FF00}TURF: %s returned to lobby while capturing the turf. The turf is now available for capture!", GetName(playerid)));
		GangZoneStopFlashForAll(igsturf);
	}
	SetPlayerTeam(playerid, NO_TEAM);
	GangZoneHideForPlayer(playerid, igsturf);
	DisablePlayerCheckpoint(playerid);
	cancapture[playerid] = 0;
	RemovePlayerMapIcon(playerid, 1);
	SendPlayerToLobby(playerid);
	Account[playerid][CopChaseDead] = 0;
	inAmmunation[playerid] = 0;
	return true;
}
public SendPlayerToTDM(playerid, team)
{
	ResetPlayerWeapons(playerid);
	GiveTDMAmmunation(playerid);
	Account[playerid][CopChaseDead] = 1;
	SpawnProtTimer[playerid] = SetTimerEx("SpawnProtection", 8000, false, "i", playerid);

	SetPlayerColor(playerid, tdmcolors[team]);
	SetPlayerPosEx(playerid, tdmspawns[team][0], tdmspawns[team][1], tdmspawns[team][2], 0, WORLD_TDM);
	SetPlayerFacingAngle(playerid, tdmspawns[team][3]);
	SetPlayerSkin(playerid, tdmskins[team][random(2)]);
	SetPlayerTeam(playerid, team + 1);
	SetPlayerCheckpoint(playerid, 1929.8989, -1776.3195, 13.5469, 2);
	SetPlayerMapIcon(playerid, 1, 1367.9875, -1279.7437, 13.5469, 6, 0, MAPICON_GLOBAL_CHECKPOINT);
	GangZoneShowForPlayer(playerid, igsturf, 0xFF0000FF);

	cancapture[playerid] = 1;
	Account[playerid][CopChaseDead] = 0;
	if(!Iter_Contains(TDMPlayers[team], playerid)) Iter_Add(TDMPlayers[team], playerid);
	return true;
}
forward LimitTeams();
public LimitTeams()
{
	new const team1 = Iter_Count(TDMPlayers[TEAM_GROVE]);
	new const team2 = Iter_Count(TDMPlayers[TEAM_BALLAS]);
	new const team3 = Iter_Count(TDMPlayers[TEAM_HOBOS]);
	new const team4 = Iter_Count(TDMPlayers[TEAM_LARAZA]);

	if(team1 <= 0 && team2 <= 0 && team3 <= 0 && team4 <= 0)
	{
		teamfull = -1;
	}
	else if(team1 > team2 && team1 > team3 && team1 > team4)
	{
		teamfull = TEAM_GROVE;
	}
	else if(team2 > team1 && team2 > team3 && team2 > team4)
	{
		teamfull = TEAM_BALLAS;
	}
	else if(team3 > team1 && team3 > team2 && team3 > team4)
	{
		teamfull = TEAM_HOBOS;
	}
	else if(team4 > team1 && team4 > team2 && team4 > team3)
	{
		teamfull = TEAM_LARAZA;
	}
}
GiveTDMAmmunation(playerid)
{
	GivePlayerWeapon(playerid, WEAPON_DEAGLE, 500);
	GivePlayerWeapon(playerid, WEAPON_AK47, 205);
	GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 100);

	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 50);
	if(Account[playerid][Donator] == 4)
	{
		GivePlayerWeapon(playerid, WEAPON_SNIPER, 25);
		SetPlayerArmour(playerid, 100);
		SendClientMessage(playerid, -1, "{fdff00}DONATOR: You have been given a Sniper & 100 armour for being Diamond Donator!");
	} else if(Account[playerid][Donator] == 4)
	{
		GivePlayerWeapon(playerid, WEAPON_SNIPER, 10);
		SetPlayerArmour(playerid, 75);
		SendClientMessage(playerid, -1, "{fdff00}DONATOR: You have been given a Sniper & 75 armour for being Gold Donator!");
	}

	if(Account[playerid][Donator] >= 3 && GetPlayerTeam(playerid) == 5)
	{
		GivePlayerWeapon(playerid, WEAPON_PARACHUTE, 1);
	}

	if(turfholder == ActivityStateID[playerid])
	{
		SetPlayerArmour(playerid, 100);
		GivePlayerWeapon(playerid, WEAPON_M4, 300);
		SendClientMessage(playerid, -1, "{49FF00}TURF: You have been given 100 Armour and an M4 as your team holds the turf.");
	}

	Account[playerid][CopChaseDead] = 0;

	return true;
}
Menu:AMMUNATION(playerid, response, listitem)
{
	if(response == MENU_RESPONSE_CLOSE) return TogglePlayerControllable(playerid, true);

	if(response == MENU_RESPONSE_SELECT)
	{
		TogglePlayerControllable(playerid, true);
		if(listitem != 4)
		{
			if(Account[playerid][Cash] < ammudata[listitem][2]) return SendClientMessage(playerid, COLOR_RED, "Ammunation: I'm afraid you don't have enough money to purchase!");

			GivePlayerWeapon(playerid, ammudata[listitem][0], ammudata[listitem][1]);
			GivePlayerMoneyEx(playerid, ammudata[listitem][2]);
		}
		else
		{
			if(Account[playerid][Cash] < 10000) return SendClientMessage(playerid, COLOR_RED, "Ammunation: I'm afraid you don't have enough money to purchase!");

			SetPlayerHealth(playerid, 100);
			SetPlayerArmour(playerid, 100);
			GivePlayerMoneyEx(playerid, -10000);
		}
	}
	return true;
}
CMD<TDM>:buy(cmdid, playerid, params[])
{
	if(inAmmunation[playerid] == 1)
	{
	    ShowPlayerMenu(playerid, AMMUNATION, "Weapons Menu");
	    AddPlayerMenuItem(playerid, "Sniper", "Lethal weapon, will cost you $40,000 per 10 bullets!");
	    AddPlayerMenuItem(playerid, "Grenade", "Lethal weapon, will cost you $10,000 per grenade!");
	    AddPlayerMenuItem(playerid, "Molotov Cocktail", "Lethal weapon, will cost you $10,000 per molotov!");
	    AddPlayerMenuItem(playerid, "M4", "Weapon, will cost you $25,000 per 100 bullets!");
	    AddPlayerMenuItem(playerid, "Health & Armour", "Medical, will cost you $10,000 per refill!");

	    TogglePlayerControllable(playerid, false);

	    SendClientMessage(playerid, COLOR_LIGHTRED, "SHOP: {FFFFFF}Use the ARROW KEYS to navigate UP and DOWN.");
	    SendClientMessage(playerid, COLOR_LIGHTRED, "SHOP: {FFFFFF}Press SPACE to purchase an item.");
	    SendClientMessage(playerid, COLOR_LIGHTRED, "SHOP: {FFFFFF}Press ENTER to CLOSE the shop.");
	}
    return 1;
}
CMD<TDM>:tdm(cmdid, playerid, params[])
{
	if(!IsPlayerInLobby(playerid)) return SendClientMessage(playerid, -1, "{31AEAA}Team Deathmatch: {FFFFFF}You must be in the lobby to use this command. This may occur due to an ongoing duel request or a bug, /lobby for a fix or contact an admin.");

	ShowTeamSelectionDialog(playerid);
	return true;
}
CMD<TDM>:g(cmdid, playerid, params[])
{
	if(ActivityState[playerid] != ACTIVITY_TDM) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}TDM: {FFFFFF}You must be in TDM to use this command..");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GRAY, "USAGE: /g [text]");

	foreach(new i: Player)
	{
		if(ActivityState[i] == ACTIVITY_TDM && ActivityStateID[playerid] == ActivityStateID[i])
		{
			SendClientMessage(i, -1, sprintf("{4CB6FF}TEAM CHAT: %s(%i): %s", GetName(playerid), playerid, params));
		}
	}
	return 1;
}
ALT:tc = CMD:g;
HandleTDMSpawn(playerid)
{
	if(GetPlayerTeam(playerid) < 100)
	{
		SendPlayerToTDM(playerid, ActivityStateID[playerid]); //ADD OFFICIAL CLAN CHECK!!!!!
	}
	if(GetPlayerTeam(playerid) > 100)
	{
		OfficialClanSelection(playerid);
	}
}
