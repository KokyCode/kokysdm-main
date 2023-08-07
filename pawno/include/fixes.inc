#define _FIXES_IS_UNSET(%0) ((2*%0-1+1)==-1)

#if !defined FIX_GetPlayerWeaponData
	#define FIX_GetPlayerWeaponData      (0)
#elseif _FIXES_IS_UNSET(FIX_GetPlayerWeaponData)
	#undef FIX_GetPlayerWeaponData
	#define FIX_GetPlayerWeaponData      (2)
#endif

#if !defined FIX_strcmp
	#define FIX_strcmp      (1)
#elseif _FIXES_IS_UNSET(FIX_strcmp)
	#undef FIX_strcmp
	#define FIX_strcmp      (2)
#endif

#if defined _ALS_GetPlayerWeaponData
	#error _ALS_GetPlayerWeaponData defined
#endif
native BAD_GetPlayerWeaponData(playerid, slot, &weapons, &ammo) = GetPlayerWeaponData;

#if FIX_GetPlayerWeaponData
	stock FIXES_GetPlayerWeaponData(playerid, slot, &weapons, &ammo)
	{
		// This reuses the "slot" variable so we don't have to declare a new one
		// and can put all the code in a single statement.
		return
			slot = GetPlayerWeaponData(playerid, slot, weapons, ammo),
			weapons = ammo ? weapons : 0,
			slot;
	}

	#define _ALS_GetPlayerWeaponData
	#define GetPlayerWeaponData FIXES_GetPlayerWeaponData
#endif

	#if defined _ALS_strcmp
	#error _ALS_strcmp defined
#endif
native BAD_strcmp(const string1[], const string2[], bool:ignorecase=false, length=cellmax) = strcmp;

#if FIX_strcmp
	stock FIXES_strcmp(const string1[], const string2[], bool:ignorecase=false, length=cellmax)
	{
		if (string1[0])
		{
			if (string2[0])
			{
				return strcmp(string1, string2, ignorecase, length);
			}
			else
			{
				// Positive as st1 is greater (strcmp spec).
				return 1;
			}
		}
		else
		{
			if (string2[0])
			{
				// Negative as str2 is greater.
				return -1;
			}
			else
			{
				// The strings are the same (empty).
				return 0;
			}
		}
	}

	#define _ALS_strcmp
	#define strcmp FIXES_strcmp
#endif