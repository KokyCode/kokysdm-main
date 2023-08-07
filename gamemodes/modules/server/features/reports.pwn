#define REPORTS "610780079521529856"

//data
new reportstr[1024];

enum _:REPORT_DATA
{
	ReportingPlayer,
	ReportedPlayer,
	ReportReason[128]
};

new Pool:Reports;

//hooks
#include <pp-hooks>
hook public OnPlayerDisconnect(playerid, reason)
{
	if(pool_valid(Reports))
	{
		new Iter:i = pool_iter(Reports);
		while(iter_inside(i))
		{
			if(iter_get(i, ReportedPlayer) == playerid) iter_erase(i);
			else iter_move_next(i);
		}
	}
}

//commands
CMD:report(cmdid, playerid, params[])
{
	new target = -1, info[200];
	if(sscanf(params, "us[200]", target, info)) return SendClientMessage(playerid, COLOR_GRAY, "{bf0000}Reports:{FFFFFF}  /report [playerid] [reason]");
	//if(playerid == target) return SendClientMessage(playerid, COLOR_GREY, "{bf0000}Reports:{FFFFFF}  You cannot report yourself!");
	if(!IsPlayerConnected(target)) return SendClientMessage(playerid, COLOR_GREY, "{bf0000}Reports:{FFFFFF}  This player is not conneted therefor you cannot report them!");
	if(HasReportedPlayer(playerid, target)) return SendClientMessage(playerid, COLOR_GREY, "{bf0000}Reports:{FFFFFF}  You must use /cancelreport [playerid] before making a new report on this player!");
	new reportid = SubmitReport(playerid, target, info);
	SendAdmcmdMessage(1, sprintf("{bf0000}[%i] Report from: [%s (%i)] | Report on: [%s (%i)] | Reason:[%s] (/reports)", reportid, GetName(playerid), playerid, GetName(target), target, info));

	DCC_SendChannelMessage(DCC_FindChannelByName("in-game-reports"), sprintf("[REPORT: %d] **%s [%d]** reported **%s [%d]**, reason: %s", reportid, GetName(playerid), playerid, GetName(target), target, info));
	SendClientMessage(playerid, COLOR_GREY, sprintf("{1E90FF}|-{dadada} Report has been sent to all online staff! Please wait for a response. /cancelreport [player] to cancel {1E90FF}-|"));
	return true;
}
CMD:cancelreport(cmdid, playerid, params[])
{
	if(!pool_valid(Reports)) return SendClientMessage(playerid, COLOR_GRAY, "{bf0000}Reports:{FFFFFF}  There are currently no reports.");

	new target = -1;
	if(sscanf(params, "u", target)) return SendClientMessage(playerid, COLOR_GRAY, "{bf0000}Reports:{FFFFFF}  /cancelreport [playerid/name]");
	if(!IsPlayerConnected(target)) return SendClientMessage(playerid, COLOR_GREY, "{bf0000}Reports:{FFFFFF}  This player is not conneted therefor you cannot report them!");

	new report[REPORT_DATA];
	for_pool(i: Reports)
	{
		iter_get_arr(i, report);
		if(report[ReportedPlayer] == target && report[ReportingPlayer] == playerid)
		{
			iter_erase(i);
			SendClientMessage(playerid, COLOR_GREY, sprintf("{1E90FF}|-{dadada} You have cancelled your report on %s (%i). {1E90FF}-|", GetName(target), target));
			return true;
		}
	}
	SendClientMessage(playerid, COLOR_GREY, sprintf("{bf0000}Reports:{FFFFFF} Could not find a report by you against %s.", GetName(target)));
	return true;
}
CMD<AD1>:reports(cmdid, playerid, params[])
{
	ShowReportDialog(playerid);
	return true;
}
CMD<AD1>:handlereport(cmdid, playerid, params[])
{
	if(!pool_valid(Reports)) return SendClientMessage(playerid, COLOR_GRAY, "{bf0000}Reports:{FFFFFF}  There are currently no reports.");

	extract params -> new reportindex; else return SendClientMessage(playerid, COLOR_GRAY, "{bf0000}Reports:{FFFFFF}  /handlereport [report ID from /reports]");
	if(!pool_has(Reports, reportindex)) return SendErrorMessage(playerid, "Invalid report ID.");

	new report[REPORT_DATA];
	pool_get_arr(Reports, reportindex, report);
	new reporter = report[ReportingPlayer], target = report[ReportedPlayer];

	pool_remove(Reports, reportindex);
	if (GetPlayerAdminHidden(playerid))
		SendClientMessage(reporter, COLOR_LIGHTRED, sprintf("{bf0000}Reports:{FFFFFF} An admin is now looking into your report on %s (%i). They will contact you if any further information is required.", GetName(target), target));
	else
		SendClientMessage(reporter, COLOR_LIGHTRED, sprintf("{bf0000}Reports:{FFFFFF} Admin %s is now looking into your report on %s (%i). They will contact you if any further information is required.", GetName(playerid), GetName(target), target));
	SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("{bf0000}Reports:{FFFFFF} You are now handling report %i.", reportindex));
	SendAdmcmdMessage(1, sprintf("{bf0000}Reports: %s {808080}is handling report %i.", GetName(playerid), reportindex));
	DCC_SendChannelMessage(DCC_FindChannelByName("in-game-reports"), sprintf("**Reports:** %s is handling report %i by %s.", GetName(playerid), reportindex, GetName(reporter)));
	return true;
}
ALT:hr = CMD:handlereport;
ALT:ar = CMD:handlereport;

