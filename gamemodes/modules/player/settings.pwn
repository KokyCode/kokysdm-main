new bool:AllowPMS[MAX_PLAYERS char] = {true, ...};

CMD:settings(cmdid, playerid, params[])
{
	ShowPlayerSettingsDialog(playerid);
	return 1;
}

ShowPlayerSettingsDialog(playerid)
{
	new str[1200];
    strcat(str, sprintf("{F19F05}Hitmarker: %s\n", ReturnOptionStatus(Account[playerid][Hitmark])));
	strcat(str, sprintf("{F19F05}Private Messages: %s\n", ReturnOptionStatus(AllowPMS{playerid})));

	yield 1;
	new response[e_DIALOG_RESPONSE_INFO];
	for(;;)
	{
		AwaitAsyncDialog(playerid, response, DIALOG_STYLE_LIST, "My Settings", str, "Select", "Cancel");

		if(!response[E_DIALOG_RESPONSE_Response]) break;

		switch(response[E_DIALOG_RESPONSE_Listitem])
		{
			case 0: //hitmarker
			{
				Account[playerid][Hitmark] = !Account[playerid][Hitmark];
				SendClientMessage(playerid, COLOR_GRAY, sprintf("{31AEAA}Settings: {FFFFFF}Your hitmarker is now %s.", Account[playerid][Hitmark] ? "enabled" : "disabled"));
				continue;
			}
			case 1: //pms
			{
				AllowPMS{playerid} = !AllowPMS{playerid};
				SendClientMessage(playerid, COLOR_GRAY, sprintf("{31AEAA}Settings: {FFFFFF}You have %s your private messages.", AllowPMS{playerid} ? "enabled" : "disabled"));
				continue;
			}
		}
	}
}
ReturnOptionStatus(option)
{
	new status[18];
	format(status, sizeof(status), option ? "{73d600}Enabled" : "{D60000}Disabled");
	return status;
}