//data
static SkinRoll;
static gSkinRollActors[10] = {INVALID_ACTOR_ID, ...};
static gSkinRollActorSkins[10] = {0, ...};
static Float:gSkinRollPositions[10][4] =
{
	{2749.0964, -1763.3590, 1026.8953, 36.5392},
	{2747.8242, -1764.8690, 1026.8953, 28.5049},
	{2746.5039, -1765.9757, 1026.8953, 34.8279},
	{2744.9167, -1766.6210, 1026.8953, 14.2039},
	{2742.9143, -1766.7238, 1026.8953, 9.2468},
	{2740.8320, -1766.6028, 1026.8953, 5.2296},
	{2738.8503, -1766.4451, 1026.8953, 349.9323},
	{2736.9839, -1765.7651, 1026.8953, 338.0818},
	{2735.6433, -1764.6808, 1026.8953, 322.7846},
	{2734.3740, -1763.7097, 1026.8953, 330.4619}
};

//hooks
SkinRollInit()
{
	SpawnSkinRollActors();
	SkinRoll = 0;

	Create3DTextLabel("{EE5133}Current price:{33C4EE} $10000\n{EE5133}Skin Roll:{33C4EE}\n/skinroll", -1, 4808.8965, 1267.8223, 2.8049, 100.0, 0);
	return true;
}


