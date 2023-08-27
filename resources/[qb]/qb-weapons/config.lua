Config = {}

Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

exports('eklentiData', function()
    return Config.WeaponAttachments
end)

Config.WeaponAttachments = {
    ["WEAPON_PISTOL"] = { 
        ["flashlight"] = {
            component = "COMPONENT_AT_PI_FLSH",
            label = "Torch",
            item = "flashlight",
        },
        ["clip"] = {
            component = "COMPONENT_PISTOL_CLIP_02",
            label = "Magazine",
            item = "clip",
        },
    },
    ["WEAPON_COMBATPISTOL"] = { 
        ["flashlight"] = {
            component = "COMPONENT_AT_PI_FLSH",
            label = "Torch",
            item = "flashlight",
        },
        ["clip"] = {
            component = "COMPONENT_COMBATPISTOL_CLIP_02",
            label = "Magazine",
            item = "clip",
        },
    },
    ["WEAPON_HEAVYPISTOL"] = { 
        ["flashlight"] = {
            component = "COMPONENT_AT_PI_FLSH",
            label = "Torch",
            item = "flashlight",
        },
        ["clip"] = {
            component = "COMPONENT_HEAVYPISTOL_CLIP_02",
            label = "Magazine",
            item = "clip",
        },
    },
    ["WEAPON_PISTOL50"] = { 
        ["flashlight"] = {
            component = "COMPONENT_AT_PI_FLSH",
            label = "Torch",
            item = "flashlight",
        },
        ["clip"] = {
            component = "COMPONENT_PISTOL50_CLIP_02",
            label = "Magazine",
            item = "clip",
        },
    },
    ["WEAPON_PISTOL_MK2"] = { 
        ["flashlight"] = {
            component = "COMPONENT_AT_PI_FLSH_02",
            label = "Torch",
            item = "flashlight",
        },
        ["clip"] = {
            component = "COMPONENT_PISTOL_MK2_CLIP_02",
            label = "Magazine",
            item = "clip",
        },
        ["scope"] = {
            component = "COMPONENT_AT_PI_RAIL",
            label = "Scope",
            item = "scope",
        },
    },
    ["WEAPON_GLOCK"] = { 
        ["flashlight"] = {
            component = "COMPONENT_AT_AR_FLSH",
            label = "Torch",
            item = "flashlight",
        },
        ["clip"] = {
            component = "COMPONENT_GLOCK_CLIP_01",
            label = "Magazine",
            item = "clip",
        },
        ["scope"] = {
            component = "COMPONENT_AT_PI_RAIL",
            label = "Scope",
            item = "scope",
        },
    },


    -- SMG
    ["WEAPON_SMG"] = { 
        ["flashlight"] = {
            component = "COMPONENT_AT_AR_FLSH",
            label = "Torch",
            item = "flashlight",
        },
        ["clip"] = {
            component = "COMPONENT_SMG_CLIP_02",
            label = "Magazine",
            item = "clip",
        },
        ["scope"] = {
            component = "COMPONENT_AT_SCOPE_MACRO_02",
            label = "Scope",
            item = "scope",
        },
    },
    ["WEAPON_MINISMG"] = { 
        ["flashlight"] = {
            component = "COMPONENT_AT_AR_FLSH",
            label = "Torch",
            item = "flashlight",
        },
        ["clip"] = {
            component = "COMPONENT_SMG_CLIP_02",
            label = "Magazine",
            item = "clip",
        },
        ["scope"] = {
            component = "COMPONENT_AT_SCOPE_MACRO_02",
            label = "Scope",
            item = "scope",
        },
    },
    ["WEAPON_MICROSMG"] = { 
        ["flashlight"] = {
            component = "COMPONENT_AT_AR_FLSH",
            label = "Torch",
            item = "flashlight",
        },
        ["clip"] = {
            component = "COMPONENT_SMG_CLIP_02",
            label = "Magazine",
            item = "clip",
        },
        ["scope"] = {
            component = "COMPONENT_AT_SCOPE_MACRO_02",
            label = "Scope",
            item = "scope",
        },
    },
    ["WEAPON_SMG_MK2"] = { 
        ["flashlight"] = {
            component = "COMPONENT_AT_AR_FLSH",
            label = "Torch",
            item = "flashlight",
        },
        ["clip"] = {
            component = "COMPONENT_SMG_MK2_CLIP_02",
            label = "Magazine",
            item = "clip",
        },
        ["scope"] = {
            component = "COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2",
            label = "Scope",
            item = "scope",
        },
    },

    -- Rifle
    ["WEAPON_ASSAULTRIFLE_MK2"] = { 
        ["flashlight"] = {
            component = "COMPONENT_AT_AR_FLSH",
            label = "Torch",
            item = "flashlight",
        },
        ["grip"] = {
            component = "COMPONENT_AT_AR_AFGRIP_02",
            label = "Tutamaç",
            item = "grip",
        },
        ["clip"] = {
            component = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
            label = "Magazine",
            item = "clip",
        },

        ["scope"] = {
            component = "COMPONENT_AT_SIGHTS",
            label = "Scope",
            item = "scope",
        },
        ["scope2"] = {
            component = "COMPONENT_AT_SCOPE_MACRO_MK2",
            label = "Scope",
            item = "scope2",
        },
        ["scope3"] = {
            component = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
            label = "Scope",
            item = "scope3",
        },
        ["muzzle"] = {
            component = "COMPONENT_AT_MUZZLE_01",
            label = "Muzzle",
            item = "muzzle",
        },
        ["muzzle2"] = {
            component = "COMPONENT_AT_MUZZLE_02",
            label = "Muzzle",
            item = "muzzle2",
        },
        ["muzzle3"] = {
            component = "COMPONENT_AT_MUZZLE_03",
            label = "Muzzle",
            item = "muzzle3",
        },
        ["muzzle4"] = {
            component = "COMPONENT_AT_MUZZLE_04",
            label = "Muzzle",
            item = "muzzle4",
        },
        ["muzzle5"] = {
            component = "COMPONENT_AT_MUZZLE_05",
            label = "Muzzle",
            item = "muzzle5",
        },
        ["muzzle6"] = {
            component = "COMPONENT_AT_MUZZLE_06",
            label = "Muzzle",
            item = "muzzle6",
        },
        ["muzzle7"] = {
            component = "COMPONENT_AT_MUZZLE_07",
            label = "Muzzle",
            item = "muzzle7",
        },
    },
    ["WEAPON_CARBINERIFLE_MK2"] = { 
        ["flashlight"] = {
            component = "COMPONENT_AT_AR_FLSH",
            label = "Torch",
            item = "flashlight",
        },
        ["grip"] = {
            component = "COMPONENT_AT_AR_AFGRIP_02",
            label = "Tutamaç",
            item = "grip",
        },
        ["clip"] = {
            component = "COMPONENT_CARBINERIFLE_MK2_CLIP_02",
            label = "Magazine",
            item = "clip",
        },

        ["scope"] = {
            component = "COMPONENT_AT_SIGHTS",
            label = "Scope",
            item = "scope",
        },
        ["scope2"] = {
            component = "COMPONENT_AT_SCOPE_MACRO_MK2",
            label = "Scope",
            item = "scope2",
        },
        ["scope3"] = {
            component = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
            label = "Scope",
            item = "scope3",
        },

        ["muzzle"] = {
            component = "COMPONENT_AT_MUZZLE_01",
            label = "Muzzle",
            item = "muzzle",
        },
        ["muzzle2"] = {
            component = "COMPONENT_AT_MUZZLE_02",
            label = "Muzzle",
            item = "muzzle2",
        },
        ["muzzle3"] = {
            component = "COMPONENT_AT_MUZZLE_03",
            label = "Muzzle",
            item = "muzzle3",
        },
        ["muzzle4"] = {
            component = "COMPONENT_AT_MUZZLE_04",
            label = "Muzzle",
            item = "muzzle4",
        },
        ["muzzle5"] = {
            component = "COMPONENT_AT_MUZZLE_05",
            label = "Muzzle",
            item = "muzzle5",
        },
        ["muzzle6"] = {
            component = "COMPONENT_AT_MUZZLE_06",
            label = "Muzzle",
            item = "muzzle6",
        },
        ["muzzle7"] = {
            component = "COMPONENT_AT_MUZZLE_07",
            label = "Muzzle",
            item = "muzzle7",
        },

    },
}


