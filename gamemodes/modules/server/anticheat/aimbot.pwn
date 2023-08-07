#include <discord-connector>
#include <discord-commands>

static weaponstring[][] =
{
	{"a Fist"}, {"Brass Knuckles"}, {"a Golf Club"}, {"a Nightstick"}, {"a Knife"},
	{"a Baseball Bat"}, {"a Shovel"}, {"a Pool Cue"}, {"a Katana"}, {"a Chainsaw"},
	{"a Purple Dildo"}, {"a Small White Vibrator"}, {"a Big White Vibrator"},
	{"a Small Silver Vibrator"}, {"a bunch of Flowers"}, {"a Cane"}, {"some Grenades"}, {"some Teargas"},
	{"some Molotov Cocktails"}, {" "}, {" "}, {""}, {"a 9mm"}, {"a Silenced Pistol"},
	{"a Desert Eagle"}, {"a Shotgun"}, {"a Sawn-off Shotgun"},
	{"a Combat Shotgun"}, {"a Micro Uzi"}, {"an MP5"}, {"an AK-47"}, {"an M4"}, {"a Tec9"},
	{"a Country Rifle"}, {"a Sniper Rifle"}, {"a Rocket Launcher (RPG)"},
	{"a Heat-Seeking Rocket Launcher"}, {"a Flamethrower"}, {"a Minigun"},
	{"some Satchel Charges"}, {"a Detonator"}, {"a Spray Can"}, {"a Fire Extinguisher"},
	{"a Camera"}, {"a pair of Night Vision Goggles"}, {"a pair of Thermal Goggles"},
	{"a Parachute"}, {" "}, {"WHATWEAPONISTHIS?"}, {"a Vehicle"}, {"Helicopter Blades"}, {"an Explosion"}
};

//
#include <pp-hooks>

static 
	rangeWarrning[MAX_PLAYERS],
	proWarrning[MAX_PLAYERS],
	randomWarrning[MAX_PLAYERS];

hook public OnPlayerConnect(playerid)
{
	rangeWarrning[playerid] =
	proWarrning[playerid] =
	randomWarrning[playerid] = 0;
}

