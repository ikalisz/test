Config                            = {}
Config.DrawDistance               = 100
Config.MarkerColor                = {r = 255, g = 255, b = 0}
Config.ResellPercentage           = 50
Config.SuleymanPara 			  = 1.5

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.ShopInside = vector3(-36.7101, -1054.13, -43.61) 
Config.ShopInsideHeading = 92.92
Config.BuyCoord = vector4(-34.25, -1079.52, 26.69, 74.87)
Config.DealerCarSpawn = vector4(-36.81, -1102.1, 25.42, 340.87)
Config.SuleymanCoord = vector4(-40.21, -1106.86, 25.42, 341.0)

Config.Zones = {
	Pdm = {
		ShopEntering = {
			vector3(-32.96, -1103.41, 26.42),
		},

		BossActions = {
			vector3(-33.01, -1114.82, 26.32),
		},

		SifirSatici = {
			vector3(-40.21, -1106.86, 26.42 ),
		},

		ResellVehicle = {
			vector3(-45.01, -1082.51, -26.43),
		}
	}
}
