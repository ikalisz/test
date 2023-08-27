inUI = false 
local room = false
local QBCore = exports['qb-core']:GetCoreObject()
PlayerData = QBCore.Functions.GetPlayerData()
local showercd = 0, 0, 0
local sleepcd = 0, 0, 0
local motelodasi = false


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    local motelodasi = false
    inUI = false 
    local room = false
end)

RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(data)
	PlayerData = data
end)

Citizen.CreateThread(function()
    local otel = AddBlipForCoord(Config.BlipCoords.x, Config.BlipCoords.y, Config.BlipCoords.z)
    SetBlipSprite(otel, 411)
    SetBlipDisplay(otel, 4)
    SetBlipScale (otel, 0.6)
    SetBlipColour(otel, 0)
    SetBlipAsShortRange(otel, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Motel")
    EndTextCommandSetBlipName(otel)
end)

exports['qb-target']:AddBoxZone("odagir", vector3(-1447.81, -537.42, 34.74), 2.1, 2.1, {
	name = "MissionRowDutyClipboard",
	heading = 35.846,
	debugPoly = false,
	minZ = 33.87834,
	maxZ = 35.56,
	}, {
		options = {
			{
            	type = "client",
            	event = "motel:odagir",
				icon = "fas fa-sign-in",
				label = "Enter Your Motel Room",
			},
            {
            	type = "client",
            	event = "MotelIslemleri",
				icon = "fas fa-tasks",
				label = "Motel Operations",
			},
		},
		distance = 2.0
})

exports['qb-target']:AddBoxZone("odacikclas", vector3(291.01, -924.82, -22.99), 1.2, 1.3, {
	name = "Classic",
	heading = 359.846,
	debugPoly = false,
	minZ = -24.87834,
	maxZ = -20.56,
	}, {
		options = {
			{
            	type = "client",
            	event = "motel:odacik",
				icon = "fas fa-sign-out",
				label = "Leave the Room",
			},
		},
		distance = 2.0
})


exports['qb-target']:AddBoxZone("odaciklux", vector3(-32.37, -586.97, 78.83), 0.8, 1.5, {
	name = "Lux",
	heading = 245.846,
	debugPoly = false,
	minZ = 78.87834,
	maxZ = 80.56,
	}, {
		options = {
			{
            	type = "client",
            	event = "motel:odacik",
				icon = "fas fa-sign-out",
				label = "Leave the Room",
			},
		},
		distance = 2.0
})



Citizen.CreateThread(function()
    while true do
        local wait = 1000
        local playerped = PlayerPedId()
        local entity = GetEntityCoords(playerped)
        for k,v in pairs(Config.EnterMotelCoords) do
            inUI = false
            if GetDistanceBetweenCoords(entity,v.x,v.y,v.z) <= 1 then
                wait = 3
                inUI = true
                exports['qb-ui']:showInteraction("Motel", nil, "motel")
            end
        end
        if not inUI then
            exports['qb-ui']:hideInteraction("motel")
        end
        Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 1000
        local ev = nil
        local function dosyalar(deger,dist)
            local entity = GetEntityCoords(PlayerPedId())
            for k,v in pairs(deger) do
                if #(entity -v) <= dist then
                return true
                end
            end
            return false
        end
        if dosyalar(Config.LuksOdaCikis, 2.0) or dosyalar(Config.DefaultRoomCikis, 1) then
            wait = 3
            exports['qb-ui']:showInteraction("Leave the Room", nil, "odacik")
        else
            exports['qb-ui']:hideInteraction("odacik")
        end
        Citizen.Wait(wait)
    end
end)







RegisterNetEvent('ra1derMotel:client:enterMotelRoom')
AddEventHandler('ra1derMotel:client:enterMotelRoom', function()
    local player = PlayerPedId()
    if QBCore.Functions.GetPlayerData().metadata["motelroom"] == 1 then
        EnterRoomAnimation()
        TriggerEvent('InteractSound_CL:PlayOnOne', Config.EnterRoomSound, Config.AllSoundVolume)
        DoScreenFadeOut(500)
        Wait(500)
        FreezeEntityPosition(player, true)
        SetEntityCoords(player, Config.LuxuryRoomCoord.x, Config.LuxuryRoomCoord.y, Config.LuxuryRoomCoord.z)
        SetEntityHeading(player, Config.LuxuryRoomHeading)
        motelodasi = true
        Wait(1400)
        room = true
        DoScreenFadeIn(1000)
        repeat
            Citizen.Wait(10)
	    until (IsControlJustPressed(0, 32) or IsControlJustPressed(0, 33) or IsControlJustPressed(0, 34) or IsControlJustPressed(0, 35))
        FreezeEntityPosition(player, false)
        TriggerServerEvent('qb-doorlock:server:updateState', "moteldoor", false, false, false, true, false, false)
    else
        EnterRoomAnimation()
        TriggerEvent('InteractSound_CL:PlayOnOne', Config.EnterRoomSound, Config.AllSoundVolume)
        DoScreenFadeOut(500)
        Wait(500)
        FreezeEntityPosition(player, true)
        SetEntityCoords(player, Config.DefaultRoomCoord.x, Config.DefaultRoomCoord.y, Config.DefaultRoomCoord.z)
        SetEntityHeading(player, Config.DefaultRoomHeading)
        motelodasi = true
        Wait(1400)
        room = true
        DoScreenFadeIn(1000)
        repeat
            Citizen.Wait(10)
	    until (IsControlJustPressed(0, 32) or IsControlJustPressed(0, 33) or IsControlJustPressed(0, 34) or IsControlJustPressed(0, 35))
        FreezeEntityPosition(player, false)
    end
end)



RegisterNetEvent('ra1derMotel:client:exitMotelRoom')
AddEventHandler('ra1derMotel:client:exitMotelRoom', function()
    if not motelodasi == false then 
        local player = PlayerPedId()
        EnterRoomAnimation()
        TriggerEvent('InteractSound_CL:PlayOnOne', Config.EnterRoomSound, Config.AllSoundVolume)
        Wait(50)
        DoScreenFadeOut(500)
        Wait(1500)
        SetEntityCoords(player, Config.ExitRoom)
        SetEntityHeading(player, Config.ExitRoomHeading)
        Wait(500)
        room = false
        motelodasi = false
        DoScreenFadeIn(1000)
        TriggerServerEvent('qb-doorlock:server:updateState', "moteldoor", true, true, true, true, true, true)
    else
        QBCore.Functions.Notify('You cant get out of here because youre not in your motel room! Use the /motel command.', 'error', 7500)
    end
end)

function EnterRoomAnimation()
    RequestAnimDictFunction('anim@heists@keycard@', function()
        TaskPlayAnim(PlayerPedId(), 'anim@heists@keycard@', 'exit', 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    end)
end

RegisterNetEvent("OpenStash")
AddEventHandler("OpenStash", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if not motelodasi == false then 
    TriggerEvent('inventory:openInventoryAnim')
    TriggerEvent('InteractSound_CL:PlayOnOne', Config.StashSound, Config.AllSoundVolume)
    TriggerEvent("inventory:client:SetCurrentStash", "ClassicOda_"..PlayerData.citizenid, QBCore.Key)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "ClassicOda_"..PlayerData.citizenid, {
        maxweight = 250000,
        slots = 100,
    })
    else
        exports["elix1rBase"]:SendAlert('You cant open your warehouse because the motel doesnt systematically enter your room.!', "info", 5000)
    end
end)

RegisterNetEvent("OpenLuxuryStash")
AddEventHandler("OpenLuxuryStash", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if not motelodasi == false then 
    TriggerEvent('inventory:openInventoryAnim')
    TriggerEvent('InteractSound_CL:PlayOnOne', Config.StashSound, Config.AllSoundVolume)
    TriggerEvent("inventory:client:SetCurrentStash", "LuksOda_"..PlayerData.citizenid, QBCore.Key)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "LuksOda_"..PlayerData.citizenid, {
        maxweight = 1000000,
        slots = 200,
    })
    else
        exports["elix1rBase"]:SendAlert('You cant open your warehouse because the motel doesnt systematically enter your room.!', "info", 5000)
    end
end)


