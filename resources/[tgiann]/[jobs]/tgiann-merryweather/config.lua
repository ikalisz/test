Config                            = {}

Config.Blip = {
    Coords  = vector3(502.22, -3128.76, 6.07),
    Sprite  = 175,
    Display = 4,
    Scale   = 0.7,
    Colour  = 26
}

Config.MafiaStation = {
    merryWeather = {
        Armories = {
            vector3(575.8, -3121.75, 18.50)
        },

        BossActions = {
            vector3(573.17, -3124.13, 18.50)
        },

        paraTasima = {
            vector3(502.22, -3128.76, 6.07)
        }
    }
}

Config.Items = {
    label = "Private Security Armory",
    slots = 30,
    items = {
		[1] = {
            name = "weapon_heavypistol",
            amount = 1,
            type = "weapon",
            slot = 1,
        },
        [2] = {
            name = "weapon_combatpdw",
            amount = 1,
            type = "weapon",
            slot = 2,
		},
		[3] = {
            name = "weapon_knuckle",
            amount = 1,
            type = "weapon",
            slot = 3,
		},
        [4] = {
            name = "walkie_lspd",
            amount = 1,
            type = "item",
            slot = 4,
        },
		[5] = {
            name = "pistol_ammo",
            amount = 5,
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "smg_ammo",
            amount = 5,
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "armor",
            amount = 50,
            type = "item",
            slot = 7,
        }
    }
}