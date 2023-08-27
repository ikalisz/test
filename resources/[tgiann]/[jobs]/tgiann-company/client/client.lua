QBCore = nil
local PlayerData = {}
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
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

local playerPed = PlayerPedId()
local playerCoords = GetEntityCoords(playerPed)
local zone = ""
local inProgress = false

Citizen.CreateThread(function()
    for name, data in pairs(blips) do
        local blip = AddBlipForCoord(data.coord)
        SetBlipSprite(blip, data.sprite)
        SetBlipDisplay(blip, 2)
        SetBlipScale(blip, 0.5)
        SetBlipColour(blip, 17)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(data.name)
        EndTextCommandSetBlipName(blip)
    end
    local burgershot = vector3(-1196.74, -891.537, 12.984)
    local burgershotH = 299.7
	exports["elixir-base"]:pedcreate("burgershot", 0x94562DD7, burgershot.x, burgershot.y, burgershot.z,  burgershotH)
    while true do
        Citizen.Wait(500)
        playerPed = PlayerPedId()
        playerCoords = GetEntityCoords(playerPed)
        local foundZone = false
        for name, data in pairs(blips) do
            if #(data.coord - playerCoords) < 150 then
                foundZone = true
                zone = name
                break
            end
        end
        if not foundZone then zone = "" end
    end
end)


exports['qb-target']:AddTargetModel(`a_m_m_farmer_01`, {
    options = {
        {
            event = "burgershot",
            icon = "fas fa-hamburger",
            label = "Burger Shot Market",
        },
    },
    distance = 1.5
})

RegisterNetEvent("burgershot", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.TriggerCallback('elixir-base:burger-sayi', function(burger)
        if burger >= 1 then 
            QBCore.Functions.Notify("You can't buy food from here, there are " ..burger.. " employees.")
        else
            exports['qb-menu']:openMenu({
                {
                    header = "Burger Shot",
                    icon = "fa-solid fa-building",
                    isMenuHeader = true, -- Set to true to make a nonclickable title
                },
                {
                    header = "Buy Burger Menu #1",
                    txt = "Fee : 100$",
                    isServer = true,
                    params = {
                        event = "burgerYemek:client",
                    }
                },
                {
                    header = "Close",
                    -- txt = "Mevcut Oda Seviyen" ..motelroom,
                    params = {
                        event = "qb-menu:closeMenu",
                    }
                },
            })
        end
    end)
end)
RegisterNetEvent("burgerYemek:client", function()
    TriggerServerEvent("burgerYemek")
end)