exports['qb-target']:AddBoxZone("StashClassic", vector3(283.3328, -924.763, -23.56), 1.1, 2.1, {
	name = "MissionRowDutyClipboard",
	heading = 358.846,
	debugPoly = false,
	minZ = -24.87834,
	maxZ = -22.56,
	}, {
		options = {
			{
            	type = "client",
            	event = "OpenStash",
				icon = "far fa-credit-card",
				label = "Access the Warehouse",
			},
		},
		distance = 2.0
})

exports['qb-target']:AddBoxZone("StashLuxury", vector3(-32.11, -584.09, 78.87), 1.1, 3.3, {
	name = "MissionRowDutyClipboard",
	heading = 271.846,
	debugPoly = false,
	minZ = 77.87834,
	maxZ = 79.00,
	}, {
		options = {
			{
            	type = "client",
            	event = "OpenLuxuryStash",
				icon = "far fa-credit-card",
				label = "Access the Warehouse",
			},
		},
		distance = 2.0
})

RegisterNetEvent("OpenClothing")
AddEventHandler("OpenClothing", function()
    if not motelodasi == false then 
        TriggerEvent("raidClothing:outfitsMenu")
        TriggerEvent('InteractSound_CL:PlayOnOne', Config.ClothingSound, Config.AllSoundVolume)
    else
        exports["elix1rBase"]:SendAlert('You cant open the clothing menu because the motel doesnt systematically enter your room.', "info", 5000)
    end
end)

