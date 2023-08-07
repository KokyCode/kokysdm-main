/*
Desynchronization Checker
Jelly23
*/

#if ! defined J_DESYNC_CHECKER_
	#define J_DESYNC_CHECKER_
#endif

/*Variables*/
static 
	bool:DCI_IsPlayerSynced[MAX_PLAYERS char],
	DCI_PlayerAmmoCount[MAX_PLAYERS char],
	DCI_PlayerUpdateTick[MAX_PLAYERS];
	
/*Callbacks*/
public OnPlayerUpdate(playerid)
{
	if(gettime() > DCI_PlayerUpdateTick[playerid] && !IsPlayerNPC(playerid))
	{
		new
		    DCI_Internal_Weapon,
			DCI_Internal_Ammo;
			
		DCI_PlayerUpdateTick[playerid] = gettime();

	    GetPlayerWeaponData(playerid, 0, DCI_Internal_Weapon, DCI_Internal_Ammo);
		
		DCI_IsPlayerSynced{playerid} = (DCI_Internal_Ammo != DCI_PlayerAmmoCount{playerid});

		SetPlayerAmmo(playerid, DCI_Internal_Weapon, !DCI_Internal_Ammo);
		
		DCI_PlayerAmmoCount{playerid} = DCI_Internal_Ammo;
	}
	#if defined DCI_OnPlayerUpdate
		return DCI_OnPlayerUpdate(playerid);
	#else
		return 1;
	#endif
}

/*Functions*/
stock IsPlayerSynced(playerid) return DCI_IsPlayerSynced{playerid};

/*Hooks*/
#if defined _ALS_OnPlayerUpdate
#undef OnPlayerUpdate
#else
#define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate DCI_OnPlayerUpdate

#if defined DCI_OnPlayerUpdate
forward DCI_OnPlayerUpdate(playerid);
#endif