Citizen.CreateThread(function()
    while true do
        local time = 500
        if coreLoaded then
            if PlayerData.job == nil then PlayerData = QBCore.Functions.GetPlayerData() end
            if PlayerData.job and PlayerData.job.name == zone then
                for name, cutCoord in pairs(cuttingCoords) do
                    local distance = #(cutCoord - playerCoords)
                    if distance < 3 and coreLoaded and not inProgress then
                        time = 1
                        local text = ""
                        if distance < 1.2 then
                            text = "[E] "
                            if IsControlJustReleased(0, 38) then
                                QBCore.UI.Menu.CloseAll()
                                local elements = {}
                                for giveItem, removeItem in pairs(cuttingItems) do
                                    table.insert(elements, {label =  QBCore.Shared.Items[giveItem].label, addItem = giveItem, removeItem = removeItem})
                                end

                                QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'cutMenu', {
                                    title    = 'Cut/Chop Material',
                                    align    = 'left',
                                    elements = elements
                                }, function(data, menu)
                                    menu.close()
                                    if data.current.addItem then
                                        QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'cutAmount', {
                                            title = "How many pieces do you want to cut/chop? (Max 10)"
                                        }, function(data2, menu2)
                                            local wAmount = tonumber(data2.value)
                                            if wAmount == nil or wAmount < 0 or wAmount > 10 or wAmount == 0 then
                                                QBCore.Functions.Notify("Incorrect Value", "error")
                                            else
                                                QBCore.Functions.TriggerCallback("elixir-base:item-kontrol", function(amount)
                                                    if amount >= wAmount then
                                                        menu2.close()
                                                        inProgress = true
                                                        TriggerEvent("dpemotes:play-anim", {"kelepçesök"})
                                                        QBCore.Functions.Progressbar("kd", "Cutting/Chopping", 1000*wAmount, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                                            disableMovement = true,
                                                            disableCarMovement = true,
                                                            disableMouse = false,
                                                            disableCombat = true,
                                                        }, { }, {}, {}, function() -- Done
                                                            inProgress = false
                                                            TriggerEvent("dpemotes:play-anim", {"c"})
                                                            TriggerServerEvent("tgiann-company:giveCutItem", QBCore.Key, data.current.addItem, data.current.removeItem, wAmount)
                                                        end, function() -- Cancel
                                                            inProgress = false
                                                            TriggerEvent("dpemotes:play-anim", {"c"})
                                                        end)
                                                    else
                                                        QBCore.Functions.Notify("On "..wAmount.." Unit "..QBCore.Shared.Items[data.current.removeItem].label.." None!", "error")
                                                    end
                                                end, data.current.removeItem)
                                            end
                                        end, function(data2, menu2)
                                            menu2.close()
                                        end)
                                    end
                                end,function(data, menu)
                                    menu.close()
                                end)
                            end
                        end
                        QBCore.Functions.DrawText3D(cutCoord.x, cutCoord.y, cutCoord.z, text.."Cut/Chop Material")
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 500
        if PlayerData.job and PlayerData.job.name == zone then
            for name, friesCoord in pairs(friesCoords) do
                local distance = #(friesCoord - playerCoords)
                if distance < 3 and coreLoaded and not inProgress then
                    time = 1
                    local text = ""
                    if distance < 1.2 then
                        text = "[E] "
                        if IsControlJustReleased(0, 38) then
                            QBCore.UI.Menu.CloseAll()
                            local elements = {}
                            for giveItem, removeItems in pairs(frieItem) do
                                table.insert(elements, {label =  QBCore.Shared.Items[giveItem].label, addItem = giveItem, removeItem = removeItems})
                            end

                            QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'friesMenu', {
                                title    = 'Make French Fries',
                                align    = 'left',
                                elements = elements
                            }, function(data, menu)
                                menu.close()
                                if data.current.addItem then

                                    QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'cutAmount', {
                                        title = "How Many French Fries Do You Want To Make? (Max 10)"
                                    }, function(data2, menu2)
                                        local wAmount = tonumber(data2.value)
                                        if wAmount == nil or wAmount < 0 or wAmount > 10 or wAmount == 0 then
                                            QBCore.Functions.Notify("Incorrect Value", "error")
                                        else
                                            QBCore.Functions.TriggerCallback("tgiann-company:checkItem", function(success)
                                                if success then
                                                    menu2.close()
                                                    inProgress = true
                                                    TriggerEvent("dpemotes:play-anim", {"elısıt"})
                                                    QBCore.Functions.Progressbar("pkh", "French Fries Preparing", 1000*wAmount, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                                        disableMovement = true,
                                                        disableCarMovement = true,
                                                        disableMouse = false,
                                                        disableCombat = true,
                                                    }, { }, {}, {}, function() -- Done
                                                        inProgress = false
                                                        TriggerEvent("dpemotes:play-anim", {"c"})
                                                        TriggerServerEvent("tgiann-company:giveItem", QBCore.Key, data.current.addItem, data.current.removeItem, wAmount, true)
                                                    end, function() -- Cancel
                                                        inProgress = false
                                                        TriggerEvent("dpemotes:play-anim", {"c"})
                                                    end)
                                                end
                                            end, data.current.removeItem, wAmount)
                                        end
                                    end, function(data2, menu2)
                                        menu2.close()
                                    end)
                                    
                                end
                            end,function(data, menu)
                                menu.close()
                            end)
                        end
                    end
                    QBCore.Functions.DrawText3D(friesCoord.x, friesCoord.y, friesCoord.z, text.."Prepare French Fries")
                end
            end
        end
        Citizen.Wait(time)
    end
end)

