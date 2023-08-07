new kdmstaffskin;
new guccisnake;
new irishpolice;
new nillyskin;
new shotskin[MAX_PLAYERS];

new serverhubnpc = INVALID_ACTOR_ID;

ServerHubKeyText()
{
	Create3DTextLabel("{EE5133}Shoot me to go to{33C4EE}\nThe Server Hub", -1, 2518.4958 ,591.0577, 35.7459, 40.0, 0);
}
InitServerHub()
{
	kdmstaffskin = CreateActor(20067, 1721.8754, -1656.4478, 20.9688, 178.8593);
	guccisnake = CreateActor(20120, 1721.7507, -1654.7797, 20.9688, 0.4655);
	irishpolice = CreateActor(20121, 1722.6783, -1655.7043, 20.9741, 270.2162);
	nillyskin = CreateActor(20122, 1727.6315, -1668.0815, 22.6094, 41.4650);
	serverhubnpc = CreateActor(20067, 2518.4958 ,591.0577, 35.7459, 358.4071);

	SetActorInvulnerable(kdmstaffskin, false);
	SetActorHealth(kdmstaffskin, 1000);
	SetActorInvulnerable(guccisnake, false);
	SetActorHealth(guccisnake, 1000);
	SetActorInvulnerable(irishpolice, false);
	SetActorHealth(irishpolice, 1000);
	SetActorInvulnerable(nillyskin, false);
	SetActorHealth(nillyskin, 1000);
	SetActorInvulnerable(serverhubnpc, false);
	SetActorHealth(serverhubnpc, 1000);
	ApplyActorAnimation(nillyskin, "DANCING", "dnce_M_a", 4.1, 1, 1, 1, 1, 0); // Pay anim
	Create3DTextLabel("{EE5133}Welcome to the server hub!{33C4EE}\nShoot the actors to buy the skins!", -1, 1710.8682, -1667.3304, 20.2261, 25.0, 0);
	ServerHubKeyText();
	return true;
}

