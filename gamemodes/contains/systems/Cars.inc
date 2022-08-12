/* Sistema de vehículos por Benjes */

#define MAX_DYNAMIC_CARS (1000)
#define MAX_OWNABLE_CARS (2)

new stock g_arrVehicleNames[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Camión de bomberos", "Camión de basura",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulancia", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Camión de seguridad", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Faggio Pizza", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Camioneta Berkley's RC", "Skimmer", "PCJ 600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR 350", "Walton",
    "Regina", "Comet", "Bicicleta", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bicicleta", "Bicicleta", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR 900", "NRG 500", "HPV 1000", "Cement Truck", "Grúa",
    "Fortune", "Cadrona", "Camión de SWAT", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Camión de bomberos", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT 400", "DFT 30",
    "Huntley", "Stafford", "BF 400", "Camioneta de noticias", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Camión de comida", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Premier", "Premier", "Premier",
    "Rancher", "Picador", "SWAT", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

enum carData
{
	carSQL_ID,
	carEXISTS,
	carMODEL,
	carOWNER,
	carOWNER_NAME[MAX_PLAYER_NAME + 1],
	Float:carPOSITION[4],
	carCOLOR_1,
	carCOLOR_2,
	carPAINT_JOB,
	carLOCKED,
	carMODS[14],
	carGAS,
 	carKMS,
	carMETERS,
 	carVALUE,
	carPLATE[13],
  	carMECHANICAL_INSIDE,
	carWORLD,
	carINTERIOR,
 	carTIME_FADING,
	carOWNER_ON,
 	carCALL_SIGN,
 	carCALL_SIGN_NAME[32],
 	Text3D:carSIGN_3D,
	carASIGN, // Asignado
	carASIGN_NAME[MAX_PLAYER_NAME + 1], // Nombre del asignado
	carTAKEN, // Prestado
 	carTAKEN_NAME[MAX_PLAYER_NAME + 1], // Nombre del prestado
	carIMPOUNDED,
	carIMPOUND_PRICE,
	carFACTION,
	carJOB,
	carDMV,
	carBIZ,
 	carRENT,
  	carRENT_PRICE,
   	carSALE,
	carSALE_PRICE,
	carVEHICLE,
 	carSTEREO,
 	carPANELS,
	carDOORS,
	carLIGHTS,
	carTIRES,
	Float:carDAMAGE,
 	carLIGHTS_STATUS,
    carSTATION_URL[128],
 	carGLOVE_BOX,
	carGLOVE_BOX_QUANTITY,
	carTRUNK_SLOTS,
 	carTRUNK[10],
	carTRUNK_QUANTITY[10],
	carCEPO,
	carLAST_USER[MAX_PLAYER_NAME + 1]
};

new
	CarData[MAX_DYNAMIC_CARS][carData];

enum coreVehicles
{
	vehFuel,
	vehCoreKMS,
	vehCoreMeters,
	vehWindowsDown,
	vehLoads,
	vehLoadType,
	vehCrateObject[5],
	vehCepoObject,
	vehTrash,
	vehRadio,
	vehRadioName[24],
	vehURL[128 char]
};

new
	CoreVehicles[MAX_VEHICLES][coreVehicles];

new ColorToHex_LightsOn[256] = // FF cuando las luces están prendidas
{
	// The existing colours from San Andreas
	0xBBBBBBFF, 0xBBBBBBFF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
	0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
	0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
	0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
	0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
	0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
	0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
	0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
	0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
	0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
	0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
	0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
	0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0xBBBBBBFF,
	// SA-MP extended colours (0.3x)
	0x177517FF, 0x210606FF, 0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF,
	0xB7B7B7FF, 0x464C8DFF, 0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF,
	0x1E1D13FF, 0x1E1306FF, 0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF,
	0x992E1EFF, 0x2C1E08FF, 0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF,
	0x481A0EFF, 0x7A7399FF, 0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF,
	0x7B3E7EFF, 0x3C1737FF, 0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF,
	0x163012FF, 0x16301BFF, 0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF,
	0x2B3C99FF, 0x3A3A0BFF, 0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF,
	0x2C5089FF, 0x15426CFF, 0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF,
	0x995C52FF, 0x99581EFF, 0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF,
	0x96821DFF, 0x197F19FF, 0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF,
	0x8A653AFF, 0x732617FF, 0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF,
	0x561A28FF, 0x4E0E27FF, 0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
};

new ColorToHex_LightsOff[256] = // AA cuando las luces están apagadas
{
	0xBBBBBB88, 0xBBBBBB88, 0x2A77A188, 0x84041088, 0x26373988, 0x86446E88, 0xD78E1088, 0x4C75B788, 0xBDBEC688, 0x5E707288,
	0x46597A88, 0x656A7988, 0x5D7E8D88, 0x58595A88, 0xD6DAD688, 0x9CA1A388, 0x335F3F88, 0x730E1A88, 0x7B0A2A88, 0x9F9D9488,
	0x3B4E7888, 0x732E3E88, 0x691E3B88, 0x96918C88, 0x51545988, 0x3F3E4588, 0xA5A9A788, 0x635C5A88, 0x3D4A6888, 0x97959288,
	0x421F2188, 0x5F272B88, 0x8494AB88, 0x767B7C88, 0x64646488, 0x5A575288, 0x25252788, 0x2D3A3588, 0x93A39688, 0x6D7A8888,
	0x22191888, 0x6F675F88, 0x7C1C2A88, 0x5F0A1588, 0x19382688, 0x5D1B2088, 0x9D987288, 0x7A756088, 0x98958688, 0xADB0B088,
	0x84898888, 0x304F4588, 0x4D626888, 0x16224888, 0x272F4B88, 0x7D625688, 0x9EA4AB88, 0x9C8D7188, 0x6D182288, 0x4E688188,
	0x9C9C9888, 0x91734788, 0x661C2688, 0x949D9F88, 0xA4A7A588, 0x8E8C4688, 0x341A1E88, 0x6A7A8C88, 0xAAAD8E88, 0xAB988F88,
	0x851F2E88, 0x6F829788, 0x58585388, 0x9AA79088, 0x601A2388, 0x20202C88, 0xA4A09688, 0xAA9D8488, 0x78222B88, 0x0E316D88,
	0x722A3F88, 0x7B715E88, 0x741D2888, 0x1E2E3288, 0x4D322F88, 0x7C1B4488, 0x2E5B2088, 0x395A8388, 0x6D283788, 0xA7A28F88,
	0xAFB1B188, 0x36415588, 0x6D6C6E88, 0x0F6A8988, 0x204B6B88, 0x2B3E5788, 0x9B9F9D88, 0x6C849588, 0x4D849588, 0xAE9B7F88,
	0x406C8F88, 0x1F253B88, 0xAB927688, 0x13457388, 0x96816C88, 0x64686A88, 0x10508288, 0xA1998388, 0x38569488, 0x52566188,
	0x7F695688, 0x8C929A88, 0x596E8788, 0x47353288, 0x44624F88, 0x730A2788, 0x22345788, 0x640D1B88, 0xA3ADC688, 0x69585388,
	0x9B8B8088, 0x620B1C88, 0x5B5D5E88, 0x62442888, 0x73182788, 0x1B376D88, 0xEC6AAE88, 0xBBBBBB88,
	0x17751788, 0x21060688, 0x12547888, 0x452A0D88, 0x571E1E88, 0x01070188, 0x25225A88, 0x2C89AA88, 0x8A4DBD88, 0x35963A88,
	0xB7B7B788, 0x464C8D88, 0x84888C88, 0x81786788, 0x817A2688, 0x6A506F88, 0x583E6F88, 0x8CB97288, 0x824F7888, 0x6D276A88,
	0x1E1D1388, 0x1E130688, 0x1F251888, 0x2C453188, 0x1E4C9988, 0x2E5F4388, 0x1E994888, 0x1E999988, 0x99997688, 0x7C849988,
	0x992E1E88, 0x2C1E0888, 0x14240788, 0x993E4D88, 0x1E4C9988, 0x19818188, 0x1A292A88, 0x16616F88, 0x1B668788, 0x6C3F9988,
	0x481A0E88, 0x7A739988, 0x746D9988, 0x53387E88, 0x22240788, 0x3E190C88, 0x46210E88, 0x991E1E88, 0x8D4C8D88, 0x805B8088,
	0x7B3E7E88, 0x3C173788, 0x73351788, 0x78181888, 0x83341A88, 0x8E2F1C88, 0x7E3E5388, 0x7C6D7C88, 0x020C0288, 0x07240788,
	0x16301288, 0x16301B88, 0x642B4F88, 0x36845288, 0x99959088, 0x818D9688, 0x99991E88, 0x7F994C88, 0x83929288, 0x78822288,
	0x2B3C9988, 0x3A3A0B88, 0x8A794E88, 0x0E1F4988, 0x15371C88, 0x15273A88, 0x37577588, 0x06082088, 0x07132688, 0x20394B88,
	0x2C508988, 0x15426C88, 0x10325088, 0x24166388, 0x69201588, 0x8C8D9488, 0x51601388, 0x090F0288, 0x8C573A88, 0x52888E88,
	0x995C5288, 0x99581E88, 0x993A6388, 0x998F4E88, 0x99311E88, 0x0D184288, 0x521E1E88, 0x42420D88, 0x4C991E88, 0x082A1D88,
	0x96821D88, 0x197F1988, 0x3B141F88, 0x74521788, 0x893F8D88, 0x7E1A6C88, 0x0B370B88, 0x27450D88, 0x071F2488, 0x78457388,
	0x8A653A88, 0x73261788, 0x31949088, 0x56941D88, 0x59163D88, 0x1B8A2F88, 0x38160B88, 0x04180488, 0x355D8E88, 0x2E3F5B88,
	0x561A2888, 0x4E0E2788, 0x706C6788, 0x3B3E4288, 0x2E2D3388, 0x7B7E7D88, 0x4A444288, 0x28344E88
};

native IsValidVehicle(vehicleid);

stock ResetVehicle(vehicleid)
{
	if (1 <= vehicleid <= MAX_VEHICLES)
	{
   		CoreVehicles[vehicleid][vehCoreKMS] = 0;
		CoreVehicles[vehicleid][vehCoreMeters] = 0;
		CoreVehicles[vehicleid][vehWindowsDown] = false;
		CoreVehicles[vehicleid][vehTrash] = 0;
		CoreVehicles[vehicleid][vehRadio] = -1;
	}
	return true;
}


stock RespawnVehicle(vehicleid)
{
    ResetVehicle(vehicleid);

	new
		id = Car_GetID(vehicleid);

	if (id != -1)
	    Car_Spawn(id);

	else SetVehicleToRespawn(vehicleid);

	return true;
}

stock Car_GetRealID(carid)
{
	if (carid == -1 || !CarData[carid][carEXISTS] || CarData[carid][carVEHICLE] == INVALID_VEHICLE_ID)
	    return INVALID_VEHICLE_ID;

	return CarData[carid][carVEHICLE];
}

stock Car_GetID(vehicleid)
{
	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (CarData[i][carEXISTS] && CarData[i][carVEHICLE] == vehicleid)
	{
	    return i;
	}
	return -1;
}

stock RemoveFromVehicle(playerid)
{
	if (IsPlayerInAnyVehicle(playerid))
	{
		static
		    Float:fX,
	    	Float:fY,
	    	Float:fZ;

		GetPlayerPos(playerid, fX, fY, fZ);
		SetPlayerPos(playerid, fX, fY, fZ + 1.5);
	}
	return true;
}

stock GetVehicleDriver(vehicleid)
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
	{
		if (SQL_IsLogged(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid) return i;
	}
	return INVALID_PLAYER_ID;
}

stock IsVehicleSeatUsed(vehicleid, seat)
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++) if (SQL_IsLogged(i) && IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == seat)
	{
	    return true;
	}
	return false;
}

