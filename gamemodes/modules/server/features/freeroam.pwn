#define		DIALOG_COLOUR     	1800

new vehNames[][] =
{
	"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
	"Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
	"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
	"Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
	"Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
	"Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
	"Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
	"Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
	"Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
	"Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
	"Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
	"Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
	"Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
	"Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
	"Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin",
	"Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
	"Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
	"Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
	"FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
	"Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
	"Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
	"Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
	"Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
	"Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
	"Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
	"Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
	"Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
	"News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Cruiser",
	"SFPD Cruiser", "LVPD Cruiser", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
	"Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
	"Tiller", "Utility Trailer"
};

enum FREEROAM_WEAPONS
{
	FRWeaponName[24],
	FRWeaponID
};
new FreeroamWeapons[][FREEROAM_WEAPONS] =
{
	{"Clear Weapons", -1},
	{"Colt 45", 22},
	{"SD Pistol", 23},
	{"Desert Eagle", 24},
	{"Shotgun", 25},
	{"Sawn-off Shotgun", 26},
	{"Combat Shotgun", 27},
	{"MAC-10", 28},
	{"MP5", 29},
	{"AK47", 30},
	{"M4", 31},
	{"TEC9", 32},
	{"Rifle", 33},
	{"Sniper Rifle", 34},
	{"RPG", 35},
	{"Heatseaker", 36},
	{"Camera", WEAPON_CAMERA}
};

new FreeroamVehicle[MAX_PLAYERS] = {-1, ...};

#include <pp-hooks>
hook public OnPlayerConnect(playerid)
{
	if(FreeroamVehicle[playerid] != -1) {
		DestroyVehicle(FreeroamVehicle[playerid]);
		FreeroamVehicle[playerid] = -1;
	}
}


hook public OnPlayerDisconnect(playerid, reason)
{
	if(FreeroamVehicle[playerid] != -1) {
		DestroyVehicle(FreeroamVehicle[playerid]);
		FreeroamVehicle[playerid] = -1;
	}
}

hook public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(ActivityState[playerid] == ACTIVITY_FREEROAM)
	{
		if(PRESSED(KEY_SUBMISSION))
			cmd_fix(9999, playerid);
		if(PRESSED(KEY_NO))
			cmd_flip(9999, playerid);
	}
}

CMD<FRM>:tune(cmdid, playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "{31AEAA}Freeroam:{FFFFFF} You must be in the driver seat of a vehicle to use this command.");

	new models[ZVEH_MAX_COMPONENTS], modelcount, vehiclemodel = GetVehicleModel(GetPlayerVehicleID(playerid));
	GetVehicleCompatibleUpgrades(vehiclemodel, models, modelcount);
	if(modelcount == 0) return SendClientMessage(playerid, COLOR_RED, "{31AEAA}Freeroam:{FFFFFF} Could not find any supported mods for this vehicle ID.");

	//ShowModelSelectionMenuEx(playerid, models, modelcount, "Select a Mod", MODEL_SELECTION_VTUNE);
	return true;
}
CMD<FRM>:wep(cmdid, playerid,params[])
{
	yield 1;
	new wepStr[1024], response[e_DIALOG_RESPONSE_INFO];
	for(new i = 0; i < sizeof(FreeroamWeapons); i++)
	{
		strcat(wepStr, sprintf("%s\n", FreeroamWeapons[i][FRWeaponName]));
	}
	AwaitAsyncDialog(playerid, response, DIALOG_STYLE_LIST, "Available Weapons", wepStr, "Select", "Cancel");

	if(!response[E_DIALOG_RESPONSE_Response]) return true;
	if(response[E_DIALOG_RESPONSE_Listitem] == 0) return ResetPlayerWeaponsEx(playerid);

	GivePlayerWeapon(playerid, FreeroamWeapons[response[E_DIALOG_RESPONSE_Listitem]][FRWeaponID], 9999);
	return 1;
}
CMD<FRM>:carcolor(cmdid, playerid, params[])
{
	for(new i; i < sizeof(ChangeColor); i++)
	{
		TextDrawSetPreviewModel(ChangeColor[i], 19349);
		TextDrawShowForPlayer(playerid,ChangeColor[i]);
	}
	SelectTextDraw(playerid, 0xFFFFFF66);
	return 1;
}
CMD<FRM>:fix(cmdid, playerid)
{
	if(!IsPlayerInAnyVehicle(playerid)) return true;

	RepairVehicle(GetPlayerVehicleID(playerid));
	return true;
}