exports['qb-target']:AddBoxZone("ClothingClassic", vector3(286.85, -922.23, -22.07), 2.1, 2.1, {
	name = "Clothingggg",
	heading = 271.23,
	debugPoly = false,
	minZ = -24.56,
	maxZ = -22.87834,
	}, {
		options = {
			{
            	type = "client",
            	event = "OpenClothing",
				icon = "far fa-credit-card",
				label = "Clothes cabinet",
			},
		},
		distance = 2.0
})

exports['qb-target']:AddBoxZone("ClothingLuxury", vector3(-38.42, -589.91, 78.83), 5.1, 5.1, {
	name = "ClothingLuxury",
	heading = 1.888,
	debugPoly = false,
	minZ = 76.56,
	maxZ = 79.87834,
	}, {
		options = {
			{
            	type = "client",
            	event = "OpenClothing",
				icon = "far fa-credit-card",
				label = "Clothes cabinet",
			},
		},
		distance = 2.0
})


RegisterNetEvent("MotelUpgrade", function()
    PlayerData = QBCore.Functions.GetPlayerData()
    if QBCore.Functions.GetPlayerData().metadata["motelroom"] == 0 then
        motelroom = 'Classic Room'
    elseif QBCore.Functions.GetPlayerData().metadata["motelroom"] == 1 then
        motelroom = 'Luxury Room'
    end
        exports['qb-menu']:openMenu({
            {
                header = "Motel",
                txt = "Your Current Room Level : "..motelroom,
                icon = "fa-solid fa-building",
                isMenuHeader = true, -- Set to true to make a nonclickable title
            },
            {
                header = "Buy a Luxury Room",
                txt = "5000$",
                icon = "fa-solid fa-money-bill-wave",
                params = {
                    event = "motel:level",
                }
            },
            {
                header = "Go to Previous Menu",
                icon = "fa-solid fa-chevron-left",
                -- txt = "Mevcut Oda Seviyen" ..motelroom,
                params = {
                    event = "MotelIslemleri",
                }
            },
        })
end)

RegisterNetEvent("MotelIslemleri", function()
    if QBCore.Functions.GetPlayerData().metadata["motelroom"] == 0 then
        motelroom = 'Classic Motel Room'
        elseif QBCore.Functions.GetPlayerData().metadata["motelroom"] == 1 then
            motelroom = 'Lüks Oda'
        end
        PlayerData = QBCore.Functions.GetPlayerData()
        exports['qb-menu']:openMenu({
        {
            header = "Motel Management",
            icon = "fa-solid fa-building",
            -- txt = "🏠 Mevcut Oda Seviyen : "..motelroom,
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = "Upgrade Your Motel Room",
            icon = "fa-solid fa-up-long",
            -- txt = "Mevcut Oda Seviyen" ..motelroom,
            params = {
                event = "MotelUpgrade",
            }
        },
    })
end)

RegisterNetEvent("motel:odagir", function()
    TriggerServerEvent("ra1derMotel:server:enterMotelRoom")
end)

RegisterNetEvent("motel:odacik", function()
    TriggerServerEvent("ra1derMotel:server:exitMotelRoom")
end)