stock CreateServerHub(playerid) {
	new tmpobjid;
	tmpobjid = CreatePlayerObject(playerid, 18783, 2430.264404, -1755.505615, 1030.034545, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 16639, "a51_labs", "dam_terazzo", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 18783, 2410.265380, -1755.505615, 1030.034545, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 16639, "a51_labs", "dam_terazzo", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 18783, 2430.264404, -1775.501831, 1030.034545, 0.000000, 0.000007, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 16639, "a51_labs", "dam_terazzo", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 18783, 2410.265380, -1775.501831, 1030.034545, 0.000000, 0.000007, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 16639, "a51_labs", "dam_terazzo", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2403.739257, -1762.523925, 1037.784790, 0.000000, 0.000014, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2403.739257, -1752.892089, 1037.784790, 0.000000, 0.000014, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2403.739257, -1772.157470, 1037.784790, 0.000000, 0.000014, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2417.246582, -1751.168334, 1028.412231, 0.000000, 0.000000, -90.000045); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2426.878417, -1751.168334, 1037.784790, 0.000007, 0.000000, -90.000068); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2407.613281, -1751.168334, 1037.784790, 0.000007, 0.000000, -90.000068); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2417.246582, -1773.844604, 1028.412231, -0.000007, 0.000000, -90.000022); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2426.878417, -1773.844604, 1037.784790, 0.000000, 0.000000, -90.000045); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2407.613281, -1773.844604, 1037.784790, 0.000000, 0.000000, -90.000045); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2430.772460, -1762.523925, 1037.784790, 0.000000, 0.000037, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2430.772460, -1752.892089, 1037.784790, 0.000000, 0.000037, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2430.772460, -1772.157470, 1037.784790, 0.000000, 0.000037, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 18756, 2405.635742, -1762.485229, 1034.486450, 0.000000, 0.000022, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 4829, "airport_las", "liftdoorsac256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 18757, 2405.635742, -1762.489624, 1034.486450, 0.000000, 0.000022, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 4829, "airport_las", "liftdoorsac256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 18762, 2409.287353, -1766.539184, 1033.537963, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2404.534423, -1762.799194, 1036.125488, 0.000000, 90.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2404.534423, -1772.433105, 1036.125488, 0.000000, 90.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2404.534423, -1753.166015, 1036.125488, 0.000000, 90.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2409.697753, -1762.523925, 1041.287231, 0.000000, 0.000029, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2409.697753, -1752.892089, 1041.287231, 0.000000, 0.000029, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2409.697753, -1772.157470, 1041.287231, 0.000000, 0.000029, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 18762, 2409.287353, -1758.489013, 1033.537963, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 18762, 2425.315673, -1758.488891, 1033.537963, 0.000007, -0.000022, 179.999740); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2430.068603, -1762.228637, 1036.125488, 0.000007, 89.999977, 179.999740); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2430.068603, -1752.594848, 1036.125488, 0.000007, 89.999977, 179.999740); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2430.068603, -1771.861938, 1036.125488, 0.000007, 89.999977, 179.999740); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2424.905517, -1762.504028, 1041.287231, 0.000007, 0.000007, 179.999740); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2424.905517, -1772.135864, 1041.287231, 0.000007, 0.000007, 179.999740); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2424.905517, -1752.870483, 1041.287231, 0.000007, 0.000007, 179.999740); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 18762, 2425.315673, -1766.538940, 1033.537963, 0.000007, -0.000022, 179.999740); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2417.246582, -1751.168334, 1044.792114, -0.000007, 0.000000, -90.000022); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2417.246582, -1773.844604, 1044.792114, -0.000014, 0.000000, -90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19325, 2413.314941, -1751.167358, 1036.447021, 89.999992, 179.999984, -90.000007); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1717, "cj_tv", "green_glass_64", 0xFF8BABD6);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2417.225585, -1746.358764, 1033.072265, 0.000000, 90.000007, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 7420, "vgnglfcrse1", "seabed", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2411.974365, -1746.358764, 1038.382080, 0.000000, 180.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 6056, "venice_law", "stonewalls2", 0xFFD0D0D0);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2422.519775, -1746.358764, 1038.382080, 0.000000, 180.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 6056, "venice_law", "stonewalls2", 0xFFD0D0D0);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2417.225585, -1746.358764, 1040.111816, 0.000000, 90.000007, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2413.163085, -1743.959838, 1038.382080, 0.000007, 180.000000, 89.999977); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 6056, "venice_law", "stonewalls2", 0xFFD0D0D0);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2422.796142, -1743.959838, 1038.382080, 0.000007, 180.000000, 89.999977); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 6056, "venice_law", "stonewalls2", 0xFFD0D0D0);
	tmpobjid = CreatePlayerObject(playerid, 19325, 2417.441162, -1751.167358, 1036.447021, 89.999992, 179.999984, -90.000007); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1717, "cj_tv", "green_glass_64", 0xFF8BABD6);
	tmpobjid = CreatePlayerObject(playerid, 19325, 2421.567138, -1751.167358, 1036.447021, 89.999992, 179.999984, -90.000007); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1717, "cj_tv", "green_glass_64", 0xFF8BABD6);
	tmpobjid = CreatePlayerObject(playerid, 19325, 2421.195312, -1773.841796, 1036.447021, 89.999992, 334.471160, -64.471237); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1717, "cj_tv", "green_glass_64", 0xFF8BABD6);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2417.284667, -1778.650390, 1033.072265, 0.000007, 90.000000, 179.999832); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 7420, "vgnglfcrse1", "seabed", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2422.535888, -1778.650390, 1038.382080, 0.000007, 180.000000, 179.999786); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 6056, "venice_law", "stonewalls2", 0xFFD0D0D0);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2411.990478, -1778.650390, 1038.382080, 0.000007, 180.000000, 179.999786); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 6056, "venice_law", "stonewalls2", 0xFFD0D0D0);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2417.284667, -1778.650390, 1040.111816, 0.000007, 90.000000, 179.999832); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1736, "cj_ammo", "CJ_Black_metal", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2421.347167, -1781.049316, 1038.382080, -0.000014, 180.000000, -89.999961); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 6056, "venice_law", "stonewalls2", 0xFFD0D0D0);
	tmpobjid = CreatePlayerObject(playerid, 19375, 2411.714111, -1781.049316, 1038.382080, -0.000014, 180.000000, -89.999961); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 6056, "venice_law", "stonewalls2", 0xFFD0D0D0);
	tmpobjid = CreatePlayerObject(playerid, 19325, 2417.069091, -1773.841796, 1036.447021, 89.999992, 334.471160, -64.471237); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1717, "cj_tv", "green_glass_64", 0xFF8BABD6);
	tmpobjid = CreatePlayerObject(playerid, 19325, 2412.942626, -1773.841796, 1036.447021, 89.999992, 334.471160, -64.471237); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1717, "cj_tv", "green_glass_64", 0xFF8BABD6);
	tmpobjid = CreatePlayerObject(playerid, 1609, 2420.188964, -1779.478637, 1035.813842, -14.800002, 28.700000, 49.899971); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1609, 2414.303710, -1777.930786, 1037.422851, -6.700004, -20.100004, -74.399993); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFA1A1A1);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, -1, "none", "none", 0xFFA1A1A1);
	SetPlayerObjectMaterial(playerid, tmpobjid, 2, -1, "none", "none", 0xFF5589CE);
	tmpobjid = CreatePlayerObject(playerid, 1604, 2416.609130, -1775.218750, 1034.728515, 0.000000, -16.199983, -92.700027); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1604, 2417.672851, -1776.468261, 1036.201416, 0.000000, -16.199983, -83.400024); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1604, 2419.767089, -1776.433227, 1034.223632, 0.000000, -16.199983, 93.799964); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1604, 2419.958496, -1779.252075, 1037.786376, -38.699981, 17.000019, 49.999961); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1599, 2417.261962, -1777.151977, 1037.216186, 0.000000, 17.000001, 95.299964); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1599, 2414.320800, -1777.950439, 1035.504882, 0.000000, 10.500003, -88.500015); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1599, 2420.998046, -1776.713745, 1034.438232, 0.000000, 10.500002, 90.399963); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1599, 2419.968750, -1777.196411, 1038.348876, -10.600000, 15.700003, 93.500007); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1600, 2418.202636, -1775.833984, 1035.466430, 0.000000, 16.700000, 88.499992); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1600, 2416.225830, -1774.934082, 1038.291625, 0.000000, 16.700000, -121.700004); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1600, 2413.076416, -1779.825073, 1035.846435, 0.000000, 16.700000, -87.799972); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1600, 2418.980224, -1775.470703, 1037.086303, -18.000000, 16.700000, -87.799972); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1603, 2419.929931, -1747.844116, 1035.879638, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 902, 2421.327636, -1776.151489, 1032.853271, 0.000000, 0.000000, 15.800000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19630, 2417.145507, -1774.944335, 1035.564697, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19630, 2416.965332, -1774.754150, 1035.374511, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19630, 2416.845214, -1775.084472, 1035.484619, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19630, 2417.656005, -1778.124633, 1038.085571, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19630, 2416.345947, -1777.554199, 1038.495971, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1600, 2414.566162, -1778.051635, 1034.410034, 0.000000, 16.700000, -87.799972); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1601, 2416.442382, -1778.572509, 1035.154174, 0.000000, -12.699995, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1605, 2412.445312, -1775.741333, 1034.321411, 0.000000, 13.699999, 270.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1606, 2418.596435, -1781.362182, 1037.901855, 0.000000, 20.699995, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 3929, 2416.836669, -1775.564575, 1033.332763, 0.000000, 0.000000, 33.499992); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 3929, 2420.475585, -1781.059692, 1033.332763, 0.000000, 0.000000, -0.800005); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 3930, 2420.215087, -1776.626220, 1033.301757, 0.000000, 0.000000, 21.400001); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 3930, 2415.310058, -1778.549316, 1033.001464, 0.000000, -53.700019, 21.400001); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 3931, 2413.396484, -1779.837524, 1033.255615, 0.000000, 90.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2420.207031, -1776.349487, 1033.059448, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2419.596435, -1776.930053, 1033.059448, 0.000000, 0.000000, 25.899997); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2417.138916, -1778.122436, 1032.829223, 0.000000, 0.000000, 25.899997); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2419.008056, -1779.772216, 1033.079467, 0.000000, 0.000000, 25.899997); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2416.524414, -1775.875244, 1033.079467, 0.000000, 0.000000, 25.899997); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2413.858642, -1776.523803, 1033.079467, 0.000000, 0.000000, 109.599998); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2414.915039, -1779.491210, 1032.759155, 0.000000, 0.000000, 109.599998); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2415.240722, -1779.598999, 1032.979125, 0.000000, 0.000000, 109.599998); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2415.763671, -1779.625610, 1032.979125, 0.000000, 0.000000, 29.399976); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1603, 2419.417236, -1747.825439, 1035.589355, 0.000000, 0.000000, -119.099975); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1603, 2420.164794, -1748.414062, 1035.589355, 12.699997, 0.000000, -119.099975); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19604, 2409.791015, -1767.497436, 1042.110351, -89.999992, 360.024749, 90.024688); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19604, 2409.791015, -1762.498413, 1042.110351, -89.999992, 360.024749, 90.024688); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19604, 2409.791015, -1757.498413, 1042.110351, -89.999992, 360.024749, 90.024688); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 3806, 2410.111328, -1755.898803, 1037.387573, -0.000007, -0.000007, -0.000082); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 2, 10837, "airroadsigns_sfse", "CJ_LAMPPOST1", 0xFFD0D0D0);
	SetPlayerObjectMaterial(playerid, tmpobjid, 3, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 4, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 3806, 2410.109375, -1758.108764, 1037.387573, -0.000007, -0.000007, -0.000082); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 2, 10837, "airroadsigns_sfse", "CJ_LAMPPOST1", 0xFFD0D0D0);
	SetPlayerObjectMaterial(playerid, tmpobjid, 3, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 4, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 3806, 2410.111328, -1760.330932, 1037.387573, -0.000007, -0.000007, -0.000082); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 2, 10837, "airroadsigns_sfse", "CJ_LAMPPOST1", 0xFFD0D0D0);
	SetPlayerObjectMaterial(playerid, tmpobjid, 3, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 4, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 3806, 2410.109375, -1762.549194, 1037.387573, -0.000007, -0.000007, -0.000082); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 2, 10837, "airroadsigns_sfse", "CJ_LAMPPOST1", 0xFFD0D0D0);
	SetPlayerObjectMaterial(playerid, tmpobjid, 3, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 4, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 3806, 2410.111328, -1764.771850, 1037.387573, -0.000007, -0.000007, -0.000082); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 2, 10837, "airroadsigns_sfse", "CJ_LAMPPOST1", 0xFFD0D0D0);
	SetPlayerObjectMaterial(playerid, tmpobjid, 3, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 4, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 3806, 2410.109375, -1766.989624, 1037.387573, -0.000007, -0.000007, -0.000082); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 2, 10837, "airroadsigns_sfse", "CJ_LAMPPOST1", 0xFFD0D0D0);
	SetPlayerObjectMaterial(playerid, tmpobjid, 3, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 4, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 3806, 2410.111328, -1769.203491, 1037.387573, -0.000007, -0.000007, -0.000082); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 2, 10837, "airroadsigns_sfse", "CJ_LAMPPOST1", 0xFFD0D0D0);
	SetPlayerObjectMaterial(playerid, tmpobjid, 3, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 4, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19480, 2424.810791, -1763.471435, 1037.945190, 0.000000, -0.000014, 179.999908); 
	SetPlayerObjectMaterialText(playerid, tmpobjid, "KOKY'S", 0, 120, "Ariel", 50, 1, 0xFFFFFFFF, 0x00000000, 0);
	tmpobjid = CreatePlayerObject(playerid, 19480, 2424.810791, -1770.861328, 1037.945190, 0.000000, -0.000014, 179.999908); 
	SetPlayerObjectMaterialText(playerid, tmpobjid, "DEATHMATCH", 0, 120, "Ariel", 50, 1, 0xFFD43434, 0x00000000, 0);
	tmpobjid = CreatePlayerObject(playerid, 19444, 2424.902099, -1754.417724, 1039.732666, 89.999992, 89.999992, -89.999992); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19444, 2424.902099, -1757.916625, 1039.732666, 89.999992, 89.999992, -89.999992); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19444, 2424.902099, -1761.414916, 1039.732666, 89.999992, 89.999992, -89.999992); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19444, 2424.902099, -1764.904541, 1039.732666, 89.999992, 89.999992, -89.999992); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19444, 2424.902099, -1768.394287, 1039.732666, 89.999992, 89.999992, -89.999992); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19444, 2424.902099, -1770.736572, 1039.732666, 89.999992, 89.999992, -89.999992); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19444, 2424.902099, -1761.855346, 1037.680908, 89.999992, 89.999992, -89.999977); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19480, 2424.810791, -1767.564697, 1035.893188, 0.000000, -0.000014, 179.999908); 
	SetPlayerObjectMaterialText(playerid, tmpobjid, "SERVER HUB", 0, 120, "Ariel", 50, 1, 0xFF000000, 0x00000000, 0);
	tmpobjid = CreatePlayerObject(playerid, 19444, 2424.902099, -1758.365478, 1037.680908, 89.999992, 89.999992, -89.999977); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19444, 2424.902099, -1765.355712, 1037.680908, 89.999992, 89.999992, -89.999977); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19444, 2424.902099, -1766.775878, 1037.680908, 89.999992, 89.999992, -89.999977); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 18783, 2418.006103, -1753.873901, 1045.532226, 180.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 18783, 2418.006103, -1773.866577, 1045.532226, 180.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19445, 2409.805908, -1765.295654, 1043.972412, 0.000000, 0.000007, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19445, 2409.805908, -1759.552612, 1043.972412, 0.000000, 0.000007, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19089, 2409.805664, -1762.626464, 1042.227905, 90.000000, 90.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2799, "castable", "chrome_pipe_32", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19089, 2409.805664, -1754.984619, 1042.227905, 90.000000, 90.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2799, "castable", "chrome_pipe_32", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19089, 2409.878417, -1762.626464, 1042.227905, 90.000000, 90.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2799, "castable", "chrome_pipe_32", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19089, 2409.878417, -1754.984619, 1042.227905, 90.000000, 90.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2799, "castable", "chrome_pipe_32", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19089, 2409.805664, -1757.306152, 1042.227905, 89.999992, 270.000000, -90.000007); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2799, "castable", "chrome_pipe_32", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19089, 2409.878417, -1757.306152, 1042.227905, 89.999992, 270.000000, -90.000007); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2799, "castable", "chrome_pipe_32", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2420.999023, -1773.856445, 1033.529418, 90.000000, 0.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2418.763916, -1773.856445, 1033.529418, 90.000000, 0.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2416.528076, -1773.856445, 1033.529418, 90.000000, 0.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2414.292236, -1773.856445, 1033.529418, 90.000000, 0.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2412.056884, -1773.856445, 1033.529418, 90.000000, 0.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2412.056640, -1773.856323, 1039.675048, -89.999992, -303.266357, 146.733596); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2414.291992, -1773.856323, 1039.675048, -89.999992, -303.266357, 146.733596); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2416.527832, -1773.856323, 1039.675048, -89.999992, -303.266357, 146.733596); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2418.763671, -1773.856323, 1039.675048, -89.999992, -303.266357, 146.733596); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2420.999023, -1773.856323, 1039.675048, -89.999992, -303.266357, 146.733596); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2412.298339, -1773.856323, 1034.409301, 0.000000, 180.000015, -89.999961); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2422.193847, -1773.856323, 1038.880493, 0.000018, -359.999938, 89.999916); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2422.193847, -1773.856323, 1036.644653, 0.000018, -359.999938, 89.999916); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2422.193847, -1773.856323, 1034.409301, 0.000018, -359.999938, 89.999916); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2412.298339, -1773.856323, 1036.645141, 0.000000, 180.000015, -89.999961); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2412.298339, -1773.856323, 1038.880493, 0.000000, 180.000015, -89.999961); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2420.999267, -1751.156494, 1039.675048, -89.999992, 374.036193, -75.963737); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2418.764160, -1751.156494, 1039.675048, -89.999992, 374.036193, -75.963737); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2416.528320, -1751.156494, 1039.675048, -89.999992, 374.036193, -75.963737); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2414.292480, -1751.156494, 1039.675048, -89.999992, 374.036193, -75.963737); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2412.057128, -1751.156494, 1039.675048, -89.999992, 374.036193, -75.963737); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2412.056884, -1751.156738, 1033.529541, 89.999992, -558.434875, 108.434928); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2414.292236, -1751.156738, 1033.529541, 89.999992, -558.434875, 108.434928); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2416.528076, -1751.156738, 1033.529541, 89.999992, -558.434875, 108.434928); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2418.763916, -1751.156738, 1033.529541, 89.999992, -558.434875, 108.434928); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2420.999267, -1751.156738, 1033.529541, 89.999992, -558.434875, 108.434928); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2412.298583, -1751.156738, 1038.795166, 0.000014, 0.000000, -90.000015); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2422.194091, -1751.156738, 1034.323974, -0.000014, -539.999938, 90.000015); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2422.194091, -1751.156738, 1036.559814, -0.000014, -539.999938, 90.000015); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2422.194091, -1751.156738, 1038.795166, -0.000014, -539.999938, 90.000015); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2412.298583, -1751.156738, 1036.559326, 0.000014, 0.000000, -90.000015); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1897, 2412.298583, -1751.156738, 1034.323974, 0.000014, 0.000000, -90.000015); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 3080, "adjumpx", "gen_chrome", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 13646, 2417.311279, -1762.504150, 1033.045898, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 14593, "papaerchaseoffice", "wall_stone6_256", 0xFFFFFFFF);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1604, 2420.830810, -1776.785522, 1035.468994, 0.000000, -14.000005, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1604, 2419.509521, -1778.862060, 1034.415039, 0.000000, -14.000005, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2417.408447, -1745.966430, 1033.172485, 0.000000, 0.000000, 38.399997); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2415.406005, -1748.803222, 1033.172485, 0.000000, 0.000000, 95.599975); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2418.551025, -1748.494628, 1032.782104, 0.000000, 0.000000, 140.999984); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2420.426513, -1746.178588, 1033.042358, 0.000000, 0.000000, 140.999984); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2419.655517, -1746.031005, 1033.042358, 0.000000, 0.000000, -163.300033); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2419.919921, -1746.357666, 1033.042358, 0.000000, 0.000000, -100.699943); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2420.883544, -1747.821166, 1032.802124, 0.000000, 0.000000, 27.200067); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 859, 2412.653808, -1746.608642, 1033.052368, 0.000000, 0.000000, 27.200067); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 3931, 2418.989746, -1747.674682, 1032.985229, 0.000000, 0.000000, 40.500000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 3930, 2412.454589, -1747.319580, 1033.158447, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 3930, 2416.286621, -1745.598022, 1032.958251, 0.000000, 90.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 3930, 2420.822998, -1749.793090, 1033.156738, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 3930, 2419.195312, -1744.749267, 1033.246826, 90.000000, 189.000000, 64.900009); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1606, 2419.702148, -1745.861694, 1034.732788, 0.000000, 17.199996, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 902, 2421.650146, -1745.808715, 1032.789062, 0.000000, 0.000000, -50.799987); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 902, 2413.591064, -1748.538818, 1032.789062, 0.000000, 0.000000, -10.299997); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1605, 2415.440673, -1748.883056, 1036.295288, 0.000000, 22.100006, 270.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1604, 2416.905761, -1749.246215, 1034.651977, 0.000000, -14.399997, 88.699943); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1604, 2416.494384, -1748.833740, 1034.166625, 0.000000, -14.399997, 88.699943); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1601, 2417.849365, -1747.013916, 1036.618652, 0.000000, -14.700001, 270.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1600, 2416.056396, -1748.727294, 1037.276245, 0.000000, 17.500000, 93.399993); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1600, 2415.083984, -1747.705200, 1036.936035, 0.000000, 17.500000, 93.399993); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1600, 2415.400878, -1748.141723, 1037.687744, 0.000000, 17.500000, 93.399993); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19630, 2418.181640, -1748.114868, 1034.078491, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19630, 2417.631103, -1748.425170, 1034.288696, 0.000000, 0.000000, 180.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19630, 2415.468994, -1748.425170, 1034.619018, 0.000000, 0.000000, 180.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 857, 2413.552978, -1745.664916, 1033.227539, 0.000000, 0.000000, -51.099998); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1597, "centralresac1", "fuzzyplant256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 857, 2420.379150, -1749.114624, 1033.297607, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1597, "centralresac1", "fuzzyplant256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 857, 2416.969238, -1779.829711, 1033.227539, 0.000000, 0.000000, -51.099998); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1597, "centralresac1", "fuzzyplant256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 857, 2421.741943, -1779.979370, 1033.277587, 0.000000, 0.000000, 165.799942); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1597, "centralresac1", "fuzzyplant256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1598, 2414.763916, -1746.961303, 1033.358886, 0.000000, -71.899986, 33.900009); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1641, 2417.013183, -1749.069458, 1033.158569, 0.000000, 0.000000, -26.799997); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 953, 2412.797851, -1777.921508, 1033.347778, 0.000000, 0.000000, 107.400131); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 953, 2418.924316, -1778.267822, 1033.347778, 0.000000, 0.000000, -109.099853); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 3092, 2414.792724, -1745.052124, 1035.884643, 0.000000, 0.000000, 180.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19087, 2414.783691, -1744.880493, 1035.400146, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1520, 2417.287841, -1776.189819, 1033.211181, 0.000000, 90.000000, -28.800001); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1610, 2414.587646, -1775.447998, 1033.150390, 0.000000, 0.000000, -16.000001); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 9301, "gazsfn2", "Bow_Smear_Cement", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1611, 2415.314453, -1775.693481, 1033.116088, 0.000000, 0.000000, 122.100021); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 9301, "gazsfn2", "Bow_Smear_Cement", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1851, 2414.779541, -1744.879272, 1033.307250, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 9301, "gazsfn2", "Bow_Smear_Cement", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2484, 2421.689941, -1778.546142, 1033.753784, 0.000000, 0.000000, 52.399990); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 19297, "matlights", "invisible", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 2404, 2422.204345, -1744.193237, 1034.378906, 0.000000, 0.000000, -35.099983); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 2782, 2418.275146, -1746.571166, 1033.370239, 0.000000, 0.000000, -37.100009); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 2811, 2422.018310, -1747.952758, 1032.620727, 0.000000, 0.000000, -38.299995); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 2811, 2421.609619, -1747.858032, 1032.620727, 0.000000, 0.000000, -72.699996); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 2811, 2421.777343, -1748.129882, 1032.340454, 0.000000, 0.000000, 17.100008); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 2811, 2421.447509, -1748.042968, 1032.620727, 0.000000, 0.000000, -12.999995); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 2811, 2421.914062, -1747.801025, 1032.620727, 0.000000, 0.000000, 84.299987); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 2, 19297, "matlights", "invisible", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 2967, 2419.610595, -1776.598510, 1033.150268, 0.000000, 0.000000, -145.099929); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 3471, 2417.859130, -1779.768310, 1032.317749, 17.400001, -29.800008, 123.200103); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19379, 2417.250244, -1773.889282, 1036.363891, 0.000000, 0.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19379, 2417.250244, -1751.149780, 1036.363891, 0.000000, 0.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 1600, 2413.851562, -1749.454223, 1035.178833, 0.000000, 17.600000, 270.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1600, 2414.492187, -1749.087402, 1034.719116, 0.000000, 17.600000, 270.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1604, 2419.186035, -1749.274658, 1037.024047, 0.000000, -14.600000, 270.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1604, 2419.906738, -1749.152832, 1036.464721, 0.000000, -14.600000, 270.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 1604, 2413.483154, -1746.661987, 1036.031372, 0.000000, -14.600000, 270.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2406.815429, -1752.603515, 1032.795288, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2408.152832, -1751.865844, 1032.194702, 0.000000, 90.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2406.815429, -1751.272338, 1032.795288, 0.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2405.478271, -1751.865844, 1032.194702, 0.000000, 90.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2406.815429, -1751.863281, 1033.285766, 90.000000, 0.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 10368, "cathedral_sfs", "dirt64b2", 0xFFD0D0D0);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 10368, "cathedral_sfs", "dirt64b2", 0xFFD0D0D0);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2406.785400, -1772.410522, 1032.795288, 0.000007, -0.000007, 179.999710); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2405.447998, -1773.148071, 1032.194702, -0.000007, 89.999992, -90.000068); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2406.785400, -1773.741577, 1032.795288, 0.000007, -0.000007, 179.999710); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2408.122802, -1773.148071, 1032.194702, -0.000007, 89.999992, -90.000068); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2406.785400, -1773.150756, 1033.285766, 89.999992, 616.631408, -76.631515); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 10368, "cathedral_sfs", "dirt64b2", 0xFFD0D0D0);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 10368, "cathedral_sfs", "dirt64b2", 0xFFD0D0D0);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2427.833496, -1752.603515, 1032.795288, 0.000000, 0.000007, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2429.170898, -1751.865844, 1032.194702, 0.000007, 90.000000, 89.999977); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2427.833496, -1751.272338, 1032.795288, 0.000000, 0.000007, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2426.496337, -1751.865844, 1032.194702, 0.000007, 90.000000, 89.999977); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2427.833496, -1751.863281, 1033.285766, 89.999992, 89.999992, -89.999992); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 10368, "cathedral_sfs", "dirt64b2", 0xFFD0D0D0);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 10368, "cathedral_sfs", "dirt64b2", 0xFFD0D0D0);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2427.803466, -1772.410522, 1032.795288, 0.000007, -0.000014, 179.999664); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2426.466064, -1773.148071, 1032.194702, -0.000014, 89.999992, -90.000045); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2427.803466, -1773.741577, 1032.795288, 0.000007, -0.000014, 179.999664); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2429.140869, -1773.148071, 1032.194702, -0.000014, 89.999992, -90.000045); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2127, "cj_kitchen", "marble2", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19174, 2427.803466, -1773.150756, 1033.285766, 89.999992, 623.225891, -83.225982); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 10368, "cathedral_sfs", "dirt64b2", 0xFFD0D0D0);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 10368, "cathedral_sfs", "dirt64b2", 0xFFD0D0D0);
	tmpobjid = CreatePlayerObject(playerid, 927, 2420.726074, -1744.088134, 1039.927246, 0.000000, 180.000000, 0.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 927, 2413.883789, -1780.919799, 1039.927246, 0.000000, 180.000000, 180.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2407.677734, -1773.213256, 1032.930908, 0.000000, 0.000000, 32.799995); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2405.988769, -1772.969116, 1032.740722, 0.000000, 0.000000, 76.699966); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2406.638671, -1773.247314, 1032.410400, 0.000000, 0.000000, 115.799957); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2407.108398, -1772.950561, 1032.430786, 0.000000, 0.000000, 122.499984); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1597, "centralresac1", "kbtree4_test", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2406.091796, -1773.051269, 1032.430786, 0.000000, 0.000000, 84.799987); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1597, "centralresac1", "kbtree4_test", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2406.597412, -1772.970336, 1032.930908, 0.000000, 0.000000, 88.100006); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 4003, "cityhall_tr_lan", "planta256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2407.150390, -1773.239135, 1032.930908, 0.000000, 0.000000, 55.300014); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 4003, "cityhall_tr_lan", "planta256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2405.968994, -1751.781616, 1032.930908, 0.000006, -0.000003, -147.199996); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2407.657958, -1752.025756, 1032.740722, 0.000000, -0.000007, -103.300041); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2407.008056, -1751.747680, 1032.410400, -0.000003, -0.000006, -64.200019); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2406.538330, -1752.044311, 1032.430786, -0.000003, -0.000006, -57.499988); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1597, "centralresac1", "kbtree4_test", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2407.554931, -1751.943725, 1032.430786, 0.000000, -0.000007, -95.200019); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1597, "centralresac1", "kbtree4_test", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2407.049316, -1752.024780, 1032.930908, 0.000000, -0.000007, -91.900001); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 4003, "cityhall_tr_lan", "planta256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2406.496337, -1751.755737, 1032.930908, 0.000003, -0.000006, -124.699974); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 4003, "cityhall_tr_lan", "planta256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2426.956787, -1751.821655, 1032.930908, 0.000001, -0.000009, -147.199996); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2428.645751, -1752.065795, 1032.740722, -0.000004, -0.000009, -103.300018); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2427.995849, -1751.787719, 1032.410400, -0.000009, -0.000003, -64.200019); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2427.526123, -1752.084350, 1032.430786, -0.000009, -0.000001, -57.499988); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1597, "centralresac1", "kbtree4_test", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2428.542724, -1751.983764, 1032.430786, -0.000006, -0.000007, -95.199996); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1597, "centralresac1", "kbtree4_test", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2428.037109, -1752.064819, 1032.930908, -0.000007, -0.000007, -91.899978); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 4003, "cityhall_tr_lan", "planta256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2427.484130, -1751.795776, 1032.930908, -0.000000, -0.000009, -124.699951); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 4003, "cityhall_tr_lan", "planta256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2426.956787, -1773.044555, 1032.930908, -0.000000, -0.000015, -147.199996); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2428.645751, -1773.288696, 1032.740722, -0.000012, -0.000009, -103.299995); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2428.542724, -1773.206665, 1032.430786, -0.000014, -0.000007, -95.199974); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1597, "centralresac1", "kbtree4_test", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2427.484130, -1773.018676, 1032.930908, -0.000007, -0.000014, -124.699928); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 4003, "cityhall_tr_lan", "planta256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 18763, 2427.839111, -1773.893188, 1031.013793, 0.000000, 180.000000, -89.999977); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 861, 2428.502929, -1773.007202, 1032.930908, -0.000007, -0.000014, -124.699928); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 4003, "cityhall_tr_lan", "planta256", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2427.884765, -1773.108154, 1032.480468, -0.000012, -0.000009, -103.299995); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 861, 2427.163085, -1772.941162, 1032.640991, -0.000014, -0.000007, -112.699966); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1597, "centralresac1", "kbtree4_test", 0xFFFFFFFF);
	tmpobjid = CreatePlayerObject(playerid, 18763, 2406.768066, -1773.890502, 1031.013793, 360.000000, 180.000000, 270.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 18763, 2406.818115, -1751.123046, 1031.013793, 360.000000, 180.000000, 270.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 18763, 2427.839111, -1751.123046, 1031.013793, 360.000000, 180.000000, 270.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2257, 2403.853027, -1770.267089, 1034.296875, 0.000000, 0.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 14489, "carlspics", "AH_landscap1", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2257, 2403.853027, -1767.126831, 1034.296875, 0.000000, 0.000000, 90.000000); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 14489, "carlspics", "AH_landscap3", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2257, 2403.853027, -1758.432128, 1034.296875, 0.000007, 0.000000, 89.999977); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 19173, "samppictures", "samppicture3", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2257, 2403.853027, -1755.291870, 1034.296875, 0.000007, 0.000000, 89.999977); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 19173, "samppictures", "samppicture1", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2257, 2430.656005, -1755.241943, 1034.296875, -0.000007, -0.000007, -89.999984); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 15034, "genhotelsave", "CJ_PAINTING8", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2257, 2430.656005, -1758.382324, 1034.296875, -0.000007, -0.000007, -89.999984); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2266, "picture_frame", "CJ_PAINTING30", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2257, 2430.656005, -1767.076904, 1034.296875, 0.000000, -0.000007, -90.000015); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2266, "picture_frame", "CJ_PAINTING28", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2257, 2430.656005, -1770.217285, 1034.296875, 0.000000, -0.000007, -90.000015); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 2266, "picture_frame", "CJ_PAINTING35", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2255, 2406.240234, -1770.546875, 1035.548095, 89.999992, 540.000000, -89.999984); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1259, "billbrd", "spotlight_64", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 1259, "billbrd", "spotlight_64", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2255, 2406.240234, -1766.546875, 1035.548095, 89.999992, 540.000000, -89.999984); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1259, "billbrd", "spotlight_64", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 1259, "billbrd", "spotlight_64", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2255, 2406.240234, -1762.546875, 1035.548095, 89.999992, 540.000000, -89.999984); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1259, "billbrd", "spotlight_64", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 1259, "billbrd", "spotlight_64", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2255, 2406.240234, -1758.546875, 1035.548095, 89.999992, 540.000000, -89.999984); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1259, "billbrd", "spotlight_64", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 1259, "billbrd", "spotlight_64", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2255, 2406.240234, -1754.546875, 1035.548095, 89.999992, 540.000000, -89.999984); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1259, "billbrd", "spotlight_64", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 1259, "billbrd", "spotlight_64", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2255, 2427.727294, -1770.546875, 1035.548095, 89.999992, 540.000000, -89.999969); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1259, "billbrd", "spotlight_64", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 1259, "billbrd", "spotlight_64", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2255, 2427.727294, -1766.546875, 1035.548095, 89.999992, 540.000000, -89.999969); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1259, "billbrd", "spotlight_64", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 1259, "billbrd", "spotlight_64", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2255, 2427.727294, -1762.546875, 1035.548095, 89.999992, 540.000000, -89.999969); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1259, "billbrd", "spotlight_64", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 1259, "billbrd", "spotlight_64", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2255, 2427.727294, -1758.546875, 1035.548095, 89.999992, 540.000000, -89.999969); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1259, "billbrd", "spotlight_64", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 1259, "billbrd", "spotlight_64", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 2255, 2427.727294, -1754.546875, 1035.548095, 89.999992, 540.000000, -89.999969); 
	SetPlayerObjectMaterial(playerid, tmpobjid, 0, 1259, "billbrd", "spotlight_64", 0x00000000);
	SetPlayerObjectMaterial(playerid, tmpobjid, 1, 1259, "billbrd", "spotlight_64", 0x00000000);
	tmpobjid = CreatePlayerObject(playerid, 19604, 2409.190429, -1764.124389, 1041.599853, -89.999992, 373.368530, 103.368446); 
	tmpobjid = CreatePlayerObject(playerid, 19454, 2405.878906, -1757.686767, 1032.450561, 0.000000, 90.000030, 0.000000); 
	tmpobjid = CreatePlayerObject(playerid, 19454, 2405.878906, -1767.319702, 1032.450561, 0.000000, 90.000030, 0.000000); 
	tmpobjid = CreatePlayerObject(playerid, 19454, 2412.446533, -1770.387207, 1032.450561, 0.000029, 90.000000, 89.999908); 
	tmpobjid = CreatePlayerObject(playerid, 19454, 2422.082275, -1770.387207, 1032.450561, 0.000029, 90.000000, 89.999908); 
	tmpobjid = CreatePlayerObject(playerid, 19454, 2412.446533, -1754.619628, 1032.450561, 0.000044, 90.000000, 89.999862); 
	tmpobjid = CreatePlayerObject(playerid, 19454, 2422.082275, -1754.619628, 1032.450561, 0.000044, 90.000000, 89.999862); 
	tmpobjid = CreatePlayerObject(playerid, 19454, 2428.650146, -1757.686767, 1032.450561, 0.000000, 90.000045, 0.000000); 
	tmpobjid = CreatePlayerObject(playerid, 19454, 2428.650146, -1767.319702, 1032.450561, 0.000000, 90.000045, 0.000000); 
	tmpobjid = CreatePlayerObject(playerid, 19608, 2413.840087, -1758.223388, 1044.936035, 0.000037, 180.000000, 89.999885); 
	tmpobjid = CreatePlayerObject(playerid, 19608, 2420.386474, -1758.223388, 1044.936035, -0.000037, 180.000000, -89.999885); 
	tmpobjid = CreatePlayerObject(playerid, 19608, 2413.840087, -1766.523437, 1044.936035, 0.000052, 180.000000, 89.999839); 
	tmpobjid = CreatePlayerObject(playerid, 19608, 2420.386474, -1766.523437, 1044.936035, -0.000052, 180.000000, -89.999839); 
	tmpobjid = CreatePlayerObject(playerid, 346, 2417.957763, -1749.009399, 1033.203613, 270.000000, 0.000000, 24.199998); 
	return 1;
}

