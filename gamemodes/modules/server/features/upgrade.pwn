#define		DIALOG_VIPCOLOUR    1802

ShowUpgrades(playerid)
{
	new str[1200];
    format(str, sizeof(str), "%s{F19F05}Bronze Packages:{91F105} %i\n", str, Account[playerid][BronzePackages]);
	format(str, sizeof(str), "%s{F19F05}Silver Packages:{91F105} %i\n", str, Account[playerid][SilverPackages]);
	format(str, sizeof(str), "%s{F19F05}Gold Packages:{91F105} %i\n", str, Account[playerid][GoldPackages]);
	format(str, sizeof(str), "%s{F19F05}Diamond Packages:{91F105} %i\n", str, Account[playerid][DiamondPackages]);
	format(str, sizeof(str), "%s{F19F05}Namechange Packages:{91F105} %i\n", str, Account[playerid][NameChangePackages]);
	format(str, sizeof(str), "%s{F19F05}Premium Key Packages:{91F105} %i\n", str, Account[playerid][PremiumKeyPackages]);
	format(str, sizeof(str), "%s{F19F05}Skin Pack Packages:{91F105} %i\n", str, Account[playerid][SkinPackUnlock]);
	format(str, sizeof(str), "%s{F19F05}KDM Tokens{91F105} %i\n", str, Account[playerid][TokenPackages]);

	Dialog_Show(playerid, UpgradeDialog, DIALOG_STYLE_LIST, "My Upgrades", str, "Select", "Cancel");
}
ShowUseDonations(playerid)
{
	new str[1200];
    format(str, sizeof(str), "%s{F19F05}Bronze Package(31 days){91F105} EURO 1.50\n", str, Account[playerid][BronzePackages]);
	format(str, sizeof(str), "%s{F19F05}Silver Packages(31 days){91F105} EURO 2.50\n", str, Account[playerid][SilverPackages]);
	format(str, sizeof(str), "%s{F19F05}Gold Packages(31 days){91F105} EURO 5.00\n", str, Account[playerid][GoldPackages]);
	format(str, sizeof(str), "%s{F19F05}Diamond Packages(31 days){91F105} EURO 10.00\n", str, Account[playerid][DiamondPackages]);
	format(str, sizeof(str), "%s{F19F05}Namechange Packages(x2){91F105} EURO 2.00\n", str, Account[playerid][NameChangePackages]);
	format(str, sizeof(str), "%s{F19F05}Premium Keys(x8){91F105} EURO 2.50\n", str, Account[playerid][PremiumKeyPackages]);
	format(str, sizeof(str), "%s{F19F05}Skin Pack Packages(x1){91F105} EURO 2.00\n", str, Account[playerid][SkinPackUnlock]);
	format(str, sizeof(str), "%s{F19F05}100K Cash{91F105} EURO 1.00\n", str, Account[playerid][TokenPackages]);
	format(str, sizeof(str), "%s{F19F05}KDM Token(x1){91F105} EURO 5.00\n", str, Account[playerid][TokenPackages]);

	SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("Notice: You have EURO %.2f to spend. Please select the correct option as refunds are not available.", Account[playerid][DonationAmount]));

	Dialog_Show(playerid, USEMYDONATIONS, DIALOG_STYLE_LIST, "UseDonations", str, "Select", "Cancel");
}
Dialog:USEMYDONATIONS(playerid, response, listitem, inputtext[])
{
	if(!response) return 0;
	await mysql_aquery_s(SQL_CONNECTION, str_format("SELECT * FROM Accounts WHERE Username = '%e' LIMIT 1", GetName(playerid)));
	cache_get_value_name_float(0, "DonationAmount", Account[playerid][DonationAmount]);
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				if(Account[playerid][DonationAmount] >= 1.50)
				{
					Account[playerid][BronzePackages]++;
					Account[playerid][DonationAmount] = floatsub(Account[playerid][DonationAmount], 1.50);
					UpdateDonationAmount(playerid);

					SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("Notice: {ffffff}You have purchased a Bronze Package, use /upgrades to activate it. (You have EURO %.2f left.)", Account[playerid][DonationAmount]));
					return 1;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Error: You don't have enough money. You can donate via www.kokysdm.net/donate.");
			}
			case 1:
			{
				if(Account[playerid][DonationAmount] >= 2.50)
				{
					Account[playerid][SilverPackages]++;
					Account[playerid][DonationAmount] = floatsub(Account[playerid][DonationAmount], 2.50);
					UpdateDonationAmount(playerid);

					SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("Notice: {ffffff}You have purchased a Silver Package, use /upgrades to activate it. (You have EURO %.2f left.)", Account[playerid][DonationAmount]));
					return 1;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Error: You don't have enough money. You can donate via www.kokysdm.net/donate.");
			}
			case 2:
			{
				if(Account[playerid][DonationAmount] >= 5.00)
				{
					Account[playerid][GoldPackages]++;
					Account[playerid][DonationAmount] = floatsub(Account[playerid][DonationAmount], 5.00);
					UpdateDonationAmount(playerid);

					SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("Notice: {ffffff}You have purchased a Gold Package, use /upgrades to activate it. (You have EURO %.2f left.)", Account[playerid][DonationAmount]));
					return 1;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Error: You don't have enough money. You can donate via www.kokysdm.net/donate.");
			}
			case 3:
			{
				if(Account[playerid][DonationAmount] >= 10.00)
				{
					Account[playerid][DiamondPackages]++;
					Account[playerid][DonationAmount] = floatsub(Account[playerid][DonationAmount], 10.00);
					UpdateDonationAmount(playerid);

					SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("Notice: {ffffff}You have purchased a Diamond Package, use /upgrades to activate it. (You have EURO %.2f left.)", Account[playerid][DonationAmount]));
					return 1;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Error: You don't have enough money. You can donate via www.kokysdm.net/donate.");
			}
			case 4:
			{
				if(Account[playerid][DonationAmount] >= 2.00)
				{
					Account[playerid][NameChanges]++;
					Account[playerid][DonationAmount] = floatsub(Account[playerid][DonationAmount], 2.00);
					UpdateDonationAmount(playerid);

					SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("Notice: {ffffff}You have purchased a Name Change Package, use /upgrades to activate it. (You have EURO %.2f left.)", Account[playerid][DonationAmount]));
					return 1;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Error: You don't have enough money. You can donate via www.kokysdm.net/donate.");
			}
			case 5:
			{
				if(Account[playerid][DonationAmount] >= 2.50)
				{
					Account[playerid][PremiumKeyPackages]++;
					Account[playerid][DonationAmount] = floatsub(Account[playerid][DonationAmount], 2.50);
					UpdateDonationAmount(playerid);

					SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("Notice: {ffffff}You have purchased a Premium Key Package, use /upgrades to activate it. (You have EURO %.2f left.)", Account[playerid][DonationAmount]));
					return 1;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Error: You don't have enough money. You can donate via www.kokysdm.net/donate.");
			}
			case 6:
			{
				if(Account[playerid][DonationAmount] >= 2.00)
				{
					Account[playerid][SkinPackUnlock]++;
					Account[playerid][DonationAmount] = floatsub(Account[playerid][DonationAmount], 2.00);
					UpdateDonationAmount(playerid);

					SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("Notice: {ffffff}You have purchased a Skin Pack Unlocker, use /upgrades to activate it. (You have EURO %.2f left.)", Account[playerid][DonationAmount]));
					return 1;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Error: You don't have enough money. You can donate via www.kokysdm.net/donate.");
			}
			case 7:
			{
				if(Account[playerid][DonationAmount] >= 1.00)
				{
					GivePlayerMoneyEx(playerid, 100000);
					Account[playerid][DonationAmount] = floatsub(Account[playerid][DonationAmount], 1.00);
					UpdateDonationAmount(playerid);
					SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("Notice: {ffffff}You have purchased $100,000 cash, it has been activated. (You have EURO %.2f left.)", Account[playerid][DonationAmount]));
					return 1;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Error: You don't have enough money. You can donate via www.kokysdm.net/donate.");
			}
			case 8:
			{
				if(Account[playerid][DonationAmount] >= 5.00)
				{
					Account[playerid][TokenPackages] = Account[playerid][TokenPackages] + 1;
					Account[playerid][DonationAmount] = floatsub(Account[playerid][DonationAmount], 5.00);
					UpdateDonationAmount(playerid);
					SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("Notice: {ffffff}You have purchased a KDM Token, use /upgrades to activate it. (You have EURO %.2f left.)", Account[playerid][DonationAmount]));
					return 1;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Error: You don't have enough money. You can donate via www.kokysdm.net/donate.");
			}
		}
	}
	return true;
}
CMD:usedonations(cmdid, playerid, params[])
{
	ShowUseDonations(playerid);
	return true;
}
UpdateDonationAmount(playerid)
{
	mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `DonationAmount` = %d WHERE `SQLID` = %d", Account[playerid][DonationAmount], Account[playerid][SQLID]));
	return true;
}
ShowDonatorControlPanel(playerid)
{
	new str[600];

	format(str, sizeof(str), "%s{F19F05}Donator Rank: %s\n", str, DonatorRank(playerid));
	format(str, sizeof(str), "%s{F19F05}Lobby Weapon: {91F105}%s\n", str, WeaponNameList[Account[playerid][LobbyWeapon]]);
	format(str, sizeof(str), "%s{F19F05}Color: {%06x}%s\n", str, GetPlayerColor(playerid) >>> 8, GetName(playerid));
	format(str, sizeof(str), "%s{F19F05}Donator Skins\n", str);
	format(str, sizeof(str), "%s{F19F05}Jet Pack\n", str);

	Dialog_Show(playerid, DCP, DIALOG_STYLE_LIST, "Donator Control Panel", str, "Select", "Cancel");
}
Dialog:DCP(playerid, response, listitem, inputtext[])
{
	new string[1024], colorname[24];
	if(!response) return 0;
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				ShowDonatorControlPanel(playerid);
			}
			case 1:
			{
				if(Account[playerid][Donator] >= 3)
				{
					Dialog_Show(playerid, DCPWEP, DIALOG_STYLE_LIST, "Select a Weapon", "Desert Eagle\nM4\nAK-47\nColt-45\nTec-9\nSniper Rifle\nRifle", "Select", "Cancel");
				}
				else return SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You need to be Gold donator or above to use this feature.");
			}
			case 2:
			{
				if(Account[playerid][Donator] > 3)
				{
					for(new i = 0; i < sizeof(pColorData); i++)
					{
						format(colorname, sizeof(colorname), pColorData[i][pColorName]);
						for(new c = 0; c < strlen(colorname); c++) colorname[c] = toupper(colorname[c]);
						strcat(string, sprintf("%s%s\n", pColorData[i][pEmbedColor], colorname));
					}
					ShowPlayerDialog(playerid, DIALOG_VIPCOLOUR, DIALOG_STYLE_LIST, "Available colours", string, "Set", "Cancel");
				}
				else return SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You need to be Diamond donator to use this feature.");
			}
			case 3:
			{
				MSelect_Open(playerid, MSelect:skins, {20022, 20023, 20024, 20050, 20051, 20052, 20147}, 7, .header = "Donator skin list");
			}
			case 4:
			{
				if(Account[playerid][Donator] > 3)
				{
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
				}
				else return SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You need to be Diamond donator to use this feature.");
			}
		}
	}
	return 1;
}
Dialog:DCPWEP(playerid, response, listitem, inputtext[])
{
	if(!response) ShowDonatorControlPanel(playerid);
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				Account[playerid][LobbyWeapon] = 24;
				ResetPlayerWeaponsEx(playerid);
				GivePlayerWeapon(playerid, Account[playerid][LobbyWeapon], 9999);
			}
			case 1:
			{
				Account[playerid][LobbyWeapon] = 31;
				ResetPlayerWeaponsEx(playerid);
				GivePlayerWeapon(playerid, Account[playerid][LobbyWeapon], 9999);
			}
			case 2:
			{
				Account[playerid][LobbyWeapon] = 30;
				ResetPlayerWeaponsEx(playerid);
				GivePlayerWeapon(playerid, Account[playerid][LobbyWeapon], 9999);
			}
			case 3:
			{
				Account[playerid][LobbyWeapon] = 22;
				ResetPlayerWeaponsEx(playerid);
				GivePlayerWeapon(playerid, Account[playerid][LobbyWeapon], 9999);
			}
			case 4:
			{
				Account[playerid][LobbyWeapon] = 32;
				ResetPlayerWeaponsEx(playerid);
				GivePlayerWeapon(playerid, Account[playerid][LobbyWeapon], 9999);
			}
			case 5:
			{
				Account[playerid][LobbyWeapon] = 34;
				ResetPlayerWeaponsEx(playerid);
				GivePlayerWeapon(playerid, Account[playerid][LobbyWeapon], 9999);
			}
			case 6:
			{
				Account[playerid][LobbyWeapon] = 33;
				ResetPlayerWeaponsEx(playerid);
				GivePlayerWeapon(playerid, Account[playerid][LobbyWeapon], 9999);
			}
		}
	}
	return 1;
}
ShowUpgradeOptions(playerid)
{
	Dialog_Show(playerid, UpgradeOptions, DIALOG_STYLE_LIST, "My Upgrades", "Gift\nActivate", "Select", "Cancel");
}
Dialog:UpgradeDialog(playerid, response, listitem, inputtext[])
{
	if(!response) return 0;
	if(response)
	{
		Account[playerid][UpgradeDialogStage] = listitem;
		ShowUpgradeOptions(playerid);
	}
	return 1;
}