RegisterNetEvent("motel:level", function()
    TriggerServerEvent("ra1derMotel:server:motellevel")
end)

-- RegisterNetEvent("EnterMotel", function()
--         EnterRoomAnimation()
--         TriggerEvent('InteractSound_CL:PlayOnOne', Config.EnterRoomSound, Config.AllSoundVolume)
--         TriggerEvent('ra1derMotel:client:enterMotelRoom')
-- end)

-- RegisterNetEvent("exitMotelRoom")
-- AddEventHandler("exitMotelRoom", function()
--     TriggerEvent('InteractSound_CL:PlayOnOne', Config.ExitRoomSound, Config.AllSoundVolume)
--     EnterRoomAnimation()
--     TriggerServerEvent('ra1derMotel:client:exitMotelRoom')
-- end)

function RequestAnimDictFunction(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then cb() end
end

RegisterCommand("motel", function()
	local playerPed = PlayerPedId()
    local enterCoord = vector3(-1447.64, -537.72, 34.74)
    local enterCoordH = 209
	if #(GetEntityCoords(playerPed) - vector3(291.04, -925.57, -23)) < 15.0 then
        EnterRoomAnimation()
        TriggerEvent('InteractSound_CL:PlayOnOne', Config.EnterRoomSound, Config.AllSoundVolume)
        Wait(50)
        DoScreenFadeOut(500)
        Wait(1500)
        SetEntityCoords(playerPed, enterCoord.x, enterCoord.y, enterCoord.z)
        SetEntityHeading(playerPed, enterCoordH)
        motelodasi = false
        Wait(500)
        DoScreenFadeIn(500)
    elseif #(GetEntityCoords(playerPed) - vector3(-32.72, -586.66, 78.83)) < 15.0 then
        EnterRoomAnimation()
        TriggerEvent('InteractSound_CL:PlayOnOne', Config.EnterRoomSound, Config.AllSoundVolume)
        Wait(50)
        DoScreenFadeOut(500)
        Wait(1500)
        SetEntityCoords(playerPed, enterCoord.x, enterCoord.y, enterCoord.z)
        SetEntityHeading(playerPed, enterCoordH)
        Wait(500)
        DoScreenFadeIn(500)
	else
		exports["elix1rBase"]:SendAlert('You cannot use this command from this location', "info", 5000)
	end
end)



RegisterNetEvent("shower", function()
    local PlayerPed = PlayerPedId()
    if not motelodasi == false then 
        if showercd == 0 or GetGameTimer() > showercd then
            TriggerEvent('InteractSound_CL:PlayOnOne', "dus", "0.05")
            QBCore.Functions.Progressbar("shower", "You're doing a lot of work with your branch", 14500, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "misschinese2_crystalmazemcs1_cs",
                anim = "dance_loop_tao",
                flags = 49,
            }, {}, {}, function()
                    TriggerServerEvent('GSR:Remove')
                ClearPedTasksImmediately(PlayerPed) 
                QBCore.Functions.Notify("you did it", 'primary')
                showercd = GetGameTimer() + Config.ShowerCoolDown	
                QBCore.Functions.Progressbar('name', 'Showering', 2500, false, true, { -- Name | Label | Time | useWhileDead | canCancel
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = 'clothingtie',
                    anim = 'try_tie_positive_a',
                    flags = 16,
                }, {}, {}, function() -- Play When Done
                ClearPedTasksImmediately(PlayerPedId())
                end)	
            end, function()
                shower = true
            end)
            UseParticleFxAssetNextCall("core") 
            particles = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ShowerCoords.x, Config.ShowerCoords.y, Config.ShowerCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false) UseParticleFxAssetNextCall("core") Citizen.Wait(3000) 
            particles2 = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ShowerCoords.x, Config.ShowerCoords.y, Config.ShowerCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false) UseParticleFxAssetNextCall("core") Citizen.Wait(3000) 
            particles3 = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ShowerCoords.x, Config.ShowerCoords.y, Config.ShowerCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false) UseParticleFxAssetNextCall("core") Citizen.Wait(3000) 
            particles4 = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ShowerCoords.x, Config.ShowerCoords.y, Config.ShowerCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false) UseParticleFxAssetNextCall("core") Citizen.Wait(3000) 
            particles5  = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ShowerCoords.x, Config.ShowerCoords.y, Config.ShowerCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
        else
            QBCore.Functions.Notify("you already took a shower", 'primary')
        end
    else
        exports["elix1rBase"]:SendAlert('You cant take a shower as the motel doesnt systematically enter your room', "info", 5000)
     end
