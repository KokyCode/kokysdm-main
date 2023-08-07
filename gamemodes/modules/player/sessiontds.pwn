//global textdraws for the session stats box
new Text:SessionBox = Text:INVALID_TEXT_DRAW;
new Text:SessionHeader = Text:INVALID_TEXT_DRAW;
new Text:SessionText = Text:INVALID_TEXT_DRAW;
new Text:SessionKills = Text:INVALID_TEXT_DRAW;
new Text:SessionDeaths = Text:INVALID_TEXT_DRAW;
new Text:SessionRatio = Text:INVALID_TEXT_DRAW;

new CurrentSessionKills[MAX_PLAYERS];
new CurrentSessionDeaths[MAX_PLAYERS];

//per player textdraws for the session stats box
new PlayerText:PlayerSessionKills[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
new PlayerText:PlayerSessionDeaths[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
new PlayerText:PlayerSessionRatio[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};

Float:GetSessionKDRatio(playerid)
{
    new deaths = CurrentSessionDeaths[playerid], kills = CurrentSessionKills[playerid];
    deaths = (deaths == 0) ? (1) : (deaths);

    return (Float:kills / Float:deaths);
}
ShowSessionStats(playerid)
{
	PlayerTextDrawShow(playerid, PlayerSessionKills[playerid]);
	PlayerTextDrawShow(playerid, PlayerSessionDeaths[playerid]);
	PlayerTextDrawShow(playerid, PlayerSessionRatio[playerid]);
	TextDrawShowForPlayer(playerid, SessionText);
	TextDrawShowForPlayer(playerid, SessionKills);
	TextDrawShowForPlayer(playerid, SessionDeaths);
	TextDrawShowForPlayer(playerid, SessionRatio);
	TextDrawShowForPlayer(playerid, SessionHeader);
	TextDrawShowForPlayer(playerid, SessionBox);
	return true;
}
HideSessionStats(playerid)
{
	PlayerTextDrawHide(playerid, PlayerSessionKills[playerid]);
	PlayerTextDrawHide(playerid, PlayerSessionDeaths[playerid]);
	PlayerTextDrawHide(playerid, PlayerSessionRatio[playerid]);
	TextDrawHideForPlayer(playerid, SessionText);
	TextDrawHideForPlayer(playerid, SessionKills);
	TextDrawHideForPlayer(playerid, SessionDeaths);
	TextDrawHideForPlayer(playerid, SessionRatio);
	TextDrawHideForPlayer(playerid, SessionHeader);
	TextDrawHideForPlayer(playerid, SessionBox);
	return true;
}
CreateSessionStats(playerid)
{
	PlayerSessionRatio[playerid] = CreatePlayerTextDraw(playerid, 598.000000, 264.000000, "0.0");
	PlayerTextDrawAlignment(playerid, PlayerSessionRatio[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerSessionRatio[playerid], 255);
	PlayerTextDrawFont(playerid, PlayerSessionRatio[playerid], 1);
	PlayerTextDrawLetterSize(playerid, PlayerSessionRatio[playerid], 0.300000, 1.799999);
	PlayerTextDrawColor(playerid, PlayerSessionRatio[playerid], -1);
	PlayerTextDrawSetOutline(playerid, PlayerSessionRatio[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PlayerSessionRatio[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerSessionRatio[playerid], 0);

	PlayerSessionDeaths[playerid] = CreatePlayerTextDraw(playerid, 570.000000, 264.000000, "0");
	PlayerTextDrawAlignment(playerid, PlayerSessionDeaths[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerSessionDeaths[playerid], 255);
	PlayerTextDrawFont(playerid, PlayerSessionDeaths[playerid], 1);
	PlayerTextDrawLetterSize(playerid, PlayerSessionDeaths[playerid], 0.330000, 1.799999);
	PlayerTextDrawColor(playerid, PlayerSessionDeaths[playerid], -1);
	PlayerTextDrawSetOutline(playerid, PlayerSessionDeaths[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PlayerSessionDeaths[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerSessionDeaths[playerid], 0);

	PlayerSessionKills[playerid] = CreatePlayerTextDraw(playerid, 544.000000, 264.000000, "0");
	PlayerTextDrawAlignment(playerid, PlayerSessionKills[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, PlayerSessionKills[playerid], 255);
	PlayerTextDrawFont(playerid, PlayerSessionKills[playerid], 1);
	PlayerTextDrawLetterSize(playerid, PlayerSessionKills[playerid], 0.330000, 1.799999);
	PlayerTextDrawColor(playerid, PlayerSessionKills[playerid], -1);
	PlayerTextDrawSetOutline(playerid, PlayerSessionKills[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PlayerSessionKills[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerSessionKills[playerid], 0);
}
UpdateKDs(playerid, killerid)
{
    ++CurrentSessionKills[killerid];
    ++CurrentSessionDeaths[playerid];

    PlayerTextDrawSetString(killerid, PlayerSessionKills[killerid], sprintf("%i", CurrentSessionKills[killerid]));
    PlayerTextDrawSetString(playerid, PlayerSessionDeaths[playerid], sprintf("%i", CurrentSessionDeaths[playerid]));

    PlayerTextDrawSetString(killerid, PlayerSessionRatio[killerid], sprintf("%.1f", GetSessionKDRatio(killerid)));
    PlayerTextDrawSetString(playerid, PlayerSessionRatio[playerid], sprintf("%.1f", GetSessionKDRatio(playerid)));

    return true;
}
CreateSessionBox()
{
	SessionBox = TextDrawCreate(531.000000, 239.000000, "                                                  ");
	TextDrawBackgroundColor(SessionBox, 510);
	TextDrawFont(SessionBox, 1);
	TextDrawLetterSize(SessionBox, 0.800000, 0.800000);
	TextDrawColor(SessionBox, -1);
	TextDrawSetOutline(SessionBox, 0);
	TextDrawSetProportional(SessionBox, 1);
	TextDrawSetShadow(SessionBox, 1);
	TextDrawUseBox(SessionBox, 1);
	TextDrawBoxColor(SessionBox, 80);
	TextDrawTextSize(SessionBox, 614.000000, 11.000000);
	TextDrawSetSelectable(SessionBox, 0);

	SessionHeader = TextDrawCreate(531.000000, 239.000000, "                                                  ");
	TextDrawBackgroundColor(SessionHeader, 510);
	TextDrawFont(SessionHeader, 1);
	TextDrawLetterSize(SessionHeader, 0.800000, 0.100000);
	TextDrawColor(SessionHeader, -1);
	TextDrawSetOutline(SessionHeader, 0);
	TextDrawSetProportional(SessionHeader, 1);
	TextDrawSetShadow(SessionHeader, 1);
	TextDrawUseBox(SessionHeader, 1);
	TextDrawBoxColor(SessionHeader, 80);
	TextDrawTextSize(SessionHeader, 614.000000, 11.000000);
	TextDrawSetSelectable(SessionHeader, 0);

	SessionText = TextDrawCreate(572.000000, 238.000000, "SESSION STATS");
	TextDrawAlignment(SessionText, 2);
	TextDrawBackgroundColor(SessionText, 255);
	TextDrawFont(SessionText, 2);
	TextDrawLetterSize(SessionText, 0.170000, 0.899999);
	TextDrawColor(SessionText, -1);
	TextDrawSetOutline(SessionText, 0);
	TextDrawSetProportional(SessionText, 1);
	TextDrawSetShadow(SessionText, 1);
	TextDrawSetSelectable(SessionText, 0);

	SessionKills = TextDrawCreate(544.000000, 252.000000, "KILLS");
	TextDrawAlignment(SessionKills, 2);
	TextDrawBackgroundColor(SessionKills, 255);
	TextDrawFont(SessionKills, 2);
	TextDrawLetterSize(SessionKills, 0.150000, 0.799998);
	TextDrawColor(SessionKills, -16776961);
	TextDrawSetOutline(SessionKills, 0);
	TextDrawSetProportional(SessionKills, 1);
	TextDrawSetShadow(SessionKills, 0);
	TextDrawSetSelectable(SessionKills, 0);

	SessionDeaths = TextDrawCreate(571.000000, 252.000000, "DEATHS");
	TextDrawAlignment(SessionDeaths, 2);
	TextDrawBackgroundColor(SessionDeaths, 255);
	TextDrawFont(SessionDeaths, 2);
	TextDrawLetterSize(SessionDeaths, 0.150000, 0.799997);
	TextDrawColor(SessionDeaths, -16776961);
	TextDrawSetOutline(SessionDeaths, 0);
	TextDrawSetProportional(SessionDeaths, 1);
	TextDrawSetShadow(SessionDeaths, 0);
	TextDrawSetSelectable(SessionDeaths, 0);

	SessionRatio = TextDrawCreate(599.000000, 252.000000, "RATIO");
	TextDrawAlignment(SessionRatio, 2);
	TextDrawBackgroundColor(SessionRatio, 255);
	TextDrawFont(SessionRatio, 2);
	TextDrawLetterSize(SessionRatio, 0.150000, 0.799997);
	TextDrawColor(SessionRatio, -16776961);
	TextDrawSetOutline(SessionRatio, 0);
	TextDrawSetProportional(SessionRatio, 1);
	TextDrawSetShadow(SessionRatio, 0);
	TextDrawSetSelectable(SessionRatio, 0);
	return true;
}