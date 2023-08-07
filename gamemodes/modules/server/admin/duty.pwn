// admin duty
#include <pp-hooks>
new previousColours[MAX_PLAYERS] = {0xFFFFFFFF, ...};

hook public OnPlayerConnect(playerid)
{
	adminDuty[playerid] = false;
	previousColours[playerid] = 0xFFFFFFFF;
}

CMD<AD1>:aduty(cmdid, playerid, params[])
{
	adminDuty[playerid] = !adminDuty[playerid];
	if(Account[playerid][pAdminHide]) ToggleAdminHidden(playerid);

	new szString[144];
	format(szString, 144, "{FF0000}%s{FFFFFF} is %s on duty.", GetName(playerid), adminDuty[playerid] ? "now" : "no longer");
	SendClientMessageToAll(COLOR_RED, szString);

	if(adminDuty[playerid]) {
		TextDrawShowForPlayer(playerid, DutyTextDraw);
		if(ActivityState[playerid] == ACTIVITY_TDM)
		{
			previousColours[playerid] = GetPlayerColor(playerid);
		}
		SetPlayerColor(playerid, 0xFF000000);
	}
	else {
		TextDrawHideForPlayer(playerid, DutyTextDraw);
		if(ActivityState[playerid] == ACTIVITY_TDM )
		{	
			if(previousColours[playerid] != 0xFFFFFFFF)
			{
				if(GetPlayerTeam(playerid) < 100)
				{
					SetPlayerColor(playerid, previousColours[playerid]);
				}
				if(GetPlayerTeam(playerid) > 100)
				{
					if ((Account[playerid][ClanID] + 5) < 200) {
						SetPlayerColor(playerid, PlayerColors[Account[playerid][ClanID] + 5]);
					} else {
						SetPlayerColor(playerid, clamp(Account[playerid][ClanID] + 5, 0, 200));
					}
				}
			}
		}
		else {
			SetPlayerColor(playerid, Account[playerid][Color]);
		}
	}
	return 1;
}