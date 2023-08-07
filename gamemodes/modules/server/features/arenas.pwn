
//data
new EnableArenas = 1;
new Iterator:ArenaOccupants[MAX_ARENAS + 1]<MAX_PLAYERS>;

enum ARENA_SPAWNS
{
	Float:SpawnX,
	Float:SpawnY,
	Float:SpawnZ,
	Float:SpawnRot,
	ArenaID
};

enum ARENA_WEAPONS
{
	ArenaWeapon,
	ArenaAmmo,
	ArenaID
};
enum ARENA_DATA
{
	ArenaName[64],
	ArenaLimit,
	Float:ArenaHP,
	Float:ArenaArmor,
	ArenaInt,
	ArenaWorld,
	ArenaMapCallback[32]
}

new ArenaSpawns[][ARENA_SPAWNS] =
{
	//western town
	{3881.6802, -1958.2377, 3.0083, 350.1957, 0},
	{3902.8997, -1943.4403, 3.0156, 3.1873, 0},
	{3925.2549, -1952.1211, 3.0156, 0.8255, 0},
	{3937.3198, -1927.1698, 3.0156, 89.8130, 0},
	{3927.3674, -1913.8987, 4.0156, 177.2338, 0},
	{3883.2200, -1906.6936, 3.5078, 0.6806, 0},
	{3879.8264, -1875.1056, 7.4844, 271.1727, 0},
	{3884.0962, -1862.2542, 3.0156, 2.8190, 0},
	{3935.6987, -1822.7385, 3.0510, 180.4932, 0},
	{3916.1008, -1802.7905, 3.2122, 179.3091, 0},
	{3895.5352, -1762.5607, 3.0156, 256.9207, 0},
	{3912.6602, -1746.3439, 3.0083, 177.5741, 0},
	{3933.2905, -1766.8291, 3.0156, 104.7352, 0},
	{3927.2625, -1785.1849, 3.0156, 175.6217, 0},

	//sewers
	{2849.5378, 2674.5549, 12.5637, 86.9492, 1},
	{2840.4504, 2692.5986, 12.5637, 88.4032, 1},
	{2876.7219, 2730.4673, 12.5637, 81.9021, 1},
	{2845.4578, 2752.4260, 12.5637, 186.9038, 1},
	{2816.0950, 2748.7756, 12.5537, 181.9969, 1},
	{2768.6255, 2736.9043, 12.6092, 270.8483, 1},
	{2779.5361, 2678.9243, 12.5487, 180.3854, 1},

	//tennis court
	{-2715.1438, -234.4539, 7.1952, 89.9062, 2},
	{-2713.4045, -252.8053, 7.0942, 89.5803, 2},
	{-2713.3984, -269.8722, 7.1622, 84.7784, 2},
	{-2735.8975, -273.1595, 7.1875, 2.1704, 2},
	{-2732.3647, -252.2155, 7.1875, 89.1776, 2},
	{-2751.2737, -251.9440, 7.1875, 89.1776, 2},
	{-2751.8804, -231.1235, 7.0375, 186.0809, 2},
	{-2771.9709, -232.0511, 7.1460, 179.3574, 2},
	{-2790.7126, -234.9515, 7.0369, 272.3933, 2},
	{-2790.5684, -251.7662, 7.0535, 267.1794, 2},
	{-2787.4844, -273.1710, 7.1875, 352.2315, 2},

	//the farm
	{-703.2117, 925.7681, 12.5590, 268.7422, 3},
	{-666.2263, 918.9478, 12.0793, 48.0515, 3},
	{-648.8793, 935.8990, 12.1328, 87.3188, 3},
	{-651.0181, 984.8845, 12.1328, 142.3908, 3},
	{-680.0721, 968.4504, 12.5568, 356.2813, 3},
	{-700.9882, 980.1034, 15.2800, 194.1180, 3},
	{-699.5894, 950.8112, 12.3315, 261.7360, 3},
	{-671.1483, 951.4883, 12.1328, 172.6106, 3},
	{-667.6432, 930.6154, 12.1328, 87.8846, 3},

	//rc battleground
	{-969.9025, 1099.2635, 1344.9979, 180.4918, 4},
	{-974.2535, 1022.9238, 1345.0454, 359.6968, 4},
	{-1031.1139, 1022.1336, 1342.6007, 353.7434, 4},
	{-1034.2985, 1098.7196, 1343.1118, 176.7084, 4},
	{-1101.9979, 1099.7274, 1341.8208, 180.1551, 4},
	{-1100.8927, 1019.3475, 1342.0938, 3.8792, 4},
	{-1135.4661, 1020.3090, 1345.7441, 298.9128, 4},
	{-1130.1964, 1057.7325, 1346.4141, 266.3258, 4},

	//meat factory
	{959.1294, 2098.3921, 1011.0237, 0.0212, 5},
	{965.1623, 2108.2776, 1011.0303, 97.8761, 5},
	{932.6434, 2108.8809, 1011.0234, 262.7303, 5},
	{948.5219, 2103.7117, 1011.0234, 3.2054, 5},
	{965.3802, 2128.0024, 1011.0234, 96.3486, 5},
	{932.7155, 2129.8604, 1011.0234, 256.1268, 5},
	{932.8464, 2144.4580, 1011.0234, 271.3549, 5},
	{951.5865, 2144.5303, 1011.0194, 90.5964, 5},
	{932.7509, 2150.7810, 1011.0234, 279.2210, 5},
	{941.6859, 2177.0518, 1011.0234, 174.2338, 5},
	{958.7984, 2177.8425, 1011.0234, 174.0342, 5},
	{953.4114, 2149.9014, 1011.0234, 353.3879, 5},

	//crack factory
	{2541.1272, -1318.6278, 1031.4219, 87.3956, 6},
	{2527.5273, -1290.1344, 1031.4219, 176.1089, 6},
	{2550.1301, -1305.3534, 1031.4219, 357.4368, 6},
	{2569.9395, -1304.6892, 1031.4219, 344.7466, 6},
	{2576.1985, -1285.3860, 1031.4219, 102.0596, 6},
	{2573.7090, -1283.8511, 1037.7734, 90.9029, 6},
	{2566.6472, -1304.4838, 1037.7734, 266.9139, 6},
	{2579.3665, -1284.4087, 1044.1250, 165.7923, 6},
	{2575.7876, -1280.3159, 1044.1250, 176.7904, 6},
	{2566.4653, -1281.5619, 1044.1250, 171.1503, 6},
	{2537.1052, -1280.5116, 1044.1250, 177.3544, 6},
	{2532.1624, -1280.9600, 1048.2891, 265.7858, 6},
	{2570.0425, -1292.4961, 1048.2891, 70.3581, 6},
	{2526.2607, -1306.0779, 1048.2891, 0.1394, 6},

	//pleasure domes
	{-782.4977, 489.2171, 1376.1953, 357.7028, 7},
	{-794.6271, 489.3680, 1376.1953, 358.2095, 7},
	{-779.4582, 497.4663, 1371.7490, 73.5630, 7},
	{-777.4786, 495.6812, 1368.5234, 86.0071, 7},
	{-789.5129, 510.2673, 1367.3745, 184.3571, 7},
	{-799.2029, 488.7800, 1364.1968, 64.8741, 7},
	{-833.1705, 489.9803, 1358.3038, 4.9250, 7},
	{-844.7684, 500.9284, 1358.1379, 264.6699, 7},
	{-833.4308, 519.7030, 1357.1016, 176.6207, 7},
	{-809.5950, 509.8304, 1360.3873, 180.1929, 7},

	// mad dog mansion
	{1265.0422, -781.3758, 1091.9063, 271.8653, 8},
	{1272.5524, -797.4643, 1089.9375, 351.1393, 8},
	{1289.5142, -786.2766, 1089.9375, 166.4274, 8},
	{1272.3583, -804.2903, 1089.9303, 274.0584, 8},
	{1289.7860, -801.9866, 1089.9375, 184.3109, 8},
	{1271.9839, -818.6398, 1089.9375, 272.0450, 8},
	{1292.5596, -818.7366, 1089.9375, 97.3599, 8},
	{1282.7593, -838.8334, 1089.9375, 6.9443, 8},
	{1278.0042, -812.4653, 1085.6328, 184.4493, 8},
	{1254.3116, -828.0401, 1084.0078, 188.8125, 8},
	// Jefferson Motel
	{2221.1677, -1153.2653, 1025.7969, 359.5554, 9},
	{2251.7324, -1159.9332, 1029.7969, 90.4230, 9},
	{2236.0789, -1168.1982, 1029.7969, 180.9772, 9},
	{2237.3110, -1193.5348, 1029.8043, 310.6750, 9},
	{2240.6030, -1192.6548, 1033.7969, 358.3022, 9},
	{2225.4463, -1177.5105, 1029.7969, 180.9536, 9},
	{2189.8535, -1190.3217, 1029.7969, 306.8914, 9},
	{2189.2551, -1180.8033, 1033.7896, 183.1001, 9},
	{2198.4607, -1175.1072, 1029.8043, 6.0884, 9},
	{2187.8687, -1152.0657, 1030.4943, 181.5568, 9},
	{2193.1819, -1142.0420, 1029.7969, 178.1100, 9},
	{2190.4995, -1146.5129, 1033.7969, 269.8942, 9},

	//dust 2
	{2579.0378, 973.7575, 2006.5078, 86.2470, 10},
	{2576.7122, 958.2054, 2008.3596, 92.5136, 10},
	{2577.3081, 962.2904, 2010.6586, 145.7780, 10},
	{2592.7280, 948.5880, 2012.7797, 86.7454, 10},
	{2585.8435, 969.8474, 2012.0742, 135.1243, 10},
	{2560.9133, 966.4774, 2009.6713, 86.4254, 10},
	{2566.4021, 934.1793, 2010.8756, 1.6995, 10},
	{2536.5940, 935.1665, 2011.1246, 356.5607, 10},
	{2520.6377, 941.5176, 2004.8145, 271.6007, 10},
	{2547.3259, 960.5210, 2009.6453, 85.8979, 10},
	{2531.3044, 959.6816, 2009.6420, 1.3203, 10},
	{2528.3240, 971.3999, 2009.6978, 94.1106, 10},
	{2530.2019, 995.9206, 2009.8207, 177.2271, 10},
	{2513.3499, 990.3740, 2009.7949, 183.5564, 10},
	{2508.5930, 1006.3300, 2013.2343, 0.4659, 10},
	{2509.4619, 1025.8197, 2011.5442, 271.4748, 10},
	{2523.2747, 1014.4479, 2009.9570, 359.1660, 10},
	{2548.2258, 1008.3361, 2011.0789, 183.1768, 10},
	{2553.1123, 1007.3466, 2007.0730, 179.0836, 10},
	{2551.8916, 996.7669, 2007.0206, 200.4334, 10},
	{2580.0269, 996.2415, 2007.3724, 86.2342, 10},
	{2571.8018, 1007.7918, 2009.8910, 254.2879, 10},
	{2549.6311, 1030.8885, 2010.7877, 179.6315, 10},
	{2595.1772, 1028.2366, 2010.7692, 90.7066, 10},
	{2586.9924, 1011.9640, 2010.3138, 355.3898, 10},
	{2560.1606, 1020.1123, 2009.9330, 269.9117, 10},

	//lvpd
	{301.9234, 175.4359, 1007.1719, 93.0642, 11},
	{288.9883, 166.9221, 1007.1719, 2.8583, 11},
	{300.9136, 191.4939, 1007.1719, 91.0061, 11},
	{267.3105, 184.1255, 1008.1719, 7.5834, 11},
	{257.1903, 184.0862, 1008.1719, 0.0884, 11},
	{239.0793, 139.1706, 1003.0234, 7.0947, 11},
	{216.6115, 168.8600, 1003.0234, 85.7750, 11},
	{188.8886, 158.4547, 1003.0234, 271.7779, 11},
	{196.3433, 168.3129, 1003.0234, 275.1227, 11},
	{188.3957, 179.2941, 1003.0234, 274.5572, 11},

	//Ghost town spawns
    {-383.0714, 2206.3538, 42.4235, 284.3897, 12},
	{-333.6323, 2219.6775, 42.4882, 106.3757, 12},
	{-373.2918, 2254.2776, 42.4844, 101.0908, 12},
	{-412.4232, 2270.8335, 42.0960, 235.2172, 12},
	{-445.6455, 2231.4150, 42.4297, 290.5942, 12}

};
new ArenaInfo[MAX_ARENAS + 1][ARENA_DATA] =
{
	{"", 0, 0.0, 0.0, 0, 0, ""},
	{"Western Town", 15, 100.0, 50.0, 0, 25, "CreateWesternTown"},
	{"The Sewers", 15, 100.0, 100.0, 3, 27, "CreateSewers"},
	{"Tennis Court", 15, 100.0, 0.0, 0, 28, ""},
	{"The Farm", 15, 100.0, 50.0, 0, 29, "CreateFarm"},
	{"RC Battle Ground", 15, 100.0, 100.0, 10, 30, ""},
	{"Meat Factory", 15, 100.0, 50.0, 1, 32, ""},
	{"Pleasure Domes", 15, 100.0, 100.0, 3, 33, ""},
	{"Liberty City", 15, 100.0, 100.0, 1, 33, ""},
	{"Madd Dogg Mansion", 15, 100.0, 100.0, 5, 33, ""},
	{"Jefferson Motel", 15, 100.0, 100.0, 15, 33, ""},
	{"Dust 2", 15, 100.0, 100.0, 1, 34, "CreateDust2"},
	{"LVPD", 10, 100.0, 100.0, 3, 35, ""},
	{"[Headshots Only] Ghost Town", 15, 100.0, 0.0, 0, 36, ""}
};


