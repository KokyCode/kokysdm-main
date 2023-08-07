// COPCHASE VARIABLES

#define MAX_COPCHASE_PLAYERS		20
#define MAX_COPCHASE_ZONES    		1
#define COPCHASE_WORLD				405

#define COPCHASE_GAME_TIME			600
#define COPCHASE_START_TIMER		40
new copchaseStatus = 0;
new copchaseTimer = 10;

new copSkins[] =
{
	280, 281, 266, 267, 265
};

new Float:copchasePositions[MAX_COPCHASE_ZONES][9][4] =  // FIRST POSITION MUST BE ALWAYS THE CRIMINAL
{
	// Groove Street
	{
		{2455.2205,-1656.7487,13.1989,90.0}, // Criminal
		{2486.5740,-1672.9653,13.2300,90.0},
		{2496.3921,-1673.4076,13.2335,90.0},
		{2485.7041,-1668.1790,13.2341,90.0},
		{2497.9111,-1668.4453,13.2387,90.0},
		{2487.8169,-1662.4998,13.2303,90.0},
		{2497.6453,-1662.5811,13.2403,90.0},
		{2486.5847,-1656.9200,13.2409,90.0},
		{2498.2781,-1657.1626,13.2717,90.0}
	}
};

new copchaseVehicles[9];
new copchaseCriminalVehicle;
new Ytimer[MAX_COPCHASE_PLAYERS] = 0;
//new copchaseStaticVehicles[5];

new copchaseCriminalVehicles[] = 
{
	445, 458, 467, 475
};

SendCopchaseMessage(const text[])
{
	foreach(new p : Player)
	{
		if(Account[p][pCopchase])
		{
			SendClientMessage(p, COLOR_WHITE, sprintf("{31AEAA}Copchase:{FFFFFF} %s", text));
		}
	}
	return 1;
}

GiveScoreToWinner(team, score)
{
	foreach(new p : Player)
		if(Account[p][pCopchase] == team)
			SetPlayerScore(p, GetPlayerScore(p)+score);
	
	return 1;
}

SendCopchaseGlobalMessage(const text[])
{
	foreach(new p : Player)
	{
		if(GetPlayerVirtualWorld(p) != 0 && !Account[p][pCopchase]) continue;
		
		SendClientMessage(p, COLOR_WHITE, sprintf("{33AA33}COPCHASE:{FFFFFF} %s", text));
	}

	return 1;
}

SendPoliceRadioMessage(const text[])
{
	foreach(new p : Player) if(Account[p][pCopchase] == 2)
		SendClientMessage(p, COLOR_SLATEBLUE, sprintf("{31AEAA}Copchase: {6A5ACD}[Radio] Officer %s", text));

	return 1;
}

//data

GetCopchaseCriminal()
{
	if(!copchaseStatus) return -1;
	
	foreach(new p : Player)
	{
		if(Account[p][pCopchase] == 3) return p;
	}

	return -1;
}

