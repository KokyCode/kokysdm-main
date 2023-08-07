//data
new LoginAttempts[MAX_PLAYERS];
//callbacks

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	if(Account[playerid][LoggedIn] == 0)
	{
		new tmpName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, tmpName, sizeof tmpName);
		TextDrawShowForPlayer(playerid, logintd);
		SendClientMessage(playerid, 0xbf0000FF, sprintf("%s [%s]", Server[Name], Server[Version]));
		SendClientMessage(playerid, COLOR_WHITE, sprintf("Welcome to the server, %s.", tmpName));
		if(!isempty(MOTD[ServerMOTD])) SendClientMessage(playerid, 0xFFFF00FF, sprintf("[MOTD]: %s", MOTD[ServerMOTD]));

		InfoBoxForPlayer(playerid, "~r~Koky's Deathmatch~w~~n~Welcome to Koky's Deathmatch!");

		Account[playerid][LoggedIn] = 0;
		LoginAttempts[playerid] = 0;

		IP_Lookup(playerid);

		await mysql_aquery_s(SQL_CONNECTION, str_format("SELECT Username FROM `Accounts` WHERE Username = '%e' LIMIT 1", tmpName));
		if(cache_num_rows())
		{
			new tmpUsername[MAX_PLAYER_NAME];
			cache_get_value_name(0, "Username", tmpUsername);
			if (strcmp(tmpUsername, GetName(playerid)))
			{
				SendClientMessage(playerid, COLOR_WHITE, sprintf("You registred your account as '%s', u must set your name to that (case-sensitive).", tmpUsername));
				KickPlayer(playerid);
			}
			else
				Login_Dialog(playerid);
		}
		else Register_Dialog(playerid);
	}
	return true;
}

forward ShowHelpMessage(playerid);
public ShowHelpMessage(playerid)
{
	if (GetPlayerAdminLevel(playerid) < 1) {
		SendClientMessage(playerid, COLOR_LIGHTRED, "[ HELP MESSAGE ]");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Arenas: {FFFFFF}Please refer to -> {DADADA}/arenas{FFFFFF}.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "KDM Tokens: {FFFFFF}Please refer to -> {DADADA}/tokenhelp{FFFFFF}.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Skin Roll: {FFFFFF}Please refer to -> /{DADADA}skinrollhelp{FFFFFF}.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Crates: {FFFFFF}Please refer to -> {DADADA}/crateshelp{FFFFFF}.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Donate: {FFFFFF}Please refer to -> {DADADA}/donate{FFFFFF}.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Clan: {FFFFFF}Please refer to -> {DADADA}/clanhelp{FFFFFF}.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Language: {FFFFFF}Please refer to -> {DADADA}/setlanguage{FFFFFF}.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Other: {FFFFFF}Please refer to -> {DADADA}/help{FFFFFF}.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "NOTICE: You can now donate easily! Check out www.kokysdm.net/donate!");
	}

	return true;
}

forward OnNewPasswordHashed(playerid);
public OnNewPasswordHashed(playerid)
{
	new hash[BCRYPT_HASH_LENGTH];
	bcrypt_get_hash(hash);

	mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE Accounts SET Password = '%e' WHERE SQLID = %i", hash, Account[playerid][SQLID]));
	return true;
}

