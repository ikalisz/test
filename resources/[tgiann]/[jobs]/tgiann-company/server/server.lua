QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('tgiann-company:giveCutItem')
AddEventHandler('tgiann-company:giveCutItem', function(key, addItem, removeItem, wAmount)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then
        local xPlayer = QBCore.Functions.GetPlayer(src)
        if xPlayer.Functions.GetItemByName(removeItem).amount > 0 then
            if xPlayer.Functions.AddItem(addItem, wAmount) then
                xPlayer.Functions.RemoveItem(removeItem, wAmount)
                TriggerClientEvent("QBCore:Notify", src, QBCore.Shared.Items[removeItem].label.." Cut/Chopped!", "success")
            else
                TriggerClientEvent("QBCore:Notify", src, "You Are Too Heavy", "error")
            end
        else
            TriggerClientEvent("QBCore:Notify", src, "On "..QBCore.Shared.Items[removeItem].label.." None!", "error")
        end
    end
end)

RegisterServerEvent('burgerYemek')
AddEventHandler('burgerYemek', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    -- local cash = Player.PlayerData.money.cash
    -- if cash >= 100 then
    if xPlayer.Functions.RemoveMoney('cash', "100") then
        info = {}
        info.type = "yemek"
        info.durubality = os.time() 
        xPlayer.Functions.AddItem("friesl", 1, nil, info)
        xPlayer.Functions.AddItem("burgerxl", 1, nil, info)
        xPlayer.Functions.AddItem("kola", 1, nil, info)
    else
        TriggerClientEvent("QBCore:Notify", src, "You don't have the money to buy the menu!", "error")
    end
end)


QBCore.Functions.CreateCallback("tgiann-company:checkItem", function(source, cb, items, wAmount)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local dataItemCount = tablelength(items)
    local itemCount = 0
    if wAmount == nil then wAmount = 1 end
    for item, amount in pairs(items) do
        if xPlayer.Functions.GetItemByName(item).amount >= amount*wAmount then
            itemCount = itemCount + 1
        else
            TriggerClientEvent("QBCore:Notify", src, "No "..amount*wAmount.." on "..QBCore.Shared.Items[item].label , "error")
        end
    end
    if itemCount == dataItemCount then 
        for item, amount in pairs(items) do
            xPlayer.Functions.RemoveItem(item, amount*wAmount)
        end
        cb(true) 
    else 
        cb(false) 
    end
end)

RegisterServerEvent('tgiann-company:giveItem')
AddEventHandler('tgiann-company:giveItem', function(key, addItem, removeItems, wAmount, drblty)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then
        if wAmount == nil then wAmount = 1 end
        local xPlayer = QBCore.Functions.GetPlayer(src)
        local info = {}
        if drblty then
            info.type = "yemek"
            info.durubality = os.time()
        end
        for i=1, wAmount do
            if xPlayer.Functions.AddItem(addItem, 1, nil, info) then
                TriggerClientEvent("QBCore:Notify", src, "1 Piece "..QBCore.Shared.Items[addItem].label.." Prepared!", "success")
            else
                TriggerClientEvent("QBCore:Notify", src, "The "..QBCore.Shared.Items[addItem].label.." You Prepared Because You Are Too Heavy Was Trash!", "error")
            end
        end
    end
end)

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

QBCore.Commands.Add("pack", "Pack Items in Top Five Slots", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    packet(source)
end)

RegisterServerEvent('tgiann-company:packet')
AddEventHandler('tgiann-company:packet', function(key)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then
        packet(src)
    end
end)

function packet(source)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if QBCore.Player.GetTotalWeight(xPlayer.PlayerData.items) < 85000 then
        local job = xPlayer.PlayerData.job.name
        local info = {
            type = "menu",
            items = {}
        }
        if job == "burger" or job == "chicken" or job == "taco" or job == "unicorx" or job == "hotdog" or job == "popsdiner" then
            local totalWeight = 0
            for i=1, 5 do
                local slotItem = xPlayer.Functions.GetItemBySlot(i)
                if slotItem then
                    local trueItem = false
                    for i=1, #itemList do
                        if slotItem.name == itemList[i] then
                            trueItem = true
                        end
                    end
                    if not trueItem then
                        TriggerClientEvent("QBCore:Notify", src, slotItem.label.." You Can't Pack Your Item!", "error")
                        return
                    end
                    table.insert(info.items, {
                        amount = slotItem.amount,
                        label = slotItem.label,
                        info = slotItem.info,
                        name = slotItem.name
                    })
                end
            end

            for i=1, 5 do
                local slotItem = xPlayer.Functions.GetItemBySlot(i)
                if slotItem then
                    xPlayer.Functions.RemoveItem(slotItem.name, slotItem.amount, slotItem.slot)
                end
            end

            local packet = "menubell"
            if job == "burger" then
                packet = "menushot"
            elseif job == "taco" then
                packet = "menutaco"
            elseif job == "hotdog" then
                packet = "menuhot"
            elseif job == "popsdiner" then
                packet = "menudiner"
            end
            xPlayer.Functions.AddItem(packet, 1, nil, info)
            TriggerClientEvent("QBCore:Notify", src, "Food/Drinks Packed", "success")
        else
            TriggerClientEvent("QBCore:Notify", src, "You Cannot Use This Command!", "error", 5000)
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "Superior Very Heavy!", "error", 5000)
    end
end

QBCore.Functions.CreateUseableItem("menubell", function(source, item)
    openPacket(source, item)
end)

QBCore.Functions.CreateUseableItem("menuhot", function(source, item)
    openPacket(source, item)
end)

QBCore.Functions.CreateUseableItem("menushot", function(source, item)
    openPacket(source, item)
end)

QBCore.Functions.CreateUseableItem("menutaco", function(source, item)
    openPacket(source, item)
end)

QBCore.Functions.CreateUseableItem("menudiner", function(source, item)
    openPacket(source, item)
end)

function openPacket(source, item)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local itemData = xPlayer.Functions.GetItemBySlot(item.slot)
    if itemData.info then
        for itemName, itemData in pairs(itemData.info.items) do
            xPlayer.Functions.AddItem(itemData.name, itemData.amount, nil, itemData.info)
        end
        xPlayer.Functions.RemoveItem(item.name, 1, item.slot)
        TriggerClientEvent("QBCore:Notify", src, "Package Opened", "success")
    else
        TriggerClientEvent("QBCore:Notify", src, "This Package Is Broken", "error")
    end
end