CMD<AD1>:denyreport(cmdid, playerid, params[])
{
	if(!pool_valid(Reports)) return SendClientMessage(playerid, COLOR_GRAY, "{bf0000}Reports:{FFFFFF}  There are currently no reports.");

	new id;
	if(sscanf(params, "is[128]", id)) return SendClientMessage(playerid, COLOR_GRAY, "{bf0000}Reports:{FFFFFF}  /denyreport [report ID from /reports]");
	if(!pool_has(Reports, id)) return SendErrorMessage(playerid, "Invalid report ID.");

	new report[REPORT_DATA];
	pool_get_arr(Reports, id, report);
	new reporter = report[ReportingPlayer], target = report[ReportedPlayer];

	pool_remove(Reports, id);
	if (GetPlayerAdminHidden(playerid))
		SendClientMessage(reporter, COLOR_LIGHTRED, sprintf("{bf0000}Reports:{FFFFFF} An admin has denied your report on %s (%i)!", GetName(target), target));
	else 
		SendClientMessage(reporter, COLOR_LIGHTRED, sprintf("{bf0000}Reports:{FFFFFF} Admin %s has denied your report on %s (%i)!", GetName(playerid), GetName(target), target));
	SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("{bf0000}Reports:{FFFFFF} You have denied report %", id));
	SendAdmcmdMessage(1, sprintf("{bf0000}Reports:{FFFFFF} %s has denied report %i", GetName(playerid), id));
	DCC_SendChannelMessage(DCC_FindChannelByName("in-game-reports"), sprintf("**Reports:** %s has denied report %i", GetName(playerid), id));
	return true;
}
ALT:dr = CMD:denyreport;

CMD<AD1>:clearreports(cmdid, playerid, params[])
{	
	if(!pool_valid(Reports)) return SendClientMessage(playerid, COLOR_GRAY, "{bf0000}Reports:{FFFFFF}  There are currently no reports.");

	SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("{bf0000}Reports:{FFFFFF} You have cleared %i pending report%s.", pool_size(Reports), pool_size(Reports) == 1 ? "" : "s"));
	SendAdmcmdMessage(1, sprintf("%s has cleared %i report%s.", GetName(playerid), pool_size(Reports), pool_size(Reports) == 1 ? "" : "s"));
	pool_delete(Reports);
	return true;
}

//functions
HasReportedPlayer(playerid, target)
{
	if(!pool_valid(Reports)) return false;

	new report[REPORT_DATA];
	for_pool(i: Reports)
	{
		iter_get_arr(i, report);
		if(report[ReportingPlayer] == playerid && report[ReportedPlayer] == target)
		{
			return true;
		}
	}
	return false;
}

