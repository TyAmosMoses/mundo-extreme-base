/* Mapeos de Mundo Extreme*/

#define TOLL_COST (50) // Costo del peaje
#define TOLL_DELAY_COP (4) // Tiempo del peaje
#define TOLL_OPEN_DISTANCE (3.0) // Distancia apta para accionar
#define MAX_TOLLS (10)

new Float:TollGatePosition[10][3] =
{
    {607.9684, -1194.2866, 19.0043}, // Richman
	{623.9500, -1183.9774, 19.2260}, // Richman
 	{39.7039, -1522.9891, 5.1995}, // Flint
 	{62.7378, -1539.9891, 5.0639}, // Flint
 	{1778.9886, 702.6728, 15.2574}, // LV
    {1795.9447, 704.2550, 15.0006}, // LV
    {612.53070, 346.59592, 17.92614}, // BLR
    {604.37152, 346.88141, 17.92614}, // BLR
    {-195.2768,252.2416,12.0781}, // BLL
    {-199.5153,260.3405,12.0781} // BLL
};

new Float:TollGateRotation[10][2] =
{
 	{0.000000, 23.81982421875},
	{0.000000, 214.37744140625},
	{0.000000, 270.67565917969},
	{0.000000, 87.337799072266},
	{0.000000, 348.10229492188},
	{0.000000, 169.43664550781},
	{0.00000, 35.00000},
	{0.00000, 215.92000},
	{0.00000, -14.94000},
	{0.00000, -195.00000}
};

new
	TollObject[MAX_TOLLS];

enum TOLL_ENUM
{
	tollLocked,  // 0 & 1 = Richman, 2 & 3 = Flint, 4 & 5 = LV, 6 & 7 = Blueberry
	tollOpenTime // 0 & 1 = Richman, 2 & 3 = Flint, 4 & 5 = LV, 6 & 7 = Blueberry
}
new TollData[MAX_TOLLS][TOLL_ENUM];

Toll_CloseToll(tollid)
{
    SetDynamicObjectRot(TollObject[tollid], TollGateRotation[tollid][0], -90.0, TollGateRotation[tollid][1]);
	return true;
}

Toll_OpenToll(tollid)
{
	TollData[tollid][tollOpenTime] = 7;
	SetDynamicObjectRot(TollObject[tollid], TollGateRotation[tollid][0], 0.0, TollGateRotation[tollid][1]);
	return true;
}

