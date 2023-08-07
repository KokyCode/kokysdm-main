
/*
 *
 *  Anticheat Config
 *
*/
forward OnCheatDetected(const playerid, const ip_address[], const type, const code);
public OnCheatDetected(const playerid, const ip_address[], const type, const code) {
    if (type) {
        #if defined BlockIpAddress
            BlockIpAddress(ip_address, 0);
        #else
            static ac_strtmp[32];
            format(ac_strtmp, sizeof ac_strtmp, "banip %s", ip_address);
            SendRconCommand(ac_strtmp);
        #endif
    } else {
        switch (code) {
            case 40: {
                SendClientMessage(playerid, AC_DEFAULT_COLOR, MAX_CONNECTS_MSG);
            }
            case 41: {
                SendClientMessage(playerid, AC_DEFAULT_COLOR, UNKNOWN_CLIENT_MSG);
            }
            default: {
                new kickMessage[sizeof KICK_MSG + 48];
                format(kickMessage, sizeof kickMessage, KICK_MSG, CodeToName(code));
                SendClientMessage(playerid, 0xFF0000AA, kickMessage);
            }
        }
        AntiCheatKickWithDesync(playerid, code);
    }
    return 1;
}

static CodeToName(const code) {
	new cheatName[48];
	/* ** ** */
	switch(code) {
		case 0: cheatName = "Airbreak (onfoot)";
		case 1: cheatName = "Airbreak (in vehicle)";
		case 2: cheatName = "Teleport hack (onfoot)";
		case 3: cheatName = "Teleport hack (in vehicle)";
		case 4: cheatName = "Teleport hack (into/between vehicles)";
		case 5: cheatName = "Teleport hack (vehicle to player)";
		case 6: cheatName = "Teleport hack (pickups)";
		case 7: cheatName = "FlyHack (onfoot)";
		case 8: cheatName = "FlyHack (in vehicle)";
		case 9: cheatName = "SpeedHack (onfoot)";
		case 10: cheatName = "SpeedHack (in vehicle)";
		case 11: cheatName = "Health hack (in vehicle)";
		case 12: cheatName = "Health hack (onfoot)";
		case 13: cheatName = "Armour hack";
		case 14: cheatName = "Money hack";
		case 15: cheatName = "Weapon hack";
		case 16: cheatName = "Ammo hack (add)";
		case 17: cheatName = "Ammo hack (infinite)";
		case 18: cheatName = "Special actions hack";
		case 19: cheatName = "GodMode from bullets (onfoot)";
		case 20: cheatName = "GodMode from bullets (in vehicle)";
		case 21: cheatName = "Invisible hack";
		case 22: cheatName = "lagcomp-spoof";
		case 23: cheatName = "Tuning hack";
		case 24: cheatName = "Parkour mod";
		case 25: cheatName = "Quick turn";
		case 26: cheatName = "Rapid fire";
		case 27: cheatName = "FakeSpawn";
		case 28: cheatName = "FakeKill";
		case 29: cheatName = "Pro Aim";
		case 30: cheatName = "CJ run";
		case 31: cheatName = "CarShot";
		case 32: cheatName = "CarJack";
		case 33: cheatName = "UnFreeze";
		case 34: cheatName = "AFK Ghost";
		case 35: cheatName = "Full Aiming";
		case 36: cheatName = "Fake NPC";
		case 37: cheatName = "Reconnect";
		case 38: cheatName = "High ping";
		case 39: cheatName = "Dialog hack";
		case 40: cheatName = "Protection from sandbox";
		case 41: cheatName = "Protection from invalid version";
		case 42: cheatName = "Rcon hack";
		case 43: cheatName = "Tuning crasher";
		case 44: cheatName = "Invalid seat crasher";
		case 45: cheatName = "Dialog crasher";
		case 46: cheatName = "Attached object crasher";
		case 47: cheatName = "Weapon Crasher";
		case 48: cheatName = "Protection from connection flood in one slot";
		case 49: cheatName = "Callback functions flood";
		case 50: cheatName = "Flood by seat changing";
		case 51: cheatName = "DDos";
		case 52: cheatName = "NOP's";
	}
	return cheatName;
}

CMD<AD4>:disableac(cmdid, playerid, params[]) {

    for (new i; i < 52; i++) {
		if (IsAntiCheatEnabled(i)) {
			EnableAntiCheat(i, false);
		}
    }

	SendClientMessage(playerid, -1, "You disabled the whole AntiCheat.");

	return CMD_SUCCESS;
}

CMD<AD4>:acsettings(cmdid, playerid, params[]) {
    new dialogStr[48 * 52];
    format(dialogStr, sizeof dialogStr, "ID\tName\tEnabled\n"); 
    for (new i; i < 52; i++) {
        format(dialogStr, sizeof dialogStr, 
            "%s\n\
            %i\t%s\t%s", dialogStr, i, CodeToName(i), IsAntiCheatEnabled(i) ? "{00ff00}Yes" : "{ff0000}No");
    }
	new response[e_DIALOG_RESPONSE_INFO];
	yield 1;
	AwaitAsyncDialog(playerid, response, DIALOG_STYLE_TABLIST_HEADERS, "Select the anticheat", dialogStr, "Select", "Cancel");

	if(!response[E_DIALOG_RESPONSE_Response]) {
        return CMD_SUCCESS;
    }

    new const listitem = response[E_DIALOG_RESPONSE_Listitem];

    EnableAntiCheat(listitem, !IsAntiCheatEnabled(listitem));
    SendClientMessage(playerid, -1, sprintf("You %s {ffffff}the anticheat for %s.", IsAntiCheatEnabled(listitem) ? "{00ff00}enabled" : "{ff0000}disabled", CodeToName(listitem)));

    return CMD_SUCCESS;
}