new ArenaWeapons[][ARENA_WEAPONS] =
{
	{24, 1500, 0},
	{33, 250, 0},

	{24, 1500, 1},
	{25, 1500, 1},
	{30, 1500, 1},

	{24, 1500, 2},

	{24, 1500, 3},

	{24, 1500, 4},
	{25, 1500, 4},
	{34, 1500, 4},

	{24, 1500, 5},

	{24, 1500, 6},

	{24, 1500, 7},
	{25, 1500, 7},

	{24, 1500, 8},

	{24, 1000, 9},

	{24, 1500, 10},
	{33, 1500, 10},

	{24, 1500, 11},
	{25, 1500, 11},

	{24, 1500, 12},

	{24, 1500, 13}
};

//hooks
#include <pp-hooks>
hook public OnPlayerDisconnect(playerid, reason)
{
	if(ActivityState[playerid] == ACTIVITY_ARENADM) UpdateArena(playerid);
}

forward SendPlayerToArena(playerid);
public SendPlayerToArena(playerid)
{
	new arenaid = ActivityStateID[playerid], spawnidx = GetRandomSpawnForArena(arenaid);
	ResetPlayerWeapons(playerid);
	DestroyAllPlayerObjects(playerid);

	if(ArenaInfo[arenaid][ArenaMapCallback][0]) CallLocalFunction(ArenaInfo[arenaid][ArenaMapCallback], "i", playerid);

	SetPlayerHealth(playerid, ArenaInfo[arenaid][ArenaHP]);
	SetPlayerArmour(playerid, ArenaInfo[arenaid][ArenaArmor]);
	SetPlayerFacingAngle(playerid, ArenaSpawns[spawnidx][SpawnRot]);
	SetPlayerPosEx(playerid, ArenaSpawns[spawnidx][SpawnX], ArenaSpawns[spawnidx][SpawnY], ArenaSpawns[spawnidx][SpawnZ], ArenaInfo[arenaid][ArenaInt], ArenaInfo[arenaid][ArenaWorld]);
	SetPlayerSkinEx(playerid, Account[playerid][Skin]);

	GiveArenaWeapons(playerid, arenaid);
	RemoveRestrictedArenaSkin(playerid);
	return true;
}

