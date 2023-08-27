Config                            = {}

Config.DrawDistance               = 20.0

Config.Marker                     = { type = 2, x = 0.7, y = 0.7, z = 0.7, r = 255, g = 255, b = 0, a = 100, rotate = false }

Config.ReviveReward               = 200  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'tr'

local second = 1000
local minute = 60 * second
Config.Fuckage = 200

Config.EarlyRespawnTimer          = 3 * minute -- Time til respawn is available

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 250

Config.radius = 1.5

Config.RespawnPoint = { coords = vector3(-451.41, -302.54, 34.91), heading = 246.89 }

Config.Hospitals = {
      Blip = {
            ls = {
                  coords = vector3(300.29, -585.51, 43.28),
                  sprite = 61,
                  scale  = 0.8,
                  color  = 2
            },
            pb = {
                  coords = vector3(-260.12, 6320.16, 32.43),
                  sprite = 61,
                  scale  = 0.8,
                  color  = 2
            },
            ss = {
                  coords = vector3(1837.81, 3675.80, 34.27),
                  sprite = 61,
                  scale  = 0.8,
                  color  = 2
            }
      },

      AmbulanceActions = { -- Tehzizat
            vector3(301.91, -600.5, 43.28),
            vector3(-245.7, 6315.27, 32.43),
            vector3(1830.78, 3678.8, 34.27),
      },

      Kayit = {
            vector3(307.68, -595.23, 43.28),
            vector3(-250.17, 6335.17, 32.43),
            vector3(1830.78, 3675.97, 34.27),
      },
      
      Stash = {
            vector3(306.2, -602.17, 43.28),
            vector3(-251.95, 6310.5, 32.43),
            vector3(1838.43, 3683.33, 34.27),
      },
      
      Duty = {
            vector3(310.79, -597.75, 43.28),
            vector3(-255.41, 6335.7, 32.43),
            vector3(1828.8, 3674.55, 34.27),
            vector3(4428.03, -4452.53, 7.24),
      },
      
      Boss = {
            vector3(297.9, -599.32, 43.28),
            vector3(-255.72, 6306.52, 32.43),
            vector3(1840.56, 3686.66, 34.27),
      },

      Tamir = {
            vector3(340.63, -570.20, 28.31),
      },

      cop = {
            vector3(304.16293334961, -601.697265625, 42.984133911133),            
      },
}

Config.Items = {
      label = "EMS Equipment Cabinet",
      slots = 30,
      items = {
            {
                  name = "weapon_flashlight",
                  amount = 1,
                  type = "weapon",
                  slot = 1,
            },
            {
                  name = "weapon_stungun",
                  amount = 1,
                  type = "weapon",
                  slot = 2,
            },
            {
                  name = "bandage",
                  amount = 10,
                  type = "item",
                  slot = 3,
            },
            {
                  name = "walkie_lspd",
                  amount = 1,
                  type = "item",
                  slot = 4,
            },
            {
                  name = "medikit",
                  amount = 1,
                  type = "item",
                  slot = 5,
            },
            {
                  name = "pk",
                  amount = 1,
                  type = "item",
                  slot = 6,
            },
            {
                  name = "ab", 
                  amount = 1,
                  type = "item",
                  slot = 7,
            },
            {
                  name = "gps",
                  amount = 1,
                  type = "item",
                  slot = 8,
            },
            {
                  name = "su_alti",
                  amount = 1,
                  type = "item",
                  slot = 9,
            },
      }
}