forward OnNewAccountPasswordHashed(playerid);
public OnNewAccountPasswordHashed(playerid)
{
	new hash[BCRYPT_HASH_LENGTH];
	bcrypt_get_hash(hash);

	await mysql_aquery_s(SQL_CONNECTION, str_format("INSERT INTO Accounts (Username, Password, RegisterDate) VALUES('%e', '%e', %d)", GetName(playerid), hash, gettime()));
	Account[playerid][SQLID] = cache_insert_id();

	TogglePlayerSpectating(playerid, 0);
	Register(playerid);
}
Character_Save(playerid)
{
	printf("Called SaveChar for player %d", playerid);
	if(Account[playerid][LoggedIn] == 1)
	{
		mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `Admin` = %d, `ClanManagement` = %d, `Skin` = %d, `Kills` = %d, `Deaths` = %d, `PlayerKeys` = %d, `PlayerEvents` = %d, `Cash` = %d, `GsignPack` = %d, `WeatherAccess` = %d, `TimeAccess` = %d, `WheelChair` = %d, `InWheelChair` = %d, `OpenedCrates` = %d, `ForumID` = %i, `ForumCode` = %i, `Verified` = %i, `NameChanges` = %d, `PlayerGroup` = %d, `Headshots` = %d, `HighestSpree` = %d, `Color` = %i, Hitmark = %d, EventsStarted = %d, EventsWon = %d, Kicks = %d, Mutes = %d, ForcedRules = %d, BronzePackages = %d, SilverPackages = %d, GoldPackages = %d, DiamondPackages = %d, SkinPackUnlock = %d, NameChangePackages = %d, PremiumKeyPackages = %d, Donator = %d, DonatorActive = %d, DonatorExpired = %d, LobbyWeapon = %d, ShotsHit = %d, ShotsMissed = %d, ShotsFired = %d, ajail_minutes = %d, CustomSkin = %d, Hour = %d, Min = %d, Sec = %d, AdminPin = %d, LastLoggedIn = %d, MonthKills = %d, LastMonthKills = %d, Muted = %d, AdminHours = %d, AdminMinutes = %d, AdminSeconds = %d, AdminActions = %d, clanid = %d, clanname = '%e', clanrank = %d, official = %d, Tokens = %d, TokenPackages = %d, RareSkins = %d, RareItems = %d, KDMStaffSkin = %d, ArcherSkin = %d, GucciSnakeSkin = %d, IrishPoliceSkin = %d, NillySkin = %d, Language = %d, DonationAmount = %f WHERE SQLID = %d LIMIT 1",
			Account[playerid][Admin],
			Account[playerid][ClanManagement],
			Account[playerid][Skin],
			Account[playerid][Kills],
			Account[playerid][Deaths],
			Account[playerid][PlayerKeys],
			Account[playerid][PlayerEvents],
			Account[playerid][Cash],
			Account[playerid][GsignPack],
			Account[playerid][WeatherAccess],
			Account[playerid][TimeAccess],
			Account[playerid][WheelChair],
			Account[playerid][InWheelChair],
			Account[playerid][OpenedCrates],
			Account[playerid][ForumID],
			Account[playerid][ForumCode],
			Account[playerid][Verified],
			Account[playerid][NameChanges],
			Account[playerid][PlayerGroup],
			Account[playerid][Headshots],
			Account[playerid][HighestSpree],
			Account[playerid][Color],
			Account[playerid][Hitmark],
			Account[playerid][EventsStarted],
			Account[playerid][EventsWon],
			Account[playerid][Kicks],
			Account[playerid][Mutes],
			Account[playerid][ForcedRules],
			Account[playerid][BronzePackages],
			Account[playerid][SilverPackages],
			Account[playerid][GoldPackages],
			Account[playerid][DiamondPackages],
			Account[playerid][SkinPackUnlock],
			Account[playerid][NameChangePackages],
			Account[playerid][PremiumKeyPackages],
			Account[playerid][Donator],
			Account[playerid][DonatorActive],
			Account[playerid][DonatorExpired],
			Account[playerid][LobbyWeapon],
			Account[playerid][ShotsHit],
			Account[playerid][ShotsMissed],
			Account[playerid][ShotsFired],
			Account[playerid][AJailTime],
			Account[playerid][CustomSkin],
			Account[playerid][Hours],
			Account[playerid][Minutes],
			Account[playerid][Seconds],
			Account[playerid][AdminPin],
			Account[playerid][LastLoggedIn] = gettime(),
			Account[playerid][MonthKills],
			Account[playerid][LastMonthKills],
			Account[playerid][Muted],
			Account[playerid][AdminHours],
			Account[playerid][AdminMinutes],
			Account[playerid][AdminSeconds],
			Account[playerid][AdminActions],
			Account[playerid][ClanID], 
			Account[playerid][ClanName],
			Account[playerid][ClanRank],
			Account[playerid][OfficialClan],
			Account[playerid][Tokens],
			Account[playerid][TokenPackages],	
			Account[playerid][RareSkins],
			Account[playerid][RareItems],
			Account[playerid][hasKDMStaffSkin],
			Account[playerid][hasArcherSkin],
			Account[playerid][hasGucciSnakeSkin],
			Account[playerid][hasIrishPoliceSkin],
			Account[playerid][hasNillySkin],
			Account[playerid][pLanguage],
			Account[playerid][DonationAmount],
			Account[playerid][SQLID]
		));
		
	}
	return 1;
}

