local QBCore                  = nil
local firstConnect = false
local allMyOutfits            = {}
local isLoggedIn = false

local removeWear = {
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
}

local faceProps = {
    [0] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- 
	[1] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- 
	[2] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- 
	[3] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- 
	[4] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- 
	[5] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- 
    [6] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- 
    [7] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- 
    [8] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- 
    [9] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- 
    [10] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- 
    [11] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- 
    [12] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- Maske
}

local Gloves = {
    Male = {
        [16] = 4,
        [17] = 4,
        [18] = 4,
        [19] = 0,
        [20] = 1,
        [21] = 2,
        [22] = 4,
        [23] = 5,
        [24] = 6,
        [25] = 8,
        [26] = 11,
        [27] = 12,
        [28] = 14,
        [29] = 15,
        [30] = 0,
        [31] = 1,
        [32] = 2,
        [33] = 4,
        [34] = 5,
        [35] = 6,
        [36] = 8,
        [37] = 11,
        [38] = 12,
        [39] = 14,
        [40] = 15,
        [41] = 0,
        [42] = 1,
        [43] = 2,
        [44] = 4,
        [45] = 5,
        [46] = 6,
        [47] = 8,
        [48] = 11,
        [49] = 12,
        [50] = 14,
        [51] = 15,
        [52] = 0,
        [53] = 1,
        [54] = 2,
        [55] = 4,
        [56] = 5,
        [57] = 6,
        [58] = 8,
        [59] = 11,
        [60] = 12,
        [61] = 14,
        [62] = 15,
        [63] = 0,
        [64] = 1,
        [65] = 2,
        [66] = 4,
        [67] = 5,
        [68] = 6,
        [69] = 8,
        [70] = 11,
        [71] = 12,
        [72] = 14,
        [73] = 15,
        [74] = 0,
        [75] = 1,
        [76] = 2,
        [77] = 4,
        [78] = 5,
        [79] = 6,
        [80] = 8,
        [81] = 11,
        [82] = 12,
        [83] = 14,
        [84] = 15,
        [85] = 0,
        [86] = 1,
        [87] = 2,
        [88] = 4,
        [89] = 5,
        [90] = 6,
        [91] = 8,
        [92] = 11,
        [93] = 12,
        [94] = 14,
        [95] = 15,
        [96] = 4,
        [97] = 4,
        [98] = 4,
        [99] = 0,
        [100] = 1,
        [101] = 2,
        [102] = 4,
        [103] = 5,
        [104] = 6,
        [105] = 8,
        [106] = 11,
        [107] = 12,
        [108] = 14,
        [109] = 15,
        [110] = 4,
        [111] = 4,
        [115] = 112,
        [116] = 112,
        [117] = 112,
        [118] = 112,
        [119] = 112,
        [120] = 112,
        [121] = 112,
        [122] = 113,
        [123] = 113,
        [124] = 113,
        [125] = 113,
        [126] = 113,
        [127] = 113,
        [128] = 113,
        [129] = 114,
        [130] = 114,
        [131] = 114,
        [132] = 114,
        [133] = 114,
        [134] = 114,
        [135] = 114,
        [136] = 15,
        [137] = 15,
        [138] = 0,
        [139] = 1,
        [140] = 2,
        [141] = 4,
        [142] = 5,
        [143] = 6,
        [144] = 8,
        [145] = 11,
        [146] = 12,
        [147] = 14,
        [148] = 112,
        [149] = 113,
        [150] = 114,
        [151] = 0,
        [152] = 1,
        [153] = 2,
        [154] = 4,
        [155] = 5,
        [156] = 6,
        [157] = 8,
        [158] = 11,
        [159] = 12,
        [160] = 14,
        [161] = 112,
        [162] = 113,
        [163] = 114,
        [165] = 4,
        [166] = 4,
        [167] = 4,
    },
    Female = {
        [16] = 11,
        [17] = 3,
        [18] = 3,
        [19] = 3,
        [20] = 0,
        [21] = 1,
        [22] = 2,
        [23] = 3,
        [24] = 4,
        [25] = 5,
        [26] = 6,
        [27] = 7,
        [28] = 9,
        [29] = 11,
        [30] = 12,
        [31] = 14,
        [32] = 15,
        [33] = 0,
        [34] = 1,
        [35] = 2,
        [36] = 3,
        [37] = 4,
        [38] = 5,
        [39] = 6,
        [40] = 7,
        [41] = 9,
        [42] = 11,
        [43] = 12,
        [44] = 14,
        [45] = 15,
        [46] = 0,
        [47] = 1,
        [48] = 2,
        [49] = 3,
        [50] = 4,
        [51] = 5,
        [52] = 6,
        [53] = 7,
        [54] = 9,
        [55] = 11,
        [56] = 12,
        [57] = 14,
        [58] = 15,
        [59] = 0,
        [60] = 1,
        [61] = 2,
        [62] = 3,
        [63] = 4,
        [64] = 5,
        [65] = 6,
        [66] = 7,
        [67] = 9,
        [68] = 11,
        [69] = 12,
        [70] = 14,
        [71] = 15,
        [72] = 0,
        [73] = 1,
        [74] = 2,
        [75] = 3,
        [76] = 4,
        [77] = 5,
        [78] = 6,
        [79] = 7,
        [80] = 9,
        [81] = 11,
        [82] = 12,
        [83] = 14,
        [84] = 15,
        [85] = 0,
        [86] = 1,
        [87] = 2,
        [88] = 3,
        [89] = 4,
        [90] = 5,
        [91] = 6,
        [92] = 7,
        [93] = 9,
        [94] = 11,
        [95] = 12,
        [96] = 14,
        [97] = 15,
        [98] = 0,
        [99] = 1,
        [100] = 2,
        [101] = 3,
        [102] = 4,
        [103] = 5,
        [104] = 6,
        [105] = 7,
        [106] = 9,
        [107] = 11,
        [108] = 12,
        [109] = 14,
        [110] = 15,
        [111] = 3,
        [112] = 3,
        [113] = 3,
        [114] = 0,
        [115] = 1,
        [116] = 2,
        [117] = 3,
        [118] = 4,
        [119] = 5,
        [120] = 6,
        [121] = 7,
        [122] = 9,
        [123] = 11,
        [124] = 12,
        [125] = 14,
        [126] = 15,
        [127] = 3,
        [128] = 3,
        [132] = 129,
        [133] = 129,
        [134] = 129,
        [135] = 129,
        [136] = 129,
        [137] = 129,
        [138] = 129,
        [139] = 130,
        [140] = 130,
        [141] = 130,
        [142] = 130,
        [143] = 130,
        [144] = 130,
        [145] = 130,
        [146] = 131,
        [147] = 131,
        [148] = 131,
        [149] = 131,
        [150] = 131,
        [151] = 131,
        [152] = 131,
        [154] = 153,
        [155] = 153,
        [156] = 153,
        [157] = 153,
        [158] = 153,
        [159] = 153,
        [160] = 153,
        [162] = 161,
        [163] = 161,
        [164] = 161,
        [165] = 161,
        [166] = 161,
        [167] = 161,
        [168] = 161,
        [169] = 15,
        [170] = 15,
        [171] = 0,
        [172] = 1,
        [173] = 2,
        [174] = 3,
        [175] = 4,
        [176] = 5,
        [177] = 6,
        [178] = 7,
        [179] = 9,
        [180] = 11,
        [181] = 12,
        [182] = 14,
        [183] = 129,
        [184] = 130,
        [185] = 131,
        [186] = 153,
        [187] = 0,
        [188] = 1,
        [189] = 2,
        [190] = 3,
        [191] = 4,
        [192] = 5,
        [193] = 6,
        [194] = 7,
        [195] = 9,
        [196] = 11,
        [197] = 12,
        [198] = 14,
        [199] = 129,
        [200] = 130,
        [201] = 131,
        [202] = 153,
        [203] = 161,
        [204] = 161,
        [206] = 3,
        [207] = 3,
        [208] = 3,
    }
}