StartCopchase(forceEnd = false)
{	
	if(copchaseStatus == 0) // LOBBY PREPARATION
	{
		copchaseStatus = 1;
		
		new place = random(MAX_COPCHASE_ZONES);
		new criminal = random(GetCopchaseTotalPlayers()), count = 1, vehCount = 0;
		criminal++;
		foreach(new p : Player)
		{
			if(Account[p][pCopchase] == 1) // if the player was in queue
			{
				ResetPlayerWeapons(p);
				GivePlayerWeapon(p, 24, 90);
				if(criminal != count) // if the player is not a criminal
				{
					Account[p][pCopchase] = 2;

					SetPlayerSkin(p, copSkins[random(sizeof(copSkins))]);
					if(vehCount < 9){
						new vehid;
						vehid = CreateVehicle(596, copchasePositions[place][vehCount+1][0], copchasePositions[place][vehCount+1][1], copchasePositions[place][vehCount+1][2], copchasePositions[place][vehCount+1][3], 0, 1, -1, 1);
						LinkVehicleToInterior(vehid, GetPlayerInterior(p));
						SetVehicleVirtualWorld(vehid, COPCHASE_WORLD);
						copchaseVehicles[vehCount] = vehid;
						PutPlayerInVehicle(p, vehid, 0);
						vehCount++;
					}else{
						PutPlayerInVehicle(p, copchaseVehicles[vehCount - 9], 1);
						vehCount++;
					}

					WC_SetPlayerHealth(p, 100);
					WC_SetPlayerArmour(p, 100);

					SetPlayerTeam(p, 2);

					SendClientMessage(p, COLOR_BLUE, "{31AEAA}Copchase:{6A5ACD} You're a cop! Chase the criminal and kill him.");
					SendClientMessage(p, COLOR_BLUE, "{31AEAA}Copchase:{6A5ACD} Use /radio [text] to communicate with your colleagues.");
					SendClientMessage(p, COLOR_BLUE, "{31AEAA}Copchase:{6A5ACD} Press Y to become visible in the map. Press it again to hide yourself from the map.");	
					GivePlayerWeapon(p, 25, 25);
				}
				else
				{
					Account[p][pCopchase] = 3;
					if(GetCopchaseTotalPlayers() > 4)
						GivePlayerWeapon(p, 31, 200);
					new vehid;
					vehid = CreateVehicle(copchaseCriminalVehicles[random(sizeof(copchaseCriminalVehicles))], copchasePositions[place][0][0], copchasePositions[place][0][1], copchasePositions[place][0][2], copchasePositions[place][0][3], 1, 0, -1, 1);
					copchaseCriminalVehicle = vehid;
					SetVehicleVirtualWorld(vehid, COPCHASE_WORLD);
					LinkVehicleToInterior(vehid, GetPlayerInterior(p));
					PutPlayerInVehicle(p, vehid, 0);
					SetPlayerTeam(p, 3);
					WC_SetPlayerHealth(p, 100);
					WC_SetPlayerArmour(p, 100);
					SendClientMessage(p, COLOR_ORANGE, "{31AEAA}Copchase:{FFA500} You're a criminal! Escape from the cops.");
					SendClientMessage(p, COLOR_ORANGE, "{31AEAA}Copchase:{FFA500} Survive for 10 minutes or kill them all to win the game.");
				}
				TogglePlayerControllable(p, 0);
				Account[p][pCopchaseVisible] = false;
			}
			count++;
		}
		SendCopchaseMessage("the game will start in 10 seconds.");
		copchaseTimer = 10;

		return 1;
	}

	if(copchaseStatus == 1) // PLAYERS ARE IN THE CARS
	{
		copchaseStatus = 2;

		foreach(new p : Player)
		{
			if(Account[p][pCopchase] == 2 || Account[p][pCopchase] == 3)
			{
				PlayerTextDrawHide(p, Account[p][TextDraw][1]);
				PlayerTextDrawHide(p, Account[p][TextDraw][0]);
				PlayerTextDrawShow(p, Account[p][TextDraw][2]);
				PlayerTextDrawShow(p, Account[p][TextDraw][3]);
				TogglePlayerControllable(p, 1);
			}

			
			foreach(new j : Player)
				if(Account[j][pCopchase])
					SetPlayerMarkerForPlayer(p, j, (GetPlayerColor(j) & 0xFFFFFF00 ));
		}

		SendCopchaseMessage("the game is started now. Run!");
		SendCopchaseMessage("created by: Angelo#8239");

		copchaseTimer = COPCHASE_GAME_TIME;
		return 1;
	}

	new bool:willEnd = true, cops, criminal;
	if(copchaseStatus == 2) // ENDING THE GAME
	{
		foreach(new p : Player)
		{
			if(Account[p][pCopchase] == 2) cops++;
			if(Account[p][pCopchase] == 3) criminal++;
		}

		if(criminal && cops) willEnd = false;

		if(willEnd || forceEnd)
		{
			for(new i = 0; i < 9; i++)
			{
				DestroyVehicle(copchaseVehicles[i]);
			}
			DestroyVehicle(copchaseCriminalVehicle);

			if(!criminal && cops){
				SendCopchaseGlobalMessage("Cops won! Every cop got +3 score.");
				GiveScoreToWinner(2, 3);
			}
			else if(criminal && !cops){
				SendCopchaseGlobalMessage("Criminal killed every cop and won +10 score!");
				GiveScoreToWinner(3, 10);
			}
			else if(!criminal && !cops){
				SendCopchaseGlobalMessage("No one won.");
			}

			if(criminal && cops){
				SendCopchaseGlobalMessage("Criminal won +20 score! Time is over.");
				GiveScoreToWinner(3, 20);
			}

			foreach(new p : Player)
			{
				if(Account[p][pCopchase])
				{
					Account[p][pCopchase] = 0;
					PlayerTextDrawHide(p, Account[p][TextDraw][1]);
					PlayerTextDrawHide(p, Account[p][TextDraw][0]);
					PlayerTextDrawHide(p, Account[p][TextDraw][2]);
					PlayerTextDrawHide(p, Account[p][TextDraw][3]);
					HandleLobbyTransition(p);
					SetPlayerSkin(p, Account[p][Skin]);
				}
			}

			copchaseStatus = 0;
			copchaseTimer = COPCHASE_START_TIMER;
		}
		return 1;
	}
	return 1;
}

GetCopchaseTotalPlayers()
{
	new c = 0;
	foreach(new p : Player) if(Account[p][pCopchase]) c++;

	return c;
}

