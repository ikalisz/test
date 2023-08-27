Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableCash                 = true

Config.gsrUpdate                = 1 * 1000          -- Change first number only, how often a new shot is logged dont set this to low keep it above 1 min - raise if you experience performance issues (default: 1 min).
Config.waterClean               = false              -- Set to false if you dont want water to clean off GSR from people who shot
Config.waterCleanTime           = 30 * 1000         -- Change first number only, Set time in water needed to clean off GSR (default: 30 sec).
Config.gsrTime                  = 60 * 60           -- Change The first number only, if you want the GSR to be auto removed faster output is minutes (default: 30 min).
Config.gsrAutoRemove            = 10 * 60 * 1000    -- Change first number only, to set the auto clean up in minuets (default: 10 min).
Config.gsrUpdateStatus          = 5 * 60 * 1000     -- Change first number only, to change how often the client updates hasFired variable dont set it very high... 5-10 min should be fine. (default: 5 min).
Config.UseCharName				= true				-- This will show the suspects name in the PASSED or FAILED notification. Allows cop to make sure they checked the right person.

Config.weaponChecklist = {
    --Get models id here : https://pastebin.com/0wwDZgkF
    0x678B81B1, -- nightStick
    0x84BD7BFD, -- crowBar
    0x60EC506, 	-- Fire Extinguisher
}



Config.PoliceStations = {
    Blip = {
        -- pl = {
        --     Coords  = vector3(-447.05, 6013.13, 31.72),
        --     Sprite  = 60,
        --     Display = 4,
        --     Scale   = 0.8,
        --     Colour  = 5
        -- },
        -- bb = {
        --     Coords  = vector3(1849.87, 3693.18, 34.27),
        --     Sprite  = 60,
        --     Display = 4,
        --     Scale   = 0.8,
        --     Colour  = 5
        -- },
        ls = {
            Coords  = vector3(425.1, -979.5, 30.7),
            Sprite  = 60,
            Display = 4,
            Scale   = 0.8,
            Colour  = 3
        },
        -- rngr = {
        --     Coords  = vector3(382.38070678711, 796.72491455078, 190.49163818359),
        --     Sprite  = 0,
        --     Display = 0,
        --     Scale   = 0.0,
        --     Colour  = 00
        -- },
    },
    
    Stash = { -- silah
        vector3(475.52059936523, -994.21148681641, 26.273273468018),
        vector3(473.92373657227, -1004.3703613281, 26.273305892944),
        vector3(-442.67, 5989.65, 31.72),
        vector3(1850.65, 3695.12, 30.27),
        vector3(4423.34, -4451.2, 7.24),
    },

    PlayerStash = {
        vector3(479.69815063477, -996.66998291016, 30.691989898682),
        vector3(473.18225097656, -1006.9043579102, 26.273305892944),
        vector3(433.43, 5994.27, 31.72),
        vector3(1859.23, 3691.04, 34.27),
        vector3(4433.98, -4451.12, 7.24),
        vector3(387.82119750977, 796.62652587891, 187.67750549316),
    },

    Armories = {
        vector3(485.46905517578, -994.64276123047, 30.689645767212),
        vector3(-437.02, 5988.27, 31.72),
        vector3(1863.07, 3688.78, 34.27),
        vector3(4435.62, -4446.72, 4.33),
        vector3(384.44555664062, 800.21295166016, 187.67750549316),
    },
    
    aractamirvemodifiye = {
        vector3(449.68460083008, -980.91925048828, 44.391421508789),
        vector3(452.01, -976.18, 25.38),
        vector3(-482.4, 6024.32, 31.34),
        vector3(1860.76, 3705.88, 33.03),
        vector3(374.26052856445, 799.19219970703, 187.37438964844),
    },

    Kayit = {
        vector3(-438.17, -323.81, 34.91),
        vector3(-250.17, 6335.17, 32.43),
    },	

    BossActions = {
        vector3(461.5163269043, -986.20703125, 30.728078842163),
        vector3(-436.26, 6000.8, 31.72),
        vector3(1862.18, 3690.58, 34.27),
    },
    
    Duty = {
        vector3(441.86676025391, -982.02746582031, 30.689504623413),
        vector3(-447.83, 6013.02, 31.72),
        vector3(1853.91, 3688.69, 34.27),
        vector3(4428.03, -4452.53, 7.24),
        vector3(381.6533203125, 797.08404541016, 190.4916229248),
    },

    Tamir = {
        vector3(487.93328857422, -997.01782226562, 30.689645767212),
        vector3(-440.38, 5992.59, 31.72),
        vector3(1840.14, 3692.05, 34.27),
    },

    Money = {
        vector3(473.78735351562, -997.22625732422, 26.673273468018),
        vector3(-442.87, 5986.53, 31.72),
        vector3(1847.89, 3694.28, 34.27),
        vector3(4431.76, -4447.23, 7.24),
        vector3(387.54794311523, 800.30151367188, 190.4916229248),
    },

    Trash = {
        vector3(472.06341552734, -994.19067382812, 26.273275375366),
    }
}

