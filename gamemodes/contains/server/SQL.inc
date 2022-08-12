/* Funciones SQL */

new
	SQL_CONNECTION,
	DataConnect;

stock Float:cache_get_field_float(row, const field_name[])
{
	new
	    str[16];

	cache_get_field_content(row, field_name, str, SQL_CONNECTION);
	return floatstr(str);
}

stock cache_get_field_int(row, const field_name[])
{
	new
	    str[12];

	cache_get_field_content(row, field_name, str, SQL_CONNECTION, sizeof(str));
	return strval(str);
}

stock Return_Escaped(const string[])
{
	new
	    entry[256];

	mysql_real_escape_string(string, entry, SQL_CONNECTION);
	return entry;
}

stock SQL_Update_Int(const database[], const name[], const var[], value)
{
	static query[512];
	format(query, sizeof(query), "UPDATE `%s` SET `%s` = '%d' WHERE `NAME` = '%s'", database, var, value, name);

	return mysql_tquery(SQL_CONNECTION, query);
}

stock SQL_Update_String(const database[], const name[], const var[], const value[])
{
	static query[512];
	format(query, sizeof(query), "UPDATE `%s` SET `%s` = '%s' WHERE `NAME` = '%s'", database, var, value, name);

	return mysql_tquery(SQL_CONNECTION, query);
}

stock SQL_Update_Float(const database[], const name[], const var[], const value[])
{
	static query[512];
	format(query, sizeof(query), "UPDATE `%s` SET `%s` = '%f' WHERE `NAME` = '%s'", database, var, value, name);

	return mysql_tquery(SQL_CONNECTION, query);
}