--Skill Bar
Citizen.CreateThread(function()
    while true do
        local time = 500
        if PlayerData.job and PlayerData.job.name == zone then
            for name, drinkCoord in pairs(drinkCoords) do
                local distance = #(drinkCoord - playerCoords)
                if distance < 3 and coreLoaded and not inProgress then
                    time = 1
                    local text = ""
                    if distance < 1.2 then
                        text = "[E] "
                        if IsControlJustReleased(0, 38) then
                            QBCore.UI.Menu.CloseAll()
                            local elements = {}
                            for giveItem, removeItems in pairs(drinkItem) do
                                table.insert(elements, {label =  QBCore.Shared.Items[giveItem].label, addItem = giveItem, removeItem = removeItems})
                            end

                            QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'drinkMenu', {
                                title    = 'Prepare Beverage',
                                align    = 'left',
                                elements = elements
                            }, function(data, menu)
                                menu.close()
                                if data.current.addItem then
                                    QBCore.Functions.TriggerCallback("tgiann-company:checkItem", function(success)
                                        if success then
                                            inProgress = true
                                            TriggerEvent("dpemotes:play-anim", {"bardak"})
                                            local finished = exports["tgiann-skillbar"]:taskBar(25000,math.random(10,15), true)
                                            if finished then
                                                TriggerServerEvent("tgiann-company:giveItem", QBCore.Key, data.current.addItem, data.current.removeItem, 1, true)
                                            else
                                                QBCore.Functions.Notify(QBCore.Shared.Items[data.current.addItem].label.." Dropped To The Table!", "error")
                                            end
                                            TriggerEvent("dpemotes:play-anim", {"c"})
                                            inProgress = false
                                        end
                                    end, data.current.removeItem)
                                end
                            end,function(data, menu)
                                menu.close()
                            end)
                        end
                    end
                    QBCore.Functions.DrawText3D(drinkCoord.x, drinkCoord.y, drinkCoord.z, text.."Prepare Beverage")
                end
            end
        end
        Citizen.Wait(time)
    end
end)