-- Events
Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
		Citizen.Wait(200)
	end
end)
local girdim = false
RegisterNetEvent("qb-multicharacter:client:chooseChar", function()
    girdim = false
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    if girdim then return end 
    girdim = true
    QBCore.Functions.TriggerCallback('raidClothing:getPlayerSkin', function(pedAppearance)
	    exports['fivem-appearance']:setPlayerAppearance(pedAppearance)
		if GetEntityModel(PlayerPedId()) == `player_zero` then
			print('[raidClothing] The character was born in Michael Character Creation menus is activated.')
			TriggerEvent('raidClothing:CreateFirstCharacter')
		end
	end)
end)



RegisterNetEvent('raidClothing:loadClothing')
AddEventHandler('raidClothing:loadClothing', function()
    local health = GetEntityHealth(PlayerPedId())
    local armour = GetPedArmour(PlayerPedId())

    if IsPedFalling(PlayerPedId()) then
        TriggerEvent("QBCore:Notify", "Unfortunately, good falls, I hope you won't die.", "error")
        return
    end

    QBCore.Functions.TriggerCallback('raidClothing:getPlayerSkin', function(pedAppearance, gender)
        if pedAppearance then 
            exports['fivem-appearance']:setPlayerAppearance(pedAppearance)
        else
            TriggerEvent('raidClothing:CreateFirstCharacter', gender)
        end
    end)

    print('[raidClothing] The character has been renewed.')
    cooldown = true
    Citizen.Wait(500)
    SetEntityHealth(PlayerPedId(), health)
    SetPedArmour(PlayerPedId(), armour)
    -- TriggerEvent("AttachWeapons")
    cooldown = false
end)

