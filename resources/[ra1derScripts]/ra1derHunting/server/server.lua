QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateUseableItem("huntingbait", function(source, item)
    TriggerClientEvent("tgiann-hunting:use-item", source, "huntingbait")
end)

QBCore.Functions.CreateUseableItem("huntingknife", function(source, item)
    TriggerClientEvent("tgiann-hunting:use-item", source, "huntingknife")
end)




QBCore.Commands.Add('resethlicense', 'Help Text', {}, false, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.SetMetaData("huntinglicense", 0)
    TriggerClientEvent('QBCore:Notify', src, "31", "error")
end, "admin")

RegisterNetEvent("tgiann-hunting:giveItem")
AddEventHandler("tgiann-hunting:giveItem", function(key)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local deger = math.random(0, 100)
    local derirandom = math.random(2, 6)
    local xPlayer = QBCore.Functions.GetPlayer(src)
        local quality = math.random(1,5)
        local info = {
            type = "et",
            quality = quality
        }
    if deger >= 80 and deger < 100 then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['kalitelicesed'], "add", 1)
            TriggerClientEvent('QBCore:Notify', src, "You found a quality deer body.", "primary")
            xPlayer.Functions.AddItem("kalitelicesed", 1, nil, info)
            xPlayer.Functions.AddItem("geyikderisi", derirandom, nil, info)
        elseif deger >= 68 and deger < 80 then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['iyicesed'], "add", 1)
            TriggerClientEvent('QBCore:Notify', src, "You found a good quality deer body.", "primary")
            xPlayer.Functions.AddItem("iyicesed", 1, nil, info)
            xPlayer.Functions.AddItem("geyikderisi", derirandom, nil, info)
        elseif deger >= 46 and deger < 68 then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['kotucesed'], "add", 1)
            TriggerClientEvent('QBCore:Notify', src, "You found a bad deer corpse.", "primary")
            xPlayer.Functions.AddItem("kotucesed", 1, nil, info)
            xPlayer.Functions.AddItem("geyikderisi", derirandom)
        elseif deger >= 0 and deger < 45 then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['boktancesed'], "add", 1)
            TriggerClientEvent('QBCore:Notify', src, "You found a shitty venison corpse.", "primary")
            xPlayer.Functions.AddItem("boktancesed", 1, nil, info)
            xPlayer.Functions.AddItem("geyikderisi", derirandom, nil, info)
        end    
end)

local itemPrice = {
    ["geyiketi"] = 8,
    ["geyikderisi"] = 12
}

RegisterNetEvent("tgiann-hunting:sellItem")
AddEventHandler("tgiann-hunting:sellItem", function(key, item)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(src)
        local itemData = xPlayer.Functions.GetItemByName(item)
        local amount = itemData.amount
        if amount > 0 then
            if xPlayer.Functions.RemoveItem(itemData.name, amount, itemData.slot) then
                local quality = itemData.info.quality
                local price = itemPrice[item]*quality
                xPlayer.Functions.AddMoney('cash', itemPrice[item]*quality)
                TriggerClientEvent("QBCore:Notify", src, amount.." Tane ".. QBCore.Shared.Items[item].label .. "(Quality: "..quality..") In return you got  "..price.."$")
            end
        else
            TriggerClientEvent("QBCore:Notify", src, "On ".. QBCore.Shared.Items[item].label .. " None!", "error")
        end
    end
end)

RegisterNetEvent("tgiann-hunting:tradeItem")
AddEventHandler("tgiann-hunting:tradeItem", function(key, item, removeItemData)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(src)
        local itemData = xPlayer.Functions.GetItemByName(removeItemData)
        local amount = itemData.amount
        if amount > 0 then
            if xPlayer.Functions.RemoveItem(itemData.name, amount, itemData.slot) then
                local quality = itemData.info.quality
                if item == "ticaretk" then
                    xPlayer.Functions.AddItem(item, quality)
                    TriggerClientEvent("QBCore:Notify", src, amount.." Tane ".. QBCore.Shared.Items[removeItemData].label .. "(Quality: "..quality..") In return you got  "..quality.." Grain  "..QBCore.Shared.Items[item].label.."")
                else
                    xPlayer.Functions.AddItem(item, 2*quality)
                    TriggerClientEvent("QBCore:Notify", src, amount.." Tane ".. QBCore.Shared.Items[removeItemData].label .. "(Quality: "..quality..") In return you got  "..2*quality.." Grain  "..QBCore.Shared.Items[item].label.."")
                end
            end
        else
            TriggerClientEvent("QBCore:Notify", src, "On ".. QBCore.Shared.Items[removeItemData].label .. " None!", "error")
        end
    end
end)

RegisterNetEvent("tgiann-hunting:removeItem")
AddEventHandler("tgiann-hunting:removeItem", function(item)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.RemoveItem(item, 1)
end)