stock GetVehicleFromBehind(vehicleid)
{
	static
	    Float:fCoords[7];

	GetVehiclePos(vehicleid, fCoords[0], fCoords[1], fCoords[2]);
	GetVehicleZAngle(vehicleid, fCoords[3]);

	for (new i = 1; i != MAX_VEHICLES; i ++) if (i != vehicleid && GetVehiclePos(i, fCoords[4], fCoords[5], fCoords[6]))
	{
		if (floatabs(fCoords[0] - fCoords[4]) < 6 && floatabs(fCoords[1] - fCoords[5]) < 6 && floatabs(fCoords[2] - fCoords[6]) < 6)
			return i;
	}
	return INVALID_VEHICLE_ID;
}

stock GetVehicleBoot(vehicleid, &Float:x, &Float:y, &Float:z)
{
	if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID)
	    return (x = 0.0, y = 0.0, z = 0.0), 0;

	static
	    Float:pos[7];
	    
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]);
	GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]);
	GetVehicleZAngle(vehicleid, pos[6]);

	x = pos[3] - (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees));
	y = pos[4] - (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees));
 	z = pos[5];
	return true;
}

stock GetVehicleHood(vehicleid, &Float:x, &Float:y, &Float:z)
{
    if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID)
	    return (x = 0.0, y = 0.0, z = 0.0), 0;

	static
	    Float:pos[7];
	    
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]);
	GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]);
	GetVehicleZAngle(vehicleid, pos[6]);

	x = pos[3] + (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees));
	y = pos[4] + (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees));
 	z = pos[5];
	return true;
}

stock GetVehicleMaxSeats(vehicleid)
{
    static const g_arrMaxSeats[] =
	{
		4, 2, 2, 2, 4, 4, 1, 2, 2, 4, 2, 2, 2, 4, 2, 2, 4, 2, 4, 2, 4, 4, 2, 2, 2, 1, 4, 4, 4, 2,
		1, 7, 1, 2, 2, 0, 2, 7, 4, 2, 4, 1, 2, 2, 2, 4, 1, 2, 1, 0, 0, 2, 1, 1, 1, 2, 2, 2, 4, 4,
		2, 2, 2, 2, 1, 1, 4, 4, 2, 2, 4, 2, 1, 1, 2, 2, 1, 2, 2, 4, 2, 1, 4, 3, 1, 1, 1, 4, 2, 2,
		4, 2, 4, 1, 2, 2, 2, 4, 4, 2, 2, 1, 2, 2, 2, 2, 2, 4, 2, 1, 1, 2, 1, 1, 2, 2, 4, 2, 2, 1,
		1, 2, 2, 2, 2, 2, 2, 2, 2, 4, 1, 1, 1, 2, 2, 2, 2, 7, 7, 1, 4, 2, 2, 2, 2, 2, 4, 4, 2, 2,
		4, 4, 2, 1, 2, 2, 2, 2, 2, 2, 4, 4, 2, 2, 1, 2, 4, 4, 1, 0, 0, 1, 1, 2, 1, 2, 2, 1, 2, 4,
		4, 2, 4, 1, 0, 4, 2, 2, 2, 2, 0, 0, 7, 2, 2, 1, 4, 4, 4, 2, 2, 2, 2, 2, 4, 2, 0, 0, 0, 4,
		0, 0
	};
	
	new
	    model = GetVehicleModel(vehicleid);

	if (400 <= model <= 611)
	    return g_arrMaxSeats[model - 400];

	return false;
}

stock GetAvailableSeat(vehicleid, start = 1)
{
	new
		seats = GetVehicleMaxSeats(vehicleid);

	for (new i = start; i < seats; i ++) if (!IsVehicleSeatUsed(vehicleid, i))
	{
	    return i;
	}
	return INVALID;
}

stock GetEngineStatus(vehicleid)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (engine != 1)
		return false;

	return true;
}

stock GetHoodStatus(vehicleid)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (bonnet != 1)
		return false;

	return true;
}

stock GetTrunkStatus(vehicleid)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (boot != 1)
		return false;

	return true;
}

stock GetLightStatus(vehicleid)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (lights != 1)
		return false;

	return true;
}

stock SetEngineStatus(vehicleid, status)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, status, lights, alarm, doors, bonnet, boot, objective);
}

stock SetLightStatus(vehicleid, status)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, status, alarm, doors, bonnet, boot, objective);
}

stock SetTrunkStatus(vehicleid, status)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, status, objective);
}

stock SetHoodStatus(vehicleid, status)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, status, boot, objective);
}

stock IsABoat(vehicleid)
{
	switch (GetVehicleModel(vehicleid))
	{
		case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595: return true;
	}
	return false;
}

stock IsABike(vehicleid)
{
	switch (GetVehicleModel(vehicleid))
	{
		case 448, 461..463, 468, 521..523, 581, 586, 481, 509, 510: return true;
	}
	return false;
}

stock IsAPlane(vehicleid)
{
	switch (GetVehicleModel(vehicleid))
	{
		case 460, 464, 476, 511, 512, 513, 519, 520, 553, 577, 592, 593: return true;
	}
	return false;
}

stock IsAHelicopter(vehicleid)
{
	switch (GetVehicleModel(vehicleid))
	{
		case 417, 425, 447, 465, 469, 487, 488, 497, 501, 548, 563: return true;
	}
	return false;
}

stock IsEngineVehicle(vehicleid)
{
	new const g_aEngineStatus[] =
	{
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};

    new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return false;

    return (g_aEngineStatus[modelid - 400]);
}

