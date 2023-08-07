#include <YSI_Coding\y_hooks>

#define LANGUAGE_ENGLISH 0
#define LANGUAGE_TURKISH 1
#define LANGUAGE_FRENCH 2
#define LANGUAGE_PORTUGUESE 3
#define LANGUAGE_ALL 5

hook OnPlayerText(playerid, text[])
{
	new passport[100];

	if (Account[playerid][Muted] > gettime())
	{
		SendClientMessage(playerid, -1, sprintf("{bf0000}Notice: {FFFFFF}You still have {31AEAA}%d {FFFFFF}seconds(s) of a mute left.", Account[playerid][Muted] - gettime()));
		return 0;
	}

	if(!Account[playerid][Admin] && ChatLocked) {
		SendClientMessage(playerid, -1, "{bf0000}Notice: {FFFFFF}The chat is currently locked by an administrator.");
		return 0;
	}

	switch(Account[playerid][Admin])
	{
		case 1: passport = "({00AF33}A{FFFFFF})";
		case 2: passport = "({00AF33}A{FFFFFF})";
		case 3: passport = "({00AF33}A{FFFFFF})";
		case 4: passport = "({00AF33}A{FFFFFF})";
		case 5: passport = "({1D7CF2}LA{FFFFFF})";
		case 6: passport = "({CD2626}SM{FFFFFF})";
		default: passport = "{1E90FF}~{FFFFFF}";
	}

	if(Account[playerid][LoggedIn] == 1 && Account[playerid][Muted] == 0)
	{
		new _string[145];
		format(_string, sizeof( _string), "%s {%06x}%s(%i):{FFFFFF} %s", passport, GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text);
		SendChat(Account[playerid][Language], _string);
		return false;
	}
	else
	{
		return 0;
	}
}
SendChat(playerlanguage, str[])
{
	new astr[128];
	foreach(new i: Player)
	{
		if(Account[i][Language] == playerlanguage)
		{
			format(astr, sizeof(astr), "(AdmChat) %s", str);
			SendClientMessage(i, 0x808080FF, astr);
		}
	}
}