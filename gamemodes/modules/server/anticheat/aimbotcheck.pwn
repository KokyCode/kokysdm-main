new LastHit[MAX_PLAYERS]; //set in onplayertakedamage

forward SetOldPos(playerid, Float:x, Float:y, Float:z);
CMD<AD1>:aimbotcheck(cmdid, playerid, params[])
{
	new pID;
	if(sscanf(params,"u", pID)) return SendClientMessage(playerid, COLOR_GRAY, "USAGE: /aimbotcheck [playername/playerid]");
	if(LastHit[pID] == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "{bf0000}Notice: {FFFFFF}This player has not damaged a player yet!");
	if(!IsPlayerConnected(pID)) return SendClientMessage(playerid, -1, "{bf0000}Notice: {FFFFFF}This player is not connected!");

	AimbotCheck(playerid, pID);
	return CMD_SUCCESS;
}
ALT:ac = CMD:aimbotcheck;

AimbotCheck(playerid, target)
{
	new Float:hX, Float:hY, Float:hZ, Float:tX, Float:tY, Float:tZ;
	new helper = LastHit[target];

	GetPlayerPos(helper, hX, hY, hZ);
	GetPlayerPos(target, tX, tY, tZ);

	SetPlayerPos(helper, tX, tY + 3, tZ + 2);
	SendClientMessage(helper, -1, sprintf("{bf0000}Notice: {FFFFFF}You have been used to help an admin check a player for aimbot. Thank you!"));
	SetTimerEx("SetOldPos", 200, false, "ifff", helper, hX, hY, hZ);
	SendAdmcmdMessage(2, sprintf("%s has checked %s for aimbot using %s.", GetName(playerid), GetName(target), GetName(helper)));
	SendClientMessage(playerid, -1, sprintf("{31AEAA}Aimbot Check: {FFFFFF}You have checked {%06x}%s{FFFFFF} for aimbot! Helper: {%06x}%s{FFFFFF}.", GetPlayerColor(target) >>> 8, GetName(target), GetPlayerColor(helper) >>> 8, GetName(helper)));
	return true;
}
public SetOldPos(playerid, Float:x, Float:y, Float:z)
{
	SetPlayerPos(playerid, x, y, z);
	return true;
}