RegisterNetEvent('raidClothing:CreateFirstCharacter', function(gender)
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    gender = gender == nil and "Male" or gender
    TriggerServerEvent("raidClothing:setRoutingBucket", QBCore.Key)
    local src = source 
	local config = {
		ped = false,
		headBlend = true,
		faceFeatures = true,
		headOverlays = true,
		components = true,
		props = true
	}


	local ped = PlayerPedId()
    local pos = vector3(-277.603, -960.132, 85.314)
    -- FreezeEntityPosition(ped, true)
    SetEntityCoords(ped, pos.x, pos.y, pos.z)
    SetEntityHeading(ped, 336.6)
    RenderScriptCams(false, true, 500, true, true)
    SetEntityVisible(PlayerPedId(), true)
    Citizen.Wait(500)
    DoScreenFadeIn(250)

    firstConnect = true
    Citizen.CreateThread(function()
        while firstConnect do
            Citizen.Wait(1)
            -- if not IsEntityPlayingAnim(PlayerPedId(), "anim@amb@clubhouse@mini@darts@", "wait_idle", 3) then
            --     QBCore.Shared.RequestAnimDict('anim@amb@clubhouse@mini@darts@', function() -- animasyon oynatma
            --         TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@mini@darts@" , "wait_idle", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
            --     end)
            -- end

            for _, player in ipairs(GetActivePlayers()) do
                if player ~= PlayerId() and NetworkIsPlayerActive(player) then
                    NetworkFadeInEntity(GetPlayerPed(player),true)
               end
            end
        end
        for _, player in ipairs(GetActivePlayers()) do
            if player ~= PlayerId() and NetworkIsPlayerActive(player) then
                NetworkFadeOutEntity(GetPlayerPed(player),false)
            end
        end
        local playerPed = PlayerPedId()
        DoScreenFadeOut(1000)
        while not IsScreenFadedOut() do Citizen.Wait(100) end
        SetEntityCoords(playerPed, QBCore.Config.DefaultSpawn.x, QBCore.Config.DefaultSpawn.y, QBCore.Config.DefaultSpawn.z)
        SetEntityHeading(playerPed, QBCore.Config.DefaultSpawn.a)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
        ClearPedTasksImmediately(playerPed)
        -- FreezeEntityPosition(playerPed, false)
    end)
    if gender == "Male" then
        RequestModel("mp_m_freemode_01")
		while not HasModelLoaded("mp_m_freemode_01") do
			Citizen.Wait(0)
		end

        SetPlayerModel(PlayerId(), "mp_m_freemode_01")
        SetModelAsNoLongerNeeded("mp_m_freemode_01")
        exports['fivem-appearance']:setPlayerModel("mp_m_freemode_01")
    else
        RequestModel("mp_f_freemode_01")
		while not HasModelLoaded("mp_f_freemode_01") do
			Citizen.Wait(0)
		end

        SetPlayerModel(PlayerId(), "mp_f_freemode_01")
        SetModelAsNoLongerNeeded("mp_f_freemode_01")
        exports['fivem-appearance']:setPlayerModel("mp_f_freemode_01")
    end
    ClearPedDecorations(PlayerPedId())
	exports['fivem-appearance']:startPlayerCustomization(function(pedAppearance)
		local pedModel = GetEntityModel(PlayerPedId())
		firstConnect = false
	    TriggerServerEvent("raidClothing:saveSkin", pedModel, pedAppearance)
	    TriggerServerEvent("kimlikver", src)
        isLoggedIn = true
	end, config)
end, false)

