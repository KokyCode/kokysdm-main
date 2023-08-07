//data
#define MAX_WEAPONSLOTS       	(13)

enum WEAPON_DATA
{
	bool:ACWeaponPossession,
	ACWeaponID,
	ACWeaponAmmo,
}
new WeaponData[MAX_PLAYERS][MAX_WEAPONSLOTS][WEAPON_DATA];
new WeaponACTriggers[MAX_PLAYERS];

//hooks/callbacks
WAC_GivePlayerWeapon(playerid, weaponid, ammo)
{
	PauseAnticheatForPlayer(playerid);

	new slot = GetWeaponSlot(weaponid);
	WeaponData[playerid][slot][ACWeaponPossession] = true;
	WeaponData[playerid][slot][ACWeaponID] = weaponid;
	WeaponData[playerid][slot][ACWeaponAmmo] = ammo;
	return GivePlayerWeapon(playerid, weaponid, ammo);
}
#if defined _ALS_GivePlayerWeapon
	#undef GivePlayerWeapon
#else
	#define _ALS_GivePlayerWeapon
#endif

#define GivePlayerWeapon WAC_GivePlayerWeapon

CheckPlayerWeapons(playerid)
{
	if(!IsPlayerSynced(playerid) || IsAnticheatPaused(playerid) || IsPlayerPaused(playerid)) return true;

	new weapon, ammo;
	for(new i = 1; i < MAX_WEAPONSLOTS; i++)
	{
		GetPlayerWeaponData(playerid, i, weapon, ammo);
		if(weapon != 0 && ammo != 0 && weapon != 46 && weapon != 2)
		{
			if(!WeaponData[playerid][i][ACWeaponPossession] || WeaponData[playerid][i][ACWeaponPossession] && weapon != WeaponData[playerid][i][ACWeaponID]) //nigga shouldnt have this gun
			{
				SyncPlayerWeapons(playerid);
				WeaponACTriggers[playerid] ++;
				if(WeaponACTriggers[playerid] >= 3) //ban the player
				{
					SendClientMessageToAll(COLOR_LIGHTRED, sprintf("[AUTO BAN] %s (%i) has ben banned for using weapon cheats. (%s)", GetName(playerid), playerid, WeaponNameList[weapon]));
					IssueBan(playerid, "Auto Ban", sprintf("Weapon Cheats (%s)", WeaponNameList[weapon]));
					break;
				}
			}
		}
	}
	return true;
}

//functions
SyncPlayerWeapons(playerid)
{
	PauseAnticheatForPlayer(playerid);
	ResetPlayerWeapons(playerid);

	for(new i = 0; i < MAX_WEAPONSLOTS; i++)
	{
		if(WeaponData[playerid][i][ACWeaponPossession])
		{
			GivePlayerWeapon(playerid, WeaponData[playerid][i][ACWeaponID], WeaponData[playerid][i][ACWeaponAmmo]);
		}
	}
	return true;
}
ResetPlayerWeaponsEx(playerid)
{
	PauseAnticheatForPlayer(playerid);
	ResetWeaponData(playerid);
	ResetPlayerWeapons(playerid);
	return true;
}
ResetWeaponData(playerid, slot = -1)
{
	new temp[WEAPON_DATA];
	if(slot == -1)
	{
		for(new i = 0; i < MAX_WEAPONSLOTS; i++)
		{
			WeaponData[playerid][i] = temp;
		}
	}
	else WeaponData[playerid][slot] = temp;
	return true;
}