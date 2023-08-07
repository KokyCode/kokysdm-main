//functions
MonthlyKeyText()
{
	new str[128];
	format(str, sizeof(str), "{bf0000}Monthly Deathmatcher: {FFFFFF}N/A {bf0000}with {FFFFFF}N/A {bf0000}kills!");
	dmerlabel = Create3DTextLabel(str, -1, MONTHDM_NPC_POS, 30.0, 0, 0);
}
UpdateMonthlyKeyText(username[], playerskin, kills)
{
	new str[128];
	format(str, sizeof(str), "{bf0000}Monthly Deathmatcher: {FFFFFF}%s {bf0000}with\n{FFFFFF}%d {bf0000}kills!", username, kills);
	Update3DTextLabelText(dmerlabel, -1, str);
	UpdateNPCSkin(playerskin);
	SendClientMessageToAll(-1, sprintf("{bf0000}Notice: {FFFFFF}The Monthly Deathmatcher has been updated! {31AEAA}%s {FFFFFF}with {31AEAA}%d {FFFFFF}kills this month!", username, kills));
}
UpdateNPCSkin(skinid)
{
	DestroyActor(monthlydm_actor);
	monthlydm_actor = CreateActor(skinid, MONTHDM_NPC_POS, 90.0);
 	ApplyActorAnimation(monthlydm_actor, "GHANDS", "gsign3", 4.1, 1, 1, 1, 0, 0);
	SetActorPos(monthlydm_actor, MONTHDM_NPC_POS);
	SetActorVirtualWorld(monthlydm_actor, 0);
	SetActorInvulnerable(monthlydm_actor, false);
	SetActorHealth(monthlydm_actor, 1000);
	ApplyActorAnimation(monthlydm_actor, "GHANDS", "gsign3", 4.1, 1, 1, 1, 0, 0);
}
CheckMonthlyDeathmatcher()
{
	new playerskin, username[32], kills;
	await mysql_aquery(SQL_CONNECTION, "SELECT `Username`, MonthKills, Skin FROM `Accounts` WHERE Banned = 0 ORDER BY MonthKills DESC LIMIT 1");
	cache_get_value_name(0, "Username", username);
	cache_get_value_name_int(0, "Skin", playerskin);
	cache_get_value_name_int(0, "MonthKills", kills);
	UpdateMonthlyKeyText(username, playerskin, kills);
}
CheckDateForNPC()
{
	new winner[32], kills;
	await mysql_aquery(SQL_CONNECTION, "SELECT `Username`, MonthKills FROM `Accounts` WHERE Banned = 0 ORDER BY MonthKills DESC LIMIT 1");
	cache_get_value_name(0, "Username", winner);
	cache_get_value_name_int(0, "MonthKills", kills);
	SendClientMessageToAll(-1, sprintf("{31AEAA}Monthly Deathmatcher: {FFFFFF}The winner is {d0b6e3}%s {FFFFFF}with {d0b6e3}%d {FFFFFF}kills! He won {00ddd7}Diamond VIP{FFFFFF}!", winner, kills));
	ResetMonthlyDeathmatcher();
}
ResetMonthlyDeathmatcher()
{
	await mysql_aquery(SQL_CONNECTION, "UPDATE `Accounts` SET LastMonthKills = MonthKills, MonthKills = 0 WHERE MonthKills > 0");
	await mysql_aquery(SQL_CONNECTION, "UPDATE `Accounts` SET `MonthKills` = 1 WHERE `Username` = 'Koky'");

	CheckMonthlyDeathmatcher();

	foreach(new i: Player)
	{
		if(Account[i][LoggedIn] == 1)
		{ 
			UpdateMonthlyKills(i);
		}
	}
}
UpdateMonthlyKills(playerid)
{
	await mysql_aquery_s(SQL_CONNECTION, str_format("SELECT MonthKills, LastMonthKills FROM `Accounts` WHERE Username = '%e'", GetName(playerid)));
	cache_get_value_name_int(0, "MonthKills", Account[playerid][MonthKills]);
	cache_get_value_name_int(0, "LastMonthKills", Account[playerid][LastMonthKills]);
	SendClientMessage(playerid, -1, sprintf("{bf0000}Notice: {FFFFFF}It's the start of a new month, therefore the monthly deathmatcher has been reset! You got %d kills in the last month!", Account[playerid][LastMonthKills]));
}
