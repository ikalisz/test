QBCore = nil
local nitroActivado = false
local LoadedModels = {}
local createdMenuList = {}
local loadedBlips = {}
local illegalPerm = false
local npc = vector3(456.21, -1317.81, 29.31)
local npc2 = vector3(1131.94, -2276.41, 31.93)
local npc3 = vector3(1321.426, 4314.491, 38.333)
local PlayerData = {}

QBCore = nil
local coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    firstLogin()
end)

function firstLogin()
    PlayerData = QBCore.Functions.GetPlayerData()
    illegalPerm = PlayerData.charinfo.illegal
end

RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(data)
	PlayerData = data
end)

local jobsSelling = {
    {
        ["coords"] = vector3(1220.72 , -3005.43, 4.67),
        ["draw-3d"] = "Press [E] to Sell Grape Crates.",
        ["item"] = "uzumkasa",
        ["money"] = 2500,
        ["blip"] = {
            ["sprite"] = 0,
            ["colour"] = 0,
            ["name"] = "Grape Crate Sales",
        }
    },
    -- {
    --     ["coords"] = vector3(784.89, -2373.00, 21.87),
    --     ["draw-3d"] = "Demir Külçe Satmak İçin [E] Tuşuna Bas.",
    --     ["item"] = "islenmis_demir",
    --     ["money"] = 5,
    --     ["blip"] = {
    --         ["sprite"] = 501,
    --         ["colour"] = 53,
    --         ["name"] = "Demir Satış",
    --     }
    -- },
    -- {
    --     ["coords"] = vector3(1220.16, -2915.91, 4.87),
    --     ["draw-3d"] = "Bakır Külçe Satmak İçin [E] Tuşuna Bas.",
    --     ["item"] = "islenmis_bakir",
    --     ["money"] = 5,
    --     ["blip"] = {
    --         ["sprite"] = 501,
    --         ["colour"] = 56,
    --         ["name"] = "Bakır Satış",
    --     }
    -- },
    -- {
    --      ["coords"] = vector3(1321.389, 4315.098, 80.332),
    --      ["draw-3d"] = "Hayvan Eti Satmak için [E] Tuşuna Bas.",
    --      ["item"] = "geyiketi",
    --      ["money"] = 20,
    --     ["blip"] = {
    --         ["sprite"] = 442,
    --         ["colour"] = 37,
    --         ["name"] = "Hayvan Eti Alıcısı",
    --     }
    -- },
    -- {
    --     ["coords"] = vector3(-591.56, -892.59, 24.94),
    --     ["draw-3d"] = "Tavun Satmak için [E] Tuşuna Bas.",
    --     ["item"] = "packaged_chicken",
    --     ["money"] = 10,
    --     ["blip"] = {
    --         ["sprite"] = 434,
    --         ["colour"] = 33,
    --         ["name"] = "Tavuk Satış",
    --     }
    -- },
    -- {
    --     ["coords"] = vector3(-697.89, -1182.5, 9.71),
    --     ["draw-3d"] = "Talaş Satmak İçin [E] Tuşuna Bas.",
    --     ["item"] = "packaged_plank",
    --     ["money"] = 10,
    --     ["blip"] = {
    --         ["sprite"] = 285,
    --         ["colour"] = 31,
    --         ["name"] = "Odun Satış",
    --     }
    -- },
    -- {
    --     ["coords"] = vector3(10.32 , -666.73, 32.45),
    --     ["draw-3d"] = "Altın Külçe Satmak İçin [E] Tuşuna Bas.",
    --     ["item"] = "islenmis_altin",
    --     ["money"] = 35,
    --     ["blip"] = {
    --         ["sprite"] = 501,
    --         ["colour"] = 46,
    --         ["name"] = "Altın Satış",
    --     }
    -- },
}

local npcSelling = {
    -- {
    --     ["coords"] = vector3(1141.39, -2050.95, 30.52),
    --     ["draw-3d"] = "Mücevher Satmak İçin [E] Tuşuna Bas.",
    --     ["item"] = "jewels",
    --     ["money"] = 1200,
    --     ["blip"] = {
    --         ["sprite"] = 57,
    --         ["colour"] = 1,
    --         ["name"] = "Mücevher Satış",
    --     }
    -- }, 
}

Citizen.CreateThread(function()
    for i=1, #npcSelling do
        local data = npcSelling[i]
    end
end)