Config.Items = {
    label = "Police Armory",
    slots = 40,
    items = {
        {
            name = "flashlight",
            amount = 1,
            type = "item",
            slot = 1,
        },
        -- {
        --     name = "clip",
        --     amount = 1,
        --     type = "item",
        --     slot = 2,
        -- },
        -- {
        --     name = "grip",
        --     amount = 1,
        --     type = "item",
        --     slot = 3,
        -- },
        -- {
        --     name = "scope",
        --     amount = 1,
        --     type = "item",
        --     slot = 4,
        -- },
		-- {
        --     name = "weapon_nightstick",
        --     amount = 1,
        --     type = "weapon",
        --     slot = 5,
        -- },
        -- {
        --     name = "weapon_stungun",
        --     amount = 1,
        --     type = "weapon",
        --     slot = 6,
		-- },
        -- {
        --     name = "weapon_combatpistol",
        --     amount = 1,
        --     type = "weapon",
        --     slot = 7,
        -- },
        -- {
        --     name = "weapon_smg",
        --     amount = 1,
        --     type = "weapon",
        --     slot = 8,
        -- },
        -- {
        --     name = "polis_karti",
        --     amount = 1,
        --     type = "item",
        --     slot = 9,
        -- },
		-- {
        --     name = "weapon_flashlight",
        --     amount = 1,
        --     type = "weapon",
        --     slot = 10,
		-- },
        -- {
        --     name = "walkie_lspd",
        --     amount = 1,
        --     type = "item",
        --     slot = 11,
        -- },
        -- {
        --     name = "gps",
        --     amount = 1,
        --     type = "item",
        --     slot = 12,
		-- },
		-- {
        --     name = "pistol_ammo",
        --     amount = 50,
        --     type = "item",
        --     slot = 13,
        -- },
        -- {
        --     name = "smg_ammo",
        --     amount = 50,
        --     type = "item",
        --     slot = 14,
        -- },
        -- {
        --     name = "rifle_ammo",
        --     amount = 50,
        --     type = "item",
        --     slot = 15,
        -- },
        -- {
        --     name = "pkelepce",
        --     amount = 5,
        --     type = "item",
        --     slot = 16,
        -- },
        -- {
        --     name = "pkelepceanahtar",
        --     amount = 1,
        --     type = "item",
        --     slot = 17,
        -- },
        -- {
        --     name = "armor",
        --     amount = 50,
        --     type = "item",
        --     slot = 18,
        -- },
        -- {
        --     name = "parasut",
        --     amount = 1,
        --     type = "item",
        --     slot = 19,
        -- },
        -- {
        --     name = "weapon_carbinerifle_mk2",
        --     amount = 1,
        --     type = "weapon",
        --     slot = 21,
        -- },
    }
}