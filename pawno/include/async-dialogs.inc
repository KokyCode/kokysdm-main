#if defined _inc_async_dialogs
	#undef _inc_async_dialogs
#endif 

#if defined async_dialogs_included
	#endinput
#endif
#define async_dialogs_included

#include <PawnPlus>

enum e_DIALOG_RESPONSE_INFO
{
	E_DIALOG_RESPONSE_Response,
	E_DIALOG_RESPONSE_Listitem,
	E_DIALOG_RESPONSE_InputText[128 + 1],
}

const PAWN_PLUS_DIALOG_ID = 0x502B; // "P+" in ascii hex

static Task:PlayerDialogTasks[MAX_PLAYERS] = {Task:0, ...};

static CallbackHandler:AsyncDialogResponseHandler;

public OnGameModeInit()
{
	AsyncDialogResponseHandler = pawn_register_callback("OnDialogResponse", "AsyncDialogsHandler");

	#if defined AsyncDialogs_OnGameModeInit
		return AsyncDialogs_OnGameModeInit();
	#else
		return 1;
	#endif
}

public OnGameModeExit()
{
	pawn_unregister_callback(AsyncDialogResponseHandler);

	#if defined AsyncDialogs_OnGameModeExit
		return AsyncDialogs_OnGameModeExit();
	#else
		return 1;
	#endif
}

stock AwaitAsyncDialog(playerid, dialog_response[e_DIALOG_RESPONSE_INFO], style, caption[], info[], button1[], button2[])
{
	ShowPlayerDialog(playerid, PAWN_PLUS_DIALOG_ID, style, caption, info, button1, button2);
	if(PlayerDialogTasks[playerid])
	{
		task_delete(PlayerDialogTasks[playerid]);
	}
	new const Task:dialog_task = PlayerDialogTasks[playerid] = task_new();
	task_await(dialog_task);

	task_get_result_arr(dialog_task, dialog_response);
}

stock AwaitAsyncDialogStr(playerid, dialog_response[e_DIALOG_RESPONSE_INFO], style, ConstStringTag:caption, ConstStringTag:info, ConstStringTag:button1, ConstStringTag:button2)
{
	pawn_call_native("ShowPlayerDialog", "dddSSSS", playerid, PAWN_PLUS_DIALOG_ID, style, _:caption, _:info, _:button1, _:button2);
	if(PlayerDialogTasks[playerid])
	{
		task_delete(PlayerDialogTasks[playerid]);
	}
	new const Task:dialog_task = PlayerDialogTasks[playerid] = task_new();
	task_await(dialog_task);

	task_get_result_arr(dialog_task, dialog_response);
}

forward AsyncDialogsHandler(playerid, dialogid, response, listitem, const inputtext[]);
public AsyncDialogsHandler(playerid, dialogid, response, listitem, const inputtext[])
{
	if(dialogid == PAWN_PLUS_DIALOG_ID)
	{
		new dialog_response[e_DIALOG_RESPONSE_INFO];
		dialog_response[E_DIALOG_RESPONSE_Response] = response;
		dialog_response[E_DIALOG_RESPONSE_Listitem] = listitem;
		strcat((dialog_response[E_DIALOG_RESPONSE_InputText][0] = '\0', dialog_response[E_DIALOG_RESPONSE_InputText]), inputtext);

		new const Task:task = PlayerDialogTasks[playerid];
		PlayerDialogTasks[playerid] = Task:0;
		task_set_result_arr(task, dialog_response);

		return 1;
	}
	return 0;
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit AsyncDialogs_OnGameModeInit
#if defined AsyncDialogs_OnGameModeInit
    forward AsyncDialogs_OnGameModeInit();
#endif

#if defined _ALS_OnGameModeExit
	#undef OnGameModeExit
#else
	#define _ALS_OnGameModeExit
#endif

#define OnGameModeExit AsyncDialogs_OnGameModeExit
#if defined AsyncDialogs_OnGameModeExit
	forward AsyncDialogs_OnGameModeExit();
#endif