stock IsSpeedoVehicle(vehicleid)
{
	if (GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510 || GetVehicleModel(vehicleid) == 481 || !IsEngineVehicle(vehicleid))
	{
	    return false;
	}
	return true;
}

forward GetVehicleSpeedToKM(vehicleid);
public GetVehicleSpeedToKM(vehicleid)
{
    new
		Float:X,
		Float:Y,
		Float:Z;

    GetVehicleVelocity(vehicleid, X, Y, Z);

    return floatround(floatsqroot(X * X + Y * Y + Z * Z) * 185.0);
}

stock GetVehicleSpeedToSpeedo(playerid)
{
	new
		Float:ST[3];

	GetVehicleVelocity(GetPlayerVehicleID(playerid), ST[0], ST[1], ST[2]);

	return floatround(1.61 * floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 100.3);
}

stock EngineOn(vehicleid, playerid)
{
	if (PlayerData[playerid][IS_ENGINE] == 1) return true;
	else
	{
	    if (!IsABike(GetPlayerVehicleID(playerid))) ApplyAnimation(playerid, "PED", "CAR_tune_radio", 3.7, 0, 0, 0, 0, 0, 1);
	    
 	 	PlayerData[playerid][IS_ENGINE] = true;
    	PlayerData[playerid][ENGINE_TIMER] = SetTimerEx("EngineProgress", 750, false, "ii", vehicleid, playerid);

        TogglePlayerControllable(playerid, false);
        
		SetPlayerChatBubble(playerid, "* está encendiendo el vehículo... *", COLOR_PURPLE, TAG_DISTANCE, SECONDS(3));

		new message[64];
		format(message, sizeof(message), "~w~Encendiendo %s...", ReturnVehicleName(CarData[Car_GetID(vehicleid)][carVEHICLE]));
		GameTextForPlayer(playerid, Desbug(message), SECONDS(5), 3);
	}
 	return true;
}

stock EngineOff(vehicleid, playerid)
{
    if (PlayerData[playerid][IS_ENGINE] == 1) return true;
	else
	{
        if (!IsABike(GetPlayerVehicleID(playerid))) ApplyAnimation(playerid, "PED", "CAR_tune_radio", 3.7, 0, 0, 0, 0, 0, 1);
        
        SetEngineStatus(vehicleid, false);
		SetPlayerChatBubble(playerid, "* apagó el motor del vehículo. *", COLOR_PURPLE, TAG_DISTANCE, SECONDS(3));

		new message[64];
		format(message, sizeof(message), "~w~%s apagado.", ReturnVehicleName(CarData[Car_GetID(vehicleid)][carVEHICLE]));
		GameTextForPlayer(playerid, Desbug(message), 750, 3);

		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
	 	{
	  		if (IsSpeedoVehicle(vehicleid) && (SQL_IsLogged(i) && GetPlayerVehicleID(i) == vehicleid))
	  		{
	  		    Hide_Speedometer(i);
	    	}
	   	}
	}
	return true;
}

forward EngineProgress(vehicleid, playerid);
public EngineProgress(vehicleid, playerid)
{
    if (PlayerData[playerid][IS_ENGINE] == 0) return true;
	else
	{
		PlayerData[playerid][IS_ENGINE] = false;
		KillTimer(PlayerData[playerid][ENGINE_TIMER]);

        TogglePlayerControllable(playerid, true);
	 	SetEngineStatus(vehicleid, true);

		SetPlayerChatBubble(playerid, "* encendió el motor del vehículo. *", COLOR_PURPLE, TAG_DISTANCE, SECONDS(3));

		new message[64];
		format(message, sizeof(message), "~w~%s encendido.", ReturnVehicleName(CarData[Car_GetID(vehicleid)][carVEHICLE]));
		GameTextForPlayer(playerid, Desbug(message), 750, 3);

		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
	 	{
	  		if (IsSpeedoVehicle(vehicleid) && (SQL_IsLogged(i) && GetPlayerVehicleID(i) == vehicleid))
	  		{
	   		   Show_Speedometer(i);
	    	}
	   	}
	}
	return true;
}

stock SetVehiclePaintjob(vehicleid, paintjobid)
{
    new
		id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carPAINT_JOB] = paintjobid;
	    Car_Save(id);
	}
	return ChangeVehiclePaintjob(vehicleid, paintjobid);
}

stock RemoveComponent(vehicleid, componentid)
{
	if (!IsValidVehicle(vehicleid) || (componentid < 1000 || componentid > 1193))
	    return false;

	new
		id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carMODS][GetVehicleComponentType(componentid)] = 0;
	    Car_Save(id);
	}
	return RemoveVehicleComponent(vehicleid, componentid);
}

stock AddComponent(vehicleid, componentid)
{
	if (!IsValidVehicle(vehicleid) || (componentid < 1000 || componentid > 1193))
	    return false;

	new
		id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carMODS][GetVehicleComponentType(componentid)] = componentid;
	    Car_Save(id);
	}
	return AddVehicleComponent(vehicleid, componentid);
}

stock ReturnVehicleName(vehicleid, type = -1)
{
	new
		model = GetVehicleModel(vehicleid),
		name[32] = "vehículo";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);

	if (type == 1) ConvertText(name, 2); // Minúscula
 	else if (type == 2) ConvertText(name, 1); // Mayúscula

	return name;
}

stock SheetVehicles()
{
	new
		str = random(26),
		random_ex[2];

	switch (str)
	{
		case 0: random_ex = "A";
		case 1: random_ex = "B";
		case 2: random_ex = "C";
		case 3: random_ex = "D";
		case 4: random_ex = "E";
		case 5: random_ex = "F";
		case 6: random_ex = "G";
		case 7: random_ex = "H";
		case 8: random_ex = "I";
		case 9: random_ex = "J";
		case 10: random_ex = "K";
		case 11: random_ex = "L";
		case 12: random_ex = "M";
		case 13: random_ex = "N";
		case 14: random_ex = "O";
		case 15: random_ex = "P";
		case 16: random_ex = "Q";
		case 17: random_ex = "R";
		case 18: random_ex = "S";
		case 19: random_ex = "T";
		case 20: random_ex = "U";
		case 21: random_ex = "V";
		case 22: random_ex = "W";
		case 23: random_ex = "X";
		case 24: random_ex = "Y";
		case 25: random_ex = "Z";
	}
	return random_ex;
}

