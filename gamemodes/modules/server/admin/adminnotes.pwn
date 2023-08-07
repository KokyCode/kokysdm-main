#define NOTE_ADMIN_LEVEL 1

CMD<AD1>:notes(cmdid, playerid, params[])
{
    new target;
    if(sscanf(params, "u", target)) return SendUsageMessage(playerid, "/notes [playerid or name]");

    if(GetPlayerAdminLevel(playerid) < NOTE_ADMIN_LEVEL) return SendErrorMessage(playerid, "Unauthorised.");

    ShowPlayerAdminNotes(playerid, target);
    return 1;
}

stock ShowPlayerAdminNotes(playerid, target) {
    if(GetPlayerAdminLevel(playerid) < NOTE_ADMIN_LEVEL) return 0;

    yield 1;
    await mysql_aquery_s(SQL_CONNECTION, str_format("SELECT * from logs WHERE PlayerName = '%s'", GetName(target)));
    if(!cache_num_rows()) return SendClientMessage(playerid, COLOR_RED, sprintf("No notes found for %s", GetName(target)));

    new noteId, timestamp, Admin_Name[MAX_PLAYER_NAME], reason[128], ajail_time, output[256], action[128], time, Timestamp: ts;

    SendClientMessage(playerid, COLOR_ORANGE, "Note ID | Admin Name | Action | Reason | Timestamp");
    for(new i = 0, r = cache_num_rows(); i < r; i++)
    {
        cache_get_value_name_int(i, "ID", noteId);
        cache_get_value_name_int(i, "Timestamp", timestamp);
        cache_get_value_name(i, "AdminName", Admin_Name);
        cache_get_value_name(i, "Command", action);
        cache_get_value_name(i, "Reason", reason);
        cache_get_value_name_int(i, "ajailtime", ajail_time);
        ts = Timestamp: timestamp;
        TimeFormat(ts, ISO6801_FULL_UTC, output);
        if(isequal(action, "/ajail")) 
        {
            cache_get_value_name_int(i, "ajailtime", time);
            SendClientMessage(playerid, COLOR_ORANGE, sprintf("%i | %s | %s - %im | %s | %s", noteId, Admin_Name, action, time, reason, output));
        }
        else SendClientMessage(playerid, COLOR_ORANGE, sprintf("%i | %s | %s | %s | %s", noteId, Admin_Name, action, reason, output));
    }
    return 1;
}