ReloadRareSkins()
{
	DestroyActor(kdmstaffskin);
	DestroyActor(guccisnake);
	DestroyActor(irishpolice);
	DestroyActor(nillyskin);

	kdmstaffskin = CreateActor(20067, 1721.8754, -1656.4478, 20.9688, 178.8593);
	guccisnake = CreateActor(20120, 1721.7507, -1654.7797, 20.9688, 0.4655);
	irishpolice = CreateActor(20121, 1722.6783, -1655.7043, 20.9741, 270.2162);
	nillyskin = CreateActor(20122, 1727.6315, -1668.0815, 22.6094, 41.4650);

	SetActorInvulnerable(kdmstaffskin, false);
	SetActorHealth(kdmstaffskin, 1000);
	SetActorInvulnerable(guccisnake, false);
	SetActorHealth(guccisnake, 1000);
	SetActorInvulnerable(irishpolice, false);
	SetActorHealth(irishpolice, 1000);
	SetActorInvulnerable(nillyskin, false);
	SetActorHealth(nillyskin, 1000);

	ApplyActorAnimation(kdmstaffskin, "DANCING", "dnce_M_a", 4.1, 1, 1, 1, 1, 0); // Pay anim
	ApplyActorAnimation(guccisnake, "DANCING", "dnce_M_a", 4.1, 1, 1, 1, 1, 0); // Pay anim
	ApplyActorAnimation(irishpolice, "DANCING", "dnce_M_a", 4.1, 1, 1, 1, 1, 0); // Pay anim
	ApplyActorAnimation(nillyskin, "DANCING", "dnce_M_a", 4.1, 1, 1, 1, 1, 0); // Pay anim
}