stock GetTrunkSlots(i)
{
    new
		slots;
		
    switch (i)
    {
        case 400: { slots = 8; }
        case 401: { slots = 6; }
        case 402: { slots = 6; }
        case 403: { slots = 10; }
        case 404: { slots = 6; }
        case 405: { slots = 6; }
        case 406: { slots = 10; }
        case 407: { slots = 10; }
        case 408: { slots = 10; }
        case 409: { slots = 6; }
        case 410: { slots = 6; }
        case 411: { slots = 6; }
        case 412: { slots = 6; }
        case 413: { slots = 9; }
        case 414: { slots = 10; }
        case 415: { slots = 6; }
        case 416: { slots = 10; }
        case 417: { slots = 10; }
        case 418: { slots = 6; }
        case 419: { slots = 6; }
        case 420: { slots = 6; }
        case 421: { slots = 6; }
        case 422: { slots = 6; }
        case 423: { slots = 10; }
        case 424: { slots = 6; }
        case 425: { slots = 6; }
        case 426: { slots = 6; }
        case 427: { slots = 10; }
        case 428: { slots = 10; }
        case 429: { slots = 6; }
        case 430: { slots = 8; }
        case 431: { slots = 10; }
        case 432: { slots = 6; }
        case 433: { slots = 10; }
        case 434: { slots = 6; }
        case 435: { slots = 10; }
        case 436: { slots = 6; }
        case 437: { slots = 10; }
        case 438: { slots = 6; }
        case 439: { slots = 6; }
        case 440: { slots = 9; }
        case 442: { slots = 6; }
        case 443: { slots = 6; }
        case 444: { slots = 6; }
        case 445: { slots = 5; }
        case 446: { slots = 6; }
        case 447: { slots = 6; }
        case 448: { slots = 6; }
        case 449: { slots = 10; }
        case 450: { slots = 10; }
        case 451: { slots = 6; }
        case 452: { slots = 6; }
        case 453: { slots = 8; }
        case 454: { slots = 10; }
        case 455: { slots = 10; }
        case 456: { slots = 10; }
        case 457: { slots = 6; }
        case 458: { slots = 6; }
        case 459: { slots = 8; }
        case 460: { slots = 6; }
        case 461: { slots = 6; }
        case 462: { slots = 6; }
        case 463: { slots = 6; }
        case 466: { slots = 6; }
        case 604: { slots = 6; }
        case 467: { slots = 6; }
        case 468: { slots = 6; }
        case 469: { slots = 6; }
        case 470: { slots = 8; }
        case 471: { slots = 6; }
        case 472: { slots = 6; }
        case 473: { slots = 6; }
        case 474: { slots = 6; }
        case 475: { slots = 6; }
        case 476: { slots = 6; }
        case 477: { slots = 6; }
        case 478: { slots = 7; }
        case 479: { slots = 6; }
        case 480: { slots = 6; }
        case 482: { slots = 10; }
        case 483: { slots = 6; }
        case 484: { slots = 10; }
        case 485: { slots = 6; }
        case 486: { slots = 6; }
        case 487: { slots = 10; }
        case 488: { slots = 10; }
        case 489: { slots = 8; }
        case 490: { slots = 8; }
        case 491: { slots = 6; }
        case 492: { slots = 6; }
        case 493: { slots = 8; }
        case 494: { slots = 6; }
        case 495: { slots = 6; }
        case 496: { slots = 6; }
        case 497: { slots = 10; }
        case 498: { slots = 10; }
        case 499: { slots = 10; }
        case 500: { slots = 6; }
        case 502: { slots = 6; }
        case 503: { slots = 6; }
        case 504: { slots = 6; }
        case 505: { slots = 8; }
        case 506: { slots = 6; }
        case 507: { slots = 5; }
        case 508: { slots = 10; }
        case 511: { slots = 4; }
        case 512: { slots = 4; }
        case 513: { slots = 4; }
        case 514: { slots = 6; }
        case 515: { slots = 6; }
        case 516: { slots = 6; }
        case 517: { slots = 6; }
        case 518: { slots = 6; }
        case 519: { slots = 10; }
        case 520: { slots = 6; }
        case 521: { slots = 6; }
        case 522: { slots = 6; }
        case 523: { slots = 6; }
        case 524: { slots = 6; }
        case 525: { slots = 6; }
        case 526: { slots = 6; }
        case 527: { slots = 6; }
        case 528: { slots = 10; }
        case 529: { slots = 6; }
        case 530: { slots = 6; }
        case 531: { slots = 6; }
        case 532: { slots = 6; }
        case 533: { slots = 6; }
        case 534: { slots = 6; }
        case 535: { slots = 6; }
        case 536: { slots = 6; }
        case 537: { slots = 10; }
        case 538: { slots = 10; }
        case 540: { slots = 6; }
        case 541: { slots = 6; }
        case 542: { slots = 6; }
        case 543: { slots = 6; }
        case 544: { slots = 10; }
        case 545: { slots = 6; }
        case 546: { slots = 6; }
        case 547: { slots = 6; }
        case 548: { slots = 10; }
        case 549: { slots = 6; }
        case 550: { slots = 6; }
        case 551: { slots = 6; }
        case 552: { slots = 10; }
        case 553: { slots = 10; }
        case 554: { slots = 8; }
        case 555: { slots = 6; }
        case 556: { slots = 6; }
        case 557: { slots = 6; }
        case 558: { slots = 6; }
        case 559: { slots = 6; }
        case 560: { slots = 6; }
        case 561: { slots = 8; }
        case 562: { slots = 6; }
        case 563: { slots = 10; }
        case 565: { slots = 6; }
        case 566: { slots = 6; }
        case 567: { slots = 6; }
        case 568: { slots = 6; }
        case 569: { slots = 10; }
        case 570: { slots = 10; }
        case 571: { slots = 6; }
        case 572: { slots = 6; }
        case 573: { slots = 6; }
        case 574: { slots = 6; }
        case 575: { slots = 6; }
        case 576: { slots = 6; }
        case 577: { slots = 10; }
        case 578: { slots = 6; }
        case 579: { slots = 8; }
        case 580: { slots = 6; }
        case 581: { slots = 6; }
        case 582: { slots = 10; }
        case 583: { slots = 6; }
        case 585: { slots = 6; }
        case 586: { slots = 6; }
        case 587: { slots = 6; }
        case 588: { slots = 8; }
        case 589: { slots = 6; }
        case 592: { slots = 10; }
        case 593: { slots = 6; }
        case 595: { slots = 8; }
        case 596: { slots = 6; }
        case 597: { slots = 6; }
        case 598: { slots = 6; }
        case 599: { slots = 6; }
        case 600: { slots = 7; }
        case 601: { slots = 6; }
        case 602: { slots = 6; }
        case 603: { slots = 6; }
        case 609: { slots = 10; }
        default: { slots = 6; }
    }
    return slots;
}

IsAPublicVehicle(carid)
{
	if (CarData[carid][carFACTION] != -1 || CarData[carid][carJOB] != -1 || CarData[carid][carDMV] != 0)
 		return true;

	return false;
}

ReturnVehicleHealth(vehicleid)
{
	if (!IsValidVehicle(vehicleid))
	    return false;

	static
	    Float:amount;

	GetVehicleHealth(vehicleid, amount);
	return floatround(amount, floatround_round);
}

GetVehicleModelByName(const name[])
{
	if (IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611))
	    return strval(name);

	for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
	{
	    if (strfind(g_arrVehicleNames[i], name, true) != -1)
	    {
	        return i + 400;
		}
	}
	return false;
}

Car_Nearest(playerid)
{
	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (CarData[i][carEXISTS])
	{
		GetVehiclePos(CarData[i][carVEHICLE], fX, fY, fZ);

		if (CarData[i][carMODEL] == 408) // Si es un trashmaster...
		{
			if (IsPlayerInRangeOfPoint(playerid, 5.0, fX, fY, fZ))
			{
		    	return i;
  			}
		}
		else
		{
  			if (IsPlayerInRangeOfPoint(playerid, 2.5, fX, fY, fZ))
			{
		    	return i;
  			}
		}
	}
	return INVALID;
}

ReturnVehicleModelName(model, type = -1)
{
	new
	    name[32] = "vehículo";

    if (model < 400 || model > 611)
	    return name;

    format(name, sizeof(name), g_arrVehicleNames[model - 400]);

	if (type == 1) ConvertText(name, 2); // Minúscula
 	else if (type == 2) ConvertText(name, 1); // Mayúscula
 	
	return name;
}

Car_Inside(playerid)
{
	new 
		carid;

	if (IsPlayerInAnyVehicle(playerid) && (carid = Car_GetID(GetPlayerVehicleID(playerid))) != -1)
	    return carid;

	return INVALID;
}

Car_IsOwner(playerid, carid)
{
	if (!SQL_IsLogged(playerid))
	    return false;

    if (CarData[carid][carEXISTS] && CarData[carid][carOWNER] != 0 && CarData[carid][carOWNER] == PlayerData[playerid][SQL_ID])
		return true;

	return false;
}

GetVehicleKeys(playerid, carid)
{
	if (!SQL_IsLogged(playerid))
	    return false;

    if ((CarData[carid][carEXISTS]) && Car_IsOwner(playerid, carid)) 
    	return true;

	return false;
}

Car_GetCount(playerid)
{
	new
		count = 0;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++)
	{
		if (CarData[i][carEXISTS] && CarData[i][carOWNER] == PlayerData[playerid][SQL_ID])
   		{
   		    count++;
		}
	}
	
	return count;
}

