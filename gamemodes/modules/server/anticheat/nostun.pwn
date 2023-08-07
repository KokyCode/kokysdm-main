//data
new LastAnimation[MAX_PLAYERS];
new FlinchCount[MAX_PLAYERS];

//command for admins
CMD<AD1>:flinchcheck(cmdid, playerid, params[])
{
	extract params -> new player:target; else return ShowSyntax(playerid, "Usage: /flinchcheck [playerid or name]");
	if(!IsPlayerConnected(target)) return SendErrorMessage(playerid, ERROR_OPTION);
	if(TimesHit[target] == 0) return SendErrorMessage(playerid, "{FFFFFF}This player has not been shot yet.");

	SendClientMessage(playerid, COLOR_GREY, sprintf("%s (%i) flinch stats - Times Hit: %i Times Flinched(Stunned): %i (%.2f%%)", GetName(target), target, TimesHit[target], FlinchCount[target], (FlinchCount[target] / TimesHit[target] * 100)));
	return true;
}

//hook
#include <pp-hooks>
hook public OnPlayerUpdate(playerid)
{
	new index = GetPlayerAnimationIndex(playerid);
	if(LastAnimation[playerid] != index && (index > 1070 && index < 1087))
	{
		FlinchCount[playerid] ++;
	}
	LastAnimation[playerid] = index;
}