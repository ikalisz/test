Config                            = {}
Config.Locale                     = 'tr'

Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false

Config.NPCSpawnDistance           = 100.0
Config.NPCNextToDistance          = 25.0

Config.Vehicles = {
	'washington',
	'asea',
	'asterope',
	'banshee',
	'buffalo',
	'premier',
	'asterope',
	'fugitive',
	'zion',
	'exemplar',
	'prairie',
	'panto',
	'dilettante'
}

Config.VehicleDelivery = vector3(-236.07160949707, -1175.0285644531, 23.04402923584)
Config.VehicleDeliveryPolyZone = PolyZone:Create({
	vector2(-226.19204711914, -1186.1668701172),
	vector2(-246.68196105957, -1186.4364013672),
	vector2(-246.50175476074, -1184.0562744141),
	vector2(-248.2999420166, -1183.322265625),
	vector2(-246.61026000977, -1159.1684570312),
	vector2(-226.10746765137, -1159.4578857422)
}, {
	name="mechanicVehicleDelivery",
	minZ = 22.033143997192,
	maxZ = 24.110214233398
})

Config.Jobs = {"mechanic", "mechanic_bennys", "mechanic_gabz", "mechanic_hayes", "mechanic_vinewood", "mechanic_hayes2"}

Config.Blips = {
	{
		name = "Otto's Auto Parts",
		coord = vector3(831.1467, -812.687, 26.142),
		colour = 8,
	},
	{
		name = "Hayes Auto Bodyshop",
		coord = vector3(-1416.18, -446.78, 35.91),
		colour = 4,
	},
	{
		name = "Bennys Original Motor Works",
		coord = vector3(-35.9572, -1049.20, 28.396),
		colour = 4,
	},
	{
		name = "6STR Tuner WorkShop",
		coord = vector3(139.1574, -3024.02, 7.0405),
		colour = 2,
	},
	{
		name = "Hayes Motorsport Workshop",
		coord = vector3(283.3636, -1809.17, 30.089),
		colour = 5,
	},
}

Config.Zones = {
	["mechanic"] = {
		MechanicActions = vector3(834.5357, -829.144, 26.332), -- galiba ikisin aynı
		VehicleSpawnPoint = vector3(800.8052, -820.489, 25.991),
		Stash = vector3(836.4611, -813.490, 26.353),
	},
	["mechanic_vinewood"] = {
		MechanicActions = vector3(542.15, -200.4, 54.49),
		VehicleSpawnPoint = vector3(546.63, -212.92, 52.97),
		Stash = vector3(545.17, -196.8, 54.49)
	},
	["mechanic_gabz"] = {
		MechanicActions = vector3(810.16, -2322.51, 30.46),-- galiba ikisin aynı
		VehicleSpawnPoint = vector3(837.11, -2348.16, 30.33),
		Stash = vector3(808.11, -2310.18, 30.46),
	},
	["mechanic_hayes"] = {
		MechanicActions = vector3(-1426.87, -458.39, 36.22),
		VehicleSpawnPoint = vector3(-1418.08, -430.26, 35.99),
		Stash = vector3(-1414.05, -451.57, 35.91),
	},
	["mechanic_bennys"] = {
		MechanicActions = vector3(-37.2045, -1036.31, 28.789),
		VehicleSpawnPoint = vector3(-29.6256, -1024.18, 28.926),
		Stash = vector3(-41.8861, -1064.38, 28.396),
	},
	["mechanic_tunner"] = {
		MechanicActions = vector3(124.7341, -3014.17, 7.0408),
		VehicleSpawnPoint = vector3(165.1506, -3047.01, 5.2964),
		Stash = vector3(128.5868, -3013.56, 7.0408),
	},
	["mechanic_hayes2"] = {
		MechanicActions = vector3(283.2888, -1809.20, 30.089),
		VehicleSpawnPoint = vector3(256.1205, -1795.69, 26.354),
		Stash = vector3(256.4288, -1814.51, 26.914),
	},
}

Config.Towables = {
	vector3(-2480.9, -212.0, 17.4),
	vector3(-2723.4, 13.2, 15.1),
	vector3(-3169.6, 976.2, 15.0),
	vector3(-3139.8, 1078.7, 20.2),
	vector3(-1656.9, -246.2, 54.5),
	vector3(-1586.7, -647.6, 29.4),
	vector3(-1036.1, -491.1, 36.2),
	vector3(-1029.2, -475.5, 36.4),
	vector3(75.2, 164.9, 104.7),
	vector3(-534.6, -756.7, 31.6),
	vector3(487.2, -30.8, 88.9),
	vector3(-772.2, -1281.8, 4.6),
	vector3(-663.8, -1207.0, 10.2),
	vector3(719.1, -767.8, 24.9),
	vector3(-971.0, -2410.4, 13.3),
	vector3(-1067.5, -2571.4, 13.2),
	vector3(-619.2, -2207.3, 5.6),
	vector3(1192.1, -1336.9, 35.1),
	vector3(-432.8, -2166.1, 9.9),
	vector3(-451.8, -2269.3, 7.2),
	vector3(939.3, -2197.5, 30.5),
	vector3(-556.1, -1794.7, 22.0),
	vector3(591.7, -2628.2, 5.6),
	vector3(1654.5, -2535.8, 74.5),
	vector3(1642.6, -2413.3, 93.1),
	vector3(1371.3, -2549.5, 47.6),
	vector3(383.8, -1652.9, 37.3),
	vector3(27.2, -1030.9, 29.4),
	vector3(229.3, -365.9, 43.8),
	vector3(-85.8, -51.7, 61.1),
	vector3(-4.6, -670.3, 31.9),
	vector3(-111.9, 92.0, 71.1),
	vector3(-314.3, -698.2, 32.5),
	vector3(-366.9, 115.5, 65.6),
	vector3(-592.1, 138.2, 60.1),
	vector3(-1613.9, 18.8, 61.8),
	vector3(-1709.8, 55.1, 65.7),
	vector3(-521.9, -266.8, 34.9),
	vector3(-451.1, -333.5, 34.0),
	vector3(322.4, -1900.5, 25.8)
}