Car_Create(ownerid, modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, faction = -1, job = -1, dmv = 0, price = 0)
{
    for (new i = 0; i != MAX_DYNAMIC_CARS; i ++)
	{
		if (!CarData[i][carEXISTS])
   		{
   		    if (color1 == -1)
   		        color1 = 255;

			if (color2 == -1)
			    color2 = 255;

   		    CarData[i][carEXISTS] = true;
            CarData[i][carMODEL] = modelid;
            
            CarData[i][carOWNER] = ownerid;
            format(CarData[i][carOWNER_NAME], 24, "<nombre_apellido>");
            
            CarData[i][carPOSITION][0] = x;
            CarData[i][carPOSITION][1] = y;
            CarData[i][carPOSITION][2] = z;
            CarData[i][carPOSITION][3] = angle;
            CarData[i][carCOLOR_1] = color1;
            CarData[i][carCOLOR_2] = color2;
            CarData[i][carPAINT_JOB] = -1;
            CarData[i][carLOCKED] = false;

            CarData[i][carTRUNK_SLOTS] = GetTrunkSlots(modelid);

			new str[13];
			format(str, sizeof(str), "%c%c %d%d%d %d%c", SheetVehicles(), SheetVehicles(), random(10), CarData[i][carSQL_ID], random(10), random(10), SheetVehicles());
			format(CarData[i][carPLATE], 13, str);

			SetVehicleNumberPlate(CarData[i][carVEHICLE], CarData[i][carPLATE]);

            CarData[i][carFACTION] = faction;
            CarData[i][carJOB] = job;
            CarData[i][carDMV] = dmv;
            CarData[i][carVALUE] = price;
            
			for (new j = 0; j < CarData[i][carTRUNK_SLOTS]; j ++)
			{
                CarData[i][carTRUNK][j] = 0;
				CarData[i][carTRUNK_QUANTITY][j] = 0;
            }

            for (new j = 0; j < 14; j ++) CarData[i][carMODS][j] = 0;
            
   	        format(CarData[i][carSTATION_URL], 128, "<url>");
	        format(CarData[i][carLAST_USER], 24, "<nombre_apellido>");

	        CarData[i][carCALL_SIGN] = 0;
	        format(CarData[i][carCALL_SIGN_NAME], 32, "<callsign>");

	   	    if (IsValidDynamic3DTextLabel(CarData[i][carSIGN_3D]))
		        DestroyDynamic3DTextLabel(CarData[i][carSIGN_3D]);

	        CarData[i][carASIGN] = -1;
	        format(CarData[i][carASIGN_NAME], 24, "<nombre_apellido>");

	        CarData[i][carTAKEN] = -1;
	        format(CarData[i][carTAKEN_NAME], 24, "<nombre_apellido>");

			CoreVehicles[CarData[i][carVEHICLE]][vehCoreKMS] = 0;
			CoreVehicles[CarData[i][carVEHICLE]][vehCoreMeters] = 0;

            CarData[i][carVEHICLE] = CreateVehicle(modelid, x, y, z, angle, color1, color2, -1);

            if (CarData[i][carVEHICLE] != INVALID_VEHICLE_ID)
			{
                ResetVehicle(CarData[i][carVEHICLE]),
                CoreVehicles[CarData[i][carVEHICLE]][vehFuel] = 100;
            }

            mysql_tquery(SQL_CONNECTION, "INSERT INTO `cars` (`carMODEL`) VALUES(0)", "OnCarCreated", "d", i);
            return i;
		}
	}
	return -1;
}

Car_Delete(carid)
{
    if (carid != -1 && CarData[carid][carEXISTS])
    {
        new
            string[64];

        format(string, sizeof(string), "DELETE FROM `cars` WHERE `carSQL_ID` = '%d'", CarData[carid][carSQL_ID]);
        mysql_tquery(SQL_CONNECTION, string);

        if (IsValidVehicle(CarData[carid][carVEHICLE]))
            DestroyVehicle(CarData[carid][carVEHICLE]);

        for (new j = 0; j < CarData[carid][carTRUNK_SLOTS]; j ++)
        {
      		CarData[carid][carTRUNK][j] = 0;
            CarData[carid][carTRUNK_QUANTITY][j] = 0;
        }

        CarData[carid][carEXISTS] = false;
        CarData[carid][carSQL_ID] = 0;
        
        CarData[carid][carOWNER] = 0;
        format(CarData[carid][carOWNER_NAME], 24, "<nombre_apellido>");
        
        CarData[carid][carCOLOR_1] = -1;
        CarData[carid][carCOLOR_2] = -1;
        CarData[carid][carPAINT_JOB] = -1;
        CarData[carid][carLOCKED] = false;
        
        for (new j = 0; j < 14; j ++) CarData[carid][carMODS][j] = 0;
        
        CarData[carid][carGAS] = 0;
        CarData[carid][carKMS] = 0;
        CarData[carid][carMETERS] = 0;
        CarData[carid][carVALUE] = 0;
        
        format(CarData[carid][carPLATE], 13, "<gt0000a>");
        
        CarData[carid][carMECHANICAL_INSIDE] = -1;
        CarData[carid][carWORLD] = 0;
        CarData[carid][carINTERIOR] = 0;
        CarData[carid][carTIME_FADING] = 0;
        CarData[carid][carOWNER_ON] = 0;

        CarData[carid][carCALL_SIGN] = 0;
        format(CarData[carid][carCALL_SIGN_NAME], 32, "<callsign>");
        
   	    if (IsValidDynamic3DTextLabel(CarData[carid][carSIGN_3D]))
	        DestroyDynamic3DTextLabel(CarData[carid][carSIGN_3D]);

        CarData[carid][carPAINT_JOB] = -1;
        CarData[carid][carPAINT_JOB] = -1;

        CarData[carid][carASIGN] = -1;
        format(CarData[carid][carASIGN_NAME], 24, "<nombre_apellido>");
        
        CarData[carid][carTAKEN] = -1;
        format(CarData[carid][carTAKEN_NAME], 24, "<nombre_apellido>");

        CarData[carid][carIMPOUNDED] = 0;
        CarData[carid][carIMPOUND_PRICE] = 0;
        CarData[carid][carFACTION] = -1;
        CarData[carid][carJOB] = -1;
        CarData[carid][carDMV] = 0;
        CarData[carid][carBIZ] = -1;
        CarData[carid][carRENT] = 0;
        CarData[carid][carRENT_PRICE] = 0;
        CarData[carid][carSALE] = 0;
        CarData[carid][carSALE_PRICE] = 0;
        CarData[carid][carLIGHTS_STATUS] = 0;
        CarData[carid][carCEPO] = 0;
        CarData[carid][carVEHICLE] = 0;
        
        format(CarData[carid][carSTATION_URL], 128, "<url>");
        format(CarData[carid][carLAST_USER], 24, "<nombre_apellido>");
    }
    return true;
}

stock CurrentCarSave(playerid)
{
 	new
	 	vehicleid = GetPlayerVehicleID(playerid);

	if (vehicleid != -1)
	{
		if ((vehicleid = Car_GetID(vehicleid)) != -1)
		{
		  	if (!IsAPublicVehicle(vehicleid))
			{
				CarData[vehicleid][carINTERIOR] = GetPlayerInterior(playerid);
		  		CarData[vehicleid][carWORLD] = GetPlayerVirtualWorld(playerid);

				for (new i = 0; i < 14; i ++) CarData[vehicleid][carMODS][i] = GetVehicleComponentInSlot(CarData[vehicleid][carVEHICLE], i);

				GetVehiclePos(CarData[vehicleid][carVEHICLE], CarData[vehicleid][carPOSITION][0], CarData[vehicleid][carPOSITION][1], CarData[vehicleid][carPOSITION][2]);
				GetVehicleZAngle(CarData[vehicleid][carVEHICLE], CarData[vehicleid][carPOSITION][3]);

				Car_Save(vehicleid);
			}
		  	else if (IsAPublicVehicle(vehicleid)) Car_PublicSave(vehicleid);
		}
	}
}