forward OnAccountPasswordChecked(playerid);
public OnAccountPasswordChecked(playerid)
{
	if(!bcrypt_is_equal())
	{
		if(LoginAttempts[playerid] < 2)
		{
			SendClientMessage(playerid, COLOR_GRAY, "{bf0000}NOTICE: {FFFFFF}Incorrect password, try again.");
			LoginAttempts[playerid] ++;
			Login_Dialog(playerid);
		}
		else
		{
			SendClientMessage(playerid, COLOR_GRAY, "{bf0000}NOTICE: {FFFFFF}You have been kicked for too many failed attempts.");
			KickPlayer(playerid);
		}
		return true;
	}

	new admin, pin;
	await mysql_aquery_s(SQL_CONNECTION, str_format("SELECT Admin, AdminPin FROM Accounts WHERE Username = '%e'", GetName(playerid)));
	cache_get_value_name_int(0, "Admin", admin);
	cache_get_value_name_int(0, "AdminPin", pin);

	if(admin != 0) HandleAdminPin(playerid, admin, pin);
	else LoginAccount(playerid);
	return true;
}
forward OnOfflineAccountHashed(accountname[]);
public OnOfflineAccountHashed(accountname[])
{
	new hash[BCRYPT_HASH_LENGTH];
	bcrypt_get_hash(hash);
	mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE Accounts SET Password = '%e' WHERE Username = '%e'", hash, accountname));
	return true;
}

//functions
Login_Dialog(playerid)
{
	new str[256];
	TextDrawShowForPlayer(playerid, logintd);

	new response[e_DIALOG_RESPONSE_INFO];
	format(str, sizeof(str), "{FFFFFF}Hello, %s!\n\nWelcome back to {990a1e}Koky's Deathmatch{FFFFFF}.\nPlease login with your existing password below.", GetName(playerid));
	AwaitAsyncDialog(playerid, response, DIALOG_STYLE_PASSWORD, "Koky's Deathmatch | Login", str, "Login", "Leave");

	if(!response[E_DIALOG_RESPONSE_Response])
	{
		SendClientMessage(playerid, COLOR_GRAY, "{bf0000}NOTICE: {FFFFFF}You have left the server.");
		KickPlayer(playerid);
		return true;
	}

	await mysql_aquery_s(SQL_CONNECTION, str_format("SELECT Password, LatestIP FROM Accounts WHERE Username = '%e'", GetName(playerid)));
	if(!cache_num_rows()) return true;

	new hashedpass[128];
	cache_get_value_name(0, "Password", hashedpass);
	bcrypt_check(response[E_DIALOG_RESPONSE_InputText], hashedpass, "OnAccountPasswordChecked", "i", playerid);
	return true;
}

Register_Dialog(playerid)
{
	new response[e_DIALOG_RESPONSE_INFO], str[256];
	format(str, sizeof(str), "{FFFFFF}Hello, %s!\n\nWelcome to {990a1e}Koky's Deathmatch{FFFFFF}.\nThis username isn't registered, thus you will register it now!\n\nEnter your desired password:",
		GetName(playerid));
	AwaitAsyncDialog(playerid, response, DIALOG_STYLE_PASSWORD, "Koky's Deathmatch | Register", str, "Register", "Leave");

	if(!response[E_DIALOG_RESPONSE_Response]) return KickPlayer(playerid);

	if(strlen(response[E_DIALOG_RESPONSE_InputText]) < 5)
	{
		SendClientMessage(playerid, COLOR_GRAY, "{bf0000}NOTICE: {FFFFFF}Your password must contain more than 5 characters.");
		Register_Dialog(playerid);
		return true;
	}

	bcrypt_hash(response[E_DIALOG_RESPONSE_InputText], BCRYPT_COST, "OnNewAccountPasswordHashed", "i", playerid);
	return 1;
}