//commands
CMD:skinroll(cmdid, playerid)
{
	if(SkinRoll == 1) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Skin Roll:{FFFFFF} Skin Roll is currently in use, please wait for the user to finish.");
	if(!IsPlayerInLobby(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Skin Roll:{FFFFFF} You must not be in an arena to use this feature.");
	if(Account[playerid][Cash] < 10000) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Skin Roll:{FFFFFF} You don't have enough money to use this feature. ($10000)");

	yield 1;
	SkinRoll = 1;
	GivePlayerMoneyEx(playerid, -10000);

	GameTextForPlayer(playerid, "~g~Rolling....", 1000, 4);
	wait_ms(1000);

	GameTextForPlayer(playerid, "~g~Selecting A SKIN....", 1000, 4);
	wait_ms(1000);

	GameTextForPlayer(playerid, "~g~RANDOMISING....", 1000, 4);
	DespawnSkinRollActors();
	SpawnSkinRollActors();
	wait_ms(1000);

	new skinidx = GetRandomSkinRollSkin(), bool:unlocked;
	GameTextForPlayer(playerid, "~g~FOUND A SKIN....", 1000, 4);

	if(Account[playerid][Donator] > 0 && PlayerCustomSkins[playerid][skinidx][cSkinUnlocked])
	{
		SendClientMessage(playerid, COLOR_GRAY, sprintf("{31AEAA}Skin Roll:{FFFFFF} You already own the {00d2f0}%s{FFFFFF} skin and as you are a donator you have been refunded!", ServerSkinData[skinidx][sSkinName]));
		GivePlayerMoneyEx(playerid, 10000);
		unlocked = true;
	}

	if(!unlocked) UnlockSkinForPlayer(playerid, skinidx);

	PlayerCustomSkins[playerid][skinidx][cSkinUnlocked] = true;
	SendClientMessageToAll(-1, sprintf("{31AEAA}Skin Roll:{FFFFFF} %s has just won the {00d2f0}%s{FFFFFF} Skin!", GetName(playerid), ServerSkinData[skinidx][sSkinName]));
	SendClientMessage(playerid, COLOR_GRAY, sprintf("{31AEAA}Skin Roll:{FFFFFF} Congratulations, you won the {00d2f0}%s{FFFFFF} skin and can now set your skin in /customskins.", ServerSkinData[skinidx][sSkinName]));

	wait_ms(7500);
	DespawnSkinRollActors();
	SpawnSkinRollActors();
	SkinRoll = 0;
	return 1;
}

CMD:customskins(cmdid, playerid, params[])
{
	if(!IsPlayerInLobby(playerid)) return true;

	yield 1;
	new response[e_DIALOG_RESPONSE_INFO];
	for(;;)
	{
		AwaitAsyncDialog(playerid, response, DIALOG_STYLE_LIST, "Custom Skins", SKINROLL_MONTHS, "Select", "Cancel");

		if(!response[E_DIALOG_RESPONSE_Response]) break;

		list_clear(DialogOptions[playerid]);

		new string[1024], unlocked[24], count;
		strcat(string, "Skin\tStatus\n");
		for(new i = 0; i < sizeof(ServerSkinData); i++)
		{
			if(!strcmp(response[E_DIALOG_RESPONSE_InputText], ServerSkinData[i][sSkinMonth], false))
			{
				if(PlayerCustomSkins[playerid][i][cSkinUnlocked]) unlocked = "{00FF00}Unlocked";
				else unlocked = "{FF0000}Locked";

				list_add(DialogOptions[playerid], i);
				strcat(string, sprintf("%s\t%s\n", ServerSkinData[i][sSkinName], unlocked));
				count ++;
			}
		}
		SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Custom Skins:{FFFFFF} You can use /mycustomskins to view a model menu of all of the skins you've unlocked.");
		AwaitAsyncDialog(playerid, response, DIALOG_STYLE_TABLIST_HEADERS, response[E_DIALOG_RESPONSE_InputText], string, "Confirm", "Cancel");

		if(!response[E_DIALOG_RESPONSE_Response]) continue;

		new idx = list_get(DialogOptions[playerid], response[E_DIALOG_RESPONSE_Listitem]);
		if(!PlayerCustomSkins[playerid][idx][cSkinUnlocked]) break;

		SetPlayerSkinEx(playerid, ServerSkinData[idx][sSkinModel]);
		break;
	}
	return true;
}
CMD:mycustomskins(cmdid, playerid, params[])
{
	if(!IsPlayerInLobby(playerid)) return true;

	new skins[MAX_CUSTOM_SKINS], skinsfound;
	for(new i = 0; i < sizeof(ServerSkinData); i++)
	{
		if(PlayerCustomSkins[playerid][i][cSkinUnlocked])
		{
			skins[skinsfound] = ServerSkinData[i][sSkinModel];
			++skinsfound;
		}
	}
	if(!skinsfound) SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Custom Skins:{FFFFFF} You do not have any custom skins unlocked.");
	//else ShowModelSelectionMenuEx(playerid, skins, skinsfound, "Select a Skin", MODEL_SELECTION_SKINLIST);
	return true;
}

//functions
LoadUnlockedSkins(playerid)
{
	await mysql_aquery_s(SQL_CONNECTION, str_format("SELECT skinid, unlocked FROM playerskins WHERE sqlid = %i", Account[playerid][SQLID]));
	if(!cache_num_rows()) return true;

	//loop through the received rows to grab all of a player's unlocked skins
	new bool:unlocked = false, skinid;
	for(new i = 0, r = cache_num_rows(); i < r; i++)
	{
		cache_get_value_name_int(i, "skinid", skinid);
		cache_get_value_name_bool(i, "unlocked", unlocked);

		//assign the appropriate data if the skin id is unlocked
		if(unlocked)
		{
			PlayerCustomSkins[playerid][skinid][cSkinID] = skinid;
			PlayerCustomSkins[playerid][skinid][cSkinName] = ServerSkinData[skinid][sSkinName];
			PlayerCustomSkins[playerid][skinid][cSkinUnlocked] = true;
		}
	}
	return true;
}

static SpawnSkinRollActors()
{
	new skinid;
	for(new i = 0; i < sizeof(gSkinRollActors); i++)
	{
		skinid = GetRandomUnusedSkinRollActor();
		gSkinRollActors[i] = CreateActor(skinid, gSkinRollPositions[i][0], gSkinRollPositions[i][1], gSkinRollPositions[i][2], gSkinRollPositions[i][3]);
		gSkinRollActorSkins[i] = skinid;
	}
	return 1;
}
static DespawnSkinRollActors()
{
	for(new i = 0; i < sizeof(gSkinRollActors); i++)
	{
		DestroyActor(gSkinRollActors[i]);
	}
}
static GetRandomSkinRollSkin()
{
	return random(sizeof(ServerSkinData));
}
static GetRandomUnusedSkinRollActor()
{
	new List:skinlist = list_new();
	for(new i = 0; i < sizeof(ServerSkinData); i++)
	{
		if(IsActorSkinUsed(ServerSkinData[i][sSkinModel])) continue;

		list_add(skinlist, ServerSkinData[i][sSkinModel]);
	}
	if(!list_size(skinlist))
	{
		list_delete(skinlist);
		return 0;
	}

	new skinidx = list_get(skinlist, math_random(0, list_size(skinlist) - 1));
	list_delete(skinlist);
	return skinidx;
}
static IsActorSkinUsed(skinid)
{
	for(new i = 0; i < sizeof(gSkinRollActorSkins); i++)
	{
		if(gSkinRollActorSkins[i] == skinid) return true;
	}
	return false;
}
UnlockSkinForPlayer(playerid, skinid)
{
	PlayerCustomSkins[playerid][skinid][cSkinUnlocked] = true;
	mysql_pquery_s(SQL_CONNECTION, str_format("INSERT INTO playerskins (sqlid, skinid, unlocked) VALUES (%i, %i, 1)", Account[playerid][SQLID], skinid));
	return true;
}