Car_Save(carid)
{
	static
	    query[2048];

	if (CarData[carid][carVEHICLE] != INVALID_VEHICLE_ID)
	{
        CarData[carid][carGAS] = CoreVehicles[CarData[carid][carVEHICLE]][vehFuel];

       	CarData[carid][carKMS] = CoreVehicles[CarData[carid][carVEHICLE]][vehCoreKMS];
		CarData[carid][carMETERS] = CoreVehicles[CarData[carid][carVEHICLE]][vehCoreMeters];

		GetVehicleHealth(CarData[carid][carVEHICLE], CarData[carid][carDAMAGE]);
   	    GetVehicleDamageStatus(CarData[carid][carVEHICLE], CarData[carid][carPANELS], CarData[carid][carDOORS], CarData[carid][carLIGHTS], CarData[carid][carTIRES]);

		CarData[carid][carWORLD] = GetVehicleVirtualWorld(CarData[carid][carVEHICLE]);

		for (new i = 0; i < 14; i ++)
		{
			CarData[carid][carMODS][i] = GetVehicleComponentInSlot(CarData[carid][carVEHICLE], i);
	    }
	}

	query[0] = '\0';
	format(query, sizeof(query), "UPDATE `cars` SET `carMODEL` = '%d', `carOWNER` = '%d', `carOWNER_NAME` = '%s', `carPOSITION_X` = '%.4f', `carPOSITION_Y` = '%.4f', \
		`carPOSITION_Z` = '%.4f', `carPOSITION_ANGLE` = '%.4f', `carCOLOR_1` = '%d', `carCOLOR_2` = '%d', `carPAINT_JOB` = '%d', `carLOCKED` = '%d', \
		`carGAS` = '%d', `carKMS` = '%d', `carMETERS` = '%d', `carVALUE` = '%d', `carPLATE` = '%s'  WHERE `carSQL_ID` = '%d'",
        CarData[carid][carMODEL],
        CarData[carid][carOWNER],
        Return_Escaped(CarData[carid][carOWNER_NAME]),
        CarData[carid][carPOSITION][0],
        CarData[carid][carPOSITION][1],
        CarData[carid][carPOSITION][2],
        CarData[carid][carPOSITION][3],
        CarData[carid][carCOLOR_1],
        CarData[carid][carCOLOR_2],
        CarData[carid][carPAINT_JOB],
        CarData[carid][carLOCKED],
        CarData[carid][carGAS],
        CarData[carid][carKMS],
        CarData[carid][carMETERS],
		CarData[carid][carVALUE],
        Return_Escaped(CarData[carid][carPLATE]),
        CarData[carid][carSQL_ID]
	);

	mysql_tquery(SQL_CONNECTION, query);

    query[0] = '\0';
	format(query, sizeof(query), "UPDATE `cars` SET `carMOD_1` = '%d', `carMOD_2` = '%d', `carMOD_3` = '%d', `carMOD_4` = '%d', `carMOD_5` = '%d', `carMOD_6` = '%d', \
		`carMOD_7` = '%d', `carMOD_8` = '%d', `carMOD_9` = '%d', `carMOD_10` = '%d', `carMOD_11` = '%d', `carMOD_12` = '%d', `carMOD_13` = '%d', `carMOD_14` = '%d' \
		WHERE `carSQL_ID` = '%d'",
		CarData[carid][carMODS][0],
		CarData[carid][carMODS][1],
		CarData[carid][carMODS][2],
		CarData[carid][carMODS][3],
		CarData[carid][carMODS][4],
		CarData[carid][carMODS][5],
		CarData[carid][carMODS][6],
		CarData[carid][carMODS][7],
		CarData[carid][carMODS][8],
		CarData[carid][carMODS][9],
		CarData[carid][carMODS][10],
		CarData[carid][carMODS][11],
		CarData[carid][carMODS][12],
		CarData[carid][carMODS][13],
		CarData[carid][carSQL_ID]
	);

	mysql_tquery(SQL_CONNECTION, query);

    query[0] = '\0';
 	format(query, sizeof(query), "UPDATE `cars` SET `carMECHANICAL_INSIDE` = '%d', `carWORLD` = '%s', `carINTERIOR` = '%d', `carTIME_FADING` = '%d', `carCALL_SIGN` = '%d', \
	 	`carCALL_SIGN_NAME` = '%s', `carASIGN` = '%d', `carASIGN_NAME` = '%s', `carTAKEN` = '%d', `carTAKEN_NAME` = '%s', `carIMPOUNDED` = '%d', `carIMPOUND_PRICE` = '%d' \
		WHERE `carSQL_ID` = '%d'",
		CarData[carid][carMECHANICAL_INSIDE],
		CarData[carid][carWORLD],
		CarData[carid][carINTERIOR],
		CarData[carid][carTIME_FADING],
		CarData[carid][carCALL_SIGN],
		Return_Escaped(CarData[carid][carCALL_SIGN_NAME]),
        CarData[carid][carASIGN],
        Return_Escaped(CarData[carid][carASIGN_NAME]),
        CarData[carid][carTAKEN],
        Return_Escaped(CarData[carid][carTAKEN_NAME]),
        CarData[carid][carIMPOUNDED],
        CarData[carid][carIMPOUND_PRICE],
        CarData[carid][carSQL_ID]
    );

	mysql_tquery(SQL_CONNECTION, query);

    query[0] = '\0';
	format(query, sizeof(query), "UPDATE `cars` SET `carFACTION` = '%d', `carJOB` = '%d', `carDMV` = '%d', `carBIZ` = '%d', `carRENT` = '%d', `carRENT_PRICE` = '%d', \
		`carSALE` = '%d', `carSALE_PRICE` = '%d', `carSTEREO` = '%d', `carPANELS` = '%d', `carDOORS` = '%d', `carLIGHTS` = '%d', `carTIRES` = '%d', `carDAMAGE` = '%f', \
	 	`carLIGHTS_STATUS` = '%d', `carSTATION_URL` = '%d', `carCEPO` = '%d', `carLAST_USER` = '%s' WHERE `carSQL_ID` = '%d'",
     	CarData[carid][carFACTION],
        CarData[carid][carJOB],
        CarData[carid][carDMV],
        CarData[carid][carBIZ],
        CarData[carid][carRENT],
        CarData[carid][carRENT_PRICE],
        CarData[carid][carSALE],
        CarData[carid][carSALE_PRICE],
        CarData[carid][carSTEREO],
        CarData[carid][carPANELS],
        CarData[carid][carDOORS],
        CarData[carid][carLIGHTS],
        CarData[carid][carTIRES],
        CarData[carid][carDAMAGE],
        CarData[carid][carLIGHTS_STATUS],
        CarData[carid][carSTATION_URL],
        CarData[carid][carCEPO],
        CarData[carid][carLAST_USER],
		CarData[carid][carSQL_ID]
	);

	mysql_tquery(SQL_CONNECTION, query);

 	query[0] = '\0';
	format(query, sizeof(query), "UPDATE `cars` SET `carTRUNK_1` = '%d', `carTRUNK_2` = '%d', `carTRUNK_3` = '%d', `carTRUNK_4` = '%d', `carTRUNK_5` = '%d', `carTRUNK_6` = '%d', \
		`carTRUNK_7` = '%d', `carTRUNK_8` = '%d', `carTRUNK_9` = '%d', `carTRUNK_10` = '%d' WHERE `carSQL_ID` = '%d'",
		CarData[carid][carTRUNK][0],
		CarData[carid][carTRUNK][1],
		CarData[carid][carTRUNK][2],
		CarData[carid][carTRUNK][3],
		CarData[carid][carTRUNK][4],
		CarData[carid][carTRUNK][5],
		CarData[carid][carTRUNK][6],
		CarData[carid][carTRUNK][7],
		CarData[carid][carTRUNK][8],
		CarData[carid][carTRUNK][9],
		CarData[carid][carSQL_ID]
	);

	mysql_tquery(SQL_CONNECTION, query);

    query[0] = '\0';
	format(query, sizeof(query), "UPDATE `cars` SET `carTRUNK_QUANTITY_1` = '%d', `carTRUNK_QUANTITY_2` = '%d', `carTRUNK_QUANTITY_3` = '%d', `carTRUNK_QUANTITY_4` = '%d', \
		`carTRUNK_QUANTITY_5` = '%d', `carTRUNK_QUANTITY_6` = '%d', `carTRUNK_QUANTITY_7` = '%d', `carTRUNK_QUANTITY_8` = '%d', `carTRUNK_QUANTITY_9` = '%d', \
		`carTRUNK_QUANTITY_10` = '%d' WHERE `carSQL_ID` = '%d'",
		CarData[carid][carTRUNK_QUANTITY][0],
		CarData[carid][carTRUNK_QUANTITY][1],
		CarData[carid][carTRUNK_QUANTITY][2],
		CarData[carid][carTRUNK_QUANTITY][3],
		CarData[carid][carTRUNK_QUANTITY][4],
		CarData[carid][carTRUNK_QUANTITY][5],
		CarData[carid][carTRUNK_QUANTITY][6],
		CarData[carid][carTRUNK_QUANTITY][7],
		CarData[carid][carTRUNK_QUANTITY][8],
		CarData[carid][carTRUNK_QUANTITY][9],
		CarData[carid][carSQL_ID]
	);

	mysql_tquery(SQL_CONNECTION, query);

    query[0] = '\0';
 	format(query, sizeof(query), "UPDATE `cars` SET `carGLOVE_BOX` = '%d', `carGLOVE_BOX_QUANTITY` = '%d' WHERE `carSQL_ID` = '%d'",
		CarData[carid][carGLOVE_BOX],
		CarData[carid][carGLOVE_BOX_QUANTITY],
		CarData[carid][carSQL_ID]
	);

	mysql_tquery(SQL_CONNECTION, query);
	return true;
}

