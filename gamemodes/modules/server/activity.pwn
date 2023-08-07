#define ACTIVITY_LOBBY (0)
#define ACTIVITY_ARENADM (1)
#define ACTIVITY_COPCHASE (2)
#define ACTIVITY_DUEL (3)
#define ACTIVITY_TDM (4)
#define ACTIVITY_FREEROAM (5)
#define ACTIVITY_EVENT (6)
// damage in lobby fix
#define ACTIVITY_DUEL_PREP (7)

//activity tracking (in dm, in copchase, etc)
new ActivityState[MAX_PLAYERS];
new ActivityStateID[MAX_PLAYERS] = {-1, ...};

GetActivityCount(activity)
{
	new count;
	foreach(new i: Player)
	{
		if(ActivityState[i] == activity)
		{
			++count;
		}
	}
	return count;
}
ReturnActivityDescription(activity)
{
	new activitydesc[24];
	switch(activity)
	{
		case ACTIVITY_LOBBY: format(activitydesc, sizeof(activitydesc), "Lobby");
		case ACTIVITY_ARENADM: format(activitydesc, sizeof(activitydesc), "Arenas");
		case ACTIVITY_COPCHASE: format(activitydesc, sizeof(activitydesc), "Cop Chase");
		case ACTIVITY_DUEL: format(activitydesc, sizeof(activitydesc), "Duels");
		case ACTIVITY_TDM: format(activitydesc, sizeof(activitydesc), "TDM");
		case ACTIVITY_DUEL_PREP: format(activitydesc, sizeof(activitydesc), "Duels - PREP");
	}
	return activitydesc;
}