RegisterNetEvent('raidClothing:adminEvent', function()
    TriggerEvent('qb-menu:client:openMenu', {
        {
            icon = "fas fa-shirt",
            header = "Change clothes",
			params = {
				event = "raidClothing:adminMenu"
			}
        },
        {
            header = "Registered clothes",
            icon = "fas fa-floppy-disk",
            params = {
                event = "raidClothing:pickNewOutfit",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
		{
            icon = "fas fa",
            header = "Delete the registered outfit",
            icon = "fas fa-user-xmark",
            params = {
                event = "raidClothing:deleteOutfitMenu",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }
    })
end)

-- RegisterCommand("kıyafetci", function()
--     TriggerEvent('qb-menu:client:openMenu', {
--         {
--             header = "Kayıtlı Kıyafetler",
--             icon = "fas fa-floppy-disk",
--             params = {
--                 event = "raidClothing:outfitsMenu",
--             }
--         }
--     })
-- end)

RegisterNetEvent('raidClothing:clothingShop', function()
    TriggerEvent('qb-menu:client:openMenu', {
        {
            icon = "fas fa-shirt",
            header = "Change clothes",
			params = {
				event = "raidClothing:clothingMenu"
			}
        },
        {
            icon = "fas fa-floppy-disk",
            header = "Registered clothes",
            params = {
                event = "raidClothing:pickNewOutfit",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
		{
            header = "Delete the registered outfit",
            icon = "fas fa-user-xmark",
            params = {
                event = "raidClothing:deleteOutfitMenu",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }
    })
end)

RegisterNetEvent('raidClothing:outfitsMenu', function()
    TriggerEvent('qb-menu:client:openMenu', {
        {
            icon = "fas fa-floppy-disk",
            header = "Registered clothes",
            params = {
                event = "raidClothing:pickNewOutfit2",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
		{
            icon = "fas fa-user-xmark",
            header = "Delete the registered outfit",
            params = {
                event = "raidClothing:deleteOutfitMenu2",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }
    })
end)

RegisterNetEvent('raidClothing:pdMenu', function()
    TriggerEvent('qb-menu:client:openMenu', {
		{
            icon = "fas fa-shirt",
            header = "Change clothes",
			params = {
				event = "raidClothing:clothingMenu"
			}
        },
		{
            icon = "fas fa-floppy-disk",
            header = "Registered clothes",
            params = {
                event = "raidClothing:pickNewOutfit3",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
		{
            icon = "fas fa-user-xmark",
            header = "Delete the registered outfit",
            params = {
                event = "raidClothing:deleteOutfitMenu",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }
    })
end)

RegisterNetEvent('raidClothing:tattoMenu', function()
	local config = {
		ped = false,
		headBlend = false,
		faceFeatures = false,
		headOverlays = false,
		components = false,
		props = false,
        tattoos = true,
	}
	
    local health = GetEntityHealth(PlayerPedId())
    local armour = GetPedArmour(PlayerPedId())

	exports['fivem-appearance']:startPlayerCustomization(function(pedAppearance)
		local pedModel = GetEntityModel(PlayerPedId())
	    TriggerServerEvent("raidClothing:saveSkin", pedModel, pedAppearance)

        Citizen.Wait(500)
    
        SetEntityHealth(PlayerPedId(), health)
        SetPedArmour(PlayerPedId(), armour)
	end, config)
end)

RegisterNetEvent('raidClothing:clothingMenu', function()
	local config = {
		ped = false,
		headBlend = false,
		faceFeatures = false,
		headOverlays = false,
		components = true,
		props = true
	}
	
    local health = GetEntityHealth(PlayerPedId())
    local armour = GetPedArmour(PlayerPedId())

	exports['fivem-appearance']:startPlayerCustomization(function(pedAppearance)
		local pedModel = GetEntityModel(PlayerPedId())
	    TriggerServerEvent("raidClothing:saveSkin", pedModel, pedAppearance)
		TriggerEvent('qb-menu:client:openMenu', {
			{
				header = "Do you want to save the combination?",
                icon = "fas fa-save",
                isMenuHeader = true,
			},
			{
                icon = "fas fa-circle-check",
				header = "Yes",
				params = {
					event = "raidClothing:saveOutfit",
				}
			},
			{
                icon = "fas fa-circle-minus",
				header = "No",
			}
		})

        Citizen.Wait(500)
    
        SetEntityHealth(PlayerPedId(), health)
        SetPedArmour(PlayerPedId(), armour)
	end, config)
end)

RegisterNetEvent('raidClothing:adminMenu', function()
	local config = {
		ped = true,
		headBlend = true,
		faceFeatures = true,
		headOverlays = true,
		components = true,
		props = true
	}
    local health = GetEntityHealth(PlayerPedId())
    local armour = GetPedArmour(PlayerPedId())
	exports['fivem-appearance']:startPlayerCustomization(function(pedAppearance)
      
		local pedModel = GetEntityModel(PlayerPedId())
	    TriggerServerEvent("raidClothing:saveSkin", pedModel, pedAppearance)
		TriggerEvent('qb-menu:client:openMenu', {
			{
				header = "Do you want to save the combination?",
                icon = "fas fa-save",
                isMenuHeader = true,
			},
			{
                icon = "fas fa-circle-check",
				header = "Yes",
				params = {
					event = "raidClothing:saveOutfit",
				}
			},
			{
                icon = "fas fa-circle-minus",
				header = "No",
			}
		})

        Citizen.Wait(500)
        SetEntityHealth(PlayerPedId(), health)
        SetPedArmour(PlayerPedId(), armour)
	end, config)
end)

RegisterNetEvent('raidClothing:barberMenu', function()
	local config = {
		ped = false,
		headBlend = false,
		faceFeatures = false,
		headOverlays = true,
		components = false,
		props = false
	}
    local health = GetEntityHealth(PlayerPedId())
    local armour = GetPedArmour(PlayerPedId())

	exports['fivem-appearance']:startPlayerCustomization(function(pedAppearance)
		local pedModel = GetEntityModel(PlayerPedId())
	    TriggerServerEvent("raidClothing:saveSkin", pedModel, pedAppearance)


        Citizen.Wait(500)
        SetEntityHealth(PlayerPedId(), health)
        SetPedArmour(PlayerPedId(), armour)
	end, config)
end)

RegisterNetEvent('raidClothing:pickNewOutfit', function(data)
    local id = data.id
    local number = data.number
	TriggerEvent('raidClothing:getOutfits')

    tablee = {
        -- {
        --     header = "Geri",
        --     txt = "",
        --     icon = "fas fa-circle-chevron-left",
        --     params = {
        --         event = "raidClothing:clothingShop"
        --     }
        -- },
    }
    Citizen.Wait(150)
	for i=1, #allMyOutfits, 1 do
        table.insert(tablee, {
			header = allMyOutfits[i].name,
            icon = "fas fa-shirt",
            number = i,
			params = {
				event = 'raidClothing:setOutfit',
				args = {
					ped = allMyOutfits[i].pedModel, 
					components = allMyOutfits[i].pedComponents, 
					props = allMyOutfits[i].pedProps
				}
			}
        })
	end
    Citizen.Wait(150)

    exports["qb-menu"]:openMenu(tablee)
end)

RegisterNetEvent('raidClothing:pickNewOutfit2', function(data)
    local id = data.id
    local number = data.number
	TriggerEvent('raidClothing:getOutfits')
    tablee = {
        {
            header = "Back",
            txt = "",
            icon = "fas fa-circle-chevron-left",
            params = {
                event = "raidClothing:clothingShop"
            }
        },
    }

    Citizen.Wait(150)
	for i=1, #allMyOutfits, 1 do
        table.insert(tablee, {
			header = allMyOutfits[i].name .. " (" .. i .. ")",
            icon = "fas fa-shirt",
            number = i,
			params = {
				event = 'raidClothing:setOutfit',
				args = {
					ped = allMyOutfits[i].pedModel, 
					components = allMyOutfits[i].pedComponents, 
					props = allMyOutfits[i].pedProps
				}
			}
        })
	end
    Citizen.Wait(150)

    exports["qb-menu"]:openMenu(tablee)
end)

RegisterNetEvent('raidClothing:getOutfits', function()
	TriggerServerEvent('raidClothing:getOutfits')
end)

RegisterNetEvent('raidClothing:sendOutfits', function(myOutfits)
	local Outfits = {}
	for i=1, #myOutfits, 1 do
		table.insert(Outfits, {id = myOutfits[i].id, name = myOutfits[i].name, pedModel = myOutfits[i].ped, pedComponents = myOutfits[i].components, pedProps = myOutfits[i].props})
	end
	allMyOutfits = Outfits
end)

RegisterNetEvent('raidClothing:setOutfit', function(data)
	local pedModel = data.ped
	local pedComponents = data.components
	local pedProps = data.props
	local playerPed = PlayerPedId()
	local currentPedModel = exports['fivem-appearance']:getPedModel(playerPed)
	if currentPedModel ~= pedModel then
    	exports['fivem-appearance']:setPlayerModel(pedModel)
		Citizen.Wait(500)
		playerPed = PlayerPedId()
		exports['fivem-appearance']:setPedComponents(playerPed, pedComponents)
		exports['fivem-appearance']:setPedProps(playerPed, pedProps)
		local pedAppearance = exports['fivem-appearance']:getPedAppearance(playerPed)
		local pedModel = GetEntityModel(PlayerPedId())
	    TriggerServerEvent("raidClothing:saveSkin", pedModel, pedAppearance)
    else
        QBCore.Functions.Progressbar('name', 'The outfit is changing', 2500, false, true, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'clothingtie',
            anim = 'try_tie_positive_a',
            flags = 16,
        }, {}, {}, function() -- Play When Done
            exports['fivem-appearance']:setPedComponents(playerPed, pedComponents)
            exports['fivem-appearance']:setPedProps(playerPed, pedProps)
            local pedAppearance = exports['fivem-appearance']:getPedAppearance(playerPed)
            local pedModel = GetEntityModel(PlayerPedId())
            TriggerServerEvent("raidClothing:saveSkin", pedModel, pedAppearance)
        end)
    end
end)

RegisterNetEvent('raidClothing:saveOutfit', function()
    local health = GetEntityHealth(PlayerPedId())
    local armour = GetPedArmour(PlayerPedId())
	local keyboard, name = exports['qb-input']:ShowInput({
        header = "Save your outfit",
        submitText = "Save",
        inputs = {
            {
                text = "Clothing name",
                name = "input",
                type = "text",
                isRequired = true
            },
        },
    })
	if keyboard then
			local playerPed = PlayerPedId()
			local pedModel = exports['fivem-appearance']:getPedModel(playerPed)
			local pedComponents = exports['fivem-appearance']:getPedComponents(playerPed)
			local pedProps = exports['fivem-appearance']:getPedProps(playerPed)
			Citizen.Wait(500)
			TriggerServerEvent('raidClothing:saveOutfit', keyboard.input, pedModel, pedComponents, pedProps)
            SetEntityHealth(PlayerPedId(), health)
            SetPedArmour(PlayerPedId(), armour)
		end
end)


RegisterNetEvent('raidClothing:deleteOutfitMenu2', function(data)
    local id = data.id
    local number = data.number
	TriggerEvent('raidClothing:getOutfits')
    tablee = {
        {
            header = "Back",
            txt = "",
            icon = "fas fa-circle-chevron-left",
            params = {
                event = "raidClothing:outfitsMenu"
            }
        },
    }
    
    Citizen.Wait(150)

	for i=1, #allMyOutfits, 1 do
        table.insert(tablee, {
            icon = "fas fa-shirt",
			header = allMyOutfits[i].name,
            number = i,
			params = {
				event = 'raidClothing:deleteOutfit',
				args = allMyOutfits[i].id
			}
        })
	end
    Citizen.Wait(150)

    exports["qb-menu"]:openMenu(tablee)
end)

RegisterNetEvent('raidClothing:deleteOutfitMenu', function(data)
    local id = data.id
    local number = data.number
	TriggerEvent('raidClothing:getOutfits')
    tablee = {
        {
            header = "Back",
            txt = "",
            icon = "fas fa-circle-chevron-left",
            params = {
                event = "raidClothing:clothingShop"
            }
        },
    }
    
    Citizen.Wait(150)

	for i=1, #allMyOutfits, 1 do
        table.insert(tablee, {
            icon = "fas fa-shirt",
			header = allMyOutfits[i].name,
            number = i,
			params = {
				event = 'raidClothing:deleteOutfit',
				args = allMyOutfits[i].id
			}
        })
	end
    Citizen.Wait(150)

    exports["qb-menu"]:openMenu(tablee)
end)

RegisterNetEvent('raidClothing:deleteOutfit', function(id)
	TriggerServerEvent('raidClothing:deleteOutfit', id)
    QBCore.Functions.Notify("DEPERED DEATH", texttype, length)
end)

-- Theads
local blip = false
local aktifblipler = {}
RegisterNetEvent("esx_eden_clotheshop:blipAcKapa")
AddEventHandler("esx_eden_clotheshop:blipAcKapa", function()
	if blip then
		pasifblip()
        QBCore.Functions.Notify("Clothing Blips Blips Closed", "error")
		blip = false
	else
		aktifblip()
        QBCore.Functions.Notify("Clothing Shop Blips Opened", "success")
		blip = true
	end
end)

function aktifblip()
	for k,v in ipairs(Config.ClothingShops) do
		local data = v
		if data.blip == true then
			local clothingShop = AddBlipForCoord(data.coords)
			SetBlipSprite(clothingShop, 73)
            SetBlipColour(clothingShop, 46)
            SetBlipScale(clothingShop, 0.5)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString("Clothes shop")
			EndTextCommandSetBlipName(blip)
            table.insert(aktifblipler, clothingShop)
		end
	end
end

function pasifblip()
	for i = 1, #aktifblipler do
		RemoveBlip(aktifblipler[i])
	end
    aktifblipler = {}
end

local blipBerber = false
local aktifbliplerBerber = {}
RegisterNetEvent("esx_barbershop:blipAcKapa")
AddEventHandler("esx_barbershop:blipAcKapa", function()
	if blipBerber then
		pasifblipBerber()
		blipBerber = false
	else
		aktifblipBerber()
		blipBerber = true
	end
end)

function aktifblipBerber()
	for k,v in ipairs(Config.BarberShops) do
		local barberShop = AddBlipForCoord(v)
		SetBlipSprite(barberShop, 71)
        SetBlipColour(barberShop, 51)
        SetBlipScale(barberShop, 0.5)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("Hairdresser / barber")
		EndTextCommandSetBlipName(blip)
		table.insert(aktifbliplerBerber, barberShop)
	end
end

function pasifblipBerber()
	for i = 1, #aktifbliplerBerber do
		RemoveBlip(aktifbliplerBerber[i])
	end
    aktifbliplerBerber = {}
end

local dovmeBlip = false
local aktifBlipDovmeci = {}
RegisterNetEvent("tattoo:blipAcKapa")
AddEventHandler("tattoo:blipAcKapa", function()
	if dovmeBlip then
		pasifBlipDovme()
        QBCore.Functions.Notify('Tattoo Blips Closed', 'error', 7500)
		dovmeBlip = false
	else
		aktifBlipDovme()
        QBCore.Functions.Notify('Tattoo Blips Opened', 'error', 7500)
		dovmeBlip = true
	end
end)

function aktifBlipDovme()
	for k,v in ipairs(Config.TattoShop) do
		local dovmeci = AddBlipForCoord(v)
		SetBlipSprite(dovmeci, 75)
        SetBlipColour(dovmeci, 1)
        SetBlipScale(dovmeci, 0.7)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("Tattoo store")
		EndTextCommandSetBlipName(blip)
		table.insert(aktifBlipDovmeci, dovmeci)
	end
end

function pasifBlipDovme()
	for i = 1, #aktifBlipDovmeci do
		RemoveBlip(aktifBlipDovmeci[i])
	end
    aktifBlipDovmeci = {}
end

-- Citizen.CreateThread(function()
-- 	for i=1, #Config.ClothingShops, 1 do
--         -- exports['qb-ui']:showInteraction("[ALT] - Kıyafetçi")
-- 	end
	
-- 	for i=1, #Config.BarberShops, 1 do
-- 		-- exports['qb-ui']:showInteraction("[ALT] - Berber")
-- 	end

-- end)

local jobClothing = false
local room = {}
exports('checkclothe', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    for i=1, #Config.ClothingShops do
        if #(pos - Config.ClothingShops[i].coords) < 4 then
            return {true, false}
        end
    end

    for i=1, #Config.BarberShops do
        if #(pos - Config.BarberShops[i]) < 4 then
			return {false, true}
        end
    end

    for i=1, #Config.TattoShop do
        if #(pos - Config.TattoShop[i]) < 4 then
			return {false, false, true}
        end
    end

    return {false, false} 
end)

-- Commands
RegisterCommand('refreshskin', function()
    if exports["tgiann-kelepce"]:isDragged() then
        QBCore.Functions.Notify(':D', 'error')
        return
    end
    
    if cooldown then
        QBCore.Functions.Notify('Cool down guy', 'error')
    else
    --    cooldown = true
       TriggerEvent('raidClothing:loadClothing')
       ExecuteCommand("propfix")
    end
end)

RegisterCommand('propfix', function()
    for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(PlayerPedId(), v) then
            SetEntityAsMissionEntity(v, true, true)
            DeleteObject(v)
            DeleteEntity(v)
        end
    end
end)

RegisterNetEvent("qb-clothing:setKafa", function(args)
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        return
    end
    local data = exports["fivem-appearance"]:checkclothe()
    local clot, ber, dov = data[1], data[2], data[3] 

    if ber == true then
        args[1] = tonumber(args[1])
        args[2] = tonumber(args[2])

        SetPedComponentVariation(PlayerPedId(), 0, args[1], args[2], 0)
    end
end)

local bussy = false
local renk = math.random(0,11)
local renk2 = math.random(0,13)
RegisterNetEvent("qb-clothing:client:adjustfacewear")
AddEventHandler("qb-clothing:client:adjustfacewear",function(type)
    if QBCore.Functions.GetPlayerData().metadata["kelepce"] or QBCore.Functions.GetPlayerData().metadata["pkelepce"] or bussy then return end
    bussy = true
    local playerPed = PlayerPedId()

	if type == 1 then 
        AnimSet = "nmt_3_rcm-10"
        AnimationOn = "cs_nigel_dual-10"
        AnimationOff = "cs_nigel_dual-10"
        time = 1200
    elseif type == 2 then -- maske
        AnimSet = "mp_masks@standard_car@ds@"
        AnimationOn = "put_on_mask"
        AnimationOff = "put_on_mask"
        time = 800
    elseif type == 3 then -- Şapka
        if not removeWear[type] then
            AnimSet = "mp_masks@standard_car@ds@"
            AnimationOn = "put_on_mask"
            time = 600
        else
            AnimSet = "missheist_agency2ahelmet"
            AnimationOff = "take_off_helmet_stand"
            time = 1200
        end
    elseif type == 4 then -- Gözlük
        AnimSet = "clothingspecs"
        AnimationOn = "take_off"
        AnimationOff = "take_off"
        time = 1400
    elseif type == 5 then -- Tişört
        AnimSet = "clothingtie"
        AnimationOn = "try_tie_negative_a"
        AnimationOff = "try_tie_negative_a"
        time = 1200
    elseif type == 6 then -- Çanta
        if not removeWear[type] then
            AnimSet = "clothingtie"
            AnimationOn = "try_tie_negative_a"
            time = 1200
        else
            AnimSet = "anim@heists@ornate_bank@grab_cash"
            AnimationOff = "intro"
            time = 1600
        end
    elseif type == 7 then -- Pantolon
        AnimSet = "re@construction"
        AnimationOn = "out_of_breath"
        AnimationOff = "out_of_breath"
        time = 1300
    elseif type == 8 then -- Ayakkabı
        AnimSet = "random@domestic"
        AnimationOn = "pickup_low"
        AnimationOff = "pickup_low"
        time = 1200
    elseif type == 9 then -- zirh
        AnimSet = "clothingtie"
        AnimationOn = "try_tie_negative_a"
        AnimationOff = "try_tie_negative_a"
        time = 1200
    end
    
	loadAnimDict(AnimSet)
	if removeWear[type] then
		TaskPlayAnim(playerPed, AnimSet, AnimationOff, 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
	else
		TaskPlayAnim(playerPed, AnimSet, AnimationOn, 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    end
    Citizen.Wait(time/2)
    if type == 1 then -- eldiven
        if not removeWear[type] then 
            SetPedComponentVariation(playerPed, 3, faceProps[3]["Prop"], faceProps[3]["Texture"], 2)
        else
            getCloth({"3"})
            local model = GetEntityModel(playerPed)
            if model == 1885233650 then -- Erkek Model
                SetPedComponentVariation(playerPed, 3, Gloves.Male[GetPedDrawableVariation(playerPed, 3)] ,Gloves.Male[GetPedTextureVariation(playerPed, 3)] ,2)
            else
                SetPedComponentVariation(playerPed, 3, Gloves.Female[GetPedDrawableVariation(playerPed, 3)] ,Gloves.Female[GetPedTextureVariation(playerPed, 3)] ,2)
            end
        end
    end

    if type == 2 then -- Maske
        if not removeWear[type] then 
            SetPedComponentVariation(playerPed, 1, faceProps[12]["Prop"], faceProps[12]["Texture"], 2)
        else
            getCloth({"12"})
            SetPedComponentVariation(playerPed, 1, 0 ,0 ,2)
        end
    end

    if type == 3 then -- Şapka
        if not removeWear[type] then 
            SetPedPropIndex(playerPed, 0, faceProps[0]["Prop"], faceProps[0]["Texture"], 2)
        else
            getCloth({"0"}, true)
            ClearPedProp(playerPed, 0)
        end
    end

    if type == 4 then -- Gözlük
        if not removeWear[type] then 
            SetPedPropIndex(playerPed, 1, faceProps[1]["Prop"], faceProps[1]["Texture"], 2)
        else
            getCloth({"1"}, true)
            ClearPedProp(playerPed, 1)
        end
    end

	if type == 5 then -- Tişört
        if not removeWear[type] then 
            SetPedComponentVariation(playerPed, 8, faceProps[8]["Prop"], faceProps[8]["Texture"], 2)
            SetPedComponentVariation(playerPed, 11, faceProps[11]["Prop"], faceProps[11]["Texture"], 2)
            SetPedComponentVariation(playerPed, 3, faceProps[3]["Prop"], faceProps[3]["Texture"], 2)
            SetPedComponentVariation(playerPed, 9, faceProps[9]["Prop"], faceProps[9]["Texture"], 2)
            SetPedComponentVariation(playerPed, 7, faceProps[7]["Prop"], faceProps[7]["Texture"], 2)
        else
            getCloth({"3","7","8","9","11"})
            SetPedComponentVariation(playerPed, 8, 15, 0, 2) --Tshirt
            SetPedComponentVariation(playerPed, 11, 15, 0, 2) --Torso
            SetPedComponentVariation(playerPed, 3, 15, 0, 2) --arms
            SetPedComponentVariation(playerPed, 9, 0, 0, 2) --bproof
            SetPedComponentVariation(playerPed, 7, 0, 0, 2) --chain  
		end
    end

    if type == 6 then -- Çanta
        if not removeWear[type] then 
            SetPedComponentVariation(playerPed, 5, faceProps[5]["Prop"], faceProps[5]["Texture"], 2)
        else
            getCloth({"5"})
            SetPedComponentVariation(playerPed, 5, 0, 0, 2) --bags
        end
    end

    if type == 7 then -- Pantolon
        if not removeWear[type] then 
            SetPedComponentVariation(playerPed, 4, faceProps[4]["Prop"], faceProps[4]["Texture"], 2)
        else
            getCloth({"4"})
            local model = GetEntityModel(playerPed)
            if model == 1885233650 then -- Erkek Model
                SetPedComponentVariation(playerPed, 4, 61, renk2, 2) --pants
            else
                SetPedComponentVariation(playerPed, 4, 15, renk, 2) --pants
            end
        end
    end

    if type == 8 then -- Ayakkabı
        if not removeWear[type] then 
            SetPedComponentVariation(playerPed, 6, faceProps[6]["Prop"], faceProps[6]["Texture"], 2)
        else
            getCloth({"6"})
            local model = GetEntityModel(playerPed)
            if model == 1885233650 then -- Erkek Model
                SetPedComponentVariation(playerPed, 6, 34, 0, 2) --shoes
            else
                SetPedComponentVariation(playerPed, 6, 58, 0, 2) --shoes
            end
        end
    end

    if type == 9 then -- Zırh
        if not removeWear[type] then 
            SetPedComponentVariation(playerPed, 9, faceProps[9]["Prop"], faceProps[9]["Texture"], 2)
        else
            getCloth({"9"})
            local model = GetEntityModel(playerPed)
            if model == 1885233650 then -- Erkek Model
                SetPedComponentVariation(playerPed, 9, 0, 0, 2) --zirh
            else
                SetPedComponentVariation(playerPed, 9, 0, 0, 2) --zirh
            end
        end
    end
    
    Citizen.Wait(time/2)
    ClearPedTasks(playerPed)
    removeWear[type] = not removeWear[type]
    bussy = false
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function getCloth(data, prop)
    for i=1, #data do
        local playerPed = PlayerPedId()
        local number = tonumber(data[i])
        if prop then
            faceProps[number]["Prop"] = GetPedPropIndex(playerPed, number)
            faceProps[number]["Texture"] = GetPedPropTextureIndex(playerPed, number)
        else
            if number == 12 then
                faceProps[12]["Prop"] = GetPedDrawableVariation(playerPed, 1)
                faceProps[12]["Texture"] = GetPedTextureVariation(playerPed, 1)
            else
                faceProps[number]["Prop"] = GetPedDrawableVariation(playerPed, number)
                faceProps[number]["Texture"] = GetPedTextureVariation(playerPed, number)
            end
            
        end
    end
end

RegisterNetEvent("qb-clothing:client:ped")
AddEventHandler("qb-clothing:client:ped", function(ped)
    local model = (type(tonumber(ped))=="number" and ped or GetHashKey(ped))
	local playerPed = PlayerPedId()
	if IsModelValid(model) then
		local player = PlayerId()
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

        exports['fivem-appearance']:setPlayerModel(model)
		SetPlayerModel(PlayerId(), model)
		SetModelAsNoLongerNeeded(model)
        SetPedRandomProps(playerPed)
        SetPedRandomComponentVariation(playerPed, false)
        SetEntityMaxHealth(playerPed, 200)
        SetEntityHealth(playerPed, 200)
        SetModelAsNoLongerNeeded(model)
	end
end)

local defaultHairMale = 12
local defaultHairFemale = 0
local oldHair = { item = -1, texture = -1, active = false}
RegisterCommand("Exit", function()
    local playerPed = PlayerPedId()
    local pedAppearance = exports['fivem-appearance']:getPedAppearance(playerPed)
    if not oldHair.active then
        oldHair.texture = pedAppearance["hair"].color
        oldHair.item = pedAppearance["hair"].style
    end
    local defaultHair = defaultHairFemale
    if GetEntityModel(playerPed) == 1885233650 then defaultHair = defaultHairMale end -- Erkek Model
    if not oldHair.active then
        QBCore.Shared.RequestAnimDict("clothingtie", function()
            TaskPlayAnim(PlayerPedId(), "clothingtie", "check_out_a", 8.0, 8.0, 2000, 1, 1, false, false, false)		
        end)
        SetPedComponentVariation(playerPed, 2, defaultHair, 0, 0)
        oldHair.active = true
    else
        QBCore.Shared.RequestAnimDict("clothingtie", function()
            TaskPlayAnim(PlayerPedId(), "clothingtie", "check_out_a", 8.0, 8.0, 2000, 1, 1, false, false, false)	
        end)
        SetPedComponentVariation(playerPed, 2, oldHair.item, 0, 0)
        oldHair.active = false
    end
    SetPedHairColor(playerPed, oldHair.texture)
end)