CMD:setweather(cmdid, playerid, params[])
{
	new weather;
	if(sscanf(params,"d",weather)) return SendClientMessage(playerid, COLOR_GRAY, "USAGE: /setweather [ID]");
	if(Account[playerid][Donator] > 0 || Account[playerid][WeatherAccess] > 0)
	{
		SetPlayerWeather(playerid, weather);
	}
	else
	{
		SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Freeroam:{FFFFFF} You aren't a Donator or haven't won Weather Access in the Premium Crates.");
	}
	return 1;
}
CMD:settime(cmdid, playerid, params[])
{
	if(Account[playerid][TimeAccess] <= 0 && ActivityState[playerid] != ACTIVITY_FREEROAM) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Freeroam:{FFFFFF} You must be in freeroam to use this command.");

	SetPlayerTime(playerid, strval(params), 0);
	return 1;
}
CMD<FRM>:god(cmdid, playerid, params[])
{
	Account[playerid][PreventDamage] = !Account[playerid][PreventDamage];
	SendClientMessage(playerid, COLOR_GRAY, sprintf("{31AEAA}Freeroam:{FFFFFF} Godmode %s. Use /god to disable it.", Account[playerid][PreventDamage] ? "enabled" : "disabled"));
	return true;
}
CMD<FRM>:veh(cmdid, playerid, params[])
{
	new vehicleid[20], color1, color2, State = GetPlayerState(playerid);
	if(GetPlayerVirtualWorld(playerid) < 2) return SendErrorMessage(playerid, "You cannot spawn a vehicle in this virutal world.");
	if(State == PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "You are currently driving a vehicle.");
	if(sscanf(params, "s[20]D(-1)D(-1)", vehicleid, color1, color2)) return SendClientMessage(playerid, COLOR_GRAY, "USAGE: /veh [modelid] [color1 optional] [color2 optional]");
	new vID = FindVehicleByNameID(vehicleid);
	if(vID == INVALID_VEHICLE_ID)
	{
		vID = strval(vehicleid);
		if(!(399 < vID < 612)) return SendErrorMessage(playerid, ERROR_OPTION);
	}
	new Float: curX, Float: curY, Float: curZ, Float: curR;

	if(FreeroamVehicle[playerid] != -1) {
		DestroyVehicle(FreeroamVehicle[playerid]);
		FreeroamVehicle[playerid] = -1;
	}
	GetPlayerPos(playerid, curX, curY, curZ);
	GetPlayerFacingAngle(playerid, curR);
	FreeroamVehicle[playerid] = CreateVehicle(vID, curX+1, curY+1, curZ, curR, color1, color2, -1);
	LinkVehicleToInterior(FreeroamVehicle[playerid], GetPlayerInterior(playerid));
	SetVehicleVirtualWorld(FreeroamVehicle[playerid], GetPlayerVirtualWorld(playerid));

	PutPlayerInVehicle(playerid, FreeroamVehicle[playerid], 0);
	SetVehicleNumberPlate(FreeroamVehicle[playerid], "Koky's DM");
	SetVehicleParamsEx(FreeroamVehicle[playerid], 1, 1, 0, 0, 0, 0, 0);
	SendClientMessage(playerid, 0xFF0000FF, sprintf("You have successfully spawned a %s.", vehNames[vID-400]));
	return 1;
}
CMD<FRM>:world(cmdid, playerid, params[])
{
	extract params -> new worldid; else return SendClientMessage(playerid, COLOR_GRAY, "USAGE: /world [1 - 999]");
	if(worldid < 1 || worldid > 999) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Freeroam:{FFFFFF} This world is restricted.");

	SetPlayerVirtualWorld(playerid, worldid);
	Account[playerid][FreeroamVW] = worldid;
	SendClientMessage(playerid, -1, sprintf("{31AEAA}Freeroam:{FFFFFF} You have set your virtual world to %d.", worldid));
	return 1;
}
CMD<FRM>:color(cmdid, playerid, params[])
{
	if(isnull(params))
	{
		new string[1024], colorname[24];
		strcat(string, "RANDOM\n");
		for(new i = 0; i < sizeof(pColorData); i++)
		{
			format(colorname, sizeof(colorname), pColorData[i][pColorName]);
			for(new c = 0; c < strlen(colorname); c++) colorname[c] = toupper(colorname[c]);
			strcat(string, sprintf("%s%s\n", pColorData[i][pEmbedColor], colorname));
		}
		ShowPlayerDialog(playerid, DIALOG_COLOUR, DIALOG_STYLE_LIST, "Available colours", string, "Set", "Cancel");
		return true;
	}

	new bool:colorfound;
	if(!strcmp(params, "random", true))
	{
		SetPlayerColor(playerid, PlayerColors[random(sizeof(PlayerColors))]);
		colorfound = true;
	}
	else
	{
		for(new i = 0; i < sizeof(pColorData); i++)
		{
			if(!strcmp(pColorData[i][pColorName], params, true))
			{
				SetPlayerColor(playerid, pColorData[i][pColor]);
				colorfound = true;
				break;
			}
		}
	}
	if(!colorfound) SendClientMessage(playerid, COLOR_GRAY, "Type /colour to open a list of predefined colours OR type /colour <colour> for instant effect (see list).");
	return 1;
}
CMD<FRM>:goto(cmdid, playerid, params[])
{
	extract params -> new player:target; else return SendClientMessage(playerid, COLOR_GRAY, "USAGE: /goto [id]");
	if(!IsPlayerConnected(target)) return SendErrorMessage(playerid, ERROR_OPTION);
	if(ActivityState[target] != ACTIVITY_FREEROAM) return SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Freeroam:{FFFFFF} That player is not in freeroam.");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(target, x, y, z);
	if(IsPlayerInAnyVehicle(playerid)) SetVehiclePos(GetPlayerVehicleID(playerid), x + 1.0, y + 1.0, z + 1.0);
	else SetPlayerPos(playerid, x + 0.5, y + 0.5, z);

	SendClientMessage(playerid, COLOR_INDIANRED, sprintf("{31AEAA}Freeroam:{FFFFFF} You have teleported to %s.", GetName(target)));
	SendClientMessage(target, COLOR_INDIANRED, sprintf("{31AEAA}Freeroam:{FFFFFF} Player %s has teleported to your position.", GetName(playerid)));
	return 1;
}
CMD<FRM>:health(cmdid, playerid, params[])
{
	SetPlayerHealth(playerid, 100);
	SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Freeroam:{FFFFFF} Your health has been restored to 100.");
	return 1;
}
ALT:armor = CMD:armour;
CMD<FRM>:armour(cmdid, playerid, params[])
{
	SetPlayerArmour(playerid, 100);
	SendClientMessage(playerid, COLOR_GRAY, "{31AEAA}Freeroam:{FFFFFF} Your armour has been restored to 100.");
	return 1;
}