/* Create */
stock Maps_Create()
{
	// Alhambra
 	CreateDynamicObject(5408, 1889.57141, -1682.14136, 34.79260,   0.00000, 0.00000, -180.00000, -1, -1, -1, 300.0);
	CreateDynamicObject(1533, 1926.05408, -1686.73755, 12.31270,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1533, 1926.05408, -1685.21753, 12.31270,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1533, 1926.05408, -1683.69995, 12.31270,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1533, 1926.05408, -1682.18005, 12.31270,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1533, 1926.05408, -1680.66003, 12.31270,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1533, 1926.05408, -1679.14502, 12.31270,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(620, 1835.02686, -1726.85876, 9.71875,   356.85840, 0.00000, -2.93215);
	CreateDynamicObject(620, 1842.84167, -1627.99976, 9.71875,   356.85840, 0.00000, -2.93215);
	CreateDynamicObject(620, 1841.52454, -1738.61584, 9.71875,   356.85840, 0.00000, -2.93215);
	CreateDynamicObject(620, 1836.16235, -1660.13342, 9.71875,   356.85840, 0.00000, -2.93215);
	CreateDynamicObject(620, 1838.48816, -1710.68274, 9.71875,   356.85840, 0.00000, -2.93215);

	/* Peajes */
	CreateDynamicObject(966,613.9722900,-1197.7174100,17.4750300,0.0000000,0.0000000,23.8200000); // Richman
	CreateDynamicObject(966,619.4291400,-1181.6597900,18.7250300,0.0000000,0.0000000,214.3770000);
	CreateDynamicObject(978,602.5300300,-1203.4530000,18.3230000,0.0000000,0.0000000,210.9350000);
	CreateDynamicObject(978,617.2069700,-1185.0639600,19.8470000,0.0000000,0.0000000,247.3620000);
	CreateDynamicObject(979,629.5009800,-1175.1540500,19.6140000,0.0000000,0.0000000,210.0000000);
	CreateDynamicObject(979,615.7869900,-1193.4639900,18.4990000,0.0000000,0.0000000,253.7500000);
	CreateDynamicObject(4642,613.6110200,-1193.1440400,19.7060000,0.0000000,0.0000000,31.1610000);
	CreateDynamicObject(4642,619.1859700,-1185.9379900,20.1340000,0.0000000,0.0000000,211.1670000);
	TollObject[0] = CreateDynamicObject(968, 613.8935546875, -1197.7329101563, 18.109180450439, 0.000000, -90.000000, 23.81982421875, -1 );
	TollObject[1] = CreateDynamicObject(968, 619.44201660156, -1181.6903076172, 19.525806427002, 0.000000, -90.000000, 214.37744140625, -1 );

	CreateDynamicObject(8168,61.2210000,-1532.8769500,5.9830000,0.0000000,0.0000000,6.5240000); // Flint County
	CreateDynamicObject(8168,41.4620000,-1529.3620600,6.1950000,0.0000000,0.0000000,186.5530000);
	CreateDynamicObject(966,35.8897500,-1526.0096400,4.2410600,0.0000000,0.0000000,270.6760000);
	CreateDynamicObject(966,67.0937300,-1536.8275100,3.9910600,0.0000000,0.0000000,87.3380000);
	CreateDynamicObject(997,66.2930000,-1547.0909400,4.1310000,0.0000000,0.0000000,82.5240000);
	CreateDynamicObject(997,34.0650000,-1516.4489700,4.3490000,0.0000000,0.0000000,299.9990000);
	CreateDynamicObject(997,35.8150000,-1526.3490000,4.2150000,0.0000000,0.0000000,307.6700000);
	CreateDynamicObject(997,64.8720000,-1533.9429900,4.2220000,0.0000000,0.0000000,312.1550000);
	CreateDynamicObject(994,51.3200000,-1531.4289600,4.2310000,0.0000000,0.0000000,352.8330000);
	CreateDynamicObject(994,45.0380000,-1530.6519800,4.2320000,0.0000000,0.0000000,352.8310000);
   	TollObject[2] = CreateDynamicObject(968, 35.838928222656, -1525.9034423828, 5.0012145042419, 0.000000, -90.000000, 270.67565917969, -1 );
 	TollObject[3] = CreateDynamicObject(968, 67.116600036621, -1536.8218994141, 4.7504549026489, 0.000000, -90.000000, 87.337799072266, -1 );

	CreateDynamicObject(8168,1789.7659900,703.2520100,15.9380000,1.0070000,3.0090000,98.8260000); // Las Venturas
	CreateDynamicObject(8168,1784.8330100,703.9470200,15.9450000,358.0590000,356.9890000,278.5100000);
	CreateDynamicObject(966,1781.4122300,697.3253200,14.6369100,0.0000000,0.0000000,348.0900000);
	CreateDynamicObject(997,1781.7650100,697.2990100,14.6460000,0.0000000,2.9990000,79.9900000);
	CreateDynamicObject(997,1792.7960200,706.3800000,13.9300000,0.0000000,2.9990000,81.3760000);
	CreateDynamicObject(966,1793.4289600,709.8798200,13.6369100,0.0000000,0.0000000,169.4370000);
	CreateDynamicObject(979,1771.3859900,702.2100200,15.0440000,0.0000000,0.0000000,307.2160000);
	CreateDynamicObject(979,1803.6180400,704.8200100,14.6030000,0.0000000,0.0000000,125.6040000);
   	TollObject[4] = CreateDynamicObject(968, 1781.4133300781, 697.31750488281, 15.420023918152, 0.000000, -90.000000, 348.10229492188, -1 );
 	TollObject[5] = CreateDynamicObject(968, 1793.6700439453, 709.84631347656, 14.405718803406, 0.000000, -90.000000, 169.43664550781, -1 );

	CreateDynamicObject(966, 614.42188, 350.81711, 17.92480, 0.00000, 0.00000, 35.00000); // Derecha de Blueberry
	CreateDynamicObject(966, 602.91162, 342.59781, 17.92480, 0.00000, 0.00000, 215.92000);
	TollObject[6] = CreateDynamicObject(968, 614.42188, 350.81711, 18.66520, 0.00000, -90.00000, 35.00000);
	TollObject[7] = CreateDynamicObject(968, 602.91162, 342.59781, 18.66520, 0.00000, -90.00000, 215.92000);

	CreateDynamicObject(966, -190.35580, 254.64290, 11.07090, 0.00000, 0.00000, 345.00000); // Izquierda de Blueberry
	CreateDynamicObject(966, -204.00880, 258.30411, 11.07090, 0.00000, 0.00000, -195.00000);
	TollObject[8] = CreateDynamicObject(968, -190.24850, 254.62019, 11.89360, 0.00000, -90.00000, -14.94000);
	TollObject[9] = CreateDynamicObject(968, -204.10410, 258.34149, 11.89360, 0.00000, -90.00000, -195.00000);

	/* Ayuntamiento, exterior */
 	SetObjectMaterialText(CreateObject(4238, 1481.76172, -1750.65906, 28.50000,   0.00000, 0.00000, 210.00000, 300.0),
	 	"{2B2B2B}AYUNTAMIENTO", 0, OBJECT_MATERIAL_SIZE_256x128, "Arial", 25, 1, 0xFFFFFFFF, 0, 1);

   	/* Comisaría, exterior */
	new TextureLVPDinLSPD[2];
	TextureLVPDinLSPD[0] = CreateObject(3976, 1571.60, -1675.75, 35.68,   0.00, 0.00, 0.00, 300.0);
	TextureLVPDinLSPD[1] = CreateObject(3975, 1578.47, -1676.42, 13.07,   0.00, 0.00, 0.00, 300.0);

	SetObjectMaterialText(CreateObject(4238, 1555.0456, -1675.6361, 22.8038, 0.0000, 0.0000, -59.7282, 300.0), "{2B2B2B}COMISARÍA", 0, 120, "Arial", 30, 1, 0xFFFFFFFF, 0x0, 1);
	SetObjectMaterialText(CreateObject(4238, 1555.0355, -1675.6188, 21.8538, 0.0000, 0.0000, -59.7282, 300.0), "{2B2B2B}Pershing Square", 0, 120, "Arial", 20, 1, 0xFFFFFFFF, 0x0, 1);

	SetObjectMaterial(TextureLVPDinLSPD[0], 9, 8419, "vgsbldng1", "buildng01_64", 0); //Techo
	SetObjectMaterial(TextureLVPDinLSPD[0], 6, 8419, "vgsbldng1", "buildng01_64", 0); //Ventanas Arriba y Columnas
	SetObjectMaterial(TextureLVPDinLSPD[0], 7, 8419, "vgsbldng1", "buildng01_64", 0); //Pared Punta
	SetObjectMaterial(TextureLVPDinLSPD[0], 5, 8419, "vgsbldng1", "buildng01_64", 0); //Puerta Borde Arriba
	SetObjectMaterial(TextureLVPDinLSPD[0], 4, 8419, "vgsbldng1", "buildng01_64", 0); //Puerta Borde Abajo
	SetObjectMaterial(TextureLVPDinLSPD[0], 2, 8419, "vgsbldng1", "buildng01_64", 0); //Puerta Frente Vidrios
	SetObjectMaterial(TextureLVPDinLSPD[0], 8, 8419, "vgsbldng1", "buildng01_64", 0); //Pared Atras
	SetObjectMaterial(TextureLVPDinLSPD[0], 13, 8419, "vgsbldng1", "buildng01_64", 0); //Frente Borde Abajo
	SetObjectMaterial(TextureLVPDinLSPD[1], 11, 8419, "vgsbldng1", "buildng01_64", 0); //Pared Cabina
	SetObjectMaterial(TextureLVPDinLSPD[1], 4, 8419, "vgsbldng1", "buildng01_64", 0); //Borde Escaleras
	SetObjectMaterial(TextureLVPDinLSPD[1], 8, 8419, "vgsbldng1", "buildng01_64", 0); //Pared Estacionamiento
	SetObjectMaterial(TextureLVPDinLSPD[1], 15, 8079, "vgsshospshop", "chr_flags_256", 0); //Piso General
	SetObjectMaterial(TextureLVPDinLSPD[1], 14, 8079, "vgsshospshop", "chr_flags_256", 0); //Piso Atras
	
 	/* Apartamento #1 por Gigistone */
 	new
 	    gobj;
 	    
	gobj = CreateDynamicObject(14861,1848.393,-2363.947,2486.071,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14569, "traidman", "chinese8", 0);
	gobj = CreateDynamicObject(2087,1843.035,-2364.114,2485.624,0.000,0.000,90.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14569, "traidman", "pagodaroof4", 0);
	gobj = CreateDynamicObject(2314,1847.336,-2359.583,2485.624,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14569, "traidman", "pagodaroof4", 0);
	gobj = CreateDynamicObject(1781,1848.891,-2359.228,2486.127,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 10052, "lomall", "zombiegeddon", 0);
	SetDynamicObjectMaterial(gobj, 3, 10052, "lomall", "zombiegeddon", 0);
	gobj = CreateDynamicObject(19377,1846.522,-2362.646,2485.531,0.000,90.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 18038, "vegas_munation", "mp_gun_floorred", 0);
	gobj = CreateDynamicObject(19450,1849.463,-2362.304,2487.368,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 8663, "triadcasino", "imperial02_64", 0);
	gobj = CreateDynamicObject(19450,1842.790,-2362.304,2487.368,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 8663, "triadcasino", "imperial02_64", 0);
	gobj = CreateDynamicObject(19450,1846.097,-2365.673,2487.368,0.000,0.000,90.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 8663, "triadcasino", "imperial02_64", 0);
	gobj = CreateDynamicObject(19450,1846.097,-2359.001,2487.368,0.000,0.000,90.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 8663, "triadcasino", "imperial02_64", 0);
	gobj = CreateDynamicObject(19378,1846.522,-2362.646,2489.199,0.000,90.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 7978, "vgssairport", "newall_harling_sless", 0);
	gobj = CreateDynamicObject(19172,1846.615,-2359.086,2487.447,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 17298, "weefarmcuntw", "sjmbigoldwin", 0);
	gobj = CreateDynamicObject(19166,1849.368,-2364.014,2487.877,90.000,0.000,-90.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 1, 6357, "sunstrans_law2", "SunBillB05", 0);
	gobj = CreateDynamicObject(1759,1848.891,-2361.240,2485.618,0.000,0.000,-96.360,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 18064, "ab_sfammuunits", "rubber_mat", 0);
	SetDynamicObjectMaterial(gobj, 1, 10765, "airportgnd_sfse", "coasty_bit3_sfe", 0);
	gobj = CreateDynamicObject(1759,1845.287,-2359.812,2485.618,0.000,0.000,11.880,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 18064, "ab_sfammuunits", "rubber_mat", 0);
	SetDynamicObjectMaterial(gobj, 1, 10765, "airportgnd_sfse", "coasty_bit3_sfe", 0);
	CreateDynamicObject(1718,1848.107,-2359.664,2486.187,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(2147,1844.211,-2359.645,2485.631,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(2843,1846.466,-2364.676,2485.624,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(1738,1845.062,-2365.374,2486.279,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(2819,1843.500,-2365.316,2485.624,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(2838,1845.998,-2364.732,2485.624,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(2867,1847.363,-2359.727,2486.127,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(1486,1843.273,-2364.137,2486.934,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(1509,1844.237,-2359.430,2487.579,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(1668,1844.461,-2359.430,2487.563,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(1535,1842.843,-2360.227,2485.617,0.000,0.000,-90.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(2149,1843.232,-2363.220,2486.905,0.000,0.000,99.839,-1,13,-1,100.000,100.000);
	CreateDynamicObject(19575,1843.342,-2363.572,2486.790,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(19576,1843.161,-2363.628,2486.790,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(19575,1843.239,-2363.690,2486.790,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(19896,1843.251,-2363.976,2486.765,0.000,0.000,109.800,-1,13,-1,100.000,100.000);
	CreateDynamicObject(1893,1845.490,-2361.935,2489.372,0.000,0.000,0.000,-1,13,-1,100.000,100.000);

	/* Apartamento #2 por Gigistone */
 	gobj = CreateDynamicObject(1802,2617.571,-1809.137,615.533,0.000,0.000,90.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14534, "ab_wooziea", "carp02S", 0);
	SetDynamicObjectMaterial(gobj, 2, 14650, "ab_trukstpc", "sa_wood08_128", 0);
	gobj = CreateDynamicObject(2296,2620.663,-1808.544,615.533,0.000,0.000,270.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 3, 14650, "ab_trukstpc", "sa_wood08_128", 0);
	SetDynamicObjectMaterial(gobj, 7, 14650, "ab_trukstpc", "sa_wood08_128", 0);
	gobj = CreateDynamicObject(19450,2621.069,-1812.410,617.276,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14534, "ab_wooziea", "walp72S", 0);
	gobj = CreateDynamicObject(19450,2617.693,-1807.528,617.276,0.000,0.000,90.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14534, "ab_wooziea", "walp72S", 0);
	gobj = CreateDynamicObject(19450,2618.175,-1816.938,617.295,0.000,0.000,90.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14534, "ab_wooziea", "walp72S", 0);
	gobj = CreateDynamicObject(19450,2613.986,-1812.211,617.276,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14534, "ab_wooziea", "walp72S", 0);
	gobj = CreateDynamicObject(19450,2611.771,-1811.408,617.276,0.000,0.000,90.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14534, "ab_wooziea", "walp72S", 0);
	gobj = CreateDynamicObject(19388,2616.501,-1812.927,617.276,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14534, "ab_wooziea", "walp72S", 0);
	gobj = CreateDynamicObject(19450,2616.501,-1819.348,617.276,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14534, "ab_wooziea", "walp72S", 0);
	gobj = CreateDynamicObject(19450,2611.771,-1811.736,617.276,0.000,0.000,90.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14534, "ab_wooziea", "walp72S", 0);
	gobj = CreateDynamicObject(19376,2617.584,-1812.232,615.444,0.000,90.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14736, "whorerooms", "AH_grncarpet", 0);
	gobj = CreateDynamicObject(19450,2611.693,-1815.680,617.276,0.000,0.000,90.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14534, "ab_wooziea", "walp72S", 0);
	gobj = CreateDynamicObject(19172,2616.899,-1807.614,617.592,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14534, "ab_wooziea", "mcstraps_window", 0);
	gobj = CreateDynamicObject(19377,2617.584,-1812.232,618.999,0.000,90.000,0.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 4830, "airport2", "brnstucco1", 0);
	gobj = CreateDynamicObject(19167,2616.409,-1814.531,617.024,90.000,0.000,-90.000,-1,13,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 1, 11150, "ab_acc_control", "ab_BoltPanel2", 0);
	CreateDynamicObject(1535,2617.929,-1816.890,615.546,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(2528,2614.909,-1812.331,615.533,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(2739,2615.903,-1814.041,615.581,0.000,0.000,-90.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(2836,2615.005,-1814.026,615.527,0.000,0.000,-87.120,-1,13,-1,100.000,100.000);
	CreateDynamicObject(2147,2620.488,-1813.600,615.533,0.000,0.000,268.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(1502,2616.521,-1813.673,615.523,0.000,0.000,90.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(1760,2617.367,-1808.195,615.531,0.000,0.000,1.679,-1,13,-1,100.000,100.000);
	CreateDynamicObject(1755,2620.510,-1811.727,615.530,0.000,0.000,-106.379,-1,13,-1,100.000,100.000);
	CreateDynamicObject(19578,2620.535,-1813.405,617.358,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(2076,2615.228,-1813.909,619.359,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(1816,2615.029,-1810.400,615.530,0.000,0.000,181.859,-1,13,-1,100.000,100.000);
	CreateDynamicObject(2106,2614.310,-1811.044,616.036,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(2424,2620.675,-1815.888,615.531,0.000,0.000,-90.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(2424,2620.675,-1814.958,615.531,0.000,0.000,-90.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(11743,2620.585,-1816.007,616.586,0.000,0.000,-109.199,-1,13,-1,100.000,100.000);
	CreateDynamicObject(19835,2620.699,-1815.726,616.659,0.000,0.000,-7.199,-1,13,-1,100.000,100.000);
	CreateDynamicObject(19896,2620.530,-1815.165,616.602,0.000,0.000,-64.920,-1,13,-1,100.000,100.000);
	CreateDynamicObject(19820,2620.739,-1814.785,616.586,0.000,0.000,-37.319,-1,13,-1,100.000,100.000);
	CreateDynamicObject(19829,2616.591,-1811.697,616.595,0.000,0.000,90.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(14680,2620.699,-1814.930,617.434,0.000,0.000,0.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(19814,2617.333,-1816.849,615.842,0.000,0.000,180.000,-1,13,-1,100.000,100.000);
	CreateDynamicObject(19873,2614.308,-1812.428,615.589,0.000,0.000,0.000,-1,13,-1,100.000,100.000);

	/* Apartamento #3 por Gigistone */
 	gobj = CreateDynamicObject(14866,2174.118,-663.289,441.402,0.000,0.000,92.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 4828, "airport3_las", "gallery01_law", 0);
	SetDynamicObjectMaterial(gobj, 2, 14806, "bdupshifi", "Bdup2_wood", 0);
	SetDynamicObjectMaterial(gobj, 3, 14806, "bdupshifi", "Bdup2_wood", 0);
	gobj = CreateDynamicObject(2323,2175.167,-662.879,440.807,0.000,0.000,270.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14806, "bdupshifi", "Bdup2_wood", 0);
	gobj = CreateDynamicObject(2313,2179.006,-661.420,440.807,0.000,0.000,358.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 2, 14806, "bdupshifi", "Bdup2_wood", 0);
	gobj = CreateDynamicObject(1703,2180.604,-664.038,440.807,0.000,0.000,178.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 1, 14806, "bdupshifi", "Bdup2_wood", 0);
	gobj = CreateDynamicObject(19450,2179.951,-668.239,442.552,0.000,0.000,90.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19450,2182.025,-671.313,442.552,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19450,2182.025,-659.767,442.552,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19450,2177.593,-660.828,442.552,0.000,0.000,90.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19450,2172.070,-664.355,442.552,0.000,0.000,90.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19431,2176.802,-663.638,442.552,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19388,2176.800,-661.526,442.552,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19450,2175.645,-669.132,442.552,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19450,2186.756,-664.498,442.552,0.000,0.000,90.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19450,2184.325,-665.583,442.552,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19377,2179.566,-665.366,440.805,0.000,90.000,0.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14710, "vgshm3int2", "HSV_2carpet1", 0);
	gobj = CreateDynamicObject(19450,2172.695,-664.275,442.552,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19377,2169.066,-665.366,440.805,0.000,90.000,0.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14710, "vgshm3int2", "HSV_2carpet1", 0);
	gobj = CreateDynamicObject(11737,2178.645,-667.377,440.892,0.000,0.000,-9.300,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14817, "whore_rms", "WH_boa1", 0);
	gobj = CreateDynamicObject(19172,2179.619,-660.912,442.856,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 4828, "airport3_las", "gallery01_law", 0);
	gobj = CreateDynamicObject(19172,2172.785,-662.435,442.847,0.000,0.000,90.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 4828, "airport3_las", "gallery01_law", 0);
	gobj = CreateDynamicObject(19376,2179.566,-665.366,444.312,0.000,90.000,0.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_carpet1", 0);
	gobj = CreateDynamicObject(19376,2169.066,-665.366,444.312,0.000,90.000,0.000,-1,13,-1,40.000,40.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_carpet1", 0);
	CreateDynamicObject(1506,2177.918,-668.197,440.831,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(2147,2181.399,-667.619,440.807,0.000,0.000,180.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(2152,2182.960,-667.985,440.807,0.000,0.000,180.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(2836,2172.763,-662.346,440.807,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(1792,2179.561,-660.999,441.307,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(2028,2180.516,-661.472,441.390,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(11718,2182.507,-667.895,441.870,0.000,0.000,221.279,-1,13,-1,40.000,40.000);
	CreateDynamicObject(11706,2183.783,-665.052,440.892,0.000,0.000,-13.619,-1,13,-1,40.000,40.000);
	CreateDynamicObject(2152,2184.333,-667.985,440.807,0.000,0.000,180.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(19933,2183.102,-667.728,441.073,0.000,0.000,-90.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(11723,2183.999,-667.962,441.995,0.000,0.000,-35.099,-1,13,-1,40.000,40.000);
	CreateDynamicObject(11721,2176.894,-663.288,441.612,0.000,0.000,90.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(11715,2182.716,-667.914,441.869,0.000,0.000,-14.640,-1,13,-1,40.000,40.000);
	CreateDynamicObject(11687,2176.229,-664.976,440.883,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(2725,2176.216,-666.244,441.289,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(1670,2176.249,-666.217,441.738,0.000,0.000,-130.380,-1,13,-1,40.000,40.000);
	CreateDynamicObject(11687,2176.147,-667.664,440.883,0.000,0.000,-26.340,-1,13,-1,40.000,40.000);
	CreateDynamicObject(19823,2178.744,-661.402,441.305,0.000,0.000,11.520,-1,13,-1,40.000,40.000);
	CreateDynamicObject(957,2176.237,-666.239,444.193,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(19571,2183.168,-667.665,441.883,90.000,0.000,-5.820,-1,13,-1,40.000,40.000);
	CreateDynamicObject(1734,2179.941,-662.758,444.222,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(2819,2174.668,-662.553,440.893,0.000,0.000,-63.959,-1,13,-1,40.000,40.000);
	CreateDynamicObject(19896,2176.215,-662.556,441.824,0.000,0.000,-136.860,-1,13,-1,40.000,40.000);
	CreateDynamicObject(2916,2181.043,-664.097,441.007,0.000,0.000,-8.159,-1,13,-1,40.000,40.000);
	CreateDynamicObject(2916,2181.239,-663.787,441.007,0.000,0.000,-27.959,-1,13,-1,40.000,40.000);
	CreateDynamicObject(19814,2176.383,-668.149,441.184,0.000,0.000,180.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(19814,2181.288,-660.918,441.222,0.000,0.000,0.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(19826,2176.892,-662.470,441.892,0.000,0.000,90.000,-1,13,-1,40.000,40.000);
	CreateDynamicObject(19826,2181.936,-666.651,441.830,0.000,0.000,-90.000,-1,13,-1,40.000,40.000);

	/* Apartamento #4 por Gigistone */
 	gobj = CreateDynamicObject(19378,726.329,-1428.728,1200.233,0.000,90.000,0.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 14815, "whore_main", "WH_tiles2", 0);
	gobj = CreateDynamicObject(19458,726.743,-1432.914,1201.902,0.000,0.000,90.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19458,731.026,-1428.666,1201.902,0.000,0.000,0.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19458,731.067,-1429.372,1201.902,0.000,0.000,90.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19458,726.288,-1424.486,1201.902,0.000,0.000,90.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19458,717.848,-1427.218,1201.902,0.000,0.000,90.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19458,717.848,-1429.317,1201.902,0.000,0.000,90.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19458,722.593,-1434.054,1201.902,0.000,0.000,0.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19458,722.593,-1422.474,1201.902,0.000,0.000,0.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(19458,721.158,-1429.373,1201.902,0.000,0.000,0.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 14711, "vgshm2int2", "HSV_wall4", 0);
	gobj = CreateDynamicObject(2834,724.519,-1432.8330,1202.856,-90.000,0.000,0.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 9220, "sfn_apart02sfn", "newindow6", 0);
	gobj = CreateDynamicObject(2834,728.499,-1432.8330,1202.886,-90.000,0.000,0.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 9220, "sfn_apart02sfn", "newindow6", 0);
	gobj = CreateDynamicObject(2142,722.769,-1426.135,1200.321,0.000,0.000,90.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 14534, "ab_wooziea", "ab_tileDiamond", 0);
	SetDynamicObjectMaterial(gobj, 1, 14534, "ab_wooziea", "ab_tileDiamond", 0);
	SetDynamicObjectMaterial(gobj, 2, 3525, "excaliburtorch", "sw_cabinwall01", 0);
	gobj = CreateDynamicObject(19378,726.329,-1428.728,1203.537,0.000,90.000,0.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 8399, "vgs_shops", "vgsclubwall08_256", 0);
	gobj = CreateDynamicObject(2346,730.421,-1426.461,1200.319,0.000,0.000,-90.000,-1,13,-1,150.000,150.000);
	SetDynamicObjectMaterial(gobj, 0, 18056, "mp_diner1", "mp_CJ_CARDBOARD128", 0);
	CreateDynamicObject(1498,721.255,-1429.013,1200.280,0.000,0.000,90.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2833,722.456,-1428.757,1200.317,0.000,0.000,90.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(11712,722.688,-1426.845,1202.249,0.000,0.000,0.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(19827,722.690,-1427.152,1201.744,0.000,0.000,90.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(1757,729.499,-1428.896,1200.319,0.000,0.000,-180.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2069,730.579,-1429.003,1200.358,0.000,0.000,0.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2284,728.258,-1428.813,1202.052,0.000,2.000,180.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2275,729.486,-1428.780,1201.816,0.000,-2.000,180.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(19807,722.889,-1426.324,1201.432,0.000,0.000,112.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(19896,722.788,-1425.845,1201.372,0.000,0.000,20.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2073,725.778,-1426.851,1203.445,0.000,0.000,0.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(1755,728.629,-1425.122,1200.320,0.000,0.000,0.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(1755,727.442,-1425.177,1200.320,0.000,0.000,6.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2833,728.029,-1426.974,1200.321,0.000,0.000,0.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2833,728.029,-1428.072,1200.321,0.000,0.000,0.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(1781,730.727,-1427.149,1200.813,0.000,0.000,-90.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2273,730.440,-1427.852,1201.994,0.000,2.000,-90.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2274,730.445,-1426.545,1201.716,0.000,2.000,-90.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2274,730.445,-1426.285,1202.276,0.000,0.000,-90.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2816,730.470,-1426.941,1200.357,0.000,0.000,-52.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2132,730.504,-1429.964,1200.320,0.000,0.000,-90.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2340,730.520,-1431.966,1200.320,0.000,0.000,-90.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2131,727.440,-1429.838,1200.320,0.000,0.000,0.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(19585,730.640,-1431.901,1201.572,0.000,0.000,18.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2849,730.653,-1429.996,1201.371,0.000,0.000,-88.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2611,730.975,-1431.019,1201.976,0.000,0.000,-90.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2611,730.975,-1431.019,1202.096,0.000,0.000,-90.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2611,730.975,-1431.019,1202.216,0.000,0.000,-90.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2611,730.975,-1430.659,1201.956,0.000,0.000,-90.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2272,723.184,-1431.822,1201.838,0.000,2.000,90.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(2011,722.968,-1430.518,1200.319,0.000,0.000,0.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(19624,730.675,-1432.685,1200.720,0.000,0.000,0.000,-1,13,-1,150.000,150.000);
	CreateDynamicObject(1230,723.252,-1432.360,1200.699,0.000,0.000,-14.000,-1,13,-1,150.000,150.000);

	/* Iglesia, interior por Gigistone */
	gobj = CreateDynamicObject(6959,100.000,600.000,2005.000,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14581, "ab_mafiasuitea", "wood02S", 0);
	gobj = CreateDynamicObject(19450,93.362,593.574,2006.691,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 13007, "sw_bankint", "bank_wall1", 0);
	gobj = CreateDynamicObject(19450,98.178,588.840,2006.691,0.000,0.000,90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 13007, "sw_bankint", "bank_wall1", 0);
	gobj = CreateDynamicObject(19450,102.996,593.574,2006.691,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 13007, "sw_bankint", "bank_wall1", 0);
	gobj = CreateDynamicObject(1256,100.820,591.127,2005.607,0.000,0.000,-90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	SetDynamicObjectMaterial(gobj, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	gobj = CreateDynamicObject(1557,96.471,588.960,2004.952,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 3603, "bevmans01_la", "lasbevcit7", 0);
	gobj = CreateDynamicObject(1557,99.498,588.964,2004.952,0.000,0.000,180.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 3603, "bevmans01_la", "lasbevcit7", 0);
	gobj = CreateDynamicObject(1256,95.158,591.127,2005.607,0.000,0.000,-90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	SetDynamicObjectMaterial(gobj, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	gobj = CreateDynamicObject(1256,95.158,593.183,2005.607,0.000,0.000,-90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	SetDynamicObjectMaterial(gobj, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	gobj = CreateDynamicObject(1256,100.820,593.183,2005.607,0.000,0.000,-90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	SetDynamicObjectMaterial(gobj, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	gobj = CreateDynamicObject(1256,100.820,595.239,2005.607,0.000,0.000,-90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	SetDynamicObjectMaterial(gobj, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	gobj = CreateDynamicObject(1256,95.158,595.239,2005.607,0.000,0.000,-90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	SetDynamicObjectMaterial(gobj, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	gobj = CreateDynamicObject(1256,100.820,597.295,2005.607,0.000,0.000,-90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	SetDynamicObjectMaterial(gobj, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	gobj = CreateDynamicObject(1256,95.158,597.295,2005.607,0.000,0.000,-90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	SetDynamicObjectMaterial(gobj, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0);
	gobj = CreateDynamicObject(19450,93.362,603.205,2006.691,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 13007, "sw_bankint", "bank_wall1", 0);
	gobj = CreateDynamicObject(19450,102.996,606.417,2006.691,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 13007, "sw_bankint", "bank_wall1", 0);
	gobj = CreateDynamicObject(19359,96.670,601.927,2004.125,0.000,0.000,90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14806, "bdupshifi", "Bdup2_wood", 0);
	gobj = CreateDynamicObject(19359,99.879,601.927,2004.125,0.000,0.000,90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14806, "bdupshifi", "Bdup2_wood", 0);
	gobj = CreateDynamicObject(2029,97.855,601.120,2004.965,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0);
	gobj = CreateDynamicObject(19450,98.178,605.436,2006.691,0.000,0.000,90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 13007, "sw_bankint", "bank_wall1", 0);
	gobj = CreateDynamicObject(19906,98.181,605.365,2008.355,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 9259, "presidio01_sfn", "stainwin_law", 0);
	gobj = CreateDynamicObject(19452,98.178,603.592,2005.045,0.000,90.000,90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14581, "ab_mafiasuitea", "wood02S", 0);
	gobj = CreateDynamicObject(19451,98.178,589.215,2009.251,0.000,20.000,90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14786, "ab_sfgymbeams", "knot_wood128", 0);
	gobj = CreateDynamicObject(19451,98.178,605.064,2009.233,0.000,-20.000,90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14786, "ab_sfgymbeams", "knot_wood128", 0);
	gobj = CreateDynamicObject(19451,102.622,603.205,2009.242,0.000,-20.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14786, "ab_sfgymbeams", "knot_wood128", 0);
	gobj = CreateDynamicObject(19451,102.622,593.574,2009.242,0.000,-20.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14786, "ab_sfgymbeams", "knot_wood128", 0);
	gobj = CreateDynamicObject(19451,93.734,593.574,2009.233,0.000,20.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14786, "ab_sfgymbeams", "knot_wood128", 0);
	gobj = CreateDynamicObject(19451,93.734,603.205,2009.233,0.000,20.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14786, "ab_sfgymbeams", "knot_wood128", 0);
	gobj = CreateDynamicObject(19376,98.232,602.882,2009.147,0.000,90.000,90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14786, "ab_sfgymbeams", "knot_wood128", 0);
	gobj = CreateDynamicObject(19376,98.232,592.386,2009.147,0.000,90.000,90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14786, "ab_sfgymbeams", "knot_wood128", 0);
	gobj = CreateDynamicObject(11744,98.728,601.123,2005.770,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14581, "ab_mafiasuitea", "goldPillar", 0);
	gobj = CreateDynamicObject(19818,98.418,600.922,2005.840,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14653, "ab_trukstpb", "mustard", 0);
	gobj = CreateDynamicObject(19388,102.996,599.995,2006.691,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 13007, "sw_bankint", "bank_wall1", 0);
	gobj = CreateDynamicObject(19450,107.804,603.399,2006.691,0.000,0.000,90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 13007, "sw_bankint", "bank_wall1", 0);
	gobj = CreateDynamicObject(19450,107.804,596.579,2006.691,0.000,0.000,90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 13007, "sw_bankint", "bank_wall1", 0);
	gobj = CreateDynamicObject(19450,109.494,600.247,2006.691,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 13007, "sw_bankint", "bank_wall1", 0);
	gobj = CreateDynamicObject(1742,106.040,603.393,2004.967,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 2, 14650, "ab_trukstpc", "sa_wood08_128", 0);
	gobj = CreateDynamicObject(1743,106.780,598.067,2004.967,0.000,0.000,180.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0);
	SetDynamicObjectMaterial(gobj, 1, 14650, "ab_trukstpc", "sa_wood08_128", 0);
	SetDynamicObjectMaterial(gobj, 2, 14650, "ab_trukstpc", "sa_wood08_128", 0);
	gobj = CreateDynamicObject(19376,107.853,600.268,2007.655,0.000,90.000,90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14786, "ab_sfgymbeams", "knot_wood128", 0);
	gobj = CreateDynamicObject(1491,102.995,600.777,2004.967,0.000,0.000,-90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 3603, "bevmans01_la", "lasbevcit7", 0);
	gobj = CreateDynamicObject(19172,109.410,599.845,2006.770,0.000,0.000,-90.000,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 10763, "airport1_sfse", "airportwind03", 0);
	gobj = CreateDynamicObject(11712,99.030,600.893,2005.769,0.000,90.000,80.279,-1,25,-1,100.000,100.000);
	SetDynamicObjectMaterial(gobj, 0, 14581, "ab_mafiasuitea", "goldPillar", 0);
	gobj = CreateDynamicObject(19883,98.717,601.109,2005.775,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	gobj = CreateDynamicObject(2894,97.913,601.135,2005.765,0.000,0.000,6.780,-1,25,-1,100.000,100.000);
	gobj = CreateDynamicObject(2163,103.078,601.540,2004.968,0.000,0.000,90.000,-1,25,-1,100.000,100.000);
	gobj = CreateDynamicObject(2202,103.537,597.202,2004.967,0.000,0.000,90.000,-1,25,-1,100.000,100.000);
	gobj = CreateDynamicObject(2120,108.978,599.896,2005.587,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	gobj = CreateDynamicObject(2205,107.171,599.166,2004.967,0.000,0.000,90.000,-1,25,-1,100.000,100.000);
	gobj = CreateDynamicObject(2120,105.416,599.434,2005.587,0.000,0.000,-176.220,-1,25,-1,100.000,100.000);
	gobj = CreateDynamicObject(2824,107.105,599.038,2005.902,0.000,0.000,-16.620,-1,25,-1,100.000,100.000);
	gobj = CreateDynamicObject(11705,107.129,600.652,2005.902,0.000,0.000,69.719,-1,25,-1,100.000,100.000);
	gobj = CreateDynamicObject(1664,105.897,597.178,2006.113,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	gobj = CreateDynamicObject(2120,105.416,600.515,2005.587,0.000,0.000,176.220,-1,25,-1,100.000,100.000);
	gobj = CreateDynamicObject(18075,109.283,599.640,2007.648,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	gobj = CreateDynamicObject(18075,98.416,598.277,2009.058,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	gobj = CreateDynamicObject(11245,92.383,604.872,2007.269,0.000,0.000,0.000,-1,25,-1,100.000,100.000);
	return true;
}

/* Remove */
stock Maps_Remove(playerid)
{
	// Alhambra
	RemoveBuildingForPlayer(playerid, 1226, 1825.9297, -1697.5625, 16.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1825.8516, -1667.0781, 16.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 5408, 1873.7422, -1682.4766, 34.7969, 0.25);
 	RemoveBuildingForPlayer(playerid, 5544, 1873.7422, -1682.4766, 34.7969, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 1837.6641, -1640.3828, 13.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1855.7188, -1741.5391, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1879.5078, -1741.4844, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1908.2188, -1741.4844, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1929.5781, -1736.9063, 21.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1931.0391, -1726.3281, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1832.3828, -1694.3125, 9.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 1537, 1837.4375, -1683.9688, 12.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 1533, 1837.4375, -1683.9531, 12.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 1537, 1837.4375, -1686.9844, 12.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1832.8984, -1670.7656, 9.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 1533, 1837.4375, -1677.9219, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1537, 1837.4375, -1680.9531, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1533, 1837.4375, -1680.9375, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1931.0391, -1702.2891, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1929.5781, -1694.4609, 21.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1931.0391, -1667.0313, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1931.0391, -1637.8984, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1855.7188, -1623.2813, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1879.5078, -1623.1016, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1908.2188, -1622.9844, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1929.5781, -1627.6250, 21.3906, 0.25);

	/* Comisaría, exterior */
    RemoveBuildingForPlayer(playerid, 4064, 1571.6016, -1675.7500, 35.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 3976, 1571.6016, -1675.7500, 35.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 4063, 1578.4688, -1676.4219, 13.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 3975, 1578.4688, -1676.4219, 13.0703, 0.25);
	
	/* Hotel en downtown por Benjes */
	RemoveBuildingForPlayer(playerid, 792, 1238.9844, -1481.9531, 12.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1238.9844, -1468.0156, 12.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1256.9844, -1443.0313, 12.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1236.2813, -1443.0313, 12.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1256.9844, -1417.7031, 12.7188, 0.25);
	return true;
}