Config.WeaponsDamage = {
    [`WEAPON_NIGHTSTICK`] = {model = `WEAPON_NIGHTSTICK`, modifier = 0.75, disableCriticalHitsHits = true},
    [`WEAPON_FLASHLIGHT`] = {model = `WEAPON_NIGHTSTICK`, modifier = 0.75, disableCriticalHits = true},

    [`WEAPON_UNARMED`] = {model = `WEAPON_UNARMED`, modifier = 0.2, disableCriticalHits = true}, -- 22 yumruk
    [`WEAPON_SNSPISTOL`] = {model = `WEAPON_SNSPISTOL`, modifier = 0.55, disableCriticalHits = true}, -- 10 mermi
    [`WEAPON_PISTOL50`] = {model = `WEAPON_PISTOL50`, modifier = 0.65, disableCriticalHits = true}, --
    [`WEAPON_HEAVYPISTOL`] = {model = `WEAPON_HEAVYPISTOL`, modifier = 0.75, disableCriticalHits = true}, --
    [`WEAPON_PISTOL`] = {model = `WEAPON_PISTOL`, modifier = 0.65, disableCriticalHits = true}, -- 6 mermi
    [`WEAPON_KNIFE`] = {model = `WEAPON_KNIFE`, modifier = 0.65, disableCriticalHits = true}, -- 3 bıçak
    [`WEAPON_BATS`] = {model = `WEAPON_BATS`, modifier = 0.5, disableCriticalHits = true}, -- 3 sopa
    [`WEAPON_KNUCKLE`] = {model = `WEAPON_KNUCKLE`, modifier = 0.75, disableCriticalHits = true}, -- 3 yumruk
    [`WEAPON_NIGHTSTICK`] = {model = `WEAPON_NIGHTSTICK`, modifier = 0.75, disableCriticalHits = true}, -- 2 sopa


    [`WEAPON_HAMMER`] = {model = `WEAPON_HAMMER`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_BAT`] = {model = `WEAPON_BAT`, modifier = 0.2, disableCriticalHits = true},

    [`WEAPON_BATTLEAXE`] = {model = `WEAPON_BATTLEAXE`, modifier = 0.2, disableCriticalHits = true},
    [`WEAPON_GOLFCLUB`] = {model = `WEAPON_GOLFCLUB`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_CROWBAR`] = {model = `WEAPON_CROWBAR`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_BOTTLE`] = {model = `WEAPON_BOTTLE`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_DAGGER`] = {model = `WEAPON_DAGGER`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_HATCHET`] = {model = `WEAPON_HATCHET`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_MACHETE`] = {model = `WEAPON_MACHETE`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_SWITCHBLADE`] = {model = `WEAPON_SWITCHBLADE`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_PROXMINE`] = {model = `WEAPON_PROXMINE`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_BZGAS`] = {model = `WEAPON_BZGAS`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_SMOKEGRENADE`] = {model = `WEAPON_SMOKEGRENADE`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_MOLOTOV`] = {model = `WEAPON_MOLOTOV`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_REVOLVER`] = {model = `WEAPON_REVOLVER`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_POOLCUE`] = {model = `WEAPON_POOLCUE`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_PIPEWRENCH`] = {model = `WEAPON_PIPEWRENCH`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_PISTOL_MK2`] = {model = `WEAPON_PISTOL_MK2`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_COMBATPISTOL`] = {model = `WEAPON_COMBATPISTOL`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_APPISTOL`] = {model = `WEAPON_APPISTOL`, modifier = 0.75, disableCriticalHits = true},

    [`WEAPON_VINTAGEPISTOL`] = {model = `WEAPON_VINTAGEPISTOL`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_GLOCK`] = {model = `WEAPON_GLOCK`, modifier = 0.80, disableCriticalHits = true},
    [`WEAPON_FLAREGUN`] = {model = `WEAPON_FLAREGUN`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_MARKSMANPISTOL`] = {model = `WEAPON_MARKSMANPISTOL`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_MICROSMG`] = {model = `WEAPON_MICROSMG`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_MINISMG`] = {model = `WEAPON_MINISMG`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_SMG`] = {model = `WEAPON_SMG`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_SMG_MK2`] = {model = `WEAPON_SMG_MK2`, modifier = 0.75, disableCriticalHits = true},
    [`weapon_microsmg3`] = {model = `weapon_microsmg3`, modifier = 0.55, disableCriticalHits = true},
    [`WEAPON_ASSAULTSMG`] = {model = `WEAPON_ASSAULTSMG`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_MG`] = {model = `WEAPON_MG`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_COMBATMG`] = {model = `WEAPON_COMBATMG`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_COMBATMG_MK2`] = {model = `WEAPON_COMBATMG_MK2`, modifier = 0.75, disableCriticalHits = true},
    [`WEAPON_COMBATPDW`] = {model = `WEAPON_COMBATPDW`, modifier = 0.75, disableCriticalHits = true},
}