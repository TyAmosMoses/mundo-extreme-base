/* Funciones �tiles para programar */

#define INVALID (-1)

#define SECONDS(%0) (%0 * 1000)
#define MINUTES(%0) (%0 * SECONDS(60))
#define HOURS(%0) (%0 * MINUTES(60))

#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0) ((newkeys & (%0)) == (%0))

#define TAG_DISTANCE (13.5)

IsNumeric(const str[])
{
	for (new i = 0, l = strlen(str); i != l; i ++)
	{
	    if (i == 0 && str[0] == '-')
			continue;

	    else if (str[i] < '0' || str[i] > '9')
			return false;
	}
	return true;
}

FormatNumber(number, const prefix[] = "$")
{
	static
		value[32],
		length;

	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));

	if ((length = strlen(value)) > 3)
	{
		for (new i = length, l = 0; --i >= 0; l ++) {
		    if ((l > 0) && (l % 3 == 0)) strins(value, ",", i + 1);
		}
	}
	
	if (prefix[0] != 0)
	    strins(value, prefix, 0);

	if (number < 0)
		strins(value, "-", 0);

	return value;
}

stock ConvertText(string[], type = 1)
{
	switch (type)
	{
	    case 1: // May�sculas
	    {
	        for (new i, len = strlen(string); i != len; i++)
	        {
	            string[i] = toupper(string[i]);
	        }
	    }
	    case 2: // Minusculas
	    {
	        for (new i, len = strlen(string); i != len; i++)
	        {
	            string[i] = tolower(string[i]);
	        }
	    }
	    default: return false;
	}
	return true;
}

stock Desbug(const string[])
{
	new
		szFixed[1024],
		iPos,
		iLen;

	for (iLen = strlen(string); iPos < iLen; iPos ++)
	switch (string[iPos])
	{
		case '�':   szFixed[iPos] = 151;
		case '�':   szFixed[iPos] = 152;
		case '�':   szFixed[iPos] = 153;
		case '�':   szFixed[iPos] = 154;
		case '�':   szFixed[iPos] = 128;
		case '�':   szFixed[iPos] = 129;
		case '�':   szFixed[iPos] = 130;
		case '�':   szFixed[iPos] = 131;
		case '�':   szFixed[iPos] = 157;
		case '�':   szFixed[iPos] = 158;
		case '�':   szFixed[iPos] = 159;
		case '�':   szFixed[iPos] = 160;
		case '�':   szFixed[iPos] = 134;
		case '�':   szFixed[iPos] = 135;
		case '�':   szFixed[iPos] = 136;
		case '�':   szFixed[iPos] = 137;
		case '�':   szFixed[iPos] = 161;
		case '�':   szFixed[iPos] = 162;
		case '�':   szFixed[iPos] = 163;
		case '�':   szFixed[iPos] = 164;
		case '�':   szFixed[iPos] = 138;
		case '�':   szFixed[iPos] = 139;
		case '�':   szFixed[iPos] = 140;
		case '�':   szFixed[iPos] = 141;
		case '�':   szFixed[iPos] = 165;
		case '�':   szFixed[iPos] = 166;
		case '�':   szFixed[iPos] = 167;
		case '�':   szFixed[iPos] = 168;
		case '�':   szFixed[iPos] = 142;
		case '�':   szFixed[iPos] = 143;
		case '�':   szFixed[iPos] = 144;
		case '�':   szFixed[iPos] = 145;
		case '�':   szFixed[iPos] = 169;
		case '�':   szFixed[iPos] = 170;
		case '�':   szFixed[iPos] = 171;
		case '�':   szFixed[iPos] = 172;
		case '�':   szFixed[iPos] = 146;
		case '�':   szFixed[iPos] = 147;
		case '�':   szFixed[iPos] = 148;
		case '�':   szFixed[iPos] = 149;
		case '�':   szFixed[iPos] = 174;
		case '�':   szFixed[iPos] = 173;
		case '�':   szFixed[iPos] = 64;
		case '�':   szFixed[iPos] = 175;
		case '`':   szFixed[iPos] = 177;
		case '&':   szFixed[iPos] = 38;
		default:    szFixed[iPos] = string[iPos];
	}
	return szFixed;
}