//aimbot detection callback
public OnPlayerSuspectedForAimbot(playerid, hitid, weaponid, warnings)
{
	new playa = hitid;
	if(warnings & WARNING_OUT_OF_RANGE_SHOT)
	{
		new Float:distances[BUSTAIM_WSTATS_SHOTS];
		BustAim::GetRangeStats(playerid, distances);

		if (Account[playerid][Kills] < 500)
		{
			rangeWarrning[playerid] ++;
			if (rangeWarrning[playerid] > 5)
			{
				SendAdminsMessage(1, COLOR_GRAY, sprintf("[GUARDIAN] %s has been banned by the anticheat for (greater distance than the weapon '%s' allows).", GetName(playerid), weaponstring[weaponid]));
				SendAdminsMessage(1, COLOR_GRAY, sprintf("[GUARDIAN] Normal Range of %s: %.2f. Range of last three hits: %.2f meters, %.2f meters, %.2f meters.", weaponstring[weaponid], BustAim::GetNormalWeaponRange(weaponid), distances[0], distances[1], distances[2]));

				DCC_SendChannelMessage(DCC_FindChannelByName("anti-cheat-logs"), sprintf("**[GUARDIAN]** %s has been banned by the anticheat for (greater distance than the weapon '%s' allows).", GetName(playerid), weaponstring[weaponid]));
				
				IssueBan(playerid, "Guardian", "out of range shoots");
				KickPlayer(playerid);
				return 1;
			}
		}

		SendAdminsMessage(1, COLOR_GRAY, sprintf("[AIMBOT] %s (%i) has hit shots from a greater distance than their weapon (%s) allows.", GetName(playerid), playerid, weaponstring[weaponid]));
		SendAdminsMessage(1, COLOR_GRAY, sprintf("[AIMBOT] Normal Range of %s: %.2f. Range of last three hits: %.2f meters, %.2f meters, %.2f meters.", weaponstring[weaponid], BustAim::GetNormalWeaponRange(weaponid), distances[0], distances[1], distances[2]));
		DCC_SendChannelMessage(DCC_FindChannelByName("anti-cheat-logs"), sprintf("**[AIMBOT]** %s (%i) has hit shots from a greater distance than their weapon (%s) allows.", GetName(playerid), playerid, weaponstring[weaponid]));
		DCC_SendChannelMessage(DCC_FindChannelByName("anti-cheat-logs"), sprintf("**[AIMBOT]** Normal Range of %s: %.2f. Range of last three hits: %.2f meters, %.2f meters, %.2f meters.", weaponstring[weaponid], BustAim::GetNormalWeaponRange(weaponid), distances[0], distances[1], distances[2]));
	}
	if(warnings & WARNING_PROAIM_TELEPORT)
	{
		new Float:distances[BUSTAIM_WSTATS_SHOTS], Float:x, Float:y, Float:z;
		BustAim::GetTeleportStats(playerid, distances);
		GetPlayerPos(playa, x, y, z);

		if (Account[playerid][Kills] < 500)
		{
			proWarrning[playerid] ++;
			if (proWarrning[playerid] > 5)
			{
				SendAdminsMessage(1, COLOR_GRAY, sprintf("[GUARDIAN] %s has been banned by the anticheat for (Pro Aimbot).", GetName(playerid), weaponstring[weaponid]));
				SendAdminsMessage(1, COLOR_GRAY, sprintf("[GUARDIAN] Range between %s and where their last 3 bullets hit: %.2f, %.2f, %.2f. Range between the player and %s: %.2f", GetName(playerid), distances[0], distances[1], distances[2], GetName(playa), GetPlayerDistanceFromPoint(playerid, x, y, z)));

				DCC_SendChannelMessage(DCC_FindChannelByName("anti-cheat-logs"), sprintf("**[GUARDIAN]** %s has been banned by the anticheat for (Pro Aimbot).", GetName(playerid)));
				
				IssueBan(playerid, "Guardian", "Pro Aimbot");
				KickPlayer(playerid);
				return 1;
			}
		}

		SendAdminsMessage(1, COLOR_GRAY, sprintf("[AIMBOT] %s (%i) has been suspected of using proaim. (A cheat that teleports an enemy in front of the player so they can spoof hitting them)", GetName(playerid), playerid));
		SendAdminsMessage(1, COLOR_GRAY, sprintf("[AIMBOT] Range between %s and where their last 3 bullets hit: %.2f, %.2f, %.2f. Range between the player and %s: %.2f", GetName(playerid), distances[0], distances[1], distances[2], GetName(playa), GetPlayerDistanceFromPoint(playerid, x, y, z)));
		DCC_SendChannelMessage(DCC_FindChannelByName("anti-cheat-logs"), sprintf("[AIMBOT] %s (%i) has been suspected of using proaim. (A cheat that teleports an enemy in front of the player so they can spoof hitting them)", GetName(playerid), playerid));
		DCC_SendChannelMessage(DCC_FindChannelByName("anti-cheat-logs"), sprintf("[AIMBOT] Range between %s and where their last 3 bullets hit: %.2f, %.2f, %.2f. Range between the player and %s: %.2f", GetName(playerid), distances[0], distances[1], distances[2], GetName(playa), GetPlayerDistanceFromPoint(playerid, x, y, z)));
	
	}
	if(warnings & WARNING_RANDOM_AIM)
	{
		new Float:distances[BUSTAIM_WSTATS_SHOTS];
		BustAim::GetRandomAimStats(playerid, distances);

		if (Account[playerid][Kills] < 500)
		{
			randomWarrning[playerid] ++;
			if (randomWarrning[playerid] > 5)
			{
				SendAdminsMessage(1, COLOR_GRAY, sprintf("[GUARDIAN] %s has been banned by the anticheat for (random aimbot).", GetName(playerid), weaponstring[weaponid]));
				SendAdminsMessage(1, COLOR_GRAY, sprintf("[GUARDIAN] Offsets of the player's last 3 bullet hits: %.2f %.2f %.2f", distances[0], distances[1], distances[2]));

				DCC_SendChannelMessage(DCC_FindChannelByName("anti-cheat-logs"), sprintf("**[GUARDIAN]** %s has been banned by the anticheat for (Random Aimbot).", GetName(playerid)));
				
				IssueBan(playerid, "Guardian", "Random Aimbot");
				KickPlayer(playerid);
				return 1;
			}
		}

		SendAdminsMessage(1, COLOR_GRAY, sprintf("[AIMBOT] %s (%i) has been suspected of using 'random aim'. This is a cheat that corrects a player's bullet trajectory when they are aiming near someone but barely misses.", GetName(playerid), playerid));
		SendAdminsMessage(1, COLOR_GRAY, sprintf("[AIMBOT] Offsets of the player's last 3 bullet hits: %.2f %.2f %.2f", distances[0], distances[1], distances[2]));
		DCC_SendChannelMessage(DCC_FindChannelByName("anti-cheat-logs"), sprintf("[AIMBOT] %s (%i) has been suspected of using 'random aim'. This is a cheat that corrects a player's bullet trajectory when they are aiming near someone but barely misses.", GetName(playerid), playerid));
		DCC_SendChannelMessage(DCC_FindChannelByName("anti-cheat-logs"), sprintf("[AIMBOT] Offsets of the player's last 3 bullet hits: %.2f %.2f %.2f", distances[0], distances[1], distances[2]));
	}
	if(warnings & WARNING_CONTINOUS_SHOTS)
	{
		SendAdminsMessage(1, COLOR_GRAY, sprintf("[AIMBOT] %s (%i) has hit 10 consecutive shots without missing using %s", GetName(playerid), playerid, weaponstring[weaponid]));
		DCC_SendChannelMessage(DCC_FindChannelByName("anti-cheat-logs"), sprintf("[AIMBOT] %s (%i) has hit 10 consecutive shots without missing using %s", GetName(playerid), playerid, weaponstring[weaponid]));
	}
	return false;
}