#include <pp-hooks>
hook public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, weaponid, bodypart)
{
	if(inServerHub[playerid] == 1)
	{	
		if(damaged_actorid == kdmstaffskin)
		{
			shotskin[playerid] = 1;
			SetActorPos(kdmstaffskin, 1721.8754, -1656.4478, 20.9688);
			Dialog_Show(playerid, BUYRARESKIN, DIALOG_STYLE_MSGBOX, "Purchase Rare Skin", "{FFFFFF}Skin: {ff8d00}KDM Staff Skin\n{FFFFFF}Price: {ff8d00}10 KDM Tokens\n{FFFFFF}Cash Value: ({ff8d00}$50,000,000 value!{FFFFFF})", "Purchase", "Cancel");
		}
		if(damaged_actorid == guccisnake)
		{
			shotskin[playerid] = 3;
			SetActorPos(guccisnake, 1721.7507, -1654.7797, 20.9688);
			Dialog_Show(playerid, BUYRARESKIN, DIALOG_STYLE_MSGBOX, "Purchase Rare Skin", "{FFFFFF}Skin: {ff8d00}Gucci Snake Skin\n{FFFFFF}Price: {ff8d00}5 KDM Tokens\n{FFFFFF}Cash Value: ({ff8d00}$25,000,000 value!{FFFFFF})", "Purchase", "Cancel");
		}
		if(damaged_actorid == irishpolice)
		{
			shotskin[playerid] = 4;
			SetActorPos(irishpolice, 1722.6783, -1655.7043, 20.9741);
			Dialog_Show(playerid, BUYRARESKIN, DIALOG_STYLE_MSGBOX, "Purchase Rare Skin", "{FFFFFF}kin: {ff8d00}Irish Police Skin\n{FFFFFF}Price: {ff8d00}2 KDM Tokens\n{FFFFFF}Cash Value: ({ff8d00}$10,000,000 value!{FFFFFF})", "Purchase", "Cancel");
		}
		if(damaged_actorid == nillyskin)
		{
			shotskin[playerid] = 5;
			SetActorPos(nillyskin,  1727.6315, -1668.0815, 22.6094);
			Dialog_Show(playerid, BUYRARESKIN, DIALOG_STYLE_MSGBOX, "Purchase Rare SKin", "{FFFFFF}Skin: {ff8d00}Nilly Skin\n{FFFFFF}Price: {ff8d00}1 KDM Tokens\n{FFFFFF}Cash Value: ({ff8d00}$5,000,000 value!{FFFFFF})", "Purchase", "Cancel");
		}
	}
	if(damaged_actorid == serverhubnpc)
	{
		cmd_serverhub(9999, playerid);
	}
}