LoginAccount(playerid)
{
	TextDrawHideForPlayer(playerid, logintd);
	await mysql_aquery_s(SQL_CONNECTION, str_format("SELECT * FROM Accounts WHERE Username = '%e' LIMIT 1", GetName(playerid)));
	if(!cache_num_rows()) return true;

	ActivityState[playerid] = ACTIVITY_LOBBY;
	ActivityStateID[playerid] = -1;
	cache_get_value_name_int(0, "SQLID", Account[playerid][SQLID]);
	cache_get_value_name_int(0, "Admin", Account[playerid][Admin]);
	cache_get_value_name_int(0, "ClanManagement", Account[playerid][ClanManagement]);
	cache_get_value_name_int(0, "Donator", Account[playerid][Donator]);
	cache_get_value_name_int(0, "Skin", Account[playerid][Skin]);
	cache_get_value_name_int(0, "Kills", Account[playerid][Kills]);
	cache_get_value_name_int(0, "Deaths", Account[playerid][Deaths]);
	cache_get_value_name_int(0, "PlayerKeys", Account[playerid][PlayerKeys]);
	cache_get_value_name_int(0, "PlayerEvents", Account[playerid][PlayerEvents]);
	cache_get_value_name_int(0, "Cash", Account[playerid][Cash]);
	cache_get_value_name_int(0, "GsignPack", Account[playerid][GsignPack]);
	cache_get_value_name_int(0, "WeatherAccess", Account[playerid][WeatherAccess]);
	cache_get_value_name_int(0, "TimeAccess", Account[playerid][TimeAccess]);
	cache_get_value_name_int(0, "WheelChair", Account[playerid][WheelChair]);
	cache_get_value_name_int(0, "InWheelChair", Account[playerid][InWheelChair]);
	cache_get_value_name_int(0, "OpenedCrates", Account[playerid][OpenedCrates]);
	cache_get_value_name_int(0, "ForumID", Account[playerid][ForumID]);
	cache_get_value_name_int(0, "ForumCode", Account[playerid][ForumCode]);
	cache_get_value_name_int(0, "Verified", Account[playerid][Verified]);
	cache_get_value_name_int(0, "NameChanges", Account[playerid][NameChanges]);
	cache_get_value_name_int(0, "PlayerGroup", Account[playerid][PlayerGroup]);
	cache_get_value_name_int(0, "Headshots", Account[playerid][Headshots]);
	cache_get_value_name_int(0, "HighestSpree", Account[playerid][HighestSpree]);
	cache_get_value_name_int(0, "EventsStarted", Account[playerid][EventsStarted]);
	cache_get_value_name_int(0, "Hitmark", Account[playerid][Hitmark]);
	cache_get_value_name_int(0, "EventsWon", Account[playerid][EventsWon]);
	cache_get_value_name_int(0, "Kicks", Account[playerid][Kicks]);
	cache_get_value_name_int(0, "Mutes", Account[playerid][Mutes]);
	cache_get_value_name_int(0, "ForcedRules", Account[playerid][ForcedRules]);
	cache_get_value_name_int(0, "BronzePackages", Account[playerid][BronzePackages]);
	cache_get_value_name_int(0, "SilverPackages", Account[playerid][SilverPackages]);
	cache_get_value_name_int(0, "GoldPackages", Account[playerid][GoldPackages]);
	cache_get_value_name_int(0, "DiamondPackages", Account[playerid][DiamondPackages]);
	cache_get_value_name_int(0, "NameChangePackages", Account[playerid][NameChangePackages]);
	cache_get_value_name_int(0, "PremiumKeyPackages", Account[playerid][PremiumKeyPackages]);
	cache_get_value_name_int(0, "SkinPackUnlock", Account[playerid][SkinPackUnlock]);
	cache_get_value_name_int(0, "DonatorActive", Account[playerid][DonatorActive]);
	cache_get_value_name_int(0, "DonatorExpired", Account[playerid][DonatorExpired]);
	cache_get_value_name_int(0, "LobbyWeapon", Account[playerid][LobbyWeapon]);
	cache_get_value_name_int(0, "ShotsFired", Account[playerid][ShotsFired]);
	cache_get_value_name_int(0, "ShotsMissed", Account[playerid][ShotsMissed]);
	cache_get_value_name_int(0, "ShotsHit", Account[playerid][ShotsHit]);
	cache_get_value_name_int(0, "ajail_minutes", Account[playerid][AJailTime]);
	cache_get_value_name_int(0, "CustomSkin", Account[playerid][CustomSkin]);
	cache_get_value_name_int(0, "Sec", Account[playerid][Seconds]);
	cache_get_value_name_int(0, "Min", Account[playerid][Minutes]);
	cache_get_value_name_int(0, "Hour", Account[playerid][Hours]);
	cache_get_value_name_int(0, "AdminPin", Account[playerid][AdminPin]);
	cache_get_value_name_int(0, "LastLoggedIn", Account[playerid][LastLoggedIn]);
	cache_get_value_name_int(0, "MonthKills", Account[playerid][MonthKills]);
	cache_get_value_name_int(0, "LastMonthKills", Account[playerid][LastMonthKills]);
	cache_get_value_name_int(0, "Muted", Account[playerid][Muted]);
	cache_get_value_name_int(0, "AdminHours", Account[playerid][AdminHours]);
	cache_get_value_name_int(0, "AdminMinutes", Account[playerid][AdminMinutes]);
	cache_get_value_name_int(0, "AdminSeconds", Account[playerid][AdminSeconds]);
	cache_get_value_name_int(0, "AdminActions", Account[playerid][AdminActions]);
	cache_get_value_name_int(0, "clanid", Account[playerid][ClanID]);
	cache_get_value_name(0, "clanname", Account[playerid][ClanName]);
	cache_get_value_name_int(0, "clanrank", Account[playerid][ClanRank]);
	cache_get_value_name_int(0, "Tokens", Account[playerid][Tokens]);
	cache_get_value_name_int(0, "TokenPackages", Account[playerid][TokenPackages]);
	cache_get_value_name_int(0, "RareSkins", Account[playerid][RareSkins]);
	cache_get_value_name_int(0, "RareItems", Account[playerid][RareItems]);
	cache_get_value_name_int(0, "KDMStaffSkin", Account[playerid][hasKDMStaffSkin]);
	cache_get_value_name_int(0, "ArcherSkin", Account[playerid][hasArcherSkin]);
	cache_get_value_name_int(0, "GucciSnakeSkin", Account[playerid][hasGucciSnakeSkin]);
	cache_get_value_name_int(0, "IrishPoliceSkin", Account[playerid][hasIrishPoliceSkin]);
	cache_get_value_name_int(0, "NillySkin", Account[playerid][hasNillySkin]);
	cache_get_value_name_int(0, "Language", Account[playerid][pLanguage]);
	cache_get_value_name_float(0, "DonationAmount", Account[playerid][DonationAmount]);

	new ip[18];
	GetPlayerIp(playerid, ip, 18);
	mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE Accounts SET LatestIP = '%e' WHERE SQLID = %i", ip, Account[playerid][SQLID]));

	Account[playerid][LoggedIn] = 1;
	format(Account[playerid][Name], MAX_PLAYER_NAME + 1, GetName(playerid));
	TogglePlayerSpectating(playerid, 0);
	SpawnPlayer(playerid);
	mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE Accounts SET LoggedIn = 1 WHERE SQLID = %d", Account[playerid][SQLID]));
	printf("%s: Logged in.", Account[playerid][Name]);
	IP_Lookup(playerid);
	Account_Lookup(playerid);
	LoadUnlockedSkins(playerid);
	return 1;
}