ShowReportDialog(playerid)
{
	if(!pool_valid(Reports) || !pool_size(Reports)) return SendErrorMessage(playerid, "There are currently no reports.");

	reportstr[0] = EOS;

	new report[REPORT_DATA];
	strcat(reportstr, "Report ID\tReporter\tReported\n");
	new tmpString[16];
	new count = 0;
	for_pool(i: Reports)
	{
		iter_get_arr(i, report);
		format(tmpString, sizeof(tmpString), "ReportID_%i", count);
		SetPVarInt(playerid, tmpString, iter_get_key(i));
		count ++;

		strcat(reportstr, sprintf("%i\t%s\t%s\n", iter_get_key(i), GetName(report[ReportingPlayer]), GetName(report[ReportedPlayer])));
	}
	Dialog_Show(playerid, ReportList, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Active Reports - %i", pool_size(Reports)), reportstr, "Select", "Cancel");
	return true;
}
SubmitReport(playerid, target, const reason[])
{
	if(!pool_valid(Reports)) {
		Reports = pool_new();
		pool_set_ordered(Reports, true);
	}

	new report[REPORT_DATA];
	report[ReportingPlayer] = playerid;
	report[ReportedPlayer] = target;
	format(report[ReportReason], 128, reason);

	return pool_add_arr(Reports, report);
}

//dialogs
Dialog:ReportList(playerid, response, listitem, inputtext[])
{
	if(!response) {
		new tmpString[16];
		new count = 0;
		for_pool(i: Reports) {
			count ++;
			format(tmpString, sizeof(tmpString), "ReportID_%i",  count);
			DeletePVar(playerid, tmpString);
		}
		return true;
	}

	new tmpString[16];
	format(tmpString, sizeof(tmpString), "ReportID_%i", listitem);
	new id = GetPVarInt(playerid, tmpString);

	new report[REPORT_DATA];
	pool_get_arr(Reports, id, report);
	format(reportstr, sizeof(reportstr), report[ReportReason]);
	if(strlen(reportstr) > 100) strins(reportstr, "\n", 101);

	yield 1;
	new dialogResponse[e_DIALOG_RESPONSE_INFO];
	AwaitAsyncDialog(playerid, dialogResponse, DIALOG_STYLE_MSGBOX, "Report Details", sprintf("Report From %s (%i) Against %s (%i)\n\n%s", GetName(report[ReportingPlayer]), report[ReportingPlayer], GetName(report[ReportedPlayer]), report[ReportedPlayer], reportstr), "Accept", "Deny");

	if (dialogResponse[E_DIALOG_RESPONSE_Response]) {
		if(!pool_has(Reports, id)) return SendErrorMessage(playerid, "Invalid report ID.");

		new reporter = report[ReportingPlayer], target = report[ReportedPlayer];

		pool_remove(Reports, id);

		if (GetPlayerAdminHidden(playerid))
			SendClientMessage(reporter, COLOR_LIGHTRED, sprintf("{bf0000}Reports:{FFFFFF} An admin is now looking into your report on %s (%i). They will contact you if any further information is required.", GetName(target), target));
		else
			SendClientMessage(reporter, COLOR_LIGHTRED, sprintf("{bf0000}Reports:{FFFFFF} Admin %s is now looking into your report on %s (%i). They will contact you if any further information is required.", GetName(playerid), GetName(target), target));
		
		SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("{bf0000}Reports:{FFFFFF} You are now handling report %i.", id));
		SendAdmcmdMessage(1, sprintf("{bf0000}Reports: %s {808080}is handling report %i.", GetName(playerid), id));

		DCC_SendChannelMessage(DCC_FindChannelByName("in-game-reports"), sprintf("**Reports:** %s is handling report %i by %s.", GetName(playerid), id, GetName(reporter)));

		DeletePVar(playerid, tmpString);
	} else {
		if(!pool_has(Reports, id)) return SendErrorMessage(playerid, "Invalid report ID.");

		new reporter = report[ReportingPlayer], target = report[ReportedPlayer];

		pool_remove(Reports, id);

		if (GetPlayerAdminHidden(playerid))
			SendClientMessage(reporter, COLOR_LIGHTRED, sprintf("{bf0000}Reports:{FFFFFF} An admin has denied your report on %s (%i)!", GetName(target), target));
		else 
			SendClientMessage(reporter, COLOR_LIGHTRED, sprintf("{bf0000}Reports:{FFFFFF} Admin %s has denied your report on %s (%i)!", GetName(playerid), GetName(target), target));
		
		SendClientMessage(playerid, COLOR_LIGHTRED, sprintf("{bf0000}Reports:{FFFFFF} You have denied report %i", id));
		SendAdmcmdMessage(1, sprintf("{bf0000}Reports:{FFFFFF} %s has denied report %i", GetName(playerid), id));
		DCC_SendChannelMessage(DCC_FindChannelByName("in-game-reports"), sprintf("**Reports:** %s has denied report %i", GetName(playerid), id));

		DeletePVar(playerid, tmpString);
	}

	return true;
}
Dialog:ReportDescription(playerid, response, listitem, inputtext[]) return ShowReportDialog(playerid);