function checkItem(itemName)
    if PlayerData.items == nil then PlayerData = QBCore.Functions.GetPlayerData() end
    for x,itemData in pairs(PlayerData.items) do
        if itemData and itemData.name then
            if string.lower(itemData.name) == string.lower(itemName) then
                return itemData
            end
        end
    end
    return false
end

function checkItem(itemName)
    if PlayerData.items == nil then PlayerData = QBCore.Functions.GetPlayerData() end
    for x,itemData in pairs(PlayerData.items) do
        if itemData and itemData.name then
            if string.lower(itemData.name) == string.lower(itemName) then
                return itemData
            end
        end
    end
    return false
end

Citizen.CreateThread(function()
    for key, value in pairs(Config.NPCLER) do
        if value.HasNpc then
            exports["elixir-base"]:pedcreate("craftnpc-"..key, value.ModelHash, value.NpcPos.x, value.NpcPos.y, value.NpcPos.z - 1, value.NpcPos.h)
        end
    end

    while true do
        local time = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        for key, value in pairs(Config.NPCLER) do
            local HudDrawPos = value.NpcPos
            if #(playerCoords - vector3(HudDrawPos.x, HudDrawPos.y, HudDrawPos.z)) <= 2 and coreLoaded then
                time = 1
                local MenuName = key
                local MenuUnique = value.MenuUnique
                local ItemList= value.items
                local IsShop = value.isShop
                local IsCraft = value.isProc
                local IsBildirim = value.policeBildirim
                local illegal = value.illegal
                local legal = value.legal
                QBCore.Functions.DrawText3D(HudDrawPos.x, HudDrawPos.y, HudDrawPos.z+ 1.0, "~w~[~g~E~w~] ".. MenuName, 0.4)
                if IsControlJustReleased(0, 38) then
                    local menuOpen = false
                    if illegalPerm then
                        if illegal then -- menü x
                            menuOpen = false
                        else
                            menuOpen = true
                        end
                    else
                        if legal then -- menü x
                            menuOpen = false
                        else
                            menuOpen = true
                        end
                    end
                    
                    if menuOpen then
                        createdMenuList[MenuName] = {}
                        if IsShop then
                            for key, value in pairs(ItemList) do
                                table.insert(createdMenuList[MenuName], {
                                    label = ('%s - <span style="color:green;">$%s</span>'):format(key, QBCore.Shared.GroupDigits(value.price)),
                                    value = value
                                })
                            end
                        else
                            for key, value in pairs(ItemList) do
                                table.insert(createdMenuList[MenuName], {
                                    label = key,
                                    value = value
                                })
                            end
                        end


                        QBCore.UI.Menu.Open( 'default', GetCurrentResourceName(), MenuUnique, {
                            title    = MenuName,
                            align    = 'left',
                            elements = createdMenuList[MenuName]
                            
                        }, function(data, menu)
                            menu.close()
                            if data.current.value ~= nil then
                                if IsShop then
                                    QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'mahmut_sell', {
                                        title = "How many pieces do you want to buy??",
                                    }, function(data3, menu3)
                                        menu3.close()
                                        if tonumber(data3.value) ~= nil then
                                            TriggerServerEvent("kfzeu:itemal", data.current, tonumber(data3.value))
                                        else
                                            QBCore.Functions.Notify("Please enter a number.")
                                        end
                                    end, function(data3, menu3)
                                        menu3.close()
                                    end)
                                    
                                else
                                    local exportdata =  data.current

                                    QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'eşya_sat', {
                                        title = "Amount to be Produced & Processed"
                                    }, function(data2, menu2)
                                        local number = tonumber(data2.value)
                                        if type(number) == "number" then
                                            local failure = false
                                            for item, value in pairs(exportdata.value.neededitems) do
                                                local itemData = checkItem(item)
                                                if not itemData then
                                                    itemData = {}
                                                    itemData.amount = 0
                                                    failure = true
                                                end 

                                                local currentItem = itemData.amount
                                                local itemCount = value.miktar * number
                                                if currentItem < itemCount then
                                                    QBCore.Functions.Notify("You have "..QBCore.Shared.Items[item].label.." from your stuff "..itemCount.."(Tane:".. QBCore.Shared.Round(itemCount / number) ..")  must be found.", "error")
                                                    failure = true
                                                end 
                                            end

                                            if not failure then 
                                                -- Citizen.CreateThread(function()
                                                --     for item, value in pairs(exportdata.value.neededitems) do
                                                --         TriggerServerEvent("edrp_meatfarm:item-sil", item, value.miktar*number)
                                                --     end
                                                -- end)
                                                QBCore.Functions.TriggerCallback("ra1der_farm:kontrol",function(sonuc)
                                                    if sonuc then
                                                        QBCore.Functions.Progressbar("uretiliyor", "you are taking...", data.current.value.reqTime * number, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                                            disableMovement = true,
                                                            disableCarMovement = true,
                                                            disableMouse = false,
                                                            disableCombat = true,
                                                        }, {
                                                            animDict = "mp_common",
                                                            anim = "givetake1_a",
                                                            flags = 49,
                                                        }, {}, {}, function() -- Done
                                                            for item, value in pairs(exportdata.value.neededitems) do
                                                                local itemData = checkItem(item)
                                                                if not itemData then
                                                                    itemData = {}
                                                                    itemData.amount = 0
                                                                    failure = true
                                                                end 
                
                                                                local currentItem = itemData.amount
                                                                local itemCount = value.miktar * number
                                                                if currentItem < itemCount then
                                                                    QBCore.Functions.Notify("on you "..QBCore.Shared.Items[item].label.." from your stuff "..itemCount.."(Unit:".. QBCore.Shared.Round(itemCount / number) ..")  must be found.", "error")
                                                                    failure = true
                                                                end 
                                                            end
                                                            if not failure then
                                                                TriggerServerEvent("edrp_meatfarm:craftla", exportdata, number)
                                                            end
                                                        end, function() -- Cancel
                                                        end)
                                                    end
                                                end,exportdata,number)
                                            end
                                        else
                                            QBCore.Functions.Notify('Incorrect Quantity!', 'error')
                                        end
                                        menu2.close()
                                    end, function(data2, menu2)
                                        menu2.close()
                                    end)

                                end
                            end

                        end,function(data, menu)
                            menu.close()
                        end)

                    elseif illegalPerm then
                        QBCore.Functions.Notify("You Can't Do This If You're Sworn In!", "error")
                    elseif not illegalPerm then
                        QBCore.Functions.Notify("I Only Work for Sworn People!", "error")
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)