Dialog:BUYRARESKIN(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(shotskin[playerid] == 1)
		{
			if(Account[playerid][Tokens] >= 10)
			{
				Account[playerid][Tokens] = Account[playerid][Tokens] - 10;
				SendClientMessageToAll(COLOR_LIGHTRED, sprintf("Server Hub: {%06x}%s {FFFFFF}has just purchase the KDM Staff Skin for 10 KDM Tokens! ($50,000,000 Value!)", GetPlayerColor(playerid) >>> 8, GetName(playerid)));
				Account[playerid][hasKDMStaffSkin] = 1;
				Account[playerid][RareSkins]++;
			}
			else return SendClientMessage(playerid, -1, "{31AEAA}Server Hub: {FFFFFF}You don't have enough tokens to buy this item! Refer to /tokenhelp.");
		}
		if(shotskin[playerid] == 3)
		{
			if(Account[playerid][Tokens] >= 5)
			{
				Account[playerid][Tokens] = Account[playerid][Tokens] - 5;
				SendClientMessageToAll(COLOR_LIGHTRED, sprintf("Server Hub: {%06x}%s {FFFFFF}has just purchase the Gucci Snake Skin for 5 KDM Tokens! ($25,000,000 Value!)", GetPlayerColor(playerid) >>> 8, GetName(playerid)));
				Account[playerid][hasGucciSnakeSkin] = 1;
				Account[playerid][RareSkins]++;
			}
			else return SendClientMessage(playerid, -1, "{31AEAA}Server Hub: {FFFFFF}You don't have enough tokens to buy this item! Refer to /tokenhelp.");
		}
		if(shotskin[playerid] == 4)
		{
			if(Account[playerid][Tokens] >= 2)
			{
				Account[playerid][Tokens] = Account[playerid][Tokens] - 2;
				SendClientMessageToAll(COLOR_LIGHTRED, sprintf("Server Hub: {%06x}%s {FFFFFF}has just purchase the Irish Police Skin for 2 KDM Tokens! ($10,000,000 Value!)", GetPlayerColor(playerid) >>> 8, GetName(playerid)));
				Account[playerid][hasIrishPoliceSkin] = 1;
				Account[playerid][RareSkins]++;
			}
			else return SendClientMessage(playerid, -1, "{31AEAA}Server Hub: {FFFFFF}You don't have enough tokens to buy this item! Refer to /tokenhelp.");
		}
		if(shotskin[playerid] == 5)
		{
			if(Account[playerid][Tokens] >= 1)
			{
				Account[playerid][Tokens] = Account[playerid][Tokens] - 1;
				SendClientMessageToAll(COLOR_LIGHTRED, sprintf("Server Hub: {%06x}%s {FFFFFF}has just purchase the Nilly Skin for 1 KDM Tokens! ($5,000,000 Value!)", GetPlayerColor(playerid) >>> 8, GetName(playerid)));
				Account[playerid][hasNillySkin] = 1;
				Account[playerid][RareSkins]++;
			}
			else return SendClientMessage(playerid, -1, "{31AEAA}Server Hub: {FFFFFF}You don't have enough tokens to buy this item! Refer to /tokenhelp.");
		}
		return 1;
	}
	return 0;
}
CMD:rareitems(cmdid, playerid, params[])
{
	Dialog_Show(playerid, RAREDIALOG, DIALOG_STYLE_LIST, "Rare Items", sprintf("Rare Skins:\t%i\nRare Items:\t%i", Account[playerid][RareSkins], Account[playerid][RareItems]), "Select", "Cancel");
	return true;
}
Dialog:RAREDIALOG(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(listitem == 0)
		{
			Dialog_Show(playerid, RARESKINS, DIALOG_STYLE_LIST, "Rare Skins", "KDM Staff Skin\nArcher Skin\nGucci Snake Skin\nIrish Police Skins\nNilly Skin", "Select", "Cancel");
		}
		if(listitem == 1)
		{
			Dialog_Show(playerid, RAREITEMS, DIALOG_STYLE_LIST, "Rare Items", "NO\nRARE\nITEMS\nFOUND", "Okay", "Okay");
		}
		return 1;
	}
	return 0;
}
Dialog:RARESKINS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(listitem == 0)
		{
			if(Account[playerid][hasKDMStaffSkin] == 1)
			{
				SetPlayerSkinEx(playerid, 20067);
			}
			else return SendClientMessage(playerid, -1, "{31AEAA}Rare Skins: You have not unlocked this skin yet. You can purchase it using /tokenhelp.");
		}
		if(listitem == 1)
		{
			if(Account[playerid][hasArcherSkin] == 1)
			{
				SetPlayerSkinEx(playerid, 20119);
			}
			else return SendClientMessage(playerid, -1, "{31AEAA}Rare Skins: You have not unlocked this skin yet. You can purchase it using /tokenhelp.");

		}
		if(listitem == 2)
		{
			if(Account[playerid][hasGucciSnakeSkin] == 1)
			{
				SetPlayerSkinEx(playerid, 20120);
			}
			else return SendClientMessage(playerid, -1, "{31AEAA}Rare Skins: You have not unlocked this skin yet. You can purchase it using /tokenhelp.");
		}
		if(listitem == 3)
		{
			if(Account[playerid][hasIrishPoliceSkin] == 1)
			{
				SetPlayerSkinEx(playerid, 20121);
			}
			else return SendClientMessage(playerid, -1, "{31AEAA}Rare Skins: You have not unlocked this skin yet. You can purchase it using /tokenhelp.");
		}
		if(listitem == 4)
		{
			if(Account[playerid][hasNillySkin] == 1)
			{
				SetPlayerSkinEx(playerid, 20122);
			}
			else return SendClientMessage(playerid, -1, "{31AEAA}Rare Skins: You have not unlocked this skin yet. You can purchase it using /tokenhelp.");
		}
		return 1;
	}
	return 0;
}
