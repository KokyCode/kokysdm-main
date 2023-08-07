#define     DIALOG_TOP10        1594

TopKills(playerid)
{
	await mysql_aquery(SQL_CONNECTION, "SELECT Username, Kills FROM Accounts WHERE Banned = 0 ORDER BY Kills DESC LIMIT 10");
	if(!cache_num_rows()) return true;

	new output[675], dest[24], score;
	for(new i = 0, r = cache_num_rows(); i < r; i++)
	{
		cache_get_value_name(i, "Username", dest);
		cache_get_value_name_int(i, "Kills", score);
		strcat(output, sprintf("{4286f4}%d.{dadada} %s with {4286f4}%d{dadada} Kills\n", i, dest, score));
	}
	ShowPlayerDialog(playerid, DIALOG_TOP10, DIALOG_STYLE_MSGBOX, "Top 10 Kills", output, "Okay", "");
	return 1;
}

TopEventWinners(playerid)
{
	await mysql_aquery(SQL_CONNECTION, "SELECT Username, EventsWon FROM Accounts WHERE Banned = 0 ORDER BY EventsWon DESC LIMIT 10");
	if(!cache_num_rows()) return true;

	new output[675], dest[24], eventswon;
	for(new i = 0, r = cache_num_rows(); i < r; i++)
	{
		cache_get_value_name(i, "Username", dest);
		cache_get_value_name_int(i, "EventsWon", eventswon);
		strcat(output, sprintf("{4286f4}%d.{dadada} %s with {4286f4}%d Events won{dadada}\n", i, dest, eventswon));
	}
	ShowPlayerDialog(playerid, DIALOG_TOP10, DIALOG_STYLE_MSGBOX, "Top 10 Event Winners", output, "Okay", "");
	return 1;
}

TopEventStarters(playerid)
{
	await mysql_aquery(SQL_CONNECTION, "SELECT Username, EventsStarted FROM Accounts WHERE Banned = 0 ORDER BY EventsStarted DESC LIMIT 10");
	if(!cache_num_rows()) return true;

	new output[675], dest[24], eventsstarted;
	for(new i = 0, r = cache_num_rows(); i < r; i++)
	{
		cache_get_value_name(i, "Username", dest);
		cache_get_value_name_int(i, "EventsStarted", eventsstarted);
		strcat(output, sprintf("{4286f4}%d.{dadada} %s with {4286f4}%d Events started{dadada}\n", i, dest, eventsstarted));
	}
	ShowPlayerDialog(playerid, DIALOG_TOP10, DIALOG_STYLE_MSGBOX, "Top 10 Event Starters", output, "Okay", "");
	return 1;
}

TopHeadshots(playerid)
{
	await mysql_aquery(SQL_CONNECTION, "SELECT Username, Headshots FROM Accounts WHERE Banned = 0 ORDER BY Headshots DESC LIMIT 10");
	if(!cache_num_rows()) return true;

	new output[675], dest[24], headshots;
	for(new i = 0, r = cache_num_rows(); i < r; i++)
	{
		cache_get_value_name(i, "Username", dest);
		cache_get_value_name_int(i, "Headshots", headshots);
		strcat(output, sprintf("{4286f4}%d.{dadada} %s with {4286f4}%d Headshots{dadada}\n", i, dest, headshots));
	}
	ShowPlayerDialog(playerid, DIALOG_TOP10, DIALOG_STYLE_MSGBOX, "Top 10 Headshots", output, "Okay", "");
	return 1;
}

TopCash(playerid)
{
	await mysql_aquery(SQL_CONNECTION, "SELECT Username, Cash FROM Accounts WHERE Banned = 0 ORDER BY Cash DESC LIMIT 10");
	if(!cache_num_rows()) return true;

	new output[675], dest[24], cash;
	for(new i = 0, r = cache_num_rows(); i < r; i++)
	{
		cache_get_value_name(i, "Username", dest);
		cache_get_value_name_int(i, "Cash", cash);
		strcat(output, sprintf("{4286f4}%d.{dadada} %s with {4286f4}$%s{dadada}\n", i, dest, Comma(cash)));
	}
	ShowPlayerDialog(playerid, DIALOG_TOP10, DIALOG_STYLE_MSGBOX, "Top 10 Richest", output, "Okay", "");
	return 1;
}

TopDeaths(playerid)
{
	await mysql_aquery(SQL_CONNECTION, "SELECT Username, Deaths FROM Accounts WHERE Banned = 0 ORDER BY Deaths DESC LIMIT 10");
	if(!cache_num_rows()) return true;

	new output[675], dest[24], score;
	for(new i = 0, r = cache_num_rows(); i < r; i++)
	{
		cache_get_value_name(i, "Username", dest);
		cache_get_value_name_int(i, "Deaths", score);
		strcat(output, sprintf("{4286f4}%d.{dadada} %s with {4286f4}%d{dadada} Deaths\n", i, dest, score));
	}
	ShowPlayerDialog(playerid, DIALOG_TOP10, DIALOG_STYLE_MSGBOX, "Top 10 Deaths", output, "Okay", "");
	return 1;
}
HighestSprees(playerid)
{
	await mysql_aquery(SQL_CONNECTION, "SELECT Username, HighestSpree FROM Accounts WHERE Banned = 0 ORDER BY HighestSpree DESC LIMIT 10");
	if(!cache_num_rows()) return true;

	new output[675], dest[24], score;
	for(new i = 0, r = cache_num_rows(); i < r; i++)
	{
		cache_get_value_name(i, "Username", dest);
		cache_get_value_name_int(i, "HighestSpree", score);
		strcat(output, sprintf("{4286f4}%d.{dadada} %s with {4286f4}%d{dadada} kills\n", i, dest, score));
	}
	ShowPlayerDialog(playerid, DIALOG_TOP10, DIALOG_STYLE_MSGBOX, "Top 10 Sprees", output, "Okay", "");
	return 1;
}

CMD:top(cmdid, playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GRAY, "[Server]: /top [kills/headshots/deaths/cash/eventswon/eventstarters/spree]");

	if(!strcmp(params, "kills", false)) TopKills(playerid);
	else if(!strcmp(params, "headshots", false)) TopHeadshots(playerid);
	else if(!strcmp(params, "deaths", false)) TopDeaths(playerid);
	else if(!strcmp(params, "cash", false)) TopCash(playerid);
	else if(!strcmp(params, "eventswon", false)) TopEventWinners(playerid);
	else if(!strcmp(params, "eventstarters", false)) TopEventStarters(playerid);
	else if(!strcmp(params, "spree", false)) HighestSprees(playerid);
	else SendClientMessage(playerid, COLOR_GRAY, "[Server]: /top [kills/headshots/deaths/cash/eventswon/eventstarters/spree]");
	return 1;
}