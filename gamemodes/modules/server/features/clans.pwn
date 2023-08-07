new pendinginvite[MAX_PLAYERS];
new invitedby[MAX_PLAYERS];

CMD<CLN>:createclan(cmdid, playerid, params[]) // ADD -125K PRICE!!
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GRAY, "USAGE: /createclan [clanname] (price: $1,500,000)");
	if(Account[playerid][ClanID] > 0) return SendClientMessage(playerid, -1, "{31AEAA}Clan: {FFFFFF}You are already in a clan. Please refer to /leaveclan");
	if(Account[playerid][Cash] < 1500000) return SendClientMessage(playerid, -1, "{31AEAA}Clan: You need at least $1,500,000 to purchase a clan!");
	GivePlayerMoneyEx(playerid, -1500000);
	if(ClanAlreadyExists(params)) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}This name already exists in the database.");
	if(strlen(params) > 64) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}That name is too long. Please shorten it.");

	yield 1;
	await mysql_aquery_s(SQL_CONNECTION, str_format("INSERT INTO clans (name, owner_name, owner_sqlid, official, color) VALUES ('%e', '%e', %i, 0, 0x0000FFFF)", params, GetName(playerid), Account[playerid][SQLID]));

	Account[playerid][ClanID] = cache_insert_id();
	Account[playerid][OfficialClan] = 0;
	Account[playerid][ClanRank] = 4;
	format(Account[playerid][ClanName], 64, params);

	SendClientMessage(playerid, -1, sprintf("{31AEAA}Clan: {FFFFFF}You have created an unofficial clan. {31AEAA}(%s - clan id: %d)", Account[playerid][ClanName], Account[playerid][ClanID]));
	return true;
}
CMD<CLN>:claninvite(cmdid, playerid, params[]) 
{
	new pid;
	if(sscanf(params, "u", pid)) return SendClientMessage(playerid, COLOR_GRAY, "USAGE: /claninvite [playerid/playername]");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Error: {FFFFFF}This player is not connected!");
	if(Account[pid][ClanID] > 0) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}This player is already in a clan!");
	if(pendinginvite[pid] > -1) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}This player already has an invite to a clan!");
	if(Account[playerid][ClanRank] < 3) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}You must be at least rank 3 in order to invite players to the clan!");
	pendinginvite[pid] = Account[playerid][ClanID];
	invitedby[pid] = playerid;
	SendClientMessage(pid, -1, sprintf("{31AEAA}Clan Invite: {%06x}%s {FFFFFF}has invited you join the clan %s.", GetPlayerColor(playerid) >>> 8, GetName(playerid), Account[playerid][ClanName]));
	SendClientMessage(pid, -1, "Type /acceptinvite or /denyinvite to continue. Invitation will expire in 1 minute.");

	SendClientMessage(playerid, -1, sprintf("{31AEAA}Clan Invite: {FFFFFF}You have invited {%06x}%s{FFFFFF} to join your clan!", GetPlayerColor(pid) >>> 8, GetName(pid)));
	SetTimerEx("ExpireInvite", 60000, false, "i", pid);
	return true;
}
forward ExpireInvite(playerid);
public ExpireInvite(playerid) {
	if(pendinginvite[playerid] != -1) {
		pendinginvite[playerid] = -1;
		invitedby[playerid] = -1;
		SendClientMessage(playerid, -1, "{31AEAA}Clan Invite: {FFFFFF}Your clan invitation has expired!");
	}
}
CMD<CLN>:clankick(cmdid, playerid, params[]) 
{
	new pid;
	if(sscanf(params, "u", pid)) return SendClientMessage(playerid, COLOR_GRAY, "USAGE: /clankick [playerid/playername]");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Error: {FFFFFF}This player is not connected!");
	if(Account[pid][ClanID] != Account[playerid][ClanID]) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}This player is already in a clan!");
	if(Account[playerid][ClanRank] < 3) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}You must be at least rank 3 in order to kick players from the clan!");
	if(Account[pid][ClanRank] > Account[playerid][ClanRank]) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}You cannot kick higher ranks from your clan!");
	if(pid == playerid) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Error: {FFFFFF}You can't kick yourself, idiot!");
	SendClanMessage(Account[playerid][ClanID], Account[playerid][ClanName], sprintf("{31AEAA}Clan Notice: {%06x}%s {FFFFFF}has been kicked from the clan by {%06x}%s!", GetPlayerColor(pid) >>> 8, GetName(pid), GetPlayerColor(playerid) >>> 8, GetName(playerid)));

	Account[pid][ClanID] = -1;
	Account[pid][ClanRank] = 0;
	Account[pid][ClanName][0] = EOS;

	return true;
}
CMD<CLN>:deleteclan(cmdid, playerid, params[]) 
{
	if(Account[playerid][ClanRank] == 4)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "Are you sure you wish to delete your clan? You can transfer ownership to another member via /transferownership [playerid]. /deleteclanconfirm to continue...");
	}
	return true;
}
CMD<CLN>:deleteclanconfirm(cmdid, playerid, params[]) 
{
	if(Account[playerid][ClanRank] != 4) return true;

	SendClanMessage(Account[playerid][ClanRank], Account[playerid][ClanName], sprintf("{%06x}%s {ffffff}has closed the Clan. %s has now been ended.", GetPlayerColor(playerid) >>> 8, GetName(playerid), Account[playerid][ClanName]));
	mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE Accounts SET ClanRank = 0, ClanID = -1 WHERE ClanID = %i", Account[playerid][ClanID]));
	mysql_pquery_s(SQL_CONNECTION, str_format("DELETE FROM `clans` WHERE id = %i", Account[playerid][ClanID]));

	foreach(new i: Player)
	{
		if(Account[i][ClanID] == Account[playerid][ClanID])
		{
			Account[i][ClanID] = -1;
			Account[i][ClanRank] = 0;
			Account[i][ClanName][0] = EOS;
			SendClientMessage(i, COLOR_LIGHTRED, "You are no longer in a clan.");
		}
	}
	return true;
}
CMD<CLN>:transferownership(cmdid, playerid, params[])
{
	if (Account[playerid][ClanRank] != 4)
		return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Error: {FFFFFF}You can not use this command!");
	new pid;
	if(sscanf(params, "u", pid)) return SendClientMessage(playerid, COLOR_GRAY, "USAGE: /transferownership [playerid/playername]");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Error: {FFFFFF}This player is not connected!");
	if(Account[pid][ClanID] != Account[playerid][ClanID]) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}This player is not in your clan!");
	Account[pid][ClanRank] = 4;
	Account[playerid][ClanRank] = 3;
	
	mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE clans SET owner_sqlid = %i, owner_name = '%e' WHERE id = %i", Account[pid][SQLID], GetName(pid), Account[playerid][ClanID]));
	mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE clans SET owner_sqlid = 0 WHERE id = %i", Account[playerid][SQLID]));

	SendClanMessage(Account[playerid][ClanID], Account[playerid][ClanName], sprintf("{%06x}%s {ffffff}has been transfered ownership. {%06x}%s no longer owns the clan.", GetPlayerColor(pid) >>> 8, GetName(pid), GetPlayerColor(playerid) >>> 8, GetName(playerid)));
	return true;
}
CMD<CLN>:denyinvite(cmdid, playerid, params[]) 
{
	if(pendinginvite[playerid] == -1) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}You have not been invited to a clan!");

	pendinginvite[playerid] = -1;
	SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan Invite: {FFFFFF}You have denied the invite for the clan.");

	new pid = invitedby[playerid];
	SendClientMessage(pid, -1, sprintf("{31AEAA}Clan Invite: {%06x}%s {FFFFFF}has denied your clan invite.", GetPlayerColor(playerid) >>> 8, GetName(playerid)));

	return true;
}
CMD<CLN>:leaveclan(cmdid, playerid, params[])
{
	if(Account[playerid][ClanRank] == 4) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}You cannot leave a clan you own!");
	if(Account[playerid][ClanID] == -1) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}You must be in a clan to use this command!");

	SendClanMessage(Account[playerid][ClanID], Account[playerid][ClanName], sprintf("{%06x}%s {ffffff}has left the clan.", GetPlayerColor(playerid) >>> 8, GetName(playerid)));

	Account[playerid][ClanID] = -1;
	Account[playerid][ClanRank] = 0;
	Account[playerid][ClanName][0] = EOS;

	return true;
}
CMD<CLNTDM>:clanskin(cmdid, playerid, params[])
{
	new slot;
	if(sscanf(params, "i", slot)) return SendClientMessage(playerid, COLOR_GRAY, "USAGE: /clanskin [slot 1-3]");
	if(Account[playerid][ClanID] == -1 || Account[playerid][ClanID] == 0) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}You must be in a clan to use this command!");
	if(!Clans[Account[playerid][ClanID]][clanofficial]) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}Your clan must be official to use this command!");
	if(GetPlayerTeam(playerid) < 100) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}You must be in a clan to use this command!");
	if(slot < 1 || slot > 3) return SendClientMessage(playerid, COLOR_GRAY, "ERROR: Slot ID must be between 1-3");

	new skinid;
	if(slot == 1) {
		skinid = Clans[Account[playerid][ClanID]][skin1];
	} else if(slot == 2) {
		skinid = Clans[Account[playerid][ClanID]][skin2];
	} else {
		skinid = Clans[Account[playerid][ClanID]][skin3];
	}
	SetPlayerSkin(playerid, skinid);
	clanskins[playerid] = slot;
	
	return true;
}
CMD<CLN>:acceptinvite(cmdid, playerid, params[])
{
	new pid = invitedby[playerid];

	if(pendinginvite[playerid] == -1) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}You have not been invited to a clan!");
	if(Account[playerid][ClanID] > -1) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}You are already in a clan!");

	Account[playerid][ClanID] = pendinginvite[playerid];
	Account[playerid][ClanRank] = 0;

	strcat(Account[playerid][ClanName], Account[pid][ClanName]);
	pendinginvite[playerid] = -1;

	SendClientMessage(pid, -1, sprintf("{31AEAA}Clan Invite: {%06x}%s {FFFFFF}has accepted your clan invite.", GetPlayerColor(playerid) >>> 8, GetName(playerid)));
	SendClanMessage(Account[playerid][ClanID], Account[playerid][ClanName], sprintf("%s has joined the clan! They were invited by %s.", GetName(playerid), GetName(pid)));

	return true;
}
CMD<CLN>:c(cmdid, playerid, params[])
{
	if(Account[playerid][ClanID] == -1 || Account[playerid][ClanID] == 0) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}You aren't in a clan to use the clan chat system.");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GRAY, "USAGE: /c [text]");
	SendClanMessage(Account[playerid][ClanID], Account[playerid][ClanName], sprintf("%s: %s", GetName(playerid), params));
	return 1;
}
CMD<CLN>:clan(cmdid, playerid, params[])
{
	if(Account[playerid][ClanID] == -1 || Account[playerid][ClanID] == 0) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Clan: {FFFFFF}You aren't in a clan to use the clan chat system.");
	
	SendClientMessage(playerid, 0xBF0000FF, "_____________[Clan Members Online]_____________");
	foreach(new i: Player){
		if(Account[playerid][ClanID] == Account[i][ClanID]) SendClientMessage(playerid, -1, sprintf("%s(%i) - Rank: %i", GetName(i), i + 1, Account[i][ClanRank]));
	}
	SendClientMessage(playerid, 0xBF0000FF, "______________________________________________");
	return 1;
}
SendClanMessage(clanid, clanname[], msg[])
{
	foreach(new i: Player)
	{
		if(Account[i][ClanID] == clanid)
		{
			SendClientMessage(i, COLOR_LIGHTBLUE, sprintf("[%s]: %s", clanname, msg));
		}
	}
	return true;
}
ClanAlreadyExists(const clan[])
{
	await mysql_aquery_s(SQL_CONNECTION, str_format("SELECT * FROM clans WHERE name = '%e' LIMIT 1", clan));
	return (cache_num_rows());
}
GetClanIDFromName(const clan[])
{
	await mysql_aquery_s(SQL_CONNECTION, str_format("SELECT id FROM clans WHERE name = '%e' LIMIT 1", clan));
	if(!cache_num_rows()) return 0;

	new clanid;
	cache_get_value_name_int(0, "id", clanid);
	return clanid;
}