Register(playerid)
{
	TextDrawHideForPlayer(playerid, logintd);
	Account[playerid][Skin] = 24;
	Account[playerid][LobbyWeapon] = 24;
	Account[playerid][Hitmark] = 1;
	IP_Lookup(playerid);
	TogglePlayerSpectating(playerid, 0);
	SendPlayerToLobby(playerid);
	return 1;
}

HandleAdminPin(playerid, adminlevel, pin)
{
	if(adminlevel > 0 && pin > 0)
	{
		Account[playerid][LoggedIn] = 0;
		ShowAdminPinDialog(playerid, adminlevel, pin);
	}
	if(adminlevel > 0 && pin == 0)
	{
		Account[playerid][LoggedIn] = 0;
		ShowCreateAdminPinDialog(playerid);
	}
	return 1;
}
ShowAdminPinDialog(playerid, adminlevel, correctpin)
{
	new str[128], response[e_DIALOG_RESPONSE_INFO];
	format(str, sizeof(str), "{FFFFFF}Hello, %s!\n\nYou have logged in as an Admin. {990a1e}Admin Level {FFFFFF}%i. \nPlease input your Admin Pin below.", GetName(playerid), adminlevel);
	for(;;)
	{
		AwaitAsyncDialog(playerid, response, DIALOG_STYLE_PASSWORD, "Koky's Deathmatch | Admin Pin", str, "Login", "Exit");

		if(!response[E_DIALOG_RESPONSE_Response])
		{
			SendClientMessage(playerid, COLOR_GRAY, "{bf0000}NOTICE: {FFFFFF}You have left the server.");
			KickPlayer(playerid);
			break;
		}
		extract response[E_DIALOG_RESPONSE_InputText] -> new pin; else
		{
			SendClientMessage(playerid, -1, "{bf0000}NOTICE: {FFFFFF}Invalid pin.");
			continue;
		}
		if(pin != correctpin)
		{
			SendClientMessage(playerid, -1, "{bf0000}NOTICE: {FFFFFF}Incorrect pin.");
			continue;
		}
		SendClientMessage(playerid, -1, sprintf("{bf0000}NOTICE: {FFFFFF}You have logged in as a level %i Administrator.", adminlevel));
		if(!isempty(MOTD[AdminMOTD])) SendClientMessage(playerid, 0x00FF00FF, sprintf("[A-MOTD]: %s", MOTD[AdminMOTD]));
		LoginAccount(playerid);
		break;
	}
	return 1;
}
ShowCreateAdminPinDialog(playerid)
{
	new response[e_DIALOG_RESPONSE_INFO];
	for(;;)
	{
		AwaitAsyncDialog(playerid, response, DIALOG_STYLE_PASSWORD, "{FF0000}Password Change", "You have logged in as an Admin and have not yet set your Admin Pin.\n{FF0000}Your pin MUST be {990a1e}4{FF0000} digits long.", "Submit", "");

		if(!response[E_DIALOG_RESPONSE_Response]) continue;
		extract response[E_DIALOG_RESPONSE_InputText] -> new pin; else
		{
			SendClientMessage(playerid, -1, "{bf0000}NOTICE: {FFFFFF}Invalid pin.");
			continue;
		}
		if(pin <= 999 || pin > 9999)
		{
			SendClientMessage(playerid, -1, "{bf0000}NOTICE: {FFFFFF}Pin must be 4 digits long.");
			continue;
		}

		Account[playerid][AdminPin] = pin;
		SendClientMessage(playerid, COLOR_GRAY, "{bf0000}NOTICE: {FFFFFF}You have set your Admin Pin. If you wish to change it, please contact a higher staff member.");
		mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE Accounts SET AdminPin = %i WHERE Username = '%e' LIMIT 1", pin, GetName(playerid)));
		LoginAccount(playerid);
		break;
	}
	return true;
}

//commands
CMD:changepassword(cmdid, playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GRAY, "USAGE: /changepassword [New Password]");
	if(strlen(params) < 5) SendClientMessage(playerid, COLOR_GRAY, "{bf0000}NOTICE: {FFFFFF}Your password must be more than five characters long.");

	bcrypt_hash(params, BCRYPT_COST, "OnNewPasswordHashed", "i", playerid);
	SendClientMessage(playerid, COLOR_LGREEN, "{bf0000}NOTICE: {FFFFFF}You have successfully changed your password, keep it safe.");
	return true;
}

CMD:togglehud(cmdid, playerid, params[])
{
	if(!HudShow[playerid])
	{
		ShowSessionStats(playerid);
		ShowNetworkTDs(playerid);
		HudShow[playerid] = true;
		SendClientMessage(playerid, COLOR_GREEN, "HUD enabled.");
	}
	else
	{
		HideSessionStats(playerid);
		HideNetworkTDs(playerid);
		HudShow[playerid] = false;
		SendClientMessage(playerid, COLOR_RED, "HUD disabled.");
	}
	return true;
}