-- Skill Bar Yemek Pişirme
Citizen.CreateThread(function()
    while true do
        local time = 500
        if PlayerData.job and PlayerData.job.name == zone then
            for name, foodCoord in pairs(foodCoords) do
                local distance = #(foodCoord - playerCoords)
                if distance < 3 and coreLoaded and not inProgress then
                    time = 1
                    local text = ""
                    if distance < 1.2 then
                        text = "[E] "
                        if IsControlJustReleased(0, 38) then
                            QBCore.UI.Menu.CloseAll()
                            local elements = {}
                            for giveItem, removeItems in pairs(foodItems[zone]) do
                                table.insert(elements, {label =  QBCore.Shared.Items[giveItem].label, addItem = giveItem, removeItem = removeItems})
                            end

                            QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'foodMenu', {
                                title    = 'Prepare Food',
                                align    = 'left',
                                elements = elements
                            }, function(data, menu)
                                menu.close()
                                if data.current.addItem then
                                    QBCore.Functions.TriggerCallback("tgiann-company:checkItem", function(success)
                                        if success then
                                            inProgress = true
                                            TriggerEvent("dpemotes:play-anim", {"bozukluk"})
                                            local finished = exports["tgiann-skillbar"]:taskBar(25000,math.random(10,15), true)
                                            if finished then
                                                TriggerServerEvent("tgiann-company:giveItem", QBCore.Key, data.current.addItem, data.current.removeItem, 1, true)
                                            else
                                                QBCore.Functions.Notify(QBCore.Shared.Items[data.current.addItem].label.." burned!", "error")
                                            end
                                            TriggerEvent("dpemotes:play-anim", {"c"})
                                            inProgress = false
                                        end
                                    end, data.current.removeItem)
                                end
                            end,function(data, menu)
                                menu.close()
                            end)
                        end
                    end
                    QBCore.Functions.DrawText3D(foodCoord.x, foodCoord.y, foodCoord.z, text.."Prepare Food")
                end
            end
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 500
        if PlayerData.job and PlayerData.job.name == zone then
            for name, storageCoord in pairs(storageCoord) do
                local distance = #(storageCoord - playerCoords)
                if distance < 3 and coreLoaded and not inProgress then
                    time = 1
                    local text = ""
                    if distance < 1.2 then
                        text = "[E] "
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("inventory:client:SetCurrentStash", "storage"..zone, QBCore.Key)
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", "storage"..zone, {
                                maxweight = 4000000,
                                slots = 500,
                            })
                        end
                    end
                    QBCore.Functions.DrawText3D(storageCoord.x, storageCoord.y, storageCoord.z, text.."Depo")
                end
            end
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 500
        for name, tableCoord in pairs(tableCoord) do
            local distance = #(tableCoord - playerCoords)
            if distance < 3 and coreLoaded and not inProgress then
                time = 1
                local text = ""
                if distance < 1.2 then
                    text = "[E] "
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent("inventory:client:SetCurrentStash", "table"..zone, QBCore.Key)
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "table"..zone, {
                            maxweight = 4000000,
                            slots = 500,
                        })
                    end
                end
                QBCore.Functions.DrawText3D(tableCoord.x, tableCoord.y, tableCoord.z, text.."Stand")
            end
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
        if IsControlJustReleased(0, 167) and PlayerData.job then
            local haveJob = false
            for job, data in pairs(blips) do
                if PlayerData.job.name == job then
                    haveJob = true
                    break
                end
            end

            if haveJob then
                QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'foodMenu', {
                    title    = 'Business Menu',
                    align    = 'left',
                    elements = {
                        {label = "Fatura Kes", value = "bill"},
                        {label = "Paketle", value = "packet"}
                    }
                }, function(data, menu)
                    menu.close()
                    if data.current.value == "bill" then
                        QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
                            title = "Total Amount of Fine to be Deducted"
                        }, function(data2, menu2)
                            local amount = tonumber(data2.value)
                            if amount == nil or amount < 0 then
                                QBCore.Functions.Notify("Incorrect Value")
                            else
                                local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                                if closestPlayer == -1 or closestDistance > 3.0 then
                                    QBCore.Functions.Notify("No One Nearby", "error")
                                else
                                    menu2.close()
                                    QBCore.Functions.Notify(amount ..'$ The Invoice of Its Value Has Been Sent To The Person!')
                                    TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), PlayerData.job.name, PlayerData.charinfo.firstname.. " " ..PlayerData.charinfo.lastname, amount)
                                end
                            end
                        end, function(data2, menu2)
                            menu2.close()
                        end)

                    elseif data.current.value == "packet" then
                        TriggerServerEvent("tgiann-company:packet", QBCore.Key)
                    end
                end,function(data, menu)
                    menu.close()
                end)
            end
        end
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 500
        if coreLoaded and PlayerData.job and PlayerData.job.name == zone and PlayerData.job.boss then
            for name, bossCoords in pairs(bossCoord) do
                local distance = #(bossCoords - playerCoords)
                if distance < 2 then
                    time = 1
                    local text = ""
                    if distance < 1 then
                        text = "[E] "
                        if IsControlJustReleased(0, 38) then
                            QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'cutMenu', {
                                title    = ''.. PlayerData.job.label.. "",
                                align    = 'left',
                                elements = { 
                                    {label = "Boss Transactions", value = "boss"},
                                    {label = "Depo", value = "stash"}
                                }
                            }, function(data, menu)
                                menu.close()
                                if data.current.value == "boss" then
                                    TriggerEvent('esx_society:openBossMenu', name, function(data, menu)
                                        menu.close()
                                    end, { wash = false })
                                elseif data.current.value == "stash" then
                                    TriggerEvent("inventory:client:SetCurrentStash", "boss"..zone, QBCore.Key)
                                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss"..zone, {
                                        maxweight = 4000000,
                                        slots = 500,
                                    })
                                end
                            end,function(data, menu)
                                menu.close()
                            end)
                        end
                    end
                    QBCore.Functions.DrawText3D(bossCoords.x, bossCoords.y, bossCoords.z, text.."Boss Transactions")
                end
            end
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 500
        for index, masalarCoord in pairs(masalar) do
            local distance = #(masalarCoord - playerCoords)
            if distance < 1.5 and coreLoaded then
                time = 1
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("inventory:client:SetCurrentStash", "masa"..index, QBCore.Key)
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "masa"..index, {
                        maxweight = 40000,
                        slots = 10,
                    })
                end
                QBCore.Functions.DrawText3D(masalarCoord.x, masalarCoord.y, masalarCoord.z, "[E] Table")
            end
        end
        Citizen.Wait(time)
    end
end)