ArenaInit()
{
	Iter_Init(ArenaOccupants);
}

//commands
CMD:arenas(cmdid, playerid, params[])
{
	if(!IsPlayerInLobby(playerid)) return SendClientMessage(playerid, -1, "{31AEAA}Arenas: {FFFFFF}You must be in the lobby to use this command.");
	if(!EnableArenas) return SendClientMessage(playerid, -1, "{31AEAA}Arenas: {FFFFFF}Arenas are currently disabled, please wait for them to open.");

	ShowArenaDialog(playerid);
	return 1;
}

//functions
RemoveRestrictedArenaSkin(playerid)
{
	if(Restricted_Skins(GetPlayerSkin(playerid)) || Restricted_Skins(Account[playerid][Skin]))
	{
		SetPlayerSkinEx(playerid, 25);
		SendClientMessage(playerid, -1, "{bf0000}Notice: {FFFFFF}This skin is not allowed, therefore we have changed your skin!");
		ClearAnimations(playerid);
	}
	return true;
}
ShowArenaDialog(playerid)
{
	new string[2000], available[24];

	strcat(string, "Map\tPlayers\tStatus\n");
	for(new i = 1; i < sizeof(ArenaInfo); i++)
	{
		if(Iter_Count(ArenaOccupants[i]) < ArenaInfo[i][ArenaLimit]) available = "{00FF00}Joinable";
		else available = "{FF0000}Full";

		strcat(string, sprintf("{FF0000}%s\t{FFFFFF}%d\t%s\n", ArenaInfo[i][ArenaName], Iter_Count(ArenaOccupants[i]), available));
	}

	yield 1;
	new response[e_DIALOG_RESPONSE_INFO];
	AwaitAsyncDialog(playerid, response, DIALOG_STYLE_TABLIST_HEADERS, "Koky's Deathmatch Arenas", string, "Join", "Cancel");

	if(!response[E_DIALOG_RESPONSE_Response]) return true;
	if(ActivityState[playerid] != ACTIVITY_LOBBY) return true;

	new dmidx = response[E_DIALOG_RESPONSE_Listitem] + 1;
	if(Iter_Count(ArenaOccupants[dmidx]) < ArenaInfo[dmidx][ArenaLimit] || Account[playerid][Donator] != 0)
	{
		InfoBoxForPlayer(playerid, sprintf("~w~Entering %s Arena, please wait....", ArenaInfo[dmidx][ArenaName]));
		ActivityState[playerid] = ACTIVITY_ARENADM;
		ActivityStateID[playerid] = dmidx;
		Iter_Add(ArenaOccupants[dmidx], playerid);
		ResetPlayerWeaponsEx(playerid);
		SendPlayerToArena(playerid);
	}
	return true;
}
GetRandomSpawnForArena(arenaid)
{
	new List:spawnlist = list_new(), counter;

	for(new i = 1; i < sizeof(ArenaSpawns); i++)
	{
		if(ArenaSpawns[i][ArenaID] == arenaid - 1)
		{
			list_add(spawnlist, i);
			++counter;
		}
	}

	new spawnindex = list_get(spawnlist, random(counter));
	list_delete(spawnlist);
	return spawnindex;
}
UpdateArena(playerid)
{
	if(ActivityState[playerid] != ACTIVITY_ARENADM) return true;

	new arenaid = ActivityStateID[playerid];
	if(arenaid != 0 && arenaid <= MAX_ARENAS) Iter_Remove(ArenaOccupants[arenaid], playerid);
	Account[playerid][KillStreak] = 0;
	return true;
}
RespawnPlayerInArena(playerid, arenaid)
{
	new spawnidx = GetRandomSpawnForArena(arenaid);
	SetPlayerFacingAngle(playerid, ArenaSpawns[spawnidx][SpawnRot]);
	SetPlayerPosEx(playerid, ArenaSpawns[spawnidx][SpawnX], ArenaSpawns[spawnidx][SpawnY], ArenaSpawns[spawnidx][SpawnZ], ArenaInfo[arenaid][ArenaInt], ArenaInfo[arenaid][ArenaWorld]);
	GiveArenaWeapons(playerid, arenaid);
	SetPlayerHealth(playerid, ArenaInfo[arenaid][ArenaHP]);
	SetPlayerArmour(playerid, ArenaInfo[arenaid][ArenaArmor]);
	SetCameraBehindPlayer(playerid);
	return true;
}
GiveArenaWeapons(playerid, arenaid)
{
	arenaid--;
	for(new i = 0; i < sizeof(ArenaWeapons); i++)
	{
		if(ArenaWeapons[i][ArenaID] == arenaid)
		{
			GivePlayerWeapon(playerid, ArenaWeapons[i][ArenaWeapon], ArenaWeapons[i][ArenaAmmo]);
		}
	}
	return true;
}