end)

RegisterNetEvent("shower2", function()
    if not motelodasi == false then 
        local PlayerPed = PlayerPedId()
        if showercd == 0 or GetGameTimer() > showercd then
            TriggerEvent('InteractSound_CL:PlayOnOne', "dus", "0.05")
            QBCore.Functions.Progressbar("shower", "You're doing a lot of work with your branch", 14500, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "misschinese2_crystalmazemcs1_cs",
                anim = "dance_loop_tao",
                flags = 49,
            }, {}, {}, function()
                    TriggerServerEvent('GSR:Remove')
                ClearPedTasksImmediately(PlayerPed) 
                QBCore.Functions.Notify("you did it", 'primary')
                showercd = GetGameTimer() + Config.ShowerCoolDown	
                QBCore.Functions.Progressbar('name', 'Showering', 2500, false, true, { -- Name | Label | Time | useWhileDead | canCancel
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = 'clothingtie',
                    anim = 'try_tie_positive_a',
                    flags = 16,
                }, {}, {}, function() -- Play When Done
                ClearPedTasksImmediately(PlayerPedId())
                end)	
            end, function()
                shower = true
            end)
            UseParticleFxAssetNextCall("core") 
            particles = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ClassicShower.x, Config.ClassicShower.y, Config.ClassicShower.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false) UseParticleFxAssetNextCall("core") Citizen.Wait(3000) 
            particles2 = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ClassicShower.x, Config.ClassicShower.y, Config.ClassicShower.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false) UseParticleFxAssetNextCall("core") Citizen.Wait(3000) 
            particles3 = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ClassicShower.x, Config.ClassicShower.y, Config.ClassicShower.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false) UseParticleFxAssetNextCall("core") Citizen.Wait(3000) 
            particles4 = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ClassicShower.x, Config.ClassicShower.y, Config.ClassicShower.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false) UseParticleFxAssetNextCall("core") Citizen.Wait(3000) 
            particles5  = StartParticleFxLoopedAtCoord("ent_sht_water", Config.ClassicShower.x, Config.ClassicShower.y, Config.ClassicShower.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
        else
            QBCore.Functions.Notify("you already took a shower", 'primary')
        end
    else
        QBCore.Functions.Notify("You can't take a shower as the motel doesn't systematically enter your room.", 'primary')
    end
end)

exports['qb-target']:AddBoxZone("dusal", vector3(-39.31, -581.75, 78.87), 1.5, 1.5, {
	name = "MissionRowDutyClipboard",
	heading = 250.846,
	debugPoly = false,
	minZ = 77.87834,
	maxZ = 80.56,
	}, {
		options = {
			{
            	type = "client",
            	event = "duşal",
				icon = "fas fa-sign-in",
				label = "Take a shower",
			},
		},
		distance = 2.0
})

exports['qb-target']:AddBoxZone("dusal2", vector3(282.92, -924.08, -22.86), 1.3, 1.3, {
	name = "MissionRowDutyClipboard",
	heading = 87.846,
	debugPoly = false,
	minZ = -22.87834,
	maxZ = -20.56,
	}, {
		options = {
			{
            	type = "client",
            	event = "duşal2",
				icon = "fas fa-sign-in",
				label = "Take a shower",
			},
		},
		distance = 2.0
})