local blip = false
local aktifblipler = {}
RegisterNetEvent("kfzeu-meat-farm:blipAcKapa2")
AddEventHandler("kfzeu-meat-farm:blipAcKapa2", function()
	if blip then
		pasifblip()
		blip = false
	else
		aktifblip()
		blip = true
	end
end)

function aktifblip()
    for key, value in pairs(Config.NPCLER) do
        if value.hasBlip then
            local loadedBlips = AddBlipForCoord(vector3(value.NpcPos.x, value.NpcPos.y, value.NpcPos.z))
			SetBlipSprite (loadedBlips, value.BlipPos.type)
			SetBlipDisplay(loadedBlips, 4)
			SetBlipScale  (loadedBlips, value.BlipPos.size)
			SetBlipColour (loadedBlips, value.BlipPos.color)
			SetBlipAsShortRange(loadedBlips, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(value.BlipPos.blipName)
            EndTextCommandSetBlipName(loadedBlips)
            table.insert(aktifblipler, loadedBlips)
        end

    end
    
    for i=1, #jobsSelling do
        local loadedBlips = AddBlipForCoord(jobsSelling[i]["coords"])
        SetBlipSprite (loadedBlips, jobsSelling[i]["blip"]["sprite"])
        SetBlipDisplay(loadedBlips, 4)
        SetBlipScale  (loadedBlips, 0.7)
        SetBlipColour (loadedBlips, jobsSelling[i]["blip"]["colour"])
        SetBlipAsShortRange(loadedBlips, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(jobsSelling[i]["blip"]["name"])
        EndTextCommandSetBlipName(loadedBlips)
        table.insert(aktifblipler, loadedBlips)
    end
end

function pasifblip()
	for i = 1, #aktifblipler do
		RemoveBlip(aktifblipler[i])
	end

	aktifblipler = {}
end



local menuacikmi = false

Citizen.CreateThread(function()
	while true do
        time = 3000
        if QBCore then
            for i=1, #jobsSelling do
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local distance = #(playerCoords - jobsSelling[i]["coords"])
            
                if distance < 25 then
                    time = 1
                    DrawMarker(20, jobsSelling[i]["coords"].x, jobsSelling[i]["coords"].y, jobsSelling[i]["coords"].z+1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0,0, 100, false, true, 2, false, false, false, false)
                    if distance < 2 then
                        QBCore.Functions.DrawText3D(jobsSelling[i]["coords"].x,jobsSelling[i]["coords"].y,jobsSelling[i]["coords"].z+1.5, jobsSelling[i]["draw-3d"])
                        if IsControlJustReleased(0,38) then
                            menuacikmi = true
                            QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'tavuk_count_sell', {
                                title = "How many do you want to sell?",
                            }, function(data, menu)
                                menu.close()
                                menuacikmi = false
                                if tonumber(data.value) then
                                    menuacikmi = false
                                    TriggerServerEvent('meat-farm:startSelling', jobsSelling[i]["item"], tonumber(data.value), jobsSelling[i]["money"], QBCore.Key)
                                else
                                    menuacikmi = false
                                    QBCore.Functions.Notify("Please enter a number.")
                                end
                            end, function(data3, menu)
                                menu.close()
                                menuacikmi = false
                            end)

                        end
                    end
                end
            end
        end
	
        Citizen.Wait(time)
    end
end)

exports('menuacikmi', function()
    return menuacikmi
end)


Citizen.CreateThread(function()
	while true do
        time = 3000
        if QBCore then
            for i=1, #npcSelling do
                local playerPed2 = PlayerPedId()
                local playerCoords2 = GetEntityCoords(playerPed2)
                local distance2 = #(playerCoords2 - npcSelling[i]["coords"])
            
                if distance2 < 25 then
                    time = 1
                    -- DrawMarker(20, jobsSelling[i]["coords"].x, jobsSelling[i]["coords"].y, jobsSelling[i]["coords"].z+1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0,0, 100, false, true, 2, false, false, false, false)
                    if distance2 < 2 then
                        QBCore.Functions.DrawText3D(npcSelling[i]["coords"].x,npcSelling[i]["coords"].y,npcSelling[i]["coords"].z+1.5, npcSelling[i]["draw-3d"])
                        if IsControlJustReleased(0,38) then
                            menuacikmi = true
                            QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'tavuk_count_sell', {
                                title = "How many do you want to sell?",
                            }, function(data, menu)
                                menuacikmi = false
                                menu.close()
                                if tonumber(data.value) then
                                    menuacikmi = false
                                    TriggerServerEvent('meat-farm:startSelling', npcSelling[i]["item"], tonumber(data.value), npcSelling[i]["money"], QBCore.Key)
                                else
                                    QBCore.Functions.Notify("Please enter a number.")
                                    menuacikmi = false
                                end
                            end, function(data3, menu)
                                menu.close()
                                menuacikmi = false
                            end)

                        end
                    end
                end
            end
        end
	
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
	while true do
        time = 3000
        if QBCore then
            for i=1, #npcSelling do
                local playerPed3 = PlayerPedId()
                local playerCoords3 = GetEntityCoords(playerPed2)
                local distance3 = #(playerCoords3 - npcSelling[i]["coords"])
            
                if distance3 < 25 then
                    time = 1
                    -- DrawMarker(20, jobsSelling[i]["coords"].x, jobsSelling[i]["coords"].y, jobsSelling[i]["coords"].z+1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0,0, 100, false, true, 2, false, false, false, false)
                    if distance3 < 3 then
                        QBCore.Functions.DrawText3D(npcSelling[i]["coords"].x,npcSelling[i]["coords"].y,npcSelling[i]["coords"].z+1.5, npcSelling[i]["draw-3d"])
                        if IsControlJustReleased(0,38) then
                            menuacikmi = true
                            QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'tavuk_count_sell', {
                                title = "How many do you want to sell?",
                            }, function(data, menu)
                                menuacikmi = false
                                menu.close()
                                if tonumber(data.value) then
                                    menuacikmi = false
                                    TriggerServerEvent('meat-farm:startSelling', npcSelling[i]["item"], tonumber(data.value), npcSelling[i]["money"], QBCore.Key)
                                else
                                    QBCore.Functions.Notify("Please enter a number.")
                                    menuacikmi = false
                                end
                            end, function(data3, menu)
                                menuacikmi = false
                                menu.close()
                            end)

                        end
                    end
                end
            end
        end
	
        Citizen.Wait(time)
    end
end)