Car_PublicSave(carid)
{
	static
	    query[1715];

	if (CarData[carid][carVEHICLE] != INVALID_VEHICLE_ID)
	{
        CarData[carid][carGAS] = CoreVehicles[CarData[carid][carVEHICLE]][vehFuel];

       	CarData[carid][carKMS] = CoreVehicles[CarData[carid][carVEHICLE]][vehCoreKMS];
		CarData[carid][carMETERS] = CoreVehicles[CarData[carid][carVEHICLE]][vehCoreMeters];
		
		CarData[carid][carWORLD] = GetVehicleVirtualWorld(CarData[carid][carVEHICLE]);
	}

	query[0] = '\0';
	format(query, sizeof(query), "UPDATE `cars` SET `carMODEL` = '%d', `carOWNER` = '%d', `carOWNER_NAME` = '%s', `carCOLOR_1` = '%d', `carCOLOR_2` = '%d', \
		`carPAINT_JOB` = '%d', `carLOCKED` = '%d', `carGAS` = '%d', `carKMS` = '%d', `carMETERS` = '%d', `carVALUE` = '%d', `carPLATE` = '%s'  WHERE `carSQL_ID` = '%d'",
        CarData[carid][carMODEL],
        CarData[carid][carOWNER],
        Return_Escaped(CarData[carid][carOWNER_NAME]),
        CarData[carid][carCOLOR_1],
        CarData[carid][carCOLOR_2],
        CarData[carid][carPAINT_JOB],
        CarData[carid][carLOCKED],
        CarData[carid][carGAS],
        CarData[carid][carKMS],
        CarData[carid][carMETERS],
		CarData[carid][carVALUE],
        Return_Escaped(CarData[carid][carPLATE]),
        CarData[carid][carSQL_ID]
	);

	mysql_tquery(SQL_CONNECTION, query);

    query[0] = '\0';
 	format(query, sizeof(query), "UPDATE `cars` SET `carMECHANICAL_INSIDE` = '%d', `carWORLD` = '%s', `carINTERIOR` = '%d', `carCALL_SIGN` = '%d', \
	 	`carCALL_SIGN_NAME` = '%s', `carASIGN` = '%d', `carASIGN_NAME` = '%s', `carTAKEN` = '%d', `carTAKEN_NAME` = '%s', `carIMPOUNDED` = '%d', \
	 	`carIMPOUND_PRICE` = '%d' WHERE `carSQL_ID` = '%d'",
		CarData[carid][carMECHANICAL_INSIDE],
		CarData[carid][carWORLD],
		CarData[carid][carINTERIOR],
		CarData[carid][carCALL_SIGN],
		Return_Escaped(CarData[carid][carCALL_SIGN_NAME]),
        CarData[carid][carASIGN],
        Return_Escaped(CarData[carid][carASIGN_NAME]),
        CarData[carid][carTAKEN],
        Return_Escaped(CarData[carid][carTAKEN_NAME]),
        CarData[carid][carIMPOUNDED],
        CarData[carid][carIMPOUND_PRICE],
        CarData[carid][carSQL_ID]
    );

	mysql_tquery(SQL_CONNECTION, query);

    query[0] = '\0';
	format(query, sizeof(query), "UPDATE `cars` SET `carFACTION` = '%d', `carJOB` = '%d', `carDMV` = '%d', `carBIZ` = '%d', `carRENT` = '%d', \
		`carRENT_PRICE` = '%d', `carSALE` = '%d', `carSALE_PRICE` = '%d', `carSTATION_URL` = '%d', `carLAST_USER` = '%s' WHERE `carSQL_ID` = '%d'",
     	CarData[carid][carFACTION],
        CarData[carid][carJOB],
        CarData[carid][carDMV],
        CarData[carid][carBIZ],
        CarData[carid][carRENT],
        CarData[carid][carRENT_PRICE],
        CarData[carid][carSALE],
        CarData[carid][carSALE_PRICE],
        CarData[carid][carSTATION_URL],
        CarData[carid][carLAST_USER],
		CarData[carid][carSQL_ID]
	);

	mysql_tquery(SQL_CONNECTION, query);

 	query[0] = '\0';
	format(query, sizeof(query), "UPDATE `cars` SET `carTRUNK_1` = '%d', `carTRUNK_2` = '%d', `carTRUNK_3` = '%d', `carTRUNK_4` = '%d', `carTRUNK_5` = '%d', `carTRUNK_6` = '%d', \
		`carTRUNK_7` = '%d', `carTRUNK_8` = '%d', `carTRUNK_9` = '%d', `carTRUNK_10` = '%d' WHERE `carSQL_ID` = '%d'",
		CarData[carid][carTRUNK][0],
		CarData[carid][carTRUNK][1],
		CarData[carid][carTRUNK][2],
		CarData[carid][carTRUNK][3],
		CarData[carid][carTRUNK][4],
		CarData[carid][carTRUNK][5],
		CarData[carid][carTRUNK][6],
		CarData[carid][carTRUNK][7],
		CarData[carid][carTRUNK][8],
		CarData[carid][carTRUNK][9],
		CarData[carid][carSQL_ID]
	);

	mysql_tquery(SQL_CONNECTION, query);

    query[0] = '\0';
	format(query, sizeof(query), "UPDATE `cars` SET `carTRUNK_QUANTITY_1` = '%d', `carTRUNK_QUANTITY_2` = '%d', `carTRUNK_QUANTITY_3` = '%d', `carTRUNK_QUANTITY_4` = '%d', \
		`carTRUNK_QUANTITY_5` = '%d', `carTRUNK_QUANTITY_6` = '%d', `carTRUNK_QUANTITY_7` = '%d', `carTRUNK_QUANTITY_8` = '%d', `carTRUNK_QUANTITY_9` = '%d', \
		`carTRUNK_QUANTITY_10` = '%d' WHERE `carSQL_ID` = '%d'",
		CarData[carid][carTRUNK_QUANTITY][0],
		CarData[carid][carTRUNK_QUANTITY][1],
		CarData[carid][carTRUNK_QUANTITY][2],
		CarData[carid][carTRUNK_QUANTITY][3],
		CarData[carid][carTRUNK_QUANTITY][4],
		CarData[carid][carTRUNK_QUANTITY][5],
		CarData[carid][carTRUNK_QUANTITY][6],
		CarData[carid][carTRUNK_QUANTITY][7],
		CarData[carid][carTRUNK_QUANTITY][8],
		CarData[carid][carTRUNK_QUANTITY][9],
		CarData[carid][carSQL_ID]
	);

	mysql_tquery(SQL_CONNECTION, query);

    query[0] = '\0';
 	format(query, sizeof(query), "UPDATE `cars` SET `carGLOVE_BOX` = '%d', `carGLOVE_BOX_QUANTITY` = '%d' WHERE `carSQL_ID` = '%d'",
		CarData[carid][carGLOVE_BOX],
		CarData[carid][carGLOVE_BOX_QUANTITY],
		CarData[carid][carSQL_ID]
	);

	mysql_tquery(SQL_CONNECTION, query);
	return true;
}

stock Car_Spawn(carid)
{
	if (carid != -1 && CarData[carid][carEXISTS])
	{
		if (IsValidVehicle(CarData[carid][carVEHICLE]))
		    DestroyVehicle(CarData[carid][carVEHICLE]);

		if (CarData[carid][carCOLOR_1] == -1)
		    CarData[carid][carCOLOR_1] = random(127);

		if (CarData[carid][carCOLOR_2] == -1)
		    CarData[carid][carCOLOR_2] = random(127);

		CarData[carid][carVEHICLE] = CreateVehicle(CarData[carid][carMODEL], CarData[carid][carPOSITION][0], CarData[carid][carPOSITION][1], CarData[carid][carPOSITION][2], CarData[carid][carPOSITION][3], CarData[carid][carCOLOR_1], CarData[carid][carCOLOR_2], (CarData[carid][carOWNER] != 0) ? (-1) : (1200000));

		if (CarData[carid][carVEHICLE] != INVALID_VEHICLE_ID)
        {
            if (CarData[carid][carPAINT_JOB] != -1) ChangeVehiclePaintjob(CarData[carid][carVEHICLE], CarData[carid][carPAINT_JOB]);

			for (new i = 0; i < 14; i ++) if (CarData[carid][carMODS][i]) AddVehicleComponent(CarData[carid][carVEHICLE], CarData[carid][carMODS][i]);

   			if (CarData[carid][carCALL_SIGN] == 0)
			{
	      	    new
	  				matricula[32];

		    	format(matricula, sizeof(matricula), "%s", CarData[carid][carPLATE]);
		    	SetVehicleNumberPlate(CarData[carid][carVEHICLE], matricula);
			}

			if (CarData[carid][carDAMAGE] < 300.0) CarData[carid][carDAMAGE] = 300.0;
			else if (CarData[carid][carDAMAGE] > 1000.0) CarData[carid][carDAMAGE] = 1000.0;

   			SetVehicleHealth(CarData[carid][carVEHICLE], CarData[carid][carDAMAGE]);

      		UpdateVehicleDamageStatus(CarData[carid][carVEHICLE], CarData[carid][carPANELS], CarData[carid][carDOORS], CarData[carid][carLIGHTS], CarData[carid][carTIRES]);

			SetVehicleVirtualWorld(CarData[carid][carVEHICLE], CarData[carid][carWORLD]);
		    LinkVehicleToInterior(CarData[carid][carVEHICLE], CarData[carid][carINTERIOR]);

			ResetVehicle(CarData[carid][carVEHICLE]);
			CoreVehicles[CarData[carid][carVEHICLE]][vehFuel] = CarData[carid][carGAS];

			CoreVehicles[CarData[carid][carVEHICLE]][vehCoreKMS] = CarData[carid][carKMS];
			CoreVehicles[CarData[carid][carVEHICLE]][vehCoreMeters] = CarData[carid][carMETERS];

			if (IsAPublicVehicle(carid))
			{
			    CarData[carid][carLIGHTS_STATUS] = 0;

				ResetVehicle(CarData[carid][carVEHICLE]);
				RepairVehicle(CarData[carid][carVEHICLE]);

                CarData[carid][carLOCKED] = false;

				if (CarData[carid][carFACTION] == 0)
				{
     				CoreVehicles[CarData[carid][carVEHICLE]][vehFuel] = 100;

	    			CarData[carid][carINTERIOR] = 0;
				    CarData[carid][carWORLD] = 0;

			    	SetVehicleVirtualWorld(CarData[carid][carVEHICLE], 0);
			    	LinkVehicleToInterior(CarData[carid][carVEHICLE], 0);
				}
			}

   		   	if (CarData[carid][carLIGHTS_STATUS] == 0) SetLightStatus(CarData[carid][carVEHICLE], false);
  			else if (CarData[carid][carLIGHTS_STATUS] != 0) SetLightStatus(CarData[carid][carVEHICLE], true);

            if (CarData[carid][carFACTION] != -1 || CarData[carid][carJOB] != -1 || CarData[carid][carDMV] != 0) CarData[carid][carLOCKED] = true;

   			if (CarData[carid][carLOCKED])
			{
			    new
					engine, lights, alarm, doors, bonnet, boot, objective;

				GetVehicleParamsEx(CarData[carid][carVEHICLE], engine, lights, alarm, doors, bonnet, boot, objective);
			    SetVehicleParamsEx(CarData[carid][carVEHICLE], engine, lights, alarm, 1, bonnet, boot, objective);
			}
		}
	}
	return false;
}