RegisterNetEvent("uyu", function()
    local PlayerPed = PlayerPedId()
    if not motelodasi == false then 
        if sleepcd == 0 or GetGameTimer() > sleepcd then
            SetEntityCoords(PlayerPed, Config.motelSleepClassic.x, Config.motelSleepClassic.y, Config.motelSleepClassic.z)
            RequestAnimDict("timetable@tracy@sleep@")
            while not HasAnimDictLoaded("timetable@tracy@sleep@") do
                Citizen.Wait(0)
            end
            TaskPlayAnim(PlayerPed, "timetable@tracy@sleep@", "idle_c", 8.0, -8.0, -1, 0, 0.0, false, false, false)
            DoScreenFadeOut(5000)
            Citizen.Wait(Config.SleepTime)
            TaskPlayAnim(PlayerPed, "timetable@tracy@sleep@", "idle_c", 8.0, -8.0, -1, 0, 0.0, false, false, false)
            DoScreenFadeIn(5000)
            Citizen.Wait(5000)
            FreezeEntityPosition(PlayerPed, false)
            RequestAnimDict("switch@franklin@bed")
            while not HasAnimDictLoaded("switch@franklin@bed") do
                Citizen.Wait(0)
            end
            TaskPlayAnim(PlayerPed, "switch@franklin@bed", "sleep_getup_rubeyes", 8.0, -8.0, -1, 0, 0.0, false, false, false)
            Citizen.Wait(9000)
            if Config.SleepHealth then
                local health = GetEntityHealth(PlayerPed) 
                if health < 200 then
                    SetEntityHealth(PlayerPed, health + 50)
            end
            end
            QBCore.Functions.Notify("You're a little more relaxed", 'primary')
            sleepcd = GetGameTimer() + Config.SleepCoolDown		
            ClearPedTasks(PlayerPed)
            ClearPedTasksImmediately(PlayerPed)
        else
            QBCore.Functions.Notify("you just slept baby", 'primary')
        end
    else
        QBCore.Functions.Notify("You can't sleep because the motel doesn't systematically enter your room", 'primary')
    end

end)

RegisterNetEvent("uyu2", function()
    local PlayerPed = PlayerPedId()
    if not motelodasi == false then 
        if sleepcd == 0 or GetGameTimer() > sleepcd then
            SetEntityCoords(PlayerPed, Config.motelSleepLux.x, Config.motelSleepLux.y, Config.motelSleepLux.z)
            RequestAnimDict("timetable@tracy@sleep@")
            while not HasAnimDictLoaded("timetable@tracy@sleep@") do
                Citizen.Wait(0)
            end
            TaskPlayAnim(PlayerPed, "timetable@tracy@sleep@", "idle_c", 8.0, -8.0, -1, 0, 0.0, false, false, false)
            DoScreenFadeOut(5000)
            Citizen.Wait(Config.SleepTime)
            TaskPlayAnim(PlayerPed, "timetable@tracy@sleep@", "idle_c", 8.0, -8.0, -1, 0, 0.0, false, false, false)
            DoScreenFadeIn(5000)
            Citizen.Wait(5000)
            FreezeEntityPosition(PlayerPed, false)
            RequestAnimDict("switch@franklin@bed")
            while not HasAnimDictLoaded("switch@franklin@bed") do
                Citizen.Wait(0)
            end
            TaskPlayAnim(PlayerPed, "switch@franklin@bed", "sleep_getup_rubeyes", 8.0, -8.0, -1, 0, 0.0, false, false, false)
            Citizen.Wait(9000)
            if Config.SleepHealth then
                local health = GetEntityHealth(PlayerPed) 
                if health < 200 then
                    SetEntityHealth(PlayerPed, health + 50)
            end
            end
            QBCore.Functions.Notify("You're a little more relaxed", 'primary')
            sleepcd = GetGameTimer() + Config.SleepCoolDown		
            ClearPedTasks(PlayerPed)
            ClearPedTasksImmediately(PlayerPed)
        else
            QBCore.Functions.Notify("you just slept baby", 'primary')
        end
    else
        QBCore.Functions.Notify("You can't sleep because the motel doesn't systematically enter your room!", 'primary')
    end
end)


exports['qb-target']:AddBoxZone("uyu", vector3(285.05, -928.24, -22.35), 2, 2, {
	name = "MissionRowDutyClipboard",
	heading = 0,
	debugPoly = false,
	minZ = -24.87834,
	maxZ = -22.56,
	}, {
		options = {
			{
            	type = "client",
            	event = "uyu",
				icon = "fas fa-sign-in",
				label = "Sleep",
			},
		},
		distance = 2.0
})



exports['qb-target']:AddBoxZone("uyu2", vector3(-36.12, -582.47, 79.5), 2, 2, {
	name = "MissionRowDutyClipboard",
	heading = 340,
	debugPoly = false,
	minZ = 77.87834,
	maxZ = 78.56,
	}, {
		options = {
			{
            	type = "client",
            	event = "uyu2",
				icon = "fas fa-sign-in",
				label = "Sleep",
			},
		},
		distance = 2.0
})