Dialog:UpgradeOptions(playerid, response, listitem, inputtext[])
{
	if(!response) ShowUpgrades(playerid);
	if(response)
	{
		if(listitem == 0)
		{
			switch(Account[playerid][UpgradeDialogStage])
			{
				case 0:
				{
					if(Account[playerid][BronzePackages] > 0)
					{
						Dialog_Show(playerid, BronzeGift, DIALOG_STYLE_INPUT, "Bronze Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.", "Gift", "Cancel");
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Bronze VIP Packages, you can purchase them via the forums. (/upgrade)");
				}
				case 1:
				{
					if(Account[playerid][SilverPackages] > 0)
					{
						Dialog_Show(playerid, SilverGift, DIALOG_STYLE_INPUT, "Silver Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.", "Gift", "Cancel");
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Silver VIP Packages, you can purchase them via the forums. (/upgrade)");
				}
				case 2:
				{
					if(Account[playerid][GoldPackages] > 0)
					{
						Dialog_Show(playerid, GoldGift, DIALOG_STYLE_INPUT, "Diamond Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.", "Gift", "Cancel");
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Gold VIP Packages, you can purchase them via the forums. (/upgrade)");
				}
				case 3:
				{
					if(Account[playerid][DiamondPackages] > 0)
					{
						Dialog_Show(playerid, DiamondGift, DIALOG_STYLE_INPUT, "Diamond Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.", "Gift", "Cancel");
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Diamond VIP Packages, you can purchase them via the forums. (/upgrade)");
				}
				case 4:
				{
					if(Account[playerid][NameChangePackages] > 0)
					{
						Dialog_Show(playerid, NameChangeGift, DIALOG_STYLE_INPUT, "Name Change Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.", "Gift", "Cancel");
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Name Change Packages, you can purchase them via the forums. (/upgrade)");
				}
				case 5:
				{
					if(Account[playerid][PremiumKeyPackages] > 0)
					{
						Dialog_Show(playerid, PremiumKeyGift, DIALOG_STYLE_INPUT, "Premium Key Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.", "Gift", "Cancel");
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Premium Key Packages, you can purchase them via the forums. (/upgrade)");
				}
				case 6:
				{
					if(Account[playerid][SkinPackUnlock] > 0)
					{
						Dialog_Show(playerid, SkinPackGift, DIALOG_STYLE_INPUT, "Skin Pack Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.", "Gift", "Cancel");
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Skin Pack Packages, you can purchase them via the forums. (/upgrade)");
				}
				case 7:
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You cannot gift KDM Tokens.");
				}
			}
		}
		if(listitem == 1)
		{
			switch(Account[playerid][UpgradeDialogStage])
			{
				case 0:
				{
					if(Account[playerid][BronzePackages] > 0)
					{
						Account[playerid][BronzePackages]--;
						ActivateUpgrades(playerid, 0);
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Bronze VIP Packages, you can purchase them via the forums. (/upgrade)");
				}
				case 1:
				{
					if(Account[playerid][SilverPackages] > 0)
					{
						Account[playerid][SilverPackages]--;
						ActivateUpgrades(playerid, 1);
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Silver VIP Packages, you can purchase them via the forums. (/upgrade)");
				}
				case 2:
				{
					if(Account[playerid][GoldPackages] > 0)
					{
						Account[playerid][GoldPackages]--;
						ActivateUpgrades(playerid, 2);
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Gold VIP Packages, you can purchase them via the forums. (/upgrade)");
				}
				case 3:
				{
					if(Account[playerid][DiamondPackages] > 0)
					{
						Account[playerid][DiamondPackages]--;
						ActivateUpgrades(playerid, 3);
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Diamond VIP Packages, you can purchase them via the forums. (/upgrade)");
				}
				case 4:
				{
					if(Account[playerid][NameChangePackages] > 0)
					{
						Account[playerid][NameChangePackages]--;
						ActivateUpgrades(playerid, 4);
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Name Change Packages, you can purchase them via the forums. (/upgrade)");
				}
				case 5:
				{
					if(Account[playerid][PremiumKeyPackages] > 0)
					{
						Account[playerid][PremiumKeyPackages]--;
						ActivateUpgrades(playerid, 5);
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Premium Key Packages, you can purchase them via the forums. (/upgrade)");
				}
				case 6:
				{
					if(Account[playerid][SkinPackUnlock] > 0)
					{
						Dialog_Show(playerid, SkinUnlock, DIALOG_STYLE_LIST, "Select a Year", SKINROLL_MONTHS, "Select", "Cancel");
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Skin Pack Packages, you can purchase them via the forums. (/upgrade)");
				}
				case 7:
				{
					if(Account[playerid][TokenPackages] > 0)
					{
						Account[playerid][TokenPackages]--;
						ActivateUpgrades(playerid, 7);
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You don't have any Skin Pack Packages, you can purchase them via the forums. (/upgrade)");
				}
			}
		}
	}
	return 1;
}
Dialog:BronzeGift(playerid, response, listitem, inputtext[])
{
	new str[128];
	if(!response)
	{
		Account[playerid][UpgradeDialogStage] = 1;
		ShowUpgrades(playerid);
	}
	if(response)
	{
		new invitee;
		if(sscanf(inputtext, "u", invitee)) return Dialog_Show(playerid, BronzeGift, DIALOG_STYLE_INPUT, "Bronze Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}NOTE:{FFFFFF}Please input the correct ID/Username.", "Gift", "Cancel");
		if(invitee == playerid) return Dialog_Show(playerid, BronzeGift, DIALOG_STYLE_INPUT, "Bronze Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}ERROR:{FFFFFF}You cannot gift yourself VIP, you must activate it yourself!", "Gift", "Cancel");
		if(invitee == INVALID_PLAYER_ID || !IsPlayerConnected(invitee)) Dialog_Show(playerid, BronzeGift, DIALOG_STYLE_INPUT, "Bronze Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}ERROR:{FFFFFF}This player is not connected!", "Gift", "Cancel");
		if(IsPlayerConnected(invitee) && Account[invitee][LoggedIn] == 1)
		{
			format(str, sizeof(str), "[ $ ] {%06x}%s {FFFFFF}has gifted you Bronze VIP! Use {AF0808}/upgrades{FFFFFF} to activate it.", GetPlayerColor(playerid) >>> 8, GetName(playerid));
			SendClientMessage(invitee, COLOR_LIGHTRED, str);
			format(str, sizeof(str), "[ $ ] {FFFFFF}You have gifted {%06x}%s {FFFFFF}Bronze VIP! This is not reversible.", GetPlayerColor(invitee) >>> 8, GetName(invitee));
			SendClientMessage(playerid, COLOR_LIGHTRED, str);
			Account[playerid][BronzePackages]--;
			Account[invitee][BronzePackages]++;
			UpdateUpgrades(playerid, invitee, 0);
		}
	}
	return 1;
}
Dialog:SilverGift(playerid, response, listitem, inputtext[])
{
	new str[128];
	if(!response)
	{
		ShowUpgrades(playerid);
		Account[playerid][UpgradeDialogStage] = 1;
	}
	if(response)
	{
		new invitee;
		if(sscanf(inputtext, "u", invitee)) return Dialog_Show(playerid, SilverGift, DIALOG_STYLE_INPUT, "Silver Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}NOTE:{FFFFFF}Please input the correct ID/Username.", "Gift", "Cancel");
		if(invitee == playerid) return Dialog_Show(playerid, SilverGift, DIALOG_STYLE_INPUT, "Silver Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}ERROR:{FFFFFF}You cannot gift yourself VIP, you must activate it yourself!", "Gift", "Cancel");
		if(invitee == INVALID_PLAYER_ID || !IsPlayerConnected(invitee)) Dialog_Show(playerid, SilverGift, DIALOG_STYLE_INPUT, "Silver Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}ERROR:{FFFFFF}This player is not connected!", "Gift", "Cancel");
		if(IsPlayerConnected(invitee) && Account[invitee][LoggedIn] == 1)
		{
			format(str, sizeof(str), "[ $ ] {%06x}%s {FFFFFF}has gifted you Silver VIP! Use {AF0808}/upgrades{FFFFFF} to activate it.", GetPlayerColor(playerid) >>> 8, GetName(playerid));
			SendClientMessage(invitee, COLOR_LIGHTRED, str);
			format(str, sizeof(str), "[ $ ] {FFFFFF}You have gifted {%06x}%s {FFFFFF}Silver VIP! This is not reversible.", GetPlayerColor(invitee) >>> 8, GetName(invitee));
			SendClientMessage(playerid, COLOR_LIGHTRED, str);
			Account[playerid][SilverPackages]--;
			Account[invitee][SilverPackages]++;
			UpdateUpgrades(playerid, invitee, 1);
		}
	}
	return 1;
}
Dialog:GoldGift(playerid, response, listitem, inputtext[])
{
	new str[128];
	if(!response)
	{
		ShowUpgrades(playerid);
		Account[playerid][UpgradeDialogStage] = 1;
	}
	if(response)
	{
		new invitee;
		if(sscanf(inputtext, "u", invitee)) return Dialog_Show(playerid, GoldGift, DIALOG_STYLE_INPUT, "Gold Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}NOTE:{FFFFFF}Please input the correct ID/Username.", "Gift", "Cancel");
		if(invitee == playerid) return Dialog_Show(playerid, GoldGift, DIALOG_STYLE_INPUT, "Gold Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}ERROR:{FFFFFF}You cannot gift yourself VIP, you must activate it yourself!", "Gift", "Cancel");
		if(invitee == INVALID_PLAYER_ID || !IsPlayerConnected(invitee)) Dialog_Show(playerid, GoldGift, DIALOG_STYLE_INPUT, "Gold Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}ERROR:{FFFFFF}This player is not connected!", "Gift", "Cancel");
		if(IsPlayerConnected(invitee) && Account[invitee][LoggedIn] == 1)
		{
			format(str, sizeof(str), "[ $ ] {%06x}%s {FFFFFF}has gifted you Gold VIP! Use {AF0808}/upgrades{FFFFFF} to activate it.", GetPlayerColor(playerid) >>> 8, GetName(playerid));
			SendClientMessage(invitee, COLOR_LIGHTRED, str);
			format(str, sizeof(str), "[ $ ] {FFFFFF}You have gifted {%06x}%s {FFFFFF}Gold VIP! This is not reversible.", GetPlayerColor(invitee) >>> 8, GetName(invitee));
			SendClientMessage(playerid, COLOR_LIGHTRED, str);
			Account[playerid][GoldPackages]--;
			Account[invitee][GoldPackages]++;
			UpdateUpgrades(playerid, invitee, 2);
		}
	}
	return 1;
}
Dialog:DiamondGift(playerid, response, listitem, inputtext[])
{
	new str[128];
	if(!response)
	{
		ShowUpgrades(playerid);
		Account[playerid][UpgradeDialogStage] = 1;
	}
	if(response)
	{
		new invitee;
		if(sscanf(inputtext, "u", invitee)) return Dialog_Show(playerid, DiamondGift, DIALOG_STYLE_INPUT, "Diamond Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}NOTE:{FFFFFF}Please input the correct ID/Username.", "Gift", "Cancel");
		if(invitee == playerid) return Dialog_Show(playerid, DiamondGift, DIALOG_STYLE_INPUT, "Diamond Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}ERROR:{FFFFFF}You cannot gift yourself VIP, you must activate it yourself!", "Gift", "Cancel");
		if(invitee == INVALID_PLAYER_ID || !IsPlayerConnected(invitee)) Dialog_Show(playerid, DiamondGift, DIALOG_STYLE_INPUT, "Diamond Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}ERROR:{FFFFFF}This player is not connected!", "Gift", "Cancel");
		if(IsPlayerConnected(invitee) && Account[invitee][LoggedIn] == 1)
		{
			format(str, sizeof(str), "[ $ ] {%06x}%s {FFFFFF}has gifted you Diamond VIP! Use {AF0808}/upgrades{FFFFFF} to activate it.", GetPlayerColor(playerid) >>> 8, GetName(playerid));
			SendClientMessage(invitee, COLOR_LIGHTRED, str);
			format(str, sizeof(str), "[ $ ] {FFFFFF}You have gifted {%06x}%s {FFFFFF}Diamond VIP! This is not reversible.", GetPlayerColor(invitee) >>> 8, GetName(invitee));
			SendClientMessage(playerid, COLOR_LIGHTRED, str);
			Account[playerid][DiamondPackages]--;
			Account[invitee][DiamondPackages]++;
			UpdateUpgrades(playerid, invitee, 3);
		}
	}
	return 1;
}
Dialog:NameChangeGift(playerid, response, listitem, inputtext[])
{
	new str[128];
	if(!response)
	{
		ShowUpgrades(playerid);
		Account[playerid][UpgradeDialogStage] = 1;
	}
	if(response)
	{
		new invitee;
		if(sscanf(inputtext, "u", invitee)) return Dialog_Show(playerid, NameChangeGift, DIALOG_STYLE_INPUT, "Name Change Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}NOTE:{FFFFFF}Please input the correct ID/Username.", "Gift", "Cancel");
		if(invitee == playerid) return Dialog_Show(playerid, NameChangeGift, DIALOG_STYLE_INPUT, "Name Change Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}ERROR:{FFFFFF}You cannot gift yourself VIP, you must activate it yourself!", "Gift", "Cancel");
		if(invitee == INVALID_PLAYER_ID || !IsPlayerConnected(invitee)) Dialog_Show(playerid, NameChangeGift, DIALOG_STYLE_INPUT, "Name Change Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}ERROR:{FFFFFF}This player is not connected!", "Gift", "Cancel");
		if(IsPlayerConnected(invitee) && Account[invitee][LoggedIn] == 1)
		{
			format(str, sizeof(str), "[ $ ] {%06x}%s {FFFFFF}has gifted you Name Changes! Use {AF0808}/upgrades{FFFFFF} to activate it.", GetPlayerColor(playerid) >>> 8, GetName(playerid));
			SendClientMessage(invitee, COLOR_LIGHTRED, str);
			format(str, sizeof(str), "[ $ ] {FFFFFF}You have gifted {%06x}%s {FFFFFF}Name Changes! This is not reversible.", GetPlayerColor(invitee) >>> 8, GetName(invitee));
			SendClientMessage(playerid, COLOR_LIGHTRED, str);
			Account[playerid][NameChangePackages]--;
			Account[invitee][NameChangePackages]++;
			UpdateUpgrades(playerid, invitee, 4);
		}
	}
	return 1;
}
Dialog:PremiumKeyGift(playerid, response, listitem, inputtext[])
{
	new str[128];
	if(!response)
	{
		ShowUpgrades(playerid);
		Account[playerid][UpgradeDialogStage] = 1;
	}
	if(response)
	{
		new invitee;
		if(sscanf(inputtext, "u", invitee)) return Dialog_Show(playerid, PremiumKeyGift, DIALOG_STYLE_INPUT, "Premium Key Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}NOTE:{FFFFFF}Please input the correct ID/Username.", "Gift", "Cancel");
		if(invitee == playerid) return Dialog_Show(playerid, PremiumKeyGift, DIALOG_STYLE_INPUT, "Premium Key Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}ERROR:{FFFFFF}You cannot gift yourself VIP, you must activate it yourself!", "Gift", "Cancel");
		if(invitee == INVALID_PLAYER_ID || !IsPlayerConnected(invitee)) Dialog_Show(playerid, PremiumKeyGift, DIALOG_STYLE_INPUT, "Premium Key Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}ERROR:{FFFFFF}This player is not connected!", "Gift", "Cancel");
		if(IsPlayerConnected(invitee) && Account[invitee][LoggedIn] == 1)
		{
			format(str, sizeof(str), "[ $ ] {%06x}%s {FFFFFF}has gifted you Premium Keys! Use {AF0808}/upgrades{FFFFFF} to activate it.", GetPlayerColor(playerid) >>> 8, GetName(playerid));
			SendClientMessage(invitee, COLOR_LIGHTRED, str);
			format(str, sizeof(str), "[ $ ] {FFFFFF}You have gifted {%06x}%s {FFFFFF}Premium Keys! This is not reversible.", GetPlayerColor(invitee) >>> 8, GetName(invitee));
			SendClientMessage(playerid, COLOR_LIGHTRED, str);
			Account[playerid][PremiumKeyPackages]--;
			Account[invitee][PremiumKeyPackages]++;
			UpdateUpgrades(playerid, invitee, 5);
		}
	}
	return 1;
}
Dialog:SkinPackGift(playerid, response, listitem, inputtext[])
{
	new str[128];
	if(!response)
	{
		Account[playerid][UpgradeDialogStage] = 1;
		ShowUpgrades(playerid);
	}
	if(response)
	{
		new invitee;
		if(sscanf(inputtext, "u", invitee)) return Dialog_Show(playerid, SkinPackGift, DIALOG_STYLE_INPUT, "Skin Pack Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}NOTE:{FFFFFF}Please input the correct ID/Username.", "Gift", "Cancel");
		if(invitee == playerid) return Dialog_Show(playerid, SkinPackGift, DIALOG_STYLE_INPUT, "Skin Pack Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}ERROR:{FFFFFF}You cannot gift yourself VIP, you must activate it yourself!", "Gift", "Cancel");
		if(invitee == INVALID_PLAYER_ID || !IsPlayerConnected(invitee)) Dialog_Show(playerid, SkinPackGift, DIALOG_STYLE_INPUT, "Skin Pack Gift", "Please input the players username or ID!\n{DD0B0B}NOTE:{FFFFFF}This is not reversible.\n{DD0B0B}ERROR:{FFFFFF}This player is not connected!", "Gift", "Cancel");
		if(IsPlayerConnected(invitee) && Account[invitee][LoggedIn] == 1)
		{
			format(str, sizeof(str), "[ $ ] {%06x}%s {FFFFFF}has gifted you a Skin Pack Unlock! Use {AF0808}/upgrades{FFFFFF} to activate it.", GetPlayerColor(playerid) >>> 8, GetName(playerid));
			SendClientMessage(invitee, COLOR_LIGHTRED, str);
			format(str, sizeof(str), "[ $ ] {FFFFFF}You have gifted {%06x}%s {FFFFFF}a Skin Pack Unlock! This is not reversible.", GetPlayerColor(invitee) >>> 8, GetName(invitee));
			SendClientMessage(playerid, COLOR_LIGHTRED, str);
			Account[playerid][SkinPackUnlock]--;
			Account[invitee][SkinPackUnlock]++;
			UpdateUpgrades(playerid, invitee, 6);
		}
	}
	return 1;
}
forward ActivateUpgrades(playerid, type);
public ActivateUpgrades(playerid, type)
{
	new str[128], Float:x, Float:y, Float:z;
	switch(type)
	{
		case 0:
		{
			Account[playerid][DonatorActive] = gettime();
			Account[playerid][DonatorExpired] = Account[playerid][DonatorActive] + 2678400;

			Account[playerid][Donator] = type + 1;
			Account[playerid][PlayerKeys] = Account[playerid][PlayerKeys] + 3;


			GivePlayerMoneyEx(playerid, 35000);
			UpdateKeyText(playerid);
			UpdateUpgrades(playerid, playerid, type);

			GetPlayerPos(playerid, x, y, z);
			
			PlayerPlaySound(playerid, 1054, 0, 0, 0);
			SetPlayerChatBubble(playerid, "{d0b6e3}* Just activated {F17705}Bronze VIP{d0b6e3}!", -1, 75.00, 10000);
			SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You have just activated your{F17705} Bronze VIP{FFFFFF} for 31 days!");
		}
		case 1:
		{
			Account[playerid][DonatorActive] = gettime();
			Account[playerid][DonatorExpired] = Account[playerid][DonatorActive] + 2678400;

			Account[playerid][Donator] = type + 1;
			Account[playerid][PlayerKeys] = Account[playerid][PlayerKeys] + 6;
			Account[playerid][PlayerEvents] = Account[playerid][PlayerEvents] + 2;
			Account[playerid][WeatherAccess] = 1;
			Account[playerid][TimeAccess] = 1;

			GivePlayerMoneyEx(playerid, 65000);
			UpdateKeyText(playerid);
			UpdateUpgrades(playerid, playerid, type);

			GetPlayerPos(playerid, x, y, z);
			
			PlayerPlaySound(playerid, 1054, 0, 0, 0);
			SetPlayerChatBubble(playerid, "{d0b6e3}* Just activated {C4BFBE}Silver VIP{d0b6e3}!", -1, 75.00, 10000);
			SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You have just activated your{C4BFBE} Silver VIP{FFFFFF} for 31 days!");
		}
		case 2:
		{
			Account[playerid][DonatorActive] = gettime();
			Account[playerid][DonatorExpired] = Account[playerid][DonatorActive] + 2678400;

			Account[playerid][Donator] = type + 1;
			Account[playerid][PlayerKeys] = Account[playerid][PlayerKeys] + 10;
			Account[playerid][PlayerEvents] = Account[playerid][PlayerEvents] + 5;
			Account[playerid][NameChanges]++;
			Account[playerid][WeatherAccess] = 1;
			Account[playerid][TimeAccess] = 1;

			GivePlayerMoneyEx(playerid, 100000);
			UpdateKeyText(playerid);
			UpdateUpgrades(playerid, playerid, type);

			GetPlayerPos(playerid, x, y, z);
			
			PlayerPlaySound(playerid, 1054, 0, 0, 0);
			SetPlayerChatBubble(playerid, "{d0b6e3}* Just activated {C59F03}Gold VIP{d0b6e3}!", -1, 75.00, 10000);
			SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You have just activated your{C59F03} Gold VIP{FFFFFF} for 31 days!");
		}
		case 3:
		{
			Account[playerid][DonatorActive] = gettime();
			Account[playerid][DonatorExpired] = Account[playerid][DonatorActive] + 2678400;

			Account[playerid][Donator] = type + 1;
			Account[playerid][PlayerKeys] = Account[playerid][PlayerKeys] + 25;
			Account[playerid][PlayerEvents] = Account[playerid][PlayerEvents] + 10;
			Account[playerid][NameChanges] = Account[playerid][NameChanges] + 2;
			Account[playerid][PremiumKeyPackages]++;
			Account[playerid][SkinPackUnlock]++;
			Account[playerid][WeatherAccess] = 1;
			Account[playerid][TimeAccess] = 1;

			GivePlayerMoneyEx(playerid, 500000);
			UpdateKeyText(playerid);
			UpdateUpgrades(playerid, playerid, type);

			GetPlayerPos(playerid, x, y, z);
			
			PlayerPlaySound(playerid, 1054, 0, 0, 0);
			SetPlayerChatBubble(playerid, "{d0b6e3}* Just activated {08D6E3}Diamond VIP{d0b6e3}!", -1, 75.00, 10000);
			SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You have just activated your{08D6E3} Diamond VIP{FFFFFF} for 31 days!");
		}
		case 4:
		{
			Account[playerid][NameChanges] = Account[playerid][NameChanges] + 2;
			UpdateUpgrades(playerid, playerid, type);
			format(str, sizeof(str), "{31AEAA}Upgrades: {FFFFFF}You have activated your Name Changes, you now have %i.", Account[playerid][NameChanges]);
			SendClientMessage(playerid, COLOR_LIGHTRED, str);

			PlayerPlaySound(playerid, 1054, 0, 0, 0);
		}
		case 5:
		{
			Account[playerid][PlayerKeys] = Account[playerid][PlayerKeys] + 8;
			UpdateUpgrades(playerid, playerid, type);
			UpdateKeyText(playerid);
			format(str, sizeof(str), "{31AEAA}Upgrades: {FFFFFF}You have activated your Premium Keys, you now have %i.", Account[playerid][PlayerKeys]);
			SendClientMessage(playerid, COLOR_LIGHTRED, str);

			PlayerPlaySound(playerid, 1054, 0, 0, 0);
		}
		case 7:
		{
			Account[playerid][Tokens]++;
			format(str, sizeof(str), "{31AEAA}Upgrades: {FFFFFF}You have activated your KDM Tokens, you now have %i tokens.", Account[playerid][Tokens]);
			SendClientMessage(playerid, COLOR_LIGHTRED, str);

			UpdateUpgrades(playerid, playerid, type);
		}
	}
	return 1;
}
Dialog:SkinUnlock(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	for(new i = 0; i < sizeof(ServerSkinData); i++)
	{
		if(!strcmp(ServerSkinData[i][sSkinMonth], inputtext, false))
		{
			UnlockSkinForPlayer(playerid, i);
		}
	}
	PlayerPlaySound(playerid, 1054, 0, 0, 0);
	UpdateUpgrades(playerid, playerid, 6);
	Account[playerid][SkinPackUnlock]--;
	SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("{31AEAA}Upgrades: {FFFFFF}You have unlocked all skins in %s! (/customskins > %s)", inputtext, inputtext));
	return true;
}
forward UpdateUpgrades(playerid, invitee, type);
public UpdateUpgrades(playerid, invitee, type)
{
	if(playerid != invitee)
	{
		switch(type)
		{
			case 0: //bronze vip
			{
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `BronzePackages` = %d WHERE `SQLID` = %d", Account[playerid][BronzePackages], Account[playerid][SQLID]));
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `BronzePackages` = %d WHERE `SQLID` = %d", Account[invitee][BronzePackages], Account[invitee][SQLID]));
			}
			case 1: //silver vip
			{
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `SilverPackages` = %d WHERE `SQLID` = %d", Account[playerid][SilverPackages], Account[playerid][SQLID]));
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `SilverPackages` = %d WHERE `SQLID` = %d", Account[invitee][SilverPackages], Account[invitee][SQLID]));
			}
			case 2:
			{
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `GoldPackages` = %d WHERE `SQLID` = %d", Account[playerid][GoldPackages], Account[playerid][SQLID]));
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `GoldPackages` = %d WHERE `SQLID` = %d", Account[invitee][GoldPackages], Account[invitee][SQLID]));
			}
			case 3:
			{
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `DiamondPackages` = %d WHERE `SQLID` = %d", Account[playerid][DiamondPackages], Account[playerid][SQLID]));
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `DiamondPackages` = %d WHERE `SQLID` = %d", Account[invitee][DiamondPackages], Account[invitee][SQLID]));
			}
			case 4:
			{
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `NameChangePackages` = %d WHERE `SQLID` = %d", Account[playerid][NameChangePackages], Account[playerid][SQLID]));
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `NameChangePackages` = %d WHERE `SQLID` = %d", Account[invitee][NameChangePackages], Account[invitee][SQLID]));
			}
			case 5:
			{
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `PremiumKeyPackages` = %d WHERE `SQLID` = %d", Account[playerid][PremiumKeyPackages], Account[playerid][SQLID]));
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `PremiumKeyPackages` = %d WHERE `SQLID` = %d", Account[invitee][PremiumKeyPackages], Account[invitee][SQLID]));
			}
			case 6:
			{
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `SkinPackUnlock` = %d WHERE `SQLID` = %d", Account[playerid][SkinPackUnlock], Account[playerid][SQLID]));
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `SkinPackUnlock` = %d WHERE `SQLID` = %d", Account[invitee][SkinPackUnlock], Account[invitee][SQLID]));
			}
			case 7:
			{
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `TokenPackages` = %d WHERE `SQLID` = %d", Account[playerid][TokenPackages], Account[playerid][SQLID]));
				mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `TokenPackages` = %d WHERE `SQLID` = %d", Account[invitee][TokenPackages], Account[invitee][SQLID]));
			}
		}
	}
	if(playerid == invitee)
	{
		switch(type)
		{
			case 0: mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `BronzePackages` = %d WHERE `SQLID` = %d", Account[playerid][BronzePackages], Account[playerid][SQLID]));
			case 1: mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `SilverPackages` = %d WHERE `SQLID` = %d", Account[playerid][SilverPackages], Account[playerid][SQLID]));
			case 2: mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `GoldPackages` = %d WHERE `SQLID` = %d", Account[playerid][GoldPackages], Account[playerid][SQLID]));
			case 3: mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `DiamondPackages` = %d WHERE `SQLID` = %d", Account[playerid][DiamondPackages], Account[playerid][SQLID]));
			case 4: mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `NameChangePackages` = %d WHERE `SQLID` = %d", Account[playerid][NameChangePackages], Account[playerid][SQLID]));
			case 5: mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `PremiumKeyPackages` = %d WHERE `SQLID` = %d", Account[playerid][PremiumKeyPackages], Account[playerid][SQLID]));
			case 6: mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `SkinPackUnlock` = %d WHERE `SQLID` = %d", Account[playerid][SkinPackUnlock], Account[playerid][SQLID]));
			case 7: mysql_pquery_s(SQL_CONNECTION, str_format("UPDATE `Accounts` SET `TokenPackages` = %d WHERE `SQLID` = %d", Account[playerid][TokenPackages], Account[playerid][SQLID]));
		}
	}
	return 1;
}
CheckUpgrade(playerid)
{
	if(gettime() > Account[playerid][DonatorExpired] && Account[playerid][Donator] > 0)
	{
		Account[playerid][Donator] = 0;
		Account[playerid][DonatorActive] = 0;
		Account[playerid][DonatorExpired] = 0;
		SetPlayerSkinEx(playerid, 5);
		SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}Your donator rank has expired. Thank you for contributing to the server, if you wish to re-upgrade your account visit the forums.");
		TogglePlayerControllable(playerid, 1);
	}
	return 1;
}
CMD:upgrades(cmdid, playerid, params[])
{
	Account[playerid][UpgradeDialogStage] = -1;
	ShowUpgrades(playerid);
	return 1;
}
CMD:dcp(cmdid, playerid, params[])
{
	if(Account[playerid][Donator] > 0)
	{
		if(IsPlayerInLobby(playerid))
		{
			ShowDonatorControlPanel(playerid);
		}
		else return SendClientMessage(playerid, -1, "{bf0000}Notice: You must be in the lobby in order to use this command!");
	}
	else return SendClientMessage(playerid, COLOR_LIGHTRED, "{31AEAA}Upgrades: {FFFFFF}You must be a donator to use this command. Please refer to /upgrade if you wish to upgrade your account");
	return 1;
}