forward OnCarCreated(carid);
public OnCarCreated(carid)
{
	if (carid == -1 || !CarData[carid][carEXISTS])
	    return false;

	CarData[carid][carSQL_ID] = cache_insert_id(SQL_CONNECTION),
	Car_Save(carid);

	new
		plate[32];
		
	format(plate, sizeof(plate), "%s", CarData[carid][carPLATE]);
	SetVehicleNumberPlate(CarData[carid][carVEHICLE], plate);
	return true;
}

forward Car_Load();
public Car_Load()
{
	static
	    rows,
	    fields,
		str[389];

	cache_get_data(rows, fields, SQL_CONNECTION);

	for (new i = 0; i < rows; i ++) if (i < MAX_DYNAMIC_CARS)
	{
	    CarData[i][carEXISTS] = true;
	    CarData[i][carSQL_ID] = cache_get_field_int(i, "carSQL_ID");
	    CarData[i][carMODEL] = cache_get_field_int(i, "carMODEL");

	    CarData[i][carOWNER] = cache_get_field_int(i, "carOWNER");
     	cache_get_field_content(i, "carOWNER_NAME", CarData[i][carOWNER_NAME], SQL_CONNECTION, 24);
     
	    CarData[i][carPOSITION][0] = cache_get_field_float(i, "carPOSITION_X");
	    CarData[i][carPOSITION][1] = cache_get_field_float(i, "carPOSITION_Y");
	    CarData[i][carPOSITION][2] = cache_get_field_float(i, "carPOSITION_Z");
	    CarData[i][carPOSITION][3] = cache_get_field_float(i, "carPOSITION_ANGLE");
	    CarData[i][carCOLOR_1] = cache_get_field_int(i, "carCOLOR_1");
	    CarData[i][carCOLOR_2] = cache_get_field_int(i, "carCOLOR_2");
	    CarData[i][carPAINT_JOB] = cache_get_field_int(i, "carPAINT_JOB");
	    CarData[i][carLOCKED] = cache_get_field_int(i, "carLOCKED");
	    
   		for (new j = 0; j < 14; j ++)
		{
	        format(str, sizeof(str), "carMOD_%d", j + 1);
	        CarData[i][carMODS][j] = cache_get_field_int(i, str);
	    }

        CarData[i][carGAS] = cache_get_field_int(i, "carGAS");
       	CarData[i][carKMS] = cache_get_field_content_int(i, "carKMS");
  		CarData[i][carMETERS] = cache_get_field_content_int(i, "carMETERS");
  		
  		CarData[i][carVALUE] = cache_get_field_int(i, "carVALUE");
  		cache_get_field_content(i, "carPLATE", CarData[i][carPLATE], SQL_CONNECTION, 13);

        CarData[i][carMECHANICAL_INSIDE] = cache_get_field_content_int(i, "carMECHANICAL_INSIDE");
		CarData[i][carWORLD] = cache_get_field_content_int(i, "carWORLD");
		CarData[i][carINTERIOR] = cache_get_field_content_int(i, "carINTERIOR");
  		CarData[i][carTIME_FADING] = cache_get_field_int(i, "carTIME_FADING");
  		
    	CarData[i][carCALL_SIGN] = cache_get_field_int(i, "carCALL_SIGN");
        cache_get_field_content(i, "carCALL_SIGN_NAME", CarData[i][carCALL_SIGN_NAME], SQL_CONNECTION, 32);
        
   		CarData[i][carASIGN] = cache_get_field_content_int(i, "carASIGN");
		cache_get_field_content(i, "carASIGN_NAME", CarData[i][carASIGN_NAME], SQL_CONNECTION, 24);

  		CarData[i][carTAKEN] = cache_get_field_content_int(i, "carTAKEN");
  		cache_get_field_content(i, "carTAKEN_NAME", CarData[i][carTAKEN_NAME], SQL_CONNECTION, 24);
  		
	    CarData[i][carIMPOUNDED] = cache_get_field_int(i, "carIMPOUNDED");
	    CarData[i][carIMPOUND_PRICE] = cache_get_field_int(i, "carIMPOUND_PRICE");
        CarData[i][carFACTION] = cache_get_field_int(i, "carFACTION");
        CarData[i][carJOB] = cache_get_field_int(i, "carJOB");
        CarData[i][carDMV] = cache_get_field_int(i, "carDMV");
        CarData[i][carBIZ] = cache_get_field_content_int(i, "carBIZ");
		CarData[i][carRENT] = cache_get_field_content_int(i, "carRENT");
  		CarData[i][carRENT_PRICE] = cache_get_field_content_int(i, "carRENT_PRICE");
		CarData[i][carSALE] = cache_get_field_content_int(i, "carSALE");
  		CarData[i][carSALE_PRICE] = cache_get_field_content_int(i, "carSALE_PRICE");
        CarData[i][carSTEREO] = cache_get_field_int(i, "carSTEREO");
		CarData[i][carPANELS] = cache_get_field_content_int(i, "carPANELS");
		CarData[i][carDOORS] = cache_get_field_content_int(i, "carDOORS");
		CarData[i][carLIGHTS] = cache_get_field_content_int(i, "carLIGHTS");
		CarData[i][carTIRES] = cache_get_field_content_int(i, "carTIRES");
        CarData[i][carDAMAGE] = cache_get_field_content_float(i, "carDAMAGE");
        CarData[i][carLIGHTS_STATUS] = cache_get_field_content_int(i, "carLIGHTS_STATUS");
        
        cache_get_field_content(i, "carSTATION_URL", CarData[i][carSTATION_URL], SQL_CONNECTION, 128);
  		
  		CarData[i][carGLOVE_BOX] = cache_get_field_content_int(i, "carGLOVE_BOX");
  		CarData[i][carGLOVE_BOX_QUANTITY] = cache_get_field_content_int(i, "carGLOVE_BOX_QUANTITY");

	    CarData[i][carTRUNK_SLOTS] = GetTrunkSlots(CarData[i][carMODEL]);

	    for (new j = 0; j < CarData[i][carTRUNK_SLOTS]; j ++)
		{
	        format(str, sizeof(str), "carTRUNK_%d", j + 1);
	        CarData[i][carTRUNK][j] = cache_get_field_int(i, str);

	        format(str, sizeof(str), "carTRUNK_QUANTITY_%d", j + 1);
	        CarData[i][carTRUNK_QUANTITY][j] = cache_get_field_int(i, str);
	    }

        CarData[i][carCEPO] = cache_get_field_content_int(i, "carCEPO");
        
  		cache_get_field_content(i, "carLAST_USER", CarData[i][carLAST_USER], SQL_CONNECTION, 60);
  		
	    Car_Spawn(i);
	}
	return true;
}