//aim profile command
CMD<AD1>:aimprofile(cmdid, playerid, params[])
{
	new playa = -1, weapon[32];
	if(sscanf(params, "uS()[32]", playa, weapon)) return SendClientMessage(playerid, COLOR_GRAY, "USAGE: /aimprofile [playerid or name] [optional: weapon]");
	if(!IsPlayerConnected(playa)) return SendErrorMessage(playerid, ERROR_OPTION);

	new allshots, hitshots, max_cont_shots, out_of_range_warns, random_aim_warns, proaim_tele_warns, wepname[32];
	if(isnull(weapon))
	{
		BustAim::GetPlayerProfile(playa, allshots, hitshots, max_cont_shots, out_of_range_warns, random_aim_warns, proaim_tele_warns);
		wepname = "All Weapons";
	}
	else
	{
		new WeaponID = GetWeaponIDFromName(weapon);
		BustAim::GetPlayerWeaponProfile(playa, WeaponID, allshots, hitshots, max_cont_shots, out_of_range_warns, random_aim_warns, proaim_tele_warns);
		format(wepname, 32, WeaponNameList[WeaponID]);
	}

	SendClientMessage(playerid, COLOR_WHITE, "\n");
	SendClientMessage(playerid, COLOR_WHITE, sprintf("Aim Profile of {6AB04C}%s (%i){FFFFFF} - %s", GetName(playa), playa, wepname));
	SendClientMessage(playerid, COLOR_WHITE, sprintf("Bullets Fired: {6AB04C}%i", allshots));
	SendClientMessage(playerid, COLOR_WHITE, sprintf("Bullets Hit: {6AB04C}%i", hitshots));
	SendClientMessage(playerid, COLOR_WHITE, sprintf("Hit Percentage: {6AB04C}%.2f%%", ((hitshots*100.0) / allshots)));
	SendClientMessage(playerid, COLOR_WHITE, sprintf("Highest Continuous Shots: {6AB04C}%i", max_cont_shots));
	SendClientMessage(playerid, COLOR_WHITE, sprintf("Out of Range Shots: {6AB04C}%i", out_of_range_warns));
	SendClientMessage(playerid, COLOR_WHITE, sprintf("Random Aim Warnings: {6AB04C}%i", random_aim_warns));
	SendClientMessage(playerid, COLOR_WHITE, sprintf("Proaim Teleport Warnings: {6AB04C}%i", proaim_tele_warns));
	SendClientMessage(playerid, COLOR_WHITE, "\n");
	return true;
}
ALT:ap = CMD:aimprofile;