//commands
CMD:copchase(cmdid, playerid)
{
	new msg[128];

	if(Account[playerid][pCopchase] == 1 && copchaseStatus == 0){
		format(msg, sizeof(msg), "{%06x}%s{FFFFFF} left copchase. [%d/%d]", GetPlayerColor(playerid) >>> 8, GetName(playerid), GetCopchaseTotalPlayers() - 1, MAX_COPCHASE_PLAYERS);
		SendCopchaseMessage(msg);
		//Account[playerid][pCopchase] = 0;
		PlayerTextDrawHide(playerid, Account[playerid][TextDraw][1]);
		PlayerTextDrawHide(playerid, Account[playerid][TextDraw][0]);
		PlayerTextDrawHide(playerid, Account[playerid][TextDraw][2]);
		PlayerTextDrawHide(playerid, Account[playerid][TextDraw][3]);
		HandleLobbyTransition(playerid);
		return 1;
	}

	if(ActivityState[playerid] != ACTIVITY_LOBBY) 
		return SendErrorMessage(playerid, "You can't do this now. Use /lobby to return to lobby.");

	if(Account[playerid][pCopchase] == 2 || Account[playerid][pCopchase] == 3) 
		return SendErrorMessage(playerid, "You're already playing copchase.");

	if(copchaseStatus) { 
		Account[playerid][pCopchase] = 0; 
		return SendErrorMessage(playerid, "Copchase is already started."); 
	}

	if(GetCopchaseTotalPlayers() >= MAX_COPCHASE_PLAYERS) 
		return SendErrorMessage(playerid, "Copchase is full and it will start soon.");

	Account[playerid][pCopchase] = 1;
	ActivityState[playerid] = ACTIVITY_COPCHASE;
	ActivityStateID[playerid] = ACTIVITY_COPCHASE;

	if(GetCopchaseTotalPlayers() == 1){
		format(msg, sizeof(msg), "{%06x}%s{FFFFFF} started copchase! Use /copchase to join.", GetPlayerColor(playerid) >>> 8, GetName(playerid));
		SendCopchaseGlobalMessage(msg);
	} else {
		format(msg, sizeof(msg), "{%06x}%s{FFFFFF} joined copchase! [%d/%d]", GetPlayerColor(playerid) >>> 8, GetName(playerid), GetCopchaseTotalPlayers(), MAX_COPCHASE_PLAYERS);
		SendCopchaseMessage(msg);
	}
	SendClientMessage(playerid, COLOR_WHITE, "Type /copchase to quit the queue.");

	SetPlayerVirtualWorld(playerid, COPCHASE_WORLD);
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid ,copchasePositions[0][1][0], copchasePositions[0][1][1], copchasePositions[0][1][2]+1);
	return 1;
}
CMD:radio(cmdid, playerid, params[])
{
	new message[256];

	if(sscanf(params, "s[256]", message)) 
		return SendUsageMessage(playerid, "/radio [message]");

	SendPoliceRadioMessage(sprintf("{%06x}%s (%d):{FFFFFF} %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, message));

	return 1;
}

//hooks
#include <pp-hooks>
hook public OnPlayerDisconnect(playerid, reason)
{
	if(Account[playerid][pCopchase] == 2){
		new msg[128];
		format(msg, sizeof(msg), "{%06x}%s{FFFFFF} has left. [%d players remaining]", GetPlayerColor(playerid) >>> 8, GetName(playerid), GetCopchaseTotalPlayers() - 1);
		SendCopchaseMessage(msg);
		Account[playerid][pCopchase] = 0;
		StartCopchase(); // checking if game is over
	}else if(Account[playerid][pCopchase] == 3)
	{
		Account[playerid][pCopchase] = 0;
		StartCopchase(); // terminating it
	}else if(Account[playerid][pCopchase] == 1){
		new msg[128];
		Account[playerid][pCopchase] = 0;
		format(msg, sizeof(msg), "{%06x}%s{FFFFFF} has disconnected. [%d players in queue]", GetPlayerColor(playerid) >>> 8, GetName(playerid), GetCopchaseTotalPlayers() - 1);
		SendCopchaseMessage(msg);
		PlayerTextDrawHide(playerid, Account[playerid][TextDraw][1]);
		PlayerTextDrawHide(playerid, Account[playerid][TextDraw][0]);
		PlayerTextDrawHide(playerid, Account[playerid][TextDraw][2]);
		PlayerTextDrawHide(playerid, Account[playerid][TextDraw][3]);
	}
}
hook public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	// COPCHASE - PRESSING Y TO BECOME VISIBLE IN THE MAP
	if(Account[playerid][pCopchase] == 2 && PRESSED(KEY_YES) && Ytimer[playerid] == 0)
	{
		if(Account[playerid][pCopchaseVisible])
		{
			// making him invisible for other cops
			foreach(new p : Player)
				if(Account[p][pCopchase] == 2 && playerid != p)
					SetPlayerMarkerForPlayer(p, playerid, (GetPlayerColor(playerid) & 0xFFFFFF00 ));
		}else{
			// making him visible
			foreach(new p : Player)
				if(Account[p][pCopchase] == 2 && playerid != p)
					SetPlayerMarkerForPlayer(p, playerid, (0x0000FFFF));
		}
		Account[playerid][pCopchaseVisible] = !Account[playerid][pCopchaseVisible];
		SendClientMessage(playerid, COLOR_SLATEBLUE, sprintf("You're now %s in the radar. Press Y to become %s again.", (Account[playerid][pCopchaseVisible]) ? ("visible") : ("invisible"), (Account[playerid][pCopchaseVisible]) ? ("invisible") : ("visible")));
		SendPoliceRadioMessage(sprintf("{%06x}%s (%d){6A5ACD} %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, (Account[playerid][pCopchaseVisible]) ? ("is now visible in the radar!") : ("is no longer visible in the radar!")));
		Ytimer[playerid] = 5;
	}
}