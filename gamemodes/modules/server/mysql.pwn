//==============================================================================
//          -- > Database Information
//==============================================================================

new MySQL:SQL_CONNECTION;
new MySQL:SQL_FORUM;

MySQLConnect()
{
	SQL_CONNECTION = mysql_connect_file("mysql-ig.ini");
	SQL_FORUM = mysql_connect_file("mysql-forum.ini");
    if(mysql_errno(SQL_CONNECTION) == 0)
    {
		mysql_log(ERROR | WARNING);
		print("------------------------------------------------------------------------------");
    	print("[MYSQL]: Connection to MySQl database succesful!");
		print("------------------------------------------------------------------------------");
	}
	else
	{
		print("------------------------------------------------------------------------------");
	    print("[MYSQL]: ERROR: Connection to MySQL database failed!");
		print("------------------------------------------------------------------------------");
	}
	mysql_set_charset("latin1", SQL_CONNECTION);
}

public OnQueryError(errorid, const error[], const callback[], const query[], MySQL:handle)
{
	switch(errorid)
	{
		case ER_SYNTAX_ERROR:
		{
			printf("[MYSQL]: SYNTAX ERROR: %s",query);
		}
	}
	new str[400];
	format(str, sizeof(str), "[MYSQL ERROR]: ID: %d", errorid);
	SendAdminsMessage(6, COLOR_RED, str);
	print(str);
	format(str, sizeof(str), "[MYSQL ERROR]: Error: %s", error);
	SendAdminsMessage(6, COLOR_RED, str);
	print(str);
	format(str, sizeof(str), "[MYSQL ERROR]: Query: %s", query);
	SendAdminsMessage(6, COLOR_RED